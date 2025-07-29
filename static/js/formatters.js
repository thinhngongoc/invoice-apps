// formatters.js

// NEW/MODIFIED: Định dạng số không phải tiền tệ (ví dụ: số lượng, phần trăm chiết khấu)
// Cho phép kiểm soát số chữ số thập phân
function formatNumber(num, minFractionDigits = 0, maxFractionDigits = 3) { // Thêm 2 tham số mới
    if (typeof num !== 'number' || isNaN(num) || num === null) {
        return '0'; // Hoặc giá trị mặc định bạn muốn cho dữ liệu không hợp lệ
    }

    // --- LOGIC SỬA ĐỔI ---
    // Nếu số là số nguyên, hãy đảm bảo rằng nó được định dạng mà không có phần thập phân
    // Bằng cách đặt minimumFractionDigits và maximumFractionDigits thành 0.
    // Sử dụng một ngưỡng nhỏ để xử lý các vấn đề về dấu phẩy động (ví dụ: 21.000000000000001)
    if (Math.abs(num - Math.round(num)) < 1e-9) {
        return new Intl.NumberFormat('en-US', {
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        }).format(num);
    } else {
        // Nếu không phải là số nguyên (có phần thập phân đáng kể),
        // sử dụng các tham số minFractionDigits và maxFractionDigits được truyền vào.
        return new Intl.NumberFormat('en-US', {
            minimumFractionDigits: minFractionDigits,
            maximumFractionDigits: maxFractionDigits
        }).format(num);
    }
    // --- KẾT THÚC LOGIC SỬA ĐỔI ---
}

// NEW/MODIFIED: Định dạng tiền tệ (làm tròn đến hàng đơn vị, có " đ")
// Dùng cho tất cả các trường tiền tệ (Tổng tiền hàng, Khách đã thanh toán, v.v.)
function formatCurrency(amount) {
    if (typeof amount !== 'number' || isNaN(amount) || amount === null) {
        amount = 0;
    }

    // Luôn làm tròn đến hàng đơn vị, không hiển thị phần thập phân.
    const formattedNumber = new Intl.NumberFormat('en-US', {
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(amount);

    return `${formattedNumber} đ`; // Thêm " đ" vào sau số đã định dạng
}

// Giữ nguyên: Hàm chuyển đổi chuỗi số định dạng Mỹ thành số float
// Ví dụ: "1,234,567.89" -> 1234567.89
// QUAN TRỌNG: Hàm này phải trả về số float để đảm bảo tính toán chính xác,
// không làm tròn hoặc cắt bỏ phần thập phân.
function parseFormattedNumber(str) {
    // Nếu không phải chuỗi, thử chuyển đổi trực tiếp về số (float).
    // Điều này xử lý trường hợp đầu vào đã là số.
    if (typeof str !== 'string') {
        const numResult = parseFloat(str);
        return isNaN(numResult) ? 0 : numResult; // Trả về 0 nếu không phải số hợp lệ
    }

    let cleanedStr = str.trim(); // Loại bỏ khoảng trắng thừa ở đầu và cuối

    // 1. Loại bỏ ký tự tiền tệ " đ" nếu có (để đảm bảo chỉ còn số)
    cleanedStr = cleanedStr.replace(/ đ/g, '');

    // 2. LOẠI BỎ TẤT CẢ DẤU PHẨY (,) vì chúng là dấu phân cách hàng nghìn trong định dạng quốc tế.
    // Ví dụ: "1,000" -> "1000", "1,234.56" -> "1234.56"
    cleanedStr = cleanedStr.replace(/,/g, '');

    // 3. Đảm bảo chỉ có một dấu chấm thập phân.
    // Nếu có nhiều dấu chấm (ví dụ: "1.2.3"), chỉ giữ lại dấu chấm đầu tiên.
    const parts = cleanedStr.split('.');
    if (parts.length > 2) {
        cleanedStr = parts[0] + '.' + parts.slice(1).join('');
    }

    // 4. Loại bỏ tất cả các ký tự không phải chữ số hoặc dấu chấm.
    // Điều này ngăn chặn các ký tự lạ hoặc chữ cái bị nhập vào.
    // Ví dụ: "$1.500" -> "1.500", "1.5abc" -> "1.5"
    cleanedStr = cleanedStr.replace(/[^0-9.]/g, '');

    // Cuối cùng, chuyển đổi chuỗi đã làm sạch thành số float.
    const result = parseFloat(cleanedStr);
    return isNaN(result) ? 0 : result; // Trả về 0 nếu không phải số hợp lệ
}
// Hàm chuyển đổi số thành chữ tiếng Việt (Giữ nguyên)
function convertNumberToVietnameseText(number) {
    if (number === 0) return "Không đồng";

    const units = [
        "không", "một", "hai", "ba", "bốn", "năm", "sáu", "bảy", "tám", "chín"
    ];
    const tens = ["", "mười", "hai mươi", "ba mươi", "bốn mươi", "năm mươi", "sáu mươi", "bảy mươi", "tám mươi", "chín mươi"];
    const levels = ["", "nghìn", "triệu", "tỷ", "nghìn tỷ", "triệu tỷ", "tỷ tỷ"]; // Mức độ (nghìn, triệu, tỷ)

    function readThreeDigits(num) {
        let str = "";
        const h = Math.floor(num / 100);
        const t = Math.floor((num % 100) / 10);
        const u = num % 10;

        if (h > 0) {
            str += units[h] + " trăm ";
        }

        if (t === 0 && u === 0) {
            // Nothing to do
        } else if (t === 0) {
            str += (h > 0 ? "linh " : "") + units[u];
        } else if (t === 1) {
            str += "mười ";
            if (u === 5) str += "lăm";
            else if (u > 0) str += units[u];
        } else {
            str += units[t] + " mươi ";
            if (u === 1) str += "mốt";
            else if (u === 5) str += "lăm";
            else if (u > 0) str += units[u];
        }
        return str.trim();
    }

    let result = "";
    let absNumber = Math.abs(number); // Lấy giá trị tuyệt đối để xử lý số âm sau
    let integerPart = Math.floor(absNumber); // Phần nguyên
    let decimalPart = Math.round((absNumber - integerPart) * 100); // Phần thập phân (lấy 2 chữ số)

    if (integerPart === 0 && decimalPart === 0) {
        return "Không đồng";
    }

    // Đọc phần nguyên
    let i = 0;
    while (integerPart > 0) {
        const threeDigits = integerPart % 1000;
        if (threeDigits !== 0) {
            let chunk = readThreeDigits(threeDigits) + " " + levels[i];
            result = chunk.trim() + " " + result;
        }
        integerPart = Math.floor(integerPart / 1000);
        i++;
    }

    result = result.trim();

    // Xử lý phần thập phân (nếu có)
    if (decimalPart > 0) {
        let decimalText = "";
        const t = Math.floor(decimalPart / 10);
        const u = decimalPart % 10;

        if (t === 0) { // Ví dụ: 0.05 (năm xu)
            decimalText = "linh " + units[u];
        } else if (t === 1) { // Ví dụ: 0.15 (mười lăm xu)
            decimalText = "mười ";
            if (u === 5) decimalText += "lăm";
            else if (u > 0) decimalText += units[u];
        } else { // Ví dụ: 0.25 (hai mươi lăm xu)
            decimalText = units[t] + " mươi ";
            if (u === 1) decimalText += "mốt";
            else if (u === 5) decimalText += "lăm";
            else if (u > 0) decimalText += units[u];
        }
        result += (result ? " phẩy " : "") + decimalText + " xu";
    } else {
        result += " đồng";
    }

    // Xử lý số âm
    if (number < 0) {
        result = "âm " + result;
    }

    // Xử lý các trường hợp đặc biệt (ví dụ: "một đồng không xu" -> "một đồng")
    result = result.replace(/một mươi/g, 'mười'); // Đảm bảo 'mười một' thay vì 'một mươi một'
    result = result.replace(/không trăm không/g, 'không trăm'); // Cleanup
    result = result.replace(/\s+/g, ' ').trim(); // Loại bỏ khoảng trắng thừa

    // Đảm bảo "lẻ" thay vì "linh" cho các trường hợp thích hợp
    result = result.replace(/linh (\w+)$/, 'lẻ $1'); // Ví dụ: "hai trăm linh năm" -> "hai trăm lẻ năm"

    // Chuẩn hóa một số trường hợp đặc biệt (thường gặp)
    result = result.replace(/mốt đồng$/, 'một đồng');
    result = result.replace(/mốt nghìn$/, 'một nghìn');
    result = result.replace(/mốt triệu$/, 'một triệu');
    result = result.replace(/mốt tỷ$/, 'một tỷ');
    result = result.replace(/lăm$/, 'lăm'); // Đảm bảo lăm không bị đổi thành năm cuối cùng
    result = result.replace(/năm mươi lăm/g, 'năm mươi lăm'); // Đảm bảo "năm mươi lăm"
    result = result.replace(/mươi năm/g, 'mươi lăm'); // 25, 35 ...

    // Xử lý trường hợp "linh không"
    result = result.replace(/linh không/, '');
    result = result.replace(/mươi không/g, 'mươi'); // 20, 30 ...

    // Chữ cái đầu tiên viết hoa
    return result.charAt(0).toUpperCase() + result.slice(1);
}

// Hàm in chi tiết hóa đơn (Giữ nguyên)
function printInvoiceDetails() {
    console.log("Debug: currentInvoiceDetails on print click:", currentInvoiceDetails);

    if (!currentInvoiceDetails || !currentInvoiceDetails.mahd) {
        Swal.fire('Lỗi', 'Không có hóa đơn được chọn để in. Vui lòng chọn hóa đơn trước.', 'error');
        console.error("Error: currentInvoiceDetails or mahd is missing for print.");
        return;
    }

    const mahd = currentInvoiceDetails.mahd;
    const printUrl = `/invoices/print-preview/${mahd}`;

    console.log("Debug: Generated printUrl:", printUrl);
    console.log("Debug: Attempting to open print window...");

    const printWindow = window.open(printUrl, '_blank');

    if (!printWindow || printWindow.closed || typeof printWindow.closed == 'undefined') {
        console.error("Debug: Failed to open print window. Likely blocked by pop-up blocker or browser settings.");
        Swal.fire({
            icon: 'warning',
            title: 'Cảnh báo!',
            text: 'Trình duyệt của bạn có thể đã chặn cửa sổ in. Vui lòng cho phép pop-up cho trang này và thử lại.',
            confirmButtonText: 'Đã hiểu'
        });
    } else {
        printWindow.onload = function () {
            console.log("Debug: Print window loaded.");
            printWindow.focus();
            printWindow.print();
        };
    }
}

// Hàm định dạng ngày tháng (Giữ nguyên)
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    try {
        let date = new Date(dateString);
        if (isNaN(date.getTime())) {
            date = new Date(dateString.replace(' ', 'T'));
        }

        if (!isNaN(date.getTime())) {
            const options = {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit',
                hour12: false
            };
            return date.toLocaleString('vi-VN', options);
        }
        return 'Không hợp lệ';
    } catch (e) {
        console.error("Lỗi định dạng ngày:", dateString, e);
        return 'Lỗi định dạng';
    }
}

// Hàm hiển thị modal chi tiết hóa đơn (Đã CẬP NHẬT CÁCH GỌI HÀM ĐỊNH DẠNG)
function showInvoiceDetailModal(invoiceData) {
    // 1. Điền thông tin chung của hóa đơn
    $('#modalInvoiceMahd').text(invoiceData.mahd);
    $('#detailMahd').text(invoiceData.mahd);
    $('#detailTenkh').text(invoiceData.customer ? invoiceData.customer.tenkh : 'Không có khách hàng');
    $('#detailNgaylap').text(formatDate(invoiceData.ngaylap));
    $('#detailNguoilap').text(invoiceData.nguoilap || 'N/A');
    $('#detailGhichu').text(invoiceData.ghichu || 'Không có');

    // Thêm hiển thị createdAt và updatedAt (nếu dữ liệu có)
    $('#detailCreatedAt').text(formatDate(invoiceData.created_at) || 'N/A');
    $('#detailUpdatedAt').text(formatDate(invoiceData.updated_at) || 'N/A');

    // 2. Điền các tổng tiền (SỬ DỤNG HÀM ĐỊNH DẠNG ĐÚNG)
    $('#detailCongtienhang').text(formatCurrency(invoiceData.congtienhang)); // Tiền tệ
    $('#detailCongchietkhau').text(formatCurrency(invoiceData.congchietkhau)); // Tiền tệ
    $('#detailKhhdathanhtoan').text(formatCurrency(invoiceData.khhdathanhtoan)); // Tiền tệ

    // 3. Xử lý "Còn nợ" và màu sắc
    const connoSpan = $('#detailConno');
    connoSpan.text(formatCurrency(invoiceData.conno)); // Tiền tệ
    if (invoiceData.conno > 0 && invoiceData.trangthai !== 'CANCELLED') {
        connoSpan.removeClass('text-success').addClass('text-danger');
    } else if (invoiceData.conno <= 0 && invoiceData.trangthai !== 'CANCELLED') {
        connoSpan.removeClass('text-danger').addClass('text-success');
    } else {
        connoSpan.removeClass('text-success text-danger');
    }

    // 4. Xử lý trạng thái và màu sắc (Giữ nguyên)
    let statusText = invoiceData.trangthai || 'N/A';
    let statusClass = '';
    switch (invoiceData.trangthai) {
        case 'PAID':
            statusClass = 'text-success fw-bold';
            break;
        case 'CANCELLED':
            statusClass = 'text-muted fst-italic';
            break;
        case 'UNPAID':
        default:
            statusClass = 'text-warning fw-bold';
            break;
    }
    $('#detailTrangthai').html(`<span class="${statusClass}">${statusText}</span>`);

    // 5. Hiển thị thông tin hủy hoặc thay thế nếu có (Giữ nguyên)
    if (invoiceData.trangthai === 'CANCELLED') {
        $('.cancel-info').show();
        $('#detailNgayHuy').text(formatDate(invoiceData.ngayhuy) || 'N/A');
        $('#detailNguoiHuy').text(invoiceData.nguoihuy || 'N/A');
    } else {
        $('.cancel-info').hide();
    }

    if (invoiceData.mahd_thaythe) {
        $('.replace-info').show();
        $('#detailMahdThayThe').text(invoiceData.mahd_thaythe);
    } else {
        $('.replace-info').hide();
    }

    // 6. Điền chi tiết sản phẩm vào bảng (SỬ DỤNG HÀM ĐỊNH DẠNG ĐÚNG)
    const detailsTableBody = $('#invoiceDetailsTableBody');
    detailsTableBody.empty();
    if (invoiceData.details && invoiceData.details.length > 0) {
        invoiceData.details.forEach((item, index) => {
            const row = `
                <tr>
                    <td>${index + 1}</td>
                    <td>${item.product ? item.product.tensp : 'N/A'}</td>
                    <td>${item.donvi || 'N/A'}</td>
                    <td>${formatNumber(item.sl || 0, 1, 3)}</td>
                    <td>${formatCurrency(item.dongia)}</td>
                    <td>${formatNumber(item.ck || 0, 0, 2)}%</td>
                    <td>${formatCurrency(item.thanhtien)}</td>
                </tr>
            `;
            detailsTableBody.append(row);
        });
    } else {
        detailsTableBody.append('<tr><td colspan="7" class="text-center">Không có chi tiết sản phẩm.</td></tr>');
    }

    // 7. Cập nhật data-attribute và trạng thái hiển thị của các nút hành động trong modal (Giữ nguyên)
    $('#editInvoiceBtn').data('mahd', invoiceData.mahd);
    $('#markPaidBtn').data('mahd', invoiceData.mahd);
    $('#cancelInvoiceModalBtn').data('mahd', invoiceData.mahd);
    $('#printInvoiceBtn').attr('onclick', `window.open('/invoices/print-preview/${invoiceData.mahd}', '_blank')`);

    if (invoiceData.trangthai === 'CANCELLED' || invoiceData.trangthai === 'PAID') {
        $('#editInvoiceBtn, #markPaidBtn, #cancelInvoiceModalBtn').hide();
    } else {
        $('#editInvoiceBtn, #markPaidBtn, #cancelInvoiceModalBtn').show();
    }

    // 8. Mở modal (Giữ nguyên)
    const invoiceDetailModalElement = document.getElementById('invoiceDetailModal');
    if (invoiceDetailModalElement) {
        const invoiceDetailModal = new bootstrap.Modal(invoiceDetailModalElement);
        invoiceDetailModal.show();
    } else {
        console.error("Modal with ID 'invoiceDetailModal' not found.");
    }
}