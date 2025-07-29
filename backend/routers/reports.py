from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlmodel import Session, select, func, or_
from typing import Optional, List
from datetime import date, timedelta
from pydantic import BaseModel, ConfigDict

from ..database import get_session
from ..models import Invoice, InvoiceDetail, Customer #, Product

router = APIRouter(prefix="/reports", tags=["Reports"])

# Pydantic models for report data
class CustomerReportDetail(BaseModel):
    makh: int
    tenkh: str
    diachi_sdt: Optional[str] = None
    ghichu: Optional[str] = None

    # Total accumulated outstanding debt for the customer from the Customer table (current overall debt)
    total_outstanding_debt_customer: float = 0.0

    # Amounts specifically from invoices within the *reporting period*
    total_goods_amount_in_period: float = 0.0
    total_discount_amount_in_period: float = 0.0
    total_invoice_amount_in_period: float = 0.0 # congtienhang - congchietkhau
    total_paid_amount_in_period: float = 0.0 # khdathanhtoan of invoices within the period
    total_debt_from_invoices_in_period: float = 0.0 # conno of invoices within the period

    model_config = ConfigDict(from_attributes=True)

class ReportSummary(BaseModel):
    total_revenue: float # Total invoice amount (goods - discount) in the period
    total_paid_amount: float # Total paid amount in the period
    total_customer_debt: float # Total outstanding debt from ALL customers (from Customer table)
    customer_details: List[CustomerReportDetail]

    model_config = ConfigDict(from_attributes=True)

# Endpoint để lấy tổng công nợ từ tất cả khách hàng (không thay đổi)
@router.get("/total-debt", response_model=dict, summary="Get total outstanding debt from all customers")
def get_total_debt(db: Session = Depends(get_session)):
    try:
        total_debt_sum = db.exec(select(func.sum(Customer.conno))).first()
        return {"total_debt": total_debt_sum if total_debt_sum is not None else 0.0}
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Error fetching total debt: {e}")

# Endpoint báo cáo tổng hợp theo thời gian và chi tiết theo khách hàng
@router.get("/summary", response_model=ReportSummary, summary="Get sales and debt report summary")
def get_report_summary(
    year: int = Query(..., description="Năm cần báo cáo"),
    month: Optional[int] = Query(None, ge=1, le=12, description="Tháng cần báo cáo (nếu có)"),
    quarter: Optional[int] = Query(None, ge=1, le=4, description="Quý cần báo cáo (nếu có)"),
    db: Session = Depends(get_session)
):
    try:
        # Validate that only one of month or quarter is provided
        if month is not None and quarter is not None:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Chỉ có thể cung cấp tháng hoặc quý, không phải cả hai."
            )

        # Build date filter conditions
        start_date = None
        end_date = None

        if month:
            # No need for (1 <= month <= 12) check as Pydantic Query parameter does this
            start_date = date(year, month, 1)
            if month == 12:
                end_date = date(year + 1, 1, 1) - timedelta(days=1)
            else:
                end_date = date(year, month + 1, 1) - timedelta(days=1)
        elif quarter:
            # No need for (1 <= quarter <= 4) check as Pydantic Query parameter does this
            start_month = (quarter - 1) * 3 + 1
            end_month = quarter * 3
            start_date = date(year, start_month, 1)
            if end_month == 12:
                end_date = date(year + 1, 1, 1) - timedelta(days=1)
            else:
                end_date = date(year, end_month + 1, 1) - timedelta(days=1)
        else: # Yearly report
            start_date = date(year, 1, 1)
            end_date = date(year, 12, 31)

        print(f"Generating report from {start_date} to {end_date}")

        # 1. Calculate overall summary for the reporting period
        overall_summary_query = select(
            func.sum(Invoice.congtienhang - Invoice.congchietkhau).label('total_revenue'),
            func.sum(Invoice.khhdathanhtoan).label('total_paid_amount'),
            func.sum(Invoice.conno).label('total_debt_from_period_invoices') # Total debt from invoices in this period
        ).where(
            Invoice.ngaylap >= start_date,
            Invoice.ngaylap <= end_date,
            Invoice.trangthai != "CANCELLED"
        )
        overall_summary_row = db.exec(overall_summary_query).first()

        total_revenue_period = overall_summary_row.total_revenue if overall_summary_row and overall_summary_row.total_revenue is not None else 0.0
        total_paid_amount_period = overall_summary_row.total_paid_amount if overall_summary_row and overall_summary_row.total_paid_amount is not None else 0.0

        # 2. Get total accumulated outstanding debt from ALL customers (from Customer table)
        # This reflects the current overall debt status, not just debt from the reporting period
        total_customer_debt_sum_from_customer_table = db.exec(select(func.sum(Customer.conno))).first()
        total_customer_debt_overall = total_customer_debt_sum_from_customer_table if total_customer_debt_sum_from_customer_table is not None else 0.0
        
        # 3. Optimize customer details query using GROUP BY
        # This fetches aggregated invoice data for all customers within the period in a single query
        customer_period_summary_query = select(
            Invoice.makh,
            func.sum(Invoice.congtienhang).label('total_goods_amount'),
            func.sum(Invoice.congchietkhau).label('total_discount_amount'),
            func.sum(Invoice.congtienhang - Invoice.congchietkhau).label('total_invoice_amount'),
            func.sum(Invoice.khhdathanhtoan).label('total_paid_amount'),
            func.sum(Invoice.conno).label('total_debt_from_invoices')
        ).where(
            Invoice.ngaylap >= start_date,
            Invoice.ngaylap <= end_date,
            Invoice.trangthai != "CANCELLED"
        ).group_by(Invoice.makh)

        period_summaries_by_customer = db.exec(customer_period_summary_query).all()

        # Create a dictionary for quick lookup of period summaries by customer ID
        period_summary_map = {s.makh: s for s in period_summaries_by_customer}

        # 4. Get all customers from the Customer table (once)
        all_customers = db.exec(select(Customer)).all()
        customer_details = []

        # Populate customer_details, including those with old debt but no new transactions
        for customer in all_customers:
            summary_in_period = period_summary_map.get(customer.makh)

            # Include customer if they had transactions in the period OR if they have current outstanding debt
            if summary_in_period or (customer.conno is not None and customer.conno > 0):
                customer_detail = CustomerReportDetail(
                    makh=customer.makh,
                    tenkh=customer.tenkh,
                    diachi_sdt=customer.diachi_sdt,
                    ghichu=customer.ghichu,
                    total_outstanding_debt_customer=customer.conno if customer.conno is not None else 0.0,
                    # Values from period summary, default to 0.0 if no transactions in period
                    total_goods_amount_in_period=summary_in_period.total_goods_amount if summary_in_period else 0.0,
                    total_discount_amount_in_period=summary_in_period.total_discount_amount if summary_in_period else 0.0,
                    total_invoice_amount_in_period=summary_in_period.total_invoice_amount if summary_in_period else 0.0,
                    total_paid_amount_in_period=summary_in_period.total_paid_amount if summary_in_period else 0.0,
                    total_debt_from_invoices_in_period=summary_in_period.total_debt_from_invoices if summary_in_period else 0.0
                )
                customer_details.append(customer_detail)
        
        # Optionally sort customer details
        customer_details.sort(key=lambda x: x.tenkh)

        return ReportSummary(
            total_revenue=total_revenue_period,
            total_paid_amount=total_paid_amount_period,
            total_customer_debt=total_customer_debt_overall, # Use overall debt from Customer table
            customer_details=customer_details
        )

    except HTTPException:
        raise
    except Exception as e:
        print(f"Error generating report: {e}") # Keep this for quick debugging
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Đã xảy ra lỗi khi tạo báo cáo: {e}")