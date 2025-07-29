--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-21 15:06:01

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 856 (class 1247 OID 16656)
-- Name: invoicestatus; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.invoicestatus AS ENUM (
    'UNPAID',
    'PAID',
    'CANCELLED'
);


ALTER TYPE public.invoicestatus OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 220 (class 1259 OID 16674)
-- Name: customer; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.customer (
    makh integer NOT NULL,
    tenkh character varying NOT NULL,
    diachi_sdt character varying,
    ghichu character varying,
    tongtienhang double precision NOT NULL,
    tongchietkhau double precision NOT NULL,
    tongthanhtoan double precision NOT NULL,
    khdathanhtoan double precision NOT NULL,
    conno double precision NOT NULL,
    tenkh_khongdau character varying
);


ALTER TABLE public.customer OWNER TO admin;

--
-- TOC entry 219 (class 1259 OID 16673)
-- Name: customer_makh_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.customer_makh_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_makh_seq OWNER TO admin;

--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 219
-- Name: customer_makh_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.customer_makh_seq OWNED BY public.customer.makh;


--
-- TOC entry 225 (class 1259 OID 16707)
-- Name: invoice; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.invoice (
    mahd character varying NOT NULL,
    makh integer NOT NULL,
    ngaylap date NOT NULL,
    khhdathanhtoan double precision NOT NULL,
    nguoilap character varying,
    ghichu character varying,
    congtienhang double precision NOT NULL,
    congchietkhau double precision NOT NULL,
    conno double precision NOT NULL,
    trangthai public.invoicestatus NOT NULL,
    ngay_huy timestamp without time zone,
    nguoi_huy character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.invoice OWNER TO admin;

--
-- TOC entry 227 (class 1259 OID 16722)
-- Name: invoicedetail; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.invoicedetail (
    id integer NOT NULL,
    mahd character varying NOT NULL,
    masp integer NOT NULL,
    donvi character varying,
    sl integer NOT NULL,
    dongia double precision NOT NULL,
    ck double precision NOT NULL,
    thanhtien double precision NOT NULL
);


ALTER TABLE public.invoicedetail OWNER TO admin;

--
-- TOC entry 226 (class 1259 OID 16721)
-- Name: invoicedetail_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.invoicedetail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoicedetail_id_seq OWNER TO admin;

--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 226
-- Name: invoicedetail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.invoicedetail_id_seq OWNED BY public.invoicedetail.id;


--
-- TOC entry 222 (class 1259 OID 16685)
-- Name: product; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.product (
    masp integer NOT NULL,
    tensp character varying NOT NULL,
    tensp_khongdau character varying NOT NULL,
    donvi character varying,
    dongia double precision NOT NULL,
    tonkho double precision NOT NULL,
    ghichu character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.product OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 16684)
-- Name: product_masp_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.product_masp_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_masp_seq OWNER TO admin;

--
-- TOC entry 4962 (class 0 OID 0)
-- Dependencies: 221
-- Name: product_masp_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.product_masp_seq OWNED BY public.product.masp;


--
-- TOC entry 224 (class 1259 OID 16695)
-- Name: productpricehistory; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.productpricehistory (
    id integer NOT NULL,
    product_masp integer NOT NULL,
    price double precision NOT NULL,
    effective_date timestamp without time zone NOT NULL,
    recorded_at timestamp without time zone NOT NULL
);


ALTER TABLE public.productpricehistory OWNER TO admin;

--
-- TOC entry 223 (class 1259 OID 16694)
-- Name: productpricehistory_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.productpricehistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productpricehistory_id_seq OWNER TO admin;

--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 223
-- Name: productpricehistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.productpricehistory_id_seq OWNED BY public.productpricehistory.id;


--
-- TOC entry 218 (class 1259 OID 16664)
-- Name: user; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying NOT NULL,
    hashed_password character varying NOT NULL,
    is_active boolean NOT NULL,
    is_admin boolean NOT NULL
);


ALTER TABLE public."user" OWNER TO admin;

--
-- TOC entry 217 (class 1259 OID 16663)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO admin;

--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- TOC entry 4770 (class 2604 OID 16742)
-- Name: customer makh; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customer ALTER COLUMN makh SET DEFAULT nextval('public.customer_makh_seq'::regclass);


--
-- TOC entry 4773 (class 2604 OID 16743)
-- Name: invoicedetail id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.invoicedetail ALTER COLUMN id SET DEFAULT nextval('public.invoicedetail_id_seq'::regclass);


--
-- TOC entry 4771 (class 2604 OID 16744)
-- Name: product masp; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product ALTER COLUMN masp SET DEFAULT nextval('public.product_masp_seq'::regclass);


--
-- TOC entry 4772 (class 2604 OID 16745)
-- Name: productpricehistory id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.productpricehistory ALTER COLUMN id SET DEFAULT nextval('public.productpricehistory_id_seq'::regclass);


--
-- TOC entry 4769 (class 2604 OID 16746)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- TOC entry 4947 (class 0 OID 16674)
-- Dependencies: 220
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.customer (makh, tenkh, diachi_sdt, ghichu, tongtienhang, tongchietkhau, tongthanhtoan, khdathanhtoan, conno, tenkh_khongdau) FROM stdin;
2	Nguyễn Văn A			4742200	0	0	0	4742200	nguyen van a
1	Ngô Ngọc Bảo Châu			7571896	0	0	0	7571896	ngo ngoc bao chau
4	Ngô Ngọc Bảo Châu1			0	0	0	0	0	ngo ngoc bao chau1
5	chau anh			0	0	0	0	0	chau anh
3	châu anh ngô			0	0	0	0	0	chau anh ngo
6	châu chấu			0	0	0	0	0	chau chau
\.


--
-- TOC entry 4952 (class 0 OID 16707)
-- Dependencies: 225
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.invoice (mahd, makh, ngaylap, khhdathanhtoan, nguoilap, ghichu, congtienhang, congchietkhau, conno, trangthai, ngay_huy, nguoi_huy, created_at, updated_at) FROM stdin;
HD-20250718-54DDBD20	1	2025-07-18	0	admin		680500	0	680500	CANCELLED	2025-07-18 17:42:39.936396	Admin	2025-07-18 16:51:26.187215	2025-07-18 17:42:39.936396
HD-20250719-06DC7E4C	1	2025-07-19	0	admin		6835360	0	6835360	CANCELLED	2025-07-21 13:56:11.881846	Admin	2025-07-19 14:48:43.324213	2025-07-21 13:56:11.881846
HD-20250721-EB935EBF	2	2025-07-21	0	admin		120000	0	120000	UNPAID	\N	\N	2025-07-21 13:56:20.605584	2025-07-21 13:56:20.605584
HD-20250721-60D0A340	1	2025-07-21	0	admin		300000	0	300000	UNPAID	\N	\N	2025-07-21 13:56:26.35786	2025-07-21 13:56:26.35786
HD-20250721-C3A4FA27	2	2025-07-21	0	admin		290000	0	290000	UNPAID	\N	\N	2025-07-21 13:56:32.979539	2025-07-21 13:56:32.979539
HD-20250721-B36F1737	1	2025-07-21	0	admin		4500000	0	4500000	UNPAID	\N	\N	2025-07-21 13:56:37.325344	2025-07-21 13:56:37.325344
HD-20250721-6C2D3787	2	2025-07-21	0	admin		1450000	0	1450000	UNPAID	\N	\N	2025-07-21 13:56:41.149813	2025-07-21 13:56:41.149813
HD-20250721-F70C97E8	1	2025-07-21	0	admin		650000	0	650000	UNPAID	\N	\N	2025-07-21 13:56:46.49345	2025-07-21 13:56:46.49345
HD-20250721-D7B2C8A5	2	2025-07-21	0	admin		810000	0	810000	UNPAID	\N	\N	2025-07-21 13:56:51.913402	2025-07-21 13:56:51.913402
HD-20250721-0E1D46B0	1	2025-07-21	0	admin		1850000	0	1850000	UNPAID	\N	\N	2025-07-21 13:56:57.834948	2025-07-21 13:56:57.834948
HD-20250721-14BB45DF	2	2025-07-21	0	admin		1600000	0	1600000	UNPAID	\N	\N	2025-07-21 13:58:53.373034	2025-07-21 13:58:53.373034
HD-20250721-FBD55427	1	2025-07-21	0	admin		46872	0	46872	UNPAID	\N	\N	2025-07-21 13:59:00.478968	2025-07-21 13:59:00.478968
HD-20250721-98846FBB	2	2025-07-21	0	admin		117200	0	117200	UNPAID	\N	\N	2025-07-21 13:59:29.914051	2025-07-21 13:59:29.914051
HD-20250721-20AB4D72	1	2025-07-21	0	admin		110000	0	110000	UNPAID	\N	\N	2025-07-21 14:02:10.257827	2025-07-21 14:02:10.257827
HD-20250721-CF821BB8	2	2025-07-21	0	admin		20000	0	20000	UNPAID	\N	\N	2025-07-21 14:02:14.998966	2025-07-21 14:02:14.998966
HD-20250721-EF2FEF15	1	2025-07-21	0	admin		10000	0	10000	UNPAID	\N	\N	2025-07-21 14:02:31.909311	2025-07-21 14:02:31.909311
HD-20250721-AD8CE256	2	2025-07-21	0	admin		35000	0	35000	UNPAID	\N	\N	2025-07-21 14:02:47.440513	2025-07-21 14:02:47.440513
HD-20250721-9A66D330	1	2025-07-21	0	admin		75000	0	75000	UNPAID	\N	\N	2025-07-21 14:02:52.763462	2025-07-21 14:02:52.763462
HD-20250721-39917876	2	2025-07-21	0	admin		300000	0	300000	UNPAID	\N	\N	2025-07-21 14:12:38.78644	2025-07-21 14:12:38.78644
HD-20250721-EE9A9D62	1	2025-07-21	0	admin		30024	0	30024	UNPAID	\N	\N	2025-07-21 14:26:53.971263	2025-07-21 14:26:53.971263
\.


--
-- TOC entry 4954 (class 0 OID 16722)
-- Dependencies: 227
-- Data for Name: invoicedetail; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.invoicedetail (id, mahd, masp, donvi, sl, dongia, ck, thanhtien) FROM stdin;
10	HD-20250719-06DC7E4C	4	cái	10	1000	0	10000
11	HD-20250719-06DC7E4C	6	cái	10	1500	0	15000
12	HD-20250719-06DC7E4C	16	cái	10	240000	0	2400000
13	HD-20250719-06DC7E4C	1755	cái	15	257000	0	3855000
14	HD-20250719-06DC7E4C	634	cái	15	7000	0	105000
15	HD-20250719-06DC7E4C	2593	cái	15	30024	0	450360
16	HD-20250721-EB935EBF	11	cái	1	120000	0	120000
17	HD-20250721-60D0A340	12	cái	1	300000	0	300000
18	HD-20250721-C3A4FA27	27	cái	1	290000	0	290000
19	HD-20250721-B36F1737	37	cái	1	4500000	0	4500000
20	HD-20250721-6C2D3787	38	cái	1	1450000	0	1450000
21	HD-20250721-F70C97E8	39	cái	1	650000	0	650000
22	HD-20250721-D7B2C8A5	40	cái	1	810000	0	810000
23	HD-20250721-0E1D46B0	45	cái	1	1850000	0	1850000
24	HD-20250721-14BB45DF	1	cái	1	1600000	0	1600000
25	HD-20250721-FBD55427	47	cái	1	46872	0	46872
26	HD-20250721-98846FBB	2091	cái	1	117200	0	117200
27	HD-20250721-20AB4D72	49	cái	1	110000	0	110000
28	HD-20250721-CF821BB8	50	cái	1	20000	0	20000
29	HD-20250721-EF2FEF15	56	cái	1	10000	0	10000
30	HD-20250721-AD8CE256	58	hộp	1	35000	0	35000
31	HD-20250721-9A66D330	65	cái	1	75000	0	75000
32	HD-20250721-39917876	12	cái	1	300000	0	300000
33	HD-20250721-EE9A9D62	2593	cái	1	30024	0	30024
\.


--
-- TOC entry 4949 (class 0 OID 16685)
-- Dependencies: 222
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.product (masp, tensp, tensp_khongdau, donvi, dongia, tonkho, ghichu, created_at, updated_at) FROM stdin;
2	Akuza K1 Pro - 13Mm	akuza k1 pro - 13mm	cái	1850000	0	\N	2025-07-18 16:43:43.524619	2025-07-18 16:43:43.524619
7	Áo Mưa	ao mua	cái	10000	0	\N	2025-07-18 16:43:43.555147	2025-07-18 16:43:43.555147
8	Áo Phản Quang	ao phan quang	cái	25000	0	\N	2025-07-18 16:43:43.558146	2025-07-18 16:43:43.558146
10	Asia Dèn 90/7W	asia den 90/7w	cái	110000	0	\N	2025-07-18 16:43:43.565147	2025-07-18 16:43:43.565147
13	Asia Đèn Dl 5W	asia den dl 5w	cái	100000	0	\N	2025-07-18 16:43:43.575176	2025-07-18 16:43:43.575176
14	Asia Đèn Hai Đầu	asia den hai dau	cái	310000	0	\N	2025-07-18 16:43:43.579168	2025-07-18 16:43:43.579168
15	Asia Đèn Hắt 4 Tia	asia den hat 4 tia	cái	150000	0	\N	2025-07-18 16:43:43.583721	2025-07-18 16:43:43.583721
17	Asia Đèn Ống Bơ 10W 3 Màu - Obld10V Dm	asia den ong bo 10w 3 mau - obld10v dm	cái	340000	0	\N	2025-07-18 16:43:43.59078	2025-07-18 16:43:43.59078
18	Asia Đèn Ống Bơ 10W-Obld10V	asia den ong bo 10w-obld10v	cái	280000	0	\N	2025-07-18 16:43:43.594787	2025-07-18 16:43:43.594787
19	Asia Đèn Ốp Nổi Vuông Obvd 10 W	asia den op noi vuong obvd 10 w	cái	340000	0	\N	2025-07-18 16:43:43.598784	2025-07-18 16:43:43.598784
20	Asia Đèn Ovan 20W	asia den ovan 20w	cái	165000	0	\N	2025-07-18 16:43:43.602302	2025-07-18 16:43:43.602302
21	Asia Đèn Panel 600X600R	asia den panel 600x600r	cái	250000	0	\N	2025-07-18 16:43:43.606294	2025-07-18 16:43:43.606294
22	Asia Dl Mrtr 7W Trắng	asia dl mrtr 7w trang	cái	84000	0	\N	2025-07-18 16:43:43.610291	2025-07-18 16:43:43.610291
23	Asia Đổi Nguồn 220/12V 250W	asia doi nguon 220/12v 250w	cái	220000	0	\N	2025-07-18 16:43:43.614288	2025-07-18 16:43:43.614288
24	Asia Led 50	asia led 50	cái	100000	0	\N	2025-07-18 16:43:43.618318	2025-07-18 16:43:43.618318
25	Asia Led Dán 5M	asia led dan 5m	dây	160000	0	\N	2025-07-18 16:43:43.62232	2025-07-18 16:43:43.62232
26	Asia Led Dây 50M	asia led day 50m	cuộn	1000000	0	\N	2025-07-18 16:43:43.626281	2025-07-18 16:43:43.626281
28	Asia Nguồn 20A 12V	asia nguon 20a 12v	cái	370000	0	\N	2025-07-18 16:43:43.634296	2025-07-18 16:43:43.634296
29	Asia Nguồn Ngoài Trời 33A	asia nguon ngoai troi 33a	cái	340000	0	\N	2025-07-18 16:43:43.638332	2025-07-18 16:43:43.638332
30	Asia Nguồn Tổ Ong 5A	asia nguon to ong 5a	cái	160000	0	\N	2025-07-18 16:43:43.643348	2025-07-18 16:43:43.643348
31	Asia Panel 200	asia panel 200	cái	300000	0	\N	2025-07-18 16:43:43.646333	2025-07-18 16:43:43.646333
32	Asia Pha 100W	asia pha 100w	cái	310000	0	\N	2025-07-18 16:43:43.650332	2025-07-18 16:43:43.650332
33	Asia Pha 200W	asia pha 200w	cái	1120000	0	\N	2025-07-18 16:43:43.653874	2025-07-18 16:43:43.653874
34	Asia Pha 200W Năng Lượng Mặt Trời	asia pha 200w nang luong mat troi	cái	1500000	0	\N	2025-07-18 16:43:43.657857	2025-07-18 16:43:43.657857
35	Asia Pha 300W Nlmt	asia pha 300w nlmt	cái	2100000	0	\N	2025-07-18 16:43:43.661868	2025-07-18 16:43:43.661868
36	Asia Pha 50W	asia pha 50w	cái	320000	0	\N	2025-07-18 16:43:43.66589	2025-07-18 16:43:43.66589
41	Át 1/50	at 1/50	cái	209000	0	\N	2025-07-18 16:43:43.685715	2025-07-18 16:43:43.685715
42	Át 2/40 Van Lôk	at 2/40 van lok	cái	105600	0	\N	2025-07-18 16:43:43.689721	2025-07-18 16:43:43.689721
43	Át 3/20 A Ls	at 3/20 a ls	cái	230000	0	\N	2025-07-18 16:43:43.692721	2025-07-18 16:43:43.692721
44	Át Khối 3/125 A Ls	at khoi 3/125 a ls	cái	0	0	\N	2025-07-18 16:43:43.695979	2025-07-18 16:43:43.695979
46	Bả Atm	ba atm	hộp	90000	0	\N	2025-07-18 16:43:43.704881	2025-07-18 16:43:43.704881
48	Bàn Bả Đen To	ban ba den to	cái	15000	0	\N	2025-07-18 16:43:43.712891	2025-07-18 16:43:43.712891
51	Bàn Giáp	ban giap	cái	13000	0	\N	2025-07-18 16:43:43.724939	2025-07-18 16:43:43.724939
52	Bản Lề 04 Ô Thoáng	ban le 04 o thoang	bộ	25000	0	\N	2025-07-18 16:43:43.729225	2025-07-18 16:43:43.729225
53	Bản Lề 100 Inox	ban le 100 inox	bộ	35000	0	\N	2025-07-18 16:43:43.732224	2025-07-18 16:43:43.732224
54	Bản Lề 130 Inox	ban le 130 inox	bộ	50000	0	\N	2025-07-18 16:43:43.737223	2025-07-18 16:43:43.737223
55	Bản Lề Bật Tủ Gỗ	ban le bat tu go	cái	15000	0	\N	2025-07-18 16:43:43.741325	2025-07-18 16:43:43.741325
57	Bản Lề Inox 5	ban le inox 5	bộ	50000	0	\N	2025-07-18 16:43:43.748332	2025-07-18 16:43:43.748332
59	Bản Lề Lá 50 Inox	ban le la 50 inox	cái	3000	0	\N	2025-07-18 16:43:43.754892	2025-07-18 16:43:43.754892
60	Bản Lề Lá 65	ban le la 65	cái	4000	0	\N	2025-07-18 16:43:43.758962	2025-07-18 16:43:43.758962
61	Bản Lề Ô Tô To	ban le o to to	cái	9000	0	\N	2025-07-18 16:43:43.762601	2025-07-18 16:43:43.762601
62	Bản Lề Sắt Tường 20	ban le sat tuong 20	bộ	40000	0	\N	2025-07-18 16:43:43.765616	2025-07-18 16:43:43.765616
63	Bản Lề Tân Hoa 16	ban le tan hoa 16	bộ	40000	0	\N	2025-07-18 16:43:43.768632	2025-07-18 16:43:43.768632
64	Bán Nguyệt 1.2M	ban nguyet 1.2m	cái	160000	0	\N	2025-07-18 16:43:43.772603	2025-07-18 16:43:43.772603
66	Bàn Ráp	ban rap	cái	15000	0	\N	2025-07-18 16:43:43.778472	2025-07-18 16:43:43.778472
67	Bàn Tời	ban toi	cái	670000	0	\N	2025-07-18 16:43:43.781473	2025-07-18 16:43:43.781473
68	Bàn Xoa Gỗ	ban xoa go	cái	18000	0	\N	2025-07-18 16:43:43.785001	2025-07-18 16:43:43.785001
69	Bàn Xoa Nhựa	ban xoa nhua	cái	13000	0	\N	2025-07-18 16:43:43.789232	2025-07-18 16:43:43.789232
70	Bàn Xoa Sắt To	ban xoa sat to	cái	20000	0	\N	2025-07-18 16:43:43.792483	2025-07-18 16:43:43.792483
11	Asia Đèn Cob D55	asia den cob d55	cái	120000	-1	\N	2025-07-18 16:43:43.568152	2025-07-21 13:56:20.607595
27	Asia Máng Tuýp Chống Ẩm 0.6 M Mdca 0.6-02	asia mang tuyp chong am 0.6 m mdca 0.6-02	cái	290000	-1	\N	2025-07-18 16:43:43.630301	2025-07-21 13:56:32.980539
37	Asia Quạt Trần 5 Cánh Qt 14 Dv	asia quat tran 5 canh qt 14 dv	cái	4500000	-1	\N	2025-07-18 16:43:43.669894	2025-07-21 13:56:37.32636
38	Asia Quạt Trần 5 Cánh Qt01	asia quat tran 5 canh qt01	cái	1450000	-1	\N	2025-07-18 16:43:43.673879	2025-07-21 13:56:41.151833
39	Asia Rọi Cây 20W	asia roi cay 20w	cái	650000	-1	\N	2025-07-18 16:43:43.677886	2025-07-21 13:56:46.494447
40	Asia Rọi Cây 30W Sáng Vàng 3000 K	asia roi cay 30w sang vang 3000 k	cái	810000	-1	\N	2025-07-18 16:43:43.681205	2025-07-21 13:56:51.9144
45	Át Khối 3P 4 Cực 150A	at khoi 3p 4 cuc 150a	cái	1850000	-1	\N	2025-07-18 16:43:43.700331	2025-07-21 13:56:57.84207
1	Akuza Ak 1102 Pro Max	akuza ak 1102 pro max	cái	1600000	-1	\N	2025-07-18 16:43:43.519619	2025-07-21 13:58:53.374188
47	Bạc 125/110	bac 125/110	cái	46872	-1	\N	2025-07-18 16:43:43.708899	2025-07-21 13:59:00.479965
49	Bàn Cào Răng 80 Cm Inoc	ban cao rang 80 cm inoc	cái	110000	-1	\N	2025-07-18 16:43:43.7179	2025-07-21 14:02:10.258827
50	Bản Chải Nhựa	ban chai nhua	cái	20000	-1	\N	2025-07-18 16:43:43.720906	2025-07-21 14:02:14.999965
56	Bản Lề Cối 16	ban le coi 16	cái	10000	-1	\N	2025-07-18 16:43:43.745353	2025-07-21 14:02:31.911823
58	Bản Lề Lá 100 Đủ ( Hộp = 2 Cái)	ban le la 100 du ( hop = 2 cai)	hộp	35000	-1	\N	2025-07-18 16:43:43.75235	2025-07-21 14:02:47.441522
65	Bán Nguyệt 30Cm	ban nguyet 30cm	cái	75000	-1	\N	2025-07-18 16:43:43.774969	2025-07-21 14:02:52.765465
12	Asia Đèn Địa Cầu	asia den dia cau	cái	300000	-2	\N	2025-07-18 16:43:43.571155	2025-07-21 14:12:38.788564
71	Băng Cản Nước 20 Cm	bang can nuoc 20 cm	m	105000	0	\N	2025-07-18 16:43:43.797585	2025-07-18 16:43:43.797585
72	Băng Cảnh Báo	bang canh bao	cuộn	25000	0	\N	2025-07-18 16:43:43.80056	2025-07-18 16:43:43.80056
73	Băng Chân	bang chan	cái	12000	0	\N	2025-07-18 16:43:43.804783	2025-07-18 16:43:43.804783
74	Băng Chống Thấm Th 10 Cm	bang chong tham th 10 cm	cuộn	90000	0	\N	2025-07-18 16:43:43.80878	2025-07-18 16:43:43.80878
75	Băng Chống Thấm Th 5 Cm	bang chong tham th 5 cm	cuộn	50000	0	\N	2025-07-18 16:43:43.811804	2025-07-18 16:43:43.811804
76	Băng Chương Nở	bang chuong no	m	50000	0	\N	2025-07-18 16:43:43.816805	2025-07-18 16:43:43.816805
77	Băng Dính 2 Mặt Bản 1F	bang dinh 2 mat ban 1f	cuộn	6000	0	\N	2025-07-18 16:43:43.820103	2025-07-18 16:43:43.820103
78	Băng Dính 2 Mặt Bản 5F	bang dinh 2 mat ban 5f	cuộn	12000	0	\N	2025-07-18 16:43:43.825113	2025-07-18 16:43:43.825113
79	Băng Dính 2 Mặt Trong	bang dinh 2 mat trong	cuộn	35000	0	\N	2025-07-18 16:43:43.828394	2025-07-18 16:43:43.828394
80	Băng Dính Bạc	bang dinh bac	cuộn	25000	0	\N	2025-07-18 16:43:43.831415	2025-07-18 16:43:43.831415
81	Băng Dính Điện	bang dinh dien	cuộn	7000	0	\N	2025-07-18 16:43:43.834233	2025-07-18 16:43:43.834233
82	Băng Dính Giấy 2Cm	bang dinh giay 2cm	cuộn	5000	0	\N	2025-07-18 16:43:43.838456	2025-07-18 16:43:43.838456
83	Băng Dính Giấy Bản 5F	bang dinh giay ban 5f	cuộn	10000	0	\N	2025-07-18 16:43:43.840609	2025-07-18 16:43:43.840609
84	Băng Dính Trong 1,6	bang dinh trong 1,6	cuộn	15000	0	\N	2025-07-18 16:43:43.843619	2025-07-18 16:43:43.843619
85	Băng Dính Trong 2,4 Kg	bang dinh trong 2,4 kg	cuộn	25000	0	\N	2025-07-18 16:43:43.846619	2025-07-18 16:43:43.846619
86	Băng Dính Trong 3 Kg	bang dinh trong 3 kg	cây	130000	0	\N	2025-07-18 16:43:43.849643	2025-07-18 16:43:43.849643
87	Băng Dính Trong 6 Kg	bang dinh trong 6 kg	cuộn	40000	0	\N	2025-07-18 16:43:43.852643	2025-07-18 16:43:43.852643
88	Băng Dính Trong Bé	bang dinh trong be	cuộn	15000	0	\N	2025-07-18 16:43:43.855158	2025-07-18 16:43:43.855158
89	Bảng Nhựa Số 3 (21X13)	bang nhua so 3 (21x13)	cái	10000	0	\N	2025-07-18 16:43:43.858158	2025-07-18 16:43:43.858158
90	Băng Tan	bang tan	thùng	440000	0	\N	2025-07-18 16:43:43.861159	2025-07-18 16:43:43.861159
91	Băng Thạch Cao	bang thach cao	cuộn	30000	0	\N	2025-07-18 16:43:43.864156	2025-07-18 16:43:43.864156
92	Băng Trương Nở	bang truong no	m	50000	0	\N	2025-07-18 16:43:43.867063	2025-07-18 16:43:43.867063
93	Bánh 700 Khóa	banh 700 khoa	cái	35000	0	\N	2025-07-18 16:43:43.870617	2025-07-18 16:43:43.870617
94	Bánh 700 Quay	banh 700 quay	cái	35000	0	\N	2025-07-18 16:43:43.874728	2025-07-18 16:43:43.874728
95	Bánh Xe 125 Khoá	banh xe 125 khoa	cái	60000	0	\N	2025-07-18 16:43:43.878212	2025-07-18 16:43:43.878212
96	Bánh Xe 125 Quay	banh xe 125 quay	cái	55000	0	\N	2025-07-18 16:43:43.880931	2025-07-18 16:43:43.880931
97	Bánh Xe 150 Đứng	banh xe 150 dung	cái	86000	0	\N	2025-07-18 16:43:43.884167	2025-07-18 16:43:43.884167
98	Bánh Xe 700	banh xe 700	cái	35000	0	\N	2025-07-18 16:43:43.887183	2025-07-18 16:43:43.887183
99	Bánh Xe Cao Su 150 Quay	banh xe cao su 150 quay	cái	90000	0	\N	2025-07-18 16:43:43.889244	2025-07-18 16:43:43.889244
100	Bánh Xe Đen Phi 4	banh xe den phi 4	cái	15000	0	\N	2025-07-18 16:43:43.893208	2025-07-18 16:43:43.893208
101	Bánh Xe Đỏ 100 Khoá	banh xe do 100 khoa	cái	35000	0	\N	2025-07-18 16:43:43.895207	2025-07-18 16:43:43.895207
102	Bánh Xe Đỏ 100 Quay	banh xe do 100 quay	cái	30000	0	\N	2025-07-18 16:43:43.898244	2025-07-18 16:43:43.898244
103	Bánh Xe Đỏ 130	banh xe do 130	cái	145000	0	\N	2025-07-18 16:43:43.901206	2025-07-18 16:43:43.901206
104	Bánh Xe Đỏ Đẩy	banh xe do day	cái	95000	0	\N	2025-07-18 16:43:43.904762	2025-07-18 16:43:43.904762
105	Bánh Xe Gvas	banh xe gvas	bộ	220000	0	\N	2025-07-18 16:43:43.90726	2025-07-18 16:43:43.90726
106	Bạt Cam	bat cam	m	8000	0	\N	2025-07-18 16:43:43.911303	2025-07-18 16:43:43.911303
107	Bạt Kẻ	bat ke	m dài	9000	0	\N	2025-07-18 16:43:43.914278	2025-07-18 16:43:43.914278
108	Bát Mài Bê Tông 100	bat mai be tong 100	cái	60000	0	\N	2025-07-18 16:43:43.916278	2025-07-18 16:43:43.916278
109	Bật Mực Cmart	bat muc cmart	cái	85000	0	\N	2025-07-18 16:43:43.920654	2025-07-18 16:43:43.920654
110	Bát Sen Tăng Áp	bat sen tang ap	cái	50000	0	\N	2025-07-18 16:43:43.923262	2025-07-18 16:43:43.923262
111	Bát Sen Tăng Áp Vuông	bat sen tang ap vuong	cái	60000	0	\N	2025-07-18 16:43:43.925284	2025-07-18 16:43:43.925284
112	Bạt Xanh Đỏ	bat xanh do	mét vuông	8000	0	\N	2025-07-18 16:43:43.928688	2025-07-18 16:43:43.928688
113	Bay Răng Cưa	bay rang cua	cái	18000	0	\N	2025-07-18 16:43:43.931918	2025-07-18 16:43:43.931918
114	Bay Thường	bay thuong	cái	10000	0	\N	2025-07-18 16:43:43.934308	2025-07-18 16:43:43.934308
115	Bay Tốt	bay tot	cái	16000	0	\N	2025-07-18 16:43:43.937331	2025-07-18 16:43:43.937331
116	Bép Cắt Kapusi Số 2	bep cat kapusi so 2	cái	20000	0	\N	2025-07-18 16:43:43.940327	2025-07-18 16:43:43.940327
117	Bép Cắt Oxi Số 3	bep cat oxi so 3	cái	18000	0	\N	2025-07-18 16:43:43.942485	2025-07-18 16:43:43.942485
118	Bép Hàn 1	bep han 1	cái	15000	0	\N	2025-07-18 16:43:43.946851	2025-07-18 16:43:43.946851
119	Bép Hàn 3	bep han 3	cái	15000	0	\N	2025-07-18 16:43:43.950838	2025-07-18 16:43:43.950838
120	Bếp Từ Canzy 588 Plus	bep tu canzy 588 plus	cái	4400000	0	\N	2025-07-18 16:43:43.953856	2025-07-18 16:43:43.953856
121	Bếp Từ Fandi 829	bep tu fandi 829	cái	5400000	0	\N	2025-07-18 16:43:43.956408	2025-07-18 16:43:43.956408
122	Bếp Từ Kitin	bep tu kitin	cái	5500000	0	\N	2025-07-18 16:43:43.960424	2025-07-18 16:43:43.960424
123	Bếp Từ Latino 828 Pro	bep tu latino 828 pro	cái	3800000	0	\N	2025-07-18 16:43:43.963424	2025-07-18 16:43:43.963424
124	Bệt 959 Linax	bet 959 linax	cái	4900000	0	\N	2025-07-18 16:43:43.966391	2025-07-18 16:43:43.966391
125	Bệt 969	bet 969	cái	3580000	0	\N	2025-07-18 16:43:43.969438	2025-07-18 16:43:43.969438
126	Bệt 989 Linax	bet 989 linax	bộ	4600000	0	\N	2025-07-18 16:43:43.972453	2025-07-18 16:43:43.972453
127	Bệt Ac 514 Linax	bet ac 514 linax	bộ	2700000	0	\N	2025-07-18 16:43:43.975439	2025-07-18 16:43:43.975439
128	Bệt Ac 832	bet ac 832	bộ	5200000	0	\N	2025-07-18 16:43:43.978439	2025-07-18 16:43:43.978439
129	Bệt Ac 902 Linax	bet ac 902 linax	cái	6550000	0	\N	2025-07-18 16:43:43.981456	2025-07-18 16:43:43.981456
130	Bệt C514 Linax	bet c514 linax	bộ	2500000	0	\N	2025-07-18 16:43:43.984005	2025-07-18 16:43:43.984005
131	Bệt Laiky	bet laiky	cái	950000	0	\N	2025-07-18 16:43:43.986017	2025-07-18 16:43:43.986017
132	Bệt Liền Khối Fv 82	bet lien khoi fv 82	cái	1800000	0	\N	2025-07-18 16:43:43.988021	2025-07-18 16:43:43.988021
133	Bệt Linax 108	bet linax 108	bộ	1900000	0	\N	2025-07-18 16:43:43.990053	2025-07-18 16:43:43.990053
134	Bệt Linax 602	bet linax 602	cái	2930000	0	\N	2025-07-18 16:43:43.993053	2025-07-18 16:43:43.993053
135	Bệt Linax Ac 898	bet linax ac 898	cái	4650000	0	\N	2025-07-18 16:43:43.996054	2025-07-18 16:43:43.996054
136	Bệt Rẻ Thái Bình Nhấn	bet re thai binh nhan	cái	650000	0	\N	2025-07-18 16:43:43.998039	2025-07-18 16:43:43.998039
137	Bệt Selta St 117	bet selta st 117	cái	2450000	0	\N	2025-07-18 16:43:44.000052	2025-07-18 16:43:44.000052
138	Bệt Selta St 198	bet selta st 198	cái	2250000	0	\N	2025-07-18 16:43:44.003053	2025-07-18 16:43:44.003053
139	Bệt Sen Ta	bet sen ta	cái	2300000	0	\N	2025-07-18 16:43:44.006618	2025-07-18 16:43:44.006618
140	Bệt Senta St 169	bet senta st 169	bộ	2250000	0	\N	2025-07-18 16:43:44.008618	2025-07-18 16:43:44.008618
141	Bệt Senta St 69	bet senta st 69	bộ	2250000	0	\N	2025-07-18 16:43:44.010617	2025-07-18 16:43:44.010617
142	Bệt Senta St 94	bet senta st 94	cái	2350000	0	\N	2025-07-18 16:43:44.013602	2025-07-18 16:43:44.013602
143	Bệt St 94 Sen Ta	bet st 94 sen ta	cái	2300000	0	\N	2025-07-18 16:43:44.016602	2025-07-18 16:43:44.016602
144	Bệt V62 Viglacera	bet v62 viglacera	bộ	3700000	0	\N	2025-07-18 16:43:44.018603	2025-07-18 16:43:44.018603
145	Bệt Vigacera Vi88	bet vigacera vi88	bộ	1350000	0	\N	2025-07-18 16:43:44.020618	2025-07-18 16:43:44.020618
146	Biến Áp Tn 1000 Va Lioa	bien ap tn 1000 va lioa	cái	580000	0	\N	2025-07-18 16:43:44.022617	2025-07-18 16:43:44.022617
147	Biến Áp Tn 200 Va	bien ap tn 200 va	cái	320000	0	\N	2025-07-18 16:43:44.025617	2025-07-18 16:43:44.025617
148	Biên Áp Tn 2000 Va	bien ap tn 2000 va	cái	780000	0	\N	2025-07-18 16:43:44.028602	2025-07-18 16:43:44.028602
149	Biến Áp Tn 400 Va	bien ap tn 400 va	cái	430000	0	\N	2025-07-18 16:43:44.031602	2025-07-18 16:43:44.031602
150	Biến Áp Tn 600 Va Lioa	bien ap tn 600 va lioa	cái	381000	0	\N	2025-07-18 16:43:44.033617	2025-07-18 16:43:44.033617
151	Bình 15 Lít Ariton Ngang Rs	binh 15 lit ariton ngang rs	cái	2250000	0	\N	2025-07-18 16:43:44.036618	2025-07-18 16:43:44.036618
152	Bình 15 Lít Ferroli	binh 15 lit ferroli	cái	1950000	0	\N	2025-07-18 16:43:44.03963	2025-07-18 16:43:44.03963
153	Bình 15 Lít Ngang Rosi	binh 15 lit ngang rosi	cái	1550000	0	\N	2025-07-18 16:43:44.042615	2025-07-18 16:43:44.042615
154	Bình 15 Lít Vuông Rosi	binh 15 lit vuong rosi	cái	1300000	0	\N	2025-07-18 16:43:44.045615	2025-07-18 16:43:44.045615
155	Bình 15 Nóng Lạnh	binh 15 nong lanh	cái	1230000	0	\N	2025-07-18 16:43:44.048631	2025-07-18 16:43:44.048631
156	Bình 1500 Lít Sơn Hà	binh 1500 lit son ha	cái	5000000	0	\N	2025-07-18 16:43:44.051631	2025-07-18 16:43:44.051631
157	Binh 2 Lít	binh 2 lit	cái	45000	0	\N	2025-07-18 16:43:44.052616	2025-07-18 16:43:44.052616
158	Bình 20 Lít Feroli Qqae	binh 20 lit feroli qqae	cái	2250000	0	\N	2025-07-18 16:43:44.056503	2025-07-18 16:43:44.056503
159	Bình 20 Lít Feroli Qqme	binh 20 lit feroli qqme	cái	2020000	0	\N	2025-07-18 16:43:44.058787	2025-07-18 16:43:44.058787
160	Bình 2500 Lít	binh 2500 lit	cái	7000000	0	\N	2025-07-18 16:43:44.061882	2025-07-18 16:43:44.061882
161	Bình Áp Máy Lọc Nước	binh ap may loc nuoc	cái	260000	0	\N	2025-07-18 16:43:44.065856	2025-07-18 16:43:44.065856
162	Bình Ariton Ngang 30 Lít Rs	binh ariton ngang 30 lit rs	cái	3100000	0	\N	2025-07-18 16:43:44.067532	2025-07-18 16:43:44.067532
163	Bình Cứu Hỏa	binh cuu hoa	bình	185000	0	\N	2025-07-18 16:43:44.069539	2025-07-18 16:43:44.069539
164	Bình Ga Mini	binh ga mini	lon	20000	0	\N	2025-07-18 16:43:44.072417	2025-07-18 16:43:44.072417
165	Bình Inox 2000L Ngang	binh inox 2000l ngang	cái	6000000	0	\N	2025-07-18 16:43:44.075423	2025-07-18 16:43:44.075423
166	Bình Minh Pvc Keo 200 Gam	binh minh pvc keo 200 gam	lọ	50000	0	\N	2025-07-18 16:43:44.078681	2025-07-18 16:43:44.078681
167	Bình Minh Pvc Keo 500 Gam	binh minh pvc keo 500 gam	lọ	80000	0	\N	2025-07-18 16:43:44.08068	2025-07-18 16:43:44.08068
168	Bình Nằm 1000 Lít Sơn Hà	binh nam 1000 lit son ha	cái	2800000	0	\N	2025-07-18 16:43:44.0842	2025-07-18 16:43:44.0842
169	Binh Ngang 20 R	binh ngang 20 r	cái	2600000	0	\N	2025-07-18 16:43:44.086222	2025-07-18 16:43:44.086222
170	Bình Nóng Lạnh 10L Pisenra	binh nong lanh 10l pisenra	cái	1480000	0	\N	2025-07-18 16:43:44.089238	2025-07-18 16:43:44.089238
171	Binh Nóng Lạnh 15 Lít Rosi	binh nong lanh 15 lit rosi	cái	1250000	0	\N	2025-07-18 16:43:44.092356	2025-07-18 16:43:44.092356
172	Bình Nóng Lạnh 15 Lít Vuông Blu Ariton	binh nong lanh 15 lit vuong blu ariton	cái	2050000	0	\N	2025-07-18 16:43:44.0954	2025-07-18 16:43:44.0954
173	Bình Nóng Lạnh 15 Lít Vuông Sơn Hà	binh nong lanh 15 lit vuong son ha	cái	1300000	0	\N	2025-07-18 16:43:44.097401	2025-07-18 16:43:44.097401
174	Bình Nóng Lạnh 20 L Sơn Hà	binh nong lanh 20 l son ha	cái	1530000	0	\N	2025-07-18 16:43:44.099414	2025-07-18 16:43:44.099414
175	Bình Nóng Lạnh 20 Lít Ariton Vitary	binh nong lanh 20 lit ariton vitary	cái	1850000	0	\N	2025-07-18 16:43:44.102401	2025-07-18 16:43:44.102401
176	Bình Nóng Lạnh 20 Lít Feroli	binh nong lanh 20 lit feroli	cái	2350000	0	\N	2025-07-18 16:43:44.104936	2025-07-18 16:43:44.104936
177	Bình Nóng Lạnh 20 Lít Ngang Rosi	binh nong lanh 20 lit ngang rosi	cái	1650000	0	\N	2025-07-18 16:43:44.108115	2025-07-18 16:43:44.108115
178	Bình Nóng Lạnh 20 Lít Vuông Rosi	binh nong lanh 20 lit vuong rosi	cái	1450000	0	\N	2025-07-18 16:43:44.111132	2025-07-18 16:43:44.111132
179	Bình Nóng Lạnh 20 Ngang Rosi	binh nong lanh 20 ngang rosi	cái	1650000	0	\N	2025-07-18 16:43:44.11434	2025-07-18 16:43:44.11434
180	Bình Nóng Lạnh 20 Rs Ariton	binh nong lanh 20 rs ariton	cái	2850000	0	\N	2025-07-18 16:43:44.117336	2025-07-18 16:43:44.117336
181	Bình Nóng Lạnh 30 Lít Feroli	binh nong lanh 30 lit feroli	cái	2550000	0	\N	2025-07-18 16:43:44.119346	2025-07-18 16:43:44.119346
182	Bình Nóng Lạnh 30 Lít Picenra	binh nong lanh 30 lit picenra	cái	2350000	0	\N	2025-07-18 16:43:44.12136	2025-07-18 16:43:44.12136
183	Bình Nóng Lạnh 30 Lit Vuông R Ariton	binh nong lanh 30 lit vuong r ariton	cái	2850000	0	\N	2025-07-18 16:43:44.124362	2025-07-18 16:43:44.124362
184	Bình Nóng Lạnh 30 Vuông Rs Ariton	binh nong lanh 30 vuong rs ariton	cái	3200000	0	\N	2025-07-18 16:43:44.12636	2025-07-18 16:43:44.12636
185	Bình Nóng Lạnh 30L Rossi	binh nong lanh 30l rossi	cái	1750000	0	\N	2025-07-18 16:43:44.129845	2025-07-18 16:43:44.129845
186	Bình Nóng Lạnh 6 Lít Ariton	binh nong lanh 6 lit ariton	cái	1750000	0	\N	2025-07-18 16:43:44.13288	2025-07-18 16:43:44.13288
187	Bình Nóng Lanh 6L Feroly	binh nong lanh 6l feroly	cái	1450000	0	\N	2025-07-18 16:43:44.134867	2025-07-18 16:43:44.134867
188	Bình Nóng Lạnh Ariton 20L R	binh nong lanh ariton 20l r	cái	2620000	0	\N	2025-07-18 16:43:44.137639	2025-07-18 16:43:44.137639
189	Bình Nóng Lạnh Ariton 30 L Ngang R	binh nong lanh ariton 30 l ngang r	cái	2980000	0	\N	2025-07-18 16:43:44.141965	2025-07-18 16:43:44.141965
190	Bình Nóng Lạnh Ariton 50 Lít	binh nong lanh ariton 50 lit	cái	3600000	0	\N	2025-07-18 16:43:44.145239	2025-07-18 16:43:44.145239
191	Bình Nóng Lạnh Chieko 15 Vuông	binh nong lanh chieko 15 vuong	cái	1150000	0	\N	2025-07-18 16:43:44.148288	2025-07-18 16:43:44.148288
192	Bình Nóng Lạnh Chieko 20 Ngang	binh nong lanh chieko 20 ngang	cái	1400000	0	\N	2025-07-18 16:43:44.151274	2025-07-18 16:43:44.151274
193	Bình Nóng Lạnh Chieko 20 Vuông	binh nong lanh chieko 20 vuong	cái	1200000	0	\N	2025-07-18 16:43:44.153287	2025-07-18 16:43:44.153287
194	Bình Nước 2000 Lít	binh nuoc 2000 lit	cái	0	0	\N	2025-07-18 16:43:44.154819	2025-07-18 16:43:44.154819
195	Bình Nóng Lạnh Sl3 15 Ngang Ariton	binh nong lanh sl3 15 ngang ariton	cái	2250000	0	\N	2025-07-18 16:43:44.157868	2025-07-18 16:43:44.157868
196	Bình Nóng Lạnh Slim 3 Rs 20 Ngang Ariton	binh nong lanh slim 3 rs 20 ngang ariton	cái	2850000	0	\N	2025-07-18 16:43:44.159867	2025-07-18 16:43:44.159867
197	Bình Sơn Hà	binh son ha	cái	2220000	0	\N	2025-07-18 16:43:44.162854	2025-07-18 16:43:44.162854
198	Bình Tưới 2 Lít	binh tuoi 2 lit	cái	45000	0	\N	2025-07-18 16:43:44.165867	2025-07-18 16:43:44.165867
199	Bình Xịt Nước Rửa Bát	binh xit nuoc rua bat	cái	90000	0	\N	2025-07-18 16:43:44.168901	2025-07-18 16:43:44.168901
200	Bịt Ghen Cam 50/40	bit ghen cam 50/40	cái	15000	0	\N	2025-07-18 16:43:44.172915	2025-07-18 16:43:44.172915
201	Bịt Ren 15	bit ren 15	cái	1000	0	\N	2025-07-18 16:43:44.17714	2025-07-18 16:43:44.17714
202	Bịt Ren 20	bit ren 20	cái	1000	0	\N	2025-07-18 16:43:44.177915	2025-07-18 16:43:44.177915
203	Bịt Ren Trong 15 Inox	bit ren trong 15 inox	cái	6000	0	\N	2025-07-18 16:43:44.181915	2025-07-18 16:43:44.181915
204	Bịt Ren Zoang	bit ren zoang	cái	2000	0	\N	2025-07-18 16:43:44.184456	2025-07-18 16:43:44.184456
205	Bịt Zoang 20	bit zoang 20	cái	3000	0	\N	2025-07-18 16:43:44.186457	2025-07-18 16:43:44.186457
206	Bộ 0.6 M11	bo 0.6 m11	bộ	115000	0	\N	2025-07-18 16:43:44.188471	2025-07-18 16:43:44.188471
207	Bộ Combo Sen Cây Scb 2190 X - 8 Món	bo combo sen cay scb 2190 x - 8 mon	bộ	4600000	0	\N	2025-07-18 16:43:44.191519	2025-07-18 16:43:44.191519
208	Bộ Phụ Kiện 6 Món Hico	bo phu kien 6 mon hico	bộ	700000	0	\N	2025-07-18 16:43:44.193518	2025-07-18 16:43:44.193518
209	Bộ Phụ Kiện Nhà Tắm Clin	bo phu kien nha tam clin	bộ	250000	0	\N	2025-07-18 16:43:44.196504	2025-07-18 16:43:44.196504
210	Bộ Phụ Kiện Sen Ta	bo phu kien sen ta	bộ	850000	0	\N	2025-07-18 16:43:44.198504	2025-07-18 16:43:44.198504
211	Bộ Ruột Bêt	bo ruot bet	cái	120000	0	\N	2025-07-18 16:43:44.201502	2025-07-18 16:43:44.201502
212	Bộ Tuýp 1.2 M M11	bo tuyp 1.2 m m11	bộ	155000	0	\N	2025-07-18 16:43:44.203504	2025-07-18 16:43:44.203504
213	Bộ Xi Phong Rửa Bát Inox	bo xi phong rua bat inox	bộ	280000	0	\N	2025-07-18 16:43:44.207107	2025-07-18 16:43:44.207107
214	Bơm Áp 120	bom ap 120	cái	850000	0	\N	2025-07-18 16:43:44.208107	2025-07-18 16:43:44.208107
215	Bơm Áp 24 V	bom ap 24 v	cái	900000	0	\N	2025-07-18 16:43:44.212093	2025-07-18 16:43:44.212093
216	Bơm Bạt 48	bom bat 48	m	18000	0	\N	2025-07-18 16:43:44.214093	2025-07-18 16:43:44.214093
217	Bơm Lợn 1.1 Kw Bảo Long	bom lon 1.1 kw bao long	cái	1650000	0	\N	2025-07-18 16:43:44.216107	2025-07-18 16:43:44.216107
218	Bơm Tay Cmart	bom tay cmart	cái	165000	0	\N	2025-07-18 16:43:44.219107	2025-07-18 16:43:44.219107
219	Bơm Thông Bồn Cầu	bom thong bon cau	cái	35000	0	\N	2025-07-18 16:43:44.221107	2025-07-18 16:43:44.221107
220	Bơm Xà Phòng	bom xa phong	bộ	90000	0	\N	2025-07-18 16:43:44.224092	2025-07-18 16:43:44.224092
221	Bồn Đứng 1200 Lít Tân Mỹ	bon dung 1200 lit tan my	cái	2900000	0	\N	2025-07-18 16:43:44.226107	2025-07-18 16:43:44.226107
222	Bồn Inox 1000 Lít	bon inox 1000 lit	cái	0	0	\N	2025-07-18 16:43:44.229093	2025-07-18 16:43:44.229093
223	Bồn Inox 1200 Lít Ngang Tm	bon inox 1200 lit ngang tm	cái	3250000	0	\N	2025-07-18 16:43:44.231101	2025-07-18 16:43:44.231101
224	Bồn Inox 1500 Lít Ngang Sơn Hà	bon inox 1500 lit ngang son ha	cái	4970000	0	\N	2025-07-18 16:43:44.235107	2025-07-18 16:43:44.235107
225	Bồn Inox 1500 Lít Ngang Tân Mỹ	bon inox 1500 lit ngang tan my	cái	4350000	0	\N	2025-07-18 16:43:44.238107	2025-07-18 16:43:44.238107
226	Bồn Inox 2000 Lít Ngang Sơn Hà	bon inox 2000 lit ngang son ha	cái	7300000	0	\N	2025-07-18 16:43:44.24114	2025-07-18 16:43:44.24114
227	Bồn Inox 500 Lít Đứng Tân Mỹ	bon inox 500 lit dung tan my	cái	1850000	0	\N	2025-07-18 16:43:44.24314	2025-07-18 16:43:44.24314
228	Bóng 1 W	bong 1 w	cái	15000	0	\N	2025-07-18 16:43:44.245154	2025-07-18 16:43:44.245154
229	Bóng 1,2 M Tt Rẻ	bong 1,2 m tt re	cái	28000	0	\N	2025-07-18 16:43:44.248154	2025-07-18 16:43:44.248154
230	Bóng 30 Rẻ	bong 30 re	cái	50000	0	\N	2025-07-18 16:43:44.251139	2025-07-18 16:43:44.251139
231	Bóng 36 W Điện Quang	bong 36 w dien quang	cái	35000	0	\N	2025-07-18 16:43:44.25314	2025-07-18 16:43:44.25314
232	Bóng 40 W R	bong 40 w r	cái	70000	0	\N	2025-07-18 16:43:44.255669	2025-07-18 16:43:44.255669
233	Bóng Ắc Quy 12 W	bong ac quy 12 w	cái	80000	0	\N	2025-07-18 16:43:44.257729	2025-07-18 16:43:44.257729
234	Bóng Ắc Quy 18 W	bong ac quy 18 w	cái	100000	0	\N	2025-07-18 16:43:44.260726	2025-07-18 16:43:44.260726
235	Bóng Búp 50 W Rẻ	bong bup 50 w re	cái	100000	0	\N	2025-07-18 16:43:44.263658	2025-07-18 16:43:44.263658
236	Bóng Đèn 65 W Rio	bong den 65 w rio	cái	100000	0	\N	2025-07-18 16:43:44.265667	2025-07-18 16:43:44.265667
237	Bóng Đèn Sưởi	bong den suoi	cái	60000	0	\N	2025-07-18 16:43:44.267667	2025-07-18 16:43:44.267667
238	Bóng Đu Đủ	bong du du	cái	25000	0	\N	2025-07-18 16:43:44.269674	2025-07-18 16:43:44.269674
239	Bóng Led 1 W	bong led 1 w	cái	15000	0	\N	2025-07-18 16:43:44.271675	2025-07-18 16:43:44.271675
240	Bóng Led 3 W Rẻ	bong led 3 w re	cái	8000	0	\N	2025-07-18 16:43:44.273779	2025-07-18 16:43:44.273779
241	Bóng Led 40 R	bong led 40 r	cái	60000	0	\N	2025-07-18 16:43:44.277068	2025-07-18 16:43:44.277068
242	Bóng Led 7 W Rẻ	bong led 7 w re	cái	8500	0	\N	2025-07-18 16:43:44.279056	2025-07-18 16:43:44.279056
243	Bóng Led E14 Hoa Thái	bong led e14 hoa thai	cái	25000	0	\N	2025-07-18 16:43:44.281072	2025-07-18 16:43:44.281072
244	Bóng Sợi Đốt 25 W	bong soi dot 25 w	cái	8000	0	\N	2025-07-18 16:43:44.28458	2025-07-18 16:43:44.28458
245	Bu Lông + Ecu + Long Đen 10	bu long + ecu + long den 10	cái	40000	0	\N	2025-07-18 16:43:44.28558	2025-07-18 16:43:44.28558
246	Bu Lông 10	bu long 10	kg	35000	0	\N	2025-07-18 16:43:44.288608	2025-07-18 16:43:44.288608
247	Bu Lông 4X2 Cm	bu long 4x2 cm	kg	50000	0	\N	2025-07-18 16:43:44.290666	2025-07-18 16:43:44.290666
248	Bu Lông M5	bu long m5	kg	50000	0	\N	2025-07-18 16:43:44.293634	2025-07-18 16:43:44.293634
249	Bu Lông+Ecu+Long Đen	bu long+ecu+long den	kg	40000	0	\N	2025-07-18 16:43:44.29664	2025-07-18 16:43:44.29664
250	Búa 2 Kg	bua 2 kg	cái	45000	0	\N	2025-07-18 16:43:44.299653	2025-07-18 16:43:44.299653
251	Búa Cán Sắt To	bua can sat to	cái	30000	0	\N	2025-07-18 16:43:44.301667	2025-07-18 16:43:44.301667
252	Búa Cao Su Bé	bua cao su be	cái	13000	0	\N	2025-07-18 16:43:44.303666	2025-07-18 16:43:44.303666
253	Búa Cao Su To	bua cao su to	cái	17000	0	\N	2025-07-18 16:43:44.306139	2025-07-18 16:43:44.306139
254	Búa Đinh 1 Kg	bua dinh 1 kg	cái	30000	0	\N	2025-07-18 16:43:44.309154	2025-07-18 16:43:44.309154
255	Búa Đỏ 1.5 Kg	bua do 1.5 kg	cái	40000	0	\N	2025-07-18 16:43:44.311169	2025-07-18 16:43:44.311169
256	Búa Lục 2 Kg	bua luc 2 kg	cái	45000	0	\N	2025-07-18 16:43:44.313185	2025-07-18 16:43:44.313185
257	Búa Rìu	bua riu	cái	35000	0	\N	2025-07-18 16:43:44.316201	2025-07-18 16:43:44.316201
258	Búa Sắt Vắt 1 Kg	bua sat vat 1 kg	cái	25000	0	\N	2025-07-18 16:43:44.318148	2025-07-18 16:43:44.318148
259	Búa Sắt Vắt 1.5 Kg	bua sat vat 1.5 kg	cái	35000	0	\N	2025-07-18 16:43:44.32117	2025-07-18 16:43:44.32117
260	Búa Vát 0.5 Kg	bua vat 0.5 kg	cái	18000	0	\N	2025-07-18 16:43:44.323185	2025-07-18 16:43:44.323185
261	Búi Sắt	bui sat	cái	3000	0	\N	2025-07-18 16:43:44.326161	2025-07-18 16:43:44.326161
262	Bulong 12X12	bulong 12x12	cái	40000	0	\N	2025-07-18 16:43:44.328171	2025-07-18 16:43:44.328171
263	Buly Tời To	buly toi to	cái	70000	0	\N	2025-07-18 16:43:44.33017	2025-07-18 16:43:44.33017
264	Búp 3 W Vàng	bup 3 w vang	cái	25000	0	\N	2025-07-18 16:43:44.332169	2025-07-18 16:43:44.332169
265	Bút Bi	but bi	cái	4000	0	\N	2025-07-18 16:43:44.335185	2025-07-18 16:43:44.335185
266	Bút Chì	but chi	hộp	30000	0	\N	2025-07-18 16:43:44.338171	2025-07-18 16:43:44.338171
267	Bút Dạ Bảng	but da bang	cái	10000	0	\N	2025-07-18 16:43:44.342197	2025-07-18 16:43:44.342197
268	Bút Dạ Kim	but da kim	hộp	75000	0	\N	2025-07-18 16:43:44.346018	2025-07-18 16:43:44.346018
269	Bút Dạ Xanh To	but da xanh to	cái	10000	0	\N	2025-07-18 16:43:44.347017	2025-07-18 16:43:44.347017
270	Bút Điện Cảm Ứng	but dien cam ung	cái	20000	0	\N	2025-07-18 16:43:44.350023	2025-07-18 16:43:44.350023
616	Cốt Kim 6	cot kim 6	cái	1000	0	\N	2025-07-18 16:43:45.219261	2025-07-18 16:43:45.219261
271	Bút Điện Etp Điện Quang	but dien etp dien quang	cái	25000	0	\N	2025-07-18 16:43:44.352161	2025-07-18 16:43:44.352161
272	Bút Điện Rẻ	but dien re	cái	15000	0	\N	2025-07-18 16:43:44.354192	2025-07-18 16:43:44.354192
273	Bút Điện Tốt Điện Quang	but dien tot dien quang	cái	25000	0	\N	2025-07-18 16:43:44.357665	2025-07-18 16:43:44.357665
274	Bút Tạ 5 Kg	but ta 5 kg	cái	170000	0	\N	2025-07-18 16:43:44.360801	2025-07-18 16:43:44.360801
275	Bút Vát 1 Kg	but vat 1 kg	cái	25000	0	\N	2025-07-18 16:43:44.362872	2025-07-18 16:43:44.362872
276	Bút Vỉ Vẽ	but vi ve	vỉ	20000	0	\N	2025-07-18 16:43:44.364924	2025-07-18 16:43:44.364924
277	Bút Xoá Rẻ	but xoa re	kg	10000	0	\N	2025-07-18 16:43:44.366443	2025-07-18 16:43:44.366443
278	Bút Xoá Xịn	but xoa xin	cái	20000	0	\N	2025-07-18 16:43:44.368468	2025-07-18 16:43:44.368468
279	Cà Lê 10	ca le 10	cái	12000	0	\N	2025-07-18 16:43:44.371514	2025-07-18 16:43:44.371514
280	Cà Lê 13	ca le 13	cái	15000	0	\N	2025-07-18 16:43:44.375498	2025-07-18 16:43:44.375498
281	Cà Lê 17	ca le 17	cái	20000	0	\N	2025-07-18 16:43:44.378514	2025-07-18 16:43:44.378514
282	Cadisun Cáp 2X16	cadisun cap 2x16	m	105000	0	\N	2025-07-18 16:43:44.380514	2025-07-18 16:43:44.380514
283	Cadisun Cáp 2X16	cadisun cap 2x16	m	0	0	\N	2025-07-18 16:43:44.383482	2025-07-18 16:43:44.383482
284	Cadisun Cáp 2X6	cadisun cap 2x6	m	46000	0	\N	2025-07-18 16:43:44.386039	2025-07-18 16:43:44.386039
285	Cadisun Cáp 3X4+1X2.5	cadisun cap 3x4+1x2.5	m	52000	0	\N	2025-07-18 16:43:44.389022	2025-07-18 16:43:44.389022
286	Cadisun Cáp Ngầm 2X16	cadisun cap ngam 2x16	m	110000	0	\N	2025-07-18 16:43:44.392071	2025-07-18 16:43:44.392071
287	Cadisun Cáp Ngầm 4X25	cadisun cap ngam 4x25	m	305000	0	\N	2025-07-18 16:43:44.394085	2025-07-18 16:43:44.394085
288	Cadisun Cáp Nhôm 4X70	cadisun cap nhom 4x70	m	80000	0	\N	2025-07-18 16:43:44.396047	2025-07-18 16:43:44.396047
289	Cadisun Cáp Treo 4X4	cadisun cap treo 4x4	m	60000	0	\N	2025-07-18 16:43:44.398069	2025-07-18 16:43:44.398069
290	Cadisun Cáp Treo 4X4	cadisun cap treo 4x4	m	60000	0	\N	2025-07-18 16:43:44.400071	2025-07-18 16:43:44.400071
291	Cadisun Cáp Treo 4X6	cadisun cap treo 4x6	m	82000	0	\N	2025-07-18 16:43:44.402085	2025-07-18 16:43:44.402085
292	Cadisun Cáp Treo Cxv 4X25	cadisun cap treo cxv 4x25	m	305000	0	\N	2025-07-18 16:43:44.404071	2025-07-18 16:43:44.404071
293	Cadisun Dây 1X0.5	cadisun day 1x0.5	m	2200	0	\N	2025-07-18 16:43:44.406069	2025-07-18 16:43:44.406069
294	Cadisun Dây 1X0.75	cadisun day 1x0.75	m	2800	0	\N	2025-07-18 16:43:44.408615	2025-07-18 16:43:44.408615
295	Cadisun Dây 1X1	cadisun day 1x1	m	2600	0	\N	2025-07-18 16:43:44.410631	2025-07-18 16:43:44.410631
296	Cadisun Dây 1X1.5 Đen	cadisun day 1x1.5 den	m	5793	0	\N	2025-07-18 16:43:44.413618	2025-07-18 16:43:44.413618
297	Cadisun Dây 1X1.5 Đỏ	cadisun day 1x1.5 do	m	5793	0	\N	2025-07-18 16:43:44.415631	2025-07-18 16:43:44.415631
298	Cadisun Dây 1X1.5 Tiếp Địa	cadisun day 1x1.5 tiep dia	m	5793	0	\N	2025-07-18 16:43:44.418615	2025-07-18 16:43:44.418615
299	Cadisun Dây 1X10	cadisun day 1x10	m	43837	0	\N	2025-07-18 16:43:44.420615	2025-07-18 16:43:44.420615
300	Cadisun Dây 1X2,5 Đen	cadisun day 1x2,5 den	m	7500	0	\N	2025-07-18 16:43:44.422631	2025-07-18 16:43:44.422631
301	Cadisun Dây 1X2.5 Đỏ	cadisun day 1x2.5 do	m	9423	0	\N	2025-07-18 16:43:44.424631	2025-07-18 16:43:44.424631
302	Cadisun Dây 1X2.5 Tiếp Địa	cadisun day 1x2.5 tiep dia	m	9423	0	\N	2025-07-18 16:43:44.427602	2025-07-18 16:43:44.427602
303	Cadisun Dây 1X2.5 Xanh	cadisun day 1x2.5 xanh	m	9423	0	\N	2025-07-18 16:43:44.43109	2025-07-18 16:43:44.43109
304	Cadisun Dây 1X4	cadisun day 1x4	m	12000	0	\N	2025-07-18 16:43:44.434122	2025-07-18 16:43:44.434122
305	Cadisun Dây 1X4 Tiếp Địa	cadisun day 1x4 tiep dia	m	11500	0	\N	2025-07-18 16:43:44.436099	2025-07-18 16:43:44.436099
306	Cadisun Dây 1X6 Đen	cadisun day 1x6 den	m	16000	0	\N	2025-07-18 16:43:44.438085	2025-07-18 16:43:44.438085
307	Cadisun Dây 1X6 Đỏ	cadisun day 1x6 do	m	19000	0	\N	2025-07-18 16:43:44.441114	2025-07-18 16:43:44.441114
308	Cadisun Dây 2X0.75	cadisun day 2x0.75	m	6500	0	\N	2025-07-18 16:43:44.443161	2025-07-18 16:43:44.443161
309	Cadisun Dây 2X0.75 Ovan	cadisun day 2x0.75 ovan	m	7000	0	\N	2025-07-18 16:43:44.445161	2025-07-18 16:43:44.445161
310	Cadisun Dây 2X1 Ovan	cadisun day 2x1 ovan	m	7500	0	\N	2025-07-18 16:43:44.448161	2025-07-18 16:43:44.448161
311	Cadisun Dây 2X1,5 Ovan	cadisun day 2x1,5 ovan	m	10000	0	\N	2025-07-18 16:43:44.451129	2025-07-18 16:43:44.451129
312	Cadisun Dây 2X1.5 Ghi Tròn	cadisun day 2x1.5 ghi tron	m	11000	0	\N	2025-07-18 16:43:44.454544	2025-07-18 16:43:44.454544
313	Cadisun Dây 2X1.5 Ovan	cadisun day 2x1.5 ovan	m	12000	0	\N	2025-07-18 16:43:44.456541	2025-07-18 16:43:44.456541
314	Cadisun Dây 2X2,5 Ovan	cadisun day 2x2,5 ovan	m	17000	0	\N	2025-07-18 16:43:44.457979	2025-07-18 16:43:44.457979
315	Cadisun Dây 2X2.5 Ghi	cadisun day 2x2.5 ghi	m	18000	0	\N	2025-07-18 16:43:44.46098	2025-07-18 16:43:44.46098
316	Cadisun Dây 2X2.5 Ovan	cadisun day 2x2.5 ovan	m	16000	0	\N	2025-07-18 16:43:44.464443	2025-07-18 16:43:44.464443
317	Cadisun Dây 2X4	cadisun day 2x4	m	26000	0	\N	2025-07-18 16:43:44.466888	2025-07-18 16:43:44.466888
318	Cadisun Dây 3X1.5 Ghi	cadisun day 3x1.5 ghi	m	17000	0	\N	2025-07-18 16:43:44.468923	2025-07-18 16:43:44.468923
319	Cadisun Dây 3X2.5 Ghi	cadisun day 3x2.5 ghi	m	27000	0	\N	2025-07-18 16:43:44.470957	2025-07-18 16:43:44.470957
320	Cadisun Dây 3X4 Ghi	cadisun day 3x4 ghi	m	40000	0	\N	2025-07-18 16:43:44.473993	2025-07-18 16:43:44.473993
321	Cadisun Dây 4X2.5 Tròn	cadisun day 4x2.5 tron	m	36000	0	\N	2025-07-18 16:43:44.477007	2025-07-18 16:43:44.477007
322	Cadisun Dây Cáp 2X6	cadisun day cap 2x6	m	46000	0	\N	2025-07-18 16:43:44.479007	2025-07-18 16:43:44.479007
323	Cadisun Dây Mềm 4X6	cadisun day mem 4x6	m	65000	0	\N	2025-07-18 16:43:44.481972	2025-07-18 16:43:44.481972
324	Cadisun Dây Mềm Ghi 4X6	cadisun day mem ghi 4x6	m	80000	0	\N	2025-07-18 16:43:44.485516	2025-07-18 16:43:44.485516
325	Cadisun Dây Tiếp Địa 1X10	cadisun day tiep dia 1x10	m	31000	0	\N	2025-07-18 16:43:44.488531	2025-07-18 16:43:44.488531
326	Cadisun Tiếp Địa 1X70	cadisun tiep dia 1x70	m	195000	0	\N	2025-07-18 16:43:44.491517	2025-07-18 16:43:44.491517
327	Cadivi Dây 1X1 Đỏ	cadivi day 1x1 do	m	4752	0	\N	2025-07-18 16:43:44.493563	2025-07-18 16:43:44.493563
328	Cadivi Dây 1X1 Xanh	cadivi day 1x1 xanh	m	4752	0	\N	2025-07-18 16:43:44.496549	2025-07-18 16:43:44.496549
329	Cadivi Dây 1X1.5	cadivi day 1x1.5	m	6963	0	\N	2025-07-18 16:43:44.498549	2025-07-18 16:43:44.498549
330	Cadivi Dây 1X2.5 Đỏ	cadivi day 1x2.5 do	m	11165	0	\N	2025-07-18 16:43:44.500563	2025-07-18 16:43:44.500563
331	Cadivi Dây 1X2.5 Xanh	cadivi day 1x2.5 xanh	m	11165	0	\N	2025-07-18 16:43:44.502549	2025-07-18 16:43:44.502549
332	Cadivi Dây 1X4 Đỏ	cadivi day 1x4 do	m	17259	0	\N	2025-07-18 16:43:44.505532	2025-07-18 16:43:44.505532
333	Cadivi Dây 1X4 Xanh	cadivi day 1x4 xanh	m	17259	0	\N	2025-07-18 16:43:44.50807	2025-07-18 16:43:44.50807
334	Cadivi Dây 2X0.75	cadivi day 2x0.75	m	8767	0	\N	2025-07-18 16:43:44.511073	2025-07-18 16:43:44.511073
335	Cadivi Dây 2X1.5 Ovan	cadivi day 2x1.5 ovan	m	15466	0	\N	2025-07-18 16:43:44.513087	2025-07-18 16:43:44.513087
336	Cadivi Dây 2X2.5	cadivi day 2x2.5	m	19500	0	\N	2025-07-18 16:43:44.516087	2025-07-18 16:43:44.516087
337	Cài Sen	cai sen	cái	20000	0	\N	2025-07-18 16:43:44.51907	2025-07-18 16:43:44.51907
338	Cài Xịt	cai xit	cái	10000	0	\N	2025-07-18 16:43:44.521087	2025-07-18 16:43:44.521087
339	Cảm Biến Decom	cam bien decom	cái	250000	0	\N	2025-07-18 16:43:44.523087	2025-07-18 16:43:44.523087
340	Cảm Biến Máy Bơm Teaasung	cam bien may bom teaasung	cái	160000	0	\N	2025-07-18 16:43:44.526087	2025-07-18 16:43:44.526087
341	Cảm Ứng Vi Sóng	cam ung vi song	cái	250000	0	\N	2025-07-18 16:43:44.529073	2025-07-18 16:43:44.529073
342	Cân 10 Kg Nhơn Hòa	can 10 kg nhon hoa	cái	510000	0	\N	2025-07-18 16:43:44.531073	2025-07-18 16:43:44.531073
343	Cân 100 Kg Nhơn Hòa	can 100 kg nhon hoa	cái	1340000	0	\N	2025-07-18 16:43:44.533087	2025-07-18 16:43:44.533087
344	Cân 2 Kg Nhơn Hòa	can 2 kg nhon hoa	cái	270000	0	\N	2025-07-18 16:43:44.536072	2025-07-18 16:43:44.536072
345	Cân 20 Kg Nhơn Hòa	can 20 kg nhon hoa	cái	570000	0	\N	2025-07-18 16:43:44.538087	2025-07-18 16:43:44.538087
346	Cân 30 Kg	can 30 kg	cái	580000	0	\N	2025-07-18 16:43:44.540072	2025-07-18 16:43:44.540072
347	Cân 60 Kg	can 60 kg	cái	1240000	0	\N	2025-07-18 16:43:44.542087	2025-07-18 16:43:44.542087
348	Cân Điện Tử 30 Kg	can dien tu 30 kg	cái	750000	0	\N	2025-07-18 16:43:44.545134	2025-07-18 16:43:44.545134
349	Cân Hơi Đồng Hồ Th	can hoi dong ho th	cái	145000	0	\N	2025-07-18 16:43:44.547134	2025-07-18 16:43:44.547134
350	Can Nhựa 10 Lít	can nhua 10 lit	cái	30000	0	\N	2025-07-18 16:43:44.550104	2025-07-18 16:43:44.550104
351	Can Nhựa 5 Lít	can nhua 5 lit	cái	20000	0	\N	2025-07-18 16:43:44.55312	2025-07-18 16:43:44.55312
352	Cân Sen	can sen	cái	20000	0	\N	2025-07-18 16:43:44.555118	2025-07-18 16:43:44.555118
353	Cán Xẻng	can xeng	cái	7000	0	\N	2025-07-18 16:43:44.557644	2025-07-18 16:43:44.557644
354	Cana Bé	cana be	hộp	38000	0	\N	2025-07-18 16:43:44.559691	2025-07-18 16:43:44.559691
355	Cana To	cana to	hộp	58000	0	\N	2025-07-18 16:43:44.561674	2025-07-18 16:43:44.561674
356	Cánh 650 Komasu	canh 650 komasu	cái	340000	0	\N	2025-07-18 16:43:44.563677	2025-07-18 16:43:44.563677
357	Cánh Mạ 500 Komasu	canh ma 500 komasu	cái	340000	0	\N	2025-07-18 16:43:44.565677	2025-07-18 16:43:44.565677
358	Cánh Quạt 400	canh quat 400	cái	30000	0	\N	2025-07-18 16:43:44.566677	2025-07-18 16:43:44.566677
359	Cánh Quạt 500 Vinawind	canh quat 500 vinawind	cái	190000	0	\N	2025-07-18 16:43:44.568691	2025-07-18 16:43:44.568691
360	Cánh Quạt Đỏ	canh quat do	cái	15000	0	\N	2025-07-18 16:43:44.571738	2025-07-18 16:43:44.571738
361	Cánh Tản To	canh tan to	cái	25000	0	\N	2025-07-18 16:43:44.5747	2025-07-18 16:43:44.5747
362	Cào Chang	cao chang	cái	40000	0	\N	2025-07-18 16:43:44.577697	2025-07-18 16:43:44.577697
363	Cào Răng	cao rang	cái	25000	0	\N	2025-07-18 16:43:44.579752	2025-07-18 16:43:44.579752
364	Cáp 2X10	cap 2x10	m	66000	0	\N	2025-07-18 16:43:44.58281	2025-07-18 16:43:44.58281
365	Cáp 2X4	cap 2x4	m	28500	0	\N	2025-07-18 16:43:44.585151	2025-07-18 16:43:44.585151
366	Cáp 2X6	cap 2x6	m	46000	0	\N	2025-07-18 16:43:44.589199	2025-07-18 16:43:44.589199
367	Cáp 3X10+1X6	cap 3x10+1x6	m	110000	0	\N	2025-07-18 16:43:44.591186	2025-07-18 16:43:44.591186
368	Cáp 4X10	cap 4x10	m	128000	0	\N	2025-07-18 16:43:44.593246	2025-07-18 16:43:44.593246
369	Cáp Boc 10	cap boc 10	m	12000	0	\N	2025-07-18 16:43:44.596233	2025-07-18 16:43:44.596233
370	Cáp Bọc 4	cap boc 4	m	2500	0	\N	2025-07-18 16:43:44.598247	2025-07-18 16:43:44.598247
371	Cáp Bọc 5	cap boc 5	m	3500	0	\N	2025-07-18 16:43:44.601233	2025-07-18 16:43:44.601233
372	Cáp Bọc 8	cap boc 8	m	8000	0	\N	2025-07-18 16:43:44.603233	2025-07-18 16:43:44.603233
373	Cáp Đồng 4X16	cap dong 4x16	m	192000	0	\N	2025-07-18 16:43:44.606235	2025-07-18 16:43:44.606235
374	Cáp Hàn 16 Mjeil	cap han 16 mjeil	m	45000	0	\N	2025-07-18 16:43:44.608772	2025-07-18 16:43:44.608772
375	Cáp Lụa 3	cap lua 3	m	2500	0	\N	2025-07-18 16:43:44.610758	2025-07-18 16:43:44.610758
376	Cáp Lụa 4	cap lua 4	m	3500	0	\N	2025-07-18 16:43:44.612772	2025-07-18 16:43:44.612772
377	Cáp Lụa Bọc Nhựa 6	cap lua boc nhua 6	m	4500	0	\N	2025-07-18 16:43:44.615772	2025-07-18 16:43:44.615772
378	Cáp Mạ Sắt Phi 10	cap ma sat phi 10	m	10000	0	\N	2025-07-18 16:43:44.618773	2025-07-18 16:43:44.618773
379	Cáp Ngầm 4X16	cap ngam 4x16	m	195000	0	\N	2025-07-18 16:43:44.620758	2025-07-18 16:43:44.620758
380	Cáp Ngầm 4X35	cap ngam 4x35	m	372000	0	\N	2025-07-18 16:43:44.622772	2025-07-18 16:43:44.622772
381	Cáp Ngầm 4X6	cap ngam 4x6	m	80000	0	\N	2025-07-18 16:43:44.625773	2025-07-18 16:43:44.625773
382	Cáp Nhôm 2X25	cap nhom 2x25	cái	17500	0	\N	2025-07-18 16:43:44.62876	2025-07-18 16:43:44.62876
383	Cáp Nhôm 4X16	cap nhom 4x16	m	17000	0	\N	2025-07-18 16:43:44.630773	2025-07-18 16:43:44.630773
384	Cáp Nhôm 4X25	cap nhom 4x25	m	28000	0	\N	2025-07-18 16:43:44.632772	2025-07-18 16:43:44.632772
385	Cáp Nhôm 4X35 Ckc	cap nhom 4x35 ckc	m	31000	0	\N	2025-07-18 16:43:44.634772	2025-07-18 16:43:44.634772
386	Cáp Nhôm 4X70 Ckc	cap nhom 4x70 ckc	m	65000	0	\N	2025-07-18 16:43:44.636772	2025-07-18 16:43:44.636772
387	Cáp Sắt Mạ 5	cap sat ma 5	m	4500	0	\N	2025-07-18 16:43:44.640739	2025-07-18 16:43:44.640739
388	Cáp Treo Cxv 4X35	cap treo cxv 4x35	m	430000	0	\N	2025-07-18 16:43:44.643784	2025-07-18 16:43:44.643784
389	Cáp Treo Đồng 4X16	cap treo dong 4x16	m	198000	0	\N	2025-07-18 16:43:44.645783	2025-07-18 16:43:44.645783
390	Cắt Băng Dinh To	cat bang dinh to	cái	35000	0	\N	2025-07-18 16:43:44.647783	2025-07-18 16:43:44.647783
391	Cắt Bê Tông 100	cat be tong 100	cái	55000	0	\N	2025-07-18 16:43:44.651769	2025-07-18 16:43:44.651769
392	Cắt Gạch 133	cat gach 133	cái	125000	0	\N	2025-07-18 16:43:44.654783	2025-07-18 16:43:44.654783
393	Cắt Gạch 150 Bosun	cat gach 150 bosun	cái	95000	0	\N	2025-07-18 16:43:44.658299	2025-07-18 16:43:44.658299
394	Cắt Gạch Bosun 230	cat gach bosun 230	cái	170000	0	\N	2025-07-18 16:43:44.660347	2025-07-18 16:43:44.660347
395	Cắt Gạch Hb	cat gach hb	cái	45000	0	\N	2025-07-18 16:43:44.662336	2025-07-18 16:43:44.662336
396	Cắt Gạch Nd Chống Rung	cat gach nd chong rung	cái	110000	0	\N	2025-07-18 16:43:44.665333	2025-07-18 16:43:44.665333
397	Cắt Gạch Phi 230 Bosun	cat gach phi 230 bosun	cái	170000	0	\N	2025-07-18 16:43:44.666333	2025-07-18 16:43:44.666333
398	Cắt Gạch Tiger Xẻ	cat gach tiger xe	cái	75000	0	\N	2025-07-18 16:43:44.668348	2025-07-18 16:43:44.668348
399	Cắt Gạch Trâu	cat gach trau	cái	110000	0	\N	2025-07-18 16:43:44.670381	2025-07-18 16:43:44.670381
400	Cắt Gỗ 180 Apos	cat go 180 apos	cái	120000	0	\N	2025-07-18 16:43:44.674381	2025-07-18 16:43:44.674381
401	Cắt Gỗ Makita	cat go makita	cái	220000	0	\N	2025-07-18 16:43:44.676395	2025-07-18 16:43:44.676395
402	Cắt Nhôm Lục Giác Xịn D250 120 Răng	cat nhom luc giac xin d250 120 rang	cái	750000	0	\N	2025-07-18 16:43:44.678381	2025-07-18 16:43:44.678381
403	Cắt Nhôm Makita D 250 Móc Câu	cat nhom makita d 250 moc cau	cái	450000	0	\N	2025-07-18 16:43:44.679381	2025-07-18 16:43:44.679381
404	Cắt Sắt 150	cat sat 150	cái	15000	0	\N	2025-07-18 16:43:44.682396	2025-07-18 16:43:44.682396
405	Cát Thạch Anh	cat thach anh	bao	110000	0	\N	2025-07-18 16:43:44.684988	2025-07-18 16:43:44.684988
406	Cầu Dao 2 Pha	cau dao 2 pha	cái	100000	0	\N	2025-07-18 16:43:44.687978	2025-07-18 16:43:44.687978
407	Cầu Dao 2/30 A Tiến Thành	cau dao 2/30 a tien thanh	cái	90000	0	\N	2025-07-18 16:43:44.689992	2025-07-18 16:43:44.689992
474	Chậu Rửa Bát 2 Hố S76S	chau rua bat 2 ho s76s	cái	700000	0	\N	2025-07-18 16:43:44.86067	2025-07-18 16:43:44.86067
408	Cầu Dao 3 Pha 4 Cực 150A Đảo Tiến Thành	cau dao 3 pha 4 cuc 150a dao tien thanh	cái	1850000	0	\N	2025-07-18 16:43:44.692993	2025-07-18 16:43:44.692993
409	Cầu Dao 3/60A Tiến Thành	cau dao 3/60a tien thanh	cái	280000	0	\N	2025-07-18 16:43:44.696026	2025-07-18 16:43:44.696026
410	Cầu Dao 3P/100 A Tiến Thành	cau dao 3p/100 a tien thanh	cái	450000	0	\N	2025-07-18 16:43:44.69904	2025-07-18 16:43:44.69904
411	Cầu Dao Đảo 2 Pha 60 A Tiến Thành Đảo	cau dao dao 2 pha 60 a tien thanh dao	cái	150000	0	\N	2025-07-18 16:43:44.70104	2025-07-18 16:43:44.70104
412	Cầu Dao Đảo 3 Pha 4 Cực 200A Tiến Thành	cau dao dao 3 pha 4 cuc 200a tien thanh	cái	2500000	0	\N	2025-07-18 16:43:44.704026	2025-07-18 16:43:44.704026
413	Cầu Dao Đảo 3P 4 Cực	cau dao dao 3p 4 cuc	cái	1960000	0	\N	2025-07-18 16:43:44.70604	2025-07-18 16:43:44.70604
414	Cầu Đấu 10 A Ekit	cau dau 10 a ekit	cái	20000	0	\N	2025-07-18 16:43:44.708562	2025-07-18 16:43:44.708562
415	Cầu Đấu 15 A	cau dau 15 a	thanh	20000	0	\N	2025-07-18 16:43:44.71061	2025-07-18 16:43:44.71061
416	Cầu Đấu 20 A Ekit	cau dau 20 a ekit	thanh	20000	0	\N	2025-07-18 16:43:44.713611	2025-07-18 16:43:44.713611
417	Cầu Đấu 25 A Ekit H=10	cau dau 25 a ekit h=10	thanh	25000	0	\N	2025-07-18 16:43:44.71561	2025-07-18 16:43:44.71561
418	Cầu Đấu 30 A Ekit	cau dau 30 a ekit	thanh	22000	0	\N	2025-07-18 16:43:44.718596	2025-07-18 16:43:44.718596
419	Cầu Đấu 60 A Ekit	cau dau 60 a ekit	thanh	40000	0	\N	2025-07-18 16:43:44.720596	2025-07-18 16:43:44.720596
420	Cầu Đấu 60A 3Fa	cau dau 60a 3fa	cái	35000	0	\N	2025-07-18 16:43:44.72261	2025-07-18 16:43:44.72261
421	Cầu Đấu 6A Ekit	cau dau 6a ekit	thanh	15000	0	\N	2025-07-18 16:43:44.72461	2025-07-18 16:43:44.72461
422	Cầu Đấu Đen 100 A	cau dau den 100 a	cái	40000	0	\N	2025-07-18 16:43:44.72761	2025-07-18 16:43:44.72761
423	Cầu Đấu Đen 25 A	cau dau den 25 a	cái	15000	0	\N	2025-07-18 16:43:44.730596	2025-07-18 16:43:44.730596
424	Cầu Mát 13 Mắt	cau mat 13 mat	thanh	35000	0	\N	2025-07-18 16:43:44.73361	2025-07-18 16:43:44.73361
425	Cầu Mát 7 Mắt	cau mat 7 mat	thanh	25000	0	\N	2025-07-18 16:43:44.735596	2025-07-18 16:43:44.735596
426	Cầu Nối 3 Pha	cau noi 3 pha	cái	260000	0	\N	2025-07-18 16:43:44.73761	2025-07-18 16:43:44.73761
427	Cầu Rác 110 304	cau rac 110 304	cái	125000	0	\N	2025-07-18 16:43:44.741597	2025-07-18 16:43:44.741597
428	Cầu Rác 110 Đẹp	cau rac 110 dep	cái	55000	0	\N	2025-07-18 16:43:44.743642	2025-07-18 16:43:44.743642
429	Cầu Rác 110 Thưa	cau rac 110 thua	cái	25000	0	\N	2025-07-18 16:43:44.745642	2025-07-18 16:43:44.745642
430	Cầu Rác 48	cau rac 48	cái	20000	0	\N	2025-07-18 16:43:44.747642	2025-07-18 16:43:44.747642
431	Cầu Rác 60	cau rac 60	cái	20000	0	\N	2025-07-18 16:43:44.751629	2025-07-18 16:43:44.751629
432	Cầu Rác 75 - 304 Đắt	cau rac 75 - 304 dat	cái	80000	0	\N	2025-07-18 16:43:44.754642	2025-07-18 16:43:44.754642
433	Cầu Rác 75 R	cau rac 75 r	cái	20000	0	\N	2025-07-18 16:43:44.756628	2025-07-18 16:43:44.756628
434	Cầu Rác 90 / 304	cau rac 90 / 304	cái	95000	0	\N	2025-07-18 16:43:44.758173	2025-07-18 16:43:44.758173
435	Cầu Rác 90 Loại Trung	cau rac 90 loai trung	cái	50000	0	\N	2025-07-18 16:43:44.761224	2025-07-18 16:43:44.761224
436	Cầu Rác 90 R	cau rac 90 r	cái	20000	0	\N	2025-07-18 16:43:44.76421	2025-07-18 16:43:44.76421
437	Cầu Rác Inox 60	cau rac inox 60	cái	45000	0	\N	2025-07-18 16:43:44.766224	2025-07-18 16:43:44.766224
438	Cây Gặt Nước	cay gat nuoc	cái	110000	0	\N	2025-07-18 16:43:44.768224	2025-07-18 16:43:44.768224
439	Cây Lau Nhà Xoay	cay lau nha xoay	cái	260000	0	\N	2025-07-18 16:43:44.771257	2025-07-18 16:43:44.771257
440	Cây Mạ 500 Komasu	cay ma 500 komasu	cái	1850000	0	\N	2025-07-18 16:43:44.774257	2025-07-18 16:43:44.774257
441	Chân 284 Dài Linax	chan 284 dai linax	cái	600000	0	\N	2025-07-18 16:43:44.777257	2025-07-18 16:43:44.777257
442	Chân Cao Su Hộp 3X3	chan cao su hop 3x3	cái	1000	0	\N	2025-07-18 16:43:44.779271	2025-07-18 16:43:44.779271
443	Chân Chậu 288 Linax	chan chau 288 linax	cái	750000	0	\N	2025-07-18 16:43:44.782257	2025-07-18 16:43:44.782257
444	Chân Chậu R	chan chau r	cái	150000	0	\N	2025-07-18 16:43:44.785805	2025-07-18 16:43:44.785805
445	Chân Chậu St 21	chan chau st 21	cái	400000	0	\N	2025-07-18 16:43:44.787791	2025-07-18 16:43:44.787791
446	Chân Lửng 288	chan lung 288	cái	700000	0	\N	2025-07-18 16:43:44.789805	2025-07-18 16:43:44.789805
447	Chân Lửng 298 Linax	chan lung 298 linax	cái	740000	0	\N	2025-07-18 16:43:44.792806	2025-07-18 16:43:44.792806
448	Chân Máy Bắn Cốt	chan may ban cot	cái	100000	0	\N	2025-07-18 16:43:44.795839	2025-07-18 16:43:44.795839
449	Chân Ren Đồng Hồ Nước Đồng	chan ren dong ho nuoc dong	đôi	60000	0	\N	2025-07-18 16:43:44.799576	2025-07-18 16:43:44.799576
450	Chân Sen Sen Ta	chan sen sen ta	bộ	160000	0	\N	2025-07-18 16:43:44.802161	2025-07-18 16:43:44.802161
451	Chân Sen Thường	chan sen thuong	đôi	90000	0	\N	2025-07-18 16:43:44.803174	2025-07-18 16:43:44.803174
452	Chân Vòi Lạnh	chan voi lanh	cái	25000	0	\N	2025-07-18 16:43:44.807477	2025-07-18 16:43:44.807477
453	Chao Đèn	chao den	cái	50000	0	\N	2025-07-18 16:43:44.810033	2025-07-18 16:43:44.810033
454	Chao Mạ 300	chao ma 300	cái	65000	0	\N	2025-07-18 16:43:44.813034	2025-07-18 16:43:44.813034
455	Chậu 1 Hố 304 78X43	chau 1 ho 304 78x43	cái	1450000	0	\N	2025-07-18 16:43:44.815033	2025-07-18 16:43:44.815033
456	Chậu 280 Linax	chau 280 linax	cái	400000	0	\N	2025-07-18 16:43:44.818033	2025-07-18 16:43:44.818033
457	Chậu 282 Linax	chau 282 linax	cái	550000	0	\N	2025-07-18 16:43:44.821017	2025-07-18 16:43:44.821017
458	Chậu 285 1 Lỗ Linax	chau 285 1 lo linax	cái	600000	0	\N	2025-07-18 16:43:44.823033	2025-07-18 16:43:44.823033
459	Chậu 285 3 Lỗ Linax	chau 285 3 lo linax	cái	600000	0	\N	2025-07-18 16:43:44.826033	2025-07-18 16:43:44.826033
460	Chậu 3 Lỗ Thái Bình	chau 3 lo thai binh	cái	150000	0	\N	2025-07-18 16:43:44.829019	2025-07-18 16:43:44.829019
461	Chậu Đúc 2 Hố 201	chau duc 2 ho 201	cái	850000	0	\N	2025-07-18 16:43:44.831035	2025-07-18 16:43:44.831035
462	Chậu Đúc 304 Sơn Hà	chau duc 304 son ha	cái	1950000	0	\N	2025-07-18 16:43:44.833046	2025-07-18 16:43:44.833046
463	Chậu Đúc Đen + Vòi	chau duc den + voi	bộ	4300000	0	\N	2025-07-18 16:43:44.836045	2025-07-18 16:43:44.836045
464	Chậu Đúc Đơn 1 Hố Đăt 78X43	chau duc don 1 ho dat 78x43	cái	2050000	0	\N	2025-07-18 16:43:44.83806	2025-07-18 16:43:44.83806
465	Chậu Góc Bé	chau goc be	cái	520000	0	\N	2025-07-18 16:43:44.841045	2025-07-18 16:43:44.841045
466	Chậu Kasung	chau kasung	cái	950000	0	\N	2025-07-18 16:43:44.843045	2025-07-18 16:43:44.843045
467	Chậu Liền Chân St 011 Sen Ta	chau lien chan st 011 sen ta	cái	1350000	0	\N	2025-07-18 16:43:44.845091	2025-07-18 16:43:44.845091
468	Chậu Linax 2216V	chau linax 2216v	cái	1250000	0	\N	2025-07-18 16:43:44.847091	2025-07-18 16:43:44.847091
469	Chậu Linax Al 299	chau linax al 299	cái	1950000	0	\N	2025-07-18 16:43:44.850091	2025-07-18 16:43:44.850091
470	Chậu Rửa Bát 1 Hố	chau rua bat 1 ho	cái	1450000	0	\N	2025-07-18 16:43:44.85308	2025-07-18 16:43:44.85308
471	Chậu Rửa Bát 1 Hố 60X42	chau rua bat 1 ho 60x42	cái	600000	0	\N	2025-07-18 16:43:44.854077	2025-07-18 16:43:44.854077
472	Chậu Rửa Bát 1 Hố Sơn Hà 447S	chau rua bat 1 ho son ha 447s	cái	350000	0	\N	2025-07-18 16:43:44.856092	2025-07-18 16:43:44.856092
473	Chậu Rửa Bát 2 Hố Rẻ	chau rua bat 2 ho re	cái	400000	0	\N	2025-07-18 16:43:44.858622	2025-07-18 16:43:44.858622
475	Chậu Rửa Bát 304 Sơn Hà Lyxury	chau rua bat 304 son ha lyxury	cái	1900000	0	\N	2025-07-18 16:43:44.863671	2025-07-18 16:43:44.863671
476	Chậu Rửa Bát 50X40 Rẻ	chau rua bat 50x40 re	cái	200000	0	\N	2025-07-18 16:43:44.86767	2025-07-18 16:43:44.86767
477	Châu Rửa Bát Đơn	chau rua bat don	bộ	250000	0	\N	2025-07-18 16:43:44.869689	2025-07-18 16:43:44.869689
478	Chậu Rửa Linax 289	chau rua linax 289	cái	850000	0	\N	2025-07-18 16:43:44.871703	2025-07-18 16:43:44.871703
479	Chậu Rửa Mặt 1 Lỗ Thái Bình	chau rua mat 1 lo thai binh	cái	150000	0	\N	2025-07-18 16:43:44.874689	2025-07-18 16:43:44.874689
480	Chậu Rửa Mặt 3 Lỗ Hc	chau rua mat 3 lo hc	cái	250000	0	\N	2025-07-18 16:43:44.876687	2025-07-18 16:43:44.876687
481	Chậu Rửa Mặt 312 Linax Fc	chau rua mat 312 linax fc	cái	950000	0	\N	2025-07-18 16:43:44.879691	2025-07-18 16:43:44.879691
482	Chậu Rửa Mặt Ac 2216	chau rua mat ac 2216	cái	1400000	0	\N	2025-07-18 16:43:44.881689	2025-07-18 16:43:44.881689
483	Chậu Rửa Măt Elips	chau rua mat elips	cái	510000	0	\N	2025-07-18 16:43:44.88428	2025-07-18 16:43:44.88428
484	Chậu Rửa Mặt Linax L2395 1 Lỗ	chau rua mat linax l2395 1 lo	cái	1050000	0	\N	2025-07-18 16:43:44.887315	2025-07-18 16:43:44.887315
485	Chậu Rửa Mặt Linax L294 V	chau rua mat linax l294 v	cái	2180000	0	\N	2025-07-18 16:43:44.890329	2025-07-18 16:43:44.890329
486	Chậu Rửa Mặt Mikado	chau rua mat mikado	cái	350000	0	\N	2025-07-18 16:43:44.892314	2025-07-18 16:43:44.892314
487	Chậu Rửa Mặt Rẻ 1 Lỗ	chau rua mat re 1 lo	cái	150000	0	\N	2025-07-18 16:43:44.894376	2025-07-18 16:43:44.894376
488	Chậu Rửa Mặt Sen Ta 23	chau rua mat sen ta 23	cái	360000	0	\N	2025-07-18 16:43:44.897381	2025-07-18 16:43:44.897381
489	Chậu Rửa Mặt St 011 Sen Ta	chau rua mat st 011 sen ta	cái	0	0	\N	2025-07-18 16:43:44.900376	2025-07-18 16:43:44.900376
490	Chậu Rửa Mặt Vigacera	chau rua mat vigacera	cái	350000	0	\N	2025-07-18 16:43:44.902376	2025-07-18 16:43:44.902376
491	Chậu Rửa Mặt Vina Cd21	chau rua mat vina cd21	cái	1250000	0	\N	2025-07-18 16:43:44.905378	2025-07-18 16:43:44.905378
492	Chậu Rửa St 013 Sen Ta	chau rua st 013 sen ta	cái	1350000	0	\N	2025-07-18 16:43:44.909476	2025-07-18 16:43:44.909476
493	Chậu Sen Ta Rửa Mặt St21	chau sen ta rua mat st21	cái	350000	0	\N	2025-07-18 16:43:44.912498	2025-07-18 16:43:44.912498
494	Chậu Sen Ta St 014	chau sen ta st 014	cái	1350000	0	\N	2025-07-18 16:43:44.914498	2025-07-18 16:43:44.914498
495	Chậu Senta 014	chau senta 014	cái	1350000	0	\N	2025-07-18 16:43:44.916523	2025-07-18 16:43:44.916523
496	Chậu Senta St 011	chau senta st 011	bộ	1280000	0	\N	2025-07-18 16:43:44.919532	2025-07-18 16:43:44.919532
497	Chậu St 001 Đặt Bàn Selta	chau st 001 dat ban selta	cái	1230000	0	\N	2025-07-18 16:43:44.922509	2025-07-18 16:43:44.922509
498	Chậu St 012 Selta	chau st 012 selta	cái	1300000	0	\N	2025-07-18 16:43:44.924509	2025-07-18 16:43:44.924509
499	Chậu St 36 Sen Ta 1 Lỗ	chau st 36 sen ta 1 lo	cái	450000	0	\N	2025-07-18 16:43:44.926523	2025-07-18 16:43:44.926523
500	Chậu Treo 3 Lỗ Vigacera	chau treo 3 lo vigacera	cái	360000	0	\N	2025-07-18 16:43:44.929524	2025-07-18 16:43:44.929524
501	Chếch 25 Uv Vesbo	chech 25 uv vesbo	cái	13200	0	\N	2025-07-18 16:43:44.931509	2025-07-18 16:43:44.931509
502	Chỉ Xây Bé	chi xay be	cuộn	8000	0	\N	2025-07-18 16:43:44.934509	2025-07-18 16:43:44.934509
503	Chỉ Xây Nhỏ	chi xay nho	cái	8000	0	\N	2025-07-18 16:43:44.936523	2025-07-18 16:43:44.936523
504	Chỉ Xây To	chi xay to	cái	15000	0	\N	2025-07-18 16:43:44.938523	2025-07-18 16:43:44.938523
505	Chia 3 Dẹt Sapoka	chia 3 det sapoka	cái	25000	0	\N	2025-07-18 16:43:44.941524	2025-07-18 16:43:44.941524
506	Chia Hơi 3	chia hoi 3	cái	40000	0	\N	2025-07-18 16:43:44.943509	2025-07-18 16:43:44.943509
507	Chia Ngả 2/20	chia nga 2/20	cái	6100	0	\N	2025-07-18 16:43:44.945555	2025-07-18 16:43:44.945555
508	Chỉnh Tâm Bệt	chinh tam bet	cái	130000	0	\N	2025-07-18 16:43:44.948555	2025-07-18 16:43:44.948555
509	Chõ Đồng 20	cho dong 20	cái	70000	0	\N	2025-07-18 16:43:44.950555	2025-07-18 16:43:44.950555
510	Chõ Đồng 40	cho dong 40	cái	182000	0	\N	2025-07-18 16:43:44.952539	2025-07-18 16:43:44.952539
511	Chõ Phun Sương	cho phun suong	cái	25000	0	\N	2025-07-18 16:43:44.954556	2025-07-18 16:43:44.954556
512	Chóa Đèn Mạ Nival 250	choa den ma nival 250	cái	45000	0	\N	2025-07-18 16:43:44.955555	2025-07-18 16:43:44.955555
513	Chổi 4 Thanh Thảo	choi 4 thanh thao	cái	15000	0	\N	2025-07-18 16:43:44.9591	2025-07-18 16:43:44.9591
514	Chổi Chít	choi chit	cái	25000	0	\N	2025-07-18 16:43:44.962137	2025-07-18 16:43:44.962137
515	Chổi Chít Cán Dài	choi chit can dai	cái	45000	0	\N	2025-07-18 16:43:44.966137	2025-07-18 16:43:44.966137
516	Chổi Đánh Rỉ Sắt	choi danh ri sat	cái	10000	0	\N	2025-07-18 16:43:44.968151	2025-07-18 16:43:44.968151
517	Chổi Lúa Quét Nhà	choi lua quet nha	cái	25000	0	\N	2025-07-18 16:43:44.971198	2025-07-18 16:43:44.971198
518	Chổi Nhựa Cán Inoc	choi nhua can inoc	cái	25000	0	\N	2025-07-18 16:43:44.974174	2025-07-18 16:43:44.974174
519	Chổi Nhựa Cán Inox	choi nhua can inox	cái	35000	0	\N	2025-07-18 16:43:44.975187	2025-07-18 16:43:44.975187
520	Chổi Nhựa Cán Nhựa	choi nhua can nhua	cái	25000	0	\N	2025-07-18 16:43:44.977184	2025-07-18 16:43:44.977184
521	Chổi Sơn 1	choi son 1	cái	2000	0	\N	2025-07-18 16:43:44.979198	2025-07-18 16:43:44.979198
522	Chổi Sơn 1 Đắt	choi son 1 dat	cái	6000	0	\N	2025-07-18 16:43:44.982199	2025-07-18 16:43:44.982199
523	Chổi Sơn 1.5	choi son 1.5	cái	3000	0	\N	2025-07-18 16:43:44.984718	2025-07-18 16:43:44.984718
524	Chổi Sơn 2	choi son 2	cái	12000	0	\N	2025-07-18 16:43:44.987753	2025-07-18 16:43:44.987753
525	Chổi Sơn 2.5	choi son 2.5	cái	5000	0	\N	2025-07-18 16:43:44.989767	2025-07-18 16:43:44.989767
526	Chổi Sơn 3	choi son 3	cái	6000	0	\N	2025-07-18 16:43:44.991768	2025-07-18 16:43:44.991768
527	Chổi Sơn 3 Thanh Thảo	choi son 3 thanh thao	cái	13000	0	\N	2025-07-18 16:43:44.993767	2025-07-18 16:43:44.993767
528	Chổi Sơn 4	choi son 4	cái	7000	0	\N	2025-07-18 16:43:44.996816	2025-07-18 16:43:44.996816
529	Chổi Sơn 4 Thắng Lợi	choi son 4 thang loi	cái	7000	0	\N	2025-07-18 16:43:44.9988	2025-07-18 16:43:44.9988
530	Chổi Sơn 4 Tn	choi son 4 tn	cái	15000	0	\N	2025-07-18 16:43:45.000814	2025-07-18 16:43:45.000814
531	Chổi Sơn Thảo Nguyên	choi son thao nguyen	cái	12000	0	\N	2025-07-18 16:43:45.003814	2025-07-18 16:43:45.003814
532	Chổi Sơn Thảo Nguyên 3	choi son thao nguyen 3	cái	10000	0	\N	2025-07-18 16:43:45.006802	2025-07-18 16:43:45.006802
533	Chổi Than	choi than	đôi	10000	0	\N	2025-07-18 16:43:45.009365	2025-07-18 16:43:45.009365
534	Chổi Tre	choi tre	cái	20000	0	\N	2025-07-18 16:43:45.011401	2025-07-18 16:43:45.011401
535	Chống Giật Bình Nóng Lạnh	chong giat binh nong lanh	cái	120000	0	\N	2025-07-18 16:43:45.013416	2025-07-18 16:43:45.013416
536	Chốt Âm Vuông	chot am vuong	cái	50000	0	\N	2025-07-18 16:43:45.017218	2025-07-18 16:43:45.017218
537	Chốt Cửa Tự Động	chot cua tu dong	cái	20000	0	\N	2025-07-18 16:43:45.01994	2025-07-18 16:43:45.01994
538	Chốt Đen 25 Cm	chot den 25 cm	cái	18000	0	\N	2025-07-18 16:43:45.02194	2025-07-18 16:43:45.02194
539	Chốt Inoc 6 "	chot inoc 6 "	cái	20000	0	\N	2025-07-18 16:43:45.023954	2025-07-18 16:43:45.023954
540	Chốt Inoc Dài 18 Cm	chot inoc dai 18 cm	cái	70000	0	\N	2025-07-18 16:43:45.025954	2025-07-18 16:43:45.025954
541	Chốt Inox Bé	chot inox be	cái	5000	0	\N	2025-07-18 16:43:45.028955	2025-07-18 16:43:45.028955
542	Chốt Inox To	chot inox to	cái	30000	0	\N	2025-07-18 16:43:45.031955	2025-07-18 16:43:45.031955
543	Chốt Niken Bé	chot niken be	cái	20000	0	\N	2025-07-18 16:43:45.03394	2025-07-18 16:43:45.03394
544	Chốt Niken To	chot niken to	cái	25000	0	\N	2025-07-18 16:43:45.035954	2025-07-18 16:43:45.035954
545	Chuông Kagawa	chuong kagawa	cái	480000	0	\N	2025-07-18 16:43:45.037954	2025-07-18 16:43:45.037954
546	Chụp Khí Mb 15 Ak	chup khi mb 15 ak	cái	15000	0	\N	2025-07-18 16:43:45.040955	2025-07-18 16:43:45.040955
547	Chụp Sứ Hàn	chup su han	cái	2500	0	\N	2025-07-18 16:43:45.042941	2025-07-18 16:43:45.042941
548	Cle 10	cle 10	cái	15000	0	\N	2025-07-18 16:43:45.044986	2025-07-18 16:43:45.044986
549	Cle 13	cle 13	cái	15000	0	\N	2025-07-18 16:43:45.047986	2025-07-18 16:43:45.047986
550	Cle 14	cle 14	cái	17000	0	\N	2025-07-18 16:43:45.050001	2025-07-18 16:43:45.050001
551	Cle 17	cle 17	cái	20000	0	\N	2025-07-18 16:43:45.052986	2025-07-18 16:43:45.052986
552	Cle 23	cle 23	cái	35000	0	\N	2025-07-18 16:43:45.054986	2025-07-18 16:43:45.054986
553	Cle 32	cle 32	cái	45000	0	\N	2025-07-18 16:43:45.057974	2025-07-18 16:43:45.057974
554	Cle 8	cle 8	cái	13000	0	\N	2025-07-18 16:43:45.059518	2025-07-18 16:43:45.059518
555	Cle Lắc 17	cle lac 17	cái	65000	0	\N	2025-07-18 16:43:45.062569	2025-07-18 16:43:45.062569
556	Cle Tự Động 10	cle tu dong 10	cái	40000	0	\N	2025-07-18 16:43:45.064555	2025-07-18 16:43:45.064555
557	Cle Tự Động 14	cle tu dong 14	cái	55000	0	\N	2025-07-18 16:43:45.066555	2025-07-18 16:43:45.066555
558	Cle Tự Động 17	cle tu dong 17	cái	60000	0	\N	2025-07-18 16:43:45.06857	2025-07-18 16:43:45.06857
559	Cle Tự Động 19	cle tu dong 19	cái	65000	0	\N	2025-07-18 16:43:45.070617	2025-07-18 16:43:45.070617
560	Cle Tự Động 8	cle tu dong 8	cái	35000	0	\N	2025-07-18 16:43:45.073619	2025-07-18 16:43:45.073619
561	Cle Tự Động13	cle tu dong13	cái	50000	0	\N	2025-07-18 16:43:45.076603	2025-07-18 16:43:45.076603
562	Clemon	clemon	bộ	150000	0	\N	2025-07-18 16:43:45.079617	2025-07-18 16:43:45.079617
563	Cọ Xe	co xe	cái	10000	0	\N	2025-07-18 16:43:45.082603	2025-07-18 16:43:45.082603
564	Cọ Xong Sắt	co xong sat	cái	4000	0	\N	2025-07-18 16:43:45.085199	2025-07-18 16:43:45.085199
565	Cốc +Nắp Xi Phông	coc +nap xi phong	bộ	50000	0	\N	2025-07-18 16:43:45.0882	2025-07-18 16:43:45.0882
566	Cóc Cáp	coc cap	cái	3000	0	\N	2025-07-18 16:43:45.090199	2025-07-18 16:43:45.090199
567	Cóc Cáp 12	coc cap 12	cái	10000	0	\N	2025-07-18 16:43:45.092199	2025-07-18 16:43:45.092199
568	Cọc Cấp Bệt Khối	coc cap bet khoi	cái	100000	0	\N	2025-07-18 16:43:45.095234	2025-07-18 16:43:45.095234
569	Cốc Chậu Rửa Bát Bé	coc chau rua bat be	cái	45000	0	\N	2025-07-18 16:43:45.098247	2025-07-18 16:43:45.098247
570	Cốc Chậu Rửa Bát To 140	coc chau rua bat to 140	cái	130000	0	\N	2025-07-18 16:43:45.100233	2025-07-18 16:43:45.100233
571	Cọc Chống Sét	coc chong set	cây	55000	0	\N	2025-07-18 16:43:45.102248	2025-07-18 16:43:45.102248
572	Cốc Đánh Răng	coc danh rang	cái	165000	0	\N	2025-07-18 16:43:45.104247	2025-07-18 16:43:45.104247
573	Cọc Đồng 1,5 Mét	coc dong 1,5 met	cái	520000	0	\N	2025-07-18 16:43:45.107233	2025-07-18 16:43:45.107233
574	Cọc Đồng 2 Mét	coc dong 2 met	cái	650000	0	\N	2025-07-18 16:43:45.109785	2025-07-18 16:43:45.109785
575	Cọc Đồng 2.4	coc dong 2.4	cái	950000	0	\N	2025-07-18 16:43:45.111833	2025-07-18 16:43:45.111833
576	Cọc Nhấn Bệt Xanh	coc nhan bet xanh	cái	120000	0	\N	2025-07-18 16:43:45.113819	2025-07-18 16:43:45.113819
577	Cối Inox 5 (Hộp 2 Cái )	coi inox 5 (hop 2 cai )	hộp	50000	0	\N	2025-07-18 16:43:45.115833	2025-07-18 16:43:45.115833
578	Côn 110/160	con 110/160	cái	40000	0	\N	2025-07-18 16:43:45.119833	2025-07-18 16:43:45.119833
579	Côn 125/110	con 125/110	cái	45000	0	\N	2025-07-18 16:43:45.121819	2025-07-18 16:43:45.121819
580	Côn 125/90	con 125/90	cái	35000	0	\N	2025-07-18 16:43:45.123833	2025-07-18 16:43:45.123833
581	Côn 140/90	con 140/90	cái	35000	0	\N	2025-07-18 16:43:45.125833	2025-07-18 16:43:45.125833
582	Côn 150/90	con 150/90	cái	35000	0	\N	2025-07-18 16:43:45.128834	2025-07-18 16:43:45.128834
583	Côn 160/110 R	con 160/110 r	cái	40000	0	\N	2025-07-18 16:43:45.130819	2025-07-18 16:43:45.130819
584	Côn 160/90	con 160/90	cái	45000	0	\N	2025-07-18 16:43:45.132833	2025-07-18 16:43:45.132833
585	Côn 20/15 Inox	con 20/15 inox	cái	20000	0	\N	2025-07-18 16:43:45.135833	2025-07-18 16:43:45.135833
586	Côn Hơi 10/8 Nối Nhanh	con hoi 10/8 noi nhanh	cái	5000	0	\N	2025-07-18 16:43:45.137833	2025-07-18 16:43:45.137833
587	Côn Long 48/34	con long 48/34	cái	6000	0	\N	2025-07-18 16:43:45.140834	2025-07-18 16:43:45.140834
588	Côn Nối Hơi 10/6	con noi hoi 10/6	cái	5000	0	\N	2025-07-18 16:43:45.144833	2025-07-18 16:43:45.144833
589	Con Sơn Inox 20 Cm	con son inox 20 cm	đôi	50000	0	\N	2025-07-18 16:43:45.146866	2025-07-18 16:43:45.146866
590	Côn Thu 140/110	con thu 140/110	cái	35000	0	\N	2025-07-18 16:43:45.14888	2025-07-18 16:43:45.14888
591	Côn Thu 150/110	con thu 150/110	cái	35000	0	\N	2025-07-18 16:43:45.151866	2025-07-18 16:43:45.151866
592	Công Tắc 2 Vị Trí Cn	cong tac 2 vi tri cn	cái	0	0	\N	2025-07-18 16:43:45.152866	2025-07-18 16:43:45.152866
593	Công Tắc Nhót	cong tac nhot	cái	15000	0	\N	2025-07-18 16:43:45.154867	2025-07-18 16:43:45.154867
594	Công Tơ 1 Pha Hm	cong to 1 pha hm	cái	175000	0	\N	2025-07-18 16:43:45.156866	2025-07-18 16:43:45.156866
595	Công Tơ 3Pha	cong to 3pha	cái	700000	0	\N	2025-07-18 16:43:45.15888	2025-07-18 16:43:45.15888
596	Công Tơ Điện Cài 60 A	cong to dien cai 60 a	cái	175000	0	\N	2025-07-18 16:43:45.162438	2025-07-18 16:43:45.162438
597	Công Tơ Điện Tử 1P 5/80A Emic	cong to dien tu 1p 5/80a emic	cái	450000	0	\N	2025-07-18 16:43:45.165436	2025-07-18 16:43:45.165436
598	Cốt Càng Cua 2.5	cot cang cua 2.5	cái	350	0	\N	2025-07-18 16:43:45.168422	2025-07-18 16:43:45.168422
599	Cốt Đồng 10/8	cot dong 10/8	cái	1500	0	\N	2025-07-18 16:43:45.170468	2025-07-18 16:43:45.170468
600	Cốt Đồng 120 Dài	cot dong 120 dai	cái	30000	0	\N	2025-07-18 16:43:45.173454	2025-07-18 16:43:45.173454
601	Cốt Đồng 16/8	cot dong 16/8	cái	2000	0	\N	2025-07-18 16:43:45.176454	2025-07-18 16:43:45.176454
602	Cốt Đồng 25	cot dong 25	cái	3000	0	\N	2025-07-18 16:43:45.178454	2025-07-18 16:43:45.178454
603	Cốt Đồng 25/8	cot dong 25/8	cái	3000	0	\N	2025-07-18 16:43:45.180469	2025-07-18 16:43:45.180469
604	Cốt Đồng 35	cot dong 35	cái	3500	0	\N	2025-07-18 16:43:45.183468	2025-07-18 16:43:45.183468
605	Cốt Đồng 35 Dài	cot dong 35 dai	cái	15000	0	\N	2025-07-18 16:43:45.187018	2025-07-18 16:43:45.187018
606	Cốt Đồng 50 Dài	cot dong 50 dai	cái	12000	0	\N	2025-07-18 16:43:45.191019	2025-07-18 16:43:45.191019
607	Cốt Đồng 6/6	cot dong 6/6	cái	1000	0	\N	2025-07-18 16:43:45.193018	2025-07-18 16:43:45.193018
608	Cốt Đồng 6/8	cot dong 6/8	cái	1000	0	\N	2025-07-18 16:43:45.196053	2025-07-18 16:43:45.196053
609	Cốt Đồng 6-6	cot dong 6-6	cái	1000	0	\N	2025-07-18 16:43:45.200088	2025-07-18 16:43:45.200088
610	Cốt Đồng 70 Dài	cot dong 70 dai	cái	15000	0	\N	2025-07-18 16:43:45.203086	2025-07-18 16:43:45.203086
611	Cốt Đồng 95 - 12	cot dong 95 - 12	cái	15000	0	\N	2025-07-18 16:43:45.205751	2025-07-18 16:43:45.205751
612	Cót Ép	cot ep	tấm	43000	0	\N	2025-07-18 16:43:45.209751	2025-07-18 16:43:45.209751
613	Cốt Kim 1.5	cot kim 1.5	gói	100000	0	\N	2025-07-18 16:43:45.212237	2025-07-18 16:43:45.212237
614	Cốt Kim 10	cot kim 10	cái	2000	0	\N	2025-07-18 16:43:45.21425	2025-07-18 16:43:45.21425
615	Cốt Kim 2.5	cot kim 2.5	cái	350	0	\N	2025-07-18 16:43:45.21626	2025-07-18 16:43:45.21626
617	Cốt Máy Hàn Đồng	cot may han dong	cái	12000	0	\N	2025-07-18 16:43:45.22126	2025-07-18 16:43:45.22126
618	Cốt Nối 16	cot noi 16	cái	2000	0	\N	2025-07-18 16:43:45.222298	2025-07-18 16:43:45.222298
619	Cốt Nối 25	cot noi 25	cái	3000	0	\N	2025-07-18 16:43:45.225594	2025-07-18 16:43:45.225594
620	Cốt Nối 35	cot noi 35	cái	4500	0	\N	2025-07-18 16:43:45.227289	2025-07-18 16:43:45.227289
621	Cốt Nối 6	cot noi 6	cái	1000	0	\N	2025-07-18 16:43:45.230966	2025-07-18 16:43:45.230966
622	Cốt Nối Đồng 10	cot noi dong 10	cái	2000	0	\N	2025-07-18 16:43:45.233999	2025-07-18 16:43:45.233999
623	Cột Nước Bệt	cot nuoc bet	cái	90000	0	\N	2025-07-18 16:43:45.235998	2025-07-18 16:43:45.235998
624	Cốt Rv 2-4 Tròn	cot rv 2-4 tron	cái	250	0	\N	2025-07-18 16:43:45.238999	2025-07-18 16:43:45.238999
625	Cốt Rv 5-5 Tròn	cot rv 5-5 tron	cái	500	0	\N	2025-07-18 16:43:45.241999	2025-07-18 16:43:45.241999
626	Cốt Y 2/4	cot y 2/4	cái	500	0	\N	2025-07-18 16:43:45.243985	2025-07-18 16:43:45.243985
627	Cốt Y 5/5	cot y 5/5	cái	500	0	\N	2025-07-18 16:43:45.245999	2025-07-18 16:43:45.245999
628	Củ Giếng 48	cu gieng 48	cái	65000	0	\N	2025-07-18 16:43:45.248045	2025-07-18 16:43:45.248045
629	Cưa Gỗ Tay	cua go tay	cái	45000	0	\N	2025-07-18 16:43:45.251046	2025-07-18 16:43:45.251046
630	Cưa Thạch Cao	cua thach cao	cái	35000	0	\N	2025-07-18 16:43:45.253321	2025-07-18 16:43:45.253321
631	Cuốc + Cán Sắt	cuoc + can sat	cái	70000	0	\N	2025-07-18 16:43:45.255346	2025-07-18 16:43:45.255346
632	Cước Xây	cuoc xay	con	5000	0	\N	2025-07-18 16:43:45.258347	2025-07-18 16:43:45.258347
633	Cút 50 Inoc	cut 50 inoc	cái	75000	0	\N	2025-07-18 16:43:45.259347	2025-07-18 16:43:45.259347
635	Cút Inoc Rt 1/2	cut inoc rt 1/2	cái	12000	0	\N	2025-07-18 16:43:45.264912	2025-07-18 16:43:45.264912
636	Cút Inox 15	cut inox 15	cái	10000	0	\N	2025-07-18 16:43:45.266911	2025-07-18 16:43:45.266911
637	Cút Inox 26 (34)	cut inox 26 (34)	cái	35000	0	\N	2025-07-18 16:43:45.268912	2025-07-18 16:43:45.268912
638	Cút Inox 3/4 (27)	cut inox 3/4 (27)	cái	20000	0	\N	2025-07-18 16:43:45.269943	2025-07-18 16:43:45.269943
639	Cút Ren Trong 25 Uv Vesbo	cut ren trong 25 uv vesbo	cái	98700	0	\N	2025-07-18 16:43:45.271957	2025-07-18 16:43:45.271957
640	Cút Tẩu 15 (Rt/Rn)	cut tau 15 (rt/rn)	cái	18000	0	\N	2025-07-18 16:43:45.275957	2025-07-18 16:43:45.275957
641	Đá Cắt 100 Hd	da cat 100 hd	viên	7000	0	\N	2025-07-18 16:43:45.276943	2025-07-18 16:43:45.276943
642	Đá Cắt 100 Ls	da cat 100 ls	viên	4000	0	\N	2025-07-18 16:43:45.279959	2025-07-18 16:43:45.279959
643	Đá Cắt 100 Tiger	da cat 100 tiger	viên	5000	0	\N	2025-07-18 16:43:45.281957	2025-07-18 16:43:45.281957
644	Đá Cắt 150 Tiger	da cat 150 tiger	viên	15000	0	\N	2025-07-18 16:43:45.284468	2025-07-18 16:43:45.284468
645	Đá Cắt 350 Sk 1Th-25V	da cat 350 sk 1th-25v	viên	45000	0	\N	2025-07-18 16:43:45.286758	2025-07-18 16:43:45.286758
646	Đá Cắt 350 Tiger	da cat 350 tiger	viên	38000	0	\N	2025-07-18 16:43:45.289767	2025-07-18 16:43:45.289767
647	Đá Cắt 355 Hd Đen	da cat 355 hd den	viên	32000	0	\N	2025-07-18 16:43:45.291766	2025-07-18 16:43:45.291766
648	Đá Mài 100 Hd	da mai 100 hd	viên	7000	0	\N	2025-07-18 16:43:45.293783	2025-07-18 16:43:45.293783
649	Đá Mài 100 Tiger H=25 Viên	da mai 100 tiger h=25 vien	viên	10000	0	\N	2025-07-18 16:43:45.296781	2025-07-18 16:43:45.296781
650	Đá Mài Dao Hd	da mai dao hd	viên	20000	0	\N	2025-07-18 16:43:45.299781	2025-07-18 16:43:45.299781
651	Đai Ôm 110	dai om 110	cái	5000	0	\N	2025-07-18 16:43:45.300781	2025-07-18 16:43:45.300781
652	Đai Ôm 21	dai om 21	cái	1000	0	\N	2025-07-18 16:43:45.303797	2025-07-18 16:43:45.303797
653	Đai Ôm 27	dai om 27	cái	1000	0	\N	2025-07-18 16:43:45.305797	2025-07-18 16:43:45.305797
654	Đai Ôm 34	dai om 34	cái	2000	0	\N	2025-07-18 16:43:45.308797	2025-07-18 16:43:45.308797
655	Đai Ôm 42	dai om 42	cái	2000	0	\N	2025-07-18 16:43:45.309797	2025-07-18 16:43:45.309797
656	Đai Ôm 48	dai om 48	cái	2000	0	\N	2025-07-18 16:43:45.312755	2025-07-18 16:43:45.312755
657	Đai Ôm 60	dai om 60	cái	3000	0	\N	2025-07-18 16:43:45.313755	2025-07-18 16:43:45.313755
658	Đai Ôm 75	dai om 75	cái	4000	0	\N	2025-07-18 16:43:45.315756	2025-07-18 16:43:45.315756
659	Đai Ôm 90	dai om 90	cái	4000	0	\N	2025-07-18 16:43:45.317769	2025-07-18 16:43:45.317769
660	Đai Ốp 60	dai op 60	cái	3000	0	\N	2025-07-18 16:43:45.320754	2025-07-18 16:43:45.320754
661	Đai Treo 110	dai treo 110	cái	8000	0	\N	2025-07-18 16:43:45.322753	2025-07-18 16:43:45.322753
662	Đai Treo 125	dai treo 125	cái	10000	0	\N	2025-07-18 16:43:45.324769	2025-07-18 16:43:45.324769
663	Đai Treo 150	dai treo 150	cái	15000	0	\N	2025-07-18 16:43:45.327769	2025-07-18 16:43:45.327769
664	Đai Treo 21	dai treo 21	cái	4000	0	\N	2025-07-18 16:43:45.330753	2025-07-18 16:43:45.330753
665	Đai Treo 27	dai treo 27	cái	4000	0	\N	2025-07-18 16:43:45.333769	2025-07-18 16:43:45.333769
666	Đai Treo 34	dai treo 34	cái	5000	0	\N	2025-07-18 16:43:45.335769	2025-07-18 16:43:45.335769
667	Đai Treo 42	dai treo 42	cái	5000	0	\N	2025-07-18 16:43:45.33877	2025-07-18 16:43:45.33877
668	Đai Treo 48	dai treo 48	cái	5000	0	\N	2025-07-18 16:43:45.340737	2025-07-18 16:43:45.340737
669	Đai Treo 60	dai treo 60	cái	5000	0	\N	2025-07-18 16:43:45.343765	2025-07-18 16:43:45.343765
670	Đai Treo 75	dai treo 75	cái	6000	0	\N	2025-07-18 16:43:45.345769	2025-07-18 16:43:45.345769
671	Đai Treo 90	dai treo 90	cái	7000	0	\N	2025-07-18 16:43:45.3478	2025-07-18 16:43:45.3478
672	Đai Treo140	dai treo140	cái	14000	0	\N	2025-07-18 16:43:45.350802	2025-07-18 16:43:45.350802
673	Đai Xiết 110	dai xiet 110	cái	10000	0	\N	2025-07-18 16:43:45.3538	2025-07-18 16:43:45.3538
674	Đai Xiết 125	dai xiet 125	cái	12000	0	\N	2025-07-18 16:43:45.355787	2025-07-18 16:43:45.355787
675	Đai Xiết 13/20	dai xiet 13/20	cái	2000	0	\N	2025-07-18 16:43:45.357801	2025-07-18 16:43:45.357801
676	Đai Xiết 140	dai xiet 140	cái	15000	0	\N	2025-07-18 16:43:45.3598	2025-07-18 16:43:45.3598
677	Đai Xiết 160	dai xiet 160	cái	18000	0	\N	2025-07-18 16:43:45.363006	2025-07-18 16:43:45.363006
678	Đai Xiết 21	dai xiet 21	cái	2000	0	\N	2025-07-18 16:43:45.367036	2025-07-18 16:43:45.367036
679	Đai Xiết 21 Có Tay Vặn	dai xiet 21 co tay van	cái	4000	0	\N	2025-07-18 16:43:45.369022	2025-07-18 16:43:45.369022
680	Đai Xiết 27	dai xiet 27	cái	3000	0	\N	2025-07-18 16:43:45.371068	2025-07-18 16:43:45.371068
681	Đai Xiết 27 Có Tay Vặn	dai xiet 27 co tay van	cái	5000	0	\N	2025-07-18 16:43:45.373067	2025-07-18 16:43:45.373067
682	Đai Xiết 34	dai xiet 34	cái	3500	0	\N	2025-07-18 16:43:45.376068	2025-07-18 16:43:45.376068
683	Đai Xiết 42	dai xiet 42	cái	5000	0	\N	2025-07-18 16:43:45.378052	2025-07-18 16:43:45.378052
684	Đai Xiết 48	dai xiet 48	cái	5000	0	\N	2025-07-18 16:43:45.380067	2025-07-18 16:43:45.380067
685	Đai Xiết 60	dai xiet 60	cái	5000	0	\N	2025-07-18 16:43:45.383068	2025-07-18 16:43:45.383068
686	Đai Xiết 75	dai xiet 75	cái	7000	0	\N	2025-07-18 16:43:45.385665	2025-07-18 16:43:45.385665
687	Đai Xiết 90	dai xiet 90	cái	8000	0	\N	2025-07-18 16:43:45.388649	2025-07-18 16:43:45.388649
688	Đai Xiết Inox 200	dai xiet inox 200	cái	20000	0	\N	2025-07-18 16:43:45.391649	2025-07-18 16:43:45.391649
689	Đai Xiết Inox 21	dai xiet inox 21	cái	2000	0	\N	2025-07-18 16:43:45.393663	2025-07-18 16:43:45.393663
690	Đạn F15 Th=40 Hộp	dan f15 th=40 hop	hộp	25000	0	\N	2025-07-18 16:43:45.396649	2025-07-18 16:43:45.396649
691	Đạn F20 Th=30 H	dan f20 th=30 h	hộp	25000	0	\N	2025-07-18 16:43:45.398695	2025-07-18 16:43:45.398695
692	Đạn Ghim F25	dan ghim f25	thùng	540000	0	\N	2025-07-18 16:43:45.401681	2025-07-18 16:43:45.401681
693	Đạn Ghim F30	dan ghim f30	thùng	620000	0	\N	2025-07-18 16:43:45.40268	2025-07-18 16:43:45.40268
694	Đạn Nổ - 200 Cái	dan no - 200 cai	hộp	100000	0	\N	2025-07-18 16:43:45.404681	2025-07-18 16:43:45.404681
695	Đánh Rỉ Máy	danh ri may	cái	8000	0	\N	2025-07-18 16:43:45.406665	2025-07-18 16:43:45.406665
696	Dao Bả	dao ba	cái	10000	0	\N	2025-07-18 16:43:45.40998	2025-07-18 16:43:45.40998
697	Dao Bả Inox	dao ba inox	cái	20000	0	\N	2025-07-18 16:43:45.411014	2025-07-18 16:43:45.411014
698	Dao Cắt Kính	dao cat kinh	cái	125000	0	\N	2025-07-18 16:43:45.413595	2025-07-18 16:43:45.413595
699	Dao Chặt	dao chat	cái	55000	0	\N	2025-07-18 16:43:45.416595	2025-07-18 16:43:45.416595
700	Dao Dọc Giấy Lanlong	dao doc giay lanlong	cái	35000	0	\N	2025-07-18 16:43:45.419568	2025-07-18 16:43:45.419568
701	Dao Dọc Giấy R	dao doc giay r	cái	10000	0	\N	2025-07-18 16:43:45.422595	2025-07-18 16:43:45.422595
702	Dao Trổ Kapusi	dao tro kapusi	cái	10000	0	\N	2025-07-18 16:43:45.424595	2025-07-18 16:43:45.424595
703	Dao Vọ	dao vo	cái	50000	0	\N	2025-07-18 16:43:45.427596	2025-07-18 16:43:45.427596
704	Dao Xay	dao xay	cái	18000	0	\N	2025-07-18 16:43:45.430581	2025-07-18 16:43:45.430581
705	Dầu Bơm Đồng Hồ Th	dau bom dong ho th	cái	145000	0	\N	2025-07-18 16:43:45.433595	2025-07-18 16:43:45.433595
706	Đầu Chuyển Nồi Khoan Rút Lõi	dau chuyen noi khoan rut loi	cái	45000	0	\N	2025-07-18 16:43:45.435581	2025-07-18 16:43:45.435581
707	Đầu Đóng	dau dong	cái	15000	0	\N	2025-07-18 16:43:45.437595	2025-07-18 16:43:45.437595
708	Đầu Hàn 20	dau han 20	cái	25000	0	\N	2025-07-18 16:43:45.441383	2025-07-18 16:43:45.441383
709	Đầu Hần 25	dau han 25	bộ	35000	0	\N	2025-07-18 16:43:45.444671	2025-07-18 16:43:45.444671
710	Đầu Hàn 32	dau han 32	cái	35000	0	\N	2025-07-18 16:43:45.446218	2025-07-18 16:43:45.446218
711	Dầu Han Sự Cố	dau han su co	bộ	100000	0	\N	2025-07-18 16:43:45.44831	2025-07-18 16:43:45.44831
712	Đầu Lọc Máy Rửa Xe	dau loc may rua xe	cái	20000	0	\N	2025-07-18 16:43:45.452545	2025-07-18 16:43:45.452545
713	Đầu Nối Nhanh 8 Thường	dau noi nhanh 8 thuong	cái	15000	0	\N	2025-07-18 16:43:45.455547	2025-07-18 16:43:45.455547
714	Đầu Ren Nối Nhanh	dau ren noi nhanh	cái	15000	0	\N	2025-07-18 16:43:45.45756	2025-07-18 16:43:45.45756
715	Đầu Tôn	dau ton	cái	10000	0	\N	2025-07-18 16:43:45.459547	2025-07-18 16:43:45.459547
716	Đầu Vít	dau vit	cái	10000	0	\N	2025-07-18 16:43:45.461563	2025-07-18 16:43:45.461563
717	Đầu Vít Boss	dau vit boss	cái	15000	0	\N	2025-07-18 16:43:45.46474	2025-07-18 16:43:45.46474
718	Đầu Vít Boss Dài 15 Cm	dau vit boss dai 15 cm	cái	25000	0	\N	2025-07-18 16:43:45.468756	2025-07-18 16:43:45.468756
719	Đầu Vít Dài 1 Cm Tiger	dau vit dai 1 cm tiger	cái	15000	0	\N	2025-07-18 16:43:45.470808	2025-07-18 16:43:45.470808
720	Đầu Vít Đồng Tiger	dau vit dong tiger	cái	10000	0	\N	2025-07-18 16:43:45.472808	2025-07-18 16:43:45.472808
721	Đầu Vít Tiger Xám Ngắn	dau vit tiger xam ngan	cái	10000	0	\N	2025-07-18 16:43:45.475774	2025-07-18 16:43:45.475774
722	Đầu Xịt Rửa Xe Đồng Máy Công Nghiệp	dau xit rua xe dong may cong nghiep	cái	15000	0	\N	2025-07-18 16:43:45.478808	2025-07-18 16:43:45.478808
723	Đầu Xịt Wc	dau xit wc	cái	70000	0	\N	2025-07-18 16:43:45.480808	2025-07-18 16:43:45.480808
724	Dây 1X10 Tiếp Địa	day 1x10 tiep dia	m	35000	0	\N	2025-07-18 16:43:45.483119	2025-07-18 16:43:45.483119
725	Dây 1X2,5 Đỏ	day 1x2,5 do	m	6500	0	\N	2025-07-18 16:43:45.486699	2025-07-18 16:43:45.486699
726	Dây 2X0.5	day 2x0.5	m	2500	0	\N	2025-07-18 16:43:45.488685	2025-07-18 16:43:45.488685
727	Dây 3X4 Ghi Mềm	day 3x4 ghi mem	m	41000	0	\N	2025-07-18 16:43:45.490699	2025-07-18 16:43:45.490699
728	Dây 4X4 Ghi	day 4x4 ghi	m	50000	0	\N	2025-07-18 16:43:45.493685	2025-07-18 16:43:45.493685
729	Dây Bảo Hiểm	day bao hiem	cái	90000	0	\N	2025-07-18 16:43:45.495692	2025-07-18 16:43:45.495692
730	Dây Bơm 27	day bom 27	cuộn	250000	0	\N	2025-07-18 16:43:45.498694	2025-07-18 16:43:45.498694
731	Dây Bơm 34 Xanh	day bom 34 xanh	m	11000	0	\N	2025-07-18 16:43:45.500696	2025-07-18 16:43:45.500696
732	Dây Bơm Nâu 21 ( 7 Kg)	day bom nau 21 ( 7 kg)	cuộn	250000	0	\N	2025-07-18 16:43:45.50271	2025-07-18 16:43:45.50271
733	Dây Bơm Phú Thịnh	day bom phu thinh	m	15000	0	\N	2025-07-18 16:43:45.505694	2025-07-18 16:43:45.505694
734	Dây Bơm Trắng	day bom trang	m	10000	0	\N	2025-07-18 16:43:45.50971	2025-07-18 16:43:45.50971
735	Dây Bơm Trắng 21	day bom trang 21	m	10000	0	\N	2025-07-18 16:43:45.511696	2025-07-18 16:43:45.511696
736	Dây Buộc Nilong	day buoc nilong	cuộn	20000	0	\N	2025-07-18 16:43:45.513226	2025-07-18 16:43:45.513226
737	Dây Cấp 1 M Tkt	day cap 1 m tkt	cái	60000	0	\N	2025-07-18 16:43:45.515275	2025-07-18 16:43:45.515275
738	Dây Cấp 20 Cm	day cap 20 cm	cái	26000	0	\N	2025-07-18 16:43:45.51926	2025-07-18 16:43:45.51926
739	Dây Cáp 2X10	day cap 2x10	m	70000	0	\N	2025-07-18 16:43:45.522258	2025-07-18 16:43:45.522258
740	Dây Cấp 30	day cap 30	cái	35000	0	\N	2025-07-18 16:43:45.524275	2025-07-18 16:43:45.524275
741	Dây Cấp 40 Charto Tốt	day cap 40 charto tot	cái	45000	0	\N	2025-07-18 16:43:45.526275	2025-07-18 16:43:45.526275
742	Dây Cấp 40 Cm	day cap 40 cm	cái	40000	0	\N	2025-07-18 16:43:45.529245	2025-07-18 16:43:45.529245
743	Dây Cấp 40 Cm Lò Xo	day cap 40 cm lo xo	cái	40000	0	\N	2025-07-18 16:43:45.532258	2025-07-18 16:43:45.532258
744	Dây Cấp 40 Cm Tkt	day cap 40 cm tkt	cái	45000	0	\N	2025-07-18 16:43:45.534275	2025-07-18 16:43:45.534275
745	Dây Cáp 4X10	day cap 4x10	m	130000	0	\N	2025-07-18 16:43:45.536274	2025-07-18 16:43:45.536274
746	Dây Cáp 4X6	day cap 4x6	m	95000	0	\N	2025-07-18 16:43:45.538275	2025-07-18 16:43:45.538275
747	Dây Cấp 60 Sanwa	day cap 60 sanwa	cái	25000	0	\N	2025-07-18 16:43:45.541259	2025-07-18 16:43:45.541259
748	Dây Cấp 60 Tkt	day cap 60 tkt	cái	50000	0	\N	2025-07-18 16:43:45.544259	2025-07-18 16:43:45.544259
749	Dây Cấp 80 Cm Tkt	day cap 80 cm tkt	cái	60000	0	\N	2025-07-18 16:43:45.546275	2025-07-18 16:43:45.546275
750	Dây Cấp Kim 60 Tkt	day cap kim 60 tkt	cái	40000	0	\N	2025-07-18 16:43:45.548323	2025-07-18 16:43:45.548323
751	Dây Cấp Lò Xo 60	day cap lo xo 60	cái	50000	0	\N	2025-07-18 16:43:45.551331	2025-07-18 16:43:45.551331
752	Dây Cáp Mạ	day cap ma	m	3000	0	\N	2025-07-18 16:43:45.55331	2025-07-18 16:43:45.55331
753	Dây Cấp Máy Giặt	day cap may giat	cái	50000	0	\N	2025-07-18 16:43:45.55531	2025-07-18 16:43:45.55531
754	Dây Cáp Quang	day cap quang	m	3000	0	\N	2025-07-18 16:43:45.558324	2025-07-18 16:43:45.558324
755	Dây Chun	day chun	cái	15000	0	\N	2025-07-18 16:43:45.560324	2025-07-18 16:43:45.560324
756	Dây Cô Loa	day co loa	cái	30000	0	\N	2025-07-18 16:43:45.562867	2025-07-18 16:43:45.562867
757	Dây Cualoa B56	day cualoa b56	cái	30000	0	\N	2025-07-18 16:43:45.56488	2025-07-18 16:43:45.56488
758	Dây Đay	day day	lần	0	0	\N	2025-07-18 16:43:45.567902	2025-07-18 16:43:45.567902
759	Dây Điện Thoại 4 Lõi	day dien thoai 4 loi	m	4500	0	\N	2025-07-18 16:43:45.569965	2025-07-18 16:43:45.569965
760	Dây Dù Xanh	day du xanh	kg	70000	0	\N	2025-07-18 16:43:45.571965	2025-07-18 16:43:45.571965
761	Dây Đui 5 Mét Đq	day dui 5 met dq	bộ	50000	0	\N	2025-07-18 16:43:45.575949	2025-07-18 16:43:45.575949
762	Dây Hàn 0.8 Kim Tín Gs	day han 0.8 kim tin gs	cuộn	550000	0	\N	2025-07-18 16:43:45.57695	2025-07-18 16:43:45.57695
763	Dây Hàn 08 Gs 15 Kg	day han 08 gs 15 kg	kiện	570000	0	\N	2025-07-18 16:43:45.579965	2025-07-18 16:43:45.579965
764	Dây Hàn 16 Jmel	day han 16 jmel	m	50000	0	\N	2025-07-18 16:43:45.581932	2025-07-18 16:43:45.581932
765	Dây Hàn Phi 25 Mm	day han phi 25 mm	m	70000	0	\N	2025-07-18 16:43:45.584929	2025-07-18 16:43:45.584929
766	Dây Hơi 10	day hoi 10	m	8000	0	\N	2025-07-18 16:43:45.586983	2025-07-18 16:43:45.586983
767	Dây Hơi 12	day hoi 12	m	10000	0	\N	2025-07-18 16:43:45.590005	2025-07-18 16:43:45.590005
768	Dây Hơi 6	day hoi 6	cái	5000	0	\N	2025-07-18 16:43:45.592007	2025-07-18 16:43:45.592007
769	Dây Hơi 8	day hoi 8	m	6000	0	\N	2025-07-18 16:43:45.594021	2025-07-18 16:43:45.594021
770	Dây Hơi Đôi Khí Oxi 6	day hoi doi khi oxi 6	m	25000	0	\N	2025-07-18 16:43:45.597021	2025-07-18 16:43:45.597021
771	Dây Inox 1 Ly 304	day inox 1 ly 304	kg	120000	0	\N	2025-07-18 16:43:45.599013	2025-07-18 16:43:45.599013
772	Dây Inox 1,5 Ly 304	day inox 1,5 ly 304	kg	110000	0	\N	2025-07-18 16:43:45.602018	2025-07-18 16:43:45.602018
773	Dây Inox 2 Ly 304	day inox 2 ly 304	kg	110000	0	\N	2025-07-18 16:43:45.604029	2025-07-18 16:43:45.604029
774	Dây Khóa Xe Mét	day khoa xe met	m	15000	0	\N	2025-07-18 16:43:45.606028	2025-07-18 16:43:45.606028
775	Dây Led 1 Hàng	day led 1 hang	cuộn	200000	0	\N	2025-07-18 16:43:45.608992	2025-07-18 16:43:45.608992
776	Dây Led 3 Hàng Trắng	day led 3 hang trang	m	20000	0	\N	2025-07-18 16:43:45.611029	2025-07-18 16:43:45.611029
777	Dây Led 3 Hàng Vàng	day led 3 hang vang	m	20000	0	\N	2025-07-18 16:43:45.613015	2025-07-18 16:43:45.613015
778	Dây Led Rạng Đông Sáng Vàng	day led rang dong sang vang	m	40000	0	\N	2025-07-18 16:43:45.615316	2025-07-18 16:43:45.615316
779	Dây Loa	day loa	m	8000	0	\N	2025-07-18 16:43:45.618303	2025-07-18 16:43:45.618303
780	Dây Mạng Cat5	day mang cat5	m	8000	0	\N	2025-07-18 16:43:45.621316	2025-07-18 16:43:45.621316
781	Dây Mạng Cat6	day mang cat6	m	10000	0	\N	2025-07-18 16:43:45.622316	2025-07-18 16:43:45.622316
782	Dây Máy Lọc Bé	day may loc be	m	5000	0	\N	2025-07-18 16:43:45.625332	2025-07-18 16:43:45.625332
783	Dây Máy Lọc Phi 10	day may loc phi 10	m	5000	0	\N	2025-07-18 16:43:45.627332	2025-07-18 16:43:45.627332
784	Dây Mồi 10 M Nhựa	day moi 10 m nhua	cái	55000	0	\N	2025-07-18 16:43:45.630316	2025-07-18 16:43:45.630316
785	Dây Mồi 15 M	day moi 15 m	cái	225000	0	\N	2025-07-18 16:43:45.633318	2025-07-18 16:43:45.633318
786	Dây Mồi 20 M	day moi 20 m	cái	300000	0	\N	2025-07-18 16:43:45.635319	2025-07-18 16:43:45.635319
787	Dây Mồi 5 M Nhựa	day moi 5 m nhua	cái	45000	0	\N	2025-07-18 16:43:45.637332	2025-07-18 16:43:45.637332
788	Dây Mồi Cáp 15 Mét	day moi cap 15 met	cái	150000	0	\N	2025-07-18 16:43:45.639332	2025-07-18 16:43:45.639332
789	Dây Mồi Nhựa 15 M Kachi	day moi nhua 15 m kachi	cái	65000	0	\N	2025-07-18 16:43:45.642314	2025-07-18 16:43:45.642314
790	Dây Mồi Nhựa 20	day moi nhua 20	cái	75000	0	\N	2025-07-18 16:43:45.644318	2025-07-18 16:43:45.644318
791	Dây Mồi Thép 10 M	day moi thep 10 m	cái	150000	0	\N	2025-07-18 16:43:45.645318	2025-07-18 16:43:45.645318
792	Dây Mồi Thép 5 M	day moi thep 5 m	cái	75000	0	\N	2025-07-18 16:43:45.647318	2025-07-18 16:43:45.647318
793	Dây Nồi Cơm	day noi com	cái	35000	0	\N	2025-07-18 16:43:45.649349	2025-07-18 16:43:45.649349
794	Dây Sen	day sen	cái	90000	0	\N	2025-07-18 16:43:45.65233	2025-07-18 16:43:45.65233
795	Dây Sen + Bát	day sen + bat	bộ	150000	0	\N	2025-07-18 16:43:45.656461	2025-07-18 16:43:45.656461
796	Dây Thép 0.5 Ly	day thep 0.5 ly	kg	50000	0	\N	2025-07-18 16:43:45.658349	2025-07-18 16:43:45.658349
797	Dây Thít	day thit	gói	30000	0	\N	2025-07-18 16:43:45.660364	2025-07-18 16:43:45.660364
798	Dây Thít 20 Cm	day thit 20 cm	gói	35000	0	\N	2025-07-18 16:43:45.662326	2025-07-18 16:43:45.662326
799	Dây Thít 30 Cm	day thit 30 cm	gói	30000	0	\N	2025-07-18 16:43:45.665006	2025-07-18 16:43:45.665006
800	Dây Thít 35 Cm - 250 Gam	day thit 35 cm - 250 gam	gói	30000	0	\N	2025-07-18 16:43:45.667873	2025-07-18 16:43:45.667873
801	Dây Thít 40 Cm	day thit 40 cm	gói	30000	0	\N	2025-07-18 16:43:45.667873	2025-07-18 16:43:45.667873
802	Dây Thít 50 Cm	day thit 50 cm	gói	65000	0	\N	2025-07-18 16:43:45.672202	2025-07-18 16:43:45.672202
803	Dây Thít Đen	day thit den	gói	35000	0	\N	2025-07-18 16:43:45.675165	2025-07-18 16:43:45.675165
804	Dây Thít Đen 4X200	day thit den 4x200	kg	120000	0	\N	2025-07-18 16:43:45.678186	2025-07-18 16:43:45.678186
805	Dây Thít Trắng 4X200	day thit trang 4x200	kg	100000	0	\N	2025-07-18 16:43:45.680187	2025-07-18 16:43:45.680187
806	Dây Thoát Máy Dặt	day thoat may dat	m	15000	0	\N	2025-07-18 16:43:45.681188	2025-07-18 16:43:45.681188
807	Dây Thông Tắc 10 Mét	day thong tac 10 met	cái	140000	0	\N	2025-07-18 16:43:45.683201	2025-07-18 16:43:45.683201
808	Dây Thông Tắc 3 Mét	day thong tac 3 met	cái	45000	0	\N	2025-07-18 16:43:45.687645	2025-07-18 16:43:45.687645
809	Dây Thông Tắc 9M	day thong tac 9m	cái	130000	0	\N	2025-07-18 16:43:45.688644	2025-07-18 16:43:45.688644
810	Dây Thừng	day thung	kg	25000	0	\N	2025-07-18 16:43:45.690645	2025-07-18 16:43:45.690645
811	Dây Tiếp Địa 1X50	day tiep dia 1x50	m	132000	0	\N	2025-07-18 16:43:45.693645	2025-07-18 16:43:45.693645
812	Dây Tivi	day tivi	m	5000	0	\N	2025-07-18 16:43:45.694642	2025-07-18 16:43:45.694642
813	Dây Xit	day xit	cái	95000	0	\N	2025-07-18 16:43:45.697634	2025-07-18 16:43:45.697634
814	Dây Xịt Rửa Xe 15 M Tiger	day xit rua xe 15 m tiger	cái	270000	0	\N	2025-07-18 16:43:45.699713	2025-07-18 16:43:45.699713
815	Dây Xịt Rửa Xe 20 M	day xit rua xe 20 m	cái	360000	0	\N	2025-07-18 16:43:45.701712	2025-07-18 16:43:45.701712
816	Dây Xịt Rửa Xe 20 Mét	day xit rua xe 20 met	cuộn	360000	0	\N	2025-07-18 16:43:45.703712	2025-07-18 16:43:45.703712
817	Đế Âm Đôi	de am doi	cái	8000	0	\N	2025-07-18 16:43:45.706713	2025-07-18 16:43:45.706713
818	Đế Âm Đơn	de am don	cái	3000	0	\N	2025-07-18 16:43:45.709713	2025-07-18 16:43:45.709713
819	Đế Âm Vuông	de am vuong	cái	5000	0	\N	2025-07-18 16:43:45.711712	2025-07-18 16:43:45.711712
820	Đế Át	de at	cái	5000	0	\N	2025-07-18 16:43:45.714228	2025-07-18 16:43:45.714228
821	Đế Nổi Lioa	de noi lioa	cái	5000	0	\N	2025-07-18 16:43:45.716277	2025-07-18 16:43:45.716277
822	Đem Sưởi 2 Bóng Điều Khiển Kottman K9R	dem suoi 2 bong dieu khien kottman k9r	cái	1150000	0	\N	2025-07-18 16:43:45.719244	2025-07-18 16:43:45.719244
823	Đèn 2 Đầu Effen	den 2 dau effen	cái	320000	0	\N	2025-07-18 16:43:45.722277	2025-07-18 16:43:45.722277
824	Đèn Báo Pha Xanh	den bao pha xanh	cái	8000	0	\N	2025-07-18 16:43:45.724276	2025-07-18 16:43:45.724276
825	Đèn Báo Pha Xanh Đỏ	den bao pha xanh do	cái	8000	0	\N	2025-07-18 16:43:45.727277	2025-07-18 16:43:45.727277
826	Đèn Bắt Muỗi 02 Điện Quang	den bat muoi 02 dien quang	cái	195000	0	\N	2025-07-18 16:43:45.730244	2025-07-18 16:43:45.730244
827	Đèn Bầu Dục 10W 1	den bau duc 10w 1	cái	95000	0	\N	2025-07-18 16:43:45.732261	2025-07-18 16:43:45.732261
828	Đèn Dl 12W Nano	den dl 12w nano	cái	100000	0	\N	2025-07-18 16:43:45.734277	2025-07-18 16:43:45.734277
829	Đèn Dl 3 Màu 90/9 Vv	den dl 3 mau 90/9 vv	cái	102000	0	\N	2025-07-18 16:43:45.737278	2025-07-18 16:43:45.737278
830	Đèn Dl 90/10 W 4000 K	den dl 90/10 w 4000 k	cái	85000	0	\N	2025-07-18 16:43:45.739277	2025-07-18 16:43:45.739277
831	Đèn Dl 90/7 W Trắng Dat 04	den dl 90/7 w trang dat 04	cái	80000	0	\N	2025-07-18 16:43:45.742253	2025-07-18 16:43:45.742253
832	Đèn Dl 90/9 W Tlc Tos	den dl 90/9 w tlc tos	cái	115000	0	\N	2025-07-18 16:43:45.745277	2025-07-18 16:43:45.745277
833	Đèn Dl Tlc 110/12 W	den dl tlc 110/12 w	cái	222000	0	\N	2025-07-18 16:43:45.747277	2025-07-18 16:43:45.747277
834	Đèn Đồng	den dong	cái	900000	0	\N	2025-07-18 16:43:45.750309	2025-07-18 16:43:45.750309
835	Đèn Dowlight 110/12W Vàng 3000K	den dowlight 110/12w vang 3000k	cái	100000	0	\N	2025-07-18 16:43:45.753302	2025-07-18 16:43:45.753302
836	Đèn Dowlight 3 Màu 110/12W	den dowlight 3 mau 110/12w	cái	120000	0	\N	2025-07-18 16:43:45.756308	2025-07-18 16:43:45.756308
837	Đèn Exit	den exit	cái	185000	0	\N	2025-07-18 16:43:45.758294	2025-07-18 16:43:45.758294
838	Đèn Hắt 3 Tia	den hat 3 tia	cái	165000	0	\N	2025-07-18 16:43:45.759294	2025-07-18 16:43:45.759294
839	Đèn Hắt Nanoco	den hat nanoco	cái	180000	0	\N	2025-07-18 16:43:45.762309	2025-07-18 16:43:45.762309
840	Đèn Hắt Vuông-Sáng Vàng	den hat vuong-sang vang	cái	260000	0	\N	2025-07-18 16:43:45.76384	2025-07-18 16:43:45.76384
841	Đèn Ngủ	den ngu	cái	165000	0	\N	2025-07-18 16:43:45.766888	2025-07-18 16:43:45.766888
842	Đèn Ốp Trang Tri	den op trang tri	cái	380000	0	\N	2025-07-18 16:43:45.768888	2025-07-18 16:43:45.768888
843	Đèn Ốp Trang Trí Phi 500	den op trang tri phi 500	cái	870000	0	\N	2025-07-18 16:43:45.771928	2025-07-18 16:43:45.771928
844	Đèn Panel 18W Phi 205 Tlc	den panel 18w phi 205 tlc	cái	135000	0	\N	2025-07-18 16:43:45.773898	2025-07-18 16:43:45.773898
845	Đèn Pin 4151	den pin 4151	cái	60000	0	\N	2025-07-18 16:43:45.776912	2025-07-18 16:43:45.776912
846	Đèn Pin 8796	den pin 8796	cái	50000	0	\N	2025-07-18 16:43:45.778927	2025-07-18 16:43:45.778927
847	Đèn Pin 9035	den pin 9035	cái	60000	0	\N	2025-07-18 16:43:45.780927	2025-07-18 16:43:45.780927
848	Đèn Pin 9123	den pin 9123	cái	43000	0	\N	2025-07-18 16:43:45.783928	2025-07-18 16:43:45.783928
849	Đèn Pin Đội Đầu Di Đẹp	den pin doi dau di dep	cái	60000	0	\N	2025-07-18 16:43:45.786539	2025-07-18 16:43:45.786539
850	Đèn Pin Siêu Sáng Ak	den pin sieu sang ak	cái	165000	0	\N	2025-07-18 16:43:45.788508	2025-07-18 16:43:45.788508
851	Đèn Pin Siêu Sáng Bé	den pin sieu sang be	cái	110000	0	\N	2025-07-18 16:43:45.790524	2025-07-18 16:43:45.790524
852	Đèn Sân Vườn 40 Cm	den san vuon 40 cm	cái	300000	0	\N	2025-07-18 16:43:45.792524	2025-07-18 16:43:45.792524
853	Đèn Spot Light D 55 Dlv	den spot light d 55 dlv	cái	76000	0	\N	2025-07-18 16:43:45.796511	2025-07-18 16:43:45.796511
854	Đèn Spotlight Phi 76 Dvl	den spotlight phi 76 dvl	cái	80000	0	\N	2025-07-18 16:43:45.798974	2025-07-18 16:43:45.798974
855	Đèn Sự Cố	den su co	cái	350000	0	\N	2025-07-18 16:43:45.801019	2025-07-18 16:43:45.801019
856	Đèn Sưởi 4 Bóng Đk Hbre	den suoi 4 bong dk hbre	cái	1650000	0	\N	2025-07-18 16:43:45.803033	2025-07-18 16:43:45.803033
857	Đèn Sưởi Âm Trần 2 Bóng Kotman	den suoi am tran 2 bong kotman	cái	860000	0	\N	2025-07-18 16:43:45.805032	2025-07-18 16:43:45.805032
858	Đèn Sưởi Treo 2 Bóng Kotman	den suoi treo 2 bong kotman	cái	750000	0	\N	2025-07-18 16:43:45.808034	2025-07-18 16:43:45.808034
859	Đèn Sưởi Treo 3 Bóng	den suoi treo 3 bong	cái	850000	0	\N	2025-07-18 16:43:45.811033	2025-07-18 16:43:45.811033
860	Đèn Tê 5X1,2 M Tàu	den te 5x1,2 m tau	cái	50000	0	\N	2025-07-18 16:43:45.814032	2025-07-18 16:43:45.814032
861	Đèn Thờ Dầu	den tho dau	cái	150000	0	\N	2025-07-18 16:43:45.816454	2025-07-18 16:43:45.816454
862	Đèn Trang Trí	den trang tri	cái	500000	0	\N	2025-07-18 16:43:45.818452	2025-07-18 16:43:45.818452
863	Đèn Tranh	den tranh	cái	400000	0	\N	2025-07-18 16:43:45.821453	2025-07-18 16:43:45.821453
864	Đèn Trụ Cổng 400X400	den tru cong 400x400	cái	520000	0	\N	2025-07-18 16:43:45.823452	2025-07-18 16:43:45.823452
865	Dịch Tâm Bệt	dich tam bet	cái	95000	0	\N	2025-07-18 16:43:45.825452	2025-07-18 16:43:45.825452
866	Điếu Đen	dieu den	cái	40000	0	\N	2025-07-18 16:43:45.82844	2025-07-18 16:43:45.82844
867	Đinh 1	dinh 1	kg	35000	0	\N	2025-07-18 16:43:45.830467	2025-07-18 16:43:45.830467
868	Đinh 3 Đen	dinh 3 den	kg	22000	0	\N	2025-07-18 16:43:45.832452	2025-07-18 16:43:45.832452
869	Đinh 5 Đen	dinh 5 den	kg	20000	0	\N	2025-07-18 16:43:45.835452	2025-07-18 16:43:45.835452
870	Đinh 7 Đen	dinh 7 den	kg	20000	0	\N	2025-07-18 16:43:45.837452	2025-07-18 16:43:45.837452
871	Đinh Bê Tông 2 Cm	dinh be tong 2 cm	kg	32000	0	\N	2025-07-18 16:43:45.840451	2025-07-18 16:43:45.840451
872	Đinh Bê Tông 4 Cm	dinh be tong 4 cm	kg	32000	0	\N	2025-07-18 16:43:45.843452	2025-07-18 16:43:45.843452
873	Đinh Bê Tông 5 Cm	dinh be tong 5 cm	kg	32000	0	\N	2025-07-18 16:43:45.845453	2025-07-18 16:43:45.845453
874	Đinh Bê Tông Vàng	dinh be tong vang	kg	50000	0	\N	2025-07-18 16:43:45.847452	2025-07-18 16:43:45.847452
875	Đinh Bt	dinh bt	kg	35000	0	\N	2025-07-18 16:43:45.849452	2025-07-18 16:43:45.849452
876	Đinh Bt 2 Cm	dinh bt 2 cm	kg	35000	0	\N	2025-07-18 16:43:45.851493	2025-07-18 16:43:45.851493
877	Đinh Bt 3 Cm	dinh bt 3 cm	kg	35000	0	\N	2025-07-18 16:43:45.853486	2025-07-18 16:43:45.853486
878	Đinh Bt 4 Cm	dinh bt 4 cm	kg	32000	0	\N	2025-07-18 16:43:45.857499	2025-07-18 16:43:45.857499
879	Đinh Bt 5 Cm	dinh bt 5 cm	kg	32000	0	\N	2025-07-18 16:43:45.861499	2025-07-18 16:43:45.861499
880	Đinh Bt 7 Cm	dinh bt 7 cm	kg	32000	0	\N	2025-07-18 16:43:45.8645	2025-07-18 16:43:45.8645
881	Đinh Bt Bắn Súng F25	dinh bt ban sung f25	hộp	240000	0	\N	2025-07-18 16:43:45.867021	2025-07-18 16:43:45.867021
882	Đinh Bt Bắn Súng F50	dinh bt ban sung f50	hộp	500000	0	\N	2025-07-18 16:43:45.868876	2025-07-18 16:43:45.868876
883	Đinh Bt Vàng 2 Cm	dinh bt vang 2 cm	kg	40000	0	\N	2025-07-18 16:43:45.870882	2025-07-18 16:43:45.870882
884	Đinh F 30 - 19 Kg	dinh f 30 - 19 kg	hộp	35000	0	\N	2025-07-18 16:43:45.873883	2025-07-18 16:43:45.873883
885	Đinh Ghim U	dinh ghim u	hộp	30000	0	\N	2025-07-18 16:43:45.876885	2025-07-18 16:43:45.876885
886	Đinh Rút 3	dinh rut 3	kg	45000	0	\N	2025-07-18 16:43:45.878465	2025-07-18 16:43:45.878465
887	Đinh Rút 4	dinh rut 4	gói	50000	0	\N	2025-07-18 16:43:45.88146	2025-07-18 16:43:45.88146
888	Đinh Rút 5	dinh rut 5	kg	50000	0	\N	2025-07-18 16:43:45.883175	2025-07-18 16:43:45.883175
889	Đinh Rút 5 Fc	dinh rut 5 fc	kg	50000	0	\N	2025-07-18 16:43:45.886819	2025-07-18 16:43:45.886819
890	Đinh Rút Nhôm	dinh rut nhom	kg	45000	0	\N	2025-07-18 16:43:45.889357	2025-07-18 16:43:45.889357
891	Đinh Rút Nhôm 5	dinh rut nhom 5	kg	50000	0	\N	2025-07-18 16:43:45.891416	2025-07-18 16:43:45.891416
892	Đinh St 25	dinh st 25	hộp	40000	0	\N	2025-07-18 16:43:45.894434	2025-07-18 16:43:45.894434
893	Đinh St 32	dinh st 32	hộp	50000	0	\N	2025-07-18 16:43:45.89742	2025-07-18 16:43:45.89742
894	Đinh U 1013	dinh u 1013	thùng	570000	0	\N	2025-07-18 16:43:45.899433	2025-07-18 16:43:45.899433
895	Đổi Nguồn 1000 Va 110/220 V	doi nguon 1000 va 110/220 v	cái	650000	0	\N	2025-07-18 16:43:45.901465	2025-07-18 16:43:45.901465
896	Đổi Nguồn 1200 Va	doi nguon 1200 va	cái	700000	0	\N	2025-07-18 16:43:45.903479	2025-07-18 16:43:45.903479
967	Ghen Cam 50/40	ghen cam 50/40	m	18000	0	\N	2025-07-18 16:43:46.080302	2025-07-18 16:43:46.080302
897	Đổi Nguồn 1500 Va Lioa 110/220 V	doi nguon 1500 va lioa 110/220 v	cái	800000	0	\N	2025-07-18 16:43:45.906481	2025-07-18 16:43:45.906481
898	Đổi Nguồn 220V / 12 V Baren	doi nguon 220v / 12 v baren	cái	220000	0	\N	2025-07-18 16:43:45.909464	2025-07-18 16:43:45.909464
899	Đổi Nguồn 600 Va Lioa 110/220 V	doi nguon 600 va lioa 110/220 v	cái	550000	0	\N	2025-07-18 16:43:45.911465	2025-07-18 16:43:45.911465
900	Đổi Nguồn Lioa 200 Va	doi nguon lioa 200 va	cái	297000	0	\N	2025-07-18 16:43:45.915012	2025-07-18 16:43:45.915012
901	Đổi Nguồn Lioa 400 Va	doi nguon lioa 400 va	cái	425000	0	\N	2025-07-18 16:43:45.917045	2025-07-18 16:43:45.917045
902	Động Cơ Tời	dong co toi	cái	1900000	0	\N	2025-07-18 16:43:45.919062	2025-07-18 16:43:45.919062
903	Đồng Hồ Áp	dong ho ap	cái	120000	0	\N	2025-07-18 16:43:45.921045	2025-07-18 16:43:45.921045
904	Đồng Hồ Điện 1 Pha Hm	dong ho dien 1 pha hm	cái	170000	0	\N	2025-07-18 16:43:45.92306	2025-07-18 16:43:45.92306
905	Đồng Hồ Điện 1Pha Emic	dong ho dien 1pha emic	cái	145000	0	\N	2025-07-18 16:43:45.926059	2025-07-18 16:43:45.926059
906	Đông Hồ Điện Emic Xịn	dong ho dien emic xin	cái	420000	0	\N	2025-07-18 16:43:45.929044	2025-07-18 16:43:45.929044
907	Đồng Hồ Ga Richu	dong ho ga richu	cái	240000	0	\N	2025-07-18 16:43:45.931045	2025-07-18 16:43:45.931045
908	Đồng Hồ Nước Sanwa	dong ho nuoc sanwa	cái	430000	0	\N	2025-07-18 16:43:45.933059	2025-07-18 16:43:45.933059
909	Đồng Hồ Nước Vnec	dong ho nuoc vnec	cái	160000	0	\N	2025-07-18 16:43:45.936059	2025-07-18 16:43:45.936059
910	Đồng Hồ Nước Vnec 20- Th=10	dong ho nuoc vnec 20- th=10	cái	170000	0	\N	2025-07-18 16:43:45.938059	2025-07-18 16:43:45.938059
911	Đồng Hồ Oxi	dong ho oxi	cái	240000	0	\N	2025-07-18 16:43:45.941065	2025-07-18 16:43:45.941065
912	Dù Xanh Tròn Nhỏ	du xanh tron nho	m	2000	0	\N	2025-07-18 16:43:45.944044	2025-07-18 16:43:45.944044
913	Dũa Tròn	dua tron	cái	20000	0	\N	2025-07-18 16:43:45.946061	2025-07-18 16:43:45.946061
914	Đục 14 Bản To	duc 14 ban to	cái	55000	0	\N	2025-07-18 16:43:45.948045	2025-07-18 16:43:45.948045
915	Đục 17 Bản To	duc 17 ban to	cái	50000	0	\N	2025-07-18 16:43:45.950059	2025-07-18 16:43:45.950059
916	Đục 17 Bogo	duc 17 bogo	cái	60000	0	\N	2025-07-18 16:43:45.953105	2025-07-18 16:43:45.953105
917	Đục Bạt Gỗ	duc bat go	cái	20000	0	\N	2025-07-18 16:43:45.956092	2025-07-18 16:43:45.956092
918	Đục Đại Tiger	duc dai tiger	cái	120000	0	\N	2025-07-18 16:43:45.958106	2025-07-18 16:43:45.958106
919	Đục Gỗ	duc go	cái	30000	0	\N	2025-07-18 16:43:45.960106	2025-07-18 16:43:45.960106
920	Đục Tay Sắt	duc tay sat	cái	15000	0	\N	2025-07-18 16:43:45.962106	2025-07-18 16:43:45.962106
921	Đục Tiger 14	duc tiger 14	cái	30000	0	\N	2025-07-18 16:43:45.965576	2025-07-18 16:43:45.965576
922	Đục Tiger 17	duc tiger 17	cái	40000	0	\N	2025-07-18 16:43:45.967607	2025-07-18 16:43:45.967607
923	Đui Cắm Sapoka	dui cam sapoka	cái	25000	0	\N	2025-07-18 16:43:45.969623	2025-07-18 16:43:45.969623
924	Đui Dây Trang Trí Sợi 5 Mét	dui day trang tri soi 5 met	bộ	120000	0	\N	2025-07-18 16:43:45.971655	2025-07-18 16:43:45.971655
925	Đùi Gà	dui ga	cái	100000	0	\N	2025-07-18 16:43:45.975641	2025-07-18 16:43:45.975641
926	Dũi Sơn	dui son	cái	20000	0	\N	2025-07-18 16:43:45.978656	2025-07-18 16:43:45.978656
927	Đui Sứ	dui su	cái	7000	0	\N	2025-07-18 16:43:45.980641	2025-07-18 16:43:45.980641
928	Đui Thả Dây 1 Mét	dui tha day 1 met	bộ	16000	0	\N	2025-07-18 16:43:45.982655	2025-07-18 16:43:45.982655
929	Đui Trang Trí 5 Mét	dui trang tri 5 met	bộ	120000	0	\N	2025-07-18 16:43:45.985656	2025-07-18 16:43:45.985656
930	Đui Trang Trí Dây 10M / 1 Sợi	dui trang tri day 10m / 1 soi	bộ	170000	0	\N	2025-07-18 16:43:45.98718	2025-07-18 16:43:45.98718
931	Đui Treo	dui treo	cái	5000	0	\N	2025-07-18 16:43:45.989285	2025-07-18 16:43:45.989285
932	Đui Treo Thường	dui treo thuong	cái	5000	0	\N	2025-07-18 16:43:45.993269	2025-07-18 16:43:45.993269
933	Đui Treo Tốt - Sứ	dui treo tot - su	cái	15000	0	\N	2025-07-18 16:43:45.997285	2025-07-18 16:43:45.997285
934	Đui Vát	dui vat	cái	10000	0	\N	2025-07-18 16:43:46.001288	2025-07-18 16:43:46.001288
935	Đuôi Chuột 17/19 Lắc	duoi chuot 17/19 lac	cái	90000	0	\N	2025-07-18 16:43:46.002271	2025-07-18 16:43:46.002271
936	Đuôi Xi Phông Inox	duoi xi phong inox	cái	110000	0	\N	2025-07-18 16:43:46.004271	2025-07-18 16:43:46.004271
937	Ecu +Bu Lông M8X3 Cm	ecu +bu long m8x3 cm	kg	33000	0	\N	2025-07-18 16:43:46.005271	2025-07-18 16:43:46.005271
938	Ecu 10	ecu 10	kg	40000	0	\N	2025-07-18 16:43:46.008286	2025-07-18 16:43:46.008286
939	Ecu 4	ecu 4	kg	50000	0	\N	2025-07-18 16:43:46.010271	2025-07-18 16:43:46.010271
940	Ecu 6	ecu 6	kg	35000	0	\N	2025-07-18 16:43:46.011271	2025-07-18 16:43:46.011271
941	Ecu 8	ecu 8	kg	40000	0	\N	2025-07-18 16:43:46.014285	2025-07-18 16:43:46.014285
942	Ga Thoát Sàn Đồng	ga thoat san dong	cái	230000	0	\N	2025-07-18 16:43:46.016285	2025-07-18 16:43:46.016285
943	Găng Cao Su Trung	gang cao su trung	đôi	13000	0	\N	2025-07-18 16:43:46.019287	2025-07-18 16:43:46.019287
944	Găng Tay Đen	gang tay den	bó	50000	0	\N	2025-07-18 16:43:46.022285	2025-07-18 16:43:46.022285
945	Găng Tay Đỏ	gang tay do	đôi	2500	0	\N	2025-07-18 16:43:46.02527	2025-07-18 16:43:46.02527
946	Găng Tay Hàn	gang tay han	đôi	30000	0	\N	2025-07-18 16:43:46.027285	2025-07-18 16:43:46.027285
947	Găng Tay Hàn Ngắn - Vàng	gang tay han ngan - vang	đôi	75000	0	\N	2025-07-18 16:43:46.029287	2025-07-18 16:43:46.029287
948	Găng Tay Sợi Trắng	gang tay soi trang	đôi	3000	0	\N	2025-07-18 16:43:46.032268	2025-07-18 16:43:46.032268
949	Găng Tay Trắng	gang tay trang	đôi	2500	0	\N	2025-07-18 16:43:46.034285	2025-07-18 16:43:46.034285
950	Găng Tay Trắng Sợi Dày	gang tay trang soi day	đôi	3000	0	\N	2025-07-18 16:43:46.036285	2025-07-18 16:43:46.036285
951	Găng Tay Xanh	gang tay xanh	đôi	5000	0	\N	2025-07-18 16:43:46.039285	2025-07-18 16:43:46.039285
952	Găng Tay Xanh 388	gang tay xanh 388	bó	55000	0	\N	2025-07-18 16:43:46.041285	2025-07-18 16:43:46.041285
953	Gáo Nhựa Bé	gao nhua be	cái	10000	0	\N	2025-07-18 16:43:46.044271	2025-07-18 16:43:46.044271
954	Gáo Nhựa To	gao nhua to	cái	15000	0	\N	2025-07-18 16:43:46.046285	2025-07-18 16:43:46.046285
955	Gạt Kính	gat kinh	cái	35000	0	\N	2025-07-18 16:43:46.04927	2025-07-18 16:43:46.04927
956	Gạt Kính Vàng	gat kinh vang	cái	25000	0	\N	2025-07-18 16:43:46.051285	2025-07-18 16:43:46.051285
957	Gạt Nước Dài	gat nuoc dai	cái	90000	0	\N	2025-07-18 16:43:46.054269	2025-07-18 16:43:46.054269
958	Ghen 100X60-2M	ghen 100x60-2m	cây	157000	0	\N	2025-07-18 16:43:46.056269	2025-07-18 16:43:46.056269
959	Ghen 20 Vanlook	ghen 20 vanlook	cây	25500	0	\N	2025-07-18 16:43:46.058271	2025-07-18 16:43:46.058271
960	Ghen 24X14	ghen 24x14	cây	15000	0	\N	2025-07-18 16:43:46.059271	2025-07-18 16:43:46.059271
961	Ghen 25 Vanlook	ghen 25 vanlook	cây	36000	0	\N	2025-07-18 16:43:46.062285	2025-07-18 16:43:46.062285
962	Ghen 60X22	ghen 60x22	cái	60800	0	\N	2025-07-18 16:43:46.065248	2025-07-18 16:43:46.065248
963	Ghen 80X60	ghen 80x60	cây	125600	0	\N	2025-07-18 16:43:46.068284	2025-07-18 16:43:46.068284
964	Ghen Bán Nguyệt / 2.4	ghen ban nguyet / 2.4	cây	54000	0	\N	2025-07-18 16:43:46.071316	2025-07-18 16:43:46.071316
965	Ghen Cam 32/25	ghen cam 32/25	m	10000	0	\N	2025-07-18 16:43:46.074317	2025-07-18 16:43:46.074317
966	Ghen Cam 40/32	ghen cam 40/32	m	13000	0	\N	2025-07-18 16:43:46.078301	2025-07-18 16:43:46.078301
968	Ghen Cam 50/65	ghen cam 50/65	m	18000	0	\N	2025-07-18 16:43:46.082316	2025-07-18 16:43:46.082316
969	Ghen Co	ghen co	m	6000	0	\N	2025-07-18 16:43:46.084316	2025-07-18 16:43:46.084316
970	Ghen Hộp 40X60 Sp	ghen hop 40x60 sp	cây	50000	0	\N	2025-07-18 16:43:46.087859	2025-07-18 16:43:46.087859
971	Ghen Hộp 60X80	ghen hop 60x80	cây	120000	0	\N	2025-07-18 16:43:46.089875	2025-07-18 16:43:46.089875
972	Ghen Ruột Gà 40/32	ghen ruot ga 40/32	m	13000	0	\N	2025-07-18 16:43:46.091875	2025-07-18 16:43:46.091875
973	Ghen Ruột Gà Đỏ 32/25	ghen ruot ga do 32/25	m	11000	0	\N	2025-07-18 16:43:46.094875	2025-07-18 16:43:46.094875
974	Ghen Ruột Gà Đỏ 50/40	ghen ruot ga do 50/40	m	17000	0	\N	2025-07-18 16:43:46.097861	2025-07-18 16:43:46.097861
975	Ghen Vuông 14X7	ghen vuong 14x7	cây	10000	0	\N	2025-07-18 16:43:46.100868	2025-07-18 16:43:46.100868
976	Ghen Vuông 16X14	ghen vuong 16x14	cây	13500	0	\N	2025-07-18 16:43:46.1049	2025-07-18 16:43:46.1049
977	Ghen Vuông 39X18 - 2M	ghen vuong 39x18 - 2m	cây	31000	0	\N	2025-07-18 16:43:46.106441	2025-07-18 16:43:46.106441
978	Ghim 13/8	ghim 13/8	cái	25000	0	\N	2025-07-18 16:43:46.10966	2025-07-18 16:43:46.10966
979	Ghim J1013	ghim j1013	hộp	35000	0	\N	2025-07-18 16:43:46.11173	2025-07-18 16:43:46.11173
980	Ghíp Điện Đôi	ghip dien doi	cái	25000	0	\N	2025-07-18 16:43:46.113746	2025-07-18 16:43:46.113746
981	Ghíp Điện Đơn	ghip dien don	cái	15000	0	\N	2025-07-18 16:43:46.115745	2025-07-18 16:43:46.115745
982	Ghíp Đôi Đức Phát Đắt	ghip doi duc phat dat	cái	50000	0	\N	2025-07-18 16:43:46.118746	2025-07-18 16:43:46.118746
983	Giá Chậu Inox	gia chau inox	cái	20000	0	\N	2025-07-18 16:43:46.120732	2025-07-18 16:43:46.120732
984	Giá Để Xà Phòng	gia de xa phong	cái	60000	0	\N	2025-07-18 16:43:46.122745	2025-07-18 16:43:46.122745
985	Giá Điều Hòa	gia dieu hoa	cái	55000	0	\N	2025-07-18 16:43:46.125745	2025-07-18 16:43:46.125745
986	Giá Điều Hòa 9000 Loại Dày	gia dieu hoa 9000 loai day	bộ	55000	0	\N	2025-07-18 16:43:46.127746	2025-07-18 16:43:46.127746
987	Giá Góc Inox	gia goc inox	cái	250000	0	\N	2025-07-18 16:43:46.130746	2025-07-18 16:43:46.130746
988	Giá Gương	gia guong	cái	10000	0	\N	2025-07-18 16:43:46.13373	2025-07-18 16:43:46.13373
989	Giá Tivi	gia tivi	cái	135000	0	\N	2025-07-18 16:43:46.135729	2025-07-18 16:43:46.135729
990	Giá Treo Bình Nóng Lạnh Vuông	gia treo binh nong lanh vuong	cái	20000	0	\N	2025-07-18 16:43:46.137731	2025-07-18 16:43:46.137731
991	Giá Treo Chậu Rửa Mặt Inox	gia treo chau rua mat inox	cái	20000	0	\N	2025-07-18 16:43:46.138732	2025-07-18 16:43:46.138732
992	Giáp Jb 120	giap jb 120	m	6000	0	\N	2025-07-18 16:43:46.141732	2025-07-18 16:43:46.141732
993	Giáp Jb 150	giap jb 150	cuộn	165000	0	\N	2025-07-18 16:43:46.143732	2025-07-18 16:43:46.143732
994	Giáp Jb 180	giap jb 180	cuộn	165000	0	\N	2025-07-18 16:43:46.146745	2025-07-18 16:43:46.146745
995	Giáp Jb 320	giap jb 320	cuộn	0	0	\N	2025-07-18 16:43:46.148732	2025-07-18 16:43:46.148732
996	Giáp Jb 400	giap jb 400	cuộn	160000	0	\N	2025-07-18 16:43:46.150745	2025-07-18 16:43:46.150745
997	Giáp Nhật 400	giap nhat 400	tờ	8000	0	\N	2025-07-18 16:43:46.154337	2025-07-18 16:43:46.154337
998	Giáp Nhật 800	giap nhat 800	tờ	10000	0	\N	2025-07-18 16:43:46.156338	2025-07-18 16:43:46.156338
999	Giáp Tàu	giap tau	tờ	2000	0	\N	2025-07-18 16:43:46.157338	2025-07-18 16:43:46.157338
1000	Giáp Tròn 100	giap tron 100	tờ	1000	0	\N	2025-07-18 16:43:46.159338	2025-07-18 16:43:46.159338
1001	Giáp Tròn 230	giap tron 230	tờ	3500	0	\N	2025-07-18 16:43:46.160338	2025-07-18 16:43:46.160338
1002	Giáp Tròn Phi 180	giap tron phi 180	tờ	2500	0	\N	2025-07-18 16:43:46.163338	2025-07-18 16:43:46.163338
1003	Giáp Vải 40	giap vai 40	m	10000	0	\N	2025-07-18 16:43:46.166336	2025-07-18 16:43:46.166336
1004	Giáp Xếp Tiger	giap xep tiger	cái	8000	0	\N	2025-07-18 16:43:46.168339	2025-07-18 16:43:46.168339
1005	Giày Bảo Hộ	giay bao ho	đôi	130000	0	\N	2025-07-18 16:43:46.171345	2025-07-18 16:43:46.171345
1006	Giày Xanh	giay xanh	đôi	25000	0	\N	2025-07-18 16:43:46.173346	2025-07-18 16:43:46.173346
1007	Gioăng 4234	gioang 4234	cái	7000	0	\N	2025-07-18 16:43:46.175348	2025-07-18 16:43:46.175348
1008	Gòng Cửa Inox	gong cua inox	bộ	95000	0	\N	2025-07-18 16:43:46.179277	2025-07-18 16:43:46.179277
1009	Gòng Inox Tường 10	gong inox tuong 10	cái	23000	0	\N	2025-07-18 16:43:46.181257	2025-07-18 16:43:46.181257
1010	Gương 40 X 60 Mifa Co	guong 40 x 60 mifa co	cái	160000	0	\N	2025-07-18 16:43:46.183257	2025-07-18 16:43:46.183257
1011	Gương 40X60 103A	guong 40x60 103a	cái	230000	0	\N	2025-07-18 16:43:46.185765	2025-07-18 16:43:46.185765
1012	Gương 40X60 Hq	guong 40x60 hq	cái	200000	0	\N	2025-07-18 16:43:46.188773	2025-07-18 16:43:46.188773
1013	Gương 40X60 Mifaco	guong 40x60 mifaco	cái	140000	0	\N	2025-07-18 16:43:46.189775	2025-07-18 16:43:46.189775
1014	Gương 40X60 Rẻ	guong 40x60 re	cái	130000	0	\N	2025-07-18 16:43:46.191773	2025-07-18 16:43:46.191773
1015	Gương 50X70 Dentalux	guong 50x70 dentalux	cái	280000	0	\N	2025-07-18 16:43:46.193773	2025-07-18 16:43:46.193773
1016	Gương 50X70 Dentalux 103 A	guong 50x70 dentalux 103 a	cái	280000	0	\N	2025-07-18 16:43:46.194773	2025-07-18 16:43:46.194773
1017	Gương 50X70 Hq	guong 50x70 hq	cái	250000	0	\N	2025-07-18 16:43:46.197772	2025-07-18 16:43:46.197772
1018	Gương 50X70 Vát 102B	guong 50x70 vat 102b	cái	380000	0	\N	2025-07-18 16:43:46.199775	2025-07-18 16:43:46.199775
1019	Gương Điện 50X70	guong dien 50x70	cái	500000	0	\N	2025-07-18 16:43:46.201772	2025-07-18 16:43:46.201772
1020	Gương Ngang 60X80 Dentalux	guong ngang 60x80 dentalux	cái	400000	0	\N	2025-07-18 16:43:46.203771	2025-07-18 16:43:46.203771
1021	Gương Vg 835	guong vg 835	cái	650000	0	\N	2025-07-18 16:43:46.205774	2025-07-18 16:43:46.205774
1022	Hạt Công Tắc Kép	hat cong tac kep	cái	35000	0	\N	2025-07-18 16:43:46.208959	2025-07-18 16:43:46.208959
1023	Hạt Mạng Cat 5	hat mang cat 5	cái	1000	0	\N	2025-07-18 16:43:46.211953	2025-07-18 16:43:46.211953
1024	Hdpe Bịt 20	hdpe bit 20	cái	12000	0	\N	2025-07-18 16:43:46.214956	2025-07-18 16:43:46.214956
1025	Hdpe Bịt 25	hdpe bit 25	cái	15000	0	\N	2025-07-18 16:43:46.216956	2025-07-18 16:43:46.216956
1026	Hdpe Bịt 32	hdpe bit 32	cái	16900	0	\N	2025-07-18 16:43:46.219969	2025-07-18 16:43:46.219969
1027	Hdpe Côn 25/20	hdpe con 25/20	cái	15000	0	\N	2025-07-18 16:43:46.223836	2025-07-18 16:43:46.223836
1028	Hdpe Côn 32/25	hdpe con 32/25	cái	20000	0	\N	2025-07-18 16:43:46.225838	2025-07-18 16:43:46.225838
1029	Hdpe Cút 20	hdpe cut 20	cái	12000	0	\N	2025-07-18 16:43:46.227852	2025-07-18 16:43:46.227852
1030	Hdpe Cút 25	hdpe cut 25	cái	15000	0	\N	2025-07-18 16:43:46.229821	2025-07-18 16:43:46.229821
1031	Hdpe Cút 32	hdpe cut 32	cái	37000	0	\N	2025-07-18 16:43:46.232837	2025-07-18 16:43:46.232837
1032	Hdpe Cút Đều 32	hdpe cut deu 32	cái	34400	0	\N	2025-07-18 16:43:46.234852	2025-07-18 16:43:46.234852
1033	Hdpe Cút Ren 25X1/2	hdpe cut ren 25x1/2	cái	15000	0	\N	2025-07-18 16:43:46.237838	2025-07-18 16:43:46.237838
1034	Hdpe Cút Rt 20	hdpe cut rt 20	cái	12000	0	\N	2025-07-18 16:43:46.239852	2025-07-18 16:43:46.239852
1035	Hdpe Cút Rt 25	hdpe cut rt 25	cái	15000	0	\N	2025-07-18 16:43:46.242836	2025-07-18 16:43:46.242836
1036	Hdpe Đai Khởi Thủy 32X1/2	hdpe dai khoi thuy 32x1/2	cái	25900	0	\N	2025-07-18 16:43:46.244854	2025-07-18 16:43:46.244854
1037	Hdpe Măng Sông 20	hdpe mang song 20	cái	12000	0	\N	2025-07-18 16:43:46.246852	2025-07-18 16:43:46.246852
1038	Hdpe Măng Sông 32	hdpe mang song 32	cái	25000	0	\N	2025-07-18 16:43:46.248852	2025-07-18 16:43:46.248852
1039	Hdpe Ms 25	hdpe ms 25	cái	15000	0	\N	2025-07-18 16:43:46.251852	2025-07-18 16:43:46.251852
1040	Hdpe Msrn 20	hdpe msrn 20	cái	15000	0	\N	2025-07-18 16:43:46.254838	2025-07-18 16:43:46.254838
1041	Hdpe Msrt 20	hdpe msrt 20	cái	12000	0	\N	2025-07-18 16:43:46.256852	2025-07-18 16:43:46.256852
1042	Hdpe Msrt 25	hdpe msrt 25	cái	15000	0	\N	2025-07-18 16:43:46.258838	2025-07-18 16:43:46.258838
1043	Hdpe Msrt 32	hdpe msrt 32	cái	28000	0	\N	2025-07-18 16:43:46.260836	2025-07-18 16:43:46.260836
1044	Hdpe Ống 20	hdpe ong 20	m	5000	0	\N	2025-07-18 16:43:46.262873	2025-07-18 16:43:46.262873
1045	Hdpe Ống 25 Deko	hdpe ong 25 deko	m	9000	0	\N	2025-07-18 16:43:46.264881	2025-07-18 16:43:46.264881
1046	Hdpe Ống 32 Deko	hdpe ong 32 deko	m	15000	0	\N	2025-07-18 16:43:46.266867	2025-07-18 16:43:46.266867
1047	Hdpe Ống Dekko 32X1.9 Pn10	hdpe ong dekko 32x1.9 pn10	m	14531	0	\N	2025-07-18 16:43:46.268881	2025-07-18 16:43:46.268881
1048	Hdpe Ren Ngoài 25	hdpe ren ngoai 25	cái	15000	0	\N	2025-07-18 16:43:46.271881	2025-07-18 16:43:46.271881
1049	Hdpe Rn 50	hdpe rn 50	cái	40000	0	\N	2025-07-18 16:43:46.274882	2025-07-18 16:43:46.274882
1050	Hdpe Tê 20	hdpe te 20	cái	20000	0	\N	2025-07-18 16:43:46.277373	2025-07-18 16:43:46.277373
1051	Hdpe Tê 25	hdpe te 25	cái	20000	0	\N	2025-07-18 16:43:46.279551	2025-07-18 16:43:46.279551
1052	Hdpe Tê 32	hdpe te 32	cái	40000	0	\N	2025-07-18 16:43:46.281232	2025-07-18 16:43:46.281232
1053	Hdpe Tê Ren 20	hdpe te ren 20	cái	20000	0	\N	2025-07-18 16:43:46.284373	2025-07-18 16:43:46.284373
1054	Hdpe Tê Ren Trong 25	hdpe te ren trong 25	cái	20000	0	\N	2025-07-18 16:43:46.285857	2025-07-18 16:43:46.285857
1055	Hdpe Van 20	hdpe van 20	cái	35000	0	\N	2025-07-18 16:43:46.288872	2025-07-18 16:43:46.288872
1056	Hdpe Van 25	hdpe van 25	cái	45000	0	\N	2025-07-18 16:43:46.291902	2025-07-18 16:43:46.291902
1057	Hdpe Van 32	hdpe van 32	cái	60000	0	\N	2025-07-18 16:43:46.294903	2025-07-18 16:43:46.294903
1058	Hẹn Giờ Decom Dckg 316	hen gio decom dckg 316	cái	250000	0	\N	2025-07-18 16:43:46.297889	2025-07-18 16:43:46.297889
1059	Hít Kính 2 Tốt	hit kinh 2 tot	cái	135000	0	\N	2025-07-18 16:43:46.300903	2025-07-18 16:43:46.300903
1060	Hít Kính 3 Đắt	hit kinh 3 dat	cái	165000	0	\N	2025-07-18 16:43:46.302903	2025-07-18 16:43:46.302903
1061	Hóa đơn	hoa don	cái	0	0	\N	2025-07-18 16:43:46.305903	2025-07-18 16:43:46.305903
1062	Hòm 4 Công Tơ	hom 4 cong to	cái	390000	0	\N	2025-07-18 16:43:46.307903	2025-07-18 16:43:46.307903
1063	Hòm Công Tơ H1 Nhựa	hom cong to h1 nhua	cái	165000	0	\N	2025-07-18 16:43:46.3109	2025-07-18 16:43:46.3109
1064	Hòm Tôn 47X29X20	hom ton 47x29x20	cái	140000	0	\N	2025-07-18 16:43:46.313897	2025-07-18 16:43:46.313897
1065	Hòm Tôn 50X80	hom ton 50x80	cái	350000	0	\N	2025-07-18 16:43:46.316899	2025-07-18 16:43:46.316899
1066	Hòm Tôn 52X23X23	hom ton 52x23x23	cái	150000	0	\N	2025-07-18 16:43:46.318885	2025-07-18 16:43:46.318885
1067	Hòm Tôn 58X37X27	hom ton 58x37x27	cái	165000	0	\N	2025-07-18 16:43:46.321897	2025-07-18 16:43:46.321897
1068	Hòm Tôn 65X41X30	hom ton 65x41x30	cái	210000	0	\N	2025-07-18 16:43:46.323896	2025-07-18 16:43:46.323896
1069	Hộp Át Giniu	hop at giniu	cái	20000	0	\N	2025-07-18 16:43:46.325913	2025-07-18 16:43:46.325913
1070	Hộp Công Nghiệp Sắt	hop cong nghiep sat	cái	570000	0	\N	2025-07-18 16:43:46.328508	2025-07-18 16:43:46.328508
1071	Hộp Đông Hồ Nước	hop dong ho nuoc	cái	120000	0	\N	2025-07-18 16:43:46.331472	2025-07-18 16:43:46.331472
1072	Hộp Đựng Đồ Nhựa Nhỡ	hop dung do nhua nho	cái	150000	0	\N	2025-07-18 16:43:46.335509	2025-07-18 16:43:46.335509
1073	Hộp Nối Dây 11X11X5	hop noi day 11x11x5	cái	18200	0	\N	2025-07-18 16:43:46.337495	2025-07-18 16:43:46.337495
1074	Hộp Nối Dây 11X11X8	hop noi day 11x11x8	cái	27500	0	\N	2025-07-18 16:43:46.33963	2025-07-18 16:43:46.33963
1075	Hộp Nối Dây 16X16X5	hop noi day 16x16x5	cái	37600	0	\N	2025-07-18 16:43:46.342684	2025-07-18 16:43:46.342684
1076	Hộp Nối Dây 16X16X8	hop noi day 16x16x8	cái	56800	0	\N	2025-07-18 16:43:46.344698	2025-07-18 16:43:46.344698
1077	Hộp Nối Dây 18,5X18,5	hop noi day 18,5x18,5	cái	75600	0	\N	2025-07-18 16:43:46.347698	2025-07-18 16:43:46.347698
1078	Hộp Nối Dây 23,5X23,5	hop noi day 23,5x23,5	cái	116000	0	\N	2025-07-18 16:43:46.349697	2025-07-18 16:43:46.349697
1079	Hộp Nối Dây 8X8X5	hop noi day 8x8x5	cái	14200	0	\N	2025-07-18 16:43:46.353662	2025-07-18 16:43:46.353662
1080	Hộp Ổ Nguồn Công Nghiệp Nhựa Mdca	hop o nguon cong nghiep nhua mdca	cái	210000	0	\N	2025-07-18 16:43:46.355682	2025-07-18 16:43:46.355682
1081	Hộp Số Quạt Trần Tn	hop so quat tran tn	cái	145000	0	\N	2025-07-18 16:43:46.357698	2025-07-18 16:43:46.357698
1082	Hót Rác Nhựa	hot rac nhua	cái	7000	0	\N	2025-07-18 16:43:46.360697	2025-07-18 16:43:46.360697
1083	Hót Rác Sắt	hot rac sat	cái	25000	0	\N	2025-07-18 16:43:46.363711	2025-07-18 16:43:46.363711
1084	Hút Mùi Buchen	hut mui buchen	cái	4200000	0	\N	2025-07-18 16:43:46.367065	2025-07-18 16:43:46.367065
1085	Hút Mùi Canzy	hut mui canzy	cái	2200000	0	\N	2025-07-18 16:43:46.370064	2025-07-18 16:43:46.370064
1086	Hút Mùi Fandi Khay Hứng Mỡ	hut mui fandi khay hung mo	cái	2500000	0	\N	2025-07-18 16:43:46.372064	2025-07-18 16:43:46.372064
1087	Hút Mùi Fd Efpr 70 Fandi	hut mui fd efpr 70 fandi	cái	4500000	0	\N	2025-07-18 16:43:46.375064	2025-07-18 16:43:46.375064
1088	Inox 10X8	inox 10x8	cái	5000	0	\N	2025-07-18 16:43:46.378632	2025-07-18 16:43:46.378632
1089	Inox 12 Avata	inox 12 avata	cái	65000	0	\N	2025-07-18 16:43:46.379632	2025-07-18 16:43:46.379632
1090	Inox 3 Boss	inox 3 boss	cái	9000	0	\N	2025-07-18 16:43:46.382646	2025-07-18 16:43:46.382646
1091	Inox 3.5 Avata	inox 3.5 avata	cái	10000	0	\N	2025-07-18 16:43:46.384645	2025-07-18 16:43:46.384645
1092	Inox 5 Boss	inox 5 boss	cái	16000	0	\N	2025-07-18 16:43:46.38823	2025-07-18 16:43:46.38823
1093	Inox 5.5 Avata	inox 5.5 avata	cái	15000	0	\N	2025-07-18 16:43:46.390229	2025-07-18 16:43:46.390229
1094	Kapusi Mỏ Lết	kapusi mo let	cái	100000	0	\N	2025-07-18 16:43:46.392244	2025-07-18 16:43:46.392244
1095	Ke + 1 Ly	ke + 1 ly	gói	15000	0	\N	2025-07-18 16:43:46.394243	2025-07-18 16:43:46.394243
1096	Ke + 1,5 Ly	ke + 1,5 ly	gói	15000	0	\N	2025-07-18 16:43:46.397244	2025-07-18 16:43:46.397244
1097	Ke + 2 Ly	ke + 2 ly	gói	15000	0	\N	2025-07-18 16:43:46.399244	2025-07-18 16:43:46.399244
1098	Kê Bê Tông	ke be tong	hộp	90000	0	\N	2025-07-18 16:43:46.40123	2025-07-18 16:43:46.40123
1099	Kê Bê Tông 7	ke be tong 7	thùng	90000	0	\N	2025-07-18 16:43:46.403244	2025-07-18 16:43:46.403244
1100	Kê Bt 3	ke bt 3	hôp	90000	0	\N	2025-07-18 16:43:46.405244	2025-07-18 16:43:46.405244
1101	Ke Cân Bằng 1 Ly	ke can bang 1 ly	gói	70000	0	\N	2025-07-18 16:43:46.40823	2025-07-18 16:43:46.40823
1102	Ke Cân Bằng 1,5 Ly	ke can bang 1,5 ly	gói	70000	0	\N	2025-07-18 16:43:46.411228	2025-07-18 16:43:46.411228
1103	Kệ Cốc Đánh Răng	ke coc danh rang	cái	165000	0	\N	2025-07-18 16:43:46.412229	2025-07-18 16:43:46.412229
1104	Ke Cộng 2 Ly	ke cong 2 ly	gói	15000	0	\N	2025-07-18 16:43:46.415276	2025-07-18 16:43:46.415276
1105	Ke Góc Đen 50 Cm	ke goc den 50 cm	cái	50000	0	\N	2025-07-18 16:43:46.416261	2025-07-18 16:43:46.416261
1106	Kệ Góc Inox 304	ke goc inox 304	cái	240000	0	\N	2025-07-18 16:43:46.418261	2025-07-18 16:43:46.418261
1107	Kệ Gương Đắt	ke guong dat	cái	110000	0	\N	2025-07-18 16:43:46.420261	2025-07-18 16:43:46.420261
1108	Ke Inox Vuông 25 Cm	ke inox vuong 25 cm	cái	25000	0	\N	2025-07-18 16:43:46.422275	2025-07-18 16:43:46.422275
1109	Kệ Kính	ke kinh	cái	100000	0	\N	2025-07-18 16:43:46.424275	2025-07-18 16:43:46.424275
1110	Ke L Sắt Dài	ke l sat dai	kg	40000	0	\N	2025-07-18 16:43:46.426584	2025-07-18 16:43:46.426584
1111	Kê Môn Đồng	ke mon dong	bộ	900000	0	\N	2025-07-18 16:43:46.429397	2025-07-18 16:43:46.429397
1112	Ke Nêm	ke nem	kg	70000	0	\N	2025-07-18 16:43:46.431467	2025-07-18 16:43:46.431467
1113	Ke Sắt 2 Lỗ	ke sat 2 lo	kg	40000	0	\N	2025-07-18 16:43:46.434492	2025-07-18 16:43:46.434492
1114	Ke Vặn	ke van	gói	65000	0	\N	2025-07-18 16:43:46.436492	2025-07-18 16:43:46.436492
1115	Ke Vuông Inix 50Cm	ke vuong inix 50cm	cái	50000	0	\N	2025-07-18 16:43:46.438492	2025-07-18 16:43:46.438492
1116	Ke Vuông Inox	ke vuong inox	cái	50000	0	\N	2025-07-18 16:43:46.441492	2025-07-18 16:43:46.441492
1117	Keo 502 Bé V42	keo 502 be v42	lọ	4200	0	\N	2025-07-18 16:43:46.444478	2025-07-18 16:43:46.444478
1118	Keo 502 N130 Đức Anh	keo 502 n130 duc anh	lọ	25000	0	\N	2025-07-18 16:43:46.446492	2025-07-18 16:43:46.446492
1119	Keo 502 Vừa V 32	keo 502 vua v 32	lọ	5000	0	\N	2025-07-18 16:43:46.449492	2025-07-18 16:43:46.449492
1120	Keo 502S Thuận Phong	keo 502s thuan phong	lọ	5000	0	\N	2025-07-18 16:43:46.452493	2025-07-18 16:43:46.452493
1121	Keo Ab 2 Thành Phần	keo ab 2 thanh phan	tuýp	35000	0	\N	2025-07-18 16:43:46.454492	2025-07-18 16:43:46.454492
1122	Keo Bịt Điều Hòa	keo bit dieu hoa	gói	5000	0	\N	2025-07-18 16:43:46.456492	2025-07-18 16:43:46.456492
1123	Keo Bơm Mạch Vàng Nhũ	keo bom mach vang nhu	lọ	135000	0	\N	2025-07-18 16:43:46.459492	2025-07-18 16:43:46.459492
1124	Keo Bọt	keo bot	lọ	75000	0	\N	2025-07-18 16:43:46.461492	2025-07-18 16:43:46.461492
1125	Kéo Cắt Cành	keo cat canh	cái	175000	0	\N	2025-07-18 16:43:46.464474	2025-07-18 16:43:46.464474
1126	Kéo Cắt Ống	keo cat ong	cái	125000	0	\N	2025-07-18 16:43:46.466524	2025-07-18 16:43:46.466524
1127	Kéo Cắt Ống Bé	keo cat ong be	cái	95000	0	\N	2025-07-18 16:43:46.469525	2025-07-18 16:43:46.469525
1128	Kéo Cắt Ống Bé Cmart	keo cat ong be cmart	cái	75000	0	\N	2025-07-18 16:43:46.471525	2025-07-18 16:43:46.471525
1129	Kéo Cắt Ống Tiger	keo cat ong tiger	cái	145000	0	\N	2025-07-18 16:43:46.473524	2025-07-18 16:43:46.473524
1130	Kéo Cắt Tôn	keo cat ton	cái	110000	0	\N	2025-07-18 16:43:46.477524	2025-07-18 16:43:46.477524
1131	Keo Chó 01	keo cho 01	lọ	35000	0	\N	2025-07-18 16:43:46.47851	2025-07-18 16:43:46.47851
1132	Keo Con Chó 0.3Kg	keo con cho 0.3kg	cái	45000	0	\N	2025-07-18 16:43:46.480021	2025-07-18 16:43:46.480021
1133	Keo Con Chó 0.8Kg	keo con cho 0.8kg	cái	90000	0	\N	2025-07-18 16:43:46.482048	2025-07-18 16:43:46.482048
1134	Keo Con Chó 3Kg	keo con cho 3kg	thùng	430000	0	\N	2025-07-18 16:43:46.484062	2025-07-18 16:43:46.484062
1135	Keo Đá Tenda Vàng	keo da tenda vang	lọ	45000	0	\N	2025-07-18 16:43:46.48659	2025-07-18 16:43:46.48659
1136	Keo Dán Gạch Maxone	keo dan gach maxone	bao	135000	0	\N	2025-07-18 16:43:46.490623	2025-07-18 16:43:46.490623
1137	Kéo Đen	keo den	cái	15000	0	\N	2025-07-18 16:43:46.492639	2025-07-18 16:43:46.492639
1138	Kéo Gà Đỏ	keo ga do	cái	40000	0	\N	2025-07-18 16:43:46.49564	2025-07-18 16:43:46.49564
1139	Keo Gắn Sắt Ab	keo gan sat ab	vỉ	38000	0	\N	2025-07-18 16:43:46.497639	2025-07-18 16:43:46.497639
1140	Keo Mạc Duy Linh	keo mac duy linh	gói	7000	0	\N	2025-07-18 16:43:46.499625	2025-07-18 16:43:46.499625
1141	Keo Mạch	keo mach	kg	15000	0	\N	2025-07-18 16:43:46.502639	2025-07-18 16:43:46.502639
1142	Keo Mạch Duy Linh	keo mach duy linh	kg	7000	0	\N	2025-07-18 16:43:46.504639	2025-07-18 16:43:46.504639
1143	Keo Mạch Thái	keo mach thai	kg	25000	0	\N	2025-07-18 16:43:46.50764	2025-07-18 16:43:46.50764
1144	Keo Nến Loại Nhỏ	keo nen loai nho	cái	1500	0	\N	2025-07-18 16:43:46.509639	2025-07-18 16:43:46.509639
1145	Keo Nến Loại To	keo nen loai to	cái	2500	0	\N	2025-07-18 16:43:46.512625	2025-07-18 16:43:46.512625
1146	Keo Ốp Lát	keo op lat	bao	130000	0	\N	2025-07-18 16:43:46.515687	2025-07-18 16:43:46.515687
1147	Keo Ram Sét L1	keo ram set l1	cặp	560000	0	\N	2025-07-18 16:43:46.517672	2025-07-18 16:43:46.517672
1148	Keo Sữa Atm	keo sua atm	gói	45000	0	\N	2025-07-18 16:43:46.520686	2025-07-18 16:43:46.520686
1149	Keo Tạo Gioăng	keo tao gioang	tuýp	45000	0	\N	2025-07-18 16:43:46.524686	2025-07-18 16:43:46.524686
1150	Keo Tibon	keo tibon	hộp	82000	0	\N	2025-07-18 16:43:46.52767	2025-07-18 16:43:46.52767
1151	Keo Tibon Sữa Thùng 20 Kg	keo tibon sua thung 20 kg	thùng	2600000	0	\N	2025-07-18 16:43:46.530805	2025-07-18 16:43:46.530805
1152	Kéo Xanh Dài	keo xanh dai	cái	25000	0	\N	2025-07-18 16:43:46.53286	2025-07-18 16:43:46.53286
1153	Kéo Xanh Ngắn	keo xanh ngan	cái	20000	0	\N	2025-07-18 16:43:46.53546	2025-07-18 16:43:46.53546
1154	Kép 1/2 Dài 12 Cm	kep 1/2 dai 12 cm	cái	18000	0	\N	2025-07-18 16:43:46.538475	2025-07-18 16:43:46.538475
1155	Kép 15/12	kep 15/12	cái	15000	0	\N	2025-07-18 16:43:46.540474	2025-07-18 16:43:46.540474
1156	Kẹp Dây Led	kep day led	túi	20000	0	\N	2025-07-18 16:43:46.54446	2025-07-18 16:43:46.54446
1157	Kẹp Đèn Bán Nguyệt	kep den ban nguyet	bộ	5000	0	\N	2025-07-18 16:43:46.54646	2025-07-18 16:43:46.54646
1158	Kẹp Đồng Tiếp Địa Vuông	kep dong tiep dia vuong	cái	60000	0	\N	2025-07-18 16:43:46.54746	2025-07-18 16:43:46.54746
1159	Kép Inox 1' (Kép 25)	kep inox 1' (kep 25)	cái	25000	0	\N	2025-07-18 16:43:46.54946	2025-07-18 16:43:46.54946
1160	Kép Inox 1' 1/2 (Kép 32)	kep inox 1' 1/2 (kep 32)	cái	0	0	\N	2025-07-18 16:43:46.551474	2025-07-18 16:43:46.551474
1161	Kép Inox 1' 3/4 (Kép 40)	kep inox 1' 3/4 (kep 40)	cái	0	0	\N	2025-07-18 16:43:46.554491	2025-07-18 16:43:46.554491
1162	Kép Inox 1/2 (Kép 15) 304	kep inox 1/2 (kep 15) 304	cái	9000	0	\N	2025-07-18 16:43:46.557474	2025-07-18 16:43:46.557474
1163	Kep Inox 15 Dài 12Cm	kep inox 15 dai 12cm	cái	16000	0	\N	2025-07-18 16:43:46.55946	2025-07-18 16:43:46.55946
1164	Kép Inox 15 Dài 15 Cm	kep inox 15 dai 15 cm	cái	20000	0	\N	2025-07-18 16:43:46.561474	2025-07-18 16:43:46.561474
1165	Kép Inox 2' (Kép 50)	kep inox 2' (kep 50)	cái	0	0	\N	2025-07-18 16:43:46.563474	2025-07-18 16:43:46.563474
1166	Kép Inox 20 304	kep inox 20 304	cái	20000	0	\N	2025-07-18 16:43:46.56653	2025-07-18 16:43:46.56653
1167	Kép Inox 3/4 (Kép 20)	kep inox 3/4 (kep 20)	cái	15000	0	\N	2025-07-18 16:43:46.569577	2025-07-18 16:43:46.569577
1168	Kẹp Mát Máy Hàn	kep mat may han	cái	25000	0	\N	2025-07-18 16:43:46.571577	2025-07-18 16:43:46.571577
1169	Kép Rẻ 1/2 (Kép 15)	kep re 1/2 (kep 15)	cái	5000	0	\N	2025-07-18 16:43:46.574577	2025-07-18 16:43:46.574577
1170	Kép Thu 20/15	kep thu 20/15	cái	20000	0	\N	2025-07-18 16:43:46.57758	2025-07-18 16:43:46.57758
1171	Kẹp Xà Gồ 8	kep xa go 8	cái	10000	0	\N	2025-07-18 16:43:46.578578	2025-07-18 16:43:46.578578
1172	Khẩu 10 Dài	khau 10 dai	cái	20000	0	\N	2025-07-18 16:43:46.582143	2025-07-18 16:43:46.582143
1173	Khẩu 17 Dài	khau 17 dai	cái	25000	0	\N	2025-07-18 16:43:46.584157	2025-07-18 16:43:46.584157
1174	Khẩu 17 Ngắn	khau 17 ngan	cái	20000	0	\N	2025-07-18 16:43:46.586682	2025-07-18 16:43:46.586682
1175	Khẩu 22	khau 22	cái	35000	0	\N	2025-07-18 16:43:46.589716	2025-07-18 16:43:46.589716
1176	Khẩu 24	khau 24	cái	45000	0	\N	2025-07-18 16:43:46.592731	2025-07-18 16:43:46.592731
1177	Khay Xà Phòng	khay xa phong	cái	60000	0	\N	2025-07-18 16:43:46.59473	2025-07-18 16:43:46.59473
1178	Khò Ga Capusi	kho ga capusi	cái	115000	0	\N	2025-07-18 16:43:46.597733	2025-07-18 16:43:46.597733
1179	Khò Ga Công Nghiệp	kho ga cong nghiep	cái	200000	0	\N	2025-07-18 16:43:46.60071	2025-07-18 16:43:46.60071
1180	Khóa Cáp 12	khoa cap 12	cái	7000	0	\N	2025-07-18 16:43:46.602716	2025-07-18 16:43:46.602716
1181	Khóa Cáp 15	khoa cap 15	cái	15000	0	\N	2025-07-18 16:43:46.60573	2025-07-18 16:43:46.60573
1182	Khoá Cáp 5	khoa cap 5	cái	1500	0	\N	2025-07-18 16:43:46.608693	2025-07-18 16:43:46.608693
1183	Khoá Cáp 6	khoa cap 6	cái	2500	0	\N	2025-07-18 16:43:46.611716	2025-07-18 16:43:46.611716
1184	Khóa Cáp 8	khoa cap 8	cái	4000	0	\N	2025-07-18 16:43:46.613714	2025-07-18 16:43:46.613714
1185	Khóa Chống Cắt To	khoa chong cat to	cái	160000	0	\N	2025-07-18 16:43:46.615762	2025-07-18 16:43:46.615762
1186	Khóa Cửa Việt Tiệp 8 Bấm	khoa cua viet tiep 8 bam	cái	60000	0	\N	2025-07-18 16:43:46.61973	2025-07-18 16:43:46.61973
1187	Khóa Cửa Việt Tiệp Đồng	khoa cua viet tiep dong	cái	180000	0	\N	2025-07-18 16:43:46.622748	2025-07-18 16:43:46.622748
1188	Khóa Đấm Acb	khoa dam acb	cái	75000	0	\N	2025-07-18 16:43:46.624806	2025-07-18 16:43:46.624806
1189	Khóa Đấm Việt Tiệp	khoa dam viet tiep	cái	100000	0	\N	2025-07-18 16:43:46.627794	2025-07-18 16:43:46.627794
1190	Khóa Đồng Của Chinh	khoa dong cua chinh	bộ	1750000	0	\N	2025-07-18 16:43:46.628806	2025-07-18 16:43:46.628806
1191	Khóa Đòng Huy Hoàng	khoa dong huy hoang	cái	165000	0	\N	2025-07-18 16:43:46.632386	2025-07-18 16:43:46.632386
1192	Khóa Huy Hoàng 5810 - 2	khoa huy hoang 5810 - 2	bộ	500000	0	\N	2025-07-18 16:43:46.634371	2025-07-18 16:43:46.634371
1193	Khóa Huy Hoàng 5810 Inox	khoa huy hoang 5810 inox	cái	750000	0	\N	2025-07-18 16:43:46.636385	2025-07-18 16:43:46.636385
1194	Khóa Huy Hoàng 8510 To	khoa huy hoang 8510 to	bộ	800000	0	\N	2025-07-18 16:43:46.638371	2025-07-18 16:43:46.638371
1195	Khóa Số	khoa so	cái	60000	0	\N	2025-07-18 16:43:46.640385	2025-07-18 16:43:46.640385
1196	Khóa Thông Phòng Việt Tiệp	khoa thong phong viet tiep	bộ	650000	0	\N	2025-07-18 16:43:46.64437	2025-07-18 16:43:46.64437
1197	Khóa Tủ Việt Tiệp	khoa tu viet tiep	cái	40000	0	\N	2025-07-18 16:43:46.646948	2025-07-18 16:43:46.646948
1198	Khóa U Longgin	khoa u longgin	cái	110000	0	\N	2025-07-18 16:43:46.648958	2025-07-18 16:43:46.648958
1199	Khóa U Việt Tiệp	khoa u viet tiep	cái	260000	0	\N	2025-07-18 16:43:46.650957	2025-07-18 16:43:46.650957
1200	Khóa Việt Nhật 30	khoa viet nhat 30	cái	20000	0	\N	2025-07-18 16:43:46.654271	2025-07-18 16:43:46.654271
1201	Khóa Việt Nhật 60	khoa viet nhat 60	cái	30000	0	\N	2025-07-18 16:43:46.658303	2025-07-18 16:43:46.658303
1202	Khóa Việt Tiệp Gang 8	khoa viet tiep gang 8	cái	50000	0	\N	2025-07-18 16:43:46.660289	2025-07-18 16:43:46.660289
1203	Khóa Vt Gang 10 Bấm	khoa vt gang 10 bam	cái	65000	0	\N	2025-07-18 16:43:46.662304	2025-07-18 16:43:46.662304
1204	Khoan 12 Boss Bt	khoan 12 boss bt	cái	40000	0	\N	2025-07-18 16:43:46.664303	2025-07-18 16:43:46.664303
1205	Khoan 12 Đa Năng	khoan 12 da nang	cái	45000	0	\N	2025-07-18 16:43:46.666321	2025-07-18 16:43:46.666321
1206	Khoan 8 Đa Năng	khoan 8 da nang	cái	35000	0	\N	2025-07-18 16:43:46.668336	2025-07-18 16:43:46.668336
1207	Khoan Bê Tông 10 Boss	khoan be tong 10 boss	cái	30000	0	\N	2025-07-18 16:43:46.670322	2025-07-18 16:43:46.670322
1208	Khoan Bê Tông 14 Ngắn Abled	khoan be tong 14 ngan abled	cái	30000	0	\N	2025-07-18 16:43:46.672335	2025-07-18 16:43:46.672335
1209	Khoan Bê Tông 16 Avata Ngắn	khoan be tong 16 avata ngan	cái	30000	0	\N	2025-07-18 16:43:46.676305	2025-07-18 16:43:46.676305
1210	Khoan Bê Tông 6 Boss	khoan be tong 6 boss	cái	25000	0	\N	2025-07-18 16:43:46.67932	2025-07-18 16:43:46.67932
1211	Khoan Bê Tông 6 Boss Dài	khoan be tong 6 boss dai	cái	30000	0	\N	2025-07-18 16:43:46.680864	2025-07-18 16:43:46.680864
1212	Khoan Bos 6 Ngắn	khoan bos 6 ngan	cái	28000	0	\N	2025-07-18 16:43:46.683883	2025-07-18 16:43:46.683883
1213	Khoan Bt 10 Makhi	khoan bt 10 makhi	cái	20000	0	\N	2025-07-18 16:43:46.686449	2025-07-18 16:43:46.686449
1214	Khoan Bt 12 Avata	khoan bt 12 avata	cái	20000	0	\N	2025-07-18 16:43:46.689496	2025-07-18 16:43:46.689496
1215	Khoan Bt 12 Makhi	khoan bt 12 makhi	cái	20000	0	\N	2025-07-18 16:43:46.691483	2025-07-18 16:43:46.691483
1216	Khoan Bt 16 Boss	khoan bt 16 boss	cái	65000	0	\N	2025-07-18 16:43:46.693483	2025-07-18 16:43:46.693483
1217	Khoan Bt 20 Tiger	khoan bt 20 tiger	cái	90000	0	\N	2025-07-18 16:43:46.695496	2025-07-18 16:43:46.695496
1218	Khoan Bt 8 Boss	khoan bt 8 boss	cái	30000	0	\N	2025-07-18 16:43:46.699474	2025-07-18 16:43:46.699474
1219	Khoan Bt 8 Makhi	khoan bt 8 makhi	cái	20000	0	\N	2025-07-18 16:43:46.702496	2025-07-18 16:43:46.702496
1220	Khoan Bt Xt 25	khoan bt xt 25	cái	115000	0	\N	2025-07-18 16:43:46.704483	2025-07-18 16:43:46.704483
1221	Khoan Đục Hugong	khoan duc hugong	cái	1150000	0	\N	2025-07-18 16:43:46.706496	2025-07-18 16:43:46.706496
1222	Khoan Inox 12 Boss	khoan inox 12 boss	cái	75000	0	\N	2025-07-18 16:43:46.709483	2025-07-18 16:43:46.709483
1223	Khoan Inox 14 Boss	khoan inox 14 boss	cái	140000	0	\N	2025-07-18 16:43:46.710483	2025-07-18 16:43:46.710483
1224	Khoan Inox 5.5 Avata	khoan inox 5.5 avata	cái	15000	0	\N	2025-07-18 16:43:46.712483	2025-07-18 16:43:46.712483
1225	Khoan Inox 6 Avata	khoan inox 6 avata	cái	15000	0	\N	2025-07-18 16:43:46.714483	2025-07-18 16:43:46.714483
1226	Khoan Inox 7	khoan inox 7	cái	30000	0	\N	2025-07-18 16:43:46.716496	2025-07-18 16:43:46.716496
1227	Khoan Inox 8 Avata	khoan inox 8 avata	cái	25000	0	\N	2025-07-18 16:43:46.718532	2025-07-18 16:43:46.718532
1228	Khoan Inox 8 Box	khoan inox 8 box	cái	40000	0	\N	2025-07-18 16:43:46.721517	2025-07-18 16:43:46.721517
1229	Khoan Inox Bosch 3	khoan inox bosch 3	cái	10000	0	\N	2025-07-18 16:43:46.723515	2025-07-18 16:43:46.723515
1230	Khoan Inox Bosch 5	khoan inox bosch 5	cái	16000	0	\N	2025-07-18 16:43:46.725531	2025-07-18 16:43:46.725531
1231	Khoan Kính	khoan kinh	cái	0	0	\N	2025-07-18 16:43:46.728533	2025-07-18 16:43:46.728533
1232	Khoan Kính 10	khoan kinh 10	cái	10000	0	\N	2025-07-18 16:43:46.73106	2025-07-18 16:43:46.73106
1233	Khoan Kính 12	khoan kinh 12	cái	12000	0	\N	2025-07-18 16:43:46.733092	2025-07-18 16:43:46.733092
1234	Khoan Kính 14	khoan kinh 14	cái	14000	0	\N	2025-07-18 16:43:46.735108	2025-07-18 16:43:46.735108
1235	Khoan Kính 30	khoan kinh 30	cái	30000	0	\N	2025-07-18 16:43:46.737108	2025-07-18 16:43:46.737108
1236	Khoan Kính 32	khoan kinh 32	cái	32000	0	\N	2025-07-18 16:43:46.739094	2025-07-18 16:43:46.739094
1237	Khoan Kinh 35	khoan kinh 35	cái	35000	0	\N	2025-07-18 16:43:46.741108	2025-07-18 16:43:46.741108
1238	Khoan Kính 48	khoan kinh 48	cái	48000	0	\N	2025-07-18 16:43:46.744109	2025-07-18 16:43:46.744109
1239	Khoan Kính 6	khoan kinh 6	cái	6000	0	\N	2025-07-18 16:43:46.746084	2025-07-18 16:43:46.746084
1240	Khoan Kính 60	khoan kinh 60	cái	60000	0	\N	2025-07-18 16:43:46.747782	2025-07-18 16:43:46.747782
1241	Khoan Kính 8	khoan kinh 8	cái	8000	0	\N	2025-07-18 16:43:46.750971	2025-07-18 16:43:46.750971
1242	Khoan Rút Lõi Dc 120	khoan rut loi dc 120	cái	636000	0	\N	2025-07-18 16:43:46.753623	2025-07-18 16:43:46.753623
1243	Khoan Rút Lõi Dong Cheng	khoan rut loi dong cheng	số	4500	0	\N	2025-07-18 16:43:46.755216	2025-07-18 16:43:46.755216
1244	Khoan Tháp 22	khoan thap 22	cái	90000	0	\N	2025-07-18 16:43:46.758263	2025-07-18 16:43:46.758263
1245	Khoan Tháp 32	khoan thap 32	cái	130000	0	\N	2025-07-18 16:43:46.761231	2025-07-18 16:43:46.761231
1246	Khoan Xiên 18 Tiger N	khoan xien 18 tiger n	cái	85000	0	\N	2025-07-18 16:43:46.763227	2025-07-18 16:43:46.763227
1247	Khoan Xiên 20 Tiger	khoan xien 20 tiger	cái	95000	0	\N	2025-07-18 16:43:46.766247	2025-07-18 16:43:46.766247
1248	Khoán Xt 10 Tiger	khoan xt 10 tiger	cái	50000	0	\N	2025-07-18 16:43:46.767255	2025-07-18 16:43:46.767255
1249	Khoan Xt 12 Tiger	khoan xt 12 tiger	cái	50000	0	\N	2025-07-18 16:43:46.770281	2025-07-18 16:43:46.770281
1250	Khoan Xt 14	khoan xt 14	cái	65000	0	\N	2025-07-18 16:43:46.772292	2025-07-18 16:43:46.772292
1251	Khoan Xt 18 4 Cạnh Tiger	khoan xt 18 4 canh tiger	cái	70000	0	\N	2025-07-18 16:43:46.775279	2025-07-18 16:43:46.775279
1252	Khoan Xt 20	khoan xt 20	cái	85000	0	\N	2025-07-18 16:43:46.778276	2025-07-18 16:43:46.778276
1253	Khoan Xt 22	khoan xt 22	cái	95000	0	\N	2025-07-18 16:43:46.780278	2025-07-18 16:43:46.780278
1254	Khoan Xuyên Tường 20	khoan xuyen tuong 20	cái	85000	0	\N	2025-07-18 16:43:46.78181	2025-07-18 16:43:46.78181
1255	Khoét Gỗ 21	khoet go 21	cái	21000	0	\N	2025-07-18 16:43:46.784849	2025-07-18 16:43:46.784849
1256	Khoét Gỗ 45	khoet go 45	cái	45000	0	\N	2025-07-18 16:43:46.787431	2025-07-18 16:43:46.787431
1257	Khoét Gỗ 60	khoet go 60	cái	60000	0	\N	2025-07-18 16:43:46.790445	2025-07-18 16:43:46.790445
1258	Khoét Inox	khoet inox	số	2500	0	\N	2025-07-18 16:43:46.792444	2025-07-18 16:43:46.792444
1259	Khoét Inox 22	khoet inox 22	cái	55000	0	\N	2025-07-18 16:43:46.795445	2025-07-18 16:43:46.795445
1260	Khoét Inox 32	khoet inox 32	cái	70000	0	\N	2025-07-18 16:43:46.797445	2025-07-18 16:43:46.797445
1261	Khoét Kinh 10	khoet kinh 10	cái	10000	0	\N	2025-07-18 16:43:46.800411	2025-07-18 16:43:46.800411
1262	Khoét Kính 20	khoet kinh 20	cái	20000	0	\N	2025-07-18 16:43:46.802429	2025-07-18 16:43:46.802429
1263	Khoét Kính 42	khoet kinh 42	cái	42000	0	\N	2025-07-18 16:43:46.804444	2025-07-18 16:43:46.804444
1264	Khoét Kính 45	khoet kinh 45	cái	45000	0	\N	2025-07-18 16:43:46.807445	2025-07-18 16:43:46.807445
1265	Khoét Kính 60	khoet kinh 60	cái	60000	0	\N	2025-07-18 16:43:46.810445	2025-07-18 16:43:46.810445
1266	Khoét Kinh 8	khoet kinh 8	cái	8000	0	\N	2025-07-18 16:43:46.812431	2025-07-18 16:43:46.812431
1267	Khoét Thạch Cao Răng - Tốt	khoet thach cao rang - tot	bộ	150000	0	\N	2025-07-18 16:43:46.814431	2025-07-18 16:43:46.814431
1268	Khởi 18 Yj	khoi 18 yj	cái	295000	0	\N	2025-07-18 16:43:46.815431	2025-07-18 16:43:46.815431
1269	Khởi Yj 12 A	khoi yj 12 a	cái	174000	0	\N	2025-07-18 16:43:46.817476	2025-07-18 16:43:46.817476
1270	Khởi Yjc 32A - 220V	khoi yjc 32a - 220v	cái	475000	0	\N	2025-07-18 16:43:46.82047	2025-07-18 16:43:46.82047
1271	Khởi Yjc 40-220 V	khoi yjc 40-220 v	cái	540000	0	\N	2025-07-18 16:43:46.821453	2025-07-18 16:43:46.821453
1272	Khớp Nối Nhanh	khop noi nhanh	cái	15000	0	\N	2025-07-18 16:43:46.823819	2025-07-18 16:43:46.823819
1273	Khuấy Sơn	khuay son	cái	35000	0	\N	2025-07-18 16:43:46.826833	2025-07-18 16:43:46.826833
1274	Khung Cưa Tiger	khung cua tiger	cái	65000	0	\N	2025-07-18 16:43:46.828832	2025-07-18 16:43:46.828832
1275	Khung Tời	khung toi	cái	670000	0	\N	2025-07-18 16:43:46.832307	2025-07-18 16:43:46.832307
1276	Kích Gạch	kich gach	cái	45000	0	\N	2025-07-18 16:43:46.834354	2025-07-18 16:43:46.834354
1277	Kìm Bấm Cốt 16 L Bosi	kim bam cot 16 l bosi	cái	290000	0	\N	2025-07-18 16:43:46.837353	2025-07-18 16:43:46.837353
1278	Kìm Bâm Mạng	kim bam mang	cái	125000	0	\N	2025-07-18 16:43:46.839353	2025-07-18 16:43:46.839353
1279	Kìm Bóp Cốt	kim bop cot	cái	0	0	\N	2025-07-18 16:43:46.842328	2025-07-18 16:43:46.842328
1280	Kìm Bóp Ke Rút	kim bop ke rut	cái	45000	0	\N	2025-07-18 16:43:46.845319	2025-07-18 16:43:46.845319
1281	Kìm Cắt Cáp	kim cat cap	cái	120000	0	\N	2025-07-18 16:43:46.848353	2025-07-18 16:43:46.848353
1282	Kìm Cắt Loại Nhỏ	kim cat loai nho	cái	0	0	\N	2025-07-18 16:43:46.85034	2025-07-18 16:43:46.85034
1283	Kìm Cắt Loại To	kim cat loai to	cái	0	0	\N	2025-07-18 16:43:46.853329	2025-07-18 16:43:46.853329
1284	Kìm Cắt Sắt Cộng Lực Loại Nhỏ	kim cat sat cong luc loai nho	cái	0	0	\N	2025-07-18 16:43:46.855315	2025-07-18 16:43:46.855315
1285	Kìm Cắt Sắt Cộng Lực Loại Nhỡ	kim cat sat cong luc loai nho	cái	0	0	\N	2025-07-18 16:43:46.858339	2025-07-18 16:43:46.858339
1286	Kìm Cắt Sắt Cộng Lực Loại To	kim cat sat cong luc loai to	cái	0	0	\N	2025-07-18 16:43:46.86234	2025-07-18 16:43:46.86234
1287	Kìm Chết	kim chet	cái	0	0	\N	2025-07-18 16:43:46.864353	2025-07-18 16:43:46.864353
1288	Kìm Cộng Lực 900 Thái Nguyên	kim cong luc 900 thai nguyen	cái	340000	0	\N	2025-07-18 16:43:46.866337	2025-07-18 16:43:46.866337
1289	Kìm Cốt Thủy Lực	kim cot thuy luc	cái	820000	0	\N	2025-07-18 16:43:46.868368	2025-07-18 16:43:46.868368
1290	Kìm Điện 8 Bosi	kim dien 8 bosi	cái	55000	0	\N	2025-07-18 16:43:46.870369	2025-07-18 16:43:46.870369
1291	Kìm Điện Bogo Xịn	kim dien bogo xin	cái	220000	0	\N	2025-07-18 16:43:46.872369	2025-07-18 16:43:46.872369
1292	Kìm Điện Đỏ 7	kim dien do 7	cái	35000	0	\N	2025-07-18 16:43:46.874382	2025-07-18 16:43:46.874382
1293	Kìm Đỏ Loại Nhỏ	kim do loai nho	cái	0	0	\N	2025-07-18 16:43:46.877383	2025-07-18 16:43:46.877383
1294	Kìm Đỏ Loại To	kim do loai to	cái	0	0	\N	2025-07-18 16:43:46.879383	2025-07-18 16:43:46.879383
1295	Kim Hàn Inox 1.6	kim han inox 1.6	cái	15000	0	\N	2025-07-18 16:43:46.881913	2025-07-18 16:43:46.881913
1296	Kìm Hàn Tiger 600 A Tay Gỗ	kim han tiger 600 a tay go	cái	75000	0	\N	2025-07-18 16:43:46.883964	2025-07-18 16:43:46.883964
1297	Kìm Kẹp Nhỡ 75 A	kim kep nho 75 a	cặp	15000	0	\N	2025-07-18 16:43:46.887524	2025-07-18 16:43:46.887524
1298	Kim Led	kim led	cái	5000	0	\N	2025-07-18 16:43:46.890522	2025-07-18 16:43:46.890522
1299	Kìm Mát	kim mat	cái	25000	0	\N	2025-07-18 16:43:46.892537	2025-07-18 16:43:46.892537
1300	Kìm Mỏ Quạ	kim mo qua	cái	0	0	\N	2025-07-18 16:43:46.894537	2025-07-18 16:43:46.894537
1301	Kìm Nhọn	kim nhon	cái	0	0	\N	2025-07-18 16:43:46.897512	2025-07-18 16:43:46.897512
1302	Kìm Nhọn 6 Thái Nguyên	kim nhon 6 thai nguyen	cái	30000	0	\N	2025-07-18 16:43:46.899521	2025-07-18 16:43:46.899521
1303	Kìm Nước	kim nuoc	cái	0	0	\N	2025-07-18 16:43:46.902522	2025-07-18 16:43:46.902522
1304	Kìm Nước 10	kim nuoc 10	cái	65000	0	\N	2025-07-18 16:43:46.904538	2025-07-18 16:43:46.904538
1305	Kìm Nước 14	kim nuoc 14	cái	85000	0	\N	2025-07-18 16:43:46.906537	2025-07-18 16:43:46.906537
1306	Kìm Rút Nêm	kim rut nem	cái	40000	0	\N	2025-07-18 16:43:46.909538	2025-07-18 16:43:46.909538
1307	Kìm Rút Nhôm Bosi	kim rut nhom bosi	cái	150000	0	\N	2025-07-18 16:43:46.912538	2025-07-18 16:43:46.912538
1308	Kim Sét 1 M 16	kim set 1 m 16	cái	35000	0	\N	2025-07-18 16:43:46.915538	2025-07-18 16:43:46.915538
1309	Kìm Tuốt Dây Kapusi	kim tuot day kapusi	cái	150000	0	\N	2025-07-18 16:43:46.917585	2025-07-18 16:43:46.917585
1310	Kìm Xich	kim xich	cái	150000	0	\N	2025-07-18 16:43:46.920573	2025-07-18 16:43:46.920573
1311	Kính Bảo Hộ Vuông	kinh bao ho vuong	cái	12000	0	\N	2025-07-18 16:43:46.924569	2025-07-18 16:43:46.924569
1312	Kính Đen Mắt Kính	kinh den mat kinh	cái	8000	0	\N	2025-07-18 16:43:46.927585	2025-07-18 16:43:46.927585
1313	Lá Inox 90	la inox 90	cái	5000	0	\N	2025-07-18 16:43:46.929572	2025-07-18 16:43:46.929572
1314	Lạnh 25 Uv Vesbo	lanh 25 uv vesbo	m	66400	0	\N	2025-07-18 16:43:46.933153	2025-07-18 16:43:46.933153
1315	Lau Nhà Cây Dài	lau nha cay dai	cái	90000	0	\N	2025-07-18 16:43:46.935168	2025-07-18 16:43:46.935168
1316	Lệch Tâm Xí	lech tam xi	cái	120000	0	\N	2025-07-18 16:43:46.937167	2025-07-18 16:43:46.937167
1317	Led 4W Đui E14	led 4w dui e14	cái	20000	0	\N	2025-07-18 16:43:46.939167	2025-07-18 16:43:46.939167
1318	Led 9 W Vne	led 9 w vne	cái	55000	0	\N	2025-07-18 16:43:46.942153	2025-07-18 16:43:46.942153
1319	Led Bi Đúc Sáng 4000K	led bi duc sang 4000k	dây	20000	0	\N	2025-07-18 16:43:46.945168	2025-07-18 16:43:46.945168
1320	Led Búp 60W	led bup 60w	cái	100000	0	\N	2025-07-18 16:43:46.947153	2025-07-18 16:43:46.947153
1321	Li Vô	li vo	cái	95000	0	\N	2025-07-18 16:43:46.949132	2025-07-18 16:43:46.949132
1322	Li Vô 20 Cm	li vo 20 cm	cái	40000	0	\N	2025-07-18 16:43:46.951152	2025-07-18 16:43:46.951152
1323	Lô Giấy Hở	lo giay ho	cái	40000	0	\N	2025-07-18 16:43:46.954154	2025-07-18 16:43:46.954154
1324	Lô Giấy Kín Thường	lo giay kin thuong	cái	85000	0	\N	2025-07-18 16:43:46.958167	2025-07-18 16:43:46.958167
1325	Lô Giấy Kín Toda 304	lo giay kin toda 304	cái	230000	0	\N	2025-07-18 16:43:46.960163	2025-07-18 16:43:46.960163
1326	Lô Giấy Senta	lo giay senta	cái	160000	0	\N	2025-07-18 16:43:46.962167	2025-07-18 16:43:46.962167
1327	Lô Sơn Lâm Tuấn Nhỡ	lo son lam tuan nho	cái	15000	0	\N	2025-07-18 16:43:46.964985	2025-07-18 16:43:46.964985
1328	Lô Sơn Trung Pro	lo son trung pro	cái	16000	0	\N	2025-07-18 16:43:46.966639	2025-07-18 16:43:46.966639
1329	Lõi 1 Kagaro	loi 1 kagaro	cái	35000	0	\N	2025-07-18 16:43:46.968833	2025-07-18 16:43:46.968833
1330	Lõi 123 Kagarô	loi 123 kagaro	bộ	135000	0	\N	2025-07-18 16:43:46.970924	2025-07-18 16:43:46.970924
1331	Lõi 3 Kagaro	loi 3 kagaro	cái	40000	0	\N	2025-07-18 16:43:46.974614	2025-07-18 16:43:46.974614
1332	Lõi Khóa Huy Hoàng	loi khoa huy hoang	cái	185000	0	\N	2025-07-18 16:43:46.978552	2025-07-18 16:43:46.978552
1333	Long Đen 10	long den 10	kg	35000	0	\N	2025-07-18 16:43:46.980566	2025-07-18 16:43:46.980566
1334	Long Đen 4	long den 4	kg	40000	0	\N	2025-07-18 16:43:46.982552	2025-07-18 16:43:46.982552
1335	Long Đen 8	long den 8	kg	35000	0	\N	2025-07-18 16:43:46.98409	2025-07-18 16:43:46.98409
1336	Ls Át 15 A	ls at 15 a	cái	85000	0	\N	2025-07-18 16:43:46.985104	2025-07-18 16:43:46.985104
1337	Ls Át 20 A	ls at 20 a	cái	75000	0	\N	2025-07-18 16:43:46.988669	2025-07-18 16:43:46.988669
1338	Ls Át 20A Có Vỏ	ls at 20a co vo	cái	85000	0	\N	2025-07-18 16:43:46.990683	2025-07-18 16:43:46.990683
1339	Ls Át 30A	ls at 30a	cái	85000	0	\N	2025-07-18 16:43:46.992683	2025-07-18 16:43:46.992683
1340	Ls Át 30A Không Vỏ	ls at 30a khong vo	cái	75000	0	\N	2025-07-18 16:43:46.995683	2025-07-18 16:43:46.995683
1341	Ls Át 3P 4 Cực 100A	ls at 3p 4 cuc 100a	cái	950000	0	\N	2025-07-18 16:43:46.998646	2025-07-18 16:43:46.998646
1342	Ls Át Cài 1/16A	ls at cai 1/16a	cái	55000	0	\N	2025-07-18 16:43:47.000645	2025-07-18 16:43:47.000645
1343	Ls Át Cài 2/100	ls at cai 2/100	cái	350000	0	\N	2025-07-18 16:43:47.003667	2025-07-18 16:43:47.003667
1344	Ls Át Cài 2/80A	ls at cai 2/80a	cái	350000	0	\N	2025-07-18 16:43:47.006683	2025-07-18 16:43:47.006683
1345	Ls Át Cài 3/100A	ls at cai 3/100a	cái	580000	0	\N	2025-07-18 16:43:47.008683	2025-07-18 16:43:47.008683
1346	Ls Át Cài 3/25A	ls at cai 3/25a	cái	230000	0	\N	2025-07-18 16:43:47.011772	2025-07-18 16:43:47.011772
1347	Ls Át Cài 3/32A	ls at cai 3/32a	cái	220000	0	\N	2025-07-18 16:43:47.01484	2025-07-18 16:43:47.01484
1348	Ls Át Cài 3/40A	ls at cai 3/40a	cái	230000	0	\N	2025-07-18 16:43:47.01684	2025-07-18 16:43:47.01684
1349	Ls Át Cài 3/50A	ls at cai 3/50a	cái	230000	0	\N	2025-07-18 16:43:47.019871	2025-07-18 16:43:47.019871
1350	Ls Át Cài 3/63A	ls at cai 3/63a	cái	230000	0	\N	2025-07-18 16:43:47.022841	2025-07-18 16:43:47.022841
1351	Ls Át Chống Giật Rcbo Ls 32 Grhc 20A	ls at chong giat rcbo ls 32 grhc 20a	cái	250000	0	\N	2025-07-18 16:43:47.025855	2025-07-18 16:43:47.025855
1352	Ls Át Đơn 1/20A	ls at don 1/20a	cái	55000	0	\N	2025-07-18 16:43:47.027855	2025-07-18 16:43:47.027855
1353	Ls Át Khối 3/100 A	ls at khoi 3/100 a	cái	1170000	0	\N	2025-07-18 16:43:47.028857	2025-07-18 16:43:47.028857
1354	Ls Át Khối 3/30A	ls at khoi 3/30a	cái	880000	0	\N	2025-07-18 16:43:47.031871	2025-07-18 16:43:47.031871
1355	Ls Át Khối 3/50A	ls at khoi 3/50a	cái	880000	0	\N	2025-07-18 16:43:47.035414	2025-07-18 16:43:47.035414
1356	Ls Át Khối 3/60A	ls at khoi 3/60a	cái	1170000	0	\N	2025-07-18 16:43:47.037413	2025-07-18 16:43:47.037413
1357	Ls Át Khối 3/75A	ls at khoi 3/75a	cái	1170000	0	\N	2025-07-18 16:43:47.040414	2025-07-18 16:43:47.040414
1358	Ls Át Khối 4/100 A Ls	ls at khoi 4/100 a ls	cái	1050000	0	\N	2025-07-18 16:43:47.042413	2025-07-18 16:43:47.042413
1359	Ls Át Khối 4/250A	ls at khoi 4/250a	cái	1700000	0	\N	2025-07-18 16:43:47.045375	2025-07-18 16:43:47.045375
1360	Ls Át Khối 4/50 A Ls	ls at khoi 4/50 a ls	cái	750000	0	\N	2025-07-18 16:43:47.047414	2025-07-18 16:43:47.047414
1361	Ls Mặt Át	ls mat at	cái	10000	0	\N	2025-07-18 16:43:47.049414	2025-07-18 16:43:47.049414
1362	Lu Cán Vang	lu can vang	cái	25000	0	\N	2025-07-18 16:43:47.052414	2025-07-18 16:43:47.052414
1363	Lu Dầu 10 Cm	lu dau 10 cm	cái	8000	0	\N	2025-07-18 16:43:47.055397	2025-07-18 16:43:47.055397
1364	Lu Dầu 6 Cm	lu dau 6 cm	cái	7000	0	\N	2025-07-18 16:43:47.056398	2025-07-18 16:43:47.056398
1365	Lu Sơn Bé Lâm Tuấn 10	lu son be lam tuan 10	cái	10000	0	\N	2025-07-18 16:43:47.058399	2025-07-18 16:43:47.058399
1366	Lu Sơn To Lâm Tuấn	lu son to lam tuan	cái	20000	0	\N	2025-07-18 16:43:47.060414	2025-07-18 16:43:47.060414
1367	Lu Sơn Trung Lâm Tuấn	lu son trung lam tuan	cái	15000	0	\N	2025-07-18 16:43:47.062414	2025-07-18 16:43:47.062414
1368	Lu Sơn Vàng 15 Cm	lu son vang 15 cm	cái	17000	0	\N	2025-07-18 16:43:47.065414	2025-07-18 16:43:47.065414
1369	Lu Sơn Vàng 22 Cm	lu son vang 22 cm	cái	22000	0	\N	2025-07-18 16:43:47.067399	2025-07-18 16:43:47.067399
1370	Lục Giá 3 Xám	luc gia 3 xam	cái	10000	0	\N	2025-07-18 16:43:47.068431	2025-07-18 16:43:47.068431
1371	Lục Giá 6 Xám	luc gia 6 xam	cái	20000	0	\N	2025-07-18 16:43:47.070444	2025-07-18 16:43:47.070444
1372	Lục Giác 12 Xám	luc giac 12 xam	cái	70000	0	\N	2025-07-18 16:43:47.073444	2025-07-18 16:43:47.073444
1373	Lục Giác 3 Xám	luc giac 3 xam	cái	12000	0	\N	2025-07-18 16:43:47.076416	2025-07-18 16:43:47.076416
1374	Lục Giác Tiger Bộ	luc giac tiger bo	bộ	65000	0	\N	2025-07-18 16:43:47.078429	2025-07-18 16:43:47.078429
1375	Lục Giác Xám Tốt	luc giac xam tot	bộ	125000	0	\N	2025-07-18 16:43:47.081445	2025-07-18 16:43:47.081445
1376	Lược Đồng 1 Pha	luoc dong 1 pha	m	75000	0	\N	2025-07-18 16:43:47.08299	2025-07-18 16:43:47.08299
1377	Lược Đồng 1 Pha 2 Răng	luoc dong 1 pha 2 rang	cái	95000	0	\N	2025-07-18 16:43:47.085041	2025-07-18 16:43:47.085041
1378	Lược Đồng 3 Pha	luoc dong 3 pha	thanh	145000	0	\N	2025-07-18 16:43:47.089584	2025-07-18 16:43:47.089584
1379	Lưới Cáo Trắng	luoi cao trang	m	20000	0	\N	2025-07-18 16:43:47.091596	2025-07-18 16:43:47.091596
1380	Lưới Cáo Xanh Bọc 1C/15M	luoi cao xanh boc 1c/15m	m	20000	0	\N	2025-07-18 16:43:47.093607	2025-07-18 16:43:47.093607
1381	Lưỡi Cắt Bê Tông Hb	luoi cat be tong hb	cái	55000	0	\N	2025-07-18 16:43:47.09662	2025-07-18 16:43:47.09662
1382	Lưỡi Cắt Gạch D125 Bogo	luoi cat gach d125 bogo	cái	95000	0	\N	2025-07-18 16:43:47.099605	2025-07-18 16:43:47.099605
1383	Lưỡi Cắt Gạch Đa Năng Đắt	luoi cat gach da nang dat	cái	160000	0	\N	2025-07-18 16:43:47.101621	2025-07-18 16:43:47.101621
1384	Lưỡi Cắt Gạch Tiger	luoi cat gach tiger	cái	95000	0	\N	2025-07-18 16:43:47.10362	2025-07-18 16:43:47.10362
1385	Lưỡi Cắt Gỗ D100 Apot	luoi cat go d100 apot	cái	50000	0	\N	2025-07-18 16:43:47.106607	2025-07-18 16:43:47.106607
1386	Lưỡi Cắt Gỗ D350	luoi cat go d350	cái	0	0	\N	2025-07-18 16:43:47.10862	2025-07-18 16:43:47.10862
1387	Lưỡi Cắt Kính	luoi cat kinh	cái	50000	0	\N	2025-07-18 16:43:47.111607	2025-07-18 16:43:47.111607
1388	Lưỡi Cắt Sắt D100	luoi cat sat d100	cái	5000	0	\N	2025-07-18 16:43:47.113604	2025-07-18 16:43:47.113604
1389	Lưỡi Cắt Sắt D125	luoi cat sat d125	cái	10000	0	\N	2025-07-18 16:43:47.11562	2025-07-18 16:43:47.11562
1390	Lưỡi Cắt Sắt D350 Đen	luoi cat sat d350 den	cái	0	0	\N	2025-07-18 16:43:47.11762	2025-07-18 16:43:47.11762
1391	Lưỡi Cắt Sắt D350 Đỏ	luoi cat sat d350 do	cái	0	0	\N	2025-07-18 16:43:47.120667	2025-07-18 16:43:47.120667
1392	Lưỡi Cắt Sắt D350 Tiger	luoi cat sat d350 tiger	cái	38000	0	\N	2025-07-18 16:43:47.123653	2025-07-18 16:43:47.123653
1393	Lưới Chống Thấm	luoi chong tham	cuộn	380000	0	\N	2025-07-18 16:43:47.125652	2025-07-18 16:43:47.125652
1394	Lưỡi Cưa Sắt	luoi cua sat	cái	7000	0	\N	2025-07-18 16:43:47.127667	2025-07-18 16:43:47.127667
1395	Lưới Cước	luoi cuoc	m	10000	0	\N	2025-07-18 16:43:47.130654	2025-07-18 16:43:47.130654
1396	Lưỡi Dao Trổ	luoi dao tro	hộp	10000	0	\N	2025-07-18 16:43:47.133173	2025-07-18 16:43:47.133173
1397	Lưới Đen	luoi den	kg	30000	0	\N	2025-07-18 16:43:47.13622	2025-07-18 16:43:47.13622
1398	Lưới Hàn 5 Đẹp	luoi han 5 dep	m	25000	0	\N	2025-07-18 16:43:47.138206	2025-07-18 16:43:47.138206
1399	Lưỡi Mài Bê Tông R	luoi mai be tong r	cái	35000	0	\N	2025-07-18 16:43:47.14022	2025-07-18 16:43:47.14022
1400	Lưới Sàng Cát	luoi sang cat	kg	38000	0	\N	2025-07-18 16:43:47.14322	2025-07-18 16:43:47.14322
1401	Lưới Sàng Cát Trắng	luoi sang cat trang	m	25000	0	\N	2025-07-18 16:43:47.146206	2025-07-18 16:43:47.146206
1402	Lưới Sàng Cát Xanh	luoi sang cat xanh	m	35000	0	\N	2025-07-18 16:43:47.148206	2025-07-18 16:43:47.148206
1403	Lưới Thach Cao	luoi thach cao	cuộn	30000	0	\N	2025-07-18 16:43:47.15022	2025-07-18 16:43:47.15022
1404	Lưới Thái Đen	luoi thai den	m	16000	0	\N	2025-07-18 16:43:47.153232	2025-07-18 16:43:47.153232
1405	Lưới Thủy Tinh	luoi thuy tinh	m	16000	0	\N	2025-07-18 16:43:47.156207	2025-07-18 16:43:47.156207
1406	Lưới Trám	luoi tram	cuộn	450000	0	\N	2025-07-18 16:43:47.159221	2025-07-18 16:43:47.159221
1407	Lưới Trắng	luoi trang	kg	55000	0	\N	2025-07-18 16:43:47.16222	2025-07-18 16:43:47.16222
1408	Lưới Xanh Đắt	luoi xanh dat	kg	60000	0	\N	2025-07-18 16:43:47.165221	2025-07-18 16:43:47.165221
1409	Mã Lý	ma ly	cái	40000	0	\N	2025-07-18 16:43:47.169223	2025-07-18 16:43:47.169223
1410	Mã Lý Bé	ma ly be	cái	35000	0	\N	2025-07-18 16:43:47.171222	2025-07-18 16:43:47.171222
1411	Mắc Áo R	mac ao r	cái	40000	0	\N	2025-07-18 16:43:47.173237	2025-07-18 16:43:47.173237
1412	Mắc Áo Vinahasa	mac ao vinahasa	cái	70000	0	\N	2025-07-18 16:43:47.176198	2025-07-18 16:43:47.176198
1413	Mai	mai	cái	50000	0	\N	2025-07-18 16:43:47.179222	2025-07-18 16:43:47.179222
1414	Mài Kính	mai kinh	cái	55000	0	\N	2025-07-18 16:43:47.180221	2025-07-18 16:43:47.180221
1415	Makita Máy Vít M0600B-10 350 W	makita may vit m0600b-10 350 w	cái	720000	0	\N	2025-07-18 16:43:47.183714	2025-07-18 16:43:47.183714
1416	Man Gan	man gan	bao	210000	0	\N	2025-07-18 16:43:47.186917	2025-07-18 16:43:47.186917
1417	Màng Bọc	mang boc	cuộn	75000	0	\N	2025-07-18 16:43:47.188988	2025-07-18 16:43:47.188988
1418	Màng Chít 5 Kg	mang chit 5 kg	cuộn	170000	0	\N	2025-07-18 16:43:47.192717	2025-07-18 16:43:47.192717
1419	Màng Co 2,1 Kg	mang co 2,1 kg	cuộn	60000	0	\N	2025-07-18 16:43:47.194727	2025-07-18 16:43:47.194727
1420	Màng Co 2X2 Kg	mang co 2x2 kg	cuộn	75000	0	\N	2025-07-18 16:43:47.196729	2025-07-18 16:43:47.196729
1421	Màng Co 30 Cm Ngắn	mang co 30 cm ngan	cuộn	75000	0	\N	2025-07-18 16:43:47.198721	2025-07-18 16:43:47.198721
1422	Màng Co 5 Kg	mang co 5 kg	cuộn	165000	0	\N	2025-07-18 16:43:47.201743	2025-07-18 16:43:47.201743
1423	Máng Dẹt 100X40	mang det 100x40	cây	120000	0	\N	2025-07-18 16:43:47.203729	2025-07-18 16:43:47.203729
1424	Máng Dẹt 100X60	mang det 100x60	cây	199000	0	\N	2025-07-18 16:43:47.205743	2025-07-18 16:43:47.205743
1425	Máng Dẹt 14X8	mang det 14x8	cây	8000	0	\N	2025-07-18 16:43:47.207742	2025-07-18 16:43:47.207742
1426	Máng Dẹt 16X14	mang det 16x14	cây	12600	0	\N	2025-07-18 16:43:47.212108	2025-07-18 16:43:47.212108
1427	Máng Dẹt 24X14	mang det 24x14	cây	17200	0	\N	2025-07-18 16:43:47.214152	2025-07-18 16:43:47.214152
1428	Máng Dẹt 30X14	mang det 30x14	cây	24000	0	\N	2025-07-18 16:43:47.218166	2025-07-18 16:43:47.218166
1429	Máng Dẹt 39X18	mang det 39x18	cây	31000	0	\N	2025-07-18 16:43:47.222212	2025-07-18 16:43:47.222212
1430	Máng Dẹt 60X40	mang det 60x40	cây	75000	0	\N	2025-07-18 16:43:47.225197	2025-07-18 16:43:47.225197
1431	Máng Dẹt 66X22	mang det 66x22	cây	60800	0	\N	2025-07-18 16:43:47.227212	2025-07-18 16:43:47.227212
1432	Máng Dẹt 80X40	mang det 80x40	cây	104000	0	\N	2025-07-18 16:43:47.230177	2025-07-18 16:43:47.230177
1433	Máng Dẹt 80X60	mang det 80x60	cây	159000	0	\N	2025-07-18 16:43:47.234181	2025-07-18 16:43:47.234181
1434	Máng Đôi 1.2 Thường	mang doi 1.2 thuong	cái	35000	0	\N	2025-07-18 16:43:47.237195	2025-07-18 16:43:47.237195
1435	Măng Sông Ghen Cam 50/40	mang song ghen cam 50/40	cái	17000	0	\N	2025-07-18 16:43:47.239209	2025-07-18 16:43:47.239209
1436	Máng Tôn	mang ton	cái	35000	0	\N	2025-07-18 16:43:47.241213	2025-07-18 16:43:47.241213
1437	Máng Vữa	mang vua	cái	35000	0	\N	2025-07-18 16:43:47.243208	2025-07-18 16:43:47.243208
1438	Mặt 3 Lỗ Xám Ánh Kim	mat 3 lo xam anh kim	cái	89000	0	\N	2025-07-18 16:43:47.246209	2025-07-18 16:43:47.246209
1439	Mặt Át	mat at	cái	11200	0	\N	2025-07-18 16:43:47.248347	2025-07-18 16:43:47.248347
1440	Mặt Che Mưa Lioa	mat che mua lioa	cái	60000	0	\N	2025-07-18 16:43:47.251341	2025-07-18 16:43:47.251341
1441	Mặt Che Mưa Simon	mat che mua simon	cái	100000	0	\N	2025-07-18 16:43:47.253342	2025-07-18 16:43:47.253342
1442	Mặt Che Trơn	mat che tron	cái	10000	0	\N	2025-07-18 16:43:47.257449	2025-07-18 16:43:47.257449
1443	Mặt Chống Nước Lioa	mat chong nuoc lioa	cái	60000	0	\N	2025-07-18 16:43:47.261478	2025-07-18 16:43:47.261478
1444	Máy Akuza B350 Pro	may akuza b350 pro	cái	1350000	0	\N	2025-07-18 16:43:47.266467	2025-07-18 16:43:47.266467
1445	Máy Áp 150 W Seton	may ap 150 w seton	cái	1100000	0	\N	2025-07-18 16:43:47.269466	2025-07-18 16:43:47.269466
1446	Máy Bơm 1,5 Kw 2Tcp25/160B Swirls	may bom 1,5 kw 2tcp25/160b swirls	cái	3300000	0	\N	2025-07-18 16:43:47.271471	2025-07-18 16:43:47.271471
1447	Máy Bơm 1.5Kw Hai Tầng	may bom 1.5kw hai tang	cái	2950000	0	\N	2025-07-18 16:43:47.273473	2025-07-18 16:43:47.273473
1448	Máy Bơm 200 Reken	may bom 200 reken	cái	1350000	0	\N	2025-07-18 16:43:47.275473	2025-07-18 16:43:47.275473
1449	Máy Bơm 300W Reken	may bom 300w reken	cái	1450000	0	\N	2025-07-18 16:43:47.278475	2025-07-18 16:43:47.278475
1450	Máy Bơm 5 Cánh Lenovo	may bom 5 canh lenovo	cái	3300000	0	\N	2025-07-18 16:43:47.280473	2025-07-18 16:43:47.280473
1451	Máy Bơm Áp 130 Reken	may bom ap 130 reken	cái	1600000	0	\N	2025-07-18 16:43:47.282474	2025-07-18 16:43:47.282474
1452	Máy Bơm Áp 150 W	may bom ap 150 w	cái	1650000	0	\N	2025-07-18 16:43:47.284476	2025-07-18 16:43:47.284476
1453	Máy Bơm Áp 150 W Seton	may bom ap 150 w seton	cái	1150000	0	\N	2025-07-18 16:43:47.288536	2025-07-18 16:43:47.288536
1454	Máy Bơm Áp 200 A Reken	may bom ap 200 a reken	cái	1700000	0	\N	2025-07-18 16:43:47.291646	2025-07-18 16:43:47.291646
1455	Máy Bơm Áp 400W	may bom ap 400w	cái	2100000	0	\N	2025-07-18 16:43:47.294645	2025-07-18 16:43:47.294645
1456	Máy Bơm Áp Sa 100 Swing	may bom ap sa 100 swing	cái	850000	0	\N	2025-07-18 16:43:47.297255	2025-07-18 16:43:47.297255
1457	Máy Bơm Áp Teasung 200W	may bom ap teasung 200w	cái	1850000	0	\N	2025-07-18 16:43:47.300267	2025-07-18 16:43:47.300267
1458	Máy Bơm Chân Không Reken 800 W	may bom chan khong reken 800 w	cái	2350000	0	\N	2025-07-18 16:43:47.302267	2025-07-18 16:43:47.302267
1459	Máy Bơm Đĩa 750 Tiến Phát	may bom dia 750 tien phat	cái	1450000	0	\N	2025-07-18 16:43:47.304264	2025-07-18 16:43:47.304264
1460	Máy Bơm Đĩa Inoc	may bom dia inoc	cái	1550000	0	\N	2025-07-18 16:43:47.306273	2025-07-18 16:43:47.306273
1461	Máy Bơm Lơn	may bom lon	cái	1700000	0	\N	2025-07-18 16:43:47.309265	2025-07-18 16:43:47.309265
1462	Máy Bơm Lợn 750 Tiến Phát	may bom lon 750 tien phat	cái	1200000	0	\N	2025-07-18 16:43:47.311688	2025-07-18 16:43:47.311688
1463	Máy Bơm Lợn 750W Bảo Long	may bom lon 750w bao long	cái	1150000	0	\N	2025-07-18 16:43:47.313718	2025-07-18 16:43:47.313718
1464	Máy Bơm Máy Cắt Chuột	may bom may cat chuot	cái	270000	0	\N	2025-07-18 16:43:47.315734	2025-07-18 16:43:47.315734
1465	Máy Bơm Reken 300 W Chân Không	may bom reken 300 w chan khong	cái	1450000	0	\N	2025-07-18 16:43:47.318735	2025-07-18 16:43:47.318735
1466	Máy Bơm Reken 400 W Chân Không	may bom reken 400 w chan khong	cái	1570000	0	\N	2025-07-18 16:43:47.321766	2025-07-18 16:43:47.321766
1467	Máy Bơm Seton 150 W Chân Không	may bom seton 150 w chan khong	cái	750000	0	\N	2025-07-18 16:43:47.324766	2025-07-18 16:43:47.324766
1468	Máy Bơm Swing 1,5 Kw 2 Tầng Cánh	may bom swing 1,5 kw 2 tang canh	cái	3300000	0	\N	2025-07-18 16:43:47.32678	2025-07-18 16:43:47.32678
1469	Máy Bơm Tõm 750 W Có Phao	may bom tom 750 w co phao	cái	2450000	0	\N	2025-07-18 16:43:47.32878	2025-07-18 16:43:47.32878
1470	Máy Bơm Tõm Swing	may bom tom swing	cái	2700000	0	\N	2025-07-18 16:43:47.33178	2025-07-18 16:43:47.33178
1471	Máy Cắt 350 Carotex	may cat 350 carotex	cái	1450000	0	\N	2025-07-18 16:43:47.33478	2025-07-18 16:43:47.33478
1472	Máy Cắt 350 Feg	may cat 350 feg	cái	1850000	0	\N	2025-07-18 16:43:47.336331	2025-07-18 16:43:47.336331
1473	Máy Cắt Bàn 350 Makita	may cat ban 350 makita	cái	2800000	0	\N	2025-07-18 16:43:47.339346	2025-07-18 16:43:47.339346
1474	Máy Cắt Cầm Tay Dong Cheng	may cat cam tay dong cheng	cái	650000	0	\N	2025-07-18 16:43:47.340331	2025-07-18 16:43:47.340331
1475	Máy Cắt Cầm Tay Dong Cheng 06-810 W	may cat cam tay dong cheng 06-810 w	cái	700000	0	\N	2025-07-18 16:43:47.342333	2025-07-18 16:43:47.342333
1476	Máy Cắt Cầm Tay Makita	may cat cam tay makita	cái	1100000	0	\N	2025-07-18 16:43:47.345329	2025-07-18 16:43:47.345329
1477	Máy Cắt Đông Cheng 110	may cat dong cheng 110	cái	980000	0	\N	2025-07-18 16:43:47.347331	2025-07-18 16:43:47.347331
1478	Máy Cắt Gạch 100 Đong Cheng	may cat gach 100 dong cheng	cái	950000	0	\N	2025-07-18 16:43:47.349345	2025-07-18 16:43:47.349345
1479	Máy Cắt Gạch Makita M 4100- 1200 W	may cat gach makita m 4100- 1200 w	cái	1550000	0	\N	2025-07-18 16:43:47.352345	2025-07-18 16:43:47.352345
1480	Máy Cắt Pin Yamashu	may cat pin yamashu	cái	1750000	0	\N	2025-07-18 16:43:47.354348	2025-07-18 16:43:47.354348
1481	Máy Cốt	may cot	cái	0	0	\N	2025-07-18 16:43:47.357345	2025-07-18 16:43:47.357345
1482	Máy Cốt Laisai	may cot laisai	cái	2250000	0	\N	2025-07-18 16:43:47.359413	2025-07-18 16:43:47.359413
1483	Máy Đẩy Gạch 1.2 M Tobuki	may day gach 1.2 m tobuki	cái	1650000	0	\N	2025-07-18 16:43:47.362399	2025-07-18 16:43:47.362399
1484	Máy Đẩy Gạch F80	may day gach f80	cái	1450000	0	\N	2025-07-18 16:43:47.364414	2025-07-18 16:43:47.364414
1485	Máy Đục 17 Dong Cheng	may duc 17 dong cheng	cái	2050000	0	\N	2025-07-18 16:43:47.3674	2025-07-18 16:43:47.3674
1486	Máy Đục Hugong	may duc hugong	cái	1650000	0	\N	2025-07-18 16:43:47.370461	2025-07-18 16:43:47.370461
1487	Máy Đục Scan	may duc scan	cái	3400000	0	\N	2025-07-18 16:43:47.372446	2025-07-18 16:43:47.372446
1488	Máy Hàn Jasic Zx7 200 E	may han jasic zx7 200 e	cái	2350000	0	\N	2025-07-18 16:43:47.375446	2025-07-18 16:43:47.375446
1489	Máy Hàn Nhiệt Gomes 4150C	may han nhiet gomes 4150c	cái	790000	0	\N	2025-07-18 16:43:47.378447	2025-07-18 16:43:47.378447
1490	Máy Hàn Ống Kapusi	may han ong kapusi	cái	450000	0	\N	2025-07-18 16:43:47.379444	2025-07-18 16:43:47.379444
1491	Máy Khoan Bê Tông Dong Cheng	may khoan be tong dong cheng	cái	1450000	0	\N	2025-07-18 16:43:47.382461	2025-07-18 16:43:47.382461
1492	Máy Khoan Bê Tông Feg 2610	may khoan be tong feg 2610	cái	1200000	0	\N	2025-07-18 16:43:47.384992	2025-07-18 16:43:47.384992
1493	Máy Khoan Bê Tông Pin Yamashu	may khoan be tong pin yamashu	cái	1900000	0	\N	2025-07-18 16:43:47.386039	2025-07-18 16:43:47.386039
1494	Máy Khoan Đục Dong Cheng Dzc05/26	may khoan duc dong cheng dzc05/26	cái	1450000	0	\N	2025-07-18 16:43:47.389603	2025-07-18 16:43:47.389603
1495	Máy Khoan Đục Feg 560 1300W	may khoan duc feg 560 1300w	cái	1480000	0	\N	2025-07-18 16:43:47.392604	2025-07-18 16:43:47.392604
1496	Máy Khoan Pin Yamasu Đầu 10	may khoan pin yamasu dau 10	cái	1300000	0	\N	2025-07-18 16:43:47.394604	2025-07-18 16:43:47.394604
1497	Máy Khoan Rút Lõi Dzz 02-250	may khoan rut loi dzz 02-250	cái	6500000	0	\N	2025-07-18 16:43:47.396618	2025-07-18 16:43:47.396618
1498	Máy Laze Promax	may laze promax	cái	1850000	0	\N	2025-07-18 16:43:47.399604	2025-07-18 16:43:47.399604
1499	Máy Laze Spider 488	may laze spider 488	cái	1500000	0	\N	2025-07-18 16:43:47.400604	2025-07-18 16:43:47.400604
1500	Máy Lọc Nước Kangaru	may loc nuoc kangaru	cái	3600000	0	\N	2025-07-18 16:43:47.403457	2025-07-18 16:43:47.403457
1501	Máy Lọc Nước Karofi	may loc nuoc karofi	cái	3600000	0	\N	2025-07-18 16:43:47.405544	2025-07-18 16:43:47.405544
1502	Máy Mài Góc Makita 9553 Nb	may mai goc makita 9553 nb	cái	1150000	0	\N	2025-07-18 16:43:47.408155	2025-07-18 16:43:47.408155
1503	Máy Rửa Xe Feg 6708 2300W	may rua xe feg 6708 2300w	cái	1750000	0	\N	2025-07-18 16:43:47.411302	2025-07-18 16:43:47.411302
1504	Máy Rung Gạch Gomez	may rung gach gomez	cái	950000	0	\N	2025-07-18 16:43:47.413349	2025-07-18 16:43:47.413349
1505	Máy Vít Đầu 10 Yamashu	may vit dau 10 yamashu	cái	1250000	0	\N	2025-07-18 16:43:47.415349	2025-07-18 16:43:47.415349
1506	Máy Vít Makita Đầu 13	may vit makita dau 13	cái	1150000	0	\N	2025-07-18 16:43:47.4185	2025-07-18 16:43:47.4185
1507	Máy Vít Makita M6001B	may vit makita m6001b	cái	950000	0	\N	2025-07-18 16:43:47.421528	2025-07-18 16:43:47.421528
1508	Máy Vít Pin 13 Yamashu	may vit pin 13 yamashu	cái	1650000	0	\N	2025-07-18 16:43:47.424579	2025-07-18 16:43:47.424579
1509	Máy Xpower 16,8 V	may xpower 16,8 v	cái	850000	0	\N	2025-07-18 16:43:47.426578	2025-07-18 16:43:47.426578
1510	Miếng Kính Hàn Đen	mieng kinh han den	cái	3000	0	\N	2025-07-18 16:43:47.428578	2025-07-18 16:43:47.428578
1511	Mo Đội Đầu	mo doi dau	cái	45000	0	\N	2025-07-18 16:43:47.431579	2025-07-18 16:43:47.431579
1512	Mỡ Hàn	mo han	hộp	30000	0	\N	2025-07-18 16:43:47.433543	2025-07-18 16:43:47.433543
1513	Mo Hàn Cầm Tay	mo han cam tay	cái	20000	0	\N	2025-07-18 16:43:47.437371	2025-07-18 16:43:47.437371
1514	Mo Hàn Đội Đầu	mo han doi dau	cái	45000	0	\N	2025-07-18 16:43:47.43937	2025-07-18 16:43:47.43937
1515	Mỏ Hàn Xung	mo han xung	cái	155000	0	\N	2025-07-18 16:43:47.442371	2025-07-18 16:43:47.442371
1516	Mỏ Lết 10 Trắng	mo let 10 trang	cái	55000	0	\N	2025-07-18 16:43:47.443372	2025-07-18 16:43:47.443372
1517	Mỏ Lết 12 Trắng	mo let 12 trang	cái	60000	0	\N	2025-07-18 16:43:47.445703	2025-07-18 16:43:47.445703
1518	Mỏ Lết 300	mo let 300	cái	0	0	\N	2025-07-18 16:43:47.448703	2025-07-18 16:43:47.448703
1519	Mỏ Lết 500	mo let 500	cái	0	0	\N	2025-07-18 16:43:47.450703	2025-07-18 16:43:47.450703
1520	Mỏ Lết 700	mo let 700	cái	0	0	\N	2025-07-18 16:43:47.452704	2025-07-18 16:43:47.452704
1521	Mỏ Lết 8 Trắng	mo let 8 trang	cái	35000	0	\N	2025-07-18 16:43:47.456279	2025-07-18 16:43:47.456279
1522	Mô Tơ	mo to	cái	1800000	0	\N	2025-07-18 16:43:47.458292	2025-07-18 16:43:47.458292
1523	Mỡ Vàng 1Th/20 Kg	mo vang 1th/20 kg	kg	100000	0	\N	2025-07-18 16:43:47.461292	2025-07-18 16:43:47.461292
1524	Móc Áo 113 Vinahasa	moc ao 113 vinahasa	cái	45000	0	\N	2025-07-18 16:43:47.464278	2025-07-18 16:43:47.464278
1525	Móc Áo 114 Vinahasa	moc ao 114 vinahasa	cái	75000	0	\N	2025-07-18 16:43:47.467276	2025-07-18 16:43:47.467276
1526	Móc Áo Chữ M	moc ao chu m	cái	100000	0	\N	2025-07-18 16:43:47.469292	2025-07-18 16:43:47.469292
1527	Móc Đế 15Cm	moc de 15cm	cái	20000	0	\N	2025-07-18 16:43:47.471323	2025-07-18 16:43:47.471323
1528	Móc Quạt 20 Cm	moc quat 20 cm	cái	25000	0	\N	2025-07-18 16:43:47.474323	2025-07-18 16:43:47.474323
1529	Móc Quạt 25 Cm	moc quat 25 cm	cái	30000	0	\N	2025-07-18 16:43:47.477325	2025-07-18 16:43:47.477325
1530	Móc Quạt 40 Cm	moc quat 40 cm	cái	40000	0	\N	2025-07-18 16:43:47.480309	2025-07-18 16:43:47.480309
1531	Móc Quạt 50 Cm	moc quat 50 cm	cái	50000	0	\N	2025-07-18 16:43:47.482324	2025-07-18 16:43:47.482324
1532	Móc Quạt 55 Cm	moc quat 55 cm	cái	55000	0	\N	2025-07-18 16:43:47.484324	2025-07-18 16:43:47.484324
1533	Móc Quạt 60 Cm	moc quat 60 cm	cái	60000	0	\N	2025-07-18 16:43:47.486459	2025-07-18 16:43:47.486459
1534	Móc Quạt Đế 15 Cm	moc quat de 15 cm	cái	20000	0	\N	2025-07-18 16:43:47.490002	2025-07-18 16:43:47.490002
1535	Móc Quạt Đế 35 Cm	moc quat de 35 cm	cái	35000	0	\N	2025-07-18 16:43:47.490988	2025-07-18 16:43:47.490988
1536	Móc Quạt Inox 15 Cm	moc quat inox 15 cm	cái	18000	0	\N	2025-07-18 16:43:47.493002	2025-07-18 16:43:47.493002
1537	Móc Trần 10 Cm	moc tran 10 cm	cái	16000	0	\N	2025-07-18 16:43:47.496002	2025-07-18 16:43:47.496002
1538	Móc Trần 20 Cm	moc tran 20 cm	cái	18000	0	\N	2025-07-18 16:43:47.498988	2025-07-18 16:43:47.498988
1539	Móc Trần 30	moc tran 30	cái	35000	0	\N	2025-07-18 16:43:47.500994	2025-07-18 16:43:47.500994
1540	Móc Trần 40 Cm	moc tran 40 cm	cái	45000	0	\N	2025-07-18 16:43:47.502988	2025-07-18 16:43:47.502988
1541	Móc Trần 50 Cm Đế	moc tran 50 cm de	cái	50000	0	\N	2025-07-18 16:43:47.505002	2025-07-18 16:43:47.505002
1542	Móc Trần 55 Cm Đế	moc tran 55 cm de	cái	55000	0	\N	2025-07-18 16:43:47.506988	2025-07-18 16:43:47.506988
1543	Móc Trần Bản Mã 15	moc tran ban ma 15	cái	25000	0	\N	2025-07-18 16:43:47.509002	2025-07-18 16:43:47.509002
1544	Móc Trần Đế 20 Cm	moc tran de 20 cm	cái	25000	0	\N	2025-07-18 16:43:47.512988	2025-07-18 16:43:47.512988
1545	Móc Trần Đế 25 Cm	moc tran de 25 cm	cái	25000	0	\N	2025-07-18 16:43:47.515002	2025-07-18 16:43:47.515002
1546	Móc Trần Đế 35 Cm	moc tran de 35 cm	cái	35000	0	\N	2025-07-18 16:43:47.518002	2025-07-18 16:43:47.518002
1547	Móc Trần Đế 45 Cm	moc tran de 45 cm	cái	45000	0	\N	2025-07-18 16:43:47.520002	2025-07-18 16:43:47.520002
1548	Móc Trần Inoc	moc tran inoc	cái	18000	0	\N	2025-07-18 16:43:47.523038	2025-07-18 16:43:47.523038
1549	Móc Trần Inox 10	moc tran inox 10	cái	20000	0	\N	2025-07-18 16:43:47.525035	2025-07-18 16:43:47.525035
1550	Msrn Inox 1/2 (Ms 15)	msrn inox 1/2 (ms 15)	cái	0	0	\N	2025-07-18 16:43:47.527035	2025-07-18 16:43:47.527035
1551	Msrn Inox 3/4 (Ms 20)	msrn inox 3/4 (ms 20)	cái	0	0	\N	2025-07-18 16:43:47.528035	2025-07-18 16:43:47.528035
1552	Msrt Inox 1/2 (Ms 15)	msrt inox 1/2 (ms 15)	cái	12000	0	\N	2025-07-18 16:43:47.531048	2025-07-18 16:43:47.531048
1553	Msrt Inox 3/4 (Ms 20)	msrt inox 3/4 (ms 20)	cái	20000	0	\N	2025-07-18 16:43:47.534035	2025-07-18 16:43:47.534035
1554	Mũ Bảo Hộ Seda Đắt	mu bao ho seda dat	cái	95000	0	\N	2025-07-18 16:43:47.535563	2025-07-18 16:43:47.535563
1555	Mũ Bảo Hộ Vàng	mu bao ho vang	cái	18000	0	\N	2025-07-18 16:43:47.537611	2025-07-18 16:43:47.537611
1556	Mũ Lá	mu la	cái	25000	0	\N	2025-07-18 16:43:47.541611	2025-07-18 16:43:47.541611
1557	Mực Tàu	muc tau	hộp	20000	0	\N	2025-07-18 16:43:47.544578	2025-07-18 16:43:47.544578
1558	Mũi Inox 2.5 Avata	mui inox 2.5 avata	cái	8000	0	\N	2025-07-18 16:43:47.548599	2025-07-18 16:43:47.548599
1559	Mũi Inox 6 Avata	mui inox 6 avata	cái	16000	0	\N	2025-07-18 16:43:47.551599	2025-07-18 16:43:47.551599
1560	Mũi Khoan 6 Đa Năng Tiger	mui khoan 6 da nang tiger	cái	30000	0	\N	2025-07-18 16:43:47.553611	2025-07-18 16:43:47.553611
1561	Mũi Khoan 8 Bê Tông Avata	mui khoan 8 be tong avata	cái	20000	0	\N	2025-07-18 16:43:47.556612	2025-07-18 16:43:47.556612
1562	Mũi Khoan Bê Tông 10	mui khoan be tong 10	cái	0	0	\N	2025-07-18 16:43:47.558595	2025-07-18 16:43:47.558595
1563	Mũi Khoan Bê Tông 12	mui khoan be tong 12	cái	0	0	\N	2025-07-18 16:43:47.561597	2025-07-18 16:43:47.561597
1564	Mũi Khoan Bê Tông 22 Tiger	mui khoan be tong 22 tiger	cái	105000	0	\N	2025-07-18 16:43:47.563611	2025-07-18 16:43:47.563611
1565	Mũi Khoan Bê Tông 6 Makhi	mui khoan be tong 6 makhi	cái	20000	0	\N	2025-07-18 16:43:47.566597	2025-07-18 16:43:47.566597
1566	Mũi Khoan Bt 10 Boss	mui khoan bt 10 boss	cái	35000	0	\N	2025-07-18 16:43:47.569611	2025-07-18 16:43:47.569611
1567	Mũi Khoan Bt 14 Boss	mui khoan bt 14 boss	cái	50000	0	\N	2025-07-18 16:43:47.571658	2025-07-18 16:43:47.571658
1568	Mũi Khoan Bt 18	mui khoan bt 18	cái	85000	0	\N	2025-07-18 16:43:47.573658	2025-07-18 16:43:47.573658
1569	Mũi Khoan Inoc 5 Boss	mui khoan inoc 5 boss	cái	16000	0	\N	2025-07-18 16:43:47.577644	2025-07-18 16:43:47.577644
1570	Mũi Khoan Inox 1.5	mui khoan inox 1.5	cái	7000	0	\N	2025-07-18 16:43:47.580643	2025-07-18 16:43:47.580643
1571	Mũi Khoan Inox 10	mui khoan inox 10	cái	35000	0	\N	2025-07-18 16:43:47.582645	2025-07-18 16:43:47.582645
1572	Mũi Khoan Inox 3.5 Boss	mui khoan inox 3.5 boss	cái	11000	0	\N	2025-07-18 16:43:47.584658	2025-07-18 16:43:47.584658
1573	Mũi Khoan Inox 4	mui khoan inox 4	cái	8000	0	\N	2025-07-18 16:43:47.587735	2025-07-18 16:43:47.587735
1574	Mũi Khoan Inox 5	mui khoan inox 5	cái	15000	0	\N	2025-07-18 16:43:47.590772	2025-07-18 16:43:47.590772
1575	Mũi Khoan Inox 6 Boss	mui khoan inox 6 boss	cái	20000	0	\N	2025-07-18 16:43:47.592786	2025-07-18 16:43:47.592786
1576	Mũi Khoan Rút Lõi	mui khoan rut loi	số	4500	0	\N	2025-07-18 16:43:47.595786	2025-07-18 16:43:47.595786
1577	Mũi Khoan Rút Lõi 102	mui khoan rut loi 102	số	4500	0	\N	2025-07-18 16:43:47.597786	2025-07-18 16:43:47.597786
1578	Mũi Khoan Rút Lõi 25	mui khoan rut loi 25	cái	0	0	\N	2025-07-18 16:43:47.600786	2025-07-18 16:43:47.600786
1579	Mũi Khoan Rút Lõi 50	mui khoan rut loi 50	cái	0	0	\N	2025-07-18 16:43:47.602772	2025-07-18 16:43:47.602772
1580	Mũi Khoan Rút Lõi Số 63	mui khoan rut loi so 63	cái	280000	0	\N	2025-07-18 16:43:47.605789	2025-07-18 16:43:47.605789
1581	Mũi Khoan Sắt 12	mui khoan sat 12	cái	20000	0	\N	2025-07-18 16:43:47.607786	2025-07-18 16:43:47.607786
1582	Mũi Khoét Gỗ Loại Thường	mui khoet go loai thuong	cái	0	0	\N	2025-07-18 16:43:47.610763	2025-07-18 16:43:47.610763
1583	Mũi Khoét Gỗ Loại Tốt	mui khoet go loai tot	cái	0	0	\N	2025-07-18 16:43:47.612783	2025-07-18 16:43:47.612783
1584	Mũi Khoét Kính, Đá Loại Thường	mui khoet kinh, da loai thuong	cái	0	0	\N	2025-07-18 16:43:47.614786	2025-07-18 16:43:47.614786
1585	Mũi Khoét Kính, Đá Loại Tốt	mui khoet kinh, da loai tot	cái	0	0	\N	2025-07-18 16:43:47.617787	2025-07-18 16:43:47.617787
1586	Mũi Khoét Sắt Loại Thường	mui khoet sat loai thuong	cái	0	0	\N	2025-07-18 16:43:47.619786	2025-07-18 16:43:47.619786
1587	Mũi Khoét Sắt Loại Tốt	mui khoet sat loai tot	cái	0	0	\N	2025-07-18 16:43:47.623802	2025-07-18 16:43:47.623802
1588	Mút Xoa	mut xoa	cái	3000	0	\N	2025-07-18 16:43:47.625164	2025-07-18 16:43:47.625164
1589	Nắp Bệt 108 Êm	nap bet 108 em	cái	260000	0	\N	2025-07-18 16:43:47.627369	2025-07-18 16:43:47.627369
1590	Nắp Bệt American	nap bet american	cái	820000	0	\N	2025-07-18 16:43:47.630581	2025-07-18 16:43:47.630581
1591	Nắp Chia Ngả	nap chia nga	cái	1600	0	\N	2025-07-18 16:43:47.63316	2025-07-18 16:43:47.63316
1592	Nắp Hộp Chia Ngả	nap hop chia nga	cái	1600	0	\N	2025-07-18 16:43:47.635146	2025-07-18 16:43:47.635146
1593	Nắp Tủ Át Roman	nap tu at roman	cái	50000	0	\N	2025-07-18 16:43:47.636653	2025-07-18 16:43:47.636653
1594	Nẹp Đồng	nep dong	cái	110000	0	\N	2025-07-18 16:43:47.639086	2025-07-18 16:43:47.639086
1595	Nẹp Đồng Đôi	nep dong doi	cái	160000	0	\N	2025-07-18 16:43:47.640635	2025-07-18 16:43:47.641669
1596	Nẹp Góc Trắng	nep goc trang	cái	110000	0	\N	2025-07-18 16:43:47.643684	2025-07-18 16:43:47.643684
1597	Nẹp Góc Vàng	nep goc vang	cái	120000	0	\N	2025-07-18 16:43:47.646669	2025-07-18 16:43:47.646669
1598	Nguồn 12A	nguon 12a	cái	260000	0	\N	2025-07-18 16:43:47.648668	2025-07-18 16:43:47.648668
1599	Nguồn 25A Ngoài Trời	nguon 25a ngoai troi	cái	310000	0	\N	2025-07-18 16:43:47.650683	2025-07-18 16:43:47.650683
1600	Nguồn Đũa 5A	nguon dua 5a	cái	180000	0	\N	2025-07-18 16:43:47.653684	2025-07-18 16:43:47.653684
1601	Nguồn Led 12V 2A Đũa	nguon led 12v 2a dua	cái	80000	0	\N	2025-07-18 16:43:47.656667	2025-07-18 16:43:47.656667
1602	Nguồn Led 12V 3A Đũa	nguon led 12v 3a dua	cái	110000	0	\N	2025-07-18 16:43:47.659684	2025-07-18 16:43:47.659684
1603	Nguồn Led Dây 3 Hàng	nguon led day 3 hang	cái	20000	0	\N	2025-07-18 16:43:47.66067	2025-07-18 16:43:47.66067
1604	Nguồn Led Rạng Đông	nguon led rang dong	cái	40000	0	\N	2025-07-18 16:43:47.66267	2025-07-18 16:43:47.66267
1605	Nguồn Máy Lọc Đài Loan	nguon may loc dai loan	cái	150000	0	\N	2025-07-18 16:43:47.66567	2025-07-18 16:43:47.66567
1606	Nguồn Ngoài Trời 33 A	nguon ngoai troi 33 a	cái	150000	0	\N	2025-07-18 16:43:47.668669	2025-07-18 16:43:47.668669
1607	Nhám Nỉ	nham ni	cái	8500	0	\N	2025-07-18 16:43:47.670683	2025-07-18 16:43:47.670683
1608	Nỉ Đỏ	ni do	cái	8000	0	\N	2025-07-18 16:43:47.67373	2025-07-18 16:43:47.67373
1609	Ni Lông	ni long	kg	20000	0	\N	2025-07-18 16:43:47.675729	2025-07-18 16:43:47.675729
1610	Ni Lông Đắt	ni long dat	kg	35000	0	\N	2025-07-18 16:43:47.67973	2025-07-18 16:43:47.67973
1611	Nỉ Trắng	ni trang	cái	10000	0	\N	2025-07-18 16:43:47.680714	2025-07-18 16:43:47.680714
1612	Ni Vo C Mart	ni vo c mart	cái	35000	0	\N	2025-07-18 16:43:47.683731	2025-07-18 16:43:47.683731
1613	Nivo 20 Cm	nivo 20 cm	cái	20000	0	\N	2025-07-18 16:43:47.684731	2025-07-18 16:43:47.684731
1614	Nơ 1/2 ( Nơ 15 304)	no 1/2 ( no 15 304)	cái	10000	0	\N	2025-07-18 16:43:47.688865	2025-07-18 16:43:47.688865
1615	Nơ 1/2-1/4	no 1/2-1/4	cái	15000	0	\N	2025-07-18 16:43:47.689865	2025-07-18 16:43:47.689865
1616	Nơ 15 Ngắn	no 15 ngan	cái	9000	0	\N	2025-07-18 16:43:47.691877	2025-07-18 16:43:47.691877
1617	Nơ 48/42 Inox	no 48/42 inox	cái	35000	0	\N	2025-07-18 16:43:47.693865	2025-07-18 16:43:47.693865
1618	Nở Bướm	no buom	cái	2000	0	\N	2025-07-18 16:43:47.695878	2025-07-18 16:43:47.695878
1619	Nở Cửa Nhựa 10X10	no cua nhua 10x10	gói	29000	0	\N	2025-07-18 16:43:47.699847	2025-07-18 16:43:47.699847
1620	Nở Cửa Nhựa Inox 10X10	no cua nhua inox 10x10	gói	75000	0	\N	2025-07-18 16:43:47.702863	2025-07-18 16:43:47.702863
1621	Nở Đạn 10	no dan 10	cái	2000	0	\N	2025-07-18 16:43:47.704878	2025-07-18 16:43:47.704878
1622	Nở Đạn 12	no dan 12	cái	4500	0	\N	2025-07-18 16:43:47.707868	2025-07-18 16:43:47.707868
1623	Nở Đạn 6	no dan 6	cái	1000	0	\N	2025-07-18 16:43:47.709879	2025-07-18 16:43:47.709879
1624	Nở Đạn 8	no dan 8	cái	1500	0	\N	2025-07-18 16:43:47.712234	2025-07-18 16:43:47.712234
1625	Nở Đạn12	no dan12	cái	5000	0	\N	2025-07-18 16:43:47.71523	2025-07-18 16:43:47.71523
1626	Nơ Inoc 26/20	no inoc 26/20	cái	25000	0	\N	2025-07-18 16:43:47.718237	2025-07-18 16:43:47.718237
1627	Nở Inox 10X10	no inox 10x10	cái	5500	0	\N	2025-07-18 16:43:47.721244	2025-07-18 16:43:47.721244
1628	Nở Inox 12X10	no inox 12x10	cái	10000	0	\N	2025-07-18 16:43:47.72329	2025-07-18 16:43:47.72329
1629	Nơ Inox 20/15	no inox 20/15	cái	20000	0	\N	2025-07-18 16:43:47.725289	2025-07-18 16:43:47.725289
1630	Nơ Inox 26/20	no inox 26/20	cái	25000	0	\N	2025-07-18 16:43:47.728275	2025-07-18 16:43:47.728275
1631	Nơ Inox 34/25(1-3/4)	no inox 34/25(1-3/4)	cái	25000	0	\N	2025-07-18 16:43:47.730289	2025-07-18 16:43:47.730289
1632	Nơ Inox 42/34	no inox 42/34	cái	35000	0	\N	2025-07-18 16:43:47.733256	2025-07-18 16:43:47.733256
1633	Nơ Inox 48/27	no inox 48/27	cái	35000	0	\N	2025-07-18 16:43:47.735253	2025-07-18 16:43:47.735253
1634	Nơ Inox 48/34	no inox 48/34	cái	35000	0	\N	2025-07-18 16:43:47.737814	2025-07-18 16:43:47.737814
1635	Nở Inox 50	no inox 50	cái	55000	0	\N	2025-07-18 16:43:47.73983	2025-07-18 16:43:47.73983
1636	Nở Inox 6X6	no inox 6x6	cái	2500	0	\N	2025-07-18 16:43:47.741816	2025-07-18 16:43:47.741816
1637	Nở Inox 6X8	no inox 6x8	cái	3000	0	\N	2025-07-18 16:43:47.745051	2025-07-18 16:43:47.745051
1638	Nở Inox 8X10	no inox 8x10	cái	4000	0	\N	2025-07-18 16:43:47.74866	2025-07-18 16:43:47.74866
1639	Nở Inox 8X12	no inox 8x12	cái	4500	0	\N	2025-07-18 16:43:47.751718	2025-07-18 16:43:47.751718
1640	Nở Inox 8X6	no inox 8x6	cái	3500	0	\N	2025-07-18 16:43:47.754705	2025-07-18 16:43:47.754705
1641	Nở Inox 8X8	no inox 8x8	cái	3500	0	\N	2025-07-18 16:43:47.75672	2025-07-18 16:43:47.75672
1642	Nở Móc 10 Sắt	no moc 10 sat	cái	5000	0	\N	2025-07-18 16:43:47.758704	2025-07-18 16:43:47.758704
1643	Nở Móc Sắt 6	no moc sat 6	cái	2000	0	\N	2025-07-18 16:43:47.761719	2025-07-18 16:43:47.761719
1644	Nở Nhựa 14	no nhua 14	cái	500	0	\N	2025-07-18 16:43:47.763718	2025-07-18 16:43:47.763718
1645	Nở Nhựa 16	no nhua 16	cái	1000	0	\N	2025-07-18 16:43:47.766702	2025-07-18 16:43:47.766702
1646	Nở Nhựa 6	no nhua 6	gói	5000	0	\N	2025-07-18 16:43:47.768702	2025-07-18 16:43:47.768702
1647	Nở Nhựa Số 3	no nhua so 3	gói	3500	0	\N	2025-07-18 16:43:47.770705	2025-07-18 16:43:47.770705
1648	Nở Nhựa Số 4	no nhua so 4	gói	6000	0	\N	2025-07-18 16:43:47.77275	2025-07-18 16:43:47.77275
1649	Nở Nhựa Số 5	no nhua so 5	gói	10000	0	\N	2025-07-18 16:43:47.775751	2025-07-18 16:43:47.775751
1650	Nở Nhựa Số 6	no nhua so 6	gói	8000	0	\N	2025-07-18 16:43:47.779735	2025-07-18 16:43:47.779735
1651	Nở Nhựa Số 7	no nhua so 7	gói	10000	0	\N	2025-07-18 16:43:47.781751	2025-07-18 16:43:47.781751
1652	Nở Sắt 10X10	no sat 10x10	cái	2500	0	\N	2025-07-18 16:43:47.783751	2025-07-18 16:43:47.783751
1653	Nở Sắt 10X6	no sat 10x6	cái	2500	0	\N	2025-07-18 16:43:47.785751	2025-07-18 16:43:47.785751
1654	Nở Sắt 10X8 Đẹp	no sat 10x8 dep	cái	2500	0	\N	2025-07-18 16:43:47.789973	2025-07-18 16:43:47.789973
1655	Nở Sắt 10X8 Sài Gòn	no sat 10x8 sai gon	túi	200000	0	\N	2025-07-18 16:43:47.791999	2025-07-18 16:43:47.791999
1656	Nở Sắt 12X10 Đẹp	no sat 12x10 dep	cái	4000	0	\N	2025-07-18 16:43:47.794984	2025-07-18 16:43:47.794984
1657	Nở Sắt 6-8	no sat 6-8	cái	0	0	\N	2025-07-18 16:43:47.796998	2025-07-18 16:43:47.796998
1658	Nở Sắt 6X5 Đẹp	no sat 6x5 dep	cái	1000	0	\N	2025-07-18 16:43:47.800982	2025-07-18 16:43:47.800982
1659	Nở Săt 6X6	no sat 6x6	cái	2500	0	\N	2025-07-18 16:43:47.802984	2025-07-18 16:43:47.802984
1660	Nở Sắt 6X6 Đẹp	no sat 6x6 dep	cái	1000	0	\N	2025-07-18 16:43:47.804984	2025-07-18 16:43:47.804984
1661	Nở Sắt 8X6 Đẹp	no sat 8x6 dep	cái	1500	0	\N	2025-07-18 16:43:47.805984	2025-07-18 16:43:47.805984
1662	Nở Sắt 8X8	no sat 8x8	cái	1500	0	\N	2025-07-18 16:43:47.807984	2025-07-18 16:43:47.807984
1663	Nở Sắt Móc 8	no sat moc 8	cái	4000	0	\N	2025-07-18 16:43:47.810982	2025-07-18 16:43:47.810982
1664	Nở Thạch Cao Ngắn	no thach cao ngan	cái	2500	0	\N	2025-07-18 16:43:47.814178	2025-07-18 16:43:47.814178
1665	Nồi Cơm 0.6 Lít Media	noi com 0.6 lit media	cái	550000	0	\N	2025-07-18 16:43:47.816164	2025-07-18 16:43:47.816164
1666	Nồi Cơm Shap 1	noi com shap 1	cái	1200000	0	\N	2025-07-18 16:43:47.817164	2025-07-18 16:43:47.817164
1667	Nối Ga Đồng 8	noi ga dong 8	cái	10000	0	\N	2025-07-18 16:43:47.820178	2025-07-18 16:43:47.820178
1668	Nối Hơi 10	noi hoi 10	bộ	20000	0	\N	2025-07-18 16:43:47.823209	2025-07-18 16:43:47.823209
1669	Nối Hơi 12	noi hoi 12	bộ	20000	0	\N	2025-07-18 16:43:47.825225	2025-07-18 16:43:47.825225
1670	Nối Hơi Khí 8	noi hoi khi 8	cái	20000	0	\N	2025-07-18 16:43:47.828225	2025-07-18 16:43:47.828225
1671	Nối Khẩu Dài	noi khau dai	cái	50000	0	\N	2025-07-18 16:43:47.831226	2025-07-18 16:43:47.831226
1672	Nối Khí 10/12	noi khi 10/12	cái	5000	0	\N	2025-07-18 16:43:47.833194	2025-07-18 16:43:47.833194
1673	Nối Khí 6	noi khi 6	cái	5000	0	\N	2025-07-18 16:43:47.836211	2025-07-18 16:43:47.836211
1674	Nối Nhanh 10/6	noi nhanh 10/6	cái	5000	0	\N	2025-07-18 16:43:47.83979	2025-07-18 16:43:47.83979
1675	Nối Nhanh 8	noi nhanh 8	cái	6000	0	\N	2025-07-18 16:43:47.842792	2025-07-18 16:43:47.842792
1676	Nối Nhanh Hơi 12/8	noi nhanh hoi 12/8	cái	6000	0	\N	2025-07-18 16:43:47.845467	2025-07-18 16:43:47.845467
1677	Nối Nhanh Khí 10	noi nhanh khi 10	cái	5000	0	\N	2025-07-18 16:43:47.847553	2025-07-18 16:43:47.847553
1678	Nối Nhanh Khí 12/10	noi nhanh khi 12/10	cái	6000	0	\N	2025-07-18 16:43:47.850249	2025-07-18 16:43:47.850249
1679	Nối Thông Sàn 110	noi thong san 110	cái	29500	0	\N	2025-07-18 16:43:47.852249	2025-07-18 16:43:47.852249
1680	Nối Thông Sàn 75	noi thong san 75	cái	20000	0	\N	2025-07-18 16:43:47.85525	2025-07-18 16:43:47.85525
1681	Nối Ty Ren 8	noi ty ren 8	cái	1500	0	\N	2025-07-18 16:43:47.857738	2025-07-18 16:43:47.857738
1682	Nối Vòi Rưả Bát	noi voi rua bat	cái	60000	0	\N	2025-07-18 16:43:47.861796	2025-07-18 16:43:47.861796
1683	Novo 1M Cmart	novo 1m cmart	cái	95000	0	\N	2025-07-18 16:43:47.863783	2025-07-18 16:43:47.863783
1684	Nước Lau Gạch	nuoc lau gach	lọ	90000	0	\N	2025-07-18 16:43:47.865764	2025-07-18 16:43:47.865764
1685	Nước Lau Kính	nuoc lau kinh	lọ	25000	0	\N	2025-07-18 16:43:47.868864	2025-07-18 16:43:47.868864
1686	Nước Thông Tắc Wc	nuoc thong tac wc	can	65000	0	\N	2025-07-18 16:43:47.870923	2025-07-18 16:43:47.870923
1687	Nút Chuông Ngang Edenki	nut chuong ngang edenki	cái	105000	0	\N	2025-07-18 16:43:47.872922	2025-07-18 16:43:47.872922
1688	Ổ 2 Cam Sapoka	o 2 cam sapoka	cái	37000	0	\N	2025-07-18 16:43:47.874953	2025-07-18 16:43:47.874953
1689	Ổ 2 Rẻ Sapoka	o 2 re sapoka	cái	16000	0	\N	2025-07-18 16:43:47.876969	2025-07-18 16:43:47.876969
1690	Ổ 3 Đế Đen Nival	o 3 de den nival	cái	15000	0	\N	2025-07-18 16:43:47.880969	2025-07-18 16:43:47.880969
1691	Ổ 3 Dn 3M Lioa	o 3 dn 3m lioa	cái	110000	0	\N	2025-07-18 16:43:47.883969	2025-07-18 16:43:47.883969
1692	Ổ 3 Dn 3S 5 Mét Lioa	o 3 dn 3s 5 met lioa	cái	130000	0	\N	2025-07-18 16:43:47.885955	2025-07-18 16:43:47.885955
1693	Ổ 3 Dn 3S Lioa	o 3 dn 3s lioa	cái	120000	0	\N	2025-07-18 16:43:47.887933	2025-07-18 16:43:47.887933
1694	Ổ 4 Cam Sapoka	o 4 cam sapoka	cái	60000	0	\N	2025-07-18 16:43:47.891247	2025-07-18 16:43:47.891247
1695	Ổ 6 Lioa 3 Mét	o 6 lioa 3 met	cái	110000	0	\N	2025-07-18 16:43:47.893301	2025-07-18 16:43:47.893301
1696	Ổ Cắm 3 Cam Sapoka	o cam 3 cam sapoka	cái	45000	0	\N	2025-07-18 16:43:47.894301	2025-07-18 16:43:47.894301
1697	Ô Chia Ba 3/16 A	o chia ba 3/16 a	cái	100000	0	\N	2025-07-18 16:43:47.897316	2025-07-18 16:43:47.897316
1698	Ổ Cn 4 Chân 32 A Mdce	o cn 4 chan 32 a mdce	cái	55000	0	\N	2025-07-18 16:43:47.899318	2025-07-18 16:43:47.899318
1699	Ổ Công Ngiệp Cố Định 16A	o cong ngiep co dinh 16a	cái	25000	0	\N	2025-07-18 16:43:47.901299	2025-07-18 16:43:47.901299
1700	Ô Dòa	o doa	cái	50000	0	\N	2025-07-18 16:43:47.90436	2025-07-18 16:43:47.90436
1701	Ốc + Long Đen 8	oc + long den 8	kg	40000	0	\N	2025-07-18 16:43:47.906359	2025-07-18 16:43:47.906359
1702	Óc Cáp 10	oc cap 10	cái	5000	0	\N	2025-07-18 16:43:47.90936	2025-07-18 16:43:47.90936
1703	Ốc Cáp 4	oc cap 4	cái	1500	0	\N	2025-07-18 16:43:47.911359	2025-07-18 16:43:47.911359
1704	Ốc Cáp 6	oc cap 6	cái	2500	0	\N	2025-07-18 16:43:47.913359	2025-07-18 16:43:47.913359
1705	Ốc Cọc Tiếp Địa Vuông	oc coc tiep dia vuong	cái	60000	0	\N	2025-07-18 16:43:47.91636	2025-07-18 16:43:47.91636
1706	Ốc Máy Mai	oc may mai	cái	10000	0	\N	2025-07-18 16:43:47.918359	2025-07-18 16:43:47.918359
1707	Óc Sen Tắm	oc sen tam	cái	45000	0	\N	2025-07-18 16:43:47.921327	2025-07-18 16:43:47.921327
1708	Okay	okay	chai	35000	0	\N	2025-07-18 16:43:47.923563	2025-07-18 16:43:47.923563
1709	Ổn Áp Standa 15 Kw	on ap standa 15 kw	cái	7850000	0	\N	2025-07-18 16:43:47.925889	2025-07-18 16:43:47.925889
1710	Ống Bạc 110	ong bac 110	cuộn	125000	0	\N	2025-07-18 16:43:47.927903	2025-07-18 16:43:47.927903
1711	Ống Bạc 150	ong bac 150	cuộn	130000	0	\N	2025-07-18 16:43:47.930904	2025-07-18 16:43:47.930904
1712	Ống Bạc 90	ong bac 90	cuộn	95000	0	\N	2025-07-18 16:43:47.933887	2025-07-18 16:43:47.933887
1713	Ống Bơm Bạt 50 Tốt	ong bom bat 50 tot	cái	18000	0	\N	2025-07-18 16:43:47.936889	2025-07-18 16:43:47.936889
1714	Ống Bơm Nâu 21 - 6 Kg	ong bom nau 21 - 6 kg	m	5000	0	\N	2025-07-18 16:43:47.938433	2025-07-18 16:43:47.938433
1715	Ống Bơm Nâu 21 - 7Kg	ong bom nau 21 - 7kg	m	5000	0	\N	2025-07-18 16:43:47.941484	2025-07-18 16:43:47.941484
1716	Ống C2 125	ong c2 125	m	123876	0	\N	2025-07-18 16:43:47.943472	2025-07-18 16:43:47.943472
1717	Ống C2 140	ong c2 140	m	156000	0	\N	2025-07-18 16:43:47.945617	2025-07-18 16:43:47.945617
1718	Ống Cam 40/32	ong cam 40/32	m	13000	0	\N	2025-07-18 16:43:47.948117	2025-07-18 16:43:47.948117
1719	Ống Cam 50/40	ong cam 50/40	m	17000	0	\N	2025-07-18 16:43:47.950117	2025-07-18 16:43:47.950117
1720	Ông Lọc 48	ong loc 48	cây	90000	0	\N	2025-07-18 16:43:47.952106	2025-07-18 16:43:47.952106
1721	Ống Sun 2 Đầu Ren	ong sun 2 dau ren	cái	20000	0	\N	2025-07-18 16:43:47.954131	2025-07-18 16:43:47.954131
1722	Ốp 18 W Nanoco	op 18 w nanoco	cái	150000	0	\N	2025-07-18 16:43:47.958117	2025-07-18 16:43:47.958117
1723	Ốp Ovan 10 W	op ovan 10 w	cái	95000	0	\N	2025-07-18 16:43:47.959117	2025-07-18 16:43:47.959117
1724	Ốp Trần 18 W Rẻ	op tran 18 w re	cái	90000	0	\N	2025-07-18 16:43:47.962131	2025-07-18 16:43:47.962131
1725	Ốp Trần 24 W Vuông Tràn Viền	op tran 24 w vuong tran vien	cái	250000	0	\N	2025-07-18 16:43:47.964131	2025-07-18 16:43:47.964131
1726	Ốp Vuông Hắt	op vuong hat	cái	280000	0	\N	2025-07-18 16:43:47.967115	2025-07-18 16:43:47.967115
1727	Pana Át 1/16A	pana at 1/16a	cái	92500	0	\N	2025-07-18 16:43:47.968098	2025-07-18 16:43:47.968098
1728	Pana Át 1/20A	pana at 1/20a	cái	92500	0	\N	2025-07-18 16:43:47.970117	2025-07-18 16:43:47.970117
1729	Pana Át 1/25A	pana at 1/25a	cái	92500	0	\N	2025-07-18 16:43:47.972131	2025-07-18 16:43:47.972131
1730	Pana Át 1/32A	pana at 1/32a	cái	92500	0	\N	2025-07-18 16:43:47.975163	2025-07-18 16:43:47.975163
1731	Pana Át 1/40	pana at 1/40	cái	92500	0	\N	2025-07-18 16:43:47.978148	2025-07-18 16:43:47.978148
1732	Pana Át 2/16	pana at 2/16	cái	265000	0	\N	2025-07-18 16:43:47.981148	2025-07-18 16:43:47.981148
1733	Pana Át 2/20A	pana at 2/20a	cái	265000	0	\N	2025-07-18 16:43:47.984162	2025-07-18 16:43:47.984162
1734	Pana Át 2/25A	pana at 2/25a	cái	265000	0	\N	2025-07-18 16:43:47.986149	2025-07-18 16:43:47.986149
1735	Pana Át 2/32A	pana at 2/32a	cái	265000	0	\N	2025-07-18 16:43:47.988641	2025-07-18 16:43:47.988641
1736	Pana Át 2/40A	pana at 2/40a	cái	265000	0	\N	2025-07-18 16:43:47.992218	2025-07-18 16:43:47.992218
1737	Pana Át 2/50A	pana at 2/50a	cái	438000	0	\N	2025-07-18 16:43:47.994218	2025-07-18 16:43:47.994218
1738	Pana Át 2/63A	pana at 2/63a	cái	438000	0	\N	2025-07-18 16:43:47.996218	2025-07-18 16:43:47.996218
1739	Pana Át 3/100	pana at 3/100	cái	2236000	0	\N	2025-07-18 16:43:47.999185	2025-07-18 16:43:47.999185
1740	Pana Át 3/32 Pana	pana at 3/32 pana	cái	469000	0	\N	2025-07-18 16:43:48.001369	2025-07-18 16:43:48.001369
1741	Pana Át 3/63 Pana	pana at 3/63 pana	cái	702000	0	\N	2025-07-18 16:43:48.002793	2025-07-18 16:43:48.002793
1742	Pana Át Cài 3/32	pana at cai 3/32	cái	469000	0	\N	2025-07-18 16:43:48.004837	2025-07-18 16:43:48.004837
1743	Pana Át Cài 3/40	pana at cai 3/40	cái	469000	0	\N	2025-07-18 16:43:48.006837	2025-07-18 16:43:48.006837
1744	Pana Át Cài 3/50	pana at cai 3/50	cái	702000	0	\N	2025-07-18 16:43:48.009851	2025-07-18 16:43:48.009851
1745	Pana Át Cài 3/50	pana at cai 3/50	cái	702000	0	\N	2025-07-18 16:43:48.012838	2025-07-18 16:43:48.012838
1746	Pana Át Cài 3/63	pana at cai 3/63	cái	702000	0	\N	2025-07-18 16:43:48.015851	2025-07-18 16:43:48.015851
1747	Pana Át Chống Giật 2/20A	pana at chong giat 2/20a	cái	628000	0	\N	2025-07-18 16:43:48.017837	2025-07-18 16:43:48.017837
1748	Pana Át Chống Giật 2/25 (32-40)	pana at chong giat 2/25 (32-40)	cái	673000	0	\N	2025-07-18 16:43:48.018838	2025-07-18 16:43:48.018838
1749	Pana Át Chống Giật 2/25A	pana at chong giat 2/25a	cái	673000	0	\N	2025-07-18 16:43:48.020838	2025-07-18 16:43:48.020838
1750	Pana Át Chống Giật 2/32	pana at chong giat 2/32	cái	673000	0	\N	2025-07-18 16:43:48.022835	2025-07-18 16:43:48.022835
1751	Pana Át Chống Giật 2/40A	pana at chong giat 2/40a	cái	673000	0	\N	2025-07-18 16:43:48.025867	2025-07-18 16:43:48.025867
1752	Pana Át Chống Giật 2/50	pana at chong giat 2/50	cái	954000	0	\N	2025-07-18 16:43:48.027881	2025-07-18 16:43:48.027881
1753	Pana Át Chống Giật 2/63 A	pana at chong giat 2/63 a	cái	954000	0	\N	2025-07-18 16:43:48.029881	2025-07-18 16:43:48.029881
1754	Pana Bộ Mặt 2 Ct Ánh Kim	pana bo mat 2 ct anh kim	cái	184000	0	\N	2025-07-18 16:43:48.032882	2025-07-18 16:43:48.032882
1756	Pana Chiết Áp Quạt	pana chiet ap quat	cái	65000	0	\N	2025-07-18 16:43:48.037881	2025-07-18 16:43:48.037881
1757	Pana Đèn Dl 110/12W	pana den dl 110/12w	cái	266000	0	\N	2025-07-18 16:43:48.041432	2025-07-18 16:43:48.041432
1758	Pana Đèn Dl 90/9W	pana den dl 90/9w	cái	226000	0	\N	2025-07-18 16:43:48.043423	2025-07-18 16:43:48.043423
1759	Pana Hạt 2 Chiều Màu Xám	pana hat 2 chieu mau xam	cái	83000	0	\N	2025-07-18 16:43:48.046432	2025-07-18 16:43:48.046432
1760	Pana Hạt 20 Màu Xám	pana hat 20 mau xam	cái	312000	0	\N	2025-07-18 16:43:48.049446	2025-07-18 16:43:48.049446
1761	Pana Hạt 20A	pana hat 20a	cái	251000	0	\N	2025-07-18 16:43:48.051446	2025-07-18 16:43:48.051446
1762	Pana Hạt Công Tắc 1 Chiều	pana hat cong tac 1 chieu	cái	23000	0	\N	2025-07-18 16:43:48.054446	2025-07-18 16:43:48.054446
1763	Pana Hạt Công Tắc 2 Chiều	pana hat cong tac 2 chieu	cái	47000	0	\N	2025-07-18 16:43:48.05743	2025-07-18 16:43:48.05743
1764	Pana Hạt Đèn Báo	pana hat den bao	cái	21000	0	\N	2025-07-18 16:43:48.059446	2025-07-18 16:43:48.059446
1765	Pana Hạt Đèn Báo Màu Xám	pana hat den bao mau xam	cái	149000	0	\N	2025-07-18 16:43:48.061446	2025-07-18 16:43:48.061446
1766	Pana Hạt Mạng Cat5	pana hat mang cat5	cái	194000	0	\N	2025-07-18 16:43:48.063961	2025-07-18 16:43:48.063961
1767	Pana Hạt Mạng Cat6	pana hat mang cat6	cái	232000	0	\N	2025-07-18 16:43:48.066106	2025-07-18 16:43:48.066106
1768	Pana Hạt Mạng Xám	pana hat mang xam	cái	223000	0	\N	2025-07-18 16:43:48.068156	2025-07-18 16:43:48.068156
1769	Pana Hạt Ổ Đôi 3 Chấu	pana hat o doi 3 chau	cái	103000	0	\N	2025-07-18 16:43:48.071034	2025-07-18 16:43:48.071034
1770	Pana Hạt Ổ Đơn	pana hat o don	cái	42600	0	\N	2025-07-18 16:43:48.073071	2025-07-18 16:43:48.073071
1771	Pana Hạt Ổ Đơn 3 Chấu	pana hat o don 3 chau	cái	71000	0	\N	2025-07-18 16:43:48.075103	2025-07-18 16:43:48.075103
1772	Pana Hạt Tivi	pana hat tivi	cái	89000	0	\N	2025-07-18 16:43:48.077102	2025-07-18 16:43:48.077102
1773	Pana Hạt Trung Gian	pana hat trung gian	cái	255000	0	\N	2025-07-18 16:43:48.080116	2025-07-18 16:43:48.080116
1774	Pana Mặt 1	pana mat 1	cái	18700	0	\N	2025-07-18 16:43:48.082102	2025-07-18 16:43:48.082102
1775	Pana Mặt 1 Ct Ánh Kim	pana mat 1 ct anh kim	cái	121000	0	\N	2025-07-18 16:43:48.084102	2025-07-18 16:43:48.084102
1776	Pana Mặt 1 Màu Xám	pana mat 1 mau xam	cái	31000	0	\N	2025-07-18 16:43:48.085102	2025-07-18 16:43:48.085102
1777	Pana Mặt 1 Vuông	pana mat 1 vuong	cái	22000	0	\N	2025-07-18 16:43:48.087116	2025-07-18 16:43:48.087116
1778	Pana Mặt 2	pana mat 2	cái	18700	0	\N	2025-07-18 16:43:48.091159	2025-07-18 16:43:48.091159
1779	Pana Mặt 2 Liền	pana mat 2 lien	cái	18700	0	\N	2025-07-18 16:43:48.093161	2025-07-18 16:43:48.093161
1780	Pana Mặt 2 Màu Xám	pana mat 2 mau xam	cái	31000	0	\N	2025-07-18 16:43:48.095175	2025-07-18 16:43:48.095175
1781	Pana Mặt 2 Vuông	pana mat 2 vuong	cái	22000	0	\N	2025-07-18 16:43:48.097175	2025-07-18 16:43:48.097175
1782	Pana Mặt 3	pana mat 3	cái	18700	0	\N	2025-07-18 16:43:48.100176	2025-07-18 16:43:48.100176
1783	Pana Mặt 3 Màu Xám	pana mat 3 mau xam	cái	31000	0	\N	2025-07-18 16:43:48.102473	2025-07-18 16:43:48.102473
1784	Pana Mặt 3 Vuông	pana mat 3 vuong	cái	22000	0	\N	2025-07-18 16:43:48.10548	2025-07-18 16:43:48.10548
1785	Pana Mặt Che Mưa Ghi	pana mat che mua ghi	cái	249000	0	\N	2025-07-18 16:43:48.10748	2025-07-18 16:43:48.10748
1786	Pana Mặt Chống Nước	pana mat chong nuoc	cái	249000	0	\N	2025-07-18 16:43:48.109494	2025-07-18 16:43:48.109494
1787	Pana Mặt Chống Nước 7903	pana mat chong nuoc 7903	cái	249000	0	\N	2025-07-18 16:43:48.112478	2025-07-18 16:43:48.112478
1788	Pana Nút Chuông	pana nut chuong	cái	107000	0	\N	2025-07-18 16:43:48.114564	2025-07-18 16:43:48.114564
1789	Pana Ổ Cắm 3 Chấu Ánh Kim Xám	pana o cam 3 chau anh kim xam	cái	99000	0	\N	2025-07-18 16:43:48.117563	2025-07-18 16:43:48.117563
1790	Pana Ổ Cắm Âm Sàn Du 5900 + Ổ 2 3 Chấu	pana o cam am san du 5900 + o 2 3 chau	cái	0	0	\N	2025-07-18 16:43:48.120564	2025-07-18 16:43:48.120564
1791	Pana Ổ Cắm Đôi 3 Chấu Ghenx	pana o cam doi 3 chau ghenx	cái	110000	0	\N	2025-07-18 16:43:48.122563	2025-07-18 16:43:48.122563
1792	Pana Ổ Đôi 3 Chấu Màu Xám	pana o doi 3 chau mau xam	cái	140000	0	\N	2025-07-18 16:43:48.126611	2025-07-18 16:43:48.126611
1793	Pana Pin 9V	pana pin 9v	viên	20000	0	\N	2025-07-18 16:43:48.128597	2025-07-18 16:43:48.128597
1794	Pana Pin Aaa	pana pin aaa	viên	4000	0	\N	2025-07-18 16:43:48.130611	2025-07-18 16:43:48.130611
1795	Pana Quạt Trần 3 Cánh	pana quat tran 3 canh	cái	1050000	0	\N	2025-07-18 16:43:48.133579	2025-07-18 16:43:48.133579
1796	Pana Quạt Trần 3 Cánh F60Fv2 Ms	pana quat tran 3 canh f60fv2 ms	cái	2220000	0	\N	2025-07-18 16:43:48.136611	2025-07-18 16:43:48.136611
1797	Pana Quạt Trần 4 Cánh Bạc	pana quat tran 4 canh bac	cái	2200000	0	\N	2025-07-18 16:43:48.139612	2025-07-18 16:43:48.139612
1798	Pana Quạt Trần 4 Cánh Trắng	pana quat tran 4 canh trang	cái	2400000	0	\N	2025-07-18 16:43:48.142138	2025-07-18 16:43:48.142138
1799	Pana Quạt Trần 5 Cánh F60Gds	pana quat tran 5 canh f60gds	cái	7160000	0	\N	2025-07-18 16:43:48.144138	2025-07-18 16:43:48.144138
1800	Pana Quạt Trần 5 Cánh Panasonic Gdn	pana quat tran 5 canh panasonic gdn	cái	4400000	0	\N	2025-07-18 16:43:48.146136	2025-07-18 16:43:48.146136
1801	Pana Quạt Trần 5 Cánhtdn	pana quat tran 5 canhtdn	cái	4450000	0	\N	2025-07-18 16:43:48.148123	2025-07-18 16:43:48.148123
1802	Pana Quạt Treo Tường	pana quat treo tuong	cái	1800000	0	\N	2025-07-18 16:43:48.150123	2025-07-18 16:43:48.150123
1803	Pana Thân Chuông	pana than chuong	cái	184000	0	\N	2025-07-18 16:43:48.151123	2025-07-18 16:43:48.151123
1804	Pha 10 W Rạng Đông	pha 10 w rang dong	cái	160000	0	\N	2025-07-18 16:43:48.153138	2025-07-18 16:43:48.153138
1805	Pha 30 W Rạng Đông	pha 30 w rang dong	cái	280000	0	\N	2025-07-18 16:43:48.157151	2025-07-18 16:43:48.157151
1806	Phấn Trắng	phan trang	hộp	5000	0	\N	2025-07-18 16:43:48.159124	2025-07-18 16:43:48.159124
1807	Phao Chống Cạn Sena	phao chong can sena	cái	550000	0	\N	2025-07-18 16:43:48.161138	2025-07-18 16:43:48.161138
1808	Phao Cơ 15	phao co 15	cái	110000	0	\N	2025-07-18 16:43:48.163137	2025-07-18 16:43:48.163137
1809	Phao Cơ 15 Even Đắt	phao co 15 even dat	cái	190000	0	\N	2025-07-18 16:43:48.166105	2025-07-18 16:43:48.166105
1810	Phao Cơ 20	phao co 20	cái	120000	0	\N	2025-07-18 16:43:48.168122	2025-07-18 16:43:48.168122
1811	Phao Cơ 20 Everet	phao co 20 everet	cái	220000	0	\N	2025-07-18 16:43:48.170139	2025-07-18 16:43:48.170139
1812	Phao Điện	phao dien	cái	90000	0	\N	2025-07-18 16:43:48.172124	2025-07-18 16:43:48.172124
1813	Phao Điện Chiutong	phao dien chiutong	cái	150000	0	\N	2025-07-18 16:43:48.174155	2025-07-18 16:43:48.174155
1814	Phao Điện Rada	phao dien rada	cái	100000	0	\N	2025-07-18 16:43:48.175153	2025-07-18 16:43:48.175153
1815	Phao Điện Sanpo	phao dien sanpo	cái	100000	0	\N	2025-07-18 16:43:48.17817	2025-07-18 16:43:48.17817
1816	Phao Huto 15	phao huto 15	cái	130000	0	\N	2025-07-18 16:43:48.181169	2025-07-18 16:43:48.181169
1817	Phao Huto 20	phao huto 20	cái	135000	0	\N	2025-07-18 16:43:48.183156	2025-07-18 16:43:48.183156
1818	Phao Xi Rẻ	phao xi re	cái	65000	0	\N	2025-07-18 16:43:48.185169	2025-07-18 16:43:48.185169
1819	Phao Xi Tốt	phao xi tot	cái	105000	0	\N	2025-07-18 16:43:48.187169	2025-07-18 16:43:48.187169
1820	Phích 4 Chân 32 A Di Động Mdce	phich 4 chan 32 a di dong mdce	cái	55000	0	\N	2025-07-18 16:43:48.1902	2025-07-18 16:43:48.1902
1821	Phích Âm Tốt Cam	phich am tot cam	cái	18000	0	\N	2025-07-18 16:43:48.192397	2025-07-18 16:43:48.192397
1822	Phích Cắm 4P/32 A	phich cam 4p/32 a	cái	40000	0	\N	2025-07-18 16:43:48.194412	2025-07-18 16:43:48.194412
1823	Phích Cắm Âm Thường	phich cam am thuong	cái	7000	0	\N	2025-07-18 16:43:48.197397	2025-07-18 16:43:48.197397
1824	Phích Cắm Công Nghiệp 16A Di Động	phich cam cong nghiep 16a di dong	cái	18000	0	\N	2025-07-18 16:43:48.199378	2025-07-18 16:43:48.199378
1825	Phích Cắm Lioa	phich cam lioa	cái	20000	0	\N	2025-07-18 16:43:48.202396	2025-07-18 16:43:48.202396
1826	Phích Cam Nival	phich cam nival	cái	10000	0	\N	2025-07-18 16:43:48.204411	2025-07-18 16:43:48.204411
1827	Phích Cắm Thường	phich cam thuong	cái	5000	0	\N	2025-07-18 16:43:48.206411	2025-07-18 16:43:48.206411
1828	Phích Cắm Tốt	phich cam tot	cái	18000	0	\N	2025-07-18 16:43:48.209412	2025-07-18 16:43:48.209412
1829	Phích Chuyển 3 Chân Ra 2 Chân Lioa	phich chuyen 3 chan ra 2 chan lioa	cái	20000	0	\N	2025-07-18 16:43:48.211397	2025-07-18 16:43:48.211397
1830	Phích Nối 3 Ra 2 Chân Sapoka	phich noi 3 ra 2 chan sapoka	cái	15000	0	\N	2025-07-18 16:43:48.214397	2025-07-18 16:43:48.214397
1831	Phích Tải	phich tai	cái	15000	0	\N	2025-07-18 16:43:48.216411	2025-07-18 16:43:48.216411
1832	Phích Tải Nival	phich tai nival	cái	10000	0	\N	2025-07-18 16:43:48.218411	2025-07-18 16:43:48.218411
1833	Phớt Vàng 100	phot vang 100	cái	6000	0	\N	2025-07-18 16:43:48.221415	2025-07-18 16:43:48.221415
1834	Phụ Kiện 6 Món Berik	phu kien 6 mon berik	bộ	400000	0	\N	2025-07-18 16:43:48.223883	2025-07-18 16:43:48.223883
1835	Phụ Kiện 6 Món Senta	phu kien 6 mon senta	cái	850000	0	\N	2025-07-18 16:43:48.225947	2025-07-18 16:43:48.225947
1836	Phụ Kiện Nhà Tắm 304	phu kien nha tam 304	bộ	600000	0	\N	2025-07-18 16:43:48.227946	2025-07-18 16:43:48.227946
1837	Phụ Kiện Nhà Tắm Vg 92	phu kien nha tam vg 92	cái	1250000	0	\N	2025-07-18 16:43:48.230947	2025-07-18 16:43:48.230947
1838	Pin 21 V Yamashu	pin 21 v yamashu	cái	420000	0	\N	2025-07-18 16:43:48.233933	2025-07-18 16:43:48.233933
1839	Pin Laze	pin laze	cái	70000	0	\N	2025-07-18 16:43:48.236947	2025-07-18 16:43:48.236947
1840	Poly Tời Bé	poly toi be	cái	50000	0	\N	2025-07-18 16:43:48.238933	2025-07-18 16:43:48.238933
1841	Poly Tời To	poly toi to	cái	70000	0	\N	2025-07-18 16:43:48.241528	2025-07-18 16:43:48.241528
1842	Puly Tời	puly toi	cái	70000	0	\N	2025-07-18 16:43:48.243528	2025-07-18 16:43:48.243528
1843	Pvc Cút Ren 21 Đồng	pvc cut ren 21 dong	cái	10000	0	\N	2025-07-18 16:43:48.246516	2025-07-18 16:43:48.246516
1844	Pvc Cút Ren Đồng 27X1/2	pvc cut ren dong 27x1/2	cái	15000	0	\N	2025-07-18 16:43:48.249514	2025-07-18 16:43:48.249514
1845	Pvc Cút Ren Đồng 27X3/4	pvc cut ren dong 27x3/4	cái	15000	0	\N	2025-07-18 16:43:48.251528	2025-07-18 16:43:48.251528
1846	Pvc Msrt 21 Đồng	pvc msrt 21 dong	cái	10000	0	\N	2025-07-18 16:43:48.253514	2025-07-18 16:43:48.253514
1847	Pvc Msrt 27X1/2 Đồng	pvc msrt 27x1/2 dong	cái	15000	0	\N	2025-07-18 16:43:48.254514	2025-07-18 16:43:48.254514
1848	Pvc Msrt 27X3/4 Đồng	pvc msrt 27x3/4 dong	cái	15000	0	\N	2025-07-18 16:43:48.256512	2025-07-18 16:43:48.256512
1849	Pvc Pvc Rắc Co Ngựa D21	pvc pvc rac co ngua d21	cái	15000	0	\N	2025-07-18 16:43:48.258514	2025-07-18 16:43:48.258514
1850	Pvc Rắc Co 48 Phú Hải	pvc rac co 48 phu hai	cái	28000	0	\N	2025-07-18 16:43:48.260528	2025-07-18 16:43:48.260528
1851	Pvc Rắc Co 90 Ngựa	pvc rac co 90 ngua	cái	228000	0	\N	2025-07-18 16:43:48.262528	2025-07-18 16:43:48.262528
1852	Pvc Rắc Co Ngựa D27	pvc rac co ngua d27	cái	20000	0	\N	2025-07-18 16:43:48.265528	2025-07-18 16:43:48.265528
1853	Pvc Rắc Co Ngựa D34	pvc rac co ngua d34	cái	25000	0	\N	2025-07-18 16:43:48.268503	2025-07-18 16:43:48.268503
1854	Pvc Rắc Co Ngựa D42	pvc rac co ngua d42	cái	40000	0	\N	2025-07-18 16:43:48.270514	2025-07-18 16:43:48.270514
1855	Pvc Rắc Co Ngựa D48	pvc rac co ngua d48	cái	45000	0	\N	2025-07-18 16:43:48.272528	2025-07-18 16:43:48.272528
1856	Pvc Rắc Co Ngựa D60	pvc rac co ngua d60	cái	80000	0	\N	2025-07-18 16:43:48.274575	2025-07-18 16:43:48.274575
1857	Pvc Rắc Co Thường D21	pvc rac co thuong d21	cái	8000	0	\N	2025-07-18 16:43:48.277567	2025-07-18 16:43:48.277567
1858	Pvc Rắc Co Thường D27	pvc rac co thuong d27	cái	8000	0	\N	2025-07-18 16:43:48.280561	2025-07-18 16:43:48.280561
1859	Pvc Rắc Co Thường D34	pvc rac co thuong d34	cái	10000	0	\N	2025-07-18 16:43:48.282561	2025-07-18 16:43:48.282561
1860	Pvc Rắc Co Thường D42	pvc rac co thuong d42	cái	0	0	\N	2025-07-18 16:43:48.28437	2025-07-18 16:43:48.28437
1861	Pvc Rắc Co Thường D48	pvc rac co thuong d48	cái	25000	0	\N	2025-07-18 16:43:48.286597	2025-07-18 16:43:48.286597
1862	Pvc Rắc Co Thường D60	pvc rac co thuong d60	cái	45000	0	\N	2025-07-18 16:43:48.288917	2025-07-18 16:43:48.288917
1863	Pvc Ren Ngoài 34/21	pvc ren ngoai 34/21	cái	3000	0	\N	2025-07-18 16:43:48.291581	2025-07-18 16:43:48.291581
1864	Pvc Ren Ngoài 34/27	pvc ren ngoai 34/27	cái	3000	0	\N	2025-07-18 16:43:48.295311	2025-07-18 16:43:48.295311
1865	Pvc Ren Ngoài 48/27	pvc ren ngoai 48/27	cái	5000	0	\N	2025-07-18 16:43:48.296311	2025-07-18 16:43:48.296311
1866	Pvc Rn 34/27	pvc rn 34/27	cái	3000	0	\N	2025-07-18 16:43:48.299327	2025-07-18 16:43:48.299327
1867	Pvc Tê Ren Đồng 21/12	pvc te ren dong 21/12	cái	12000	0	\N	2025-07-18 16:43:48.302325	2025-07-18 16:43:48.302325
1868	Pvc Tê Rt 21X1/2	pvc te rt 21x1/2	cái	10000	0	\N	2025-07-18 16:43:48.304311	2025-07-18 16:43:48.304311
1869	Quả Lọc 1 Karofi	qua loc 1 karofi	cái	45000	0	\N	2025-07-18 16:43:48.306325	2025-07-18 16:43:48.306325
1870	Quả Lọc 123 Kagaroo	qua loc 123 kagaroo	bộ	135000	0	\N	2025-07-18 16:43:48.308325	2025-07-18 16:43:48.308325
1871	Quả Lọc 123 Karoffi	qua loc 123 karoffi	bộ	165000	0	\N	2025-07-18 16:43:48.311326	2025-07-18 16:43:48.311326
1872	Quả Lọc Ro Hao Sing	qua loc ro hao sing	cái	250000	0	\N	2025-07-18 16:43:48.314311	2025-07-18 16:43:48.314311
1873	Quạt Cây 450 Tn	quat cay 450 tn	cái	420000	0	\N	2025-07-18 16:43:48.317325	2025-07-18 16:43:48.317325
1874	Quạt Cây 500 Thống Nhất	quat cay 500 thong nhat	cái	1250000	0	\N	2025-07-18 16:43:48.319311	2025-07-18 16:43:48.319311
1875	Quạt Cây 650 Komasu	quat cay 650 komasu	cái	2050000	0	\N	2025-07-18 16:43:48.321325	2025-07-18 16:43:48.321325
1876	Quạt Cây 650 Thống Nhất	quat cay 650 thong nhat	cái	1450000	0	\N	2025-07-18 16:43:48.325325	2025-07-18 16:43:48.325325
1877	Quạt Chân Quỳ Komasu	quat chan quy komasu	cái	1720000	0	\N	2025-07-18 16:43:48.327343	2025-07-18 16:43:48.327343
1878	Quạt Đảo Hatari	quat dao hatari	cái	1300000	0	\N	2025-07-18 16:43:48.328343	2025-07-18 16:43:48.328343
1879	Quạt Đảo Trần	quat dao tran	cái	500000	0	\N	2025-07-18 16:43:48.330343	2025-07-18 16:43:48.330343
1880	Quạt Đen Máy Tính 11X11	quat den may tinh 11x11	cái	65000	0	\N	2025-07-18 16:43:48.332357	2025-07-18 16:43:48.332357
1881	Quạt Hơi Nước 6000 M Rapido	quat hoi nuoc 6000 m rapido	cái	1950000	0	\N	2025-07-18 16:43:48.335341	2025-07-18 16:43:48.335341
1882	Quạt Máy Tính Đen 15X15	quat may tinh den 15x15	cái	145000	0	\N	2025-07-18 16:43:48.338619	2025-07-18 16:43:48.338619
1883	Quạt Quỳ Komatsu	quat quy komatsu	cái	1700000	0	\N	2025-07-18 16:43:48.341129	2025-07-18 16:43:48.341129
1884	Quạt Rút 400 Dk Tn	quat rut 400 dk tn	cái	380000	0	\N	2025-07-18 16:43:48.34318	2025-07-18 16:43:48.34318
1885	Quạt Sưởi Kot Man	quat suoi kot man	cái	1660000	0	\N	2025-07-18 16:43:48.346165	2025-07-18 16:43:48.346165
1886	Quạt Thông Gió 12V6	quat thong gio 12v6	cái	180000	0	\N	2025-07-18 16:43:48.34918	2025-07-18 16:43:48.34918
1887	Quạt Thông Gió 14V6	quat thong gio 14v6	cái	170000	0	\N	2025-07-18 16:43:48.35118	2025-07-18 16:43:48.35118
1888	Quạt Thông Gió 16V6	quat thong gio 16v6	cái	195000	0	\N	2025-07-18 16:43:48.35418	2025-07-18 16:43:48.35418
1889	Quạt Thông Gió 30V6 Tico	quat thong gio 30v6 tico	cái	0	0	\N	2025-07-18 16:43:48.35718	2025-07-18 16:43:48.35718
1890	Quạt Thông Gió Nanoco	quat thong gio nanoco	cái	220000	0	\N	2025-07-18 16:43:48.359551	2025-07-18 16:43:48.359551
1891	Quạt Thông Gió Tico 20Av6	quat thong gio tico 20av6	cái	250000	0	\N	2025-07-18 16:43:48.361565	2025-07-18 16:43:48.361565
1892	Quạt Thông Gió Tường 20X20 Geneu	quat thong gio tuong 20x20 geneu	cái	240000	0	\N	2025-07-18 16:43:48.363565	2025-07-18 16:43:48.363565
1893	Quạt Trần 5 Cánh Thống Nhất	quat tran 5 canh thong nhat	cái	2550000	0	\N	2025-07-18 16:43:48.366566	2025-07-18 16:43:48.366566
1894	Quạt Trần Nhôm 3 Cánh Thống Nhất	quat tran nhom 3 canh thong nhat	cái	850000	0	\N	2025-07-18 16:43:48.369551	2025-07-18 16:43:48.369551
1895	Quạt Trần Trắng Thống Nhất	quat tran trang thong nhat	cái	800000	0	\N	2025-07-18 16:43:48.370551	2025-07-18 16:43:48.370551
1896	Quạt Trần Xanh	quat tran xanh	cái	800000	0	\N	2025-07-18 16:43:48.373565	2025-07-18 16:43:48.373565
1897	Quạt Treo 300 Tn	quat treo 300 tn	cái	320000	0	\N	2025-07-18 16:43:48.375612	2025-07-18 16:43:48.375612
1898	Quạt Treo 400 Điều Khiển Tn	quat treo 400 dieu khien tn	cái	500000	0	\N	2025-07-18 16:43:48.378614	2025-07-18 16:43:48.378614
1899	Quạt Treo 400 Tn	quat treo 400 tn	cái	340000	0	\N	2025-07-18 16:43:48.380596	2025-07-18 16:43:48.380596
1900	Quạt Treo 450	quat treo 450	cái	370000	0	\N	2025-07-18 16:43:48.381598	2025-07-18 16:43:48.381598
1901	Quạt Treo 450 Tn	quat treo 450 tn	cái	370000	0	\N	2025-07-18 16:43:48.383598	2025-07-18 16:43:48.383598
1902	Quạt Treo Hatari	quat treo hatari	cái	1250000	0	\N	2025-07-18 16:43:48.386612	2025-07-18 16:43:48.386612
1903	Quạt Treo Mishumisi	quat treo mishumisi	cái	1620000	0	\N	2025-07-18 16:43:48.389128	2025-07-18 16:43:48.389128
1904	Que Hàn 2.5 Kim Tín	que han 2.5 kim tin	bó	75000	0	\N	2025-07-18 16:43:48.391698	2025-07-18 16:43:48.391698
1905	Que Hàn Inox	que han inox	bó	165000	0	\N	2025-07-18 16:43:48.393732	2025-07-18 16:43:48.393732
1906	Que Hàn Kim Tín 2.5	que han kim tin 2.5	bó	75000	0	\N	2025-07-18 16:43:48.395732	2025-07-18 16:43:48.395732
1907	Que Hàn Kim Tín 3.2	que han kim tin 3.2	bó	135000	0	\N	2025-07-18 16:43:48.397731	2025-07-18 16:43:48.397731
1908	Que Hàn Kim Tín 4	que han kim tin 4	bó	135000	0	\N	2025-07-18 16:43:48.400732	2025-07-18 16:43:48.400732
1909	Quốc Cán Sắt	quoc can sat	cái	75000	0	\N	2025-07-18 16:43:48.403732	2025-07-18 16:43:48.403732
1910	Rắc Đực Phi 16 Máy Hàn	rac duc phi 16 may han	cái	15000	0	\N	2025-07-18 16:43:48.405746	2025-07-18 16:43:48.405746
1911	Ram Sét 2	ram set 2	cặp	320000	0	\N	2025-07-18 16:43:48.407746	2025-07-18 16:43:48.407746
1912	Ray Kéo 35	ray keo 35	bộ	35000	0	\N	2025-07-18 16:43:48.410713	2025-07-18 16:43:48.410713
1913	Rb 7 To	rb 7 to	lọ	50000	0	\N	2025-07-18 16:43:48.41273	2025-07-18 16:43:48.41273
1914	Rb 7 Xịn	rb 7 xin	lọ	80000	0	\N	2025-07-18 16:43:48.415732	2025-07-18 16:43:48.415732
1915	Rđ Bộ T8 0.6M Thủy Tinh	rd bo t8 0.6m thuy tinh	bộ	70000	0	\N	2025-07-18 16:43:48.417746	2025-07-18 16:43:48.417746
1916	Rđ Bộ Túy Đôi M11 1.2 M	rd bo tuy doi m11 1.2 m	bộ	275000	0	\N	2025-07-18 16:43:48.419746	2025-07-18 16:43:48.419746
1917	Rđ Bộ Tuýp Led T8 1.2M Thủy Tinh	rd bo tuyp led t8 1.2m thuy tinh	bộ	90000	0	\N	2025-07-18 16:43:48.422746	2025-07-18 16:43:48.422746
1918	Rđ Bộ Tuýp Thủy Tinh 0.6	rd bo tuyp thuy tinh 0.6	bộ	70000	0	\N	2025-07-18 16:43:48.424732	2025-07-18 16:43:48.424732
1919	Rđ Bóng T8 0.6M Thủy Tinh	rd bong t8 0.6m thuy tinh	bóng	45000	0	\N	2025-07-18 16:43:48.426746	2025-07-18 16:43:48.426746
1920	Rđ Bóng Tuýp 1.2 M Thủy Tinh	rd bong tuyp 1.2 m thuy tinh	cái	65000	0	\N	2025-07-18 16:43:48.428779	2025-07-18 16:43:48.428779
1921	Rđ Đèn 90/12W Chiếu Điẻm	rd den 90/12w chieu diem	cái	135000	0	\N	2025-07-18 16:43:48.431085	2025-07-18 16:43:48.431085
1922	Rđ Đèn Cầu Thang	rd den cau thang	cái	135000	0	\N	2025-07-18 16:43:48.432094	2025-07-18 16:43:48.432094
1923	Rđ Đèn Dl 110/12 3 Màu	rd den dl 110/12 3 mau	cái	120000	0	\N	2025-07-18 16:43:48.435103	2025-07-18 16:43:48.435103
1924	Rđ Đèn Dl 110/12 W - 4000 K	rd den dl 110/12 w - 4000 k	cái	100000	0	\N	2025-07-18 16:43:48.437151	2025-07-18 16:43:48.437151
1925	Rđ Đèn Dl 110/12 W Trắng	rd den dl 110/12 w trang	cái	95000	0	\N	2025-07-18 16:43:48.439165	2025-07-18 16:43:48.439165
1926	Rd Đèn Dl 110/12W	rd den dl 110/12w	cái	100000	0	\N	2025-07-18 16:43:48.442166	2025-07-18 16:43:48.442166
1927	Rđ Đèn Dl 110/9 W 04	rd den dl 110/9 w 04	cái	95000	0	\N	2025-07-18 16:43:48.444623	2025-07-18 16:43:48.444623
1928	Rđ Đèn Dl 3 Màu 110/9 W Vv	rd den dl 3 mau 110/9 w vv	cái	115000	0	\N	2025-07-18 16:43:48.446648	2025-07-18 16:43:48.446648
1929	Rđ Đèn Dl 90/9 W	rd den dl 90/9 w	cái	82000	0	\N	2025-07-18 16:43:48.449642	2025-07-18 16:43:48.449642
1930	Rđ Đèn Dowlight 110/12 W Vàng 3000K	rd den dowlight 110/12 w vang 3000k	cái	96000	0	\N	2025-07-18 16:43:48.451656	2025-07-18 16:43:48.451656
1931	Rđ Đèn Dowlight 90/10W Trắng	rd den dowlight 90/10w trang	cái	85000	0	\N	2025-07-18 16:43:48.453656	2025-07-18 16:43:48.453656
1932	Rđ Đèn Gương	rd den guong	cái	160000	0	\N	2025-07-18 16:43:48.45664	2025-07-18 16:43:48.45664
1933	Rđ Đèn Ngủ Cảm Biến	rd den ngu cam bien	cái	70000	0	\N	2025-07-18 16:43:48.460005	2025-07-18 16:43:48.460005
1934	Rđ Đèn Ốp Trần Vuông Cảm Biến	rd den op tran vuong cam bien	cái	280000	0	\N	2025-07-18 16:43:48.46203	2025-07-18 16:43:48.46203
1935	Rđ Đèn Panel 600X600	rd den panel 600x600	cái	500000	0	\N	2025-07-18 16:43:48.46403	2025-07-18 16:43:48.46403
1936	Rđ Dl 9/10 W Trắng	rd dl 9/10 w trang	cái	85000	0	\N	2025-07-18 16:43:48.468014	2025-07-18 16:43:48.468014
1937	Rđ Dl 90/10 W Trắng	rd dl 90/10 w trang	cái	85000	0	\N	2025-07-18 16:43:48.471031	2025-07-18 16:43:48.471031
1938	Rđ Dowlight 3 Màu Vv 90/10 W	rd dowlight 3 mau vv 90/10 w	cái	102600	0	\N	2025-07-18 16:43:48.473016	2025-07-18 16:43:48.473016
1939	Rđ Đui Cảm Biến	rd dui cam bien	cái	135000	0	\N	2025-07-18 16:43:48.475061	2025-07-18 16:43:48.475061
1940	Rđ Led Búp 12W	rd led bup 12w	cái	50000	0	\N	2025-07-18 16:43:48.478062	2025-07-18 16:43:48.478062
1941	Rđ Led Búp 15W	rd led bup 15w	cái	60000	0	\N	2025-07-18 16:43:48.480045	2025-07-18 16:43:48.480045
1942	Rđ Led Búp 20W	rd led bup 20w	cái	80000	0	\N	2025-07-18 16:43:48.482061	2025-07-18 16:43:48.482061
1943	Rđ Led Búp 30W	rd led bup 30w	cái	125000	0	\N	2025-07-18 16:43:48.485061	2025-07-18 16:43:48.485061
1944	Rđ Led Búp 3W	rd led bup 3w	cái	25000	0	\N	2025-07-18 16:43:48.487061	2025-07-18 16:43:48.487061
1945	Rđ Led Búp 40W	rd led bup 40w	cái	155000	0	\N	2025-07-18 16:43:48.490592	2025-07-18 16:43:48.490592
1946	Rđ Led Búp 50W	rd led bup 50w	cái	180000	0	\N	2025-07-18 16:43:48.492683	2025-07-18 16:43:48.492683
1947	Rđ Led Búp 5W	rd led bup 5w	cái	30000	0	\N	2025-07-18 16:43:48.494734	2025-07-18 16:43:48.494734
1948	Rđ Led Búp 7W	rd led bup 7w	cái	35000	0	\N	2025-07-18 16:43:48.496734	2025-07-18 16:43:48.496734
1949	Rđ Led Búp 9W	rd led bup 9w	cái	40000	0	\N	2025-07-18 16:43:48.499735	2025-07-18 16:43:48.499735
1950	Rđ Led Trụ 80 W	rd led tru 80 w	cái	260000	0	\N	2025-07-18 16:43:48.502718	2025-07-18 16:43:48.502718
1951	Rđ Máng Led T8 1.2M	rd mang led t8 1.2m	cái	50000	0	\N	2025-07-18 16:43:48.50472	2025-07-18 16:43:48.50472
1952	Rđ Nối Led	rd noi led	cái	40000	0	\N	2025-07-18 16:43:48.505457	2025-07-18 16:43:48.505457
1953	Rđ Ổ Cắm An Toán Máy Bơm	rd o cam an toan may bom	cái	190000	0	\N	2025-07-18 16:43:48.507759	2025-07-18 16:43:48.507759
1954	Rđ Ốp 18 W Cảm Biến	rd op 18 w cam bien	cái	260000	0	\N	2025-07-18 16:43:48.509853	2025-07-18 16:43:48.509853
1955	Rđ Ốp 18W Tròn Tràn Viền	rd op 18w tron tran vien	cái	175000	0	\N	2025-07-18 16:43:48.513245	2025-07-18 16:43:48.513245
1956	Rđ Ốp 24 W Tràn Viền Tròn	rd op 24 w tran vien tron	cái	240000	0	\N	2025-07-18 16:43:48.515293	2025-07-18 16:43:48.515293
1957	Rđ Ốp Ban Công 24W	rd op ban cong 24w	cái	250000	0	\N	2025-07-18 16:43:48.517278	2025-07-18 16:43:48.517278
1958	Rđ Ốp Tràn Viền 12 W Tròn	rd op tran vien 12 w tron	cái	145000	0	\N	2025-07-18 16:43:48.518278	2025-07-18 16:43:48.518278
1959	Rđ Ốp Tràn Viền 12 W Vuông	rd op tran vien 12 w vuong	cái	145000	0	\N	2025-07-18 16:43:48.521293	2025-07-18 16:43:48.521293
1960	Rđ Ốp Tường Ovan Cảm Biến	rd op tuong ovan cam bien	cái	165000	0	\N	2025-07-18 16:43:48.523292	2025-07-18 16:43:48.523292
1961	Rđ Ốp Vuông 18 W Tràn Viền	rd op vuong 18 w tran vien	cái	175000	0	\N	2025-07-18 16:43:48.526276	2025-07-18 16:43:48.526276
1962	Rđ Ốp Vuông 18 W Vuông Trắng	rd op vuong 18 w vuong trang	cái	200000	0	\N	2025-07-18 16:43:48.528339	2025-07-18 16:43:48.528339
1963	Rđ Pha 20 W	rd pha 20 w	cái	240000	0	\N	2025-07-18 16:43:48.530339	2025-07-18 16:43:48.530339
1964	Rđ Pha 50 W	rd pha 50 w	cái	380000	0	\N	2025-07-18 16:43:48.53334	2025-07-18 16:43:48.53334
1965	Rđ Tê 5 X 0,3 M	rd te 5 x 0,3 m	cái	65000	0	\N	2025-07-18 16:43:48.535325	2025-07-18 16:43:48.535325
1966	Rđ Tê 5 X 0.6 M	rd te 5 x 0.6 m	cái	75000	0	\N	2025-07-18 16:43:48.537339	2025-07-18 16:43:48.537339
1967	Rđ Tê 5 X 1,2 M	rd te 5 x 1,2 m	cái	90000	0	\N	2025-07-18 16:43:48.540339	2025-07-18 16:43:48.540339
1968	Rđ Tuýp 0.6 Bán Nguyệt	rd tuyp 0.6 ban nguyet	bộ	120000	0	\N	2025-07-18 16:43:48.54287	2025-07-18 16:43:48.54287
1969	Rđ Tuýp 1,2M M26	rd tuyp 1,2m m26	bộ	175000	0	\N	2025-07-18 16:43:48.54492	2025-07-18 16:43:48.54492
1970	Rđ Tuýp 1,2M M36	rd tuyp 1,2m m36	bộ	175000	0	\N	2025-07-18 16:43:48.547905	2025-07-18 16:43:48.547905
1971	Rđ Tuýp Bn 1,2 M M26	rd tuyp bn 1,2 m m26	cái	165000	0	\N	2025-07-18 16:43:48.548937	2025-07-18 16:43:48.548937
1972	Rđ Tuýp Bn M 66 1.2 M	rd tuyp bn m 66 1.2 m	bộ	220000	0	\N	2025-07-18 16:43:48.550947	2025-07-18 16:43:48.550947
1973	Rẻ Lau	re lau	kg	20000	0	\N	2025-07-18 16:43:48.552947	2025-07-18 16:43:48.552947
1974	Rẻ Lau Trắng	re lau trang	kg	35000	0	\N	2025-07-18 16:43:48.555936	2025-07-18 16:43:48.555936
1975	Ren 8 X 3 Mét	ren 8 x 3 met	cây	19000	0	\N	2025-07-18 16:43:48.557947	2025-07-18 16:43:48.557947
1976	Ren Bồn 48 Inox	ren bon 48 inox	cái	35000	0	\N	2025-07-18 16:43:48.560962	2025-07-18 16:43:48.560962
1977	Ren Bồn Inox 27	ren bon inox 27	cái	25000	0	\N	2025-07-18 16:43:48.562947	2025-07-18 16:43:48.562947
1978	Ren Đồng 1/8 Ra 8	ren dong 1/8 ra 8	cái	10000	0	\N	2025-07-18 16:43:48.564962	2025-07-18 16:43:48.564962
1979	Rọ Bơm Đồng Miha 50	ro bom dong miha 50	cái	290000	0	\N	2025-07-18 16:43:48.56793	2025-07-18 16:43:48.56793
1980	Rơ Le Hẹn Giờ Dcom	ro le hen gio dcom	cái	260000	0	\N	2025-07-18 16:43:48.570945	2025-07-18 16:43:48.570945
1981	Rơ Le Máy Bơm Áp	ro le may bom ap	cái	80000	0	\N	2025-07-18 16:43:48.573962	2025-07-18 16:43:48.573962
1982	Rơ Le Máy Bơm Áp Tas	ro le may bom ap tas	cái	170000	0	\N	2025-07-18 16:43:48.576009	2025-07-18 16:43:48.576009
1983	Roăng Băng Tan	roang bang tan	cái	2000	0	\N	2025-07-18 16:43:48.57901	2025-07-18 16:43:48.57901
1984	Rọi Cây 10W	roi cay 10w	cái	420000	0	\N	2025-07-18 16:43:48.580006	2025-07-18 16:43:48.580006
1985	Rọi Sắt To	roi sat to	cái	25000	0	\N	2025-07-18 16:43:48.581996	2025-07-18 16:43:48.581996
1986	Rốn Bồn 48	ron bon 48	cái	35000	0	\N	2025-07-18 16:43:48.583996	2025-07-18 16:43:48.583996
1987	Rốn Téc 48	ron tec 48	cái	55000	0	\N	2025-07-18 16:43:48.58601	2025-07-18 16:43:48.58601
1988	Rong Băng Tan	rong bang tan	cái	1000	0	\N	2025-07-18 16:43:48.588009	2025-07-18 16:43:48.588009
1989	Rong Bệt	rong bet	cái	50000	0	\N	2025-07-18 16:43:48.59151	2025-07-18 16:43:48.59151
1990	Rong Cao Su 42/34	rong cao su 42/34	cái	7000	0	\N	2025-07-18 16:43:48.59407	2025-07-18 16:43:48.59407
1991	Rp 7	rp 7	cái	80000	0	\N	2025-07-18 16:43:48.597075	2025-07-18 16:43:48.597075
1992	Rp 7 To	rp 7 to	hộp	40000	0	\N	2025-07-18 16:43:48.599086	2025-07-18 16:43:48.599086
1993	Rũa Kapusi	rua kapusi	cái	60000	0	\N	2025-07-18 16:43:48.602528	2025-07-18 16:43:48.602528
1994	Rũi Sơn Dài	rui son dai	cái	25000	0	\N	2025-07-18 16:43:48.605539	2025-07-18 16:43:48.605539
1995	Rui Sơn Ngắn	rui son ngan	cái	20000	0	\N	2025-07-18 16:43:48.608553	2025-07-18 16:43:48.608553
1996	Rút Lõi 112	rut loi 112	cái	440000	0	\N	2025-07-18 16:43:48.610553	2025-07-18 16:43:48.610553
1997	Rút Lõi 76	rut loi 76	cái	304000	0	\N	2025-07-18 16:43:48.614553	2025-07-18 16:43:48.614553
1998	Sạc Laze	sac laze	cái	60000	0	\N	2025-07-18 16:43:48.617784	2025-07-18 16:43:48.617784
1999	Sàng Cát	sang cat	m	30000	0	\N	2025-07-18 16:43:48.620798	2025-07-18 16:43:48.620798
2000	Sào 2M	sao 2m	cái	10000	0	\N	2025-07-18 16:43:48.623776	2025-07-18 16:43:48.623776
2001	Sapoka Ổ 2 Cam	sapoka o 2 cam	cái	35000	0	\N	2025-07-18 16:43:48.626782	2025-07-18 16:43:48.626782
2002	Sâu Nhựa Rẻ 15	sau nhua re 15	cái	1000	0	\N	2025-07-18 16:43:48.628813	2025-07-18 16:43:48.628813
2003	Sâu Ren Nhôm	sau ren nhom	cái	6000	0	\N	2025-07-18 16:43:48.631829	2025-07-18 16:43:48.631829
2004	Schneider Át 1/16 (Snaido)	schneider at 1/16 (snaido)	cái	187000	0	\N	2025-07-18 16:43:48.633797	2025-07-18 16:43:48.633797
2005	Schneider Át 1/20 A9K27120	schneider at 1/20 a9k27120	cái	187000	0	\N	2025-07-18 16:43:48.636824	2025-07-18 16:43:48.636824
2006	Schneider Át 1/25 (Snaido)	schneider at 1/25 (snaido)	cái	187000	0	\N	2025-07-18 16:43:48.638827	2025-07-18 16:43:48.638827
2007	Schneider Át 10Ka 3P 100A-A9N18367	schneider at 10ka 3p 100a-a9n18367	cái	4565000	0	\N	2025-07-18 16:43:48.640827	2025-07-18 16:43:48.640827
2008	Schneider Át 120A (Snaido)	schneider at 120a (snaido)	cái	187000	0	\N	2025-07-18 16:43:48.641813	2025-07-18 16:43:48.641813
2009	Schneider Át 1P+N40A_A9D31640	schneider at 1p+n40a_a9d31640	cái	2574000	0	\N	2025-07-18 16:43:48.646189	2025-07-18 16:43:48.646189
2010	Schneider Át 2/20 A9K27220	schneider at 2/20 a9k27220	cái	528000	0	\N	2025-07-18 16:43:48.648175	2025-07-18 16:43:48.648175
2011	Schneider Át 2/32 A9K27232	schneider at 2/32 a9k27232	cái	528000	0	\N	2025-07-18 16:43:48.65119	2025-07-18 16:43:48.65119
2012	Schneider Át 2/40 A9K24240	schneider at 2/40 a9k24240	cái	632500	0	\N	2025-07-18 16:43:48.653189	2025-07-18 16:43:48.653189
2013	Schneider Át 3/32 (Snaido)	schneider at 3/32 (snaido)	cái	858000	0	\N	2025-07-18 16:43:48.655189	2025-07-18 16:43:48.655189
2014	Schneider Át 3/63 (Snaido)	schneider at 3/63 (snaido)	cái	1243000	0	\N	2025-07-18 16:43:48.658455	2025-07-18 16:43:48.658455
2015	Schneider Át Chống Giật 2/32 (Snaido)	schneider at chong giat 2/32 (snaido)	cái	2574000	0	\N	2025-07-18 16:43:48.660513	2025-07-18 16:43:48.660513
2016	Schneider Át Chống Giật 2/40 (Snaido)	schneider at chong giat 2/40 (snaido)	cái	2574000	0	\N	2025-07-18 16:43:48.663497	2025-07-18 16:43:48.663497
2017	Schneider Tủ Điện 24 Át Resi 9-Mip22212	schneider tu dien 24 at resi 9-mip22212	cái	1661000	0	\N	2025-07-18 16:43:48.666507	2025-07-18 16:43:48.666507
2018	Sen 268 Saphias	sen 268 saphias	bộ	800000	0	\N	2025-07-18 16:43:48.667514	2025-07-18 16:43:48.667514
2019	Sen Cây A018	sen cay a018	bộ	5600000	0	\N	2025-07-18 16:43:48.670499	2025-07-18 16:43:48.670499
2020	Sen Cây A06	sen cay a06	bộ	3800000	0	\N	2025-07-18 16:43:48.672513	2025-07-18 16:43:48.672513
2021	Sen Cây Selta A023	sen cay selta a023	cái	5500000	0	\N	2025-07-18 16:43:48.674546	2025-07-18 16:43:48.674546
2022	Sen Cây Selta A024	sen cay selta a024	cái	2700000	0	\N	2025-07-18 16:43:48.67656	2025-07-18 16:43:48.67656
2023	Sen Cây Sen Ta	sen cay sen ta	cái	3500000	0	\N	2025-07-18 16:43:48.679546	2025-07-18 16:43:48.679546
2024	Sen Cây Sen Ta A007	sen cay sen ta a007	cái	3500000	0	\N	2025-07-18 16:43:48.68156	2025-07-18 16:43:48.68156
2025	Sen Liền Vòi Đồng Thường	sen lien voi dong thuong	bộ	750000	0	\N	2025-07-18 16:43:48.683546	2025-07-18 16:43:48.683546
2026	Sen Liền Vòi Senta	sen lien voi senta	cái	1280000	0	\N	2025-07-18 16:43:48.685546	2025-07-18 16:43:48.685546
2027	Sen Sen Ta Sb 2018	sen sen ta sb 2018	bộ	1300000	0	\N	2025-07-18 16:43:48.68756	2025-07-18 16:43:48.68756
2028	Sen Tắm 2019 Senta	sen tam 2019 senta	bộ	1250000	0	\N	2025-07-18 16:43:48.69114	2025-07-18 16:43:48.69114
2029	Sen Tắm 301	sen tam 301	bộ	650000	0	\N	2025-07-18 16:43:48.693142	2025-07-18 16:43:48.693142
2030	Sen Tắm 501	sen tam 501	cái	750000	0	\N	2025-07-18 16:43:48.695681	2025-07-18 16:43:48.695681
2031	Sen Tắm Linax	sen tam linax	bộ	1700000	0	\N	2025-07-18 16:43:48.697698	2025-07-18 16:43:48.697698
2032	Sen Tắm Sen Ta 2018	sen tam sen ta 2018	cái	1300000	0	\N	2025-07-18 16:43:48.699698	2025-07-18 16:43:48.699698
2033	Sen Tắm Sf 280	sen tam sf 280	cái	1030000	0	\N	2025-07-18 16:43:48.702675	2025-07-18 16:43:48.702675
2034	Sen Tắm Trung	sen tam trung	cái	650000	0	\N	2025-07-18 16:43:48.705684	2025-07-18 16:43:48.705684
2035	Sen Tắm Vg581	sen tam vg581	cái	4200000	0	\N	2025-07-18 16:43:48.706683	2025-07-18 16:43:48.706683
2036	Si	si	bao	200000	0	\N	2025-07-18 16:43:48.708684	2025-07-18 16:43:48.708684
2037	Si Phông Rửa Bát Sơn Hà	si phong rua bat son ha	cái	100000	0	\N	2025-07-18 16:43:48.710698	2025-07-18 16:43:48.710698
2038	Si Phông Rút	si phong rut	cái	50000	0	\N	2025-07-18 16:43:48.712683	2025-07-18 16:43:48.712683
2039	Si Phông Rút -Xám	si phong rut -xam	cái	60000	0	\N	2025-07-18 16:43:48.714684	2025-07-18 16:43:48.714684
2040	Si Pông 42	si pong 42	cái	31320	0	\N	2025-07-18 16:43:48.716682	2025-07-18 16:43:48.716682
2041	Si Pông 75	si pong 75	cái	121255	0	\N	2025-07-18 16:43:48.718698	2025-07-18 16:43:48.718698
2042	Si Pông 90	si pong 90	cái	141790	0	\N	2025-07-18 16:43:48.721698	2025-07-18 16:43:48.721698
2043	Sika 107 Tópseal	sika 107 topseal	cặp	870000	0	\N	2025-07-18 16:43:48.723698	2025-07-18 16:43:48.723698
2044	Sika 214	sika 214	bao	290000	0	\N	2025-07-18 16:43:48.725456	2025-07-18 16:43:48.725456
2045	Sika B52	sika b52	cặp	750000	0	\N	2025-07-18 16:43:48.727725	2025-07-18 16:43:48.727725
2046	Sika Latex Th	sika latex th	can	300000	0	\N	2025-07-18 16:43:48.729288	2025-07-18 16:43:48.729288
2047	Sika Membrem	sika membrem	thùng	1200000	0	\N	2025-07-18 16:43:48.731937	2025-07-18 16:43:48.731937
2048	Sika Tự Chảy Thường	sika tu chay thuong	bao	200000	0	\N	2025-07-18 16:43:48.735618	2025-07-18 16:43:48.735618
2049	Silicon 500 Đen	silicon 500 den	lọ	55000	0	\N	2025-07-18 16:43:48.737626	2025-07-18 16:43:48.737626
2050	Silicon 500 Ghi	silicon 500 ghi	lọ	50000	0	\N	2025-07-18 16:43:48.739676	2025-07-18 16:43:48.739676
2051	Silicon A 200	silicon a 200	thùng	1200000	0	\N	2025-07-18 16:43:48.741676	2025-07-18 16:43:48.741676
2052	Silicon A100	silicon a100	lọ	33000	0	\N	2025-07-18 16:43:48.743676	2025-07-18 16:43:48.743676
2053	Silicon A200	silicon a200	lọ	50000	0	\N	2025-07-18 16:43:48.747239	2025-07-18 16:43:48.747239
2054	Silicon A300	silicon a300	lọ	65000	0	\N	2025-07-18 16:43:48.74924	2025-07-18 16:43:48.74924
2055	Silicon A500 Black	silicon a500 black	lọ	50000	0	\N	2025-07-18 16:43:48.751255	2025-07-18 16:43:48.751255
2056	Silicon A500 Đục	silicon a500 duc	lọ	50000	0	\N	2025-07-18 16:43:48.753255	2025-07-18 16:43:48.753255
2057	Silicon A500 Trong	silicon a500 trong	lọ	55000	0	\N	2025-07-18 16:43:48.756255	2025-07-18 16:43:48.756255
2058	Silicon A600	silicon a600	lọ	65000	0	\N	2025-07-18 16:43:48.759283	2025-07-18 16:43:48.759283
2059	Silicon Nâu	silicon nau	cái	50000	0	\N	2025-07-18 16:43:48.761299	2025-07-18 16:43:48.761299
2060	Sino Át 3/63A Cam	sino at 3/63a cam	cái	248500	0	\N	2025-07-18 16:43:48.763298	2025-07-18 16:43:48.763298
2061	Sino Át Cài 3/32 Cam	sino at cai 3/32 cam	cái	208000	0	\N	2025-07-18 16:43:48.765284	2025-07-18 16:43:48.765284
2062	Sino Át Cài 3/40A Cam	sino at cai 3/40a cam	cái	165000	0	\N	2025-07-18 16:43:48.769283	2025-07-18 16:43:48.769283
2063	Sino Át Cài 3/50 Cam	sino at cai 3/50 cam	cái	190000	0	\N	2025-07-18 16:43:48.772284	2025-07-18 16:43:48.772284
2064	Sino Át Cài 3/63 A Cam	sino at cai 3/63 a cam	cái	248500	0	\N	2025-07-18 16:43:48.774284	2025-07-18 16:43:48.774284
2065	Sino Át Cam 2/63A	sino at cam 2/63a	cái	158500	0	\N	2025-07-18 16:43:48.775316	2025-07-18 16:43:48.775316
2066	Sino Át Cam 3/25	sino at cam 3/25	cái	175000	0	\N	2025-07-18 16:43:48.778318	2025-07-18 16:43:48.778318
2067	Sino Át Cam 3/32	sino at cam 3/32	cái	208000	0	\N	2025-07-18 16:43:48.779316	2025-07-18 16:43:48.779316
2068	Sino Át Cam 3/50	sino at cam 3/50	cái	248000	0	\N	2025-07-18 16:43:48.781317	2025-07-18 16:43:48.781317
2069	Sino Át Cam Át 1/10A	sino at cam at 1/10a	cái	62000	0	\N	2025-07-18 16:43:48.783314	2025-07-18 16:43:48.783314
2070	Sino Át Cam Át 1/16A	sino at cam at 1/16a	cái	62000	0	\N	2025-07-18 16:43:48.78633	2025-07-18 16:43:48.78633
2071	Sino Át Cam Át 1/20A	sino at cam at 1/20a	cái	62000	0	\N	2025-07-18 16:43:48.78833	2025-07-18 16:43:48.78833
2072	Sino Át Cam Át 1/25A	sino at cam at 1/25a	cái	62000	0	\N	2025-07-18 16:43:48.791732	2025-07-18 16:43:48.791732
2073	Sino Át Cam Át 1/32 A	sino at cam at 1/32 a	cái	62000	0	\N	2025-07-18 16:43:48.793718	2025-07-18 16:43:48.793718
2074	Sino Át Cam Át 1/40A	sino at cam at 1/40a	cái	62000	0	\N	2025-07-18 16:43:48.795732	2025-07-18 16:43:48.795732
2075	Sino Át Cam Át 1/50A	sino at cam at 1/50a	cái	72000	0	\N	2025-07-18 16:43:48.798296	2025-07-18 16:43:48.798296
2076	Sino Át Cam Át 1/63A	sino at cam at 1/63a	cái	72000	0	\N	2025-07-18 16:43:48.800296	2025-07-18 16:43:48.800296
2077	Sino Át Cam Át 2/16A	sino at cam at 2/16a	cái	136000	0	\N	2025-07-18 16:43:48.802296	2025-07-18 16:43:48.802296
2078	Sino Át Cam Át 2/20A	sino at cam at 2/20a	cái	136000	0	\N	2025-07-18 16:43:48.805282	2025-07-18 16:43:48.805282
2079	Sino Át Cam Át 2/25A	sino at cam at 2/25a	cái	136000	0	\N	2025-07-18 16:43:48.806282	2025-07-18 16:43:48.806282
2080	Sino Át Cam Át 2/32A	sino at cam at 2/32a	cái	136000	0	\N	2025-07-18 16:43:48.808296	2025-07-18 16:43:48.808296
2081	Sino Át Cam Át 2/40A	sino at cam at 2/40a	cái	136000	0	\N	2025-07-18 16:43:48.811296	2025-07-18 16:43:48.811296
2082	Sino Át Cam Át 2/50A	sino at cam at 2/50a	cái	158500	0	\N	2025-07-18 16:43:48.814297	2025-07-18 16:43:48.814297
2083	Sino Át Cam Át 2/63A	sino at cam at 2/63a	cái	158500	0	\N	2025-07-18 16:43:48.816282	2025-07-18 16:43:48.816282
2084	Sino Át Đen 20A	sino at den 20a	cái	45000	0	\N	2025-07-18 16:43:48.818296	2025-07-18 16:43:48.818296
2085	Sino Át Đen 30A	sino at den 30a	cái	40000	0	\N	2025-07-18 16:43:48.821297	2025-07-18 16:43:48.821297
2086	Sino Đế Nổi Cao	sino de noi cao	cái	5000	0	\N	2025-07-18 16:43:48.823296	2025-07-18 16:43:48.823296
2087	Sino Mặt Át Đôi	sino mat at doi	cái	10000	0	\N	2025-07-18 16:43:48.825282	2025-07-18 16:43:48.825282
2088	Sino Mặt Át Đơn	sino mat at don	cái	10000	0	\N	2025-07-18 16:43:48.827282	2025-07-18 16:43:48.827282
2089	Sino Mặt Chống Nước	sino mat chong nuoc	cái	70000	0	\N	2025-07-18 16:43:48.829296	2025-07-18 16:43:48.829296
2090	Sino Ổ Cắm Âm Sàn	sino o cam am san	cái	620000	0	\N	2025-07-18 16:43:48.832329	2025-07-18 16:43:48.832329
2092	Sino S18 Cc Chiết Áp Quạt	sino s18 cc chiet ap quat	cái	117200	0	\N	2025-07-18 16:43:48.83835	2025-07-18 16:43:48.83835
2093	Sino S18 Cc Hạt Công Tắc 1 Chiều	sino s18 cc hat cong tac 1 chieu	cái	13800	0	\N	2025-07-18 16:43:48.840369	2025-07-18 16:43:48.840369
2094	Sino S18 Cc Hạt Công Tắc 2 Chiều	sino s18 cc hat cong tac 2 chieu	cái	29800	0	\N	2025-07-18 16:43:48.842369	2025-07-18 16:43:48.842369
2095	Sino S18 Cc Hạt Công Tắc 20A 2 Cực	sino s18 cc hat cong tac 20a 2 cuc	cái	85000	0	\N	2025-07-18 16:43:48.845914	2025-07-18 16:43:48.845914
2096	Sino S18 Cc Hạt Đèn Báo Đỏ, Xanh	sino s18 cc hat den bao do, xanh	cái	12600	0	\N	2025-07-18 16:43:48.847948	2025-07-18 16:43:48.847948
2097	Sino S18 Cc Hạt Điện Thoại	sino s18 cc hat dien thoai	cái	53500	0	\N	2025-07-18 16:43:48.851948	2025-07-18 16:43:48.851948
2098	Sino S18 Cc Hạt Mạng	sino s18 cc hat mang	cái	119000	0	\N	2025-07-18 16:43:48.854962	2025-07-18 16:43:48.854962
2099	Sino S18 Cc Hạt Tivi	sino s18 cc hat tivi	cái	53500	0	\N	2025-07-18 16:43:48.858946	2025-07-18 16:43:48.858946
2100	Sino S18 Cc Mặt 1	sino s18 cc mat 1	cái	13500	0	\N	2025-07-18 16:43:48.861962	2025-07-18 16:43:48.861962
2101	Sino S18 Cc Mặt 2	sino s18 cc mat 2	cái	13500	0	\N	2025-07-18 16:43:48.863948	2025-07-18 16:43:48.863948
2102	Sino S18 Cc Mặt 3	sino s18 cc mat 3	cái	13500	0	\N	2025-07-18 16:43:48.865948	2025-07-18 16:43:48.865948
2103	Sino S18 Cc Mặt 4	sino s18 cc mat 4	cái	26800	0	\N	2025-07-18 16:43:48.868217	2025-07-18 16:43:48.868217
2104	Sino S18 Cc Mặt 5	sino s18 cc mat 5	cái	26800	0	\N	2025-07-18 16:43:48.872252	2025-07-18 16:43:48.872252
2105	Sino S18 Cc Mặt 6	sino s18 cc mat 6	cái	26800	0	\N	2025-07-18 16:43:48.874238	2025-07-18 16:43:48.874238
2106	Sino S18 Cc Ổ I - 2 Chấu	sino s18 cc o i - 2 chau	cái	26200	0	\N	2025-07-18 16:43:48.876284	2025-07-18 16:43:48.876284
2107	Sino S18 Cc Ổ I - 3 Chấu	sino s18 cc o i - 3 chau	cái	54000	0	\N	2025-07-18 16:43:48.879248	2025-07-18 16:43:48.879248
2108	Sino S18 Cc Ổ Ii - 3 Chấu	sino s18 cc o ii - 3 chau	cái	62500	0	\N	2025-07-18 16:43:48.883285	2025-07-18 16:43:48.883285
2109	Sino S18 Chiết Áp Đèn	sino s18 chiet ap den	cái	102000	0	\N	2025-07-18 16:43:48.885284	2025-07-18 16:43:48.885284
2110	Sino S18 Chiết Áp Quạt	sino s18 chiet ap quat	cái	102000	0	\N	2025-07-18 16:43:48.888284	2025-07-18 16:43:48.888284
2111	Sino S18 Hạt Công Tắc 1 Chiều	sino s18 hat cong tac 1 chieu	cái	10200	0	\N	2025-07-18 16:43:48.890765	2025-07-18 16:43:48.890765
2112	Sino S18 Hạt Công Tắc 2 Chiều	sino s18 hat cong tac 2 chieu	cái	17800	0	\N	2025-07-18 16:43:48.893794	2025-07-18 16:43:48.893794
2113	Sino S18 Hạt Công Tắc 20A 2 Cực	sino s18 hat cong tac 20a 2 cuc	cái	65500	0	\N	2025-07-18 16:43:48.896328	2025-07-18 16:43:48.896328
2114	Sino S18 Hạt Đèn Báo Đỏ, Xanh	sino s18 hat den bao do, xanh	cái	16500	0	\N	2025-07-18 16:43:48.897376	2025-07-18 16:43:48.897376
2115	Sino S18 Hạt Điện Thoại	sino s18 hat dien thoai	cái	49600	0	\N	2025-07-18 16:43:48.900729	2025-07-18 16:43:48.900729
2116	Sino S18 Hạt Mạng	sino s18 hat mang	cái	65600	0	\N	2025-07-18 16:43:48.903729	2025-07-18 16:43:48.903729
2117	Sino S18 Hạt Tivi	sino s18 hat tivi	cái	40200	0	\N	2025-07-18 16:43:48.905743	2025-07-18 16:43:48.905743
2118	Sino S18 Mặt 1	sino s18 mat 1	cái	12500	0	\N	2025-07-18 16:43:48.908743	2025-07-18 16:43:48.908743
2119	Sino S18 Mặt 2	sino s18 mat 2	cái	12500	0	\N	2025-07-18 16:43:48.910743	2025-07-18 16:43:48.910743
2120	Sino S18 Mặt 3	sino s18 mat 3	cái	12500	0	\N	2025-07-18 16:43:48.914707	2025-07-18 16:43:48.914707
2121	Sino S18 Mặt 4	sino s18 mat 4	cái	15800	0	\N	2025-07-18 16:43:48.916729	2025-07-18 16:43:48.916729
2122	Sino S18 Mặt 5	sino s18 mat 5	cái	15800	0	\N	2025-07-18 16:43:48.917729	2025-07-18 16:43:48.917729
2123	Sino S18 Mặt 6	sino s18 mat 6	cái	15800	0	\N	2025-07-18 16:43:48.919729	2025-07-18 16:43:48.919729
2124	Sino S18 Ổ 1 - 2 Chấu	sino s18 o 1 - 2 chau	cái	29500	0	\N	2025-07-18 16:43:48.921743	2025-07-18 16:43:48.921743
2125	Sino S18 Ổ 1 - 3 Chấu	sino s18 o 1 - 3 chau	cái	41800	0	\N	2025-07-18 16:43:48.924745	2025-07-18 16:43:48.924745
2126	Sino S18 Ổ 1 + 1 Lỗ , + 2 Lỗ	sino s18 o 1 + 1 lo , + 2 lo	cái	36200	0	\N	2025-07-18 16:43:48.926728	2025-07-18 16:43:48.926728
2127	Sino S18 Ổ 2 - 2 Chấu	sino s18 o 2 - 2 chau	cái	44600	0	\N	2025-07-18 16:43:48.927726	2025-07-18 16:43:48.927726
2128	Sino S18 Ổ 2 - 3 Chấu	sino s18 o 2 - 3 chau	cái	57000	0	\N	2025-07-18 16:43:48.929559	2025-07-18 16:43:48.929559
2129	Sino S18 Ổ 2 + 1 Lỗ	sino s18 o 2 + 1 lo	cái	43500	0	\N	2025-07-18 16:43:48.932829	2025-07-18 16:43:48.932829
2130	Sino S18 Ổ 2 + 2 Lỗ	sino s18 o 2 + 2 lo	cái	43500	0	\N	2025-07-18 16:43:48.93477	2025-07-18 16:43:48.93477
2131	Sino S18 Ổ 3 - 2 Chấu	sino s18 o 3 - 2 chau	cái	54800	0	\N	2025-07-18 16:43:48.936898	2025-07-18 16:43:48.936898
2132	Sino S18A Chiết Áp Đèn	sino s18a chiet ap den	cái	116500	0	\N	2025-07-18 16:43:48.940398	2025-07-18 16:43:48.940398
2133	Sino S18A Chiết Áp Quạt	sino s18a chiet ap quat	cái	123600	0	\N	2025-07-18 16:43:48.943422	2025-07-18 16:43:48.943422
2134	Sino S18A Hạt Công Tắc 1 Chiều	sino s18a hat cong tac 1 chieu	cái	10800	0	\N	2025-07-18 16:43:48.946921	2025-07-18 16:43:48.946921
2135	Sino S18A Hạt Công Tắc 2 Chiều	sino s18a hat cong tac 2 chieu	cái	19200	0	\N	2025-07-18 16:43:48.948956	2025-07-18 16:43:48.948956
2136	Sino S18A Hạt Công Tắc 20A 2 Cực	sino s18a hat cong tac 20a 2 cuc	cái	69200	0	\N	2025-07-18 16:43:48.951967	2025-07-18 16:43:48.951967
2137	Sino S18A Hạt Đèn Báo Đỏ, Xanh	sino s18a hat den bao do, xanh	cái	19200	0	\N	2025-07-18 16:43:48.953967	2025-07-18 16:43:48.953967
2138	Sino S18A Hạt Điện Thoại	sino s18a hat dien thoai	cái	60000	0	\N	2025-07-18 16:43:48.956938	2025-07-18 16:43:48.956938
2139	Sino S18A Hạt Mạng	sino s18a hat mang	cái	72800	0	\N	2025-07-18 16:43:48.959968	2025-07-18 16:43:48.959968
2140	Sino S18A Hạt Tivi	sino s18a hat tivi	cái	40800	0	\N	2025-07-18 16:43:48.963185	2025-07-18 16:43:48.963185
2141	Sino S18A Mặt 1	sino s18a mat 1	cái	13500	0	\N	2025-07-18 16:43:48.965171	2025-07-18 16:43:48.965171
2142	Sino S18A Mặt 2	sino s18a mat 2	cái	13500	0	\N	2025-07-18 16:43:48.966171	2025-07-18 16:43:48.966171
2143	Sino S18A Mặt 3	sino s18a mat 3	cái	13500	0	\N	2025-07-18 16:43:48.969185	2025-07-18 16:43:48.969185
2144	Sino S18A Mặt 4	sino s18a mat 4	cái	18200	0	\N	2025-07-18 16:43:48.971172	2025-07-18 16:43:48.971172
2145	Sino S18A Mặt 5	sino s18a mat 5	cái	18200	0	\N	2025-07-18 16:43:48.973171	2025-07-18 16:43:48.973171
2146	Sino S18A Mặt 6	sino s18a mat 6	cái	18200	0	\N	2025-07-18 16:43:48.976218	2025-07-18 16:43:48.976218
2147	Sino S18A Ổ 1 - 2 Chấu	sino s18a o 1 - 2 chau	cái	35500	0	\N	2025-07-18 16:43:48.978723	2025-07-18 16:43:48.978723
2148	Sino S18A Ổ 1 - 3 Chấu	sino s18a o 1 - 3 chau	cái	50200	0	\N	2025-07-18 16:43:48.980735	2025-07-18 16:43:48.980735
2149	Sino S18A Ổ 1 + 1 Lỗ	sino s18a o 1 + 1 lo	cái	43500	0	\N	2025-07-18 16:43:48.983741	2025-07-18 16:43:48.983741
2150	Sino S18A Ổ 1 + 2 Lỗ	sino s18a o 1 + 2 lo	cái	43500	0	\N	2025-07-18 16:43:48.986757	2025-07-18 16:43:48.986757
2151	Sino S18A Ổ 2 - 2 Chấu	sino s18a o 2 - 2 chau	cái	53500	0	\N	2025-07-18 16:43:48.987743	2025-07-18 16:43:48.987743
2152	Sino S18A Ổ 2 - 3 Chấu	sino s18a o 2 - 3 chau	cái	68500	0	\N	2025-07-18 16:43:48.991649	2025-07-18 16:43:48.991649
2153	Sino S18A Ổ 2 + 1 Lỗ	sino s18a o 2 + 1 lo	cái	52200	0	\N	2025-07-18 16:43:48.993704	2025-07-18 16:43:48.993704
2154	Sino S18A Ổ 2 + 2 Lỗ	sino s18a o 2 + 2 lo	cái	52200	0	\N	2025-07-18 16:43:48.996704	2025-07-18 16:43:48.996704
2155	Sino S18A Ổ 3 - 2 Chấu	sino s18a o 3 - 2 chau	cái	65800	0	\N	2025-07-18 16:43:48.999148	2025-07-18 16:43:48.999148
2156	Sino Tủ Át 28 Át	sino tu at 28 at	cái	948000	0	\N	2025-07-18 16:43:49.001161	2025-07-18 16:43:49.001161
2157	Sino Tủ Điện 14/18 Át	sino tu dien 14/18 at	cái	620000	0	\N	2025-07-18 16:43:49.005151	2025-07-18 16:43:49.005151
2158	Sino Tủ Điện 2/4 Át	sino tu dien 2/4 at	cái	117000	0	\N	2025-07-18 16:43:49.008129	2025-07-18 16:43:49.008129
2159	Sino Tủ Điện 3/6 Át	sino tu dien 3/6 at	cái	152000	0	\N	2025-07-18 16:43:49.010145	2025-07-18 16:43:49.010145
2160	Sino Tủ Điện 4/8 Át	sino tu dien 4/8 at	cái	230000	0	\N	2025-07-18 16:43:49.012128	2025-07-18 16:43:49.012128
2161	Sino Tủ Điện 8/12 Át	sino tu dien 8/12 at	cái	266000	0	\N	2025-07-18 16:43:49.014555	2025-07-18 16:43:49.014555
2162	Sơn 0.8 Đại Bàng	son 0.8 dai bang	cái	55000	0	\N	2025-07-18 16:43:49.016609	2025-07-18 16:43:49.016609
2163	Sơn Chống Rỉ 08 Đb	son chong ri 08 db	hộp	55000	0	\N	2025-07-18 16:43:49.018623	2025-07-18 16:43:49.018623
2164	Sơn Chống Rỉ Đại Bàng 3 Kg	son chong ri dai bang 3 kg	hộp	160000	0	\N	2025-07-18 16:43:49.021623	2025-07-18 16:43:49.021623
2165	Sơn Chống Rỉ Ghi Indo 08	son chong ri ghi indo 08	hộp	55000	0	\N	2025-07-18 16:43:49.024623	2025-07-18 16:43:49.024623
2166	Sơn Chống Rỉ Indo 3 Kg Ghi	son chong ri indo 3 kg ghi	hộp	150000	0	\N	2025-07-18 16:43:49.027777	2025-07-18 16:43:49.027777
2167	Sơn Đb 3 Kg Cr	son db 3 kg cr	lọ	168000	0	\N	2025-07-18 16:43:49.029779	2025-07-18 16:43:49.029779
2168	Sơn Đen 08 Đb	son den 08 db	hộp	75000	0	\N	2025-07-18 16:43:49.031781	2025-07-18 16:43:49.031781
2169	Sơn Đen 3 Kg Đại Bàng	son den 3 kg dai bang	lon	185000	0	\N	2025-07-18 16:43:49.03479	2025-07-18 16:43:49.03479
2170	Sơn Đỏ 3 Kg Đb	son do 3 kg db	hộp	230000	0	\N	2025-07-18 16:43:49.037786	2025-07-18 16:43:49.037786
2171	Sơn Đỏ 3 Kg Zn	son do 3 kg zn	hộp	235000	0	\N	2025-07-18 16:43:49.038786	2025-07-18 16:43:49.038786
2172	Sơn Ghi 08 Đb	son ghi 08 db	hộp	75000	0	\N	2025-07-18 16:43:49.040796	2025-07-18 16:43:49.040796
2173	Sơn Ghi 08 Zn	son ghi 08 zn	hộp	80000	0	\N	2025-07-18 16:43:49.042786	2025-07-18 16:43:49.042786
2174	Sơn Nhũ 08 Đb	son nhu 08 db	hộp	85000	0	\N	2025-07-18 16:43:49.044786	2025-07-18 16:43:49.044786
2175	Sơn Thái Vàng 01	son thai vang 01	lọ	15000	0	\N	2025-07-18 16:43:49.046788	2025-07-18 16:43:49.046788
2176	Sơn Xịt 211	son xit 211	lọ	30000	0	\N	2025-07-18 16:43:49.050079	2025-07-18 16:43:49.050079
2177	Sơn Xịt 212	son xit 212	lọ	30000	0	\N	2025-07-18 16:43:49.052081	2025-07-18 16:43:49.052081
2178	Sơn Xịt A300	son xit a300	lọ	30000	0	\N	2025-07-18 16:43:49.055078	2025-07-18 16:43:49.055078
2179	Sơn Xịt Đen 210	son xit den 210	lọ	30000	0	\N	2025-07-18 16:43:49.05708	2025-07-18 16:43:49.05708
2180	Sơn Xịt Đỏ	son xit do	lọ	30000	0	\N	2025-07-18 16:43:49.059076	2025-07-18 16:43:49.059076
2181	Sơn Xịt Trắng	son xit trang	lọ	30000	0	\N	2025-07-18 16:43:49.061078	2025-07-18 16:43:49.061078
2182	Sơn Zn 0.8 Trắng	son zn 0.8 trang	cái	85000	0	\N	2025-07-18 16:43:49.063076	2025-07-18 16:43:49.063076
2183	Sơn Zn 3 Kg Xanh	son zn 3 kg xanh	hộp	225000	0	\N	2025-07-18 16:43:49.065077	2025-07-18 16:43:49.065077
2184	Sơn Zn Đen 3 Kg	son zn den 3 kg	hộp	225000	0	\N	2025-07-18 16:43:49.069076	2025-07-18 16:43:49.069076
2185	Sơn Zn Ghi Sáng 3Kg	son zn ghi sang 3kg	cái	225000	0	\N	2025-07-18 16:43:49.073087	2025-07-18 16:43:49.073087
2186	Sơn Zn Kem 3 Kg	son zn kem 3 kg	hộp	235000	0	\N	2025-07-18 16:43:49.075108	2025-07-18 16:43:49.075108
2187	Sơn Zn Nhũ 08	son zn nhu 08	hộp	85000	0	\N	2025-07-18 16:43:49.078108	2025-07-18 16:43:49.078108
2188	Sơn Zn Trắng 3 Kg	son zn trang 3 kg	hộp	225000	0	\N	2025-07-18 16:43:49.080107	2025-07-18 16:43:49.080107
2189	Sơn Zn Vàng Cam 3 Kg	son zn vang cam 3 kg	lọ	235000	0	\N	2025-07-18 16:43:49.083109	2025-07-18 16:43:49.083109
2190	Sơn Zn Xing Pha 08	son zn xing pha 08	hộp	85000	0	\N	2025-07-18 16:43:49.085105	2025-07-18 16:43:49.085105
2191	Sơn Zn Xing Pha 3 Kg	son zn xing pha 3 kg	hộp	235000	0	\N	2025-07-18 16:43:49.087108	2025-07-18 16:43:49.087108
2192	Sopoka Ổ 1	sopoka o 1	cái	13000	0	\N	2025-07-18 16:43:49.090619	2025-07-18 16:43:49.090619
2193	Sopoka Ổ 3 Trắng	sopoka o 3 trang	cái	25000	0	\N	2025-07-18 16:43:49.091619	2025-07-18 16:43:49.09262
2194	Sp Chia Ngả 3/ 20	sp chia nga 3/ 20	cái	6100	0	\N	2025-07-18 16:43:49.094621	2025-07-18 16:43:49.094621
2195	Sp Chia Ngả 3/16	sp chia nga 3/16	cái	5920	0	\N	2025-07-18 16:43:49.097126	2025-07-18 16:43:49.097126
2196	Sp Chia Ngả 3/25	sp chia nga 3/25	cái	6880	0	\N	2025-07-18 16:43:49.099137	2025-07-18 16:43:49.099137
2197	Sp Chia Ngả 4/ 20	sp chia nga 4/ 20	cái	6100	0	\N	2025-07-18 16:43:49.102604	2025-07-18 16:43:49.102604
2198	Sp Chia Ngả 4/16	sp chia nga 4/16	cái	5920	0	\N	2025-07-18 16:43:49.106084	2025-07-18 16:43:49.106084
2199	Sp Chia Ngả 4/25	sp chia nga 4/25	cái	6880	0	\N	2025-07-18 16:43:49.108084	2025-07-18 16:43:49.108084
2200	Sp Cút Nắp 16	sp cut nap 16	cái	3380	0	\N	2025-07-18 16:43:49.110085	2025-07-18 16:43:49.110085
2201	Sp Cút Nắp 20	sp cut nap 20	cái	4850	0	\N	2025-07-18 16:43:49.113087	2025-07-18 16:43:49.113087
2202	Sp Cút Nắp 25	sp cut nap 25	cái	8000	0	\N	2025-07-18 16:43:49.115362	2025-07-18 16:43:49.115362
2203	Sp Cút Nắp 32	sp cut nap 32	cái	11600	0	\N	2025-07-18 16:43:49.116468	2025-07-18 16:43:49.116468
2204	Sp Cút Trơn 16	sp cut tron 16	cái	3000	0	\N	2025-07-18 16:43:49.118468	2025-07-18 16:43:49.118468
2205	Sp Cút Trơn 20	sp cut tron 20	cái	4200	0	\N	2025-07-18 16:43:49.121467	2025-07-18 16:43:49.121467
2206	Sp Cút Trơn 25	sp cut tron 25	cái	7000	0	\N	2025-07-18 16:43:49.123469	2025-07-18 16:43:49.123469
2207	Sp Cút Trơn 32	sp cut tron 32	cái	10200	0	\N	2025-07-18 16:43:49.126467	2025-07-18 16:43:49.126467
2208	Sp Ghen Ruột Gà 16	sp ghen ruot ga 16	m	2500	0	\N	2025-07-18 16:43:49.128468	2025-07-18 16:43:49.128468
2209	Sp Ghen Ruột Gà 16	sp ghen ruot ga 16	cuộn	190000	0	\N	2025-07-18 16:43:49.130469	2025-07-18 16:43:49.130469
2210	Sp Ghen Ruột Gà 20	sp ghen ruot ga 20	cuộn	232000	0	\N	2025-07-18 16:43:49.132468	2025-07-18 16:43:49.132468
2211	Sp Ghen Ruột Gà 25	sp ghen ruot ga 25	m	3500	0	\N	2025-07-18 16:43:49.134473	2025-07-18 16:43:49.134473
2212	Sp Ghen Ruột Gà 25	sp ghen ruot ga 25	cuộn	261000	0	\N	2025-07-18 16:43:49.135841	2025-07-18 16:43:49.135841
2213	Sp Ghen Ruột Gà 32	sp ghen ruot ga 32	m	10000	0	\N	2025-07-18 16:43:49.138877	2025-07-18 16:43:49.138877
2214	Sp Ghen Ruột Gà 32	sp ghen ruot ga 32	cuộn	356000	0	\N	2025-07-18 16:43:49.140877	2025-07-18 16:43:49.140877
2215	Sp Ghen Tròn 16	sp ghen tron 16	cây	20000	0	\N	2025-07-18 16:43:49.143877	2025-07-18 16:43:49.143877
2216	Sp Ghen Tròn 20	sp ghen tron 20	cây	27600	0	\N	2025-07-18 16:43:49.145888	2025-07-18 16:43:49.145888
2217	Sp Ghen Tròn 25	sp ghen tron 25	cây	40500	0	\N	2025-07-18 16:43:49.149452	2025-07-18 16:43:49.149452
2218	Sp Ghen Tròn 32	sp ghen tron 32	cây	82000	0	\N	2025-07-18 16:43:49.152468	2025-07-18 16:43:49.152468
2219	Sp Kẹp 16	sp kep 16	cái	1060	0	\N	2025-07-18 16:43:49.154468	2025-07-18 16:43:49.154468
2220	Sp Kẹp 20	sp kep 20	cái	1160	0	\N	2025-07-18 16:43:49.157439	2025-07-18 16:43:49.157439
2221	Sp Kẹp 25	sp kep 25	cái	2200	0	\N	2025-07-18 16:43:49.160454	2025-07-18 16:43:49.160454
2222	Sp Kẹp 32	sp kep 32	cái	2420	0	\N	2025-07-18 16:43:49.162454	2025-07-18 16:43:49.162454
2223	Sp Lò Xo Uốn Ống 16	sp lo xo uon ong 16	cái	45000	0	\N	2025-07-18 16:43:49.163454	2025-07-18 16:43:49.163454
2224	Sp Lò Xo Uốn Ống 20	sp lo xo uon ong 20	cái	0	0	\N	2025-07-18 16:43:49.165454	2025-07-18 16:43:49.165454
2225	Sp Lò Xo Uốn Ống 25	sp lo xo uon ong 25	cái	80000	0	\N	2025-07-18 16:43:49.167468	2025-07-18 16:43:49.167468
2226	Sp Lò Xo Uốn Ống 32	sp lo xo uon ong 32	cái	85000	0	\N	2025-07-18 16:43:49.170437	2025-07-18 16:43:49.170437
2227	Sp Măng Sông 16	sp mang song 16	cái	900	0	\N	2025-07-18 16:43:49.172452	2025-07-18 16:43:49.172452
2228	Sp Măng Sông 20	sp mang song 20	cái	980	0	\N	2025-07-18 16:43:49.174454	2025-07-18 16:43:49.174454
2229	Sp Măng Sông 25	sp mang song 25	cái	1600	0	\N	2025-07-18 16:43:49.1775	2025-07-18 16:43:49.1775
2230	Sp Măng Sông 32	sp mang song 32	cái	2200	0	\N	2025-07-18 16:43:49.179963	2025-07-18 16:43:49.179963
2231	Sp Nối Ren 16	sp noi ren 16	cái	2200	0	\N	2025-07-18 16:43:49.182087	2025-07-18 16:43:49.182087
2232	Sp Nối Ren 20	sp noi ren 20	cái	2320	0	\N	2025-07-18 16:43:49.18509	2025-07-18 16:43:49.18509
2233	Sp Nối Ren 25	sp noi ren 25	cái	2950	0	\N	2025-07-18 16:43:49.1871	2025-07-18 16:43:49.1871
2234	Sp Nối Ren 32	sp noi ren 32	cái	4900	0	\N	2025-07-18 16:43:49.189631	2025-07-18 16:43:49.189631
2235	Sp Tê Nắp 16	sp te nap 16	cái	4900	0	\N	2025-07-18 16:43:49.192666	2025-07-18 16:43:49.192666
2236	Sp Tê Nắp 20	sp te nap 20	cái	6850	0	\N	2025-07-18 16:43:49.194668	2025-07-18 16:43:49.194668
2237	Sp Tê Nắp 25	sp te nap 25	cái	8750	0	\N	2025-07-18 16:43:49.197658	2025-07-18 16:43:49.197658
2238	Sp Tê Nắp 32	sp te nap 32	cái	11200	0	\N	2025-07-18 16:43:49.200212	2025-07-18 16:43:49.200212
2239	Sp Tê Trơn 16	sp te tron 16	cái	4350	0	\N	2025-07-18 16:43:49.203715	2025-07-18 16:43:49.203715
2240	Sp Tê Trơn 20	sp te tron 20	cái	5720	0	\N	2025-07-18 16:43:49.20676	2025-07-18 16:43:49.20676
2241	Sp Tê Trơn 25	sp te tron 25	cái	7650	0	\N	2025-07-18 16:43:49.208747	2025-07-18 16:43:49.208747
2242	Sp Tê Trơn 32	sp te tron 32	cái	9580	0	\N	2025-07-18 16:43:49.21076	2025-07-18 16:43:49.21076
2243	Sủi Ngắn	sui ngan	cái	20000	0	\N	2025-07-18 16:43:49.214744	2025-07-18 16:43:49.214744
2244	Súng Bắn J 1013	sung ban j 1013	cái	250000	0	\N	2025-07-18 16:43:49.21676	2025-07-18 16:43:49.21676
2245	Súng Bắn Keo Silicon Rẻ	sung ban keo silicon re	cái	25000	0	\N	2025-07-18 16:43:49.21976	2025-07-18 16:43:49.21976
2246	Súng Bắn Silicon Inox	sung ban silicon inox	cái	35000	0	\N	2025-07-18 16:43:49.22176	2025-07-18 16:43:49.22176
2247	Súng Bắn Silicon Tốt Kapusi	sung ban silicon tot kapusi	cái	45000	0	\N	2025-07-18 16:43:49.22473	2025-07-18 16:43:49.22473
2248	Súng Ghim Inox Cmart	sung ghim inox cmart	cái	125000	0	\N	2025-07-18 16:43:49.22776	2025-07-18 16:43:49.22776
2249	Súng Keo Bọt	sung keo bot	cái	145000	0	\N	2025-07-18 16:43:49.22976	2025-07-18 16:43:49.22976
2250	Súng Keo Nến Loại Nhỏ	sung keo nen loai nho	cái	0	0	\N	2025-07-18 16:43:49.23276	2025-07-18 16:43:49.23276
2251	Súng Keo Nến Loại To	sung keo nen loai to	cái	125000	0	\N	2025-07-18 16:43:49.235793	2025-07-18 16:43:49.235793
2252	Súng Keo Ram Sét	sung keo ram set	cái	560000	0	\N	2025-07-18 16:43:49.238791	2025-07-18 16:43:49.238791
2253	Súng Khí Nhựa	sung khi nhua	cái	35000	0	\N	2025-07-18 16:43:49.241793	2025-07-18 16:43:49.241793
2254	Súng Phun Sơn Đỏ	sung phun son do	bộ	130000	0	\N	2025-07-18 16:43:49.243808	2025-07-18 16:43:49.243808
2255	Súng Phun Tiger	sung phun tiger	bộ	180000	0	\N	2025-07-18 16:43:49.245771	2025-07-18 16:43:49.245771
2256	Súng Rửa Xe	sung rua xe	cái	200000	0	\N	2025-07-18 16:43:49.2483	2025-07-18 16:43:49.2483
2257	Súng Rút Hơi	sung rut hoi	cái	950000	0	\N	2025-07-18 16:43:49.250332	2025-07-18 16:43:49.250332
2258	Súng Silicon Nhựa	sung silicon nhua	cái	65000	0	\N	2025-07-18 16:43:49.251333	2025-07-18 16:43:49.251333
2259	Sưởi 4 Bóng	suoi 4 bong	cái	1550000	0	\N	2025-07-18 16:43:49.253332	2025-07-18 16:43:49.253332
2260	Sưởi Âm Trần 4 Bóng Kotman He4Br	suoi am tran 4 bong kotman he4br	cái	1650000	0	\N	2025-07-18 16:43:49.255346	2025-07-18 16:43:49.255346
2261	Sưởi Gốm Bàn	suoi gom ban	cái	450000	0	\N	2025-07-18 16:43:49.258331	2025-07-18 16:43:49.258331
2262	T5 0,6 Mét Tàu	t5 0,6 met tau	cái	50000	0	\N	2025-07-18 16:43:49.26131	2025-07-18 16:43:49.26131
2263	Tải Cẩu	tai cau	cái	90000	0	\N	2025-07-18 16:43:49.263346	2025-07-18 16:43:49.263346
2264	Tải Cò	tai co	cái	2000	0	\N	2025-07-18 16:43:49.266346	2025-07-18 16:43:49.266346
2265	Tải Đen	tai den	cái	6000	0	\N	2025-07-18 16:43:49.26931	2025-07-18 16:43:49.26931
2266	Tải Đen 1,5 Tạ	tai den 1,5 ta	cái	7000	0	\N	2025-07-18 16:43:49.273322	2025-07-18 16:43:49.273322
2267	Tai Khóa Sắt	tai khoa sat	cái	2000	0	\N	2025-07-18 16:43:49.276379	2025-07-18 16:43:49.276379
2268	Tai Lật Inox	tai lat inox	cái	8000	0	\N	2025-07-18 16:43:49.279002	2025-07-18 16:43:49.279002
2269	Tai Sắt Hàn	tai sat han	cái	2000	0	\N	2025-07-18 16:43:49.281051	2025-07-18 16:43:49.281051
2270	Tải Xanh 50 Kg	tai xanh 50 kg	cái	4000	0	\N	2025-07-18 16:43:49.283066	2025-07-18 16:43:49.283066
2271	Tấm Sắt 1Mx1M	tam sat 1mx1m	tấm	50000	0	\N	2025-07-18 16:43:49.285065	2025-07-18 16:43:49.285065
2272	Tăng 14	tang 14	cái	26000	0	\N	2025-07-18 16:43:49.288065	2025-07-18 16:43:49.288065
2273	Tăng 20 ( M20)	tang 20 ( m20)	cái	30000	0	\N	2025-07-18 16:43:49.290662	2025-07-18 16:43:49.290662
2274	Tăng Đơ 10	tang do 10	cái	10000	0	\N	2025-07-18 16:43:49.293624	2025-07-18 16:43:49.293624
2275	Tăng Đơ 6	tang do 6	cái	7000	0	\N	2025-07-18 16:43:49.295646	2025-07-18 16:43:49.295646
2276	Tăng Đơ 8	tang do 8	cái	10000	0	\N	2025-07-18 16:43:49.296648	2025-07-18 16:43:49.296648
2277	Taro 3	taro 3	cái	35000	0	\N	2025-07-18 16:43:49.299226	2025-07-18 16:43:49.299226
2278	Taro 4 Hss	taro 4 hss	cái	40000	0	\N	2025-07-18 16:43:49.303226	2025-07-18 16:43:49.303226
2279	Taro 6 Hss	taro 6 hss	cái	45000	0	\N	2025-07-18 16:43:49.306226	2025-07-18 16:43:49.306226
2280	Tay Cắt Hơi 301	tay cat hoi 301	cái	310000	0	\N	2025-07-18 16:43:49.30921	2025-07-18 16:43:49.30921
2281	Tay Co Inox Bé	tay co inox be	cái	8000	0	\N	2025-07-18 16:43:49.310212	2025-07-18 16:43:49.310212
2282	Tay Co Inox To	tay co inox to	cái	15000	0	\N	2025-07-18 16:43:49.313226	2025-07-18 16:43:49.313226
2283	Tẩy Đa Năng Su Mô	tay da nang su mo	lọ	60000	0	\N	2025-07-18 16:43:49.315212	2025-07-18 16:43:49.315212
2284	Tay Đẩy Tủ Bếp	tay day tu bep	cái	65000	0	\N	2025-07-18 16:43:49.317226	2025-07-18 16:43:49.317226
2285	Tẩy Gạch Bé	tay gach be	cái	50000	0	\N	2025-07-18 16:43:49.319212	2025-07-18 16:43:49.319212
2286	Tay Khẩu L Vặn	tay khau l van	cái	50000	0	\N	2025-07-18 16:43:49.320212	2025-07-18 16:43:49.320212
2287	Tay Sen	tay sen	cái	55000	0	\N	2025-07-18 16:43:49.323212	2025-07-18 16:43:49.323212
2288	Tẩy Thái Okai	tay thai okai	lọ	30000	0	\N	2025-07-18 16:43:49.326226	2025-07-18 16:43:49.326226
2289	Tẩy Xi Măng To 2 Lít	tay xi mang to 2 lit	can	90000	0	\N	2025-07-18 16:43:49.328212	2025-07-18 16:43:49.328212
2290	Tê 125/90 ( Lấy Tê 125+ Bạc 125/90)	te 125/90 ( lay te 125+ bac 125/90)	cái	170000	0	\N	2025-07-18 16:43:49.329212	2025-07-18 16:43:49.329212
2291	Tê 5 0,6 Trắng Tàu	te 5 0,6 trang tau	cáu	45000	0	\N	2025-07-18 16:43:49.331212	2025-07-18 16:43:49.331212
2292	Tê 5X0,6 Tàu	te 5x0,6 tau	cái	45000	0	\N	2025-07-18 16:43:49.333226	2025-07-18 16:43:49.333226
2293	Tê Cầu 15	te cau 15	cái	25000	0	\N	2025-07-18 16:43:49.337257	2025-07-18 16:43:49.337257
2294	Tê Giảm Áp	te giam ap	cái	65000	0	\N	2025-07-18 16:43:49.339273	2025-07-18 16:43:49.339273
2295	Tê Hơi 10	te hoi 10	cái	7000	0	\N	2025-07-18 16:43:49.342274	2025-07-18 16:43:49.342274
2296	Tê Hơi 12	te hoi 12	cái	8000	0	\N	2025-07-18 16:43:49.344273	2025-07-18 16:43:49.344273
2297	Tê Khóa 15	te khoa 15	cái	65000	0	\N	2025-07-18 16:43:49.34726	2025-07-18 16:43:49.34726
2298	Tê Khóa 2 Đầu	te khoa 2 dau	cái	65000	0	\N	2025-07-18 16:43:49.349439	2025-07-18 16:43:49.349439
2299	Tê Khóa 3 Đầu	te khoa 3 dau	cái	60000	0	\N	2025-07-18 16:43:49.35144	2025-07-18 16:43:49.35144
2300	Tê Máy Lọc Nước	te may loc nuoc	cái	40000	0	\N	2025-07-18 16:43:49.353454	2025-07-18 16:43:49.353454
2301	Tê Nhanh 8	te nhanh 8	cái	6000	0	\N	2025-07-18 16:43:49.356794	2025-07-18 16:43:49.356794
2302	Tê Nối Nhanh 10	te noi nhanh 10	cái	7000	0	\N	2025-07-18 16:43:49.359927	2025-07-18 16:43:49.359927
2303	Tê Nối Nhanh 6	te noi nhanh 6	cái	6000	0	\N	2025-07-18 16:43:49.361949	2025-07-18 16:43:49.361949
2304	Tê Ren Đồng 27 Phú Thịnh	te ren dong 27 phu thinh	cái	12000	0	\N	2025-07-18 16:43:49.363959	2025-07-18 16:43:49.363959
2305	Tê Ren Ngoài 15	te ren ngoai 15	cái	15000	0	\N	2025-07-18 16:43:49.366996	2025-07-18 16:43:49.366996
2306	Tê Ren Trong 15 Inox	te ren trong 15 inox	cái	15000	0	\N	2025-07-18 16:43:49.369971	2025-07-18 16:43:49.369971
2307	Tê Rn Inox 15	te rn inox 15	cái	15000	0	\N	2025-07-18 16:43:49.372996	2025-07-18 16:43:49.372996
2308	Tê Rt Inox 15	te rt inox 15	cái	15000	0	\N	2025-07-18 16:43:49.375027	2025-07-18 16:43:49.375027
2309	Tê Vặn 10	te van 10	cái	20000	0	\N	2025-07-18 16:43:49.378027	2025-07-18 16:43:49.378027
2310	Tê Vặn 13	te van 13	cái	20000	0	\N	2025-07-18 16:43:49.380027	2025-07-18 16:43:49.380027
2311	Th Bon	th bon	lọ	50000	0	\N	2025-07-18 16:43:49.383082	2025-07-18 16:43:49.383082
2312	Than Chấu	than chau	bao	90000	0	\N	2025-07-18 16:43:49.38606	2025-07-18 16:43:49.38606
2313	Than Hoạt Tính	than hoat tinh	bao	230000	0	\N	2025-07-18 16:43:49.38808	2025-07-18 16:43:49.38808
2314	Thang 5 Bậc Inox	thang 5 bac inox	cái	550000	0	\N	2025-07-18 16:43:49.392674	2025-07-18 16:43:49.392674
2315	Thang 7 Bâc	thang 7 bac	cái	800000	0	\N	2025-07-18 16:43:49.39466	2025-07-18 16:43:49.39466
2316	Thang Inoc 6 Bậc Ninda	thang inoc 6 bac ninda	cái	650000	0	\N	2025-07-18 16:43:49.39666	2025-07-18 16:43:49.39666
2317	Thang Inox 1.5 Mét	thang inox 1.5 met	cái	420000	0	\N	2025-07-18 16:43:49.39866	2025-07-18 16:43:49.39866
2318	Thang Inox 2.5 Mét	thang inox 2.5 met	cái	700000	0	\N	2025-07-18 16:43:49.400216	2025-07-18 16:43:49.400216
2319	Thang Inox 2Met	thang inox 2met	cái	560000	0	\N	2025-07-18 16:43:49.403216	2025-07-18 16:43:49.403216
2320	Thang Inox 3 Bậc	thang inox 3 bac	cái	450000	0	\N	2025-07-18 16:43:49.405202	2025-07-18 16:43:49.405202
2321	Thang Inox 4 Bậc	thang inox 4 bac	cái	480000	0	\N	2025-07-18 16:43:49.407202	2025-07-18 16:43:49.407202
2322	Thang Nhôm 2 Met Xanh	thang nhom 2 met xanh	cái	700000	0	\N	2025-07-18 16:43:49.409217	2025-07-18 16:43:49.409217
2323	Thang Nhôm 2.5M	thang nhom 2.5m	cái	350000	0	\N	2025-07-18 16:43:49.411216	2025-07-18 16:43:49.411216
2324	Thang Rút Xanh 3.8 Mét	thang rut xanh 3.8 met	cái	1600000	0	\N	2025-07-18 16:43:49.414217	2025-07-18 16:43:49.414217
2325	Thang Tre Mét	thang tre met	m	45000	0	\N	2025-07-18 16:43:49.417202	2025-07-18 16:43:49.417202
2326	Thanh Cài Át	thanh cai at	m	30000	0	\N	2025-07-18 16:43:49.419216	2025-07-18 16:43:49.419216
2327	Thanh Cài Át 1Met	thanh cai at 1met	thanh	20000	0	\N	2025-07-18 16:43:49.421202	2025-07-18 16:43:49.421202
2328	Then Inox 16	then inox 16	cái	50000	0	\N	2025-07-18 16:43:49.423216	2025-07-18 16:43:49.423216
2329	Thép 0.5 Ly	thep 0.5 ly	kg	45000	0	\N	2025-07-18 16:43:49.426227	2025-07-18 16:43:49.426227
2330	Thép 1 Ly Mạ	thep 1 ly ma	kg	28000	0	\N	2025-07-18 16:43:49.428202	2025-07-18 16:43:49.428202
2331	Thép 2 Ly	thep 2 ly	kg	25000	0	\N	2025-07-18 16:43:49.430202	2025-07-18 16:43:49.430202
2332	Thép 3 Ly Mạ	thep 3 ly ma	kg	25000	0	\N	2025-07-18 16:43:49.432202	2025-07-18 16:43:49.432202
2333	Thép Bọc Nhựa	thep boc nhua	kg	35000	0	\N	2025-07-18 16:43:49.434263	2025-07-18 16:43:49.434263
2334	Thép Đen (Thép Buộc)	thep den (thep buoc)	kg	25000	0	\N	2025-07-18 16:43:49.437249	2025-07-18 16:43:49.437249
2335	Thép Inox	thep inox	kg	80000	0	\N	2025-07-18 16:43:49.439248	2025-07-18 16:43:49.439248
2336	Thép Mạ 1.5 Ly	thep ma 1.5 ly	kg	25000	0	\N	2025-07-18 16:43:49.44225	2025-07-18 16:43:49.44225
2337	Thép Mạ 2 Ly	thep ma 2 ly	kg	25000	0	\N	2025-07-18 16:43:49.444264	2025-07-18 16:43:49.444264
2338	Thép Mạ Kẽm	thep ma kem	kg	25000	0	\N	2025-07-18 16:43:49.446269	2025-07-18 16:43:49.446269
2339	Thiếc	thiec	cuộn	15000	0	\N	2025-07-18 16:43:49.448781	2025-07-18 16:43:49.448781
2340	Thoát Sàn 2 Lóp Vinahasa	thoat san 2 lop vinahasa	cái	50000	0	\N	2025-07-18 16:43:49.450813	2025-07-18 16:43:49.450813
2341	Thoát Sàn 60 Kasa	thoat san 60 kasa	cái	25000	0	\N	2025-07-18 16:43:49.451816	2025-07-18 16:43:49.451816
2342	Thoát Sàn 75 Toda	thoat san 75 toda	cái	110000	0	\N	2025-07-18 16:43:49.454829	2025-07-18 16:43:49.454829
2343	Thoát Sàn 90 Đm Inox	thoat san 90 dm inox	cái	90000	0	\N	2025-07-18 16:43:49.456829	2025-07-18 16:43:49.456829
2344	Thoát Sàn 90 Toda	thoat san 90 toda	cái	110000	0	\N	2025-07-18 16:43:49.459814	2025-07-18 16:43:49.459814
2345	Thoát Sàn Dm	thoat san dm	cái	85000	0	\N	2025-07-18 16:43:49.461815	2025-07-18 16:43:49.461815
2346	Thoát Sàn Đm Inox	thoat san dm inox	cái	85000	0	\N	2025-07-18 16:43:49.463829	2025-07-18 16:43:49.463829
2347	Thoát Sàn Đồng	thoat san dong	cái	230000	0	\N	2025-07-18 16:43:49.467822	2025-07-18 16:43:49.467822
2348	Thoát Sàn Kasa Rẻ 90	thoat san kasa re 90	cái	30000	0	\N	2025-07-18 16:43:49.470829	2025-07-18 16:43:49.470829
2349	Thoát Sàn Linax 120	thoat san linax 120	cái	55000	0	\N	2025-07-18 16:43:49.472815	2025-07-18 16:43:49.472815
2350	Thoát Sàn Mấy Giặt	thoat san may giat	cái	110000	0	\N	2025-07-18 16:43:49.474829	2025-07-18 16:43:49.474829
2351	Thoát Sàn Ngăn Mùi Đồng	thoat san ngan mui dong	cái	35000	0	\N	2025-07-18 16:43:49.476875	2025-07-18 16:43:49.476875
2352	Thông Gió 15V4 Tico	thong gio 15v4 tico	cái	240000	0	\N	2025-07-18 16:43:49.479876	2025-07-18 16:43:49.479876
2353	Thông Gió 15V6 Tico	thong gio 15v6 tico	cái	240000	0	\N	2025-07-18 16:43:49.481862	2025-07-18 16:43:49.481862
2354	Thông Gió 16Av6	thong gio 16av6	cái	195000	0	\N	2025-07-18 16:43:49.484406	2025-07-18 16:43:49.484406
2355	Thông Gió 20V4 Tico	thong gio 20v4 tico	cái	250000	0	\N	2025-07-18 16:43:49.486568	2025-07-18 16:43:49.486568
2356	Thông Gió 20X20 Yj	thong gio 20x20 yj	cái	320000	0	\N	2025-07-18 16:43:49.487555	2025-07-18 16:43:49.487555
2357	Thông Gió 25V6 Tico	thong gio 25v6 tico	cái	260000	0	\N	2025-07-18 16:43:49.490085	2025-07-18 16:43:49.490085
2358	Thông Gió Nanoco 14X14	thong gio nanoco 14x14	cái	185000	0	\N	2025-07-18 16:43:49.492133	2025-07-18 16:43:49.492133
2359	Thông Gió Phi 500 Nanoco	thong gio phi 500 nanoco	cái	1450000	0	\N	2025-07-18 16:43:49.494119	2025-07-18 16:43:49.494119
2360	Thông Gió Tico 25V4	thong gio tico 25v4	cái	250000	0	\N	2025-07-18 16:43:49.496132	2025-07-18 16:43:49.496132
2361	Thông Tắc Chai Nhỏ	thong tac chai nho	hộp	30000	0	\N	2025-07-18 16:43:49.499132	2025-07-18 16:43:49.499132
2362	Thuế Vat 10%	thue vat 10%	cái	0	0	\N	2025-07-18 16:43:49.501699	2025-07-18 16:43:49.501699
2363	Thúng Cật	thung cat	cái	35000	0	\N	2025-07-18 16:43:49.504675	2025-07-18 16:43:49.504675
2364	Thùng Sơn	thung son	cái	20000	0	\N	2025-07-18 16:43:49.506675	2025-07-18 16:43:49.506675
2365	Thước 3 Mét	thuoc 3 met	cái	30000	0	\N	2025-07-18 16:43:49.508689	2025-07-18 16:43:49.508689
2366	Thước 5 M Kapusi Đen	thuoc 5 m kapusi den	cái	45000	0	\N	2025-07-18 16:43:49.510689	2025-07-18 16:43:49.510689
2367	Thước 5 M Lan	thuoc 5 m lan	cái	20000	0	\N	2025-07-18 16:43:49.514673	2025-07-18 16:43:49.514673
2368	Thước 5 M Tiger	thuoc 5 m tiger	cái	25000	0	\N	2025-07-18 16:43:49.516689	2025-07-18 16:43:49.516689
2369	Thước 5 Mét Kapusi	thuoc 5 met kapusi	cái	45000	0	\N	2025-07-18 16:43:49.51969	2025-07-18 16:43:49.51969
2370	Thước 5M Bfv	thuoc 5m bfv	cái	35000	0	\N	2025-07-18 16:43:49.521689	2025-07-18 16:43:49.521689
2371	Thước 7.5 Mét	thuoc 7.5 met	cái	45000	0	\N	2025-07-18 16:43:49.52469	2025-07-18 16:43:49.52469
2372	Thước Cuộn 50M	thuoc cuon 50m	cái	95000	0	\N	2025-07-18 16:43:49.526675	2025-07-18 16:43:49.526675
2373	Thước Đàn 2 Mét	thuoc dan 2 met	cái	200000	0	\N	2025-07-18 16:43:49.528673	2025-07-18 16:43:49.528673
2374	Thước Dây 30 Mét	thuoc day 30 met	cái	95000	0	\N	2025-07-18 16:43:49.529675	2025-07-18 16:43:49.529675
2375	Thước Ke Inox 50Cm	thuoc ke inox 50cm	cái	75000	0	\N	2025-07-18 16:43:49.531675	2025-07-18 16:43:49.531675
2376	Thước Kẹp 20 Cm	thuoc kep 20 cm	cái	115000	0	\N	2025-07-18 16:43:49.533689	2025-07-18 16:43:49.533689
2377	Thước Lá 0.5 Mét Thường	thuoc la 0.5 met thuong	cái	25000	0	\N	2025-07-18 16:43:49.5377	2025-07-18 16:43:49.5377
2378	Thước Nẹp 1.2	thuoc nep 1.2	cái	17000	0	\N	2025-07-18 16:43:49.540227	2025-07-18 16:43:49.540227
2379	Thước Nhôm 1.5M	thuoc nhom 1.5m	cái	15000	0	\N	2025-07-18 16:43:49.542226	2025-07-18 16:43:49.542226
2380	Thước Nhôm 2 M	thuoc nhom 2 m	cái	45000	0	\N	2025-07-18 16:43:49.544225	2025-07-18 16:43:49.544225
2381	Thước Nhôm 2.5M	thuoc nhom 2.5m	cái	57000	0	\N	2025-07-18 16:43:49.546227	2025-07-18 16:43:49.546227
2382	Thước Nhôm 3M	thuoc nhom 3m	cái	69000	0	\N	2025-07-18 16:43:49.548226	2025-07-18 16:43:49.548226
2383	Thước Nhôm Nẹp 2 Mét	thuoc nhom nep 2 met	cái	30000	0	\N	2025-07-18 16:43:49.550551	2025-07-18 16:43:49.550551
2384	Thước Vải 30 Mét	thuoc vai 30 met	cái	80000	0	\N	2025-07-18 16:43:49.551551	2025-07-18 16:43:49.551551
2385	Thước Vải Tiger 20 M	thuoc vai tiger 20 m	cái	65000	0	\N	2025-07-18 16:43:49.554554	2025-07-18 16:43:49.554554
2386	Thuổng Sắt	thuong sat	cái	150000	0	\N	2025-07-18 16:43:49.556049	2025-07-18 16:43:49.556049
2387	Ti Bon Rẻ	ti bon re	lọ	50000	0	\N	2025-07-18 16:43:49.558053	2025-07-18 16:43:49.558053
2388	Ti Bon Tốt	ti bon tot	lọ	80000	0	\N	2025-07-18 16:43:49.562094	2025-07-18 16:43:49.562094
2389	Ti Ô 10	ti o 10	m	3500	0	\N	2025-07-18 16:43:49.564102	2025-07-18 16:43:49.564102
2390	Ti Ô 14	ti o 14	cuộn	220000	0	\N	2025-07-18 16:43:49.566093	2025-07-18 16:43:49.566093
2391	Tibon Xịn	tibon xin	lọ	82000	0	\N	2025-07-18 16:43:49.569093	2025-07-18 16:43:49.569093
2392	Tico Thông Gió 12V6	tico thong gio 12v6	cái	200000	0	\N	2025-07-18 16:43:49.572088	2025-07-18 16:43:49.572088
2393	Tiêu Lệnh	tieu lenh	bộ	65000	0	\N	2025-07-18 16:43:49.574091	2025-07-18 16:43:49.574091
2394	Tô Sọc 2 Cạnh To	to soc 2 canh to	cái	30000	0	\N	2025-07-18 16:43:49.575091	2025-07-18 16:43:49.575091
2395	Tô Vít	to vit	cái	0	0	\N	2025-07-18 16:43:49.577704	2025-07-18 16:43:49.577704
2396	Tô Vít Đóng	to vit dong	cái	0	0	\N	2025-07-18 16:43:49.581468	2025-07-18 16:43:49.581468
2397	Tô Vít Mỹ	to vit my	cái	15000	0	\N	2025-07-18 16:43:49.5835	2025-07-18 16:43:49.5835
2398	Tô Vít Sọc Vàng 1 Đầu +	to vit soc vang 1 dau +	cái	30000	0	\N	2025-07-18 16:43:49.586477	2025-07-18 16:43:49.586477
2399	Tô Vít Sọc Xanh Xịn	to vit soc xanh xin	cái	35000	0	\N	2025-07-18 16:43:49.588493	2025-07-18 16:43:49.588493
2400	Tôn Gỗ 5	ton go 5	gói	65000	0	\N	2025-07-18 16:43:49.592058	2025-07-18 16:43:49.592058
2401	Tôn Gỗ 7	ton go 7	gói	55000	0	\N	2025-07-18 16:43:49.594058	2025-07-18 16:43:49.594058
2402	Tp Ppr Chếch 20	tp ppr chech 20	cái	4909	0	\N	2025-07-18 16:43:49.596072	2025-07-18 16:43:49.596072
2403	Tp Ppr Chếch 25	tp ppr chech 25	cái	7953	0	\N	2025-07-18 16:43:49.598071	2025-07-18 16:43:49.598071
2404	Tp Ppr Chếch 32	tp ppr chech 32	cái	11978	0	\N	2025-07-18 16:43:49.600627	2025-07-18 16:43:49.600627
2405	Tp Ppr Chếch 40	tp ppr chech 40	cái	23662	0	\N	2025-07-18 16:43:49.604596	2025-07-18 16:43:49.604596
2406	Tp Ppr Chếch 50	tp ppr chech 50	cái	45262	0	\N	2025-07-18 16:43:49.60759	2025-07-18 16:43:49.60759
2407	Tp Ppr Chếch 63	tp ppr chech 63	cái	103582	0	\N	2025-07-18 16:43:49.609629	2025-07-18 16:43:49.609629
2408	Tp Ppr Côn Thu 25/20	tp ppr con thu 25/20	cái	4909	0	\N	2025-07-18 16:43:49.611614	2025-07-18 16:43:49.611614
2409	Tp Ppr Côn Thu 32/20	tp ppr con thu 32/20	cái	6971	0	\N	2025-07-18 16:43:49.614646	2025-07-18 16:43:49.614646
2410	Tp Ppr Côn Thu 32/25	tp ppr con thu 32/25	cái	6971	0	\N	2025-07-18 16:43:49.618628	2025-07-18 16:43:49.618628
2411	Tp Ppr Côn Thu 40/20	tp ppr con thu 40/20	cái	10800	0	\N	2025-07-18 16:43:49.620614	2025-07-18 16:43:49.620614
2412	Tp Ppr Côn Thu 40/25	tp ppr con thu 40/25	cái	10800	0	\N	2025-07-18 16:43:49.622628	2025-07-18 16:43:49.622628
2413	Tp Ppr Côn Thu 40/32	tp ppr con thu 40/32	cái	10800	0	\N	2025-07-18 16:43:49.625628	2025-07-18 16:43:49.625628
2414	Tp Ppr Côn Thu 50/20	tp ppr con thu 50/20	cái	19440	0	\N	2025-07-18 16:43:49.627628	2025-07-18 16:43:49.627628
2415	Tp Ppr Côn Thu 50/25	tp ppr con thu 50/25	cái	19440	0	\N	2025-07-18 16:43:49.629628	2025-07-18 16:43:49.629628
2416	Tp Ppr Côn Thu 50/32	tp ppr con thu 50/32	cái	19440	0	\N	2025-07-18 16:43:49.632629	2025-07-18 16:43:49.632629
2417	Tp Ppr Côn Thu 50/40	tp ppr con thu 50/40	cái	19440	0	\N	2025-07-18 16:43:49.634628	2025-07-18 16:43:49.634628
2418	Tp Ppr Côn Thu 63/50	tp ppr con thu 63/50	cái	37603	0	\N	2025-07-18 16:43:49.637658	2025-07-18 16:43:49.637658
2419	Tp Ppr Cút 20	tp ppr cut 20	cái	5989	0	\N	2025-07-18 16:43:49.639675	2025-07-18 16:43:49.639675
2420	Tp Ppr Cút 25	tp ppr cut 25	cái	7953	0	\N	2025-07-18 16:43:49.641674	2025-07-18 16:43:49.641674
2421	Tp Ppr Cút 32	tp ppr cut 32	cái	13942	0	\N	2025-07-18 16:43:49.644676	2025-07-18 16:43:49.644676
2422	Tp Ppr Cút 40	tp ppr cut 40	cái	22582	0	\N	2025-07-18 16:43:49.646644	2025-07-18 16:43:49.646644
2423	Tp Ppr Cút 50	tp ppr cut 50	cái	39665	0	\N	2025-07-18 16:43:49.649642	2025-07-18 16:43:49.649642
2424	Tp Ppr Cút 63	tp ppr cut 63	cái	121353	0	\N	2025-07-18 16:43:49.653781	2025-07-18 16:43:49.653781
2425	Tp Ppr Cút Rn 20X1/2"	tp ppr cut rn 20x1/2"	cái	61069	0	\N	2025-07-18 16:43:49.655782	2025-07-18 16:43:49.655782
2426	Tp Ppr Cút Rn 25X1/2"	tp ppr cut rn 25x1/2"	cái	69022	0	\N	2025-07-18 16:43:49.660766	2025-07-18 16:43:49.660766
2427	Tp Ppr Cút Rn 25X3/4"	tp ppr cut rn 25x3/4"	cái	81589	0	\N	2025-07-18 16:43:49.662768	2025-07-18 16:43:49.662768
2428	Tp Ppr Cút Rt 20X1/2"	tp ppr cut rt 20x1/2"	cái	43397	0	\N	2025-07-18 16:43:49.664782	2025-07-18 16:43:49.664782
2429	Tp Ppr Cút Rt 25X1/2"	tp ppr cut rt 25x1/2"	cái	49287	0	\N	2025-07-18 16:43:49.666781	2025-07-18 16:43:49.666781
2430	Tp Ppr Cút Rt 25X3/4"	tp ppr cut rt 25x3/4"	cái	67600	0	\N	2025-07-18 16:43:49.669757	2025-07-18 16:43:49.669757
2431	Tp Ppr Măng Sông 20 (Nối Thẳng)	tp ppr mang song 20 (noi thang)	cái	3142	0	\N	2025-07-18 16:43:49.672768	2025-07-18 16:43:49.672768
2432	Tp Ppr Măng Sông 25 (Nối Thẳng)	tp ppr mang song 25 (noi thang)	cái	5302	0	\N	2025-07-18 16:43:49.674784	2025-07-18 16:43:49.674784
2433	Tp Ppr Măng Sông 32 (Nối Thẳng)	tp ppr mang song 32 (noi thang)	cái	8247	0	\N	2025-07-18 16:43:49.676829	2025-07-18 16:43:49.676829
2434	Tp Ppr Măng Sông 40 (Nối Thẳng)	tp ppr mang song 40 (noi thang)	cái	13157	0	\N	2025-07-18 16:43:49.678829	2025-07-18 16:43:49.678829
2435	Tp Ppr Măng Sông 50 (Nối Thẳng)	tp ppr mang song 50 (noi thang)	cái	23563	0	\N	2025-07-18 16:43:49.681811	2025-07-18 16:43:49.681811
2436	Tp Ppr Măng Sông 63	tp ppr mang song 63	cái	47225	0	\N	2025-07-18 16:43:49.683829	2025-07-18 16:43:49.683829
2437	Tp Ppr Msrn 20X1/2"	tp ppr msrn 20x1/2"	cái	49287	0	\N	2025-07-18 16:43:49.685829	2025-07-18 16:43:49.685829
2438	Tp Ppr Msrn 25X1/2"	tp ppr msrn 25x1/2"	cái	56945	0	\N	2025-07-18 16:43:49.687859	2025-07-18 16:43:49.687859
2439	Tp Ppr Msrn 25X3/4"	tp ppr msrn 25x3/4"	cái	68727	0	\N	2025-07-18 16:43:49.691483	2025-07-18 16:43:49.691483
2440	Tp Ppr Msrn 32X1"	tp ppr msrn 32x1"	cái	101618	0	\N	2025-07-18 16:43:49.693468	2025-07-18 16:43:49.693468
2441	Tp Ppr Msrn 40X11/4"	tp ppr msrn 40x11/4"	cái	295527	0	\N	2025-07-18 16:43:49.696468	2025-07-18 16:43:49.696468
2442	Tp Ppr Msrn 50X11/2"	tp ppr msrn 50x11/2"	cái	369360	0	\N	2025-07-18 16:43:49.698482	2025-07-18 16:43:49.698482
2443	Tp Ppr Msrn 63	tp ppr msrn 63	cái	626000	0	\N	2025-07-18 16:43:49.700027	2025-07-18 16:43:49.700027
2444	Tp Ppr Msrt 20X1/2"	tp ppr msrt 20x1/2"	cái	38978	0	\N	2025-07-18 16:43:49.704041	2025-07-18 16:43:49.704041
2445	Tp Ppr Msrt 25X1/2"	tp ppr msrt 25x1/2"	cái	47717	0	\N	2025-07-18 16:43:49.707039	2025-07-18 16:43:49.707039
2446	Tp Ppr Msrt 25X3/4"	tp ppr msrt 25x3/4"	cái	53125	0	\N	2025-07-18 16:43:49.710062	2025-07-18 16:43:49.710062
2447	Tp Ppr Msrt 32X1"	tp ppr msrt 32x1"	cái	86793	0	\N	2025-07-18 16:43:49.712064	2025-07-18 16:43:49.712064
2448	Tp Ppr Msrt 40X11/4"	tp ppr msrt 40x11/4"	cái	215018	0	\N	2025-07-18 16:43:49.715519	2025-07-18 16:43:49.715519
2449	Tp Ppr Msrt 50X11/2"	tp ppr msrt 50x11/2"	cái	285218	0	\N	2025-07-18 16:43:49.719529	2025-07-18 16:43:49.719529
2450	Tp Ppr Nút Bịt 20	tp ppr nut bit 20	cái	3000	0	\N	2025-07-18 16:43:49.721528	2025-07-18 16:43:49.721528
2451	Tp Ppr Nút Bịt 25	tp ppr nut bit 25	cái	5200	0	\N	2025-07-18 16:43:49.723542	2025-07-18 16:43:49.723542
2452	Tp Ppr Nút Bịt 32	tp ppr nut bit 32	cái	6800	0	\N	2025-07-18 16:43:49.727543	2025-07-18 16:43:49.727543
2453	Tp Ppr Nút Bịt 40	tp ppr nut bit 40	cái	10300	0	\N	2025-07-18 16:43:49.730542	2025-07-18 16:43:49.730542
2454	Tp Ppr Nút Bịt 50	tp ppr nut bit 50	cái	19400	0	\N	2025-07-18 16:43:49.733543	2025-07-18 16:43:49.733543
2455	Tp Ppr Ống Chánh 20	tp ppr ong chanh 20	cái	15700	0	\N	2025-07-18 16:43:49.73759	2025-07-18 16:43:49.73759
2456	Tp Ppr Ống Chánh 25	tp ppr ong chanh 25	cái	29300	0	\N	2025-07-18 16:43:49.739576	2025-07-18 16:43:49.739576
2457	Tp Ppr Ống Lạnh 20	tp ppr ong lanh 20	m	23957	0	\N	2025-07-18 16:43:49.74159	2025-07-18 16:43:49.74159
2458	Tp Ppr Ống Lạnh 25	tp ppr ong lanh 25	m	42807	0	\N	2025-07-18 16:43:49.74359	2025-07-18 16:43:49.74359
2459	Tp Ppr Ống Lạnh 32	tp ppr ong lanh 32	m	55473	0	\N	2025-07-18 16:43:49.74659	2025-07-18 16:43:49.74659
2460	Tp Ppr Ống Lạnh 40	tp ppr ong lanh 40	m	74422	0	\N	2025-07-18 16:43:49.748594	2025-07-18 16:43:49.748594
2461	Tp Ppr Ống Lạnh 50	tp ppr ong lanh 50	m	109080	0	\N	2025-07-18 16:43:49.751107	2025-07-18 16:43:49.751107
2462	Tp Ppr Ống Lạnh 63	tp ppr ong lanh 63	m	173389	0	\N	2025-07-18 16:43:49.753277	2025-07-18 16:43:49.753277
2463	Tp Ppr Ống Nóng 20	tp ppr ong nong 20	m	29651	0	\N	2025-07-18 16:43:49.756276	2025-07-18 16:43:49.756276
2464	Tp Ppr Ống Nóng 25	tp ppr ong nong 25	m	52037	0	\N	2025-07-18 16:43:49.758275	2025-07-18 16:43:49.758275
2465	Tp Ppr Ống Nóng 32	tp ppr ong nong 32	m	76582	0	\N	2025-07-18 16:43:49.761897	2025-07-18 16:43:49.761897
2466	Tp Ppr Ống Nóng 40	tp ppr ong nong 40	m	118505	0	\N	2025-07-18 16:43:49.764911	2025-07-18 16:43:49.764911
2467	Tp Ppr Ống Nóng 50	tp ppr ong nong 50	m	184189	0	\N	2025-07-18 16:43:49.766897	2025-07-18 16:43:49.766897
2468	Tp Ppr Rắc Co 20	tp ppr rac co 20	cái	38978	0	\N	2025-07-18 16:43:49.769897	2025-07-18 16:43:49.769897
2469	Tp Ppr Rắc Co 25	tp ppr rac co 25	cái	57437	0	\N	2025-07-18 16:43:49.772895	2025-07-18 16:43:49.772895
2470	Tp Ppr Rắc Co 32	tp ppr rac co 32	cái	82669	0	\N	2025-07-18 16:43:49.774911	2025-07-18 16:43:49.774911
2471	Tp Ppr Rắc Co 40	tp ppr rac co 40	cái	94942	0	\N	2025-07-18 16:43:49.777959	2025-07-18 16:43:49.777959
2472	Tp Ppr Rắc Co 50	tp ppr rac co 50	cái	142658	0	\N	2025-07-18 16:43:49.780944	2025-07-18 16:43:49.780944
2473	Tp Ppr Rắc Co Rn 20X1/2"	tp ppr rac co rn 20x1/2"	cái	99065	0	\N	2025-07-18 16:43:49.783942	2025-07-18 16:43:49.783942
2474	Tp Ppr Rắc Co Rn 25X3/4"	tp ppr rac co rn 25x3/4"	cái	154440	0	\N	2025-07-18 16:43:49.785943	2025-07-18 16:43:49.785943
2475	Tp Ppr Rắc Co Rn 32X1"	tp ppr rac co rn 32x1"	cái	242705	0	\N	2025-07-18 16:43:49.787957	2025-07-18 16:43:49.787957
2476	Tp Ppr Rắc Co Rn 40X11/4"	tp ppr rac co rn 40x11/4"	cái	360131	0	\N	2025-07-18 16:43:49.790457	2025-07-18 16:43:49.790457
3018	Vít Mạ 4X3	vit ma 4x3	kg	40000	0	\N	2025-07-18 16:43:51.107912	2025-07-18 16:43:51.107912
2477	Tp Ppr Rắc Co Rn 50X11/2"	tp ppr rac co rn 50x11/2"	cái	635629	0	\N	2025-07-18 16:43:49.79448	2025-07-18 16:43:49.79448
2478	Tp Ppr Rắc Co Rn 63	tp ppr rac co rn 63	cái	859778	0	\N	2025-07-18 16:43:49.79748	2025-07-18 16:43:49.79748
2479	Tp Ppr Rắc Co Rt 20X1/2"	tp ppr rac co rt 20x1/2"	cái	92880	0	\N	2025-07-18 16:43:49.798519	2025-07-18 16:43:49.798519
2480	Tp Ppr Rắc Co Rt 25X3/4"	tp ppr rac co rt 25x3/4"	cái	148745	0	\N	2025-07-18 16:43:49.801057	2025-07-18 16:43:49.801057
2481	Tp Ppr Rắc Co Rt 32X1"	tp ppr rac co rt 32x1"	cái	218062	0	\N	2025-07-18 16:43:49.803697	2025-07-18 16:43:49.803697
2482	Tp Ppr Rắc Co Rt 40X11/4"	tp ppr rac co rt 40x11/4"	cái	341673	0	\N	2025-07-18 16:43:49.804713	2025-07-18 16:43:49.804713
2483	Tp Ppr Rắc Co Rt 50X11/2"	tp ppr rac co rt 50x11/2"	cái	595080	0	\N	2025-07-18 16:43:49.806853	2025-07-18 16:43:49.806853
2484	Tp Ppr Tê 20	tp ppr te 20	cái	6971	0	\N	2025-07-18 16:43:49.808855	2025-07-18 16:43:49.808855
2485	Tp Ppr Tê 25	tp ppr te 25	cái	10800	0	\N	2025-07-18 16:43:49.810868	2025-07-18 16:43:49.810868
2486	Tp Ppr Tê 32	tp ppr te 32	cái	17771	0	\N	2025-07-18 16:43:49.813871	2025-07-18 16:43:49.813871
2487	Tp Ppr Tê 40	tp ppr te 40	cái	27687	0	\N	2025-07-18 16:43:49.816854	2025-07-18 16:43:49.816854
2488	Tp Ppr Tê 50	tp ppr te 50	cái	54393	0	\N	2025-07-18 16:43:49.817854	2025-07-18 16:43:49.817854
2489	Tp Ppr Tê 63	tp ppr te 63	cái	136473	0	\N	2025-07-18 16:43:49.820869	2025-07-18 16:43:49.820869
2490	Tp Ppr Tê 63/40	tp ppr te 63/40	cái	129011	0	\N	2025-07-18 16:43:49.822868	2025-07-18 16:43:49.822868
2491	Tp Ppr Tê 63/50	tp ppr te 63/50	cái	129011	0	\N	2025-07-18 16:43:49.825868	2025-07-18 16:43:49.825868
2492	Tp Ppr Tê Rt 20X1/2"	tp ppr te rt 20x1/2"	cái	43789	0	\N	2025-07-18 16:43:49.827854	2025-07-18 16:43:49.827854
2493	Tp Ppr Tê Rt 25X1/2"	tp ppr te rt 25x1/2"	cái	46833	0	\N	2025-07-18 16:43:49.829868	2025-07-18 16:43:49.829868
2494	Tp Ppr Tê Rt 25X3/4"	tp ppr te rt 25x3/4"	cái	68237	0	\N	2025-07-18 16:43:49.832869	2025-07-18 16:43:49.832869
2495	Tp Ppr Tê Thu 25/20	tp ppr te thu 25/20	cái	10800	0	\N	2025-07-18 16:43:49.834868	2025-07-18 16:43:49.834868
2496	Tp Ppr Tê Thu 32/20	tp ppr te thu 32/20	cái	19047	0	\N	2025-07-18 16:43:49.8379	2025-07-18 16:43:49.8379
2497	Tp Ppr Tê Thu 32/25	tp ppr te thu 32/25	cái	19047	0	\N	2025-07-18 16:43:49.839886	2025-07-18 16:43:49.839886
2498	Tp Ppr Tê Thu 40/20	tp ppr te thu 40/20	cái	41825	0	\N	2025-07-18 16:43:49.8419	2025-07-18 16:43:49.8419
2499	Tp Ppr Tê Thu 40/25	tp ppr te thu 40/25	cái	41825	0	\N	2025-07-18 16:43:49.845884	2025-07-18 16:43:49.845884
2500	Tp Ppr Tê Thu 40/32	tp ppr te thu 40/32	cái	41825	0	\N	2025-07-18 16:43:49.8489	2025-07-18 16:43:49.8489
2501	Tp Ppr Tê Thu 50/20	tp ppr te thu 50/20	cái	73440	0	\N	2025-07-18 16:43:49.8499	2025-07-18 16:43:49.8499
2502	Tp Ppr Tê Thu 50/25	tp ppr te thu 50/25	cái	73440	0	\N	2025-07-18 16:43:49.85348	2025-07-18 16:43:49.85348
2503	Tp Ppr Tê Thu 50/32	tp ppr te thu 50/32	cái	73440	0	\N	2025-07-18 16:43:49.855479	2025-07-18 16:43:49.855479
2504	Tp Ppr Tê Thu 50/40	tp ppr te thu 50/40	cái	73440	0	\N	2025-07-18 16:43:49.85845	2025-07-18 16:43:49.85845
2505	Tp Ppr Van 63	tp ppr van 63	cái	1364629	0	\N	2025-07-18 16:43:49.860463	2025-07-18 16:43:49.860463
2506	Tp Ppr Van Mở 100% D20	tp ppr van mo 100% d20	cái	205200	0	\N	2025-07-18 16:43:49.862479	2025-07-18 16:43:49.862479
2507	Tp Ppr Van Mở 100% D25	tp ppr van mo 100% d25	cái	236029	0	\N	2025-07-18 16:43:49.86548	2025-07-18 16:43:49.86548
2508	Tp Ppr Van Mở 100% D32	tp ppr van mo 100% d32	cái	338629	0	\N	2025-07-18 16:43:49.867479	2025-07-18 16:43:49.867479
2509	Tp Ppr Van Mở 100% D40	tp ppr van mo 100% d40	cái	569945	0	\N	2025-07-18 16:43:49.870463	2025-07-18 16:43:49.870463
2510	Tp Ppr Van Mở 100% D50	tp ppr van mo 100% d50	cái	888840	0	\N	2025-07-18 16:43:49.872463	2025-07-18 16:43:49.872463
2511	Tp Pvc Bạc Cb 110/42	tp pvc bac cb 110/42	cái	26730	0	\N	2025-07-18 16:43:49.875698	2025-07-18 16:43:49.875698
2512	Tp Pvc Bạc Cb 110/48	tp pvc bac cb 110/48	cái	29810	0	\N	2025-07-18 16:43:49.879756	2025-07-18 16:43:49.879756
2513	Tp Pvc Bạc Cb 110/60	tp pvc bac cb 110/60	cái	31020	0	\N	2025-07-18 16:43:49.88274	2025-07-18 16:43:49.88274
2514	Tp Pvc Bạc Cb 110/75	tp pvc bac cb 110/75	cái	33110	0	\N	2025-07-18 16:43:49.88474	2025-07-18 16:43:49.88474
2515	Tp Pvc Bạc Cb 110/90	tp pvc bac cb 110/90	cái	34980	0	\N	2025-07-18 16:43:49.886756	2025-07-18 16:43:49.886756
2516	Tp Pvc Bạc Cb 75/34	tp pvc bac cb 75/34	cái	9790	0	\N	2025-07-18 16:43:49.888756	2025-07-18 16:43:49.888756
2517	Tp Pvc Bạc Cb 75/42	tp pvc bac cb 75/42	cái	9790	0	\N	2025-07-18 16:43:49.892295	2025-07-18 16:43:49.892295
2518	Tp Pvc Bạc Cb 75/48	tp pvc bac cb 75/48	cái	9790	0	\N	2025-07-18 16:43:49.895689	2025-07-18 16:43:49.895689
2519	Tp Pvc Bạc Cb 75/60	tp pvc bac cb 75/60	cái	9790	0	\N	2025-07-18 16:43:49.89769	2025-07-18 16:43:49.89769
2520	Tp Pvc Bạc Cb 90/34	tp pvc bac cb 90/34	cái	14960	0	\N	2025-07-18 16:43:49.899705	2025-07-18 16:43:49.899705
2521	Tp Pvc Bạc Cb 90/42	tp pvc bac cb 90/42	cái	14960	0	\N	2025-07-18 16:43:49.902224	2025-07-18 16:43:49.902224
2522	Tp Pvc Bạc Cb 90/48	tp pvc bac cb 90/48	cái	15840	0	\N	2025-07-18 16:43:49.905268	2025-07-18 16:43:49.905268
2523	Tp Pvc Bạc Cb 90/60	tp pvc bac cb 90/60	cái	17050	0	\N	2025-07-18 16:43:49.907589	2025-07-18 16:43:49.907589
2524	Tp Pvc Bạc Cb 90/75	tp pvc bac cb 90/75	cái	15180	0	\N	2025-07-18 16:43:49.909657	2025-07-18 16:43:49.909657
2525	Tp Pvc Bịt 110	tp pvc bit 110	cái	7000	0	\N	2025-07-18 16:43:49.911657	2025-07-18 16:43:49.911657
2526	Tp Pvc Bịt 125	tp pvc bit 125	cái	15000	0	\N	2025-07-18 16:43:49.915657	2025-07-18 16:43:49.915657
2527	Tp Pvc Bịt 140	tp pvc bit 140	cái	25000	0	\N	2025-07-18 16:43:49.917657	2025-07-18 16:43:49.917657
2528	Tp Pvc Bịt 21	tp pvc bit 21	cái	2000	0	\N	2025-07-18 16:43:49.920657	2025-07-18 16:43:49.920657
2529	Tp Pvc Bịt 27	tp pvc bit 27	cái	2500	0	\N	2025-07-18 16:43:49.923641	2025-07-18 16:43:49.923641
2530	Tp Pvc Bịt 34	tp pvc bit 34	cái	3000	0	\N	2025-07-18 16:43:49.927621	2025-07-18 16:43:49.927621
2531	Tp Pvc Bịt 42	tp pvc bit 42	cái	3500	0	\N	2025-07-18 16:43:49.930389	2025-07-18 16:43:49.930389
2532	Tp Pvc Bịt 48	tp pvc bit 48	cái	4000	0	\N	2025-07-18 16:43:49.932389	2025-07-18 16:43:49.932389
2533	Tp Pvc Bịt 60	tp pvc bit 60	cái	4500	0	\N	2025-07-18 16:43:49.933389	2025-07-18 16:43:49.933389
2534	Tp Pvc Bịt 75	tp pvc bit 75	cái	5000	0	\N	2025-07-18 16:43:49.936412	2025-07-18 16:43:49.936412
2535	Tp Pvc Bịt 90	tp pvc bit 90	cái	6000	0	\N	2025-07-18 16:43:49.939421	2025-07-18 16:43:49.939421
2536	Tp Pvc Bịt Xả 125	tp pvc bit xa 125	cái	46000	0	\N	2025-07-18 16:43:49.940945	2025-07-18 16:43:49.940945
2537	Tp Pvc Bịt Xả Tt 110	tp pvc bit xa tt 110	cái	32780	0	\N	2025-07-18 16:43:49.942944	2025-07-18 16:43:49.942944
2538	Tp Pvc Bịt Xả Tt 60	tp pvc bit xa tt 60	cái	11660	0	\N	2025-07-18 16:43:49.944946	2025-07-18 16:43:49.944946
2539	Tp Pvc Bịt Xả Tt 76	tp pvc bit xa tt 76	cái	16940	0	\N	2025-07-18 16:43:49.947945	2025-07-18 16:43:49.947945
2540	Tp Pvc Bịt Xả Tt 90	tp pvc bit xa tt 90	cái	24640	0	\N	2025-07-18 16:43:49.951218	2025-07-18 16:43:49.951218
2541	Tp Pvc Chếch 110	tp pvc chech 110	cái	37800	0	\N	2025-07-18 16:43:49.95473	2025-07-18 16:43:49.95473
2542	Tp Pvc Chếch 125	tp pvc chech 125	cái	66744	0	\N	2025-07-18 16:43:49.956731	2025-07-18 16:43:49.956731
2543	Tp Pvc Chếch 140	tp pvc chech 140	cái	83000	0	\N	2025-07-18 16:43:49.957731	2025-07-18 16:43:49.957731
2544	Tp Pvc Chếch 21	tp pvc chech 21	cái	2000	0	\N	2025-07-18 16:43:49.959731	2025-07-18 16:43:49.959731
2545	Tp Pvc Chếch 27	tp pvc chech 27	cái	2000	0	\N	2025-07-18 16:43:49.96161	2025-07-18 16:43:49.96161
2546	Tp Pvc Chếch 34	tp pvc chech 34	cái	2860	0	\N	2025-07-18 16:43:49.963586	2025-07-18 16:43:49.963586
2547	Tp Pvc Chếch 42	tp pvc chech 42	cái	4290	0	\N	2025-07-18 16:43:49.965585	2025-07-18 16:43:49.965585
2548	Tp Pvc Chếch 48	tp pvc chech 48	cái	6820	0	\N	2025-07-18 16:43:49.967585	2025-07-18 16:43:49.967585
2549	Tp Pvc Chếch 60	tp pvc chech 60	cái	10908	0	\N	2025-07-18 16:43:49.970583	2025-07-18 16:43:49.970583
2550	Tp Pvc Chếch 75	tp pvc chech 75	cái	18900	0	\N	2025-07-18 16:43:49.973607	2025-07-18 16:43:49.973607
2551	Tp Pvc Chếch 90	tp pvc chech 90	cái	24732	0	\N	2025-07-18 16:43:49.975645	2025-07-18 16:43:49.975645
2552	Tp Pvc Côn Thu 110/34	tp pvc con thu 110/34	cái	21708	0	\N	2025-07-18 16:43:49.977657	2025-07-18 16:43:49.977657
2553	Tp Pvc Côn Thu 110/42	tp pvc con thu 110/42	cái	20844	0	\N	2025-07-18 16:43:49.980635	2025-07-18 16:43:49.980635
2554	Tp Pvc Côn Thu 110/48	tp pvc con thu 110/48	cái	20844	0	\N	2025-07-18 16:43:49.984642	2025-07-18 16:43:49.984642
2555	Tp Pvc Côn Thu 110/60	tp pvc con thu 110/60	cái	21708	0	\N	2025-07-18 16:43:49.987658	2025-07-18 16:43:49.987658
2556	Tp Pvc Côn Thu 110/75	tp pvc con thu 110/75	cái	22032	0	\N	2025-07-18 16:43:49.989657	2025-07-18 16:43:49.989657
2557	Tp Pvc Côn Thu 110/90	tp pvc con thu 110/90	cái	22572	0	\N	2025-07-18 16:43:49.992899	2025-07-18 16:43:49.992899
2558	Tp Pvc Côn Thu 27/21	tp pvc con thu 27/21	cái	2000	0	\N	2025-07-18 16:43:49.994899	2025-07-18 16:43:49.994899
2559	Tp Pvc Côn Thu 34/21	tp pvc con thu 34/21	cái	2000	0	\N	2025-07-18 16:43:49.996912	2025-07-18 16:43:49.996912
2560	Tp Pvc Côn Thu 34/27	tp pvc con thu 34/27	cái	2420	0	\N	2025-07-18 16:43:49.999913	2025-07-18 16:43:49.999913
2561	Tp Pvc Côn Thu 42/21	tp pvc con thu 42/21	cái	2860	0	\N	2025-07-18 16:43:50.002387	2025-07-18 16:43:50.002387
2562	Tp Pvc Côn Thu 42/27	tp pvc con thu 42/27	cái	2970	0	\N	2025-07-18 16:43:50.005419	2025-07-18 16:43:50.005419
2563	Tp Pvc Côn Thu 42/34	tp pvc con thu 42/34	cái	3190	0	\N	2025-07-18 16:43:50.007434	2025-07-18 16:43:50.007434
2564	Tp Pvc Côn Thu 48/21	tp pvc con thu 48/21	cái	5000	0	\N	2025-07-18 16:43:50.010433	2025-07-18 16:43:50.010433
2565	Tp Pvc Côn Thu 48/27	tp pvc con thu 48/27	cái	5000	0	\N	2025-07-18 16:43:50.012433	2025-07-18 16:43:50.012433
2566	Tp Pvc Côn Thu 48/34	tp pvc con thu 48/34	cái	5000	0	\N	2025-07-18 16:43:50.015415	2025-07-18 16:43:50.015415
2567	Tp Pvc Côn Thu 48/42	tp pvc con thu 48/42	cái	5000	0	\N	2025-07-18 16:43:50.017265	2025-07-18 16:43:50.017265
2568	Tp Pvc Côn Thu 60/21	tp pvc con thu 60/21	cái	5280	0	\N	2025-07-18 16:43:50.019357	2025-07-18 16:43:50.019357
2569	Tp Pvc Côn Thu 60/27	tp pvc con thu 60/27	cái	6380	0	\N	2025-07-18 16:43:50.022498	2025-07-18 16:43:50.022498
2570	Tp Pvc Côn Thu 60/34	tp pvc con thu 60/34	cái	6380	0	\N	2025-07-18 16:43:50.025039	2025-07-18 16:43:50.025039
2571	Tp Pvc Côn Thu 60/42	tp pvc con thu 60/42	cái	6380	0	\N	2025-07-18 16:43:50.027106	2025-07-18 16:43:50.027106
2572	Tp Pvc Côn Thu 60/48	tp pvc con thu 60/48	cái	6820	0	\N	2025-07-18 16:43:50.029117	2025-07-18 16:43:50.029117
2573	Tp Pvc Côn Thu 75/27	tp pvc con thu 75/27	cái	10000	0	\N	2025-07-18 16:43:50.031131	2025-07-18 16:43:50.031131
2574	Tp Pvc Côn Thu 75/34	tp pvc con thu 75/34	cái	10120	0	\N	2025-07-18 16:43:50.033117	2025-07-18 16:43:50.033117
2575	Tp Pvc Côn Thu 75/42	tp pvc con thu 75/42	cái	10120	0	\N	2025-07-18 16:43:50.034116	2025-07-18 16:43:50.034116
2576	Tp Pvc Côn Thu 75/48	tp pvc con thu 75/48	cái	10120	0	\N	2025-07-18 16:43:50.037132	2025-07-18 16:43:50.037132
2577	Tp Pvc Côn Thu 75/60	tp pvc con thu 75/60	cái	10670	0	\N	2025-07-18 16:43:50.039164	2025-07-18 16:43:50.039164
2578	Tp Pvc Côn Thu 90/34	tp pvc con thu 90/34	cái	12760	0	\N	2025-07-18 16:43:50.040164	2025-07-18 16:43:50.040164
2579	Tp Pvc Côn Thu 90/42	tp pvc con thu 90/42	cái	13970	0	\N	2025-07-18 16:43:50.042178	2025-07-18 16:43:50.042178
2580	Tp Pvc Côn Thu 90/48	tp pvc con thu 90/48	cái	13970	0	\N	2025-07-18 16:43:50.045178	2025-07-18 16:43:50.045178
2581	Tp Pvc Côn Thu 90/60	tp pvc con thu 90/60	cái	14410	0	\N	2025-07-18 16:43:50.048143	2025-07-18 16:43:50.048143
2582	Tp Pvc Côn Thu 90/75	tp pvc con thu 90/75	cái	15730	0	\N	2025-07-18 16:43:50.051163	2025-07-18 16:43:50.051163
2583	Tp Pvc Cút 110	tp pvc cut 110	cái	48060	0	\N	2025-07-18 16:43:50.053743	2025-07-18 16:43:50.053743
2584	Tp Pvc Cút 160	tp pvc cut 160	cái	148000	0	\N	2025-07-18 16:43:50.055757	2025-07-18 16:43:50.055757
2585	Tp Pvc Cút 200	tp pvc cut 200	cái	301752	0	\N	2025-07-18 16:43:50.058722	2025-07-18 16:43:50.058722
2586	Tp Pvc Cút 21	tp pvc cut 21	cái	2000	0	\N	2025-07-18 16:43:50.061743	2025-07-18 16:43:50.061743
2587	Tp Pvc Cút 27	tp pvc cut 27	cái	2500	0	\N	2025-07-18 16:43:50.062743	2025-07-18 16:43:50.062743
2588	Tp Pvc Cút 34	tp pvc cut 34	cái	3410	0	\N	2025-07-18 16:43:50.064743	2025-07-18 16:43:50.064743
2589	Tp Pvc Cút 42	tp pvc cut 42	cái	5610	0	\N	2025-07-18 16:43:50.066743	2025-07-18 16:43:50.066743
2590	Tp Pvc Cút 48	tp pvc cut 48	cái	8800	0	\N	2025-07-18 16:43:50.068726	2025-07-18 16:43:50.068726
2591	Tp Pvc Cút 60	tp pvc cut 60	cái	12744	0	\N	2025-07-18 16:43:50.071727	2025-07-18 16:43:50.071727
2592	Tp Pvc Cút 75	tp pvc cut 75	cái	23000	0	\N	2025-07-18 16:43:50.073741	2025-07-18 16:43:50.073741
2594	Tp Pvc Keo 1 Kg	tp pvc keo 1 kg	hộp	152240	0	\N	2025-07-18 16:43:50.078803	2025-07-18 16:43:50.078803
2595	Tp Pvc Keo 15Gr	tp pvc keo 15gr	tuýp	5000	0	\N	2025-07-18 16:43:50.081771	2025-07-18 16:43:50.081771
2596	Tp Pvc Keo 30Gr	tp pvc keo 30gr	tuýp	5900	0	\N	2025-07-18 16:43:50.084788	2025-07-18 16:43:50.084788
2597	Tp Pvc Keo 500Gr	tp pvc keo 500gr	hộp	84200	0	\N	2025-07-18 16:43:50.08679	2025-07-18 16:43:50.08679
2598	Tp Pvc Keo 50Gr	tp pvc keo 50gr	tuýp	9000	0	\N	2025-07-18 16:43:50.088803	2025-07-18 16:43:50.088803
2599	Tp Pvc Măng Sông 110	tp pvc mang song 110	cái	17500	0	\N	2025-07-18 16:43:50.092362	2025-07-18 16:43:50.092362
2600	Tp Pvc Măng Sông 125	tp pvc mang song 125	cái	40000	0	\N	2025-07-18 16:43:50.094347	2025-07-18 16:43:50.094347
2601	Tp Pvc Măng Sông 21	tp pvc mang song 21	cái	2000	0	\N	2025-07-18 16:43:50.096345	2025-07-18 16:43:50.096345
2602	Tp Pvc Măng Sông 27	tp pvc mang song 27	cái	2000	0	\N	2025-07-18 16:43:50.099345	2025-07-18 16:43:50.099345
2603	Tp Pvc Măng Sông 34	tp pvc mang song 34	cái	2500	0	\N	2025-07-18 16:43:50.101361	2025-07-18 16:43:50.101361
2604	Tp Pvc Măng Sông 42	tp pvc mang song 42	cái	4000	0	\N	2025-07-18 16:43:50.104957	2025-07-18 16:43:50.104957
2605	Tp Pvc Măng Sông 48	tp pvc mang song 48	cái	5000	0	\N	2025-07-18 16:43:50.106943	2025-07-18 16:43:50.106943
2606	Tp Pvc Măng Sông 60	tp pvc mang song 60	cái	8000	0	\N	2025-07-18 16:43:50.108943	2025-07-18 16:43:50.108943
2607	Tp Pvc Măng Sông 75	tp pvc mang song 75	cái	10000	0	\N	2025-07-18 16:43:50.109943	2025-07-18 16:43:50.109943
2608	Tp Pvc Măng Sông 90	tp pvc mang song 90	cái	14000	0	\N	2025-07-18 16:43:50.112241	2025-07-18 16:43:50.112241
2609	Tp Pvc Măng Sông Ren Trong 42	tp pvc mang song ren trong 42	cái	7000	0	\N	2025-07-18 16:43:50.115242	2025-07-18 16:43:50.115242
2610	Tp Pvc Măng Sông Trượt 110	tp pvc mang song truot 110	cái	126000	0	\N	2025-07-18 16:43:50.117227	2025-07-18 16:43:50.117227
3019	Vít Mạ 5X4	vit ma 5x4	kg	40000	0	\N	2025-07-18 16:43:51.11106	2025-07-18 16:43:51.11106
2611	Tp Pvc Măng Sông Trượt 75	tp pvc mang song truot 75	cái	65000	0	\N	2025-07-18 16:43:50.120227	2025-07-18 16:43:50.120227
2612	Tp Pvc Măng Sông Trượt 90	tp pvc mang song truot 90	cái	90000	0	\N	2025-07-18 16:43:50.122242	2025-07-18 16:43:50.122242
2613	Tp Pvc Ống C0 110	tp pvc ong c0 110	m	72576	0	\N	2025-07-18 16:43:50.124241	2025-07-18 16:43:50.124241
2614	Tp Pvc Ống C0 160	tp pvc ong c0 160	m	148284	0	\N	2025-07-18 16:43:50.127217	2025-07-18 16:43:50.127217
2615	Tp Pvc Ống C0 21	tp pvc ong c0 21	m	8470	0	\N	2025-07-18 16:43:50.129227	2025-07-18 16:43:50.129227
2616	Tp Pvc Ống C0 27	tp pvc ong c0 27	m	10780	0	\N	2025-07-18 16:43:50.131241	2025-07-18 16:43:50.131241
2617	Tp Pvc Ống C0 34	tp pvc ong c0 34	m	12744	0	\N	2025-07-18 16:43:50.134242	2025-07-18 16:43:50.134242
2618	Tp Pvc Ống C0 42	tp pvc ong c0 42	m	18590	0	\N	2025-07-18 16:43:50.137227	2025-07-18 16:43:50.137227
2619	Tp Pvc Ống C0 48	tp pvc ong c0 48	m	22356	0	\N	2025-07-18 16:43:50.140239	2025-07-18 16:43:50.140239
2620	Tp Pvc Ống C0 60	tp pvc ong c0 60	m	29700	0	\N	2025-07-18 16:43:50.143253	2025-07-18 16:43:50.143253
2621	Tp Pvc Ống C0 75	tp pvc ong c0 75	m	41360	0	\N	2025-07-18 16:43:50.146253	2025-07-18 16:43:50.146253
2622	Tp Pvc Ống C0 90	tp pvc ong c0 90	m	49390	0	\N	2025-07-18 16:43:50.149229	2025-07-18 16:43:50.149229
2623	Tp Pvc Ống C1 110	tp pvc ong c1 110	m	84564	0	\N	2025-07-18 16:43:50.151237	2025-07-18 16:43:50.151237
2624	Tp Pvc Ống C1 125	tp pvc ong c1 125	m	105000	0	\N	2025-07-18 16:43:50.153764	2025-07-18 16:43:50.153764
2625	Tp Pvc Ống C1 140	tp pvc ong c1 140	m	130680	0	\N	2025-07-18 16:43:50.15581	2025-07-18 16:43:50.15581
2626	Tp Pvc Ống C1 160	tp pvc ong c1 160	cái	172800	0	\N	2025-07-18 16:43:50.158778	2025-07-18 16:43:50.158778
2627	Tp Pvc Ống C1 21	tp pvc ong c1 21	m	9072	0	\N	2025-07-18 16:43:50.161795	2025-07-18 16:43:50.161795
2628	Tp Pvc Ống C1 27	tp pvc ong c1 27	m	12420	0	\N	2025-07-18 16:43:50.164829	2025-07-18 16:43:50.164829
2629	Tp Pvc Ống C1 34	tp pvc ong c1 34	m	15950	0	\N	2025-07-18 16:43:50.166811	2025-07-18 16:43:50.166811
2630	Tp Pvc Ống C1 42	tp pvc ong c1 42	m	21492	0	\N	2025-07-18 16:43:50.16881	2025-07-18 16:43:50.16881
2631	Tp Pvc Ống C1 48	tp pvc ong c1 48	m	26070	0	\N	2025-07-18 16:43:50.171773	2025-07-18 16:43:50.171773
2632	Tp Pvc Ống C1 60	tp pvc ong c1 60	m	36180	0	\N	2025-07-18 16:43:50.174811	2025-07-18 16:43:50.174811
2633	Tp Pvc Ống C1 75	tp pvc ong c1 75	m	46008	0	\N	2025-07-18 16:43:50.176842	2025-07-18 16:43:50.176842
2634	Tp Pvc Ống C1 90	tp pvc ong c1 90	m	56808	0	\N	2025-07-18 16:43:50.178841	2025-07-18 16:43:50.178841
2635	Tp Pvc Ống C2 110	tp pvc ong c2 110	m	96228	0	\N	2025-07-18 16:43:50.182828	2025-07-18 16:43:50.182828
2636	Tp Pvc Ống C2 200	tp pvc ong c2 200	m	312984	0	\N	2025-07-18 16:43:50.184841	2025-07-18 16:43:50.184841
2637	Tp Pvc Ống C2 21	tp pvc ong c2 21	m	10908	0	\N	2025-07-18 16:43:50.186828	2025-07-18 16:43:50.186828
2638	Tp Pvc Ống C2 27	tp pvc ong c2 27	m	13824	0	\N	2025-07-18 16:43:50.188828	2025-07-18 16:43:50.188828
2639	Tp Pvc Ống C2 34	tp pvc ong c2 34	m	19116	0	\N	2025-07-18 16:43:50.189825	2025-07-18 16:43:50.189825
2640	Tp Pvc Ống C2 42	tp pvc ong c2 42	m	24408	0	\N	2025-07-18 16:43:50.192098	2025-07-18 16:43:50.192098
2641	Tp Pvc Ống C2 48	tp pvc ong c2 48	m	29484	0	\N	2025-07-18 16:43:50.195113	2025-07-18 16:43:50.195113
2642	Tp Pvc Ống C2 60	tp pvc ong c2 60	m	42120	0	\N	2025-07-18 16:43:50.197115	2025-07-18 16:43:50.197115
2643	Tp Pvc Ống C2 75	tp pvc ong c2 75	m	60000	0	\N	2025-07-18 16:43:50.199113	2025-07-18 16:43:50.199113
2644	Tp Pvc Ống C2 90	tp pvc ong c2 90	m	65664	0	\N	2025-07-18 16:43:50.201112	2025-07-18 16:43:50.201112
2645	Tp Pvc Ống C3	tp pvc ong c3	m	134784	0	\N	2025-07-18 16:43:50.203658	2025-07-18 16:43:50.203658
2646	Tp Pvc Ống C3 21	tp pvc ong c3 21	m	12800	0	\N	2025-07-18 16:43:50.205695	2025-07-18 16:43:50.205695
2647	Tp Pvc Ống C3 48	tp pvc ong c3 48	m	35640	0	\N	2025-07-18 16:43:50.207708	2025-07-18 16:43:50.207708
2648	Tp Pvc Ống C3 60 Pvc	tp pvc ong c3 60 pvc	m	50976	0	\N	2025-07-18 16:43:50.210675	2025-07-18 16:43:50.210675
2649	Tp Pvc Ống C3 73 Pvc	tp pvc ong c3 73 pvc	m	74304	0	\N	2025-07-18 16:43:50.212693	2025-07-18 16:43:50.212693
2650	Tp Pvc Ống C3 90	tp pvc ong c3 90	m	86076	0	\N	2025-07-18 16:43:50.214671	2025-07-18 16:43:50.214671
2651	Tp Pvc Ống Lọc C0 48	tp pvc ong loc c0 48	cây	80520	0	\N	2025-07-18 16:43:50.217694	2025-07-18 16:43:50.217694
2652	Tp Pvc Ống Lọc C1 48	tp pvc ong loc c1 48	m	99880	0	\N	2025-07-18 16:43:50.219709	2025-07-18 16:43:50.219709
2653	Tp Pvc Ống Thoát 110	tp pvc ong thoat 110	m	65340	0	\N	2025-07-18 16:43:50.221709	2025-07-18 16:43:50.221709
2654	Tp Pvc Ống Thoát 21	tp pvc ong thoat 21	m	6930	0	\N	2025-07-18 16:43:50.223708	2025-07-18 16:43:50.223708
2655	Tp Pvc Ống Thoát 27	tp pvc ong thoat 27	m	8580	0	\N	2025-07-18 16:43:50.22669	2025-07-18 16:43:50.22669
2656	Tp Pvc Ống Thoát 34	tp pvc ong thoat 34	m	11110	0	\N	2025-07-18 16:43:50.228695	2025-07-18 16:43:50.228695
2657	Tp Pvc Ống Thoát 42	tp pvc ong thoat 42	m	16610	0	\N	2025-07-18 16:43:50.230708	2025-07-18 16:43:50.230708
2658	Tp Pvc Ống Thoát 48	tp pvc ong thoat 48	m	19470	0	\N	2025-07-18 16:43:50.233709	2025-07-18 16:43:50.233709
2659	Tp Pvc Ống Thoát 60	tp pvc ong thoat 60	m	25300	0	\N	2025-07-18 16:43:50.236567	2025-07-18 16:43:50.236567
2660	Tp Pvc Ống Thoát 75	tp pvc ong thoat 75	m	35420	0	\N	2025-07-18 16:43:50.237573	2025-07-18 16:43:50.237573
2661	Tp Pvc Ống Thoát 90	tp pvc ong thoat 90	m	43230	0	\N	2025-07-18 16:43:50.241063	2025-07-18 16:43:50.241063
2662	Tp Pvc Rn 110	tp pvc rn 110	cái	59832	0	\N	2025-07-18 16:43:50.243108	2025-07-18 16:43:50.243108
2663	Tp Pvc Rn 21	tp pvc rn 21	cái	2000	0	\N	2025-07-18 16:43:50.24412	2025-07-18 16:43:50.24412
2664	Tp Pvc Rn 27	tp pvc rn 27	cái	2000	0	\N	2025-07-18 16:43:50.247153	2025-07-18 16:43:50.247153
2665	Tp Pvc Rn 42	tp pvc rn 42	cái	4180	0	\N	2025-07-18 16:43:50.250129	2025-07-18 16:43:50.250129
2666	Tp Pvc Rn 48	tp pvc rn 48	cái	5940	0	\N	2025-07-18 16:43:50.252371	2025-07-18 16:43:50.252371
2667	Tp Pvc Rn 60	tp pvc rn 60	cái	9460	0	\N	2025-07-18 16:43:50.25486	2025-07-18 16:43:50.25486
2668	Tp Pvc Rn 75	tp pvc rn 75	cái	10476	0	\N	2025-07-18 16:43:50.25687	2025-07-18 16:43:50.25687
2669	Tp Pvc Rn 90	tp pvc rn 90	cái	23652	0	\N	2025-07-18 16:43:50.258873	2025-07-18 16:43:50.258873
2670	Tp Pvc Rt 110	tp pvc rt 110	cái	61020	0	\N	2025-07-18 16:43:50.260886	2025-07-18 16:43:50.260886
2671	Tp Pvc Rt 21	tp pvc rt 21	cái	1500	0	\N	2025-07-18 16:43:50.262869	2025-07-18 16:43:50.262869
2672	Tp Pvc Rt 27	tp pvc rt 27	cái	1650	0	\N	2025-07-18 16:43:50.263869	2025-07-18 16:43:50.263869
2673	Tp Pvc Rt 34	tp pvc rt 34	cái	2970	0	\N	2025-07-18 16:43:50.265869	2025-07-18 16:43:50.265869
2674	Tp Pvc Rt 42	tp pvc rt 42	cái	4180	0	\N	2025-07-18 16:43:50.269989	2025-07-18 16:43:50.269989
2675	Tp Pvc Rt 48	tp pvc rt 48	cái	5940	0	\N	2025-07-18 16:43:50.272966	2025-07-18 16:43:50.272966
2676	Tp Pvc Rt 60	tp pvc rt 60	cái	8360	0	\N	2025-07-18 16:43:50.276571	2025-07-18 16:43:50.276571
2677	Tp Pvc Rt 75	tp pvc rt 75	cái	16632	0	\N	2025-07-18 16:43:50.277574	2025-07-18 16:43:50.277574
2678	Tp Pvc Rt 90	tp pvc rt 90	cái	26460	0	\N	2025-07-18 16:43:50.28057	2025-07-18 16:43:50.28057
2679	Tp Pvc Si Pông 110	tp pvc si pong 110	cái	157410	0	\N	2025-07-18 16:43:50.283577	2025-07-18 16:43:50.283577
2680	Tp Pvc Si Pông 42	tp pvc si pong 42	cái	28820	0	\N	2025-07-18 16:43:50.286572	2025-07-18 16:43:50.286572
2681	Tp Pvc Si Pông 48	tp pvc si pong 48	cái	39380	0	\N	2025-07-18 16:43:50.288571	2025-07-18 16:43:50.288571
2682	Tp Pvc Si Pông 60	tp pvc si pong 60	cái	63910	0	\N	2025-07-18 16:43:50.289568	2025-07-18 16:43:50.289568
2683	Tp Pvc Si Pông 75	tp pvc si pong 75	cái	111540	0	\N	2025-07-18 16:43:50.292079	2025-07-18 16:43:50.292079
2684	Tp Pvc Si Pông 90	tp pvc si pong 90	cái	141790	0	\N	2025-07-18 16:43:50.294275	2025-07-18 16:43:50.294275
2685	Tp Pvc Tê 110	tp pvc te 110	cái	67932	0	\N	2025-07-18 16:43:50.297279	2025-07-18 16:43:50.297279
2686	Tp Pvc Tê 125	tp pvc te 125	cái	114000	0	\N	2025-07-18 16:43:50.300775	2025-07-18 16:43:50.300775
2687	Tp Pvc Tê 21	tp pvc te 21	cái	2310	0	\N	2025-07-18 16:43:50.305324	2025-07-18 16:43:50.305324
2688	Tp Pvc Tê 27	tp pvc te 27	cái	3850	0	\N	2025-07-18 16:43:50.307346	2025-07-18 16:43:50.307346
2689	Tp Pvc Tê 34	tp pvc te 34	cái	5170	0	\N	2025-07-18 16:43:50.310361	2025-07-18 16:43:50.310361
2690	Tp Pvc Tê 42	tp pvc te 42	cái	7370	0	\N	2025-07-18 16:43:50.312361	2025-07-18 16:43:50.312361
2691	Tp Pvc Tê 48	tp pvc te 48	cái	11000	0	\N	2025-07-18 16:43:50.316345	2025-07-18 16:43:50.316345
2692	Tp Pvc Tê 60	tp pvc te 60	cái	17064	0	\N	2025-07-18 16:43:50.318361	2025-07-18 16:43:50.318361
2693	Tp Pvc Tê 75	tp pvc te 75	cái	29052	0	\N	2025-07-18 16:43:50.321361	2025-07-18 16:43:50.321361
2694	Tp Pvc Tê 90	tp pvc te 90	cái	40068	0	\N	2025-07-18 16:43:50.323361	2025-07-18 16:43:50.323361
2695	Tp Pvc Tê Cong 110	tp pvc te cong 110	cái	77436	0	\N	2025-07-18 16:43:50.326362	2025-07-18 16:43:50.326362
2696	Tp Pvc Tê Cong 60	tp pvc te cong 60	cái	20127	0	\N	2025-07-18 16:43:50.329361	2025-07-18 16:43:50.329361
2697	Tp Pvc Tê Cong 90	tp pvc te cong 90	cái	46440	0	\N	2025-07-18 16:43:50.331347	2025-07-18 16:43:50.331347
2698	Tp Pvc Tê Thu 110/34	tp pvc te thu 110/34	cái	39600	0	\N	2025-07-18 16:43:50.333361	2025-07-18 16:43:50.333361
2699	Tp Pvc Tê Thu 110/42	tp pvc te thu 110/42	cái	40040	0	\N	2025-07-18 16:43:50.335361	2025-07-18 16:43:50.335361
2700	Tp Pvc Tê Thu 110/48	tp pvc te thu 110/48	cái	42020	0	\N	2025-07-18 16:43:50.33833	2025-07-18 16:43:50.33833
2701	Tp Pvc Tê Thu 110/60	tp pvc te thu 110/60	cái	46530	0	\N	2025-07-18 16:43:50.340376	2025-07-18 16:43:50.340376
2702	Tp Pvc Tê Thu 110/75	tp pvc te thu 110/75	cái	49170	0	\N	2025-07-18 16:43:50.34239	2025-07-18 16:43:50.34239
2703	Tp Pvc Tê Thu 110/90	tp pvc te thu 110/90	cái	57780	0	\N	2025-07-18 16:43:50.345391	2025-07-18 16:43:50.345391
2704	Tp Pvc Tê Thu 27/21	tp pvc te thu 27/21	cái	2970	0	\N	2025-07-18 16:43:50.348374	2025-07-18 16:43:50.348374
2705	Tp Pvc Tê Thu 34/21	tp pvc te thu 34/21	cái	3850	0	\N	2025-07-18 16:43:50.35039	2025-07-18 16:43:50.35039
2706	Tp Pvc Tê Thu 34/27	tp pvc te thu 34/27	cái	4180	0	\N	2025-07-18 16:43:50.35239	2025-07-18 16:43:50.35239
2707	Tp Pvc Tê Thu 42/21	tp pvc te thu 42/21	cái	5060	0	\N	2025-07-18 16:43:50.35492	2025-07-18 16:43:50.35492
2708	Tp Pvc Tê Thu 42/27	tp pvc te thu 42/27	cái	5610	0	\N	2025-07-18 16:43:50.356971	2025-07-18 16:43:50.356971
2709	Tp Pvc Tê Thu 42/34	tp pvc te thu 42/34	cái	6820	0	\N	2025-07-18 16:43:50.360956	2025-07-18 16:43:50.360956
2710	Tp Pvc Tê Thu 48/21	tp pvc te thu 48/21	cái	8250	0	\N	2025-07-18 16:43:50.363955	2025-07-18 16:43:50.363955
2711	Tp Pvc Tê Thu 48/27	tp pvc te thu 48/27	cái	8360	0	\N	2025-07-18 16:43:50.365376	2025-07-18 16:43:50.365376
2712	Tp Pvc Tê Thu 48/34	tp pvc te thu 48/34	cái	8800	0	\N	2025-07-18 16:43:50.367445	2025-07-18 16:43:50.367445
2713	Tp Pvc Tê Thu 48/42	tp pvc te thu 48/42	cái	11124	0	\N	2025-07-18 16:43:50.371804	2025-07-18 16:43:50.371804
2714	Tp Pvc Tê Thu 60/21	tp pvc te thu 60/21	cái	10230	0	\N	2025-07-18 16:43:50.374837	2025-07-18 16:43:50.374837
2715	Tp Pvc Tê Thu 60/27	tp pvc te thu 60/27	cái	11550	0	\N	2025-07-18 16:43:50.376884	2025-07-18 16:43:50.376884
2716	Tp Pvc Tê Thu 60/34	tp pvc te thu 60/34	cái	12650	0	\N	2025-07-18 16:43:50.378847	2025-07-18 16:43:50.378847
2717	Tp Pvc Tê Thu 60/42	tp pvc te thu 60/42	cái	13716	0	\N	2025-07-18 16:43:50.382881	2025-07-18 16:43:50.382881
2718	Tp Pvc Tê Thu 60/48	tp pvc te thu 60/48	cái	14630	0	\N	2025-07-18 16:43:50.384868	2025-07-18 16:43:50.384868
2719	Tp Pvc Tê Thu 75/27	tp pvc te thu 75/27	cái	18500	0	\N	2025-07-18 16:43:50.385868	2025-07-18 16:43:50.385868
2720	Tp Pvc Tê Thu 75/34	tp pvc te thu 75/34	cái	19000	0	\N	2025-07-18 16:43:50.38787	2025-07-18 16:43:50.38787
2721	Tp Pvc Tê Thu 75/42	tp pvc te thu 75/42	cái	20196	0	\N	2025-07-18 16:43:50.38887	2025-07-18 16:43:50.38887
2722	Tp Pvc Tê Thu 75/48	tp pvc te thu 75/48	cái	23320	0	\N	2025-07-18 16:43:50.392454	2025-07-18 16:43:50.392454
2723	Tp Pvc Tê Thu 75/60	tp pvc te thu 75/60	cái	26070	0	\N	2025-07-18 16:43:50.394475	2025-07-18 16:43:50.394475
2724	Tp Pvc Tê Thu 76/27	tp pvc te thu 76/27	cái	18500	0	\N	2025-07-18 16:43:50.396491	2025-07-18 16:43:50.396491
2725	Tp Pvc Tê Thu 90/34	tp pvc te thu 90/34	cái	31790	0	\N	2025-07-18 16:43:50.399492	2025-07-18 16:43:50.399492
2726	Tp Pvc Tê Thu 90/42	tp pvc te thu 90/42	cái	25380	0	\N	2025-07-18 16:43:50.401491	2025-07-18 16:43:50.401491
2727	Tp Pvc Tê Thu 90/48	tp pvc te thu 90/48	cái	31460	0	\N	2025-07-18 16:43:50.405022	2025-07-18 16:43:50.405022
2728	Tp Pvc Tê Thu 90/60	tp pvc te thu 90/60	cái	38280	0	\N	2025-07-18 16:43:50.407055	2025-07-18 16:43:50.407055
2729	Tp Pvc Tê Thu 90/75	tp pvc te thu 90/75	cái	40040	0	\N	2025-07-18 16:43:50.409057	2025-07-18 16:43:50.409057
2730	Tp Pvc Tứ Cong 110 (Chạc 4)	tp pvc tu cong 110 (chac 4)	cái	104000	0	\N	2025-07-18 16:43:50.411057	2025-07-18 16:43:50.411057
2731	Tp Pvc Tứ Cong 90 (Chạc 4)	tp pvc tu cong 90 (chac 4)	cái	60000	0	\N	2025-07-18 16:43:50.412055	2025-07-18 16:43:50.412055
2732	Tp Pvc Y 110	tp pvc y 110	cái	74844	0	\N	2025-07-18 16:43:50.415038	2025-07-18 16:43:50.415038
2733	Tp Pvc Y 125	tp pvc y 125	cái	150000	0	\N	2025-07-18 16:43:50.417033	2025-07-18 16:43:50.417033
2734	Tp Pvc Y 140	tp pvc y 140	cái	240000	0	\N	2025-07-18 16:43:50.420056	2025-07-18 16:43:50.420056
2735	Tp Pvc Y 27	tp pvc y 27	cái	5940	0	\N	2025-07-18 16:43:50.422071	2025-07-18 16:43:50.422071
2736	Tp Pvc Y 34	tp pvc y 34	cái	6160	0	\N	2025-07-18 16:43:50.424071	2025-07-18 16:43:50.424071
2737	Tp Pvc Y 42	tp pvc y 42	cái	8250	0	\N	2025-07-18 16:43:50.428832	2025-07-18 16:43:50.428832
2738	Tp Pvc Y 48	tp pvc y 48	cái	15950	0	\N	2025-07-18 16:43:50.431898	2025-07-18 16:43:50.431898
2739	Tp Pvc Y 60	tp pvc y 60	cái	21060	0	\N	2025-07-18 16:43:50.433885	2025-07-18 16:43:50.433885
2740	Tp Pvc Y 75	tp pvc y 75	cái	40500	0	\N	2025-07-18 16:43:50.435898	2025-07-18 16:43:50.435898
2741	Tp Pvc Y 90	tp pvc y 90	cái	49572	0	\N	2025-07-18 16:43:50.437897	2025-07-18 16:43:50.437897
2742	Tp Pvc Y Thu 110/60	tp pvc y thu 110/60	cái	75000	0	\N	2025-07-18 16:43:50.439897	2025-07-18 16:43:50.439897
2743	Tp Pvc Y Thu 110/75	tp pvc y thu 110/75	cái	0	0	\N	2025-07-18 16:43:50.442928	2025-07-18 16:43:50.442928
2744	Tp Pvc Y Thu 110/90	tp pvc y thu 110/90	cái	72160	0	\N	2025-07-18 16:43:50.444942	2025-07-18 16:43:50.444942
2745	Tp Pvc Y Thu 90/75	tp pvc y thu 90/75	cái	50000	0	\N	2025-07-18 16:43:50.446942	2025-07-18 16:43:50.446942
2746	Trần Đảo Hatari	tran dao hatari	cái	1350000	0	\N	2025-07-18 16:43:50.449904	2025-07-18 16:43:50.449904
2747	Trần Phú Cáp Điện 2X6	tran phu cap dien 2x6	m	61000	0	\N	2025-07-18 16:43:50.451926	2025-07-18 16:43:50.451926
2748	Trần Phú Cáp Treo 2X6	tran phu cap treo 2x6	m	61000	0	\N	2025-07-18 16:43:50.453942	2025-07-18 16:43:50.453942
2749	Trần Phú Dây 1X1 Đỏ	tran phu day 1x1 do	m	5100	0	\N	2025-07-18 16:43:50.457367	2025-07-18 16:43:50.457367
2750	Trần Phú Dây 1X1 Xanh	tran phu day 1x1 xanh	m	5100	0	\N	2025-07-18 16:43:50.460367	2025-07-18 16:43:50.460367
2751	Trần Phú Dây 1X1.5 Đỏ	tran phu day 1x1.5 do	m	7530	0	\N	2025-07-18 16:43:50.462367	2025-07-18 16:43:50.462367
2752	Trần Phú Dây 1X1.5 Tiếp Địa	tran phu day 1x1.5 tiep dia	m	7530	0	\N	2025-07-18 16:43:50.465368	2025-07-18 16:43:50.465368
2753	Trần Phú Dây 1X1.5 Vàng	tran phu day 1x1.5 vang	m	7530	0	\N	2025-07-18 16:43:50.467367	2025-07-18 16:43:50.467367
2754	Trần Phú Dây 1X1.5 Xanh	tran phu day 1x1.5 xanh	m	7530	0	\N	2025-07-18 16:43:50.469345	2025-07-18 16:43:50.469345
2755	Trần Phú Dây 1X10 Đỏ	tran phu day 1x10 do	m	49500	0	\N	2025-07-18 16:43:50.471352	2025-07-18 16:43:50.471352
2756	Trần Phú Dây 1X10 Xanh	tran phu day 1x10 xanh	m	49500	0	\N	2025-07-18 16:43:50.474007	2025-07-18 16:43:50.474007
2757	Trần Phú Dây 1X2.5 Đỏ	tran phu day 1x2.5 do	m	12240	0	\N	2025-07-18 16:43:50.475996	2025-07-18 16:43:50.475996
2758	Trần Phú Dây 1X2.5 Tiếp Địa	tran phu day 1x2.5 tiep dia	m	12240	0	\N	2025-07-18 16:43:50.478002	2025-07-18 16:43:50.478002
2759	Trần Phú Dây 1X2.5 Vàng	tran phu day 1x2.5 vang	m	12240	0	\N	2025-07-18 16:43:50.480002	2025-07-18 16:43:50.480002
2760	Trần Phú Dây 1X2.5 Xanh	tran phu day 1x2.5 xanh	m	12240	0	\N	2025-07-18 16:43:50.482005	2025-07-18 16:43:50.482005
2761	Trần Phú Dây 1X4 Đỏ	tran phu day 1x4 do	m	18800	0	\N	2025-07-18 16:43:50.484784	2025-07-18 16:43:50.484784
2762	Trần Phú Dây 1X4 Tiếp Địa	tran phu day 1x4 tiep dia	m	18800	0	\N	2025-07-18 16:43:50.486783	2025-07-18 16:43:50.486783
2763	Trần Phú Dây 1X4 Vàng	tran phu day 1x4 vang	m	18800	0	\N	2025-07-18 16:43:50.488783	2025-07-18 16:43:50.488783
2764	Trần Phú Dây 1X4 Xanh	tran phu day 1x4 xanh	m	18800	0	\N	2025-07-18 16:43:50.491313	2025-07-18 16:43:50.491313
2765	Trần Phú Dây 1X6 Đỏ	tran phu day 1x6 do	m	27940	0	\N	2025-07-18 16:43:50.494871	2025-07-18 16:43:50.494871
2766	Trần Phú Dây 1X6 Tiếp Địa	tran phu day 1x6 tiep dia	m	27940	0	\N	2025-07-18 16:43:50.497902	2025-07-18 16:43:50.497902
2767	Trần Phú Dây 1X6 Xanh	tran phu day 1x6 xanh	m	27940	0	\N	2025-07-18 16:43:50.499906	2025-07-18 16:43:50.499906
2768	Trần Phú Dây 2X0.75	tran phu day 2x0.75	m	9130	0	\N	2025-07-18 16:43:50.501906	2025-07-18 16:43:50.501906
2769	Trần Phú Dây 2X1.0	tran phu day 2x1.0	m	11700	0	\N	2025-07-18 16:43:50.505876	2025-07-18 16:43:50.505876
2770	Trần Phú Dây 2X1.5	tran phu day 2x1.5	m	16060	0	\N	2025-07-18 16:43:50.508978	2025-07-18 16:43:50.508978
2771	Trần Phú Dây 2X2.5	tran phu day 2x2.5	m	26400	0	\N	2025-07-18 16:43:50.510986	2025-07-18 16:43:50.510986
2772	Trần Phú Dây 2X4.0	tran phu day 2x4.0	m	39700	0	\N	2025-07-18 16:43:50.512985	2025-07-18 16:43:50.512985
2773	Trần Phú Dây 2X6.0	tran phu day 2x6.0	m	58740	0	\N	2025-07-18 16:43:50.515992	2025-07-18 16:43:50.515992
2774	Treo Hatari	treo hatari	cái	1300000	0	\N	2025-07-18 16:43:50.517971	2025-07-18 16:43:50.517971
2775	Trõ Đỏ D21	tro do d21	cái	0	0	\N	2025-07-18 16:43:50.519985	2025-07-18 16:43:50.519985
2776	Trõ Đỏ D27	tro do d27	cái	12000	0	\N	2025-07-18 16:43:50.521969	2025-07-18 16:43:50.521969
2777	Trõ Đỏ D34	tro do d34	cái	15000	0	\N	2025-07-18 16:43:50.524953	2025-07-18 16:43:50.524953
2778	Trõ Đỏ D42	tro do d42	cái	25000	0	\N	2025-07-18 16:43:50.52797	2025-07-18 16:43:50.52797
2779	Trõ Đỏ D48	tro do d48	cái	35000	0	\N	2025-07-18 16:43:50.529985	2025-07-18 16:43:50.529985
2780	Trõ Đỏ D60	tro do d60	cái	0	0	\N	2025-07-18 16:43:50.531971	2025-07-18 16:43:50.531971
2781	Trõ Đỏ D75	tro do d75	cái	65000	0	\N	2025-07-18 16:43:50.532971	2025-07-18 16:43:50.532971
2782	Trõ Đồng 20 (Ren 3/4) Minh Họa	tro dong 20 (ren 3/4) minh hoa	cái	70000	0	\N	2025-07-18 16:43:50.534971	2025-07-18 16:43:50.534971
2783	Trõ Đồng 32 Mbv (Ren 1 Ink)	tro dong 32 mbv (ren 1 ink)	cái	100000	0	\N	2025-07-18 16:43:50.537969	2025-07-18 16:43:50.537969
2784	Trỗ Đòng 40	tro dong 40	cái	150000	0	\N	2025-07-18 16:43:50.541985	2025-07-18 16:43:50.541985
2785	Trõ Đồng 40 (1X1/4) Minh Hòa	tro dong 40 (1x1/4) minh hoa	cái	150000	0	\N	2025-07-18 16:43:50.544032	2025-07-18 16:43:50.544032
2786	Trõ Ngựa 27	tro ngua 27	cái	25000	0	\N	2025-07-18 16:43:50.547033	2025-07-18 16:43:50.547033
2787	Tủ 40X60X11	tu 40x60x11	cái	350000	0	\N	2025-07-18 16:43:50.550016	2025-07-18 16:43:50.550016
2788	Tủ Át 25X35 Geneu	tu at 25x35 geneu	cái	247000	0	\N	2025-07-18 16:43:50.552033	2025-07-18 16:43:50.552033
2789	Tủ Át 40X60	tu at 40x60	cái	380000	0	\N	2025-07-18 16:43:50.554032	2025-07-18 16:43:50.554032
2790	Tủ Át Boger 12 Át	tu at boger 12 at	cái	650000	0	\N	2025-07-18 16:43:50.556032	2025-07-18 16:43:50.556032
2791	Tủ Át Shaidder	tu at shaidder	cái	210000	0	\N	2025-07-18 16:43:50.559324	2025-07-18 16:43:50.559324
2792	Tủ Cứu Hỏa	tu cuu hoa	cái	300000	0	\N	2025-07-18 16:43:50.562324	2025-07-18 16:43:50.562324
2793	Tủ Điện 16X20X10 Th	tu dien 16x20x10 th	cái	105000	0	\N	2025-07-18 16:43:50.563324	2025-07-18 16:43:50.563324
2794	Tủ Điện 20X30X10 Th	tu dien 20x30x10 th	cái	135000	0	\N	2025-07-18 16:43:50.566339	2025-07-18 16:43:50.566339
2795	Tủ Điện 20X30X15 Th	tu dien 20x30x15 th	cái	350000	0	\N	2025-07-18 16:43:50.568338	2025-07-18 16:43:50.568338
2796	Tủ Điện 21X16 Th	tu dien 21x16 th	cái	105000	0	\N	2025-07-18 16:43:50.570763	2025-07-18 16:43:50.570763
2797	Tủ Điện 25X35X10 Th	tu dien 25x35x10 th	cái	165000	0	\N	2025-07-18 16:43:50.573817	2025-07-18 16:43:50.573817
2798	Tủ Điện 25X35X15 Th	tu dien 25x35x15 th	cái	175000	0	\N	2025-07-18 16:43:50.575831	2025-07-18 16:43:50.575831
2799	Tủ Điện 30X40X10 Th	tu dien 30x40x10 th	cái	210000	0	\N	2025-07-18 16:43:50.577878	2025-07-18 16:43:50.577878
2800	Tủ Điện 30X40X15 Th	tu dien 30x40x15 th	cái	350000	0	\N	2025-07-18 16:43:50.580841	2025-07-18 16:43:50.580841
2801	Tủ Điện 40X60X10 Th	tu dien 40x60x10 th	cái	380000	0	\N	2025-07-18 16:43:50.584863	2025-07-18 16:43:50.584863
2802	Tủ Điện 60X80X25	tu dien 60x80x25	cái	680000	0	\N	2025-07-18 16:43:50.586878	2025-07-18 16:43:50.586878
2803	Tủ Điện 700X1000 Th	tu dien 700x1000 th	cái	1400000	0	\N	2025-07-18 16:43:50.589878	2025-07-18 16:43:50.589878
2804	Tủ Điện 90X70X11	tu dien 90x70x11	cái	1100000	0	\N	2025-07-18 16:43:50.592505	2025-07-18 16:43:50.592505
2805	Tủ Điện Boger	tu dien boger	cái	858000	0	\N	2025-07-18 16:43:50.595562	2025-07-18 16:43:50.595562
2806	Tủ Điện Kim Loại 24 Át Em24Plh	tu dien kim loai 24 at em24plh	cái	741000	0	\N	2025-07-18 16:43:50.596607	2025-07-18 16:43:50.596607
2807	Tủ Điện Nhựa 20X30	tu dien nhua 20x30	cái	230000	0	\N	2025-07-18 16:43:50.598621	2025-07-18 16:43:50.598621
2808	Tủ Điện Sắt 50X70X11 Th	tu dien sat 50x70x11 th	cái	580000	0	\N	2025-07-18 16:43:50.59962	2025-07-18 16:43:50.59962
2809	Tủ Điện Sắt 60X80X20	tu dien sat 60x80x20	cái	680000	0	\N	2025-07-18 16:43:50.60262	2025-07-18 16:43:50.60262
2810	Tủ Điện Th 40X60X18	tu dien th 40x60x18	cái	380000	0	\N	2025-07-18 16:43:50.605605	2025-07-18 16:43:50.605605
2811	Tủ Sắt 20X30X11 Th	tu sat 20x30x11 th	cái	145000	0	\N	2025-07-18 16:43:50.608184	2025-07-18 16:43:50.608184
2812	Tủ Sắt 20X30X15 Th	tu sat 20x30x15 th	cái	150000	0	\N	2025-07-18 16:43:50.611183	2025-07-18 16:43:50.611183
2813	Tủ Sắt 21X16 Th	tu sat 21x16 th	cái	105000	0	\N	2025-07-18 16:43:50.614151	2025-07-18 16:43:50.614151
2814	Tủ Sắt 30X40X11	tu sat 30x40x11	cái	200000	0	\N	2025-07-18 16:43:50.616167	2025-07-18 16:43:50.616167
2815	Tủ Sắt 35X45X11	tu sat 35x45x11	cái	220000	0	\N	2025-07-18 16:43:50.618169	2025-07-18 16:43:50.618169
2816	Tụ Trần 2.5 Mf	tu tran 2.5 mf	cái	15000	0	\N	2025-07-18 16:43:50.621183	2025-07-18 16:43:50.621183
2817	Túi Đồ 3 Khóa	tui do 3 khoa	cái	120000	0	\N	2025-07-18 16:43:50.623183	2025-07-18 16:43:50.623183
2818	Túi Đồ Daikin	tui do daikin	cái	200000	0	\N	2025-07-18 16:43:50.626184	2025-07-18 16:43:50.626184
2819	Tuýp 1,2 M Bn M36	tuyp 1,2 m bn m36	cái	170000	0	\N	2025-07-18 16:43:50.628174	2025-07-18 16:43:50.628174
2820	Tuýp Bán Nguyệt 60W M66 Rd	tuyp ban nguyet 60w m66 rd	cái	220000	0	\N	2025-07-18 16:43:50.631183	2025-07-18 16:43:50.631183
2821	Tuýp Bán Nguyệt M26 0.6/ 25W	tuyp ban nguyet m26 0.6/ 25w	bộ	115000	0	\N	2025-07-18 16:43:50.633183	2025-07-18 16:43:50.633183
2822	Tuýp Bn 0.6 Mét Led M36	tuyp bn 0.6 met led m36	bộ	120000	0	\N	2025-07-18 16:43:50.635183	2025-07-18 16:43:50.635183
2823	Tuýp Bn 30 Cm	tuyp bn 30 cm	bộ	75000	0	\N	2025-07-18 16:43:50.638183	2025-07-18 16:43:50.638183
2824	Ty Bon	ty bon	lọ	82000	0	\N	2025-07-18 16:43:50.640169	2025-07-18 16:43:50.640169
2825	Ty Ren 10 (3M)	ty ren 10 (3m)	cây	28500	0	\N	2025-07-18 16:43:50.642183	2025-07-18 16:43:50.642183
2826	Ty Ren 10 X 2 Mét	ty ren 10 x 2 met	cây	20000	0	\N	2025-07-18 16:43:50.64523	2025-07-18 16:43:50.64523
2827	Ty Ren 12 (2M)	ty ren 12 (2m)	cây	35000	0	\N	2025-07-18 16:43:50.64723	2025-07-18 16:43:50.64723
2828	Ty Ren 16 (2M)	ty ren 16 (2m)	cây	35000	0	\N	2025-07-18 16:43:50.650214	2025-07-18 16:43:50.650214
2829	Ty Ren 6 (2M)	ty ren 6 (2m)	cây	9000	0	\N	2025-07-18 16:43:50.652216	2025-07-18 16:43:50.652216
2830	Ty Ren 8 (2M)	ty ren 8 (2m)	cây	15000	0	\N	2025-07-18 16:43:50.65423	2025-07-18 16:43:50.65423
2831	U Bôn M6X27	u bon m6x27	cái	1000	0	\N	2025-07-18 16:43:50.65723	2025-07-18 16:43:50.65723
2832	U Bôn M8 / 90	u bon m8 / 90	cái	4500	0	\N	2025-07-18 16:43:50.659787	2025-07-18 16:43:50.659787
2833	U Bôn M8X110	u bon m8x110	cái	4300	0	\N	2025-07-18 16:43:50.660771	2025-07-18 16:43:50.660771
2834	U Bôn M8X34	u bon m8x34	cái	2300	0	\N	2025-07-18 16:43:50.663118	2025-07-18 16:43:50.663118
2835	U Bôn M8X48	u bon m8x48	cái	2500	0	\N	2025-07-18 16:43:50.66468	2025-07-18 16:43:50.66468
2836	U Bôn M8X60	u bon m8x60	cái	3000	0	\N	2025-07-18 16:43:50.666206	2025-07-18 16:43:50.666206
2837	U Bôn M8X76	u bon m8x76	cái	3500	0	\N	2025-07-18 16:43:50.670841	2025-07-18 16:43:50.670841
2838	Ủng Giản Gi	ung gian gi	cái	65000	0	\N	2025-07-18 16:43:50.672872	2025-07-18 16:43:50.672872
2839	Vam 3 Càng	vam 3 cang	cái	180000	0	\N	2025-07-18 16:43:50.674888	2025-07-18 16:43:50.674888
2840	Van 1 Chiều 15 Mbv	van 1 chieu 15 mbv	cái	35000	0	\N	2025-07-18 16:43:50.676898	2025-07-18 16:43:50.676898
2841	Van 1 Chiều 3/4	van 1 chieu 3/4	cái	60000	0	\N	2025-07-18 16:43:50.679898	2025-07-18 16:43:50.679898
2842	Van 1 Chiều 42 Mbv 1X1/4	van 1 chieu 42 mbv 1x1/4	cái	180000	0	\N	2025-07-18 16:43:50.682882	2025-07-18 16:43:50.682882
2843	Van 1 Chiều 48	van 1 chieu 48	cái	230000	0	\N	2025-07-18 16:43:50.684884	2025-07-18 16:43:50.684884
2844	Van 1 Chiều 60 (Dn 50 )	van 1 chieu 60 (dn 50 )	cái	440000	0	\N	2025-07-18 16:43:50.685884	2025-07-18 16:43:50.685884
2845	Van 1 Chiều Lá 25	van 1 chieu la 25	cái	85000	0	\N	2025-07-18 16:43:50.687898	2025-07-18 16:43:50.687898
2846	Van 1 Chiều Lò Xo 15 (1/2)	van 1 chieu lo xo 15 (1/2)	cái	50000	0	\N	2025-07-18 16:43:50.689898	2025-07-18 16:43:50.689898
2847	Van 1 Chiều Lò Xo 32	van 1 chieu lo xo 32	cái	100000	0	\N	2025-07-18 16:43:50.693518	2025-07-18 16:43:50.693518
2848	Van 1 Chiều Nl	van 1 chieu nl	cái	55000	0	\N	2025-07-18 16:43:50.696055	2025-07-18 16:43:50.696055
2849	Van 21 Bình Minh	van 21 binh minh	cái	25000	0	\N	2025-07-18 16:43:50.699123	2025-07-18 16:43:50.699123
2850	Van 21 Ngựa	van 21 ngua	cái	18000	0	\N	2025-07-18 16:43:50.701123	2025-07-18 16:43:50.701123
2851	Van 27 Bình Minh	van 27 binh minh	cái	30000	0	\N	2025-07-18 16:43:50.704123	2025-07-18 16:43:50.704123
2852	Van 27 Đỏ Taijan	van 27 do taijan	cái	25000	0	\N	2025-07-18 16:43:50.707638	2025-07-18 16:43:50.707638
2853	Van 48 Ngựa	van 48 ngua	cái	70000	0	\N	2025-07-18 16:43:50.71067	2025-07-18 16:43:50.71067
2854	Van Áp Cao	van ap cao	cái	45000	0	\N	2025-07-18 16:43:50.712672	2025-07-18 16:43:50.712672
2855	Van Áp Giếng	van ap gieng	cái	35000	0	\N	2025-07-18 16:43:50.714672	2025-07-18 16:43:50.714672
2856	Van Bi 3/4 Inox	van bi 3/4 inox	cái	60000	0	\N	2025-07-18 16:43:50.717692	2025-07-18 16:43:50.717692
2857	Van Bi Inox 15	van bi inox 15	cái	55000	0	\N	2025-07-18 16:43:50.720672	2025-07-18 16:43:50.720672
2858	Van Bình Áp	van binh ap	cái	25000	0	\N	2025-07-18 16:43:50.722685	2025-07-18 16:43:50.722685
2859	Vận Chuyển Xe Ôm	van chuyen xe om	lần	0	0	\N	2025-07-18 16:43:50.724672	2025-07-18 16:43:50.724672
2860	Van Cửa Đồng 15	van cua dong 15	cái	85000	0	\N	2025-07-18 16:43:50.727726	2025-07-18 16:43:50.727726
2861	Van Cửa Đồng 20 Mbv	van cua dong 20 mbv	cái	130000	0	\N	2025-07-18 16:43:50.730761	2025-07-18 16:43:50.730761
2862	Van Cửa Đồng 3/4 Minh Hòa Mbv	van cua dong 3/4 minh hoa mbv	cái	108000	0	\N	2025-07-18 16:43:50.732747	2025-07-18 16:43:50.732747
2863	Van Điện Từ	van dien tu	cái	250000	0	\N	2025-07-18 16:43:50.734761	2025-07-18 16:43:50.734761
2864	Van Giảm Áp	van giam ap	cái	80000	0	\N	2025-07-18 16:43:50.738726	2025-07-18 16:43:50.738726
2865	Van Hơi 1/4	van hoi 1/4	cái	30000	0	\N	2025-07-18 16:43:50.741745	2025-07-18 16:43:50.741745
2866	Van Lò Xo D15	van lo xo d15	cái	39000	0	\N	2025-07-18 16:43:50.743777	2025-07-18 16:43:50.743777
2867	Van Lo Xo D20	van lo xo d20	cái	70000	0	\N	2025-07-18 16:43:50.745791	2025-07-18 16:43:50.745791
2868	Van Nơ 15 Mbv	van no 15 mbv	cái	65000	0	\N	2025-07-18 16:43:50.748777	2025-07-18 16:43:50.748777
2869	Van Nơ 3/4 Mbv	van no 3/4 mbv	cái	70000	0	\N	2025-07-18 16:43:50.750777	2025-07-18 16:43:50.750777
2870	Van Pvc 90 Ngựa	van pvc 90 ngua	cái	300000	0	\N	2025-07-18 16:43:50.751775	2025-07-18 16:43:50.751775
2871	Van Pvc D21	van pvc d21	cái	18000	0	\N	2025-07-18 16:43:50.753777	2025-07-18 16:43:50.753777
2872	Van Pvc D27 Ngựa	van pvc d27 ngua	cái	25000	0	\N	2025-07-18 16:43:50.755791	2025-07-18 16:43:50.755791
2873	Van Pvc D34	van pvc d34	cái	30000	0	\N	2025-07-18 16:43:50.757791	2025-07-18 16:43:50.757791
2874	Van Pvc D42	van pvc d42	cái	50000	0	\N	2025-07-18 16:43:50.76092	2025-07-18 16:43:50.76092
2875	Van Pvc D48	van pvc d48	cái	70000	0	\N	2025-07-18 16:43:50.762905	2025-07-18 16:43:50.762905
2876	Van Pvc D60	van pvc d60	cái	90000	0	\N	2025-07-18 16:43:50.764918	2025-07-18 16:43:50.764918
2877	Van Pvc D75	van pvc d75	cái	0	0	\N	2025-07-18 16:43:50.767919	2025-07-18 16:43:50.767919
2878	Vặn Ren Ngược	van ren nguoc	cái	40000	0	\N	2025-07-18 16:43:50.769918	2025-07-18 16:43:50.769918
2879	Van Tiểu Nam R	van tieu nam r	cái	120000	0	\N	2025-07-18 16:43:50.773011	2025-07-18 16:43:50.773011
2880	Vắt Khăn Dàn M	vat khan dan m	cái	300000	0	\N	2025-07-18 16:43:50.775056	2025-07-18 16:43:50.775056
2881	Vắt Khăn Đôi	vat khan doi	cái	110000	0	\N	2025-07-18 16:43:50.777117	2025-07-18 16:43:50.777117
2882	Vắt Khăn Đôi Toda	vat khan doi toda	cái	260000	0	\N	2025-07-18 16:43:50.779117	2025-07-18 16:43:50.779117
2883	Vắt Khăn Đơn Đm	vat khan don dm	cái	100000	0	\N	2025-07-18 16:43:50.782129	2025-07-18 16:43:50.782129
2884	Vắt Khăn Đơn Toda	vat khan don toda	cái	250000	0	\N	2025-07-18 16:43:50.784103	2025-07-18 16:43:50.784103
2885	Vb Ppr Chánh 20	vb ppr chanh 20	cái	18000	0	\N	2025-07-18 16:43:50.785103	2025-07-18 16:43:50.785103
2886	Vb Ppr Chánh 25	vb ppr chanh 25	cái	30000	0	\N	2025-07-18 16:43:50.788089	2025-07-18 16:43:50.788089
2887	Vb Ppr Chếch 20	vb ppr chech 20	cái	6800	0	\N	2025-07-18 16:43:50.791609	2025-07-18 16:43:50.791609
2888	Vb Ppr Chếch 25	vb ppr chech 25	cái	10200	0	\N	2025-07-18 16:43:50.794705	2025-07-18 16:43:50.794705
2889	Vb Ppr Chếch 32	vb ppr chech 32	cái	16600	0	\N	2025-07-18 16:43:50.796697	2025-07-18 16:43:50.796697
2890	Vb Ppr Chếch 40	vb ppr chech 40	cái	32100	0	\N	2025-07-18 16:43:50.798699	2025-07-18 16:43:50.798699
2891	Vb Ppr Chếch 50	vb ppr chech 50	cái	61400	0	\N	2025-07-18 16:43:50.800699	2025-07-18 16:43:50.800699
2892	Vb Ppr Côn Thu 40/20	vb ppr con thu 40/20	cái	9200	0	\N	2025-07-18 16:43:50.803699	2025-07-18 16:43:50.803699
2893	Vb Ppr Côn Thu 50/20	vb ppr con thu 50/20	cái	21300	0	\N	2025-07-18 16:43:50.807068	2025-07-18 16:43:50.807068
2894	Vb Ppr Côn Thu Trực Tiếp 25/20	vb ppr con thu truc tiep 25/20	cái	7300	0	\N	2025-07-18 16:43:50.810619	2025-07-18 16:43:50.810619
2895	Vb Ppr Côn Thu Trực Tiếp 32/20	vb ppr con thu truc tiep 32/20	cái	10700	0	\N	2025-07-18 16:43:50.812605	2025-07-18 16:43:50.812605
2896	Vb Ppr Côn Thu Trực Tiếp 32/25	vb ppr con thu truc tiep 32/25	cái	11600	0	\N	2025-07-18 16:43:50.814702	2025-07-18 16:43:50.814702
2897	Vb Ppr Côn Thu Trực Tiếp 40/25	vb ppr con thu truc tiep 40/25	cái	17500	0	\N	2025-07-18 16:43:50.818787	2025-07-18 16:43:50.818787
2898	Vb Ppr Côn Thu Trực Tiếp 40/32	vb ppr con thu truc tiep 40/32	cái	19200	0	\N	2025-07-18 16:43:50.81984	2025-07-18 16:43:50.81984
2899	Vb Ppr Côn Thu Trực Tiếp 50/25	vb ppr con thu truc tiep 50/25	cái	27700	0	\N	2025-07-18 16:43:50.822899	2025-07-18 16:43:50.822899
2900	Vb Ppr Côn Thu Trực Tiếp 50/32	vb ppr con thu truc tiep 50/32	cái	28100	0	\N	2025-07-18 16:43:50.824899	2025-07-18 16:43:50.824899
2901	Vb Ppr Côn Thu Trực Tiếp 50/40	vb ppr con thu truc tiep 50/40	cái	29600	0	\N	2025-07-18 16:43:50.827885	2025-07-18 16:43:50.827885
2902	Vb Ppr Cút 20	vb ppr cut 20	cái	7800	0	\N	2025-07-18 16:43:50.829899	2025-07-18 16:43:50.829899
2903	Vb Ppr Cút 25	vb ppr cut 25	cái	12500	0	\N	2025-07-18 16:43:50.832889	2025-07-18 16:43:50.832889
2904	Vb Ppr Cút 25 Chống Uv	vb ppr cut 25 chong uv	cái	17000	0	\N	2025-07-18 16:43:50.834899	2025-07-18 16:43:50.834899
2905	Vb Ppr Cút 32	vb ppr cut 32	cái	19300	0	\N	2025-07-18 16:43:50.836899	2025-07-18 16:43:50.836899
2906	Vb Ppr Cút 32 Chống Uv	vb ppr cut 32 chong uv	cái	26800	0	\N	2025-07-18 16:43:50.839885	2025-07-18 16:43:50.839885
2907	Vb Ppr Cút 40	vb ppr cut 40	cái	30900	0	\N	2025-07-18 16:43:50.841883	2025-07-18 16:43:50.841883
2908	Vb Ppr Cút 50	vb ppr cut 50	cái	56800	0	\N	2025-07-18 16:43:50.843909	2025-07-18 16:43:50.843909
2909	Vb Ppr Cút Rn 20X1/2"	vb ppr cut rn 20x1/2"	cái	95600	0	\N	2025-07-18 16:43:50.846909	2025-07-18 16:43:50.846909
2910	Vb Ppr Cút Rn 25X1/2"	vb ppr cut rn 25x1/2"	cái	98600	0	\N	2025-07-18 16:43:50.848909	2025-07-18 16:43:50.848909
2911	Vb Ppr Cút Rn 25X3/4"	vb ppr cut rn 25x3/4"	cái	149100	0	\N	2025-07-18 16:43:50.85191	2025-07-18 16:43:50.85191
2912	Vb Ppr Cút Rt 20X1/2"	vb ppr cut rt 20x1/2"	cái	62200	0	\N	2025-07-18 16:43:50.853909	2025-07-18 16:43:50.853909
2913	Vb Ppr Cút Rt 25X1/2"	vb ppr cut rt 25x1/2"	cái	67800	0	\N	2025-07-18 16:43:50.856895	2025-07-18 16:43:50.856895
2914	Vb Ppr Cút Rt 25X3/4"	vb ppr cut rt 25x3/4"	cái	84700	0	\N	2025-07-18 16:43:50.859476	2025-07-18 16:43:50.859476
2915	Vb Ppr Măng Sông 20	vb ppr mang song 20	cái	5700	0	\N	2025-07-18 16:43:50.861474	2025-07-18 16:43:50.861474
2916	Vb Ppr Măng Sông 25	vb ppr mang song 25	cái	8300	0	\N	2025-07-18 16:43:50.86349	2025-07-18 16:43:50.86349
2917	Vb Ppr Măng Sông 25 Chống Uv	vb ppr mang song 25 chong uv	cái	12100	0	\N	2025-07-18 16:43:50.86549	2025-07-18 16:43:50.86549
2918	Vb Ppr Măng Sông 32	vb ppr mang song 32	cái	12500	0	\N	2025-07-18 16:43:50.86849	2025-07-18 16:43:50.86849
2919	Vb Ppr Măng Sông 32 Chống Uv	vb ppr mang song 32 chong uv	cái	17200	0	\N	2025-07-18 16:43:50.871476	2025-07-18 16:43:50.871476
2920	Vb Ppr Măng Sông 40	vb ppr mang song 40	cái	19200	0	\N	2025-07-18 16:43:50.875474	2025-07-18 16:43:50.875474
2921	Vb Ppr Măng Sông 50	vb ppr mang song 50	cái	34100	0	\N	2025-07-18 16:43:50.877537	2025-07-18 16:43:50.877537
2922	Vb Ppr Msrn 20X1/2"	vb ppr msrn 20x1/2"	cái	91800	0	\N	2025-07-18 16:43:50.880537	2025-07-18 16:43:50.880537
2923	Vb Ppr Msrn 25X1/2"	vb ppr msrn 25x1/2"	cái	93600	0	\N	2025-07-18 16:43:50.883274	2025-07-18 16:43:50.883274
2924	Vb Ppr Msrn 25X3/4"	vb ppr msrn 25x3/4"	cái	140400	0	\N	2025-07-18 16:43:50.888313	2025-07-18 16:43:50.888313
2925	Vb Ppr Msrn 32X1"	vb ppr msrn 32x1"	cái	264800	0	\N	2025-07-18 16:43:50.889324	2025-07-18 16:43:50.889324
2926	Vb Ppr Msrn 40X11/4"	vb ppr msrn 40x11/4"	cái	418400	0	\N	2025-07-18 16:43:50.892461	2025-07-18 16:43:50.892461
2927	Vb Ppr Msrn 50X11/2"	vb ppr msrn 50x11/2"	cái	497600	0	\N	2025-07-18 16:43:50.895539	2025-07-18 16:43:50.895539
2928	Vb Ppr Msrt 20X1/2"	vb ppr msrt 20x1/2"	cái	58300	0	\N	2025-07-18 16:43:50.897525	2025-07-18 16:43:50.897525
2929	Vb Ppr Msrt 25X1/2"	vb ppr msrt 25x1/2"	cái	66400	0	\N	2025-07-18 16:43:50.899539	2025-07-18 16:43:50.899539
2930	Vb Ppr Msrt 25X3/4"	vb ppr msrt 25x3/4"	cái	77800	0	\N	2025-07-18 16:43:50.901539	2025-07-18 16:43:50.901539
2931	Vb Ppr Msrt 32X1"	vb ppr msrt 32x1"	cái	215300	0	\N	2025-07-18 16:43:50.904539	2025-07-18 16:43:50.904539
2932	Vb Ppr Msrt 40X11/4"	vb ppr msrt 40x11/4"	cái	334200	0	\N	2025-07-18 16:43:50.906525	2025-07-18 16:43:50.906525
2933	Vb Ppr Msrt 50X11/2"	vb ppr msrt 50x11/2"	cái	392900	0	\N	2025-07-18 16:43:50.907525	2025-07-18 16:43:50.907525
2934	Vb Ppr Nóng 25 Chống Uv	vb ppr nong 25 chong uv	m	96200	0	\N	2025-07-18 16:43:50.909035	2025-07-18 16:43:50.909035
2935	Vb Ppr Nóng 32 Chống Uv	vb ppr nong 32 chong uv	m	155500	0	\N	2025-07-18 16:43:50.911081	2025-07-18 16:43:50.911081
2936	Vb Ppr Nút Bịt 20	vb ppr nut bit 20	cái	4900	0	\N	2025-07-18 16:43:50.914081	2025-07-18 16:43:50.914081
2937	Vb Ppr Nút Bịt 25	vb ppr nut bit 25	cái	6400	0	\N	2025-07-18 16:43:50.917067	2025-07-18 16:43:50.917067
2938	Vb Ppr Nút Bịt 32	vb ppr nut bit 32	cái	10500	0	\N	2025-07-18 16:43:50.919263	2025-07-18 16:43:50.919263
2939	Vb Ppr Nút Bịt 40	vb ppr nut bit 40	cái	18500	0	\N	2025-07-18 16:43:50.921808	2025-07-18 16:43:50.921808
2940	Vb Ppr Nút Bịt 50	vb ppr nut bit 50	cái	30800	0	\N	2025-07-18 16:43:50.924858	2025-07-18 16:43:50.924858
2941	Vb Ppr Ống Lạnh D20	vb ppr ong lanh d20	m	31900	0	\N	2025-07-18 16:43:50.926858	2025-07-18 16:43:50.926858
2942	Vb Ppr Ống Lạnh D25	vb ppr ong lanh d25	m	50600	0	\N	2025-07-18 16:43:50.929843	2025-07-18 16:43:50.929843
2943	Vb Ppr Ống Lạnh D32	vb ppr ong lanh d32	m	70900	0	\N	2025-07-18 16:43:50.931844	2025-07-18 16:43:50.931844
2944	Vb Ppr Ống Lạnh D40	vb ppr ong lanh d40	m	112400	0	\N	2025-07-18 16:43:50.932844	2025-07-18 16:43:50.932844
2945	Vb Ppr Ống Lạnh D50	vb ppr ong lanh d50	m	171800	0	\N	2025-07-18 16:43:50.935859	2025-07-18 16:43:50.935859
2946	Vb Ppr Ống Nóng D20	vb ppr ong nong d20	m	45500	0	\N	2025-07-18 16:43:50.937858	2025-07-18 16:43:50.937858
2947	Vb Ppr Ống Nóng D25	vb ppr ong nong d25	m	70900	0	\N	2025-07-18 16:43:50.940842	2025-07-18 16:43:50.940842
2948	Vb Ppr Ống Nóng D32	vb ppr ong nong d32	m	112300	0	\N	2025-07-18 16:43:50.942858	2025-07-18 16:43:50.942858
2949	Vb Ppr Ống Nóng D40	vb ppr ong nong d40	m	177200	0	\N	2025-07-18 16:43:50.94489	2025-07-18 16:43:50.94489
2950	Vb Ppr Ống Nóng D50	vb ppr ong nong d50	m	269300	0	\N	2025-07-18 16:43:50.948317	2025-07-18 16:43:50.948317
2951	Vb Ppr Rắc Co Nhựa 20	vb ppr rac co nhua 20	cái	84000	0	\N	2025-07-18 16:43:50.951078	2025-07-18 16:43:50.951078
2952	Vb Ppr Rắc Co Nhựa 25	vb ppr rac co nhua 25	cái	125800	0	\N	2025-07-18 16:43:50.953128	2025-07-18 16:43:50.953128
2953	Vb Ppr Rắc Co Nhựa 32	vb ppr rac co nhua 32	cái	184800	0	\N	2025-07-18 16:43:50.956128	2025-07-18 16:43:50.956128
2954	Vb Ppr Rắc Co Nhựa 40	vb ppr rac co nhua 40	cái	294000	0	\N	2025-07-18 16:43:50.958659	2025-07-18 16:43:50.958659
2955	Vb Ppr Rắc Co Nhựa 50	vb ppr rac co nhua 50	cái	472000	0	\N	2025-07-18 16:43:50.960795	2025-07-18 16:43:50.960795
2956	Vb Ppr Rắc Co Rn 20X1/2"	vb ppr rac co rn 20x1/2"	cái	169100	0	\N	2025-07-18 16:43:50.963796	2025-07-18 16:43:50.963796
2957	Vb Ppr Rắc Co Rn 25X3/4"	vb ppr rac co rn 25x3/4"	cái	285300	0	\N	2025-07-18 16:43:50.965781	2025-07-18 16:43:50.965781
2958	Vb Ppr Rắc Co Rn 32X1"	vb ppr rac co rn 32x1"	cái	348000	0	\N	2025-07-18 16:43:50.967781	2025-07-18 16:43:50.967781
2959	Vb Ppr Rắc Co Rn 40X11/4"	vb ppr rac co rn 40x11/4"	cái	491300	0	\N	2025-07-18 16:43:50.968781	2025-07-18 16:43:50.968781
2960	Vb Ppr Rắc Co Rn 50X11/2"	vb ppr rac co rn 50x11/2"	cái	947700	0	\N	2025-07-18 16:43:50.971779	2025-07-18 16:43:50.971779
2961	Vb Ppr Rắc Co Rt 20X1/2"	vb ppr rac co rt 20x1/2"	cái	153500	0	\N	2025-07-18 16:43:50.973781	2025-07-18 16:43:50.973781
2962	Vb Ppr Rắc Co Rt 25X3/4"	vb ppr rac co rt 25x3/4"	cái	226300	0	\N	2025-07-18 16:43:50.976794	2025-07-18 16:43:50.976794
2963	Vb Ppr Rắc Co Rt 32X1"	vb ppr rac co rt 32x1"	cái	311700	0	\N	2025-07-18 16:43:50.978842	2025-07-18 16:43:50.978842
2964	Vb Ppr Rắc Co Rt 40X11/4"	vb ppr rac co rt 40x11/4"	cái	474900	0	\N	2025-07-18 16:43:50.980826	2025-07-18 16:43:50.980826
2965	Vb Ppr Tê 20	vb ppr te 20	cái	9500	0	\N	2025-07-18 16:43:50.982826	2025-07-18 16:43:50.982826
2966	Vb Ppr Tê 25	vb ppr te 25	cái	17000	0	\N	2025-07-18 16:43:50.984826	2025-07-18 16:43:50.984826
2967	Vb Ppr Tê 25 Chống Uv	vb ppr te 25 chong uv	cái	24100	0	\N	2025-07-18 16:43:50.98684	2025-07-18 16:43:50.98684
2968	Vb Ppr Tê 32	vb ppr te 32	cái	25400	0	\N	2025-07-18 16:43:50.989841	2025-07-18 16:43:50.989841
2969	Vb Ppr Tê 40	vb ppr te 40	cái	42500	0	\N	2025-07-18 16:43:50.992366	2025-07-18 16:43:50.992366
2970	Vb Ppr Tê 50	vb ppr te 50	cái	74400	0	\N	2025-07-18 16:43:50.995454	2025-07-18 16:43:50.995454
2971	Vb Ppr Tê Rt 20X1/2"	vb ppr te rt 20x1/2"	cái	64900	0	\N	2025-07-18 16:43:50.997455	2025-07-18 16:43:50.997455
2972	Vb Ppr Tê Rt 25X1/2"	vb ppr te rt 25x1/2"	cái	66500	0	\N	2025-07-18 16:43:50.999456	2025-07-18 16:43:50.999456
2973	Vb Ppr Tê Thu 25/20	vb ppr te thu 25/20	cái	15500	0	\N	2025-07-18 16:43:51.001469	2025-07-18 16:43:51.001469
2974	Vb Ppr Tê Thu 32/20	vb ppr te thu 32/20	cái	25700	0	\N	2025-07-18 16:43:51.004456	2025-07-18 16:43:51.004456
2975	Vb Ppr Tê Thu 32/25	vb ppr te thu 32/25	cái	26800	0	\N	2025-07-18 16:43:51.00747	2025-07-18 16:43:51.00747
2976	Vb Ppr Tê Thu 40/20	vb ppr te thu 40/20	cái	47100	0	\N	2025-07-18 16:43:51.009001	2025-07-18 16:43:51.009001
2977	Vb Ppr Tê Thu 40/25	vb ppr te thu 40/25	cái	47100	0	\N	2025-07-18 16:43:51.011035	2025-07-18 16:43:51.011035
2978	Vb Ppr Tê Thu 40/32	vb ppr te thu 40/32	cái	47100	0	\N	2025-07-18 16:43:51.012035	2025-07-18 16:43:51.012035
2979	Vb Ppr Tê Thu 50/20	vb ppr te thu 50/20	cái	75600	0	\N	2025-07-18 16:43:51.014035	2025-07-18 16:43:51.014035
2980	Vb Ppr Tê Thu 50/25	vb ppr te thu 50/25	cái	75600	0	\N	2025-07-18 16:43:51.017491	2025-07-18 16:43:51.017491
2981	Vb Ppr Tê Thu 50/32	vb ppr te thu 50/32	cái	75600	0	\N	2025-07-18 16:43:51.02005	2025-07-18 16:43:51.02005
2982	Vb Ppr Tê Thu 50/40	vb ppr te thu 50/40	cái	84900	0	\N	2025-07-18 16:43:51.022043	2025-07-18 16:43:51.022043
2983	Vb Ppr Van Cửa Mở 100% D20	vb ppr van cua mo 100% d20	cái	348500	0	\N	2025-07-18 16:43:51.024044	2025-07-18 16:43:51.024044
2984	Vb Ppr Van Cửa Mở 100% D25	vb ppr van cua mo 100% d25	cái	429800	0	\N	2025-07-18 16:43:51.027329	2025-07-18 16:43:51.027329
2985	Vb Ppr Van Cửa Mở 100% D32	vb ppr van cua mo 100% d32	cái	563000	0	\N	2025-07-18 16:43:51.030345	2025-07-18 16:43:51.030345
2986	Vb Ppr Van Cửa Mở 100% D40	vb ppr van cua mo 100% d40	cái	962300	0	\N	2025-07-18 16:43:51.032344	2025-07-18 16:43:51.032344
2987	Vb Ppr Van Cửa Mở 100% D50	vb ppr van cua mo 100% d50	cái	1385100	0	\N	2025-07-18 16:43:51.035345	2025-07-18 16:43:51.035345
2988	Ven Cáp 110 - 201	ven cap 110 - 201	cái	80000	0	\N	2025-07-18 16:43:51.037334	2025-07-18 16:43:51.037334
2989	Ven Cáp 110 /304	ven cap 110 /304	cái	125000	0	\N	2025-07-18 16:43:51.040329	2025-07-18 16:43:51.040329
2990	Ven Cáp 140	ven cap 140	cái	160000	0	\N	2025-07-18 16:43:51.041331	2025-07-18 16:43:51.041331
2991	Ven Cáp 304 D90	ven cap 304 d90	cái	110000	0	\N	2025-07-18 16:43:51.04333	2025-07-18 16:43:51.04333
2992	Ven Cáp 76	ven cap 76	cái	110000	0	\N	2025-07-18 16:43:51.04433	2025-07-18 16:43:51.04433
2993	Vít + Nở Combo	vit + no combo	cái	0	0	\N	2025-07-18 16:43:51.046376	2025-07-18 16:43:51.046376
2994	Vít + Nở Nhựa 6	vit + no nhua 6	bộ	1000	0	\N	2025-07-18 16:43:51.050366	2025-07-18 16:43:51.050366
2995	Vít 2 Ren Mịn Tk	vit 2 ren min tk	gói	145000	0	\N	2025-07-18 16:43:51.05236	2025-07-18 16:43:51.05236
2996	Vít 3 Béo (5X3)	vit 3 beo (5x3)	kg	40000	0	\N	2025-07-18 16:43:51.055376	2025-07-18 16:43:51.055376
2997	Vít 8 + Nở 8	vit 8 + no 8	bộ	1000	0	\N	2025-07-18 16:43:51.05836	2025-07-18 16:43:51.05836
2998	Vít Bắt Mặt M4	vit bat mat m4	kg	50000	0	\N	2025-07-18 16:43:51.060902	2025-07-18 16:43:51.060902
2999	Vít Cn 10X10 Inox	vit cn 10x10 inox	gói	80000	0	\N	2025-07-18 16:43:51.063916	2025-07-18 16:43:51.063916
3000	Vít Cửa Nhựa 10X10	vit cua nhua 10x10	gói	35000	0	\N	2025-07-18 16:43:51.066902	2025-07-18 16:43:51.066902
3001	Vít Cửa Nhựa 10X10 Inox	vit cua nhua 10x10 inox	gói	75000	0	\N	2025-07-18 16:43:51.068916	2025-07-18 16:43:51.068916
3002	Vít Cửa Nhựa Inox 8X8	vit cua nhua inox 8x8	gói	50000	0	\N	2025-07-18 16:43:51.071902	2025-07-18 16:43:51.071902
3003	Vít Đen 2.5 Cm	vit den 2.5 cm	gói	50000	0	\N	2025-07-18 16:43:51.072902	2025-07-18 16:43:51.072902
3004	Vít Đen 3 Cm	vit den 3 cm	gói	50000	0	\N	2025-07-18 16:43:51.074902	2025-07-18 16:43:51.074902
3005	Vít Đen 4 Cm	vit den 4 cm	gói	50000	0	\N	2025-07-18 16:43:51.076916	2025-07-18 16:43:51.076916
3006	Vít Dù 1,3 Cm	vit du 1,3 cm	kg	70000	0	\N	2025-07-18 16:43:51.079963	2025-07-18 16:43:51.079963
3007	Vít Dù Inox 1.3	vit du inox 1.3	hộp	80000	0	\N	2025-07-18 16:43:51.082949	2025-07-18 16:43:51.082949
3008	Vít Dù Tk 3 Cm	vit du tk 3 cm	gói	150000	0	\N	2025-07-18 16:43:51.085964	2025-07-18 16:43:51.085964
3009	Vít Giác 16	vit giac 16	kg	35000	0	\N	2025-07-18 16:43:51.086949	2025-07-18 16:43:51.086949
3010	Vít Giác 8X6	vit giac 8x6	kg	35000	0	\N	2025-07-18 16:43:51.088949	2025-07-18 16:43:51.088949
3011	Vít Giác 8X8	vit giac 8x8	kg	35000	0	\N	2025-07-18 16:43:51.090962	2025-07-18 16:43:51.090962
3012	Vít Gỗ 7 Cm	vit go 7 cm	gói	55000	0	\N	2025-07-18 16:43:51.094524	2025-07-18 16:43:51.094524
3013	Vít Inox 4X3	vit inox 4x3	kg	100000	0	\N	2025-07-18 16:43:51.09657	2025-07-18 16:43:51.09657
3014	Vít Inox 5X3	vit inox 5x3	kg	100000	0	\N	2025-07-18 16:43:51.09857	2025-07-18 16:43:51.09857
3015	Vít Inox 5X3 Cm	vit inox 5x3 cm	kg	100000	0	\N	2025-07-18 16:43:51.10157	2025-07-18 16:43:51.10157
3016	Vít Inox 5X4	vit inox 5x4	kg	100000	0	\N	2025-07-18 16:43:51.10357	2025-07-18 16:43:51.10357
3017	Vít Khuyên 8X6	vit khuyen 8x6	kg	43000	0	\N	2025-07-18 16:43:51.105823	2025-07-18 16:43:51.105823
3020	Vít Mạ 6,8,10	vit ma 6,8,10	kg	40000	0	\N	2025-07-18 16:43:51.112736	2025-07-18 16:43:51.112736
3021	Vít Mạ 6X5	vit ma 6x5	kg	40000	0	\N	2025-07-18 16:43:51.115784	2025-07-18 16:43:51.115784
3022	Vít Mạ 6X6	vit ma 6x6	kg	40000	0	\N	2025-07-18 16:43:51.117769	2025-07-18 16:43:51.117769
3023	Vít Móc L + Nở 16	vit moc l + no 16	bộ	5000	0	\N	2025-07-18 16:43:51.118769	2025-07-18 16:43:51.118769
3024	Vít Móc Màn	vit moc man	kg	50000	0	\N	2025-07-18 16:43:51.120783	2025-07-18 16:43:51.120783
3025	Vít Ren Mịn 4 F	vit ren min 4 f	gói	230000	0	\N	2025-07-18 16:43:51.123783	2025-07-18 16:43:51.123783
3026	Vít Ren Mịn 5 F Trắng	vit ren min 5 f trang	gói	230000	0	\N	2025-07-18 16:43:51.126769	2025-07-18 16:43:51.126769
3027	Vít Thạch Cao	vit thach cao	cái	2000	0	\N	2025-07-18 16:43:51.128783	2025-07-18 16:43:51.128783
3028	Vít Tk Chìm 2.5 Cm	vit tk chim 2.5 cm	gói	90000	0	\N	2025-07-18 16:43:51.130769	2025-07-18 16:43:51.130769
3029	Vít Tk Chìm 3 Ren Mịn	vit tk chim 3 ren min	gói	225000	0	\N	2025-07-18 16:43:51.131769	2025-07-18 16:43:51.131769
3030	Vít Tk Chìm 4	vit tk chim 4	gói	125000	0	\N	2025-07-18 16:43:51.133769	2025-07-18 16:43:51.133769
3031	Vít Tôn	vit ton	kg	90000	0	\N	2025-07-18 16:43:51.135783	2025-07-18 16:43:51.135783
3032	Vít Tôn 3	vit ton 3	gói	70000	0	\N	2025-07-18 16:43:51.13875	2025-07-18 16:43:51.13875
3033	Vít Tôn 4	vit ton 4	gói	87000	0	\N	2025-07-18 16:43:51.141783	2025-07-18 16:43:51.141783
3034	Vít Tôn 5	vit ton 5	gói	97000	0	\N	2025-07-18 16:43:51.144785	2025-07-18 16:43:51.144785
3035	Vít Tôn 6	vit ton 6	gói	120000	0	\N	2025-07-18 16:43:51.146832	2025-07-18 16:43:51.146832
3036	Vít Tôn 7	vit ton 7	gói	145000	0	\N	2025-07-18 16:43:51.149818	2025-07-18 16:43:51.149818
3037	Vít Tự Khoan	vit tu khoan	kg	70000	0	\N	2025-07-18 16:43:51.152817	2025-07-18 16:43:51.152817
3038	Vít Tự Khoan Chìm 2 Cm	vit tu khoan chim 2 cm	gói	85000	0	\N	2025-07-18 16:43:51.155819	2025-07-18 16:43:51.155819
3039	Vít Tự Khoan Chìm 3 Cm	vit tu khoan chim 3 cm	gói	130000	0	\N	2025-07-18 16:43:51.157833	2025-07-18 16:43:51.157833
3040	Vít Tự Khoan Dù 1.3 Cm	vit tu khoan du 1.3 cm	kg	70000	0	\N	2025-07-18 16:43:51.161061	2025-07-18 16:43:51.161061
3041	Vít Tự Khoan Dù 2 Cm	vit tu khoan du 2 cm	gói	110000	0	\N	2025-07-18 16:43:51.164059	2025-07-18 16:43:51.164059
3042	Vít Tự Khoan Dù 3	vit tu khoan du 3	kg	70000	0	\N	2025-07-18 16:43:51.16706	2025-07-18 16:43:51.16706
3043	Vít Tự Khoan Inox 2 Cm	vit tu khoan inox 2 cm	kg	80000	0	\N	2025-07-18 16:43:51.170074	2025-07-18 16:43:51.170074
3044	Vít Tự Khoan Vàng	vit tu khoan vang	gói	150000	0	\N	2025-07-18 16:43:51.17306	2025-07-18 16:43:51.17306
3045	Vít Vàng	vit vang	gói	40000	0	\N	2025-07-18 16:43:51.174058	2025-07-18 16:43:51.174058
3046	Vít Vàng 2	vit vang 2	kg	50000	0	\N	2025-07-18 16:43:51.177075	2025-07-18 16:43:51.177075
3047	Vít Vàng 2,5 Cm	vit vang 2,5 cm	kg	55000	0	\N	2025-07-18 16:43:51.179122	2025-07-18 16:43:51.179122
3048	Vít Vàng 3 Cm	vit vang 3 cm	kg	50000	0	\N	2025-07-18 16:43:51.181122	2025-07-18 16:43:51.181122
3049	Vít Vàng 4	vit vang 4	kg	50000	0	\N	2025-07-18 16:43:51.185097	2025-07-18 16:43:51.185097
3050	Vít Vàng 6Cm	vit vang 6cm	kg	55000	0	\N	2025-07-18 16:43:51.188108	2025-07-18 16:43:51.188108
3051	Vít Vàng 7	vit vang 7	gói	50000	0	\N	2025-07-18 16:43:51.190122	2025-07-18 16:43:51.190122
3052	Vít+Nở	vit+no	kg	50000	0	\N	2025-07-18 16:43:51.192645	2025-07-18 16:43:51.192645
3053	Vn 1 Chiều Lò Xo Mbv 25	vn 1 chieu lo xo mbv 25	cái	99800	0	\N	2025-07-18 16:43:51.195724	2025-07-18 16:43:51.195724
3054	Vỏ Át	vo at	cái	15000	0	\N	2025-07-18 16:43:51.197727	2025-07-18 16:43:51.197727
3055	Vỏ Át Nổi Genei Chó Át Cài	vo at noi genei cho at cai	cái	15000	0	\N	2025-07-18 16:43:51.199726	2025-07-18 16:43:51.199726
3056	Vỏ Đồng Hồ Inox	vo dong ho inox	cái	120000	0	\N	2025-07-18 16:43:51.201726	2025-07-18 16:43:51.201726
3057	Vòi 15 Kẽm Minh Hòa	voi 15 kem minh hoa	cái	40000	0	\N	2025-07-18 16:43:51.20374	2025-07-18 16:43:51.20374
3058	Vòi Bếp Đa Năng Linax 1013 Sx	voi bep da nang linax 1013 sx	cái	3500000	0	\N	2025-07-18 16:43:51.205726	2025-07-18 16:43:51.205726
3059	Vòi Châu 1 Lỗ	voi chau 1 lo	cái	350000	0	\N	2025-07-18 16:43:51.207726	2025-07-18 16:43:51.207726
3060	Vòi Chậu Lạnh	voi chau lanh	cái	125000	0	\N	2025-07-18 16:43:51.208724	2025-07-18 16:43:51.208724
3061	Vòi Chậu Rửa Bát Nl 304	voi chau rua bat nl 304	cái	350000	0	\N	2025-07-18 16:43:51.213713	2025-07-18 16:43:51.213713
3062	Vòi Chậu Rửa Mặt 3 Lỗ Trung	voi chau rua mat 3 lo trung	cái	500000	0	\N	2025-07-18 16:43:51.215696	2025-07-18 16:43:51.215696
3063	Vòi Chậu Rửa Mặt Kasung 301	voi chau rua mat kasung 301	bộ	550000	0	\N	2025-07-18 16:43:51.217692	2025-07-18 16:43:51.217692
3064	Vòi Chậu Rửa Mặt Kasung 501	voi chau rua mat kasung 501	bộ	600000	0	\N	2025-07-18 16:43:51.220713	2025-07-18 16:43:51.220713
3065	Vòi Chậu Rửa Mặt Nóng Lạnh Paznaa	voi chau rua mat nong lanh paznaa	bộ	400000	0	\N	2025-07-18 16:43:51.223714	2025-07-18 16:43:51.223714
3066	Vòi Chậu Rửa Mặt Nóng Lạnh Vg132	voi chau rua mat nong lanh vg132	cái	960000	0	\N	2025-07-18 16:43:51.226715	2025-07-18 16:43:51.226715
3067	Vòi Chậu Rửa Mặt Nóng Lạnh Vg132.1	voi chau rua mat nong lanh vg132.1	cái	1650000	0	\N	2025-07-18 16:43:51.230198	2025-07-18 16:43:51.230198
3068	Vòi Chậu Rút Senta Ss122	voi chau rut senta ss122	cái	1750000	0	\N	2025-07-18 16:43:51.233288	2025-07-18 16:43:51.233288
3069	Vòi Chậu Sen Ta 109 Rửa Bát	voi chau sen ta 109 rua bat	cái	1150000	0	\N	2025-07-18 16:43:51.235428	2025-07-18 16:43:51.235428
3070	Vòi Chậu Sen Ta 110	voi chau sen ta 110	cái	950000	0	\N	2025-07-18 16:43:51.23843	2025-07-18 16:43:51.23843
3071	Vòi Đầm 635	voi dam 635	cái	900000	0	\N	2025-07-18 16:43:51.240982	2025-07-18 16:43:51.240982
3072	Vòi Đầm Be	voi dam be	cái	680000	0	\N	2025-07-18 16:43:51.242991	2025-07-18 16:43:51.242991
3073	Voi Đầm To	voi dam to	cái	750000	0	\N	2025-07-18 16:43:51.244404	2025-07-18 16:43:51.244404
3074	Vòi Gạt 15 Ana Thái	voi gat 15 ana thai	cái	115000	0	\N	2025-07-18 16:43:51.246551	2025-07-18 16:43:51.246551
3075	Vòi Gạt 15 Đồng	voi gat 15 dong	cái	75000	0	\N	2025-07-18 16:43:51.25059	2025-07-18 16:43:51.25059
3076	Vòi Gạt 15 Inox	voi gat 15 inox	cái	55000	0	\N	2025-07-18 16:43:51.253589	2025-07-18 16:43:51.253589
3077	Vòi Gạt 15 Kẽm	voi gat 15 kem	cái	40000	0	\N	2025-07-18 16:43:51.257025	2025-07-18 16:43:51.257025
3078	Vòi Gạt 15 Nhựa	voi gat 15 nhua	cái	15000	0	\N	2025-07-18 16:43:51.258059	2025-07-18 16:43:51.258059
3079	Vòi Gạt 15 Sanwa	voi gat 15 sanwa	cái	120000	0	\N	2025-07-18 16:43:51.261548	2025-07-18 16:43:51.261548
3080	Vòi Gạt 20 Đồng	voi gat 20 dong	cái	0	0	\N	2025-07-18 16:43:51.263556	2025-07-18 16:43:51.263556
3081	Vòi Gạt 20 Inox	voi gat 20 inox	cái	0	0	\N	2025-07-18 16:43:51.266577	2025-07-18 16:43:51.266577
3082	Vòi Gạt 20 Nhựa	voi gat 20 nhua	cái	15000	0	\N	2025-07-18 16:43:51.26758	2025-07-18 16:43:51.26758
3083	Vòi Gạt 20 Sanwa	voi gat 20 sanwa	cái	145000	0	\N	2025-07-18 16:43:51.270564	2025-07-18 16:43:51.270564
3084	Vòi Gạt Đồng Vnec	voi gat dong vnec	cái	70000	0	\N	2025-07-18 16:43:51.273022	2025-07-18 16:43:51.273022
3085	Vòi Gạt Sen Ta 1/2	voi gat sen ta 1/2	cái	170000	0	\N	2025-07-18 16:43:51.276035	2025-07-18 16:43:51.276035
3086	Vòi Lavabo Sl 102	voi lavabo sl 102	bộ	1450000	0	\N	2025-07-18 16:43:51.278065	2025-07-18 16:43:51.278065
3087	Vòi Linax Lfv 612	voi linax lfv 612	cái	1800000	0	\N	2025-07-18 16:43:51.280053	2025-07-18 16:43:51.280053
3088	Vòi Ln Senta 2018	voi ln senta 2018	cái	750000	0	\N	2025-07-18 16:43:51.28305	2025-07-18 16:43:51.28305
3089	Vòi Máy Lọc Đắt	voi may loc dat	cái	100000	0	\N	2025-07-18 16:43:51.286051	2025-07-18 16:43:51.286051
3090	Vòi Quay Ngang Inox	voi quay ngang inox	cái	125000	0	\N	2025-07-18 16:43:51.289062	2025-07-18 16:43:51.289062
3091	Vòi Ram Set	voi ram set	cái	25000	0	\N	2025-07-18 16:43:51.291072	2025-07-18 16:43:51.291072
3092	Vòi Rm Sf 155	voi rm sf 155	cái	600000	0	\N	2025-07-18 16:43:51.294169	2025-07-18 16:43:51.294169
3093	Vòi Rửa America	voi rua america	cái	750000	0	\N	2025-07-18 16:43:51.297491	2025-07-18 16:43:51.297491
3094	Vòi Rửa Bát 304 Nóng Lạnh	voi rua bat 304 nong lanh	cái	300000	0	\N	2025-07-18 16:43:51.300491	2025-07-18 16:43:51.300491
3095	Vòi Rửa Bát Lạnh - Đẹp	voi rua bat lanh - dep	cái	270000	0	\N	2025-07-18 16:43:51.30249	2025-07-18 16:43:51.30249
3096	Vòi Rửa Bát Lạnh 304	voi rua bat lanh 304	cái	160000	0	\N	2025-07-18 16:43:51.305716	2025-07-18 16:43:51.305716
3097	Vòi Rửa Bát Lạnh 304 Gắn Chậu	voi rua bat lanh 304 gan chau	cái	160000	0	\N	2025-07-18 16:43:51.309745	2025-07-18 16:43:51.309745
3098	Vòi Rửa Bát Nl 304	voi rua bat nl 304	cái	350000	0	\N	2025-07-18 16:43:51.311769	2025-07-18 16:43:51.311769
3099	Vòi Rửa Bát Nl 473 Safias	voi rua bat nl 473 safias	cái	800000	0	\N	2025-07-18 16:43:51.31611	2025-07-18 16:43:51.31611
3100	Vòi Rửa Bát Nl Pazana Quả Loe	voi rua bat nl pazana qua loe	cái	620000	0	\N	2025-07-18 16:43:51.32011	2025-07-18 16:43:51.32011
3101	Vòi Rửa Bát Rút Saphias	voi rua bat rut saphias	cái	1550000	0	\N	2025-07-18 16:43:51.32311	2025-07-18 16:43:51.32311
3102	Vòi Rửa Bát Rút Sen Ta Ss102	voi rua bat rut sen ta ss102	cái	1650000	0	\N	2025-07-18 16:43:51.327497	2025-07-18 16:43:51.327497
3103	Vòi Rửa Bát Sen Ta 110 Nl	voi rua bat sen ta 110 nl	cái	950000	0	\N	2025-07-18 16:43:51.330655	2025-07-18 16:43:51.330655
3104	Vòi Rửa Bát Senta 109 Gắn Chậu	voi rua bat senta 109 gan chau	cái	1150000	0	\N	2025-07-18 16:43:51.333179	2025-07-18 16:43:51.333179
3105	Vòi Rửa Bát Senta Lạnh	voi rua bat senta lanh	cái	480000	0	\N	2025-07-18 16:43:51.334691	2025-07-18 16:43:51.334691
3106	Vòi Rửa Bát Vigacera Nl Vg731	voi rua bat vigacera nl vg731	cái	1450000	0	\N	2025-07-18 16:43:51.337689	2025-07-18 16:43:51.337689
3107	Vòi Rửa Mặt 1 Lỗ Nóng Lạnh 2024 Sen Ta	voi rua mat 1 lo nong lanh 2024 sen ta	cái	780000	0	\N	2025-07-18 16:43:51.340689	2025-07-18 16:43:51.340689
3108	Vòi Rửa Mặt 1 Lỗ Nóng Lạnh Sus	voi rua mat 1 lo nong lanh sus	cái	350000	0	\N	2025-07-18 16:43:51.343691	2025-07-18 16:43:51.343691
3109	Vòi Rửa Mặt 2 Lỗ 2019 Sen Ta	voi rua mat 2 lo 2019 sen ta	cái	800000	0	\N	2025-07-18 16:43:51.34669	2025-07-18 16:43:51.34669
3110	Vòi Rửa Mặt 368 Saphias	voi rua mat 368 saphias	cái	650000	0	\N	2025-07-18 16:43:51.350692	2025-07-18 16:43:51.350692
3111	Vòi Rửa Mặt Lạnh Đồng	voi rua mat lanh dong	cái	300000	0	\N	2025-07-18 16:43:51.353689	2025-07-18 16:43:51.353689
3112	Vòi Rửa Mặt Lạnh Rẻ	voi rua mat lanh re	cái	120000	0	\N	2025-07-18 16:43:51.356691	2025-07-18 16:43:51.356691
3113	Vòi Rửa Mặt Lạnh Sen Ta	voi rua mat lanh sen ta	bộ	430000	0	\N	2025-07-18 16:43:51.359688	2025-07-18 16:43:51.359688
3114	Vòi Rửa Mặt Nl 301 Xp+Dc	voi rua mat nl 301 xp+dc	bộ	550000	0	\N	2025-07-18 16:43:51.363691	2025-07-18 16:43:51.363691
3115	Vòi Rửa Mặt Nl Sen Ta 2018	voi rua mat nl sen ta 2018	cái	750000	0	\N	2025-07-18 16:43:51.366694	2025-07-18 16:43:51.366694
3116	Vòi Rửa Mặt Nl Senta 2014	voi rua mat nl senta 2014	cái	800000	0	\N	2025-07-18 16:43:51.370692	2025-07-18 16:43:51.370692
3117	Vòi Rửa Mặt Nl Sl 1021 Sen Ta	voi rua mat nl sl 1021 sen ta	cái	750000	0	\N	2025-07-18 16:43:51.373706	2025-07-18 16:43:51.373706
3118	Vòi Rửa Mặt Selta Vuông Sl 008	voi rua mat selta vuong sl 008	cái	1000000	0	\N	2025-07-18 16:43:51.37669	2025-07-18 16:43:51.37669
3119	Voi Sen 301	voi sen 301	cái	650000	0	\N	2025-07-18 16:43:51.379713	2025-07-18 16:43:51.379713
3120	Vòi Tưới	voi tuoi	cái	40000	0	\N	2025-07-18 16:43:51.381695	2025-07-18 16:43:51.381695
3121	Vòi Tưới Cây	voi tuoi cay	cái	160000	0	\N	2025-07-18 16:43:51.384696	2025-07-18 16:43:51.384696
3122	Vòi Xịt Kasung	voi xit kasung	bộ	135000	0	\N	2025-07-18 16:43:51.388703	2025-07-18 16:43:51.388703
3123	Vợt Muỗi Eur 02 Điện Quang	vot muoi eur 02 dien quang	cái	110000	0	\N	2025-07-18 16:43:51.390722	2025-07-18 16:43:51.390722
3124	Wifi	wifi	cái	320000	0	\N	2025-07-18 16:43:51.395318	2025-07-18 16:43:51.395318
3125	Xà Cầy	xa cay	cái	0	0	\N	2025-07-18 16:43:51.399385	2025-07-18 16:43:51.399385
3126	Xăng Thơm	xang thom	lít	35000	0	\N	2025-07-18 16:43:51.403385	2025-07-18 16:43:51.403385
3127	Xe Đẩy Đỏ	xe day do	cái	380000	0	\N	2025-07-18 16:43:51.40637	2025-07-18 16:43:51.40637
3128	Xe Rùa 14	xe rua 14	cái	350000	0	\N	2025-07-18 16:43:51.409385	2025-07-18 16:43:51.409385
3129	Xeng Cong To	xeng cong to	cái	60000	0	\N	2025-07-18 16:43:51.411371	2025-07-18 16:43:51.411371
3130	Xẻng Nhọn Cán Típ	xeng nhon can tip	cái	60000	0	\N	2025-07-18 16:43:51.413385	2025-07-18 16:43:51.413385
3131	Xẻng Vuông Cán Sắt Nhỏ	xeng vuong can sat nho	cái	65000	0	\N	2025-07-18 16:43:51.416371	2025-07-18 16:43:51.416371
3132	Xẻng Vuông Cong + Cán Gỗ	xeng vuong cong + can go	cái	35000	0	\N	2025-07-18 16:43:51.420369	2025-07-18 16:43:51.420369
3133	Xì Khô	xi kho	cái	50000	0	\N	2025-07-18 16:43:51.423371	2025-07-18 16:43:51.423371
3134	Xì Khô Nhật Dài	xi kho nhat dai	cái	75000	0	\N	2025-07-18 16:43:51.425385	2025-07-18 16:43:51.425385
3135	Xi Măng Trắng	xi mang trang	kg	7000	0	\N	2025-07-18 16:43:51.428357	2025-07-18 16:43:51.428357
3136	Xi Phông 75	xi phong 75	cái	109512	0	\N	2025-07-18 16:43:51.430385	2025-07-18 16:43:51.430385
3137	Xi Phông Đơn Rửa Bát	xi phong don rua bat	bộ	90000	0	\N	2025-07-18 16:43:51.433371	2025-07-18 16:43:51.433371
3138	Xi Phông Nhấn Inox	xi phong nhan inox	bộ	260000	0	\N	2025-07-18 16:43:51.435371	2025-07-18 16:43:51.435371
3139	Xi Phông Rửa Bát	xi phong rua bat	bộ	220000	0	\N	2025-07-18 16:43:51.437379	2025-07-18 16:43:51.437379
3140	Xi Phông Rửa Bát Đơn	xi phong rua bat don	bộ	90000	0	\N	2025-07-18 16:43:51.440369	2025-07-18 16:43:51.440369
3141	Xi Phông Rửa Mặt Đuôi Inox	xi phong rua mat duoi inox	bộ	260000	0	\N	2025-07-18 16:43:51.442371	2025-07-18 16:43:51.442371
3142	Xi Phông Rút	xi phong rut	cái	50000	0	\N	2025-07-18 16:43:51.444385	2025-07-18 16:43:51.444385
3143	Xi Phông Rút Xám	xi phong rut xam	cái	60000	0	\N	2025-07-18 16:43:51.447371	2025-07-18 16:43:51.447371
3144	Xi Phông Sơn Hà Rửa Bát	xi phong son ha rua bat	cái	100000	0	\N	2025-07-18 16:43:51.449356	2025-07-18 16:43:51.449356
3145	Xi Phong Tiểu Nam	xi phong tieu nam	bộ	50000	0	\N	2025-07-18 16:43:51.452369	2025-07-18 16:43:51.452369
3146	Xi Pông Rửa Bát	xi pong rua bat	cái	110000	0	\N	2025-07-18 16:43:51.454347	2025-07-18 16:43:51.454347
3147	Xích Tàu 2 Xích Mèo	xich tau 2 xich meo	cái	10000	0	\N	2025-07-18 16:43:51.456347	2025-07-18 16:43:51.456347
3148	Xit A10 Bóng	xit a10 bong	hộp	30000	0	\N	2025-07-18 16:43:51.457347	2025-07-18 16:43:51.457347
3149	Xịt Chế - 1Th=12	xit che - 1th=12	lọ	35000	0	\N	2025-07-18 16:43:51.460348	2025-07-18 16:43:51.460348
3150	Xịt Inax 105 M	xit inax 105 m	cái	950000	0	\N	2025-07-18 16:43:51.46235	2025-07-18 16:43:51.46235
3151	Xịt Inoc	xit inoc	lọ	75000	0	\N	2025-07-18 16:43:51.464345	2025-07-18 16:43:51.464345
3152	Xịt Kính	xit kinh	chai	25000	0	\N	2025-07-18 16:43:51.46635	2025-07-18 16:43:51.46635
3153	Xịt Linax 102	xit linax 102	cái	320000	0	\N	2025-07-18 16:43:51.468354	2025-07-18 16:43:51.468354
3154	Xịt Linax 105	xit linax 105	cái	860000	0	\N	2025-07-18 16:43:51.469348	2025-07-18 16:43:51.469348
3155	Xịt Muỗi	xit muoi	hộp	65000	0	\N	2025-07-18 16:43:51.472351	2025-07-18 16:43:51.472351
3156	Xịt Senta	xit senta	cái	260000	0	\N	2025-07-18 16:43:51.474347	2025-07-18 16:43:51.474347
3157	Xịt To Let Inox	xit to let inox	bộ	145000	0	\N	2025-07-18 16:43:51.476347	2025-07-18 16:43:51.476347
3158	Xịt Vg 828	xit vg 828	cái	250000	0	\N	2025-07-18 16:43:51.478353	2025-07-18 16:43:51.478353
3159	Xịt Viglacera Nhựa	xit viglacera nhua	bộ	220000	0	\N	2025-07-18 16:43:51.481353	2025-07-18 16:43:51.481353
3160	Xịt Viki A	xit viki a	cái	260000	0	\N	2025-07-18 16:43:51.483376	2025-07-18 16:43:51.483376
3161	Xịt Xám Doda	xit xam doda	bộ	120000	0	\N	2025-07-18 16:43:51.48642	2025-07-18 16:43:51.48642
3162	Xịt Xí Thái	xit xi thai	bộ	70000	0	\N	2025-07-18 16:43:51.488438	2025-07-18 16:43:51.488438
3163	Xô Vữa	xo vua	cái	10000	0	\N	2025-07-18 16:43:51.491436	2025-07-18 16:43:51.491436
3164	Xổm	xom	cái	150000	0	\N	2025-07-18 16:43:51.494451	2025-07-18 16:43:51.494451
3165	Xốp Xanh 2 Mặt 2 Cm	xop xanh 2 mat 2 cm	cuộn	7000	0	\N	2025-07-18 16:43:51.497596	2025-07-18 16:43:51.497596
3166	Xúc Bả Inox	xuc ba inox	cái	18000	0	\N	2025-07-18 16:43:51.499594	2025-07-18 16:43:51.499594
3167	Xúc Bả Sắt To	xuc ba sat to	cái	10000	0	\N	2025-07-18 16:43:51.501597	2025-07-18 16:43:51.501597
3168	Xúc Tác 2	xuc tac 2	kg	155000	0	\N	2025-07-18 16:43:51.50486	2025-07-18 16:43:51.50486
3169	Zoăng Băng Tan	zoang bang tan	cái	1000	0	\N	2025-07-18 16:43:51.50786	2025-07-18 16:43:51.50786
3170	Zoăng Bệt	zoang bet	cái	50000	0	\N	2025-07-18 16:43:51.510859	2025-07-18 16:43:51.510859
3	Ampe Kìm Cmart	ampe kim cmart	cái	500000	-1	\N	2025-07-18 16:43:43.536633	2025-07-18 16:51:26.032628
5	Áo Cốt 10	ao cot 10	cái	500	-1	\N	2025-07-18 16:43:43.546623	2025-07-18 16:51:26.037562
9	Asia Dây Led Cuộn	asia day led cuon	cuộn	180000	-1	\N	2025-07-18 16:43:43.562146	2025-07-18 16:51:26.195277
4	Áo Cốt	ao cot	cái	1000	0	\N	2025-07-18 16:43:43.542628	2025-07-21 13:56:11.873847
6	Áo Cốt 70	ao cot 70	cái	1500	0	\N	2025-07-18 16:43:43.549623	2025-07-21 13:56:11.877846
16	Asia Đèn Hắt Vuông Dtu 01	asia den hat vuong dtu 01	cái	240000	0	\N	2025-07-18 16:43:43.587788	2025-07-21 13:56:11.878851
1755	Pana Bộ Mặt 3 Ct 1 Chiều Ánh Kim	pana bo mat 3 ct 1 chieu anh kim	cái	257000	0	\N	2025-07-18 16:43:48.035867	2025-07-21 13:56:11.879848
634	Cút Bơm Nhôm	cut bom nhom	cái	7000	0	\N	2025-07-18 16:43:45.262926	2025-07-21 13:56:11.880847
2091	Sino S18 Cc Chiết Áp Đèn	sino s18 cc chiet ap den	cái	117200	-1	\N	2025-07-18 16:43:48.834358	2025-07-21 13:59:29.91506
2593	Tp Pvc Cút 90	tp pvc cut 90	cái	30024	-1	\N	2025-07-18 16:43:50.075757	2025-07-21 14:26:53.972772
\.


--
-- TOC entry 4951 (class 0 OID 16695)
-- Dependencies: 224
-- Data for Name: productpricehistory; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.productpricehistory (id, product_masp, price, effective_date, recorded_at) FROM stdin;
1	1	1600000	2025-07-18 16:43:43.519619	2025-07-18 16:43:43.524619
2	2	1850000	2025-07-18 16:43:43.524619	2025-07-18 16:43:43.53162
3	3	500000	2025-07-18 16:43:43.536633	2025-07-18 16:43:43.539624
4	4	1000	2025-07-18 16:43:43.542628	2025-07-18 16:43:43.545624
5	5	500	2025-07-18 16:43:43.546623	2025-07-18 16:43:43.549623
6	6	1500	2025-07-18 16:43:43.549623	2025-07-18 16:43:43.553146
7	7	10000	2025-07-18 16:43:43.555147	2025-07-18 16:43:43.558146
8	8	25000	2025-07-18 16:43:43.558146	2025-07-18 16:43:43.561147
9	9	180000	2025-07-18 16:43:43.562146	2025-07-18 16:43:43.565147
10	10	110000	2025-07-18 16:43:43.565147	2025-07-18 16:43:43.567146
11	11	120000	2025-07-18 16:43:43.568152	2025-07-18 16:43:43.571155
12	12	300000	2025-07-18 16:43:43.571155	2025-07-18 16:43:43.575176
13	13	100000	2025-07-18 16:43:43.575176	2025-07-18 16:43:43.579168
14	14	310000	2025-07-18 16:43:43.579168	2025-07-18 16:43:43.583721
15	15	150000	2025-07-18 16:43:43.583721	2025-07-18 16:43:43.586803
16	16	240000	2025-07-18 16:43:43.587788	2025-07-18 16:43:43.59078
17	17	340000	2025-07-18 16:43:43.59078	2025-07-18 16:43:43.594787
18	18	280000	2025-07-18 16:43:43.594787	2025-07-18 16:43:43.598784
19	19	340000	2025-07-18 16:43:43.598784	2025-07-18 16:43:43.602302
20	20	165000	2025-07-18 16:43:43.602302	2025-07-18 16:43:43.606294
21	21	250000	2025-07-18 16:43:43.606294	2025-07-18 16:43:43.610291
22	22	84000	2025-07-18 16:43:43.610291	2025-07-18 16:43:43.614288
23	23	220000	2025-07-18 16:43:43.614288	2025-07-18 16:43:43.618318
24	24	100000	2025-07-18 16:43:43.618318	2025-07-18 16:43:43.62232
25	25	160000	2025-07-18 16:43:43.62232	2025-07-18 16:43:43.626281
26	26	1000000	2025-07-18 16:43:43.626281	2025-07-18 16:43:43.630301
27	27	290000	2025-07-18 16:43:43.630301	2025-07-18 16:43:43.634296
28	28	370000	2025-07-18 16:43:43.634296	2025-07-18 16:43:43.638332
29	29	340000	2025-07-18 16:43:43.638332	2025-07-18 16:43:43.642322
30	30	160000	2025-07-18 16:43:43.643348	2025-07-18 16:43:43.646333
31	31	300000	2025-07-18 16:43:43.646333	2025-07-18 16:43:43.649317
32	32	310000	2025-07-18 16:43:43.650332	2025-07-18 16:43:43.653874
33	33	1120000	2025-07-18 16:43:43.653874	2025-07-18 16:43:43.657857
34	34	1500000	2025-07-18 16:43:43.657857	2025-07-18 16:43:43.661868
35	35	2100000	2025-07-18 16:43:43.661868	2025-07-18 16:43:43.66589
36	36	320000	2025-07-18 16:43:43.66589	2025-07-18 16:43:43.669894
37	37	4500000	2025-07-18 16:43:43.669894	2025-07-18 16:43:43.673879
38	38	1450000	2025-07-18 16:43:43.673879	2025-07-18 16:43:43.676885
39	39	650000	2025-07-18 16:43:43.677886	2025-07-18 16:43:43.681205
40	40	810000	2025-07-18 16:43:43.681205	2025-07-18 16:43:43.685715
41	41	209000	2025-07-18 16:43:43.685715	2025-07-18 16:43:43.688722
42	42	105600	2025-07-18 16:43:43.689721	2025-07-18 16:43:43.691745
43	43	230000	2025-07-18 16:43:43.692721	2025-07-18 16:43:43.695979
44	44	0	2025-07-18 16:43:43.695979	2025-07-18 16:43:43.698987
45	45	1850000	2025-07-18 16:43:43.700331	2025-07-18 16:43:43.703883
46	46	90000	2025-07-18 16:43:43.704881	2025-07-18 16:43:43.707904
47	47	46872	2025-07-18 16:43:43.708899	2025-07-18 16:43:43.712891
48	48	15000	2025-07-18 16:43:43.712891	2025-07-18 16:43:43.716875
49	49	110000	2025-07-18 16:43:43.7179	2025-07-18 16:43:43.720906
50	50	20000	2025-07-18 16:43:43.720906	2025-07-18 16:43:43.72394
51	51	13000	2025-07-18 16:43:43.724939	2025-07-18 16:43:43.728225
52	52	25000	2025-07-18 16:43:43.729225	2025-07-18 16:43:43.732224
53	53	35000	2025-07-18 16:43:43.732224	2025-07-18 16:43:43.736226
54	54	50000	2025-07-18 16:43:43.737223	2025-07-18 16:43:43.74033
55	55	15000	2025-07-18 16:43:43.741325	2025-07-18 16:43:43.744333
56	56	10000	2025-07-18 16:43:43.745353	2025-07-18 16:43:43.748332
57	57	50000	2025-07-18 16:43:43.748332	2025-07-18 16:43:43.75133
58	58	35000	2025-07-18 16:43:43.75235	2025-07-18 16:43:43.754892
59	59	3000	2025-07-18 16:43:43.754892	2025-07-18 16:43:43.757962
60	60	4000	2025-07-18 16:43:43.758962	2025-07-18 16:43:43.762601
61	61	9000	2025-07-18 16:43:43.762601	2025-07-18 16:43:43.765616
62	62	40000	2025-07-18 16:43:43.765616	2025-07-18 16:43:43.768632
63	63	40000	2025-07-18 16:43:43.768632	2025-07-18 16:43:43.772603
64	64	160000	2025-07-18 16:43:43.772603	2025-07-18 16:43:43.774969
65	65	75000	2025-07-18 16:43:43.774969	2025-07-18 16:43:43.778472
66	66	15000	2025-07-18 16:43:43.778472	2025-07-18 16:43:43.780474
67	67	670000	2025-07-18 16:43:43.781473	2025-07-18 16:43:43.783992
68	68	18000	2025-07-18 16:43:43.785001	2025-07-18 16:43:43.788018
69	69	13000	2025-07-18 16:43:43.789232	2025-07-18 16:43:43.792483
70	70	20000	2025-07-18 16:43:43.792483	2025-07-18 16:43:43.796563
71	71	105000	2025-07-18 16:43:43.797585	2025-07-18 16:43:43.80056
72	72	25000	2025-07-18 16:43:43.80056	2025-07-18 16:43:43.803783
73	73	12000	2025-07-18 16:43:43.804783	2025-07-18 16:43:43.80778
74	74	90000	2025-07-18 16:43:43.80878	2025-07-18 16:43:43.811804
75	75	50000	2025-07-18 16:43:43.811804	2025-07-18 16:43:43.815788
76	76	50000	2025-07-18 16:43:43.816805	2025-07-18 16:43:43.820103
77	77	6000	2025-07-18 16:43:43.820103	2025-07-18 16:43:43.824127
78	78	12000	2025-07-18 16:43:43.825113	2025-07-18 16:43:43.828394
79	79	35000	2025-07-18 16:43:43.828394	2025-07-18 16:43:43.831415
80	80	25000	2025-07-18 16:43:43.831415	2025-07-18 16:43:43.834233
81	81	7000	2025-07-18 16:43:43.834233	2025-07-18 16:43:43.83744
82	82	5000	2025-07-18 16:43:43.838456	2025-07-18 16:43:43.840609
83	83	10000	2025-07-18 16:43:43.840609	2025-07-18 16:43:43.843619
84	84	15000	2025-07-18 16:43:43.843619	2025-07-18 16:43:43.846619
85	85	25000	2025-07-18 16:43:43.846619	2025-07-18 16:43:43.849643
86	86	130000	2025-07-18 16:43:43.849643	2025-07-18 16:43:43.851657
87	87	40000	2025-07-18 16:43:43.852643	2025-07-18 16:43:43.855158
88	88	15000	2025-07-18 16:43:43.855158	2025-07-18 16:43:43.858158
89	89	10000	2025-07-18 16:43:43.858158	2025-07-18 16:43:43.861159
90	90	440000	2025-07-18 16:43:43.861159	2025-07-18 16:43:43.864156
91	91	30000	2025-07-18 16:43:43.864156	2025-07-18 16:43:43.867063
92	92	50000	2025-07-18 16:43:43.867063	2025-07-18 16:43:43.870617
93	93	35000	2025-07-18 16:43:43.870617	2025-07-18 16:43:43.874728
94	94	35000	2025-07-18 16:43:43.874728	2025-07-18 16:43:43.877202
95	95	60000	2025-07-18 16:43:43.878212	2025-07-18 16:43:43.879896
96	96	55000	2025-07-18 16:43:43.880931	2025-07-18 16:43:43.884167
97	97	86000	2025-07-18 16:43:43.884167	2025-07-18 16:43:43.886181
98	98	35000	2025-07-18 16:43:43.887183	2025-07-18 16:43:43.889244
99	99	90000	2025-07-18 16:43:43.889244	2025-07-18 16:43:43.892247
100	100	15000	2025-07-18 16:43:43.893208	2025-07-18 16:43:43.895207
101	101	35000	2025-07-18 16:43:43.895207	2025-07-18 16:43:43.898244
102	102	30000	2025-07-18 16:43:43.898244	2025-07-18 16:43:43.901206
103	103	145000	2025-07-18 16:43:43.901206	2025-07-18 16:43:43.904762
104	104	95000	2025-07-18 16:43:43.904762	2025-07-18 16:43:43.90726
105	105	220000	2025-07-18 16:43:43.90726	2025-07-18 16:43:43.910317
106	106	8000	2025-07-18 16:43:43.911303	2025-07-18 16:43:43.913283
107	107	9000	2025-07-18 16:43:43.914278	2025-07-18 16:43:43.916278
108	108	60000	2025-07-18 16:43:43.916278	2025-07-18 16:43:43.91906
109	109	85000	2025-07-18 16:43:43.920654	2025-07-18 16:43:43.922253
110	110	50000	2025-07-18 16:43:43.923262	2025-07-18 16:43:43.925284
111	111	60000	2025-07-18 16:43:43.925284	2025-07-18 16:43:43.928688
112	112	8000	2025-07-18 16:43:43.928688	2025-07-18 16:43:43.930893
113	113	18000	2025-07-18 16:43:43.931918	2025-07-18 16:43:43.934308
114	114	10000	2025-07-18 16:43:43.934308	2025-07-18 16:43:43.937331
115	115	16000	2025-07-18 16:43:43.937331	2025-07-18 16:43:43.939352
116	116	20000	2025-07-18 16:43:43.940327	2025-07-18 16:43:43.942485
117	117	18000	2025-07-18 16:43:43.942485	2025-07-18 16:43:43.945803
118	118	15000	2025-07-18 16:43:43.946851	2025-07-18 16:43:43.949814
119	119	15000	2025-07-18 16:43:43.950838	2025-07-18 16:43:43.952837
120	120	4400000	2025-07-18 16:43:43.953856	2025-07-18 16:43:43.956408
121	121	5400000	2025-07-18 16:43:43.956408	2025-07-18 16:43:43.960424
122	122	5500000	2025-07-18 16:43:43.960424	2025-07-18 16:43:43.963424
123	123	3800000	2025-07-18 16:43:43.963424	2025-07-18 16:43:43.966391
124	124	4900000	2025-07-18 16:43:43.966391	2025-07-18 16:43:43.969438
125	125	3580000	2025-07-18 16:43:43.969438	2025-07-18 16:43:43.972453
126	126	4600000	2025-07-18 16:43:43.972453	2025-07-18 16:43:43.975439
127	127	2700000	2025-07-18 16:43:43.975439	2025-07-18 16:43:43.978439
128	128	5200000	2025-07-18 16:43:43.978439	2025-07-18 16:43:43.981456
129	129	6550000	2025-07-18 16:43:43.981456	2025-07-18 16:43:43.984005
130	130	2500000	2025-07-18 16:43:43.984005	2025-07-18 16:43:43.985006
131	131	950000	2025-07-18 16:43:43.986017	2025-07-18 16:43:43.988021
132	132	1800000	2025-07-18 16:43:43.988021	2025-07-18 16:43:43.990053
133	133	1900000	2025-07-18 16:43:43.990053	2025-07-18 16:43:43.993053
134	134	2930000	2025-07-18 16:43:43.993053	2025-07-18 16:43:43.996054
135	135	4650000	2025-07-18 16:43:43.996054	2025-07-18 16:43:43.998039
136	136	650000	2025-07-18 16:43:43.998039	2025-07-18 16:43:44.000052
137	137	2450000	2025-07-18 16:43:44.000052	2025-07-18 16:43:44.002052
138	138	2250000	2025-07-18 16:43:44.003053	2025-07-18 16:43:44.005617
139	139	2300000	2025-07-18 16:43:44.006618	2025-07-18 16:43:44.008618
140	140	2250000	2025-07-18 16:43:44.008618	2025-07-18 16:43:44.010617
141	141	2250000	2025-07-18 16:43:44.010617	2025-07-18 16:43:44.013602
142	142	2350000	2025-07-18 16:43:44.013602	2025-07-18 16:43:44.016602
143	143	2300000	2025-07-18 16:43:44.016602	2025-07-18 16:43:44.018603
144	144	3700000	2025-07-18 16:43:44.018603	2025-07-18 16:43:44.020618
145	145	1350000	2025-07-18 16:43:44.020618	2025-07-18 16:43:44.022617
146	146	580000	2025-07-18 16:43:44.022617	2025-07-18 16:43:44.024618
147	147	320000	2025-07-18 16:43:44.025617	2025-07-18 16:43:44.028602
148	148	780000	2025-07-18 16:43:44.028602	2025-07-18 16:43:44.031602
149	149	430000	2025-07-18 16:43:44.031602	2025-07-18 16:43:44.033617
150	150	381000	2025-07-18 16:43:44.033617	2025-07-18 16:43:44.036618
151	151	2250000	2025-07-18 16:43:44.036618	2025-07-18 16:43:44.038584
152	152	1950000	2025-07-18 16:43:44.03963	2025-07-18 16:43:44.041612
153	153	1550000	2025-07-18 16:43:44.042615	2025-07-18 16:43:44.044637
154	154	1300000	2025-07-18 16:43:44.045615	2025-07-18 16:43:44.04763
155	155	1230000	2025-07-18 16:43:44.048631	2025-07-18 16:43:44.050631
156	156	5000000	2025-07-18 16:43:44.051631	2025-07-18 16:43:44.052616
157	157	45000	2025-07-18 16:43:44.052616	2025-07-18 16:43:44.055158
158	158	2250000	2025-07-18 16:43:44.056503	2025-07-18 16:43:44.057751
159	159	2020000	2025-07-18 16:43:44.058787	2025-07-18 16:43:44.060868
160	160	7000000	2025-07-18 16:43:44.061882	2025-07-18 16:43:44.064856
161	161	260000	2025-07-18 16:43:44.065856	2025-07-18 16:43:44.067532
162	162	3100000	2025-07-18 16:43:44.067532	2025-07-18 16:43:44.069539
163	163	185000	2025-07-18 16:43:44.069539	2025-07-18 16:43:44.072417
164	164	20000	2025-07-18 16:43:44.072417	2025-07-18 16:43:44.075423
165	165	6000000	2025-07-18 16:43:44.075423	2025-07-18 16:43:44.077681
166	166	50000	2025-07-18 16:43:44.078681	2025-07-18 16:43:44.08068
167	167	80000	2025-07-18 16:43:44.08068	2025-07-18 16:43:44.083183
168	168	2800000	2025-07-18 16:43:44.0842	2025-07-18 16:43:44.086222
169	169	2600000	2025-07-18 16:43:44.086222	2025-07-18 16:43:44.089238
170	170	1480000	2025-07-18 16:43:44.089238	2025-07-18 16:43:44.091271
171	171	1250000	2025-07-18 16:43:44.092356	2025-07-18 16:43:44.0954
172	172	2050000	2025-07-18 16:43:44.0954	2025-07-18 16:43:44.097401
173	173	1300000	2025-07-18 16:43:44.097401	2025-07-18 16:43:44.099414
174	174	1530000	2025-07-18 16:43:44.099414	2025-07-18 16:43:44.102401
175	175	1850000	2025-07-18 16:43:44.102401	2025-07-18 16:43:44.104414
176	176	2350000	2025-07-18 16:43:44.104936	2025-07-18 16:43:44.107073
177	177	1650000	2025-07-18 16:43:44.108115	2025-07-18 16:43:44.11013
178	178	1450000	2025-07-18 16:43:44.111132	2025-07-18 16:43:44.113301
179	179	1650000	2025-07-18 16:43:44.11434	2025-07-18 16:43:44.117336
180	180	2850000	2025-07-18 16:43:44.117336	2025-07-18 16:43:44.119346
181	181	2550000	2025-07-18 16:43:44.119346	2025-07-18 16:43:44.12136
182	182	2350000	2025-07-18 16:43:44.12136	2025-07-18 16:43:44.124362
183	183	2850000	2025-07-18 16:43:44.124362	2025-07-18 16:43:44.12636
184	184	3200000	2025-07-18 16:43:44.12636	2025-07-18 16:43:44.128867
185	185	1750000	2025-07-18 16:43:44.129845	2025-07-18 16:43:44.13288
186	186	1750000	2025-07-18 16:43:44.13288	2025-07-18 16:43:44.134867
187	187	1450000	2025-07-18 16:43:44.134867	2025-07-18 16:43:44.137639
188	188	2620000	2025-07-18 16:43:44.137639	2025-07-18 16:43:44.141965
189	189	2980000	2025-07-18 16:43:44.141965	2025-07-18 16:43:44.145239
190	190	3600000	2025-07-18 16:43:44.145239	2025-07-18 16:43:44.147287
191	191	1150000	2025-07-18 16:43:44.148288	2025-07-18 16:43:44.151274
192	192	1400000	2025-07-18 16:43:44.151274	2025-07-18 16:43:44.153287
193	193	1200000	2025-07-18 16:43:44.153287	2025-07-18 16:43:44.154819
194	194	0	2025-07-18 16:43:44.154819	2025-07-18 16:43:44.156867
195	195	2250000	2025-07-18 16:43:44.157868	2025-07-18 16:43:44.159867
196	196	2850000	2025-07-18 16:43:44.159867	2025-07-18 16:43:44.162854
197	197	2220000	2025-07-18 16:43:44.162854	2025-07-18 16:43:44.164857
198	198	45000	2025-07-18 16:43:44.165867	2025-07-18 16:43:44.168901
199	199	90000	2025-07-18 16:43:44.168901	2025-07-18 16:43:44.172915
200	200	15000	2025-07-18 16:43:44.172915	2025-07-18 16:43:44.17714
201	201	1000	2025-07-18 16:43:44.17714	2025-07-18 16:43:44.177915
202	202	1000	2025-07-18 16:43:44.177915	2025-07-18 16:43:44.180899
203	203	6000	2025-07-18 16:43:44.181915	2025-07-18 16:43:44.184456
204	204	2000	2025-07-18 16:43:44.184456	2025-07-18 16:43:44.186457
205	205	3000	2025-07-18 16:43:44.186457	2025-07-18 16:43:44.188471
206	206	115000	2025-07-18 16:43:44.188471	2025-07-18 16:43:44.190518
207	207	4600000	2025-07-18 16:43:44.191519	2025-07-18 16:43:44.193518
208	208	700000	2025-07-18 16:43:44.193518	2025-07-18 16:43:44.196504
209	209	250000	2025-07-18 16:43:44.196504	2025-07-18 16:43:44.198504
210	210	850000	2025-07-18 16:43:44.198504	2025-07-18 16:43:44.201502
211	211	120000	2025-07-18 16:43:44.201502	2025-07-18 16:43:44.203504
212	212	155000	2025-07-18 16:43:44.203504	2025-07-18 16:43:44.207107
213	213	280000	2025-07-18 16:43:44.207107	2025-07-18 16:43:44.208107
214	214	850000	2025-07-18 16:43:44.208107	2025-07-18 16:43:44.211107
215	215	900000	2025-07-18 16:43:44.212093	2025-07-18 16:43:44.214093
216	216	18000	2025-07-18 16:43:44.214093	2025-07-18 16:43:44.216107
217	217	1650000	2025-07-18 16:43:44.216107	2025-07-18 16:43:44.219107
218	218	165000	2025-07-18 16:43:44.219107	2025-07-18 16:43:44.221107
219	219	35000	2025-07-18 16:43:44.221107	2025-07-18 16:43:44.223107
220	220	90000	2025-07-18 16:43:44.224092	2025-07-18 16:43:44.226107
221	221	2900000	2025-07-18 16:43:44.226107	2025-07-18 16:43:44.228107
222	222	0	2025-07-18 16:43:44.229093	2025-07-18 16:43:44.231101
223	223	3250000	2025-07-18 16:43:44.231101	2025-07-18 16:43:44.235107
224	224	4970000	2025-07-18 16:43:44.235107	2025-07-18 16:43:44.237107
225	225	4350000	2025-07-18 16:43:44.238107	2025-07-18 16:43:44.24114
226	226	7300000	2025-07-18 16:43:44.24114	2025-07-18 16:43:44.24314
227	227	1850000	2025-07-18 16:43:44.24314	2025-07-18 16:43:44.245154
228	228	15000	2025-07-18 16:43:44.245154	2025-07-18 16:43:44.248154
229	229	28000	2025-07-18 16:43:44.248154	2025-07-18 16:43:44.251139
230	230	50000	2025-07-18 16:43:44.251139	2025-07-18 16:43:44.25314
231	231	35000	2025-07-18 16:43:44.25314	2025-07-18 16:43:44.255669
232	232	70000	2025-07-18 16:43:44.255669	2025-07-18 16:43:44.257729
233	233	80000	2025-07-18 16:43:44.257729	2025-07-18 16:43:44.259729
234	234	100000	2025-07-18 16:43:44.260726	2025-07-18 16:43:44.263658
235	235	100000	2025-07-18 16:43:44.263658	2025-07-18 16:43:44.265667
236	236	100000	2025-07-18 16:43:44.265667	2025-07-18 16:43:44.267667
237	237	60000	2025-07-18 16:43:44.267667	2025-07-18 16:43:44.268673
238	238	25000	2025-07-18 16:43:44.269674	2025-07-18 16:43:44.271675
239	239	15000	2025-07-18 16:43:44.271675	2025-07-18 16:43:44.273779
240	240	8000	2025-07-18 16:43:44.273779	2025-07-18 16:43:44.277068
241	241	60000	2025-07-18 16:43:44.277068	2025-07-18 16:43:44.279056
242	242	8500	2025-07-18 16:43:44.279056	2025-07-18 16:43:44.281072
243	243	25000	2025-07-18 16:43:44.281072	2025-07-18 16:43:44.28357
244	244	8000	2025-07-18 16:43:44.28458	2025-07-18 16:43:44.28558
245	245	40000	2025-07-18 16:43:44.28558	2025-07-18 16:43:44.288608
246	246	35000	2025-07-18 16:43:44.288608	2025-07-18 16:43:44.290666
247	247	50000	2025-07-18 16:43:44.290666	2025-07-18 16:43:44.292667
248	248	50000	2025-07-18 16:43:44.293634	2025-07-18 16:43:44.29664
249	249	40000	2025-07-18 16:43:44.29664	2025-07-18 16:43:44.299653
250	250	45000	2025-07-18 16:43:44.299653	2025-07-18 16:43:44.301667
251	251	30000	2025-07-18 16:43:44.301667	2025-07-18 16:43:44.303666
252	252	13000	2025-07-18 16:43:44.303666	2025-07-18 16:43:44.306139
253	253	17000	2025-07-18 16:43:44.306139	2025-07-18 16:43:44.309154
254	254	30000	2025-07-18 16:43:44.309154	2025-07-18 16:43:44.311169
255	255	40000	2025-07-18 16:43:44.311169	2025-07-18 16:43:44.313185
256	256	45000	2025-07-18 16:43:44.313185	2025-07-18 16:43:44.316201
257	257	35000	2025-07-18 16:43:44.316201	2025-07-18 16:43:44.318148
258	258	25000	2025-07-18 16:43:44.318148	2025-07-18 16:43:44.32117
259	259	35000	2025-07-18 16:43:44.32117	2025-07-18 16:43:44.323185
260	260	18000	2025-07-18 16:43:44.323185	2025-07-18 16:43:44.326161
261	261	3000	2025-07-18 16:43:44.326161	2025-07-18 16:43:44.328171
262	262	40000	2025-07-18 16:43:44.328171	2025-07-18 16:43:44.33017
263	263	70000	2025-07-18 16:43:44.33017	2025-07-18 16:43:44.332169
264	264	25000	2025-07-18 16:43:44.332169	2025-07-18 16:43:44.334186
265	265	4000	2025-07-18 16:43:44.335185	2025-07-18 16:43:44.337185
266	266	30000	2025-07-18 16:43:44.338171	2025-07-18 16:43:44.341241
267	267	10000	2025-07-18 16:43:44.342197	2025-07-18 16:43:44.345019
268	268	75000	2025-07-18 16:43:44.346018	2025-07-18 16:43:44.347017
269	269	10000	2025-07-18 16:43:44.347017	2025-07-18 16:43:44.350023
270	270	20000	2025-07-18 16:43:44.350023	2025-07-18 16:43:44.352161
271	271	25000	2025-07-18 16:43:44.352161	2025-07-18 16:43:44.354192
272	272	15000	2025-07-18 16:43:44.354192	2025-07-18 16:43:44.357665
273	273	25000	2025-07-18 16:43:44.357665	2025-07-18 16:43:44.359764
274	274	170000	2025-07-18 16:43:44.360801	2025-07-18 16:43:44.362872
275	275	25000	2025-07-18 16:43:44.362872	2025-07-18 16:43:44.364924
276	276	20000	2025-07-18 16:43:44.364924	2025-07-18 16:43:44.366443
277	277	10000	2025-07-18 16:43:44.366443	2025-07-18 16:43:44.368468
278	278	20000	2025-07-18 16:43:44.368468	2025-07-18 16:43:44.371514
279	279	12000	2025-07-18 16:43:44.371514	2025-07-18 16:43:44.374489
280	280	15000	2025-07-18 16:43:44.375498	2025-07-18 16:43:44.378514
281	281	20000	2025-07-18 16:43:44.378514	2025-07-18 16:43:44.380514
282	282	105000	2025-07-18 16:43:44.380514	2025-07-18 16:43:44.382513
283	283	0	2025-07-18 16:43:44.383482	2025-07-18 16:43:44.386039
284	284	46000	2025-07-18 16:43:44.386039	2025-07-18 16:43:44.389022
285	285	52000	2025-07-18 16:43:44.389022	2025-07-18 16:43:44.392071
286	286	110000	2025-07-18 16:43:44.392071	2025-07-18 16:43:44.394085
287	287	305000	2025-07-18 16:43:44.394085	2025-07-18 16:43:44.396047
288	288	80000	2025-07-18 16:43:44.396047	2025-07-18 16:43:44.398069
289	289	60000	2025-07-18 16:43:44.398069	2025-07-18 16:43:44.400071
290	290	60000	2025-07-18 16:43:44.400071	2025-07-18 16:43:44.402085
291	291	82000	2025-07-18 16:43:44.402085	2025-07-18 16:43:44.404071
292	292	305000	2025-07-18 16:43:44.404071	2025-07-18 16:43:44.406069
293	293	2200	2025-07-18 16:43:44.406069	2025-07-18 16:43:44.407617
294	294	2800	2025-07-18 16:43:44.408615	2025-07-18 16:43:44.410631
295	295	2600	2025-07-18 16:43:44.410631	2025-07-18 16:43:44.412631
296	296	5793	2025-07-18 16:43:44.413618	2025-07-18 16:43:44.414631
297	297	5793	2025-07-18 16:43:44.415631	2025-07-18 16:43:44.418615
298	298	5793	2025-07-18 16:43:44.418615	2025-07-18 16:43:44.420615
299	299	43837	2025-07-18 16:43:44.420615	2025-07-18 16:43:44.422631
300	300	7500	2025-07-18 16:43:44.422631	2025-07-18 16:43:44.424631
301	301	9423	2025-07-18 16:43:44.424631	2025-07-18 16:43:44.427602
302	302	9423	2025-07-18 16:43:44.427602	2025-07-18 16:43:44.43109
303	303	9423	2025-07-18 16:43:44.43109	2025-07-18 16:43:44.434122
304	304	12000	2025-07-18 16:43:44.434122	2025-07-18 16:43:44.436099
305	305	11500	2025-07-18 16:43:44.436099	2025-07-18 16:43:44.438085
306	306	16000	2025-07-18 16:43:44.438085	2025-07-18 16:43:44.441114
307	307	19000	2025-07-18 16:43:44.441114	2025-07-18 16:43:44.442147
308	308	6500	2025-07-18 16:43:44.443161	2025-07-18 16:43:44.445161
309	309	7000	2025-07-18 16:43:44.445161	2025-07-18 16:43:44.448161
310	310	7500	2025-07-18 16:43:44.448161	2025-07-18 16:43:44.450129
311	311	10000	2025-07-18 16:43:44.451129	2025-07-18 16:43:44.453532
312	312	11000	2025-07-18 16:43:44.454544	2025-07-18 16:43:44.455542
313	313	12000	2025-07-18 16:43:44.456541	2025-07-18 16:43:44.457979
314	314	17000	2025-07-18 16:43:44.457979	2025-07-18 16:43:44.46098
315	315	18000	2025-07-18 16:43:44.46098	2025-07-18 16:43:44.464443
316	316	16000	2025-07-18 16:43:44.464443	2025-07-18 16:43:44.466888
317	317	26000	2025-07-18 16:43:44.466888	2025-07-18 16:43:44.468923
318	318	17000	2025-07-18 16:43:44.468923	2025-07-18 16:43:44.470957
319	319	27000	2025-07-18 16:43:44.470957	2025-07-18 16:43:44.473993
320	320	40000	2025-07-18 16:43:44.473993	2025-07-18 16:43:44.477007
321	321	36000	2025-07-18 16:43:44.477007	2025-07-18 16:43:44.479007
322	322	46000	2025-07-18 16:43:44.479007	2025-07-18 16:43:44.481972
323	323	65000	2025-07-18 16:43:44.481972	2025-07-18 16:43:44.484501
324	324	80000	2025-07-18 16:43:44.485516	2025-07-18 16:43:44.488531
325	325	31000	2025-07-18 16:43:44.488531	2025-07-18 16:43:44.490518
326	326	195000	2025-07-18 16:43:44.491517	2025-07-18 16:43:44.492563
327	327	4752	2025-07-18 16:43:44.493563	2025-07-18 16:43:44.496549
328	328	4752	2025-07-18 16:43:44.496549	2025-07-18 16:43:44.498549
329	329	6963	2025-07-18 16:43:44.498549	2025-07-18 16:43:44.500563
330	330	11165	2025-07-18 16:43:44.500563	2025-07-18 16:43:44.502549
331	331	11165	2025-07-18 16:43:44.502549	2025-07-18 16:43:44.505532
332	332	17259	2025-07-18 16:43:44.505532	2025-07-18 16:43:44.50807
333	333	17259	2025-07-18 16:43:44.50807	2025-07-18 16:43:44.511073
334	334	8767	2025-07-18 16:43:44.511073	2025-07-18 16:43:44.513087
335	335	15466	2025-07-18 16:43:44.513087	2025-07-18 16:43:44.516087
336	336	19500	2025-07-18 16:43:44.516087	2025-07-18 16:43:44.518073
337	337	20000	2025-07-18 16:43:44.51907	2025-07-18 16:43:44.52007
338	338	10000	2025-07-18 16:43:44.521087	2025-07-18 16:43:44.523087
339	339	250000	2025-07-18 16:43:44.523087	2025-07-18 16:43:44.526087
340	340	160000	2025-07-18 16:43:44.526087	2025-07-18 16:43:44.528087
341	341	250000	2025-07-18 16:43:44.529073	2025-07-18 16:43:44.53007
342	342	510000	2025-07-18 16:43:44.531073	2025-07-18 16:43:44.533087
343	343	1340000	2025-07-18 16:43:44.533087	2025-07-18 16:43:44.535087
344	344	270000	2025-07-18 16:43:44.536072	2025-07-18 16:43:44.538087
345	345	570000	2025-07-18 16:43:44.538087	2025-07-18 16:43:44.540072
346	346	580000	2025-07-18 16:43:44.540072	2025-07-18 16:43:44.542087
347	347	1240000	2025-07-18 16:43:44.542087	2025-07-18 16:43:44.545134
348	348	750000	2025-07-18 16:43:44.545134	2025-07-18 16:43:44.547134
349	349	145000	2025-07-18 16:43:44.547134	2025-07-18 16:43:44.550104
350	350	30000	2025-07-18 16:43:44.550104	2025-07-18 16:43:44.55312
351	351	20000	2025-07-18 16:43:44.55312	2025-07-18 16:43:44.555118
352	352	20000	2025-07-18 16:43:44.555118	2025-07-18 16:43:44.557134
353	353	7000	2025-07-18 16:43:44.557644	2025-07-18 16:43:44.559691
354	354	38000	2025-07-18 16:43:44.559691	2025-07-18 16:43:44.561674
355	355	58000	2025-07-18 16:43:44.561674	2025-07-18 16:43:44.563677
356	356	340000	2025-07-18 16:43:44.563677	2025-07-18 16:43:44.564674
357	357	340000	2025-07-18 16:43:44.565677	2025-07-18 16:43:44.566677
358	358	30000	2025-07-18 16:43:44.566677	2025-07-18 16:43:44.568691
359	359	190000	2025-07-18 16:43:44.568691	2025-07-18 16:43:44.571738
360	360	15000	2025-07-18 16:43:44.571738	2025-07-18 16:43:44.5747
361	361	25000	2025-07-18 16:43:44.5747	2025-07-18 16:43:44.576423
362	362	40000	2025-07-18 16:43:44.577697	2025-07-18 16:43:44.579752
363	363	25000	2025-07-18 16:43:44.579752	2025-07-18 16:43:44.582303
364	364	66000	2025-07-18 16:43:44.58281	2025-07-18 16:43:44.585151
365	365	28500	2025-07-18 16:43:44.585151	2025-07-18 16:43:44.588184
366	366	46000	2025-07-18 16:43:44.589199	2025-07-18 16:43:44.590186
367	367	110000	2025-07-18 16:43:44.591186	2025-07-18 16:43:44.593246
368	368	128000	2025-07-18 16:43:44.593246	2025-07-18 16:43:44.596233
369	369	12000	2025-07-18 16:43:44.596233	2025-07-18 16:43:44.598247
370	370	2500	2025-07-18 16:43:44.598247	2025-07-18 16:43:44.600246
371	371	3500	2025-07-18 16:43:44.601233	2025-07-18 16:43:44.603233
372	372	8000	2025-07-18 16:43:44.603233	2025-07-18 16:43:44.605246
373	373	192000	2025-07-18 16:43:44.606235	2025-07-18 16:43:44.608772
374	374	45000	2025-07-18 16:43:44.608772	2025-07-18 16:43:44.610758
375	375	2500	2025-07-18 16:43:44.610758	2025-07-18 16:43:44.612772
376	376	3500	2025-07-18 16:43:44.612772	2025-07-18 16:43:44.615772
377	377	4500	2025-07-18 16:43:44.615772	2025-07-18 16:43:44.618773
378	378	10000	2025-07-18 16:43:44.618773	2025-07-18 16:43:44.620758
379	379	195000	2025-07-18 16:43:44.620758	2025-07-18 16:43:44.622772
380	380	372000	2025-07-18 16:43:44.622772	2025-07-18 16:43:44.625773
381	381	80000	2025-07-18 16:43:44.625773	2025-07-18 16:43:44.627772
382	382	17500	2025-07-18 16:43:44.62876	2025-07-18 16:43:44.630773
383	383	17000	2025-07-18 16:43:44.630773	2025-07-18 16:43:44.632772
384	384	28000	2025-07-18 16:43:44.632772	2025-07-18 16:43:44.634772
385	385	31000	2025-07-18 16:43:44.634772	2025-07-18 16:43:44.636772
386	386	65000	2025-07-18 16:43:44.636772	2025-07-18 16:43:44.640739
387	387	4500	2025-07-18 16:43:44.640739	2025-07-18 16:43:44.643784
388	388	430000	2025-07-18 16:43:44.643784	2025-07-18 16:43:44.645783
389	389	198000	2025-07-18 16:43:44.645783	2025-07-18 16:43:44.647783
390	390	35000	2025-07-18 16:43:44.647783	2025-07-18 16:43:44.650793
391	391	55000	2025-07-18 16:43:44.651769	2025-07-18 16:43:44.654783
392	392	125000	2025-07-18 16:43:44.654783	2025-07-18 16:43:44.657783
393	393	95000	2025-07-18 16:43:44.658299	2025-07-18 16:43:44.660347
394	394	170000	2025-07-18 16:43:44.660347	2025-07-18 16:43:44.662336
395	395	45000	2025-07-18 16:43:44.662336	2025-07-18 16:43:44.664333
396	396	110000	2025-07-18 16:43:44.665333	2025-07-18 16:43:44.666333
397	397	170000	2025-07-18 16:43:44.666333	2025-07-18 16:43:44.668348
398	398	75000	2025-07-18 16:43:44.668348	2025-07-18 16:43:44.670381
399	399	110000	2025-07-18 16:43:44.670381	2025-07-18 16:43:44.67338
400	400	120000	2025-07-18 16:43:44.674381	2025-07-18 16:43:44.676395
401	401	220000	2025-07-18 16:43:44.676395	2025-07-18 16:43:44.678381
402	402	750000	2025-07-18 16:43:44.678381	2025-07-18 16:43:44.679381
403	403	450000	2025-07-18 16:43:44.679381	2025-07-18 16:43:44.681395
404	404	15000	2025-07-18 16:43:44.682396	2025-07-18 16:43:44.684988
405	405	110000	2025-07-18 16:43:44.684988	2025-07-18 16:43:44.687978
406	406	100000	2025-07-18 16:43:44.687978	2025-07-18 16:43:44.689992
407	407	90000	2025-07-18 16:43:44.689992	2025-07-18 16:43:44.692993
408	408	1850000	2025-07-18 16:43:44.692993	2025-07-18 16:43:44.696026
409	409	280000	2025-07-18 16:43:44.696026	2025-07-18 16:43:44.69804
410	410	450000	2025-07-18 16:43:44.69904	2025-07-18 16:43:44.70104
411	411	150000	2025-07-18 16:43:44.70104	2025-07-18 16:43:44.703039
412	412	2500000	2025-07-18 16:43:44.704026	2025-07-18 16:43:44.70604
413	413	1960000	2025-07-18 16:43:44.70604	2025-07-18 16:43:44.708562
414	414	20000	2025-07-18 16:43:44.708562	2025-07-18 16:43:44.71061
415	415	20000	2025-07-18 16:43:44.71061	2025-07-18 16:43:44.71261
416	416	20000	2025-07-18 16:43:44.713611	2025-07-18 16:43:44.71561
417	417	25000	2025-07-18 16:43:44.71561	2025-07-18 16:43:44.717598
418	418	22000	2025-07-18 16:43:44.718596	2025-07-18 16:43:44.720596
419	419	40000	2025-07-18 16:43:44.720596	2025-07-18 16:43:44.72261
420	420	35000	2025-07-18 16:43:44.72261	2025-07-18 16:43:44.72461
421	421	15000	2025-07-18 16:43:44.72461	2025-07-18 16:43:44.72761
422	422	40000	2025-07-18 16:43:44.72761	2025-07-18 16:43:44.730596
423	423	15000	2025-07-18 16:43:44.730596	2025-07-18 16:43:44.73361
424	424	35000	2025-07-18 16:43:44.73361	2025-07-18 16:43:44.735596
425	425	25000	2025-07-18 16:43:44.735596	2025-07-18 16:43:44.73761
426	426	260000	2025-07-18 16:43:44.73761	2025-07-18 16:43:44.741597
427	427	125000	2025-07-18 16:43:44.741597	2025-07-18 16:43:44.742596
428	428	55000	2025-07-18 16:43:44.743642	2025-07-18 16:43:44.745642
429	429	25000	2025-07-18 16:43:44.745642	2025-07-18 16:43:44.747642
430	430	20000	2025-07-18 16:43:44.747642	2025-07-18 16:43:44.750663
431	431	20000	2025-07-18 16:43:44.751629	2025-07-18 16:43:44.753628
432	432	80000	2025-07-18 16:43:44.754642	2025-07-18 16:43:44.755643
433	433	20000	2025-07-18 16:43:44.756628	2025-07-18 16:43:44.758173
434	434	95000	2025-07-18 16:43:44.758173	2025-07-18 16:43:44.761224
435	435	50000	2025-07-18 16:43:44.761224	2025-07-18 16:43:44.76421
436	436	20000	2025-07-18 16:43:44.76421	2025-07-18 16:43:44.766224
437	437	45000	2025-07-18 16:43:44.766224	2025-07-18 16:43:44.768224
438	438	110000	2025-07-18 16:43:44.768224	2025-07-18 16:43:44.770271
439	439	260000	2025-07-18 16:43:44.771257	2025-07-18 16:43:44.773242
440	440	1850000	2025-07-18 16:43:44.774257	2025-07-18 16:43:44.776271
441	441	600000	2025-07-18 16:43:44.777257	2025-07-18 16:43:44.779271
442	442	1000	2025-07-18 16:43:44.779271	2025-07-18 16:43:44.781271
443	443	750000	2025-07-18 16:43:44.782257	2025-07-18 16:43:44.785805
444	444	150000	2025-07-18 16:43:44.785805	2025-07-18 16:43:44.787791
445	445	400000	2025-07-18 16:43:44.787791	2025-07-18 16:43:44.789805
446	446	700000	2025-07-18 16:43:44.789805	2025-07-18 16:43:44.791805
447	447	740000	2025-07-18 16:43:44.792806	2025-07-18 16:43:44.794853
448	448	100000	2025-07-18 16:43:44.795839	2025-07-18 16:43:44.798554
449	449	60000	2025-07-18 16:43:44.799576	2025-07-18 16:43:44.801646
450	450	160000	2025-07-18 16:43:44.802161	2025-07-18 16:43:44.803174
451	451	90000	2025-07-18 16:43:44.803174	2025-07-18 16:43:44.807477
452	452	25000	2025-07-18 16:43:44.807477	2025-07-18 16:43:44.810033
453	453	50000	2025-07-18 16:43:44.810033	2025-07-18 16:43:44.812033
454	454	65000	2025-07-18 16:43:44.813034	2025-07-18 16:43:44.815033
455	455	1450000	2025-07-18 16:43:44.815033	2025-07-18 16:43:44.818033
456	456	400000	2025-07-18 16:43:44.818033	2025-07-18 16:43:44.821017
457	457	550000	2025-07-18 16:43:44.821017	2025-07-18 16:43:44.823033
458	458	600000	2025-07-18 16:43:44.823033	2025-07-18 16:43:44.825033
459	459	600000	2025-07-18 16:43:44.826033	2025-07-18 16:43:44.829019
460	460	150000	2025-07-18 16:43:44.829019	2025-07-18 16:43:44.831035
461	461	850000	2025-07-18 16:43:44.831035	2025-07-18 16:43:44.833046
462	462	1950000	2025-07-18 16:43:44.833046	2025-07-18 16:43:44.836045
463	463	4300000	2025-07-18 16:43:44.836045	2025-07-18 16:43:44.83806
464	464	2050000	2025-07-18 16:43:44.83806	2025-07-18 16:43:44.840059
465	465	520000	2025-07-18 16:43:44.841045	2025-07-18 16:43:44.842046
466	466	950000	2025-07-18 16:43:44.843045	2025-07-18 16:43:44.845091
467	467	1350000	2025-07-18 16:43:44.845091	2025-07-18 16:43:44.847091
468	468	1250000	2025-07-18 16:43:44.847091	2025-07-18 16:43:44.850091
469	469	1950000	2025-07-18 16:43:44.850091	2025-07-18 16:43:44.85308
470	470	1450000	2025-07-18 16:43:44.85308	2025-07-18 16:43:44.854077
471	471	600000	2025-07-18 16:43:44.854077	2025-07-18 16:43:44.856092
472	472	350000	2025-07-18 16:43:44.856092	2025-07-18 16:43:44.858622
473	473	400000	2025-07-18 16:43:44.858622	2025-07-18 16:43:44.86067
474	474	700000	2025-07-18 16:43:44.86067	2025-07-18 16:43:44.863671
475	475	1900000	2025-07-18 16:43:44.863671	2025-07-18 16:43:44.86667
476	476	200000	2025-07-18 16:43:44.86767	2025-07-18 16:43:44.868657
477	477	250000	2025-07-18 16:43:44.869689	2025-07-18 16:43:44.871703
478	478	850000	2025-07-18 16:43:44.871703	2025-07-18 16:43:44.873702
479	479	150000	2025-07-18 16:43:44.874689	2025-07-18 16:43:44.876687
480	480	250000	2025-07-18 16:43:44.876687	2025-07-18 16:43:44.878683
481	481	950000	2025-07-18 16:43:44.879691	2025-07-18 16:43:44.881689
482	482	1400000	2025-07-18 16:43:44.881689	2025-07-18 16:43:44.882747
483	483	510000	2025-07-18 16:43:44.88428	2025-07-18 16:43:44.886315
484	484	1050000	2025-07-18 16:43:44.887315	2025-07-18 16:43:44.889328
485	485	2180000	2025-07-18 16:43:44.890329	2025-07-18 16:43:44.892314
486	486	350000	2025-07-18 16:43:44.892314	2025-07-18 16:43:44.894376
487	487	150000	2025-07-18 16:43:44.894376	2025-07-18 16:43:44.897381
488	488	360000	2025-07-18 16:43:44.897381	2025-07-18 16:43:44.899377
489	489	0	2025-07-18 16:43:44.900376	2025-07-18 16:43:44.902376
490	490	350000	2025-07-18 16:43:44.902376	2025-07-18 16:43:44.905378
491	491	1250000	2025-07-18 16:43:44.905378	2025-07-18 16:43:44.908915
492	492	1350000	2025-07-18 16:43:44.909476	2025-07-18 16:43:44.912498
493	493	350000	2025-07-18 16:43:44.912498	2025-07-18 16:43:44.914498
494	494	1350000	2025-07-18 16:43:44.914498	2025-07-18 16:43:44.916523
495	495	1350000	2025-07-18 16:43:44.916523	2025-07-18 16:43:44.919532
496	496	1280000	2025-07-18 16:43:44.919532	2025-07-18 16:43:44.921509
497	497	1230000	2025-07-18 16:43:44.922509	2025-07-18 16:43:44.924509
498	498	1300000	2025-07-18 16:43:44.924509	2025-07-18 16:43:44.926523
499	499	450000	2025-07-18 16:43:44.926523	2025-07-18 16:43:44.929524
500	500	360000	2025-07-18 16:43:44.929524	2025-07-18 16:43:44.931509
501	501	13200	2025-07-18 16:43:44.931509	2025-07-18 16:43:44.933523
502	502	8000	2025-07-18 16:43:44.934509	2025-07-18 16:43:44.936523
503	503	8000	2025-07-18 16:43:44.936523	2025-07-18 16:43:44.938523
504	504	15000	2025-07-18 16:43:44.938523	2025-07-18 16:43:44.941524
505	505	25000	2025-07-18 16:43:44.941524	2025-07-18 16:43:44.943509
506	506	40000	2025-07-18 16:43:44.943509	2025-07-18 16:43:44.945555
507	507	6100	2025-07-18 16:43:44.945555	2025-07-18 16:43:44.948555
508	508	130000	2025-07-18 16:43:44.948555	2025-07-18 16:43:44.950555
509	509	70000	2025-07-18 16:43:44.950555	2025-07-18 16:43:44.952539
510	510	182000	2025-07-18 16:43:44.952539	2025-07-18 16:43:44.954556
511	511	25000	2025-07-18 16:43:44.954556	2025-07-18 16:43:44.955555
512	512	45000	2025-07-18 16:43:44.955555	2025-07-18 16:43:44.958555
513	513	15000	2025-07-18 16:43:44.9591	2025-07-18 16:43:44.962137
514	514	25000	2025-07-18 16:43:44.962137	2025-07-18 16:43:44.966137
515	515	45000	2025-07-18 16:43:44.966137	2025-07-18 16:43:44.968151
516	516	10000	2025-07-18 16:43:44.968151	2025-07-18 16:43:44.971198
517	517	25000	2025-07-18 16:43:44.971198	2025-07-18 16:43:44.974174
518	518	25000	2025-07-18 16:43:44.974174	2025-07-18 16:43:44.975187
519	519	35000	2025-07-18 16:43:44.975187	2025-07-18 16:43:44.977184
520	520	25000	2025-07-18 16:43:44.977184	2025-07-18 16:43:44.979198
521	521	2000	2025-07-18 16:43:44.979198	2025-07-18 16:43:44.981198
522	522	6000	2025-07-18 16:43:44.982199	2025-07-18 16:43:44.984718
523	523	3000	2025-07-18 16:43:44.984718	2025-07-18 16:43:44.986767
524	524	12000	2025-07-18 16:43:44.987753	2025-07-18 16:43:44.989767
525	525	5000	2025-07-18 16:43:44.989767	2025-07-18 16:43:44.991768
526	526	6000	2025-07-18 16:43:44.991768	2025-07-18 16:43:44.993767
527	527	13000	2025-07-18 16:43:44.993767	2025-07-18 16:43:44.996816
528	528	7000	2025-07-18 16:43:44.996816	2025-07-18 16:43:44.9988
529	529	7000	2025-07-18 16:43:44.9988	2025-07-18 16:43:45.000814
530	530	15000	2025-07-18 16:43:45.000814	2025-07-18 16:43:45.002814
531	531	12000	2025-07-18 16:43:45.003814	2025-07-18 16:43:45.005815
532	532	10000	2025-07-18 16:43:45.006802	2025-07-18 16:43:45.009365
533	533	10000	2025-07-18 16:43:45.009365	2025-07-18 16:43:45.011401
534	534	20000	2025-07-18 16:43:45.011401	2025-07-18 16:43:45.013416
535	535	120000	2025-07-18 16:43:45.013416	2025-07-18 16:43:45.017218
536	536	50000	2025-07-18 16:43:45.017218	2025-07-18 16:43:45.01994
537	537	20000	2025-07-18 16:43:45.01994	2025-07-18 16:43:45.02194
538	538	18000	2025-07-18 16:43:45.02194	2025-07-18 16:43:45.023954
539	539	20000	2025-07-18 16:43:45.023954	2025-07-18 16:43:45.025954
540	540	70000	2025-07-18 16:43:45.025954	2025-07-18 16:43:45.028955
541	541	5000	2025-07-18 16:43:45.028955	2025-07-18 16:43:45.031955
542	542	30000	2025-07-18 16:43:45.031955	2025-07-18 16:43:45.03394
543	543	20000	2025-07-18 16:43:45.03394	2025-07-18 16:43:45.035954
544	544	25000	2025-07-18 16:43:45.035954	2025-07-18 16:43:45.037954
545	545	480000	2025-07-18 16:43:45.037954	2025-07-18 16:43:45.040955
546	546	15000	2025-07-18 16:43:45.040955	2025-07-18 16:43:45.042941
547	547	2500	2025-07-18 16:43:45.042941	2025-07-18 16:43:45.044986
548	548	15000	2025-07-18 16:43:45.044986	2025-07-18 16:43:45.047986
549	549	15000	2025-07-18 16:43:45.047986	2025-07-18 16:43:45.050001
550	550	17000	2025-07-18 16:43:45.050001	2025-07-18 16:43:45.052986
551	551	20000	2025-07-18 16:43:45.052986	2025-07-18 16:43:45.054986
552	552	35000	2025-07-18 16:43:45.054986	2025-07-18 16:43:45.056986
553	553	45000	2025-07-18 16:43:45.057974	2025-07-18 16:43:45.059518
554	554	13000	2025-07-18 16:43:45.059518	2025-07-18 16:43:45.062569
555	555	65000	2025-07-18 16:43:45.062569	2025-07-18 16:43:45.064555
556	556	40000	2025-07-18 16:43:45.064555	2025-07-18 16:43:45.065553
557	557	55000	2025-07-18 16:43:45.066555	2025-07-18 16:43:45.06857
558	558	60000	2025-07-18 16:43:45.06857	2025-07-18 16:43:45.070617
559	559	65000	2025-07-18 16:43:45.070617	2025-07-18 16:43:45.073619
560	560	35000	2025-07-18 16:43:45.073619	2025-07-18 16:43:45.076603
561	561	50000	2025-07-18 16:43:45.076603	2025-07-18 16:43:45.079617
562	562	150000	2025-07-18 16:43:45.079617	2025-07-18 16:43:45.082603
563	563	10000	2025-07-18 16:43:45.082603	2025-07-18 16:43:45.085199
564	564	4000	2025-07-18 16:43:45.085199	2025-07-18 16:43:45.087199
565	565	50000	2025-07-18 16:43:45.0882	2025-07-18 16:43:45.090199
566	566	3000	2025-07-18 16:43:45.090199	2025-07-18 16:43:45.092199
567	567	10000	2025-07-18 16:43:45.092199	2025-07-18 16:43:45.094199
568	568	100000	2025-07-18 16:43:45.095234	2025-07-18 16:43:45.097231
569	569	45000	2025-07-18 16:43:45.098247	2025-07-18 16:43:45.099234
570	570	130000	2025-07-18 16:43:45.100233	2025-07-18 16:43:45.102248
571	571	55000	2025-07-18 16:43:45.102248	2025-07-18 16:43:45.104247
572	572	165000	2025-07-18 16:43:45.104247	2025-07-18 16:43:45.107233
573	573	520000	2025-07-18 16:43:45.107233	2025-07-18 16:43:45.109785
574	574	650000	2025-07-18 16:43:45.109785	2025-07-18 16:43:45.111833
575	575	950000	2025-07-18 16:43:45.111833	2025-07-18 16:43:45.113819
576	576	120000	2025-07-18 16:43:45.113819	2025-07-18 16:43:45.115833
577	577	50000	2025-07-18 16:43:45.115833	2025-07-18 16:43:45.118833
578	578	40000	2025-07-18 16:43:45.119833	2025-07-18 16:43:45.120819
579	579	45000	2025-07-18 16:43:45.121819	2025-07-18 16:43:45.123833
580	580	35000	2025-07-18 16:43:45.123833	2025-07-18 16:43:45.125833
581	581	35000	2025-07-18 16:43:45.125833	2025-07-18 16:43:45.127833
582	582	35000	2025-07-18 16:43:45.128834	2025-07-18 16:43:45.130819
583	583	40000	2025-07-18 16:43:45.130819	2025-07-18 16:43:45.132833
584	584	45000	2025-07-18 16:43:45.132833	2025-07-18 16:43:45.135833
585	585	20000	2025-07-18 16:43:45.135833	2025-07-18 16:43:45.137833
586	586	5000	2025-07-18 16:43:45.137833	2025-07-18 16:43:45.140834
587	587	6000	2025-07-18 16:43:45.140834	2025-07-18 16:43:45.144833
588	588	5000	2025-07-18 16:43:45.144833	2025-07-18 16:43:45.146866
589	589	50000	2025-07-18 16:43:45.146866	2025-07-18 16:43:45.14888
590	590	35000	2025-07-18 16:43:45.14888	2025-07-18 16:43:45.15088
591	591	35000	2025-07-18 16:43:45.151866	2025-07-18 16:43:45.152866
592	592	0	2025-07-18 16:43:45.152866	2025-07-18 16:43:45.154867
593	593	15000	2025-07-18 16:43:45.154867	2025-07-18 16:43:45.156866
594	594	175000	2025-07-18 16:43:45.156866	2025-07-18 16:43:45.15888
595	595	700000	2025-07-18 16:43:45.15888	2025-07-18 16:43:45.162438
596	596	175000	2025-07-18 16:43:45.162438	2025-07-18 16:43:45.165436
597	597	450000	2025-07-18 16:43:45.165436	2025-07-18 16:43:45.167422
598	598	350	2025-07-18 16:43:45.168422	2025-07-18 16:43:45.169468
599	599	1500	2025-07-18 16:43:45.170468	2025-07-18 16:43:45.173454
600	600	30000	2025-07-18 16:43:45.173454	2025-07-18 16:43:45.175478
601	601	2000	2025-07-18 16:43:45.176454	2025-07-18 16:43:45.178454
602	602	3000	2025-07-18 16:43:45.178454	2025-07-18 16:43:45.180469
603	603	3000	2025-07-18 16:43:45.180469	2025-07-18 16:43:45.183468
604	604	3500	2025-07-18 16:43:45.183468	2025-07-18 16:43:45.187018
605	605	15000	2025-07-18 16:43:45.187018	2025-07-18 16:43:45.190018
606	606	12000	2025-07-18 16:43:45.191019	2025-07-18 16:43:45.193018
607	607	1000	2025-07-18 16:43:45.193018	2025-07-18 16:43:45.196053
608	608	1000	2025-07-18 16:43:45.196053	2025-07-18 16:43:45.199074
609	609	1000	2025-07-18 16:43:45.200088	2025-07-18 16:43:45.202087
610	610	15000	2025-07-18 16:43:45.203086	2025-07-18 16:43:45.205751
611	611	15000	2025-07-18 16:43:45.205751	2025-07-18 16:43:45.20875
612	612	43000	2025-07-18 16:43:45.209751	2025-07-18 16:43:45.212237
613	613	100000	2025-07-18 16:43:45.212237	2025-07-18 16:43:45.21425
614	614	2000	2025-07-18 16:43:45.21425	2025-07-18 16:43:45.21626
615	615	350	2025-07-18 16:43:45.21626	2025-07-18 16:43:45.218274
616	616	1000	2025-07-18 16:43:45.219261	2025-07-18 16:43:45.22126
617	617	12000	2025-07-18 16:43:45.22126	2025-07-18 16:43:45.222298
618	618	2000	2025-07-18 16:43:45.222298	2025-07-18 16:43:45.225594
619	619	3000	2025-07-18 16:43:45.225594	2025-07-18 16:43:45.227289
620	620	4500	2025-07-18 16:43:45.227289	2025-07-18 16:43:45.230966
621	621	1000	2025-07-18 16:43:45.230966	2025-07-18 16:43:45.233999
622	622	2000	2025-07-18 16:43:45.233999	2025-07-18 16:43:45.235998
623	623	90000	2025-07-18 16:43:45.235998	2025-07-18 16:43:45.238999
624	624	250	2025-07-18 16:43:45.238999	2025-07-18 16:43:45.241999
625	625	500	2025-07-18 16:43:45.241999	2025-07-18 16:43:45.243985
626	626	500	2025-07-18 16:43:45.243985	2025-07-18 16:43:45.245999
627	627	500	2025-07-18 16:43:45.245999	2025-07-18 16:43:45.248045
628	628	65000	2025-07-18 16:43:45.248045	2025-07-18 16:43:45.251046
629	629	45000	2025-07-18 16:43:45.251046	2025-07-18 16:43:45.253321
630	630	35000	2025-07-18 16:43:45.253321	2025-07-18 16:43:45.255346
631	631	70000	2025-07-18 16:43:45.255346	2025-07-18 16:43:45.257346
632	632	5000	2025-07-18 16:43:45.258347	2025-07-18 16:43:45.259347
633	633	75000	2025-07-18 16:43:45.259347	2025-07-18 16:43:45.262926
634	634	7000	2025-07-18 16:43:45.262926	2025-07-18 16:43:45.264912
635	635	12000	2025-07-18 16:43:45.264912	2025-07-18 16:43:45.266911
636	636	10000	2025-07-18 16:43:45.266911	2025-07-18 16:43:45.267911
637	637	35000	2025-07-18 16:43:45.268912	2025-07-18 16:43:45.269943
638	638	20000	2025-07-18 16:43:45.269943	2025-07-18 16:43:45.271957
639	639	98700	2025-07-18 16:43:45.271957	2025-07-18 16:43:45.274957
640	640	18000	2025-07-18 16:43:45.275957	2025-07-18 16:43:45.276943
641	641	7000	2025-07-18 16:43:45.276943	2025-07-18 16:43:45.278957
642	642	4000	2025-07-18 16:43:45.279959	2025-07-18 16:43:45.280958
643	643	5000	2025-07-18 16:43:45.281957	2025-07-18 16:43:45.284468
644	644	15000	2025-07-18 16:43:45.284468	2025-07-18 16:43:45.286758
645	645	45000	2025-07-18 16:43:45.286758	2025-07-18 16:43:45.288749
646	646	38000	2025-07-18 16:43:45.289767	2025-07-18 16:43:45.291766
647	647	32000	2025-07-18 16:43:45.291766	2025-07-18 16:43:45.293783
648	648	7000	2025-07-18 16:43:45.293783	2025-07-18 16:43:45.295749
649	649	10000	2025-07-18 16:43:45.296781	2025-07-18 16:43:45.298781
650	650	20000	2025-07-18 16:43:45.299781	2025-07-18 16:43:45.300781
651	651	5000	2025-07-18 16:43:45.300781	2025-07-18 16:43:45.303797
652	652	1000	2025-07-18 16:43:45.303797	2025-07-18 16:43:45.305797
653	653	1000	2025-07-18 16:43:45.305797	2025-07-18 16:43:45.308797
654	654	2000	2025-07-18 16:43:45.308797	2025-07-18 16:43:45.309797
655	655	2000	2025-07-18 16:43:45.309797	2025-07-18 16:43:45.312755
656	656	2000	2025-07-18 16:43:45.312755	2025-07-18 16:43:45.313755
657	657	3000	2025-07-18 16:43:45.313755	2025-07-18 16:43:45.315756
658	658	4000	2025-07-18 16:43:45.315756	2025-07-18 16:43:45.317769
659	659	4000	2025-07-18 16:43:45.317769	2025-07-18 16:43:45.320754
660	660	3000	2025-07-18 16:43:45.320754	2025-07-18 16:43:45.322753
661	661	8000	2025-07-18 16:43:45.322753	2025-07-18 16:43:45.324769
662	662	10000	2025-07-18 16:43:45.324769	2025-07-18 16:43:45.327769
663	663	15000	2025-07-18 16:43:45.327769	2025-07-18 16:43:45.330753
664	664	4000	2025-07-18 16:43:45.330753	2025-07-18 16:43:45.333769
665	665	4000	2025-07-18 16:43:45.333769	2025-07-18 16:43:45.335769
666	666	5000	2025-07-18 16:43:45.335769	2025-07-18 16:43:45.337769
667	667	5000	2025-07-18 16:43:45.33877	2025-07-18 16:43:45.340737
668	668	5000	2025-07-18 16:43:45.340737	2025-07-18 16:43:45.343765
669	669	5000	2025-07-18 16:43:45.343765	2025-07-18 16:43:45.345769
670	670	6000	2025-07-18 16:43:45.345769	2025-07-18 16:43:45.3478
671	671	7000	2025-07-18 16:43:45.3478	2025-07-18 16:43:45.3498
672	672	14000	2025-07-18 16:43:45.350802	2025-07-18 16:43:45.3538
673	673	10000	2025-07-18 16:43:45.3538	2025-07-18 16:43:45.355787
674	674	12000	2025-07-18 16:43:45.355787	2025-07-18 16:43:45.357801
675	675	2000	2025-07-18 16:43:45.357801	2025-07-18 16:43:45.3598
676	676	15000	2025-07-18 16:43:45.3598	2025-07-18 16:43:45.363006
677	677	18000	2025-07-18 16:43:45.363006	2025-07-18 16:43:45.366021
678	678	2000	2025-07-18 16:43:45.367036	2025-07-18 16:43:45.368022
679	679	4000	2025-07-18 16:43:45.369022	2025-07-18 16:43:45.371068
680	680	3000	2025-07-18 16:43:45.371068	2025-07-18 16:43:45.373067
681	681	5000	2025-07-18 16:43:45.373067	2025-07-18 16:43:45.376068
682	682	3500	2025-07-18 16:43:45.376068	2025-07-18 16:43:45.378052
683	683	5000	2025-07-18 16:43:45.378052	2025-07-18 16:43:45.380067
684	684	5000	2025-07-18 16:43:45.380067	2025-07-18 16:43:45.383068
685	685	5000	2025-07-18 16:43:45.383068	2025-07-18 16:43:45.385665
686	686	7000	2025-07-18 16:43:45.385665	2025-07-18 16:43:45.388649
687	687	8000	2025-07-18 16:43:45.388649	2025-07-18 16:43:45.391649
688	688	20000	2025-07-18 16:43:45.391649	2025-07-18 16:43:45.393663
689	689	2000	2025-07-18 16:43:45.393663	2025-07-18 16:43:45.396649
690	690	25000	2025-07-18 16:43:45.396649	2025-07-18 16:43:45.398695
691	691	25000	2025-07-18 16:43:45.398695	2025-07-18 16:43:45.400678
692	692	540000	2025-07-18 16:43:45.401681	2025-07-18 16:43:45.40268
693	693	620000	2025-07-18 16:43:45.40268	2025-07-18 16:43:45.404681
694	694	100000	2025-07-18 16:43:45.404681	2025-07-18 16:43:45.406665
695	695	8000	2025-07-18 16:43:45.406665	2025-07-18 16:43:45.40998
696	696	10000	2025-07-18 16:43:45.40998	2025-07-18 16:43:45.411014
697	697	20000	2025-07-18 16:43:45.411014	2025-07-18 16:43:45.413595
698	698	125000	2025-07-18 16:43:45.413595	2025-07-18 16:43:45.415595
699	699	55000	2025-07-18 16:43:45.416595	2025-07-18 16:43:45.419568
700	700	35000	2025-07-18 16:43:45.419568	2025-07-18 16:43:45.422595
701	701	10000	2025-07-18 16:43:45.422595	2025-07-18 16:43:45.424595
702	702	10000	2025-07-18 16:43:45.424595	2025-07-18 16:43:45.426595
703	703	50000	2025-07-18 16:43:45.427596	2025-07-18 16:43:45.429566
704	704	18000	2025-07-18 16:43:45.430581	2025-07-18 16:43:45.433595
705	705	145000	2025-07-18 16:43:45.433595	2025-07-18 16:43:45.435581
706	706	45000	2025-07-18 16:43:45.435581	2025-07-18 16:43:45.437595
707	707	15000	2025-07-18 16:43:45.437595	2025-07-18 16:43:45.441383
708	708	25000	2025-07-18 16:43:45.441383	2025-07-18 16:43:45.443621
709	709	35000	2025-07-18 16:43:45.444671	2025-07-18 16:43:45.446218
710	710	35000	2025-07-18 16:43:45.446218	2025-07-18 16:43:45.44831
711	711	100000	2025-07-18 16:43:45.44831	2025-07-18 16:43:45.451545
712	712	20000	2025-07-18 16:43:45.452545	2025-07-18 16:43:45.455547
713	713	15000	2025-07-18 16:43:45.455547	2025-07-18 16:43:45.45756
714	714	15000	2025-07-18 16:43:45.45756	2025-07-18 16:43:45.459547
715	715	10000	2025-07-18 16:43:45.459547	2025-07-18 16:43:45.461563
716	716	10000	2025-07-18 16:43:45.461563	2025-07-18 16:43:45.46474
717	717	15000	2025-07-18 16:43:45.46474	2025-07-18 16:43:45.468045
718	718	25000	2025-07-18 16:43:45.468756	2025-07-18 16:43:45.470808
719	719	15000	2025-07-18 16:43:45.470808	2025-07-18 16:43:45.472808
720	720	10000	2025-07-18 16:43:45.472808	2025-07-18 16:43:45.475774
721	721	10000	2025-07-18 16:43:45.475774	2025-07-18 16:43:45.477808
722	722	15000	2025-07-18 16:43:45.478808	2025-07-18 16:43:45.480808
723	723	70000	2025-07-18 16:43:45.480808	2025-07-18 16:43:45.483119
724	724	35000	2025-07-18 16:43:45.483119	2025-07-18 16:43:45.486699
725	725	6500	2025-07-18 16:43:45.486699	2025-07-18 16:43:45.488685
726	726	2500	2025-07-18 16:43:45.488685	2025-07-18 16:43:45.490699
727	727	41000	2025-07-18 16:43:45.490699	2025-07-18 16:43:45.492699
728	728	50000	2025-07-18 16:43:45.493685	2025-07-18 16:43:45.495692
729	729	90000	2025-07-18 16:43:45.495692	2025-07-18 16:43:45.497665
730	730	250000	2025-07-18 16:43:45.498694	2025-07-18 16:43:45.500696
731	731	11000	2025-07-18 16:43:45.500696	2025-07-18 16:43:45.50271
732	732	250000	2025-07-18 16:43:45.50271	2025-07-18 16:43:45.505694
733	733	15000	2025-07-18 16:43:45.505694	2025-07-18 16:43:45.508696
734	734	10000	2025-07-18 16:43:45.50971	2025-07-18 16:43:45.510696
735	735	10000	2025-07-18 16:43:45.511696	2025-07-18 16:43:45.513226
736	736	20000	2025-07-18 16:43:45.513226	2025-07-18 16:43:45.515275
737	737	60000	2025-07-18 16:43:45.515275	2025-07-18 16:43:45.51926
738	738	26000	2025-07-18 16:43:45.51926	2025-07-18 16:43:45.522258
739	739	70000	2025-07-18 16:43:45.522258	2025-07-18 16:43:45.524275
740	740	35000	2025-07-18 16:43:45.524275	2025-07-18 16:43:45.526275
741	741	45000	2025-07-18 16:43:45.526275	2025-07-18 16:43:45.529245
742	742	40000	2025-07-18 16:43:45.529245	2025-07-18 16:43:45.532258
743	743	40000	2025-07-18 16:43:45.532258	2025-07-18 16:43:45.534275
744	744	45000	2025-07-18 16:43:45.534275	2025-07-18 16:43:45.536274
745	745	130000	2025-07-18 16:43:45.536274	2025-07-18 16:43:45.538275
746	746	95000	2025-07-18 16:43:45.538275	2025-07-18 16:43:45.541259
747	747	25000	2025-07-18 16:43:45.541259	2025-07-18 16:43:45.543261
748	748	50000	2025-07-18 16:43:45.544259	2025-07-18 16:43:45.546275
749	749	60000	2025-07-18 16:43:45.546275	2025-07-18 16:43:45.548323
750	750	40000	2025-07-18 16:43:45.548323	2025-07-18 16:43:45.550323
751	751	50000	2025-07-18 16:43:45.551331	2025-07-18 16:43:45.55331
752	752	3000	2025-07-18 16:43:45.55331	2025-07-18 16:43:45.55531
753	753	50000	2025-07-18 16:43:45.55531	2025-07-18 16:43:45.558324
754	754	3000	2025-07-18 16:43:45.558324	2025-07-18 16:43:45.560324
755	755	15000	2025-07-18 16:43:45.560324	2025-07-18 16:43:45.562867
756	756	30000	2025-07-18 16:43:45.562867	2025-07-18 16:43:45.56488
757	757	30000	2025-07-18 16:43:45.56488	2025-07-18 16:43:45.566902
758	758	0	2025-07-18 16:43:45.567902	2025-07-18 16:43:45.569965
759	759	4500	2025-07-18 16:43:45.569965	2025-07-18 16:43:45.571965
760	760	70000	2025-07-18 16:43:45.571965	2025-07-18 16:43:45.574949
761	761	50000	2025-07-18 16:43:45.575949	2025-07-18 16:43:45.57695
762	762	550000	2025-07-18 16:43:45.57695	2025-07-18 16:43:45.579965
763	763	570000	2025-07-18 16:43:45.579965	2025-07-18 16:43:45.581932
764	764	50000	2025-07-18 16:43:45.581932	2025-07-18 16:43:45.583949
765	765	70000	2025-07-18 16:43:45.584929	2025-07-18 16:43:45.586983
766	766	8000	2025-07-18 16:43:45.586983	2025-07-18 16:43:45.590005
767	767	10000	2025-07-18 16:43:45.590005	2025-07-18 16:43:45.592007
768	768	5000	2025-07-18 16:43:45.592007	2025-07-18 16:43:45.594021
769	769	6000	2025-07-18 16:43:45.594021	2025-07-18 16:43:45.596021
770	770	25000	2025-07-18 16:43:45.597021	2025-07-18 16:43:45.599013
771	771	120000	2025-07-18 16:43:45.599013	2025-07-18 16:43:45.601028
772	772	110000	2025-07-18 16:43:45.602018	2025-07-18 16:43:45.604029
773	773	110000	2025-07-18 16:43:45.604029	2025-07-18 16:43:45.606028
774	774	15000	2025-07-18 16:43:45.606028	2025-07-18 16:43:45.608992
775	775	200000	2025-07-18 16:43:45.608992	2025-07-18 16:43:45.611029
776	776	20000	2025-07-18 16:43:45.611029	2025-07-18 16:43:45.613015
777	777	20000	2025-07-18 16:43:45.613015	2025-07-18 16:43:45.615316
778	778	40000	2025-07-18 16:43:45.615316	2025-07-18 16:43:45.618303
779	779	8000	2025-07-18 16:43:45.618303	2025-07-18 16:43:45.620316
780	780	8000	2025-07-18 16:43:45.621316	2025-07-18 16:43:45.622316
781	781	10000	2025-07-18 16:43:45.622316	2025-07-18 16:43:45.625332
782	782	5000	2025-07-18 16:43:45.625332	2025-07-18 16:43:45.627332
783	783	5000	2025-07-18 16:43:45.627332	2025-07-18 16:43:45.630316
784	784	55000	2025-07-18 16:43:45.630316	2025-07-18 16:43:45.632318
785	785	225000	2025-07-18 16:43:45.633318	2025-07-18 16:43:45.635319
786	786	300000	2025-07-18 16:43:45.635319	2025-07-18 16:43:45.637332
787	787	45000	2025-07-18 16:43:45.637332	2025-07-18 16:43:45.639332
788	788	150000	2025-07-18 16:43:45.639332	2025-07-18 16:43:45.642314
789	789	65000	2025-07-18 16:43:45.642314	2025-07-18 16:43:45.643316
790	790	75000	2025-07-18 16:43:45.644318	2025-07-18 16:43:45.645318
791	791	150000	2025-07-18 16:43:45.645318	2025-07-18 16:43:45.647318
792	792	75000	2025-07-18 16:43:45.647318	2025-07-18 16:43:45.649349
793	793	35000	2025-07-18 16:43:45.649349	2025-07-18 16:43:45.65233
794	794	90000	2025-07-18 16:43:45.65233	2025-07-18 16:43:45.655348
795	795	150000	2025-07-18 16:43:45.656461	2025-07-18 16:43:45.65733
796	796	50000	2025-07-18 16:43:45.658349	2025-07-18 16:43:45.660364
797	797	30000	2025-07-18 16:43:45.660364	2025-07-18 16:43:45.662326
798	798	35000	2025-07-18 16:43:45.662326	2025-07-18 16:43:45.664497
799	799	30000	2025-07-18 16:43:45.665006	2025-07-18 16:43:45.666548
800	800	30000	2025-07-18 16:43:45.667873	2025-07-18 16:43:45.667873
801	801	30000	2025-07-18 16:43:45.667873	2025-07-18 16:43:45.671201
802	802	65000	2025-07-18 16:43:45.672202	2025-07-18 16:43:45.675165
803	803	35000	2025-07-18 16:43:45.675165	2025-07-18 16:43:45.678186
804	804	120000	2025-07-18 16:43:45.678186	2025-07-18 16:43:45.680187
805	805	100000	2025-07-18 16:43:45.680187	2025-07-18 16:43:45.681188
806	806	15000	2025-07-18 16:43:45.681188	2025-07-18 16:43:45.683201
807	807	140000	2025-07-18 16:43:45.683201	2025-07-18 16:43:45.686658
808	808	45000	2025-07-18 16:43:45.687645	2025-07-18 16:43:45.688644
809	809	130000	2025-07-18 16:43:45.688644	2025-07-18 16:43:45.690645
810	810	25000	2025-07-18 16:43:45.690645	2025-07-18 16:43:45.692645
811	811	132000	2025-07-18 16:43:45.693645	2025-07-18 16:43:45.694642
812	812	5000	2025-07-18 16:43:45.694642	2025-07-18 16:43:45.696645
813	813	95000	2025-07-18 16:43:45.697634	2025-07-18 16:43:45.698666
814	814	270000	2025-07-18 16:43:45.699713	2025-07-18 16:43:45.701712
815	815	360000	2025-07-18 16:43:45.701712	2025-07-18 16:43:45.703712
816	816	360000	2025-07-18 16:43:45.703712	2025-07-18 16:43:45.706713
817	817	8000	2025-07-18 16:43:45.706713	2025-07-18 16:43:45.708712
818	818	3000	2025-07-18 16:43:45.709713	2025-07-18 16:43:45.710699
819	819	5000	2025-07-18 16:43:45.711712	2025-07-18 16:43:45.714228
820	820	5000	2025-07-18 16:43:45.714228	2025-07-18 16:43:45.716277
821	821	5000	2025-07-18 16:43:45.716277	2025-07-18 16:43:45.719244
822	822	1150000	2025-07-18 16:43:45.719244	2025-07-18 16:43:45.722277
823	823	320000	2025-07-18 16:43:45.722277	2025-07-18 16:43:45.724276
824	824	8000	2025-07-18 16:43:45.724276	2025-07-18 16:43:45.727277
825	825	8000	2025-07-18 16:43:45.727277	2025-07-18 16:43:45.729247
826	826	195000	2025-07-18 16:43:45.730244	2025-07-18 16:43:45.732261
827	827	95000	2025-07-18 16:43:45.732261	2025-07-18 16:43:45.734277
828	828	100000	2025-07-18 16:43:45.734277	2025-07-18 16:43:45.737278
829	829	102000	2025-07-18 16:43:45.737278	2025-07-18 16:43:45.739277
830	830	85000	2025-07-18 16:43:45.739277	2025-07-18 16:43:45.742253
831	831	80000	2025-07-18 16:43:45.742253	2025-07-18 16:43:45.745277
832	832	115000	2025-07-18 16:43:45.745277	2025-07-18 16:43:45.747277
833	833	222000	2025-07-18 16:43:45.747277	2025-07-18 16:43:45.750309
834	834	900000	2025-07-18 16:43:45.750309	2025-07-18 16:43:45.752308
835	835	100000	2025-07-18 16:43:45.753302	2025-07-18 16:43:45.756308
836	836	120000	2025-07-18 16:43:45.756308	2025-07-18 16:43:45.758294
837	837	185000	2025-07-18 16:43:45.758294	2025-07-18 16:43:45.759294
838	838	165000	2025-07-18 16:43:45.759294	2025-07-18 16:43:45.761308
839	839	180000	2025-07-18 16:43:45.762309	2025-07-18 16:43:45.76384
840	840	260000	2025-07-18 16:43:45.76384	2025-07-18 16:43:45.766888
841	841	165000	2025-07-18 16:43:45.766888	2025-07-18 16:43:45.768888
842	842	380000	2025-07-18 16:43:45.768888	2025-07-18 16:43:45.771928
843	843	870000	2025-07-18 16:43:45.771928	2025-07-18 16:43:45.773898
844	844	135000	2025-07-18 16:43:45.773898	2025-07-18 16:43:45.776912
845	845	60000	2025-07-18 16:43:45.776912	2025-07-18 16:43:45.778927
846	846	50000	2025-07-18 16:43:45.778927	2025-07-18 16:43:45.780927
847	847	60000	2025-07-18 16:43:45.780927	2025-07-18 16:43:45.782927
848	848	43000	2025-07-18 16:43:45.783928	2025-07-18 16:43:45.786539
849	849	60000	2025-07-18 16:43:45.786539	2025-07-18 16:43:45.788508
850	850	165000	2025-07-18 16:43:45.788508	2025-07-18 16:43:45.790524
851	851	110000	2025-07-18 16:43:45.790524	2025-07-18 16:43:45.792524
852	852	300000	2025-07-18 16:43:45.792524	2025-07-18 16:43:45.795524
853	853	76000	2025-07-18 16:43:45.796511	2025-07-18 16:43:45.798974
854	854	80000	2025-07-18 16:43:45.798974	2025-07-18 16:43:45.800019
855	855	350000	2025-07-18 16:43:45.801019	2025-07-18 16:43:45.803033
856	856	1650000	2025-07-18 16:43:45.803033	2025-07-18 16:43:45.805032
857	857	860000	2025-07-18 16:43:45.805032	2025-07-18 16:43:45.808034
858	858	750000	2025-07-18 16:43:45.808034	2025-07-18 16:43:45.811033
859	859	850000	2025-07-18 16:43:45.811033	2025-07-18 16:43:45.813032
860	860	50000	2025-07-18 16:43:45.814032	2025-07-18 16:43:45.815452
861	861	150000	2025-07-18 16:43:45.816454	2025-07-18 16:43:45.818452
862	862	500000	2025-07-18 16:43:45.818452	2025-07-18 16:43:45.821453
863	863	400000	2025-07-18 16:43:45.821453	2025-07-18 16:43:45.823452
864	864	520000	2025-07-18 16:43:45.823452	2025-07-18 16:43:45.825452
865	865	95000	2025-07-18 16:43:45.825452	2025-07-18 16:43:45.827452
866	866	40000	2025-07-18 16:43:45.82844	2025-07-18 16:43:45.829453
867	867	35000	2025-07-18 16:43:45.830467	2025-07-18 16:43:45.832452
868	868	22000	2025-07-18 16:43:45.832452	2025-07-18 16:43:45.835452
869	869	20000	2025-07-18 16:43:45.835452	2025-07-18 16:43:45.837452
870	870	20000	2025-07-18 16:43:45.837452	2025-07-18 16:43:45.839452
871	871	32000	2025-07-18 16:43:45.840451	2025-07-18 16:43:45.842438
872	872	32000	2025-07-18 16:43:45.843452	2025-07-18 16:43:45.845453
873	873	32000	2025-07-18 16:43:45.845453	2025-07-18 16:43:45.847452
874	874	50000	2025-07-18 16:43:45.847452	2025-07-18 16:43:45.849452
875	875	35000	2025-07-18 16:43:45.849452	2025-07-18 16:43:45.851493
876	876	35000	2025-07-18 16:43:45.851493	2025-07-18 16:43:45.853486
877	877	35000	2025-07-18 16:43:45.853486	2025-07-18 16:43:45.857499
878	878	32000	2025-07-18 16:43:45.857499	2025-07-18 16:43:45.860499
879	879	32000	2025-07-18 16:43:45.861499	2025-07-18 16:43:45.8645
880	880	32000	2025-07-18 16:43:45.8645	2025-07-18 16:43:45.867021
881	881	240000	2025-07-18 16:43:45.867021	2025-07-18 16:43:45.868876
882	882	500000	2025-07-18 16:43:45.868876	2025-07-18 16:43:45.870882
883	883	40000	2025-07-18 16:43:45.870882	2025-07-18 16:43:45.872883
884	884	35000	2025-07-18 16:43:45.873883	2025-07-18 16:43:45.876885
885	885	30000	2025-07-18 16:43:45.876885	2025-07-18 16:43:45.878465
886	886	45000	2025-07-18 16:43:45.878465	2025-07-18 16:43:45.88146
887	887	50000	2025-07-18 16:43:45.88146	2025-07-18 16:43:45.883175
888	888	50000	2025-07-18 16:43:45.883175	2025-07-18 16:43:45.886819
889	889	50000	2025-07-18 16:43:45.886819	2025-07-18 16:43:45.889357
890	890	45000	2025-07-18 16:43:45.889357	2025-07-18 16:43:45.891416
891	891	50000	2025-07-18 16:43:45.891416	2025-07-18 16:43:45.893433
892	892	40000	2025-07-18 16:43:45.894434	2025-07-18 16:43:45.896432
893	893	50000	2025-07-18 16:43:45.89742	2025-07-18 16:43:45.898417
894	894	570000	2025-07-18 16:43:45.899433	2025-07-18 16:43:45.90048
895	895	650000	2025-07-18 16:43:45.901465	2025-07-18 16:43:45.90248
896	896	700000	2025-07-18 16:43:45.903479	2025-07-18 16:43:45.905479
897	897	800000	2025-07-18 16:43:45.906481	2025-07-18 16:43:45.909464
898	898	220000	2025-07-18 16:43:45.909464	2025-07-18 16:43:45.911465
899	899	550000	2025-07-18 16:43:45.911465	2025-07-18 16:43:45.913482
900	900	297000	2025-07-18 16:43:45.915012	2025-07-18 16:43:45.916021
901	901	425000	2025-07-18 16:43:45.917045	2025-07-18 16:43:45.919062
902	902	1900000	2025-07-18 16:43:45.919062	2025-07-18 16:43:45.921045
903	903	120000	2025-07-18 16:43:45.921045	2025-07-18 16:43:45.92306
904	904	170000	2025-07-18 16:43:45.92306	2025-07-18 16:43:45.926059
905	905	145000	2025-07-18 16:43:45.926059	2025-07-18 16:43:45.928047
906	906	420000	2025-07-18 16:43:45.929044	2025-07-18 16:43:45.931045
907	907	240000	2025-07-18 16:43:45.931045	2025-07-18 16:43:45.933059
908	908	430000	2025-07-18 16:43:45.933059	2025-07-18 16:43:45.936059
909	909	160000	2025-07-18 16:43:45.936059	2025-07-18 16:43:45.938059
910	910	170000	2025-07-18 16:43:45.938059	2025-07-18 16:43:45.941065
911	911	240000	2025-07-18 16:43:45.941065	2025-07-18 16:43:45.944044
912	912	2000	2025-07-18 16:43:45.944044	2025-07-18 16:43:45.946061
913	913	20000	2025-07-18 16:43:45.946061	2025-07-18 16:43:45.948045
914	914	55000	2025-07-18 16:43:45.948045	2025-07-18 16:43:45.950059
915	915	50000	2025-07-18 16:43:45.950059	2025-07-18 16:43:45.953105
916	916	60000	2025-07-18 16:43:45.953105	2025-07-18 16:43:45.95509
917	917	20000	2025-07-18 16:43:45.956092	2025-07-18 16:43:45.957106
918	918	120000	2025-07-18 16:43:45.958106	2025-07-18 16:43:45.960106
919	919	30000	2025-07-18 16:43:45.960106	2025-07-18 16:43:45.962106
920	920	15000	2025-07-18 16:43:45.962106	2025-07-18 16:43:45.965576
921	921	30000	2025-07-18 16:43:45.965576	2025-07-18 16:43:45.967607
922	922	40000	2025-07-18 16:43:45.967607	2025-07-18 16:43:45.969623
923	923	25000	2025-07-18 16:43:45.969623	2025-07-18 16:43:45.971655
924	924	120000	2025-07-18 16:43:45.971655	2025-07-18 16:43:45.974655
925	925	100000	2025-07-18 16:43:45.975641	2025-07-18 16:43:45.978656
926	926	20000	2025-07-18 16:43:45.978656	2025-07-18 16:43:45.980641
927	927	7000	2025-07-18 16:43:45.980641	2025-07-18 16:43:45.982655
928	928	16000	2025-07-18 16:43:45.982655	2025-07-18 16:43:45.985656
929	929	120000	2025-07-18 16:43:45.985656	2025-07-18 16:43:45.98718
930	930	170000	2025-07-18 16:43:45.98718	2025-07-18 16:43:45.989285
931	931	5000	2025-07-18 16:43:45.989285	2025-07-18 16:43:45.993269
932	932	5000	2025-07-18 16:43:45.993269	2025-07-18 16:43:45.997285
933	933	15000	2025-07-18 16:43:45.997285	2025-07-18 16:43:46.000285
934	934	10000	2025-07-18 16:43:46.001288	2025-07-18 16:43:46.002271
935	935	90000	2025-07-18 16:43:46.002271	2025-07-18 16:43:46.004271
936	936	110000	2025-07-18 16:43:46.004271	2025-07-18 16:43:46.005271
937	937	33000	2025-07-18 16:43:46.005271	2025-07-18 16:43:46.008286
938	938	40000	2025-07-18 16:43:46.008286	2025-07-18 16:43:46.009271
939	939	50000	2025-07-18 16:43:46.010271	2025-07-18 16:43:46.011271
940	940	35000	2025-07-18 16:43:46.011271	2025-07-18 16:43:46.014285
941	941	40000	2025-07-18 16:43:46.014285	2025-07-18 16:43:46.016285
942	942	230000	2025-07-18 16:43:46.016285	2025-07-18 16:43:46.019287
943	943	13000	2025-07-18 16:43:46.019287	2025-07-18 16:43:46.022285
944	944	50000	2025-07-18 16:43:46.022285	2025-07-18 16:43:46.024285
945	945	2500	2025-07-18 16:43:46.02527	2025-07-18 16:43:46.027285
946	946	30000	2025-07-18 16:43:46.027285	2025-07-18 16:43:46.029287
947	947	75000	2025-07-18 16:43:46.029287	2025-07-18 16:43:46.032268
948	948	3000	2025-07-18 16:43:46.032268	2025-07-18 16:43:46.033268
949	949	2500	2025-07-18 16:43:46.034285	2025-07-18 16:43:46.036285
950	950	3000	2025-07-18 16:43:46.036285	2025-07-18 16:43:46.039285
951	951	5000	2025-07-18 16:43:46.039285	2025-07-18 16:43:46.041285
952	952	55000	2025-07-18 16:43:46.041285	2025-07-18 16:43:46.043285
953	953	10000	2025-07-18 16:43:46.044271	2025-07-18 16:43:46.045285
954	954	15000	2025-07-18 16:43:46.046285	2025-07-18 16:43:46.048285
955	955	35000	2025-07-18 16:43:46.04927	2025-07-18 16:43:46.051285
956	956	25000	2025-07-18 16:43:46.051285	2025-07-18 16:43:46.054269
957	957	90000	2025-07-18 16:43:46.054269	2025-07-18 16:43:46.056269
958	958	157000	2025-07-18 16:43:46.056269	2025-07-18 16:43:46.058271
959	959	25500	2025-07-18 16:43:46.058271	2025-07-18 16:43:46.059271
960	960	15000	2025-07-18 16:43:46.059271	2025-07-18 16:43:46.061285
961	961	36000	2025-07-18 16:43:46.062285	2025-07-18 16:43:46.065248
962	962	60800	2025-07-18 16:43:46.065248	2025-07-18 16:43:46.068284
963	963	125600	2025-07-18 16:43:46.068284	2025-07-18 16:43:46.071316
964	964	54000	2025-07-18 16:43:46.071316	2025-07-18 16:43:46.074317
965	965	10000	2025-07-18 16:43:46.074317	2025-07-18 16:43:46.077301
966	966	13000	2025-07-18 16:43:46.078301	2025-07-18 16:43:46.080302
967	967	18000	2025-07-18 16:43:46.080302	2025-07-18 16:43:46.081317
968	968	18000	2025-07-18 16:43:46.082316	2025-07-18 16:43:46.084316
969	969	6000	2025-07-18 16:43:46.084316	2025-07-18 16:43:46.08686
970	970	50000	2025-07-18 16:43:46.087859	2025-07-18 16:43:46.089875
971	971	120000	2025-07-18 16:43:46.089875	2025-07-18 16:43:46.091875
972	972	13000	2025-07-18 16:43:46.091875	2025-07-18 16:43:46.093875
973	973	11000	2025-07-18 16:43:46.094875	2025-07-18 16:43:46.096875
974	974	17000	2025-07-18 16:43:46.097861	2025-07-18 16:43:46.100868
975	975	10000	2025-07-18 16:43:46.100868	2025-07-18 16:43:46.10438
976	976	13500	2025-07-18 16:43:46.1049	2025-07-18 16:43:46.106441
977	977	31000	2025-07-18 16:43:46.106441	2025-07-18 16:43:46.108623
978	978	25000	2025-07-18 16:43:46.10966	2025-07-18 16:43:46.11173
979	979	35000	2025-07-18 16:43:46.11173	2025-07-18 16:43:46.113746
980	980	25000	2025-07-18 16:43:46.113746	2025-07-18 16:43:46.115745
981	981	15000	2025-07-18 16:43:46.115745	2025-07-18 16:43:46.118746
982	982	50000	2025-07-18 16:43:46.118746	2025-07-18 16:43:46.120732
983	983	20000	2025-07-18 16:43:46.120732	2025-07-18 16:43:46.122745
984	984	60000	2025-07-18 16:43:46.122745	2025-07-18 16:43:46.124746
985	985	55000	2025-07-18 16:43:46.125745	2025-07-18 16:43:46.127746
986	986	55000	2025-07-18 16:43:46.127746	2025-07-18 16:43:46.130746
987	987	250000	2025-07-18 16:43:46.130746	2025-07-18 16:43:46.13373
988	988	10000	2025-07-18 16:43:46.13373	2025-07-18 16:43:46.135729
989	989	135000	2025-07-18 16:43:46.135729	2025-07-18 16:43:46.136731
990	990	20000	2025-07-18 16:43:46.137731	2025-07-18 16:43:46.138732
991	991	20000	2025-07-18 16:43:46.138732	2025-07-18 16:43:46.140746
992	992	6000	2025-07-18 16:43:46.141732	2025-07-18 16:43:46.143732
993	993	165000	2025-07-18 16:43:46.143732	2025-07-18 16:43:46.14573
994	994	165000	2025-07-18 16:43:46.146745	2025-07-18 16:43:46.147732
995	995	0	2025-07-18 16:43:46.148732	2025-07-18 16:43:46.149746
996	996	160000	2025-07-18 16:43:46.150745	2025-07-18 16:43:46.154337
997	997	8000	2025-07-18 16:43:46.154337	2025-07-18 16:43:46.156338
998	998	10000	2025-07-18 16:43:46.156338	2025-07-18 16:43:46.157338
999	999	2000	2025-07-18 16:43:46.157338	2025-07-18 16:43:46.159338
1000	1000	1000	2025-07-18 16:43:46.159338	2025-07-18 16:43:46.160338
1001	1001	3500	2025-07-18 16:43:46.160338	2025-07-18 16:43:46.162338
1002	1002	2500	2025-07-18 16:43:46.163338	2025-07-18 16:43:46.165343
1003	1003	10000	2025-07-18 16:43:46.166336	2025-07-18 16:43:46.168339
1004	1004	8000	2025-07-18 16:43:46.168339	2025-07-18 16:43:46.170339
1005	1005	130000	2025-07-18 16:43:46.171345	2025-07-18 16:43:46.173346
1006	1006	25000	2025-07-18 16:43:46.173346	2025-07-18 16:43:46.175348
1007	1007	7000	2025-07-18 16:43:46.175348	2025-07-18 16:43:46.179277
1008	1008	95000	2025-07-18 16:43:46.179277	2025-07-18 16:43:46.181257
1009	1009	23000	2025-07-18 16:43:46.181257	2025-07-18 16:43:46.183257
1010	1010	160000	2025-07-18 16:43:46.183257	2025-07-18 16:43:46.185765
1011	1011	230000	2025-07-18 16:43:46.185765	2025-07-18 16:43:46.187774
1012	1012	200000	2025-07-18 16:43:46.188773	2025-07-18 16:43:46.189775
1013	1013	140000	2025-07-18 16:43:46.189775	2025-07-18 16:43:46.191773
1014	1014	130000	2025-07-18 16:43:46.191773	2025-07-18 16:43:46.193773
1015	1015	280000	2025-07-18 16:43:46.193773	2025-07-18 16:43:46.194773
1016	1016	280000	2025-07-18 16:43:46.194773	2025-07-18 16:43:46.197772
1017	1017	250000	2025-07-18 16:43:46.197772	2025-07-18 16:43:46.199775
1018	1018	380000	2025-07-18 16:43:46.199775	2025-07-18 16:43:46.201772
1019	1019	500000	2025-07-18 16:43:46.201772	2025-07-18 16:43:46.203771
1020	1020	400000	2025-07-18 16:43:46.203771	2025-07-18 16:43:46.205774
1021	1021	650000	2025-07-18 16:43:46.205774	2025-07-18 16:43:46.208959
1022	1022	35000	2025-07-18 16:43:46.208959	2025-07-18 16:43:46.211953
1023	1023	1000	2025-07-18 16:43:46.211953	2025-07-18 16:43:46.214956
1024	1024	12000	2025-07-18 16:43:46.214956	2025-07-18 16:43:46.216956
1025	1025	15000	2025-07-18 16:43:46.216956	2025-07-18 16:43:46.219969
1026	1026	16900	2025-07-18 16:43:46.219969	2025-07-18 16:43:46.222839
1027	1027	15000	2025-07-18 16:43:46.223836	2025-07-18 16:43:46.224838
1028	1028	20000	2025-07-18 16:43:46.225838	2025-07-18 16:43:46.227852
1029	1029	12000	2025-07-18 16:43:46.227852	2025-07-18 16:43:46.229821
1030	1030	15000	2025-07-18 16:43:46.229821	2025-07-18 16:43:46.232837
1031	1031	37000	2025-07-18 16:43:46.232837	2025-07-18 16:43:46.234852
1032	1032	34400	2025-07-18 16:43:46.234852	2025-07-18 16:43:46.236852
1033	1033	15000	2025-07-18 16:43:46.237838	2025-07-18 16:43:46.239852
1034	1034	12000	2025-07-18 16:43:46.239852	2025-07-18 16:43:46.241852
1035	1035	15000	2025-07-18 16:43:46.242836	2025-07-18 16:43:46.244854
1036	1036	25900	2025-07-18 16:43:46.244854	2025-07-18 16:43:46.246852
1037	1037	12000	2025-07-18 16:43:46.246852	2025-07-18 16:43:46.248852
1038	1038	25000	2025-07-18 16:43:46.248852	2025-07-18 16:43:46.251852
1039	1039	15000	2025-07-18 16:43:46.251852	2025-07-18 16:43:46.254838
1040	1040	15000	2025-07-18 16:43:46.254838	2025-07-18 16:43:46.256852
1041	1041	12000	2025-07-18 16:43:46.256852	2025-07-18 16:43:46.258838
1042	1042	15000	2025-07-18 16:43:46.258838	2025-07-18 16:43:46.260836
1043	1043	28000	2025-07-18 16:43:46.260836	2025-07-18 16:43:46.262873
1044	1044	5000	2025-07-18 16:43:46.262873	2025-07-18 16:43:46.264881
1045	1045	9000	2025-07-18 16:43:46.264881	2025-07-18 16:43:46.266867
1046	1046	15000	2025-07-18 16:43:46.266867	2025-07-18 16:43:46.268881
1047	1047	14531	2025-07-18 16:43:46.268881	2025-07-18 16:43:46.271881
1048	1048	15000	2025-07-18 16:43:46.271881	2025-07-18 16:43:46.274882
1049	1049	40000	2025-07-18 16:43:46.274882	2025-07-18 16:43:46.277373
1050	1050	20000	2025-07-18 16:43:46.277373	2025-07-18 16:43:46.279551
1051	1051	20000	2025-07-18 16:43:46.279551	2025-07-18 16:43:46.281232
1052	1052	40000	2025-07-18 16:43:46.281232	2025-07-18 16:43:46.284373
1053	1053	20000	2025-07-18 16:43:46.284373	2025-07-18 16:43:46.285857
1054	1054	20000	2025-07-18 16:43:46.285857	2025-07-18 16:43:46.287874
1055	1055	35000	2025-07-18 16:43:46.288872	2025-07-18 16:43:46.291902
1056	1056	45000	2025-07-18 16:43:46.291902	2025-07-18 16:43:46.293903
1057	1057	60000	2025-07-18 16:43:46.294903	2025-07-18 16:43:46.297889
1058	1058	250000	2025-07-18 16:43:46.297889	2025-07-18 16:43:46.300903
1059	1059	135000	2025-07-18 16:43:46.300903	2025-07-18 16:43:46.302903
1060	1060	165000	2025-07-18 16:43:46.302903	2025-07-18 16:43:46.304903
1061	1061	0	2025-07-18 16:43:46.305903	2025-07-18 16:43:46.307903
1062	1062	390000	2025-07-18 16:43:46.307903	2025-07-18 16:43:46.3109
1063	1063	165000	2025-07-18 16:43:46.3109	2025-07-18 16:43:46.313897
1064	1064	140000	2025-07-18 16:43:46.313897	2025-07-18 16:43:46.315913
1065	1065	350000	2025-07-18 16:43:46.316899	2025-07-18 16:43:46.318885
1066	1066	150000	2025-07-18 16:43:46.318885	2025-07-18 16:43:46.321897
1067	1067	165000	2025-07-18 16:43:46.321897	2025-07-18 16:43:46.323896
1068	1068	210000	2025-07-18 16:43:46.323896	2025-07-18 16:43:46.325913
1069	1069	20000	2025-07-18 16:43:46.325913	2025-07-18 16:43:46.328508
1070	1070	570000	2025-07-18 16:43:46.328508	2025-07-18 16:43:46.331472
1071	1071	120000	2025-07-18 16:43:46.331472	2025-07-18 16:43:46.334493
1072	1072	150000	2025-07-18 16:43:46.335509	2025-07-18 16:43:46.336495
1073	1073	18200	2025-07-18 16:43:46.337495	2025-07-18 16:43:46.33963
1074	1074	27500	2025-07-18 16:43:46.33963	2025-07-18 16:43:46.341698
1075	1075	37600	2025-07-18 16:43:46.342684	2025-07-18 16:43:46.344698
1076	1076	56800	2025-07-18 16:43:46.344698	2025-07-18 16:43:46.347698
1077	1077	75600	2025-07-18 16:43:46.347698	2025-07-18 16:43:46.349697
1078	1078	116000	2025-07-18 16:43:46.349697	2025-07-18 16:43:46.352666
1079	1079	14200	2025-07-18 16:43:46.353662	2025-07-18 16:43:46.355682
1080	1080	210000	2025-07-18 16:43:46.355682	2025-07-18 16:43:46.357698
1081	1081	145000	2025-07-18 16:43:46.357698	2025-07-18 16:43:46.360697
1082	1082	7000	2025-07-18 16:43:46.360697	2025-07-18 16:43:46.363711
1083	1083	25000	2025-07-18 16:43:46.363711	2025-07-18 16:43:46.366016
1084	1084	4200000	2025-07-18 16:43:46.367065	2025-07-18 16:43:46.370064
1085	1085	2200000	2025-07-18 16:43:46.370064	2025-07-18 16:43:46.372064
1086	1086	2500000	2025-07-18 16:43:46.372064	2025-07-18 16:43:46.375064
1087	1087	4500000	2025-07-18 16:43:46.375064	2025-07-18 16:43:46.378632
1088	1088	5000	2025-07-18 16:43:46.378632	2025-07-18 16:43:46.379632
1089	1089	65000	2025-07-18 16:43:46.379632	2025-07-18 16:43:46.382646
1090	1090	9000	2025-07-18 16:43:46.382646	2025-07-18 16:43:46.384645
1091	1091	10000	2025-07-18 16:43:46.384645	2025-07-18 16:43:46.38823
1092	1092	16000	2025-07-18 16:43:46.38823	2025-07-18 16:43:46.390229
1093	1093	15000	2025-07-18 16:43:46.390229	2025-07-18 16:43:46.392244
1094	1094	100000	2025-07-18 16:43:46.392244	2025-07-18 16:43:46.394243
1095	1095	15000	2025-07-18 16:43:46.394243	2025-07-18 16:43:46.396244
1096	1096	15000	2025-07-18 16:43:46.397244	2025-07-18 16:43:46.399244
1097	1097	15000	2025-07-18 16:43:46.399244	2025-07-18 16:43:46.40023
1098	1098	90000	2025-07-18 16:43:46.40123	2025-07-18 16:43:46.403244
1099	1099	90000	2025-07-18 16:43:46.403244	2025-07-18 16:43:46.405244
1100	1100	90000	2025-07-18 16:43:46.405244	2025-07-18 16:43:46.407243
1101	1101	70000	2025-07-18 16:43:46.40823	2025-07-18 16:43:46.41023
1102	1102	70000	2025-07-18 16:43:46.411228	2025-07-18 16:43:46.412229
1103	1103	165000	2025-07-18 16:43:46.412229	2025-07-18 16:43:46.414275
1104	1104	15000	2025-07-18 16:43:46.415276	2025-07-18 16:43:46.416261
1105	1105	50000	2025-07-18 16:43:46.416261	2025-07-18 16:43:46.418261
1106	1106	240000	2025-07-18 16:43:46.418261	2025-07-18 16:43:46.420261
1107	1107	110000	2025-07-18 16:43:46.420261	2025-07-18 16:43:46.422275
1108	1108	25000	2025-07-18 16:43:46.422275	2025-07-18 16:43:46.424275
1109	1109	100000	2025-07-18 16:43:46.424275	2025-07-18 16:43:46.426584
1110	1110	40000	2025-07-18 16:43:46.426584	2025-07-18 16:43:46.429397
1111	1111	900000	2025-07-18 16:43:46.429397	2025-07-18 16:43:46.431467
1112	1112	70000	2025-07-18 16:43:46.431467	2025-07-18 16:43:46.434492
1113	1113	40000	2025-07-18 16:43:46.434492	2025-07-18 16:43:46.436492
1114	1114	65000	2025-07-18 16:43:46.436492	2025-07-18 16:43:46.438492
1115	1115	50000	2025-07-18 16:43:46.438492	2025-07-18 16:43:46.441492
1116	1116	50000	2025-07-18 16:43:46.441492	2025-07-18 16:43:46.444478
1117	1117	4200	2025-07-18 16:43:46.444478	2025-07-18 16:43:46.446492
1118	1118	25000	2025-07-18 16:43:46.446492	2025-07-18 16:43:46.449492
1119	1119	5000	2025-07-18 16:43:46.449492	2025-07-18 16:43:46.451492
1120	1120	5000	2025-07-18 16:43:46.452493	2025-07-18 16:43:46.454492
1121	1121	35000	2025-07-18 16:43:46.454492	2025-07-18 16:43:46.456492
1122	1122	5000	2025-07-18 16:43:46.456492	2025-07-18 16:43:46.458493
1123	1123	135000	2025-07-18 16:43:46.459492	2025-07-18 16:43:46.461492
1124	1124	75000	2025-07-18 16:43:46.461492	2025-07-18 16:43:46.463492
1125	1125	175000	2025-07-18 16:43:46.464474	2025-07-18 16:43:46.465525
1126	1126	125000	2025-07-18 16:43:46.466524	2025-07-18 16:43:46.468524
1127	1127	95000	2025-07-18 16:43:46.469525	2025-07-18 16:43:46.471525
1128	1128	75000	2025-07-18 16:43:46.471525	2025-07-18 16:43:46.473524
1129	1129	145000	2025-07-18 16:43:46.473524	2025-07-18 16:43:46.476524
1130	1130	110000	2025-07-18 16:43:46.477524	2025-07-18 16:43:46.47851
1131	1131	35000	2025-07-18 16:43:46.47851	2025-07-18 16:43:46.480021
1132	1132	45000	2025-07-18 16:43:46.480021	2025-07-18 16:43:46.482048
1133	1133	90000	2025-07-18 16:43:46.482048	2025-07-18 16:43:46.484062
1134	1134	430000	2025-07-18 16:43:46.484062	2025-07-18 16:43:46.48659
1135	1135	45000	2025-07-18 16:43:46.48659	2025-07-18 16:43:46.489627
1136	1136	135000	2025-07-18 16:43:46.490623	2025-07-18 16:43:46.492639
1137	1137	15000	2025-07-18 16:43:46.492639	2025-07-18 16:43:46.49564
1138	1138	40000	2025-07-18 16:43:46.49564	2025-07-18 16:43:46.497639
1139	1139	38000	2025-07-18 16:43:46.497639	2025-07-18 16:43:46.499625
1140	1140	7000	2025-07-18 16:43:46.499625	2025-07-18 16:43:46.50164
1141	1141	15000	2025-07-18 16:43:46.502639	2025-07-18 16:43:46.504639
1142	1142	7000	2025-07-18 16:43:46.504639	2025-07-18 16:43:46.506639
1143	1143	25000	2025-07-18 16:43:46.50764	2025-07-18 16:43:46.509639
1144	1144	1500	2025-07-18 16:43:46.509639	2025-07-18 16:43:46.512625
1145	1145	2500	2025-07-18 16:43:46.512625	2025-07-18 16:43:46.515687
1146	1146	130000	2025-07-18 16:43:46.515687	2025-07-18 16:43:46.517672
1147	1147	560000	2025-07-18 16:43:46.517672	2025-07-18 16:43:46.520686
1148	1148	45000	2025-07-18 16:43:46.520686	2025-07-18 16:43:46.523686
1149	1149	45000	2025-07-18 16:43:46.524686	2025-07-18 16:43:46.526435
1150	1150	82000	2025-07-18 16:43:46.52767	2025-07-18 16:43:46.530805
1151	1151	2600000	2025-07-18 16:43:46.530805	2025-07-18 16:43:46.53286
1152	1152	25000	2025-07-18 16:43:46.53286	2025-07-18 16:43:46.53546
1153	1153	20000	2025-07-18 16:43:46.53546	2025-07-18 16:43:46.537475
1154	1154	18000	2025-07-18 16:43:46.538475	2025-07-18 16:43:46.540474
1155	1155	15000	2025-07-18 16:43:46.540474	2025-07-18 16:43:46.54446
1156	1156	20000	2025-07-18 16:43:46.54446	2025-07-18 16:43:46.54646
1157	1157	5000	2025-07-18 16:43:46.54646	2025-07-18 16:43:46.54746
1158	1158	60000	2025-07-18 16:43:46.54746	2025-07-18 16:43:46.54946
1159	1159	25000	2025-07-18 16:43:46.54946	2025-07-18 16:43:46.551474
1160	1160	0	2025-07-18 16:43:46.551474	2025-07-18 16:43:46.554491
1161	1161	0	2025-07-18 16:43:46.554491	2025-07-18 16:43:46.557474
1162	1162	9000	2025-07-18 16:43:46.557474	2025-07-18 16:43:46.55946
1163	1163	16000	2025-07-18 16:43:46.55946	2025-07-18 16:43:46.561474
1164	1164	20000	2025-07-18 16:43:46.561474	2025-07-18 16:43:46.563474
1165	1165	0	2025-07-18 16:43:46.563474	2025-07-18 16:43:46.56653
1166	1166	20000	2025-07-18 16:43:46.56653	2025-07-18 16:43:46.568578
1167	1167	15000	2025-07-18 16:43:46.569577	2025-07-18 16:43:46.571577
1168	1168	25000	2025-07-18 16:43:46.571577	2025-07-18 16:43:46.573577
1169	1169	5000	2025-07-18 16:43:46.574577	2025-07-18 16:43:46.57758
1170	1170	20000	2025-07-18 16:43:46.57758	2025-07-18 16:43:46.578578
1171	1171	10000	2025-07-18 16:43:46.578578	2025-07-18 16:43:46.581156
1172	1172	20000	2025-07-18 16:43:46.582143	2025-07-18 16:43:46.584157
1173	1173	25000	2025-07-18 16:43:46.584157	2025-07-18 16:43:46.586166
1174	1174	20000	2025-07-18 16:43:46.586682	2025-07-18 16:43:46.589716
1175	1175	35000	2025-07-18 16:43:46.589716	2025-07-18 16:43:46.59173
1176	1176	45000	2025-07-18 16:43:46.592731	2025-07-18 16:43:46.59473
1177	1177	60000	2025-07-18 16:43:46.59473	2025-07-18 16:43:46.597733
1178	1178	115000	2025-07-18 16:43:46.597733	2025-07-18 16:43:46.60071
1179	1179	200000	2025-07-18 16:43:46.60071	2025-07-18 16:43:46.602716
1180	1180	7000	2025-07-18 16:43:46.602716	2025-07-18 16:43:46.604731
1181	1181	15000	2025-07-18 16:43:46.60573	2025-07-18 16:43:46.60773
1182	1182	1500	2025-07-18 16:43:46.608693	2025-07-18 16:43:46.610701
1183	1183	2500	2025-07-18 16:43:46.611716	2025-07-18 16:43:46.613714
1184	1184	4000	2025-07-18 16:43:46.613714	2025-07-18 16:43:46.615762
1185	1185	160000	2025-07-18 16:43:46.615762	2025-07-18 16:43:46.618762
1186	1186	60000	2025-07-18 16:43:46.61973	2025-07-18 16:43:46.621737
1187	1187	180000	2025-07-18 16:43:46.622748	2025-07-18 16:43:46.624806
1188	1188	75000	2025-07-18 16:43:46.624806	2025-07-18 16:43:46.626806
1189	1189	100000	2025-07-18 16:43:46.627794	2025-07-18 16:43:46.628806
1190	1190	1750000	2025-07-18 16:43:46.628806	2025-07-18 16:43:46.632386
1191	1191	165000	2025-07-18 16:43:46.632386	2025-07-18 16:43:46.634371
1192	1192	500000	2025-07-18 16:43:46.634371	2025-07-18 16:43:46.635369
1193	1193	750000	2025-07-18 16:43:46.636385	2025-07-18 16:43:46.638371
1194	1194	800000	2025-07-18 16:43:46.638371	2025-07-18 16:43:46.640385
1195	1195	60000	2025-07-18 16:43:46.640385	2025-07-18 16:43:46.64437
1196	1196	650000	2025-07-18 16:43:46.64437	2025-07-18 16:43:46.646948
1197	1197	40000	2025-07-18 16:43:46.646948	2025-07-18 16:43:46.648958
1198	1198	110000	2025-07-18 16:43:46.648958	2025-07-18 16:43:46.650957
1199	1199	260000	2025-07-18 16:43:46.650957	2025-07-18 16:43:46.654271
1200	1200	20000	2025-07-18 16:43:46.654271	2025-07-18 16:43:46.657288
1201	1201	30000	2025-07-18 16:43:46.658303	2025-07-18 16:43:46.660289
1202	1202	50000	2025-07-18 16:43:46.660289	2025-07-18 16:43:46.662304
1203	1203	65000	2025-07-18 16:43:46.662304	2025-07-18 16:43:46.664303
1204	1204	40000	2025-07-18 16:43:46.664303	2025-07-18 16:43:46.666321
1205	1205	45000	2025-07-18 16:43:46.666321	2025-07-18 16:43:46.668336
1206	1206	35000	2025-07-18 16:43:46.668336	2025-07-18 16:43:46.670322
1207	1207	30000	2025-07-18 16:43:46.670322	2025-07-18 16:43:46.672335
1208	1208	30000	2025-07-18 16:43:46.672335	2025-07-18 16:43:46.675306
1209	1209	30000	2025-07-18 16:43:46.676305	2025-07-18 16:43:46.678298
1210	1210	25000	2025-07-18 16:43:46.67932	2025-07-18 16:43:46.680864
1211	1211	30000	2025-07-18 16:43:46.680864	2025-07-18 16:43:46.683883
1212	1212	28000	2025-07-18 16:43:46.683883	2025-07-18 16:43:46.686449
1213	1213	20000	2025-07-18 16:43:46.686449	2025-07-18 16:43:46.689496
1214	1214	20000	2025-07-18 16:43:46.689496	2025-07-18 16:43:46.691483
1215	1215	20000	2025-07-18 16:43:46.691483	2025-07-18 16:43:46.693483
1216	1216	65000	2025-07-18 16:43:46.693483	2025-07-18 16:43:46.695496
1217	1217	90000	2025-07-18 16:43:46.695496	2025-07-18 16:43:46.698465
1218	1218	30000	2025-07-18 16:43:46.699474	2025-07-18 16:43:46.702496
1219	1219	20000	2025-07-18 16:43:46.702496	2025-07-18 16:43:46.704483
1220	1220	115000	2025-07-18 16:43:46.704483	2025-07-18 16:43:46.706496
1221	1221	1150000	2025-07-18 16:43:46.706496	2025-07-18 16:43:46.709483
1222	1222	75000	2025-07-18 16:43:46.709483	2025-07-18 16:43:46.710483
1223	1223	140000	2025-07-18 16:43:46.710483	2025-07-18 16:43:46.712483
1224	1224	15000	2025-07-18 16:43:46.712483	2025-07-18 16:43:46.714483
1225	1225	15000	2025-07-18 16:43:46.714483	2025-07-18 16:43:46.716496
1226	1226	30000	2025-07-18 16:43:46.716496	2025-07-18 16:43:46.718532
1227	1227	25000	2025-07-18 16:43:46.718532	2025-07-18 16:43:46.721517
1228	1228	40000	2025-07-18 16:43:46.721517	2025-07-18 16:43:46.723515
1229	1229	10000	2025-07-18 16:43:46.723515	2025-07-18 16:43:46.725531
1230	1230	16000	2025-07-18 16:43:46.725531	2025-07-18 16:43:46.727531
1231	1231	0	2025-07-18 16:43:46.728533	2025-07-18 16:43:46.729531
1232	1232	10000	2025-07-18 16:43:46.73106	2025-07-18 16:43:46.733092
1233	1233	12000	2025-07-18 16:43:46.733092	2025-07-18 16:43:46.735108
1234	1234	14000	2025-07-18 16:43:46.735108	2025-07-18 16:43:46.737108
1235	1235	30000	2025-07-18 16:43:46.737108	2025-07-18 16:43:46.739094
1236	1236	32000	2025-07-18 16:43:46.739094	2025-07-18 16:43:46.741108
1237	1237	35000	2025-07-18 16:43:46.741108	2025-07-18 16:43:46.744109
1238	1238	48000	2025-07-18 16:43:46.744109	2025-07-18 16:43:46.746084
1239	1239	6000	2025-07-18 16:43:46.746084	2025-07-18 16:43:46.747782
1240	1240	60000	2025-07-18 16:43:46.747782	2025-07-18 16:43:46.750456
1241	1241	8000	2025-07-18 16:43:46.750971	2025-07-18 16:43:46.75198
1242	1242	636000	2025-07-18 16:43:46.753623	2025-07-18 16:43:46.755216
1243	1243	4500	2025-07-18 16:43:46.755216	2025-07-18 16:43:46.757249
1244	1244	90000	2025-07-18 16:43:46.758263	2025-07-18 16:43:46.761231
1245	1245	130000	2025-07-18 16:43:46.761231	2025-07-18 16:43:46.763227
1246	1246	85000	2025-07-18 16:43:46.763227	2025-07-18 16:43:46.765247
1247	1247	95000	2025-07-18 16:43:46.766247	2025-07-18 16:43:46.767255
1248	1248	50000	2025-07-18 16:43:46.767255	2025-07-18 16:43:46.770281
1249	1249	50000	2025-07-18 16:43:46.770281	2025-07-18 16:43:46.772292
1250	1250	65000	2025-07-18 16:43:46.772292	2025-07-18 16:43:46.774292
1251	1251	70000	2025-07-18 16:43:46.775279	2025-07-18 16:43:46.777287
1252	1252	85000	2025-07-18 16:43:46.778276	2025-07-18 16:43:46.779278
1253	1253	95000	2025-07-18 16:43:46.780278	2025-07-18 16:43:46.78181
1254	1254	85000	2025-07-18 16:43:46.78181	2025-07-18 16:43:46.783848
1255	1255	21000	2025-07-18 16:43:46.784849	2025-07-18 16:43:46.787431
1256	1256	45000	2025-07-18 16:43:46.787431	2025-07-18 16:43:46.790445
1257	1257	60000	2025-07-18 16:43:46.790445	2025-07-18 16:43:46.792444
1258	1258	2500	2025-07-18 16:43:46.792444	2025-07-18 16:43:46.794445
1259	1259	55000	2025-07-18 16:43:46.795445	2025-07-18 16:43:46.797445
1260	1260	70000	2025-07-18 16:43:46.797445	2025-07-18 16:43:46.800411
1261	1261	10000	2025-07-18 16:43:46.800411	2025-07-18 16:43:46.802429
1262	1262	20000	2025-07-18 16:43:46.802429	2025-07-18 16:43:46.804444
1263	1263	42000	2025-07-18 16:43:46.804444	2025-07-18 16:43:46.806444
1264	1264	45000	2025-07-18 16:43:46.807445	2025-07-18 16:43:46.810445
1265	1265	60000	2025-07-18 16:43:46.810445	2025-07-18 16:43:46.812431
1266	1266	8000	2025-07-18 16:43:46.812431	2025-07-18 16:43:46.813431
1267	1267	150000	2025-07-18 16:43:46.814431	2025-07-18 16:43:46.815431
1268	1268	295000	2025-07-18 16:43:46.815431	2025-07-18 16:43:46.817476
1269	1269	174000	2025-07-18 16:43:46.817476	2025-07-18 16:43:46.82047
1270	1270	475000	2025-07-18 16:43:46.82047	2025-07-18 16:43:46.821453
1271	1271	540000	2025-07-18 16:43:46.821453	2025-07-18 16:43:46.823819
1272	1272	15000	2025-07-18 16:43:46.823819	2025-07-18 16:43:46.825832
1273	1273	35000	2025-07-18 16:43:46.826833	2025-07-18 16:43:46.828832
1274	1274	65000	2025-07-18 16:43:46.828832	2025-07-18 16:43:46.831799
1275	1275	670000	2025-07-18 16:43:46.832307	2025-07-18 16:43:46.834354
1276	1276	45000	2025-07-18 16:43:46.834354	2025-07-18 16:43:46.837353
1277	1277	290000	2025-07-18 16:43:46.837353	2025-07-18 16:43:46.839353
1278	1278	125000	2025-07-18 16:43:46.839353	2025-07-18 16:43:46.842328
1279	1279	0	2025-07-18 16:43:46.842328	2025-07-18 16:43:46.845319
1280	1280	45000	2025-07-18 16:43:46.845319	2025-07-18 16:43:46.848353
1281	1281	120000	2025-07-18 16:43:46.848353	2025-07-18 16:43:46.85034
1282	1282	0	2025-07-18 16:43:46.85034	2025-07-18 16:43:46.852353
1283	1283	0	2025-07-18 16:43:46.853329	2025-07-18 16:43:46.855315
1284	1284	0	2025-07-18 16:43:46.855315	2025-07-18 16:43:46.858339
1285	1285	0	2025-07-18 16:43:46.858339	2025-07-18 16:43:46.86234
1286	1286	0	2025-07-18 16:43:46.86234	2025-07-18 16:43:46.864353
1287	1287	0	2025-07-18 16:43:46.864353	2025-07-18 16:43:46.866337
1288	1288	340000	2025-07-18 16:43:46.866337	2025-07-18 16:43:46.868368
1289	1289	820000	2025-07-18 16:43:46.868368	2025-07-18 16:43:46.869369
1290	1290	55000	2025-07-18 16:43:46.870369	2025-07-18 16:43:46.871369
1291	1291	220000	2025-07-18 16:43:46.872369	2025-07-18 16:43:46.873383
1292	1292	35000	2025-07-18 16:43:46.874382	2025-07-18 16:43:46.876368
1293	1293	0	2025-07-18 16:43:46.877383	2025-07-18 16:43:46.879383
1294	1294	0	2025-07-18 16:43:46.879383	2025-07-18 16:43:46.881913
1295	1295	15000	2025-07-18 16:43:46.881913	2025-07-18 16:43:46.883964
1296	1296	75000	2025-07-18 16:43:46.883964	2025-07-18 16:43:46.886487
1297	1297	15000	2025-07-18 16:43:46.887524	2025-07-18 16:43:46.889512
1298	1298	5000	2025-07-18 16:43:46.890522	2025-07-18 16:43:46.892537
1299	1299	25000	2025-07-18 16:43:46.892537	2025-07-18 16:43:46.894537
1300	1300	0	2025-07-18 16:43:46.894537	2025-07-18 16:43:46.897512
1301	1301	0	2025-07-18 16:43:46.897512	2025-07-18 16:43:46.899521
1302	1302	30000	2025-07-18 16:43:46.899521	2025-07-18 16:43:46.902522
1303	1303	0	2025-07-18 16:43:46.902522	2025-07-18 16:43:46.904538
1304	1304	65000	2025-07-18 16:43:46.904538	2025-07-18 16:43:46.906537
1305	1305	85000	2025-07-18 16:43:46.906537	2025-07-18 16:43:46.909538
1306	1306	40000	2025-07-18 16:43:46.909538	2025-07-18 16:43:46.912538
1307	1307	150000	2025-07-18 16:43:46.912538	2025-07-18 16:43:46.914539
1308	1308	35000	2025-07-18 16:43:46.915538	2025-07-18 16:43:46.917585
1309	1309	150000	2025-07-18 16:43:46.917585	2025-07-18 16:43:46.920573
1310	1310	150000	2025-07-18 16:43:46.920573	2025-07-18 16:43:46.924569
1311	1311	12000	2025-07-18 16:43:46.924569	2025-07-18 16:43:46.927585
1312	1312	8000	2025-07-18 16:43:46.927585	2025-07-18 16:43:46.929572
1313	1313	5000	2025-07-18 16:43:46.929572	2025-07-18 16:43:46.932117
1314	1314	66400	2025-07-18 16:43:46.933153	2025-07-18 16:43:46.935168
1315	1315	90000	2025-07-18 16:43:46.935168	2025-07-18 16:43:46.937167
1316	1316	120000	2025-07-18 16:43:46.937167	2025-07-18 16:43:46.939167
1317	1317	20000	2025-07-18 16:43:46.939167	2025-07-18 16:43:46.942153
1318	1318	55000	2025-07-18 16:43:46.942153	2025-07-18 16:43:46.944167
1319	1319	20000	2025-07-18 16:43:46.945168	2025-07-18 16:43:46.946154
1320	1320	100000	2025-07-18 16:43:46.947153	2025-07-18 16:43:46.949132
1321	1321	95000	2025-07-18 16:43:46.949132	2025-07-18 16:43:46.951152
1322	1322	40000	2025-07-18 16:43:46.951152	2025-07-18 16:43:46.954154
1323	1323	40000	2025-07-18 16:43:46.954154	2025-07-18 16:43:46.957153
1324	1324	85000	2025-07-18 16:43:46.958167	2025-07-18 16:43:46.960163
1325	1325	230000	2025-07-18 16:43:46.960163	2025-07-18 16:43:46.962167
1326	1326	160000	2025-07-18 16:43:46.962167	2025-07-18 16:43:46.964985
1327	1327	15000	2025-07-18 16:43:46.964985	2025-07-18 16:43:46.966639
1328	1328	16000	2025-07-18 16:43:46.966639	2025-07-18 16:43:46.968833
1329	1329	35000	2025-07-18 16:43:46.968833	2025-07-18 16:43:46.970924
1330	1330	135000	2025-07-18 16:43:46.970924	2025-07-18 16:43:46.974614
1331	1331	40000	2025-07-18 16:43:46.974614	2025-07-18 16:43:46.978552
1332	1332	185000	2025-07-18 16:43:46.978552	2025-07-18 16:43:46.979552
1333	1333	35000	2025-07-18 16:43:46.980566	2025-07-18 16:43:46.981567
1334	1334	40000	2025-07-18 16:43:46.982552	2025-07-18 16:43:46.983063
1335	1335	35000	2025-07-18 16:43:46.98409	2025-07-18 16:43:46.985104
1336	1336	85000	2025-07-18 16:43:46.985104	2025-07-18 16:43:46.988669
1337	1337	75000	2025-07-18 16:43:46.988669	2025-07-18 16:43:46.98967
1338	1338	85000	2025-07-18 16:43:46.990683	2025-07-18 16:43:46.992683
1339	1339	85000	2025-07-18 16:43:46.992683	2025-07-18 16:43:46.994684
1340	1340	75000	2025-07-18 16:43:46.995683	2025-07-18 16:43:46.998646
1341	1341	950000	2025-07-18 16:43:46.998646	2025-07-18 16:43:47.000645
1342	1342	55000	2025-07-18 16:43:47.000645	2025-07-18 16:43:47.003667
1343	1343	350000	2025-07-18 16:43:47.003667	2025-07-18 16:43:47.005683
1344	1344	350000	2025-07-18 16:43:47.006683	2025-07-18 16:43:47.008683
1345	1345	580000	2025-07-18 16:43:47.008683	2025-07-18 16:43:47.011772
1346	1346	230000	2025-07-18 16:43:47.011772	2025-07-18 16:43:47.013841
1347	1347	220000	2025-07-18 16:43:47.01484	2025-07-18 16:43:47.01684
1348	1348	230000	2025-07-18 16:43:47.01684	2025-07-18 16:43:47.018871
1349	1349	230000	2025-07-18 16:43:47.019871	2025-07-18 16:43:47.022841
1350	1350	230000	2025-07-18 16:43:47.022841	2025-07-18 16:43:47.024855
1351	1351	250000	2025-07-18 16:43:47.025855	2025-07-18 16:43:47.027855
1352	1352	55000	2025-07-18 16:43:47.027855	2025-07-18 16:43:47.028857
1353	1353	1170000	2025-07-18 16:43:47.028857	2025-07-18 16:43:47.031871
1354	1354	880000	2025-07-18 16:43:47.031871	2025-07-18 16:43:47.035414
1355	1355	880000	2025-07-18 16:43:47.035414	2025-07-18 16:43:47.037413
1356	1356	1170000	2025-07-18 16:43:47.037413	2025-07-18 16:43:47.039414
1357	1357	1170000	2025-07-18 16:43:47.040414	2025-07-18 16:43:47.042413
1358	1358	1050000	2025-07-18 16:43:47.042413	2025-07-18 16:43:47.045375
1359	1359	1700000	2025-07-18 16:43:47.045375	2025-07-18 16:43:47.046399
1360	1360	750000	2025-07-18 16:43:47.047414	2025-07-18 16:43:47.049414
1361	1361	10000	2025-07-18 16:43:47.049414	2025-07-18 16:43:47.051414
1362	1362	25000	2025-07-18 16:43:47.052414	2025-07-18 16:43:47.054383
1363	1363	8000	2025-07-18 16:43:47.055397	2025-07-18 16:43:47.056398
1364	1364	7000	2025-07-18 16:43:47.056398	2025-07-18 16:43:47.058399
1365	1365	10000	2025-07-18 16:43:47.058399	2025-07-18 16:43:47.060414
1366	1366	20000	2025-07-18 16:43:47.060414	2025-07-18 16:43:47.062414
1367	1367	15000	2025-07-18 16:43:47.062414	2025-07-18 16:43:47.065414
1368	1368	17000	2025-07-18 16:43:47.065414	2025-07-18 16:43:47.067399
1369	1369	22000	2025-07-18 16:43:47.067399	2025-07-18 16:43:47.068431
1370	1370	10000	2025-07-18 16:43:47.068431	2025-07-18 16:43:47.070444
1371	1371	20000	2025-07-18 16:43:47.070444	2025-07-18 16:43:47.073444
1372	1372	70000	2025-07-18 16:43:47.073444	2025-07-18 16:43:47.076416
1373	1373	12000	2025-07-18 16:43:47.076416	2025-07-18 16:43:47.078429
1374	1374	65000	2025-07-18 16:43:47.078429	2025-07-18 16:43:47.080445
1375	1375	125000	2025-07-18 16:43:47.081445	2025-07-18 16:43:47.08299
1376	1376	75000	2025-07-18 16:43:47.08299	2025-07-18 16:43:47.085041
1377	1377	95000	2025-07-18 16:43:47.085041	2025-07-18 16:43:47.089584
1378	1378	145000	2025-07-18 16:43:47.089584	2025-07-18 16:43:47.091596
1379	1379	20000	2025-07-18 16:43:47.091596	2025-07-18 16:43:47.093607
1380	1380	20000	2025-07-18 16:43:47.093607	2025-07-18 16:43:47.09562
1381	1381	55000	2025-07-18 16:43:47.09662	2025-07-18 16:43:47.099605
1382	1382	95000	2025-07-18 16:43:47.099605	2025-07-18 16:43:47.100604
1383	1383	160000	2025-07-18 16:43:47.101621	2025-07-18 16:43:47.10362
1384	1384	95000	2025-07-18 16:43:47.10362	2025-07-18 16:43:47.10562
1385	1385	50000	2025-07-18 16:43:47.106607	2025-07-18 16:43:47.10862
1386	1386	0	2025-07-18 16:43:47.10862	2025-07-18 16:43:47.111607
1387	1387	50000	2025-07-18 16:43:47.111607	2025-07-18 16:43:47.113604
1388	1388	5000	2025-07-18 16:43:47.113604	2025-07-18 16:43:47.11562
1389	1389	10000	2025-07-18 16:43:47.11562	2025-07-18 16:43:47.11762
1390	1390	0	2025-07-18 16:43:47.11762	2025-07-18 16:43:47.120667
1391	1391	0	2025-07-18 16:43:47.120667	2025-07-18 16:43:47.123653
1392	1392	38000	2025-07-18 16:43:47.123653	2025-07-18 16:43:47.125652
1393	1393	380000	2025-07-18 16:43:47.125652	2025-07-18 16:43:47.127667
1394	1394	7000	2025-07-18 16:43:47.127667	2025-07-18 16:43:47.129667
1395	1395	10000	2025-07-18 16:43:47.130654	2025-07-18 16:43:47.133173
1396	1396	10000	2025-07-18 16:43:47.133173	2025-07-18 16:43:47.13622
1397	1397	30000	2025-07-18 16:43:47.13622	2025-07-18 16:43:47.138206
1398	1398	25000	2025-07-18 16:43:47.138206	2025-07-18 16:43:47.14022
1399	1399	35000	2025-07-18 16:43:47.14022	2025-07-18 16:43:47.14322
1400	1400	38000	2025-07-18 16:43:47.14322	2025-07-18 16:43:47.146206
1401	1401	25000	2025-07-18 16:43:47.146206	2025-07-18 16:43:47.148206
1402	1402	35000	2025-07-18 16:43:47.148206	2025-07-18 16:43:47.15022
1403	1403	30000	2025-07-18 16:43:47.15022	2025-07-18 16:43:47.15222
1404	1404	16000	2025-07-18 16:43:47.153232	2025-07-18 16:43:47.156207
1405	1405	16000	2025-07-18 16:43:47.156207	2025-07-18 16:43:47.159221
1406	1406	450000	2025-07-18 16:43:47.159221	2025-07-18 16:43:47.16222
1407	1407	55000	2025-07-18 16:43:47.16222	2025-07-18 16:43:47.165221
1408	1408	60000	2025-07-18 16:43:47.165221	2025-07-18 16:43:47.16819
1409	1409	40000	2025-07-18 16:43:47.169223	2025-07-18 16:43:47.171222
1410	1410	35000	2025-07-18 16:43:47.171222	2025-07-18 16:43:47.173237
1411	1411	40000	2025-07-18 16:43:47.173237	2025-07-18 16:43:47.175236
1412	1412	70000	2025-07-18 16:43:47.176198	2025-07-18 16:43:47.178237
1413	1413	50000	2025-07-18 16:43:47.179222	2025-07-18 16:43:47.180221
1414	1414	55000	2025-07-18 16:43:47.180221	2025-07-18 16:43:47.183208
1415	1415	720000	2025-07-18 16:43:47.183714	2025-07-18 16:43:47.186917
1416	1416	210000	2025-07-18 16:43:47.186917	2025-07-18 16:43:47.188988
1417	1417	75000	2025-07-18 16:43:47.188988	2025-07-18 16:43:47.191695
1418	1418	170000	2025-07-18 16:43:47.192717	2025-07-18 16:43:47.194727
1419	1419	60000	2025-07-18 16:43:47.194727	2025-07-18 16:43:47.196729
1420	1420	75000	2025-07-18 16:43:47.196729	2025-07-18 16:43:47.198721
1421	1421	75000	2025-07-18 16:43:47.198721	2025-07-18 16:43:47.200726
1422	1422	165000	2025-07-18 16:43:47.201743	2025-07-18 16:43:47.202729
1423	1423	120000	2025-07-18 16:43:47.203729	2025-07-18 16:43:47.205743
1424	1424	199000	2025-07-18 16:43:47.205743	2025-07-18 16:43:47.207742
1425	1425	8000	2025-07-18 16:43:47.207742	2025-07-18 16:43:47.212108
1426	1426	12600	2025-07-18 16:43:47.212108	2025-07-18 16:43:47.214152
1427	1427	17200	2025-07-18 16:43:47.214152	2025-07-18 16:43:47.218166
1428	1428	24000	2025-07-18 16:43:47.218166	2025-07-18 16:43:47.222212
1429	1429	31000	2025-07-18 16:43:47.222212	2025-07-18 16:43:47.225197
1430	1430	75000	2025-07-18 16:43:47.225197	2025-07-18 16:43:47.227212
1431	1431	60800	2025-07-18 16:43:47.227212	2025-07-18 16:43:47.230177
1432	1432	104000	2025-07-18 16:43:47.230177	2025-07-18 16:43:47.234181
1433	1433	159000	2025-07-18 16:43:47.234181	2025-07-18 16:43:47.237195
1434	1434	35000	2025-07-18 16:43:47.237195	2025-07-18 16:43:47.239209
1435	1435	17000	2025-07-18 16:43:47.239209	2025-07-18 16:43:47.241213
1436	1436	35000	2025-07-18 16:43:47.241213	2025-07-18 16:43:47.243208
1437	1437	35000	2025-07-18 16:43:47.243208	2025-07-18 16:43:47.246209
1438	1438	89000	2025-07-18 16:43:47.246209	2025-07-18 16:43:47.248347
1439	1439	11200	2025-07-18 16:43:47.248347	2025-07-18 16:43:47.250344
1440	1440	60000	2025-07-18 16:43:47.251341	2025-07-18 16:43:47.253342
1441	1441	100000	2025-07-18 16:43:47.253342	2025-07-18 16:43:47.257449
1442	1442	10000	2025-07-18 16:43:47.257449	2025-07-18 16:43:47.261478
1443	1443	60000	2025-07-18 16:43:47.261478	2025-07-18 16:43:47.266467
1444	1444	1350000	2025-07-18 16:43:47.266467	2025-07-18 16:43:47.268469
1445	1445	1100000	2025-07-18 16:43:47.269466	2025-07-18 16:43:47.271471
1446	1446	3300000	2025-07-18 16:43:47.271471	2025-07-18 16:43:47.273473
1447	1447	2950000	2025-07-18 16:43:47.273473	2025-07-18 16:43:47.275473
1448	1448	1350000	2025-07-18 16:43:47.275473	2025-07-18 16:43:47.278475
1449	1449	1450000	2025-07-18 16:43:47.278475	2025-07-18 16:43:47.280473
1450	1450	3300000	2025-07-18 16:43:47.280473	2025-07-18 16:43:47.282474
1451	1451	1600000	2025-07-18 16:43:47.282474	2025-07-18 16:43:47.284476
1452	1452	1650000	2025-07-18 16:43:47.284476	2025-07-18 16:43:47.288536
1453	1453	1150000	2025-07-18 16:43:47.288536	2025-07-18 16:43:47.291646
1454	1454	1700000	2025-07-18 16:43:47.291646	2025-07-18 16:43:47.293645
1455	1455	2100000	2025-07-18 16:43:47.294645	2025-07-18 16:43:47.296258
1456	1456	850000	2025-07-18 16:43:47.297255	2025-07-18 16:43:47.299255
1457	1457	1850000	2025-07-18 16:43:47.300267	2025-07-18 16:43:47.302267
1458	1458	2350000	2025-07-18 16:43:47.302267	2025-07-18 16:43:47.304264
1459	1459	1450000	2025-07-18 16:43:47.304264	2025-07-18 16:43:47.306273
1460	1460	1550000	2025-07-18 16:43:47.306273	2025-07-18 16:43:47.309265
1461	1461	1700000	2025-07-18 16:43:47.309265	2025-07-18 16:43:47.311688
1462	1462	1200000	2025-07-18 16:43:47.311688	2025-07-18 16:43:47.313718
1463	1463	1150000	2025-07-18 16:43:47.313718	2025-07-18 16:43:47.315734
1464	1464	270000	2025-07-18 16:43:47.315734	2025-07-18 16:43:47.317734
1465	1465	1450000	2025-07-18 16:43:47.318735	2025-07-18 16:43:47.32078
1466	1466	1570000	2025-07-18 16:43:47.321766	2025-07-18 16:43:47.32378
1467	1467	750000	2025-07-18 16:43:47.324766	2025-07-18 16:43:47.32678
1468	1468	3300000	2025-07-18 16:43:47.32678	2025-07-18 16:43:47.32878
1469	1469	2450000	2025-07-18 16:43:47.32878	2025-07-18 16:43:47.33178
1470	1470	2700000	2025-07-18 16:43:47.33178	2025-07-18 16:43:47.33478
1471	1471	1450000	2025-07-18 16:43:47.33478	2025-07-18 16:43:47.336331
1472	1472	1850000	2025-07-18 16:43:47.336331	2025-07-18 16:43:47.339346
1473	1473	2800000	2025-07-18 16:43:47.339346	2025-07-18 16:43:47.340331
1474	1474	650000	2025-07-18 16:43:47.340331	2025-07-18 16:43:47.342333
1475	1475	700000	2025-07-18 16:43:47.342333	2025-07-18 16:43:47.345329
1476	1476	1100000	2025-07-18 16:43:47.345329	2025-07-18 16:43:47.347331
1477	1477	980000	2025-07-18 16:43:47.347331	2025-07-18 16:43:47.349345
1478	1478	950000	2025-07-18 16:43:47.349345	2025-07-18 16:43:47.352345
1479	1479	1550000	2025-07-18 16:43:47.352345	2025-07-18 16:43:47.354348
1480	1480	1750000	2025-07-18 16:43:47.354348	2025-07-18 16:43:47.356345
1481	1481	0	2025-07-18 16:43:47.357345	2025-07-18 16:43:47.359413
1482	1482	2250000	2025-07-18 16:43:47.359413	2025-07-18 16:43:47.361413
1483	1483	1650000	2025-07-18 16:43:47.362399	2025-07-18 16:43:47.364414
1484	1484	1450000	2025-07-18 16:43:47.364414	2025-07-18 16:43:47.3674
1485	1485	2050000	2025-07-18 16:43:47.3674	2025-07-18 16:43:47.370461
1486	1486	1650000	2025-07-18 16:43:47.370461	2025-07-18 16:43:47.372446
1487	1487	3400000	2025-07-18 16:43:47.372446	2025-07-18 16:43:47.37446
1488	1488	2350000	2025-07-18 16:43:47.375446	2025-07-18 16:43:47.377445
1489	1489	790000	2025-07-18 16:43:47.378447	2025-07-18 16:43:47.379444
1490	1490	450000	2025-07-18 16:43:47.379444	2025-07-18 16:43:47.382461
1491	1491	1450000	2025-07-18 16:43:47.382461	2025-07-18 16:43:47.383461
1492	1492	1200000	2025-07-18 16:43:47.384992	2025-07-18 16:43:47.386039
1493	1493	1900000	2025-07-18 16:43:47.386039	2025-07-18 16:43:47.389603
1494	1494	1450000	2025-07-18 16:43:47.389603	2025-07-18 16:43:47.391602
1495	1495	1480000	2025-07-18 16:43:47.392604	2025-07-18 16:43:47.394604
1496	1496	1300000	2025-07-18 16:43:47.394604	2025-07-18 16:43:47.396618
1497	1497	6500000	2025-07-18 16:43:47.396618	2025-07-18 16:43:47.398618
1498	1498	1850000	2025-07-18 16:43:47.399604	2025-07-18 16:43:47.400604
1499	1499	1500000	2025-07-18 16:43:47.400604	2025-07-18 16:43:47.403457
1500	1500	3600000	2025-07-18 16:43:47.403457	2025-07-18 16:43:47.405544
1501	1501	3600000	2025-07-18 16:43:47.405544	2025-07-18 16:43:47.408155
1502	1502	1150000	2025-07-18 16:43:47.408155	2025-07-18 16:43:47.411302
1503	1503	1750000	2025-07-18 16:43:47.411302	2025-07-18 16:43:47.413349
1504	1504	950000	2025-07-18 16:43:47.413349	2025-07-18 16:43:47.415349
1505	1505	1250000	2025-07-18 16:43:47.415349	2025-07-18 16:43:47.4185
1506	1506	1150000	2025-07-18 16:43:47.4185	2025-07-18 16:43:47.421528
1507	1507	950000	2025-07-18 16:43:47.421528	2025-07-18 16:43:47.424579
1508	1508	1650000	2025-07-18 16:43:47.424579	2025-07-18 16:43:47.426578
1509	1509	850000	2025-07-18 16:43:47.426578	2025-07-18 16:43:47.428578
1510	1510	3000	2025-07-18 16:43:47.428578	2025-07-18 16:43:47.430578
1511	1511	45000	2025-07-18 16:43:47.431579	2025-07-18 16:43:47.433543
1512	1512	30000	2025-07-18 16:43:47.433543	2025-07-18 16:43:47.437371
1513	1513	20000	2025-07-18 16:43:47.437371	2025-07-18 16:43:47.43937
1514	1514	45000	2025-07-18 16:43:47.43937	2025-07-18 16:43:47.442371
1515	1515	155000	2025-07-18 16:43:47.442371	2025-07-18 16:43:47.443372
1516	1516	55000	2025-07-18 16:43:47.443372	2025-07-18 16:43:47.445703
1517	1517	60000	2025-07-18 16:43:47.445703	2025-07-18 16:43:47.448703
1518	1518	0	2025-07-18 16:43:47.448703	2025-07-18 16:43:47.450703
1519	1519	0	2025-07-18 16:43:47.450703	2025-07-18 16:43:47.452704
1520	1520	0	2025-07-18 16:43:47.452704	2025-07-18 16:43:47.455243
1521	1521	35000	2025-07-18 16:43:47.456279	2025-07-18 16:43:47.458292
1522	1522	1800000	2025-07-18 16:43:47.458292	2025-07-18 16:43:47.461292
1523	1523	100000	2025-07-18 16:43:47.461292	2025-07-18 16:43:47.463292
1524	1524	45000	2025-07-18 16:43:47.464278	2025-07-18 16:43:47.466276
1525	1525	75000	2025-07-18 16:43:47.467276	2025-07-18 16:43:47.469292
1526	1526	100000	2025-07-18 16:43:47.469292	2025-07-18 16:43:47.471323
1527	1527	20000	2025-07-18 16:43:47.471323	2025-07-18 16:43:47.474323
1528	1528	25000	2025-07-18 16:43:47.474323	2025-07-18 16:43:47.477325
1529	1529	30000	2025-07-18 16:43:47.477325	2025-07-18 16:43:47.480309
1530	1530	40000	2025-07-18 16:43:47.480309	2025-07-18 16:43:47.482324
1531	1531	50000	2025-07-18 16:43:47.482324	2025-07-18 16:43:47.484324
1532	1532	55000	2025-07-18 16:43:47.484324	2025-07-18 16:43:47.486459
1533	1533	60000	2025-07-18 16:43:47.486459	2025-07-18 16:43:47.489002
1534	1534	20000	2025-07-18 16:43:47.490002	2025-07-18 16:43:47.490988
1535	1535	35000	2025-07-18 16:43:47.490988	2025-07-18 16:43:47.493002
1536	1536	18000	2025-07-18 16:43:47.493002	2025-07-18 16:43:47.496002
1537	1537	16000	2025-07-18 16:43:47.496002	2025-07-18 16:43:47.498988
1538	1538	18000	2025-07-18 16:43:47.498988	2025-07-18 16:43:47.500994
1539	1539	35000	2025-07-18 16:43:47.500994	2025-07-18 16:43:47.502988
1540	1540	45000	2025-07-18 16:43:47.502988	2025-07-18 16:43:47.505002
1541	1541	50000	2025-07-18 16:43:47.505002	2025-07-18 16:43:47.506988
1542	1542	55000	2025-07-18 16:43:47.506988	2025-07-18 16:43:47.509002
1543	1543	25000	2025-07-18 16:43:47.509002	2025-07-18 16:43:47.511971
1544	1544	25000	2025-07-18 16:43:47.512988	2025-07-18 16:43:47.515002
1545	1545	25000	2025-07-18 16:43:47.515002	2025-07-18 16:43:47.518002
1546	1546	35000	2025-07-18 16:43:47.518002	2025-07-18 16:43:47.520002
1547	1547	45000	2025-07-18 16:43:47.520002	2025-07-18 16:43:47.523038
1548	1548	18000	2025-07-18 16:43:47.523038	2025-07-18 16:43:47.525035
1549	1549	20000	2025-07-18 16:43:47.525035	2025-07-18 16:43:47.527035
1550	1550	0	2025-07-18 16:43:47.527035	2025-07-18 16:43:47.528035
1551	1551	0	2025-07-18 16:43:47.528035	2025-07-18 16:43:47.530048
1552	1552	12000	2025-07-18 16:43:47.531048	2025-07-18 16:43:47.534035
1553	1553	20000	2025-07-18 16:43:47.534035	2025-07-18 16:43:47.535563
1554	1554	95000	2025-07-18 16:43:47.535563	2025-07-18 16:43:47.537611
1555	1555	18000	2025-07-18 16:43:47.537611	2025-07-18 16:43:47.540611
1556	1556	25000	2025-07-18 16:43:47.541611	2025-07-18 16:43:47.544578
1557	1557	20000	2025-07-18 16:43:47.544578	2025-07-18 16:43:47.548599
1558	1558	8000	2025-07-18 16:43:47.548599	2025-07-18 16:43:47.550599
1559	1559	16000	2025-07-18 16:43:47.551599	2025-07-18 16:43:47.553611
1560	1560	30000	2025-07-18 16:43:47.553611	2025-07-18 16:43:47.556612
1561	1561	20000	2025-07-18 16:43:47.556612	2025-07-18 16:43:47.558595
1562	1562	0	2025-07-18 16:43:47.558595	2025-07-18 16:43:47.560611
1563	1563	0	2025-07-18 16:43:47.561597	2025-07-18 16:43:47.563611
1564	1564	105000	2025-07-18 16:43:47.563611	2025-07-18 16:43:47.565611
1565	1565	20000	2025-07-18 16:43:47.566597	2025-07-18 16:43:47.568611
1566	1566	35000	2025-07-18 16:43:47.569611	2025-07-18 16:43:47.571658
1567	1567	50000	2025-07-18 16:43:47.571658	2025-07-18 16:43:47.573658
1568	1568	85000	2025-07-18 16:43:47.573658	2025-07-18 16:43:47.576658
1569	1569	16000	2025-07-18 16:43:47.577644	2025-07-18 16:43:47.579659
1570	1570	7000	2025-07-18 16:43:47.580643	2025-07-18 16:43:47.582645
1571	1571	35000	2025-07-18 16:43:47.582645	2025-07-18 16:43:47.584658
1572	1572	11000	2025-07-18 16:43:47.584658	2025-07-18 16:43:47.586176
1573	1573	8000	2025-07-18 16:43:47.587735	2025-07-18 16:43:47.590772
1574	1574	15000	2025-07-18 16:43:47.590772	2025-07-18 16:43:47.592786
1575	1575	20000	2025-07-18 16:43:47.592786	2025-07-18 16:43:47.595786
1576	1576	4500	2025-07-18 16:43:47.595786	2025-07-18 16:43:47.597786
1577	1577	4500	2025-07-18 16:43:47.597786	2025-07-18 16:43:47.600786
1578	1578	0	2025-07-18 16:43:47.600786	2025-07-18 16:43:47.602772
1579	1579	0	2025-07-18 16:43:47.602772	2025-07-18 16:43:47.604786
1580	1580	280000	2025-07-18 16:43:47.605789	2025-07-18 16:43:47.607786
1581	1581	20000	2025-07-18 16:43:47.607786	2025-07-18 16:43:47.610763
1582	1582	0	2025-07-18 16:43:47.610763	2025-07-18 16:43:47.612783
1583	1583	0	2025-07-18 16:43:47.612783	2025-07-18 16:43:47.614786
1584	1584	0	2025-07-18 16:43:47.614786	2025-07-18 16:43:47.616786
1585	1585	0	2025-07-18 16:43:47.617787	2025-07-18 16:43:47.619786
1586	1586	0	2025-07-18 16:43:47.619786	2025-07-18 16:43:47.622666
1587	1587	0	2025-07-18 16:43:47.623802	2025-07-18 16:43:47.625164
1588	1588	3000	2025-07-18 16:43:47.625164	2025-07-18 16:43:47.627369
1589	1589	260000	2025-07-18 16:43:47.627369	2025-07-18 16:43:47.630581
1590	1590	820000	2025-07-18 16:43:47.630581	2025-07-18 16:43:47.63316
1591	1591	1600	2025-07-18 16:43:47.63316	2025-07-18 16:43:47.635146
1592	1592	1600	2025-07-18 16:43:47.635146	2025-07-18 16:43:47.636653
1593	1593	50000	2025-07-18 16:43:47.636653	2025-07-18 16:43:47.639086
1594	1594	110000	2025-07-18 16:43:47.639086	2025-07-18 16:43:47.640635
1595	1595	160000	2025-07-18 16:43:47.640635	2025-07-18 16:43:47.643684
1596	1596	110000	2025-07-18 16:43:47.643684	2025-07-18 16:43:47.646669
1597	1597	120000	2025-07-18 16:43:47.646669	2025-07-18 16:43:47.648668
1598	1598	260000	2025-07-18 16:43:47.648668	2025-07-18 16:43:47.650683
1599	1599	310000	2025-07-18 16:43:47.650683	2025-07-18 16:43:47.652683
1600	1600	180000	2025-07-18 16:43:47.653684	2025-07-18 16:43:47.656667
1601	1601	80000	2025-07-18 16:43:47.656667	2025-07-18 16:43:47.659684
1602	1602	110000	2025-07-18 16:43:47.659684	2025-07-18 16:43:47.66067
1603	1603	20000	2025-07-18 16:43:47.66067	2025-07-18 16:43:47.66267
1604	1604	40000	2025-07-18 16:43:47.66267	2025-07-18 16:43:47.66567
1605	1605	150000	2025-07-18 16:43:47.66567	2025-07-18 16:43:47.668669
1606	1606	150000	2025-07-18 16:43:47.668669	2025-07-18 16:43:47.670683
1607	1607	8500	2025-07-18 16:43:47.670683	2025-07-18 16:43:47.67373
1608	1608	8000	2025-07-18 16:43:47.67373	2025-07-18 16:43:47.675729
1609	1609	20000	2025-07-18 16:43:47.675729	2025-07-18 16:43:47.678697
1610	1610	35000	2025-07-18 16:43:47.67973	2025-07-18 16:43:47.680714
1611	1611	10000	2025-07-18 16:43:47.680714	2025-07-18 16:43:47.683731
1612	1612	35000	2025-07-18 16:43:47.683731	2025-07-18 16:43:47.684731
1613	1613	20000	2025-07-18 16:43:47.684731	2025-07-18 16:43:47.687828
1614	1614	10000	2025-07-18 16:43:47.688865	2025-07-18 16:43:47.689865
1615	1615	15000	2025-07-18 16:43:47.689865	2025-07-18 16:43:47.691877
1616	1616	9000	2025-07-18 16:43:47.691877	2025-07-18 16:43:47.693865
1617	1617	35000	2025-07-18 16:43:47.693865	2025-07-18 16:43:47.695878
1618	1618	2000	2025-07-18 16:43:47.695878	2025-07-18 16:43:47.69885
1619	1619	29000	2025-07-18 16:43:47.699847	2025-07-18 16:43:47.702863
1620	1620	75000	2025-07-18 16:43:47.702863	2025-07-18 16:43:47.704878
1621	1621	2000	2025-07-18 16:43:47.704878	2025-07-18 16:43:47.707868
1622	1622	4500	2025-07-18 16:43:47.707868	2025-07-18 16:43:47.709879
1623	1623	1000	2025-07-18 16:43:47.709879	2025-07-18 16:43:47.712234
1624	1624	1500	2025-07-18 16:43:47.712234	2025-07-18 16:43:47.71523
1625	1625	5000	2025-07-18 16:43:47.71523	2025-07-18 16:43:47.718237
1626	1626	25000	2025-07-18 16:43:47.718237	2025-07-18 16:43:47.721244
1627	1627	5500	2025-07-18 16:43:47.721244	2025-07-18 16:43:47.72329
1628	1628	10000	2025-07-18 16:43:47.72329	2025-07-18 16:43:47.725289
1629	1629	20000	2025-07-18 16:43:47.725289	2025-07-18 16:43:47.728275
1630	1630	25000	2025-07-18 16:43:47.728275	2025-07-18 16:43:47.730289
1631	1631	25000	2025-07-18 16:43:47.730289	2025-07-18 16:43:47.732258
1632	1632	35000	2025-07-18 16:43:47.733256	2025-07-18 16:43:47.735253
1633	1633	35000	2025-07-18 16:43:47.735253	2025-07-18 16:43:47.736783
1634	1634	35000	2025-07-18 16:43:47.737814	2025-07-18 16:43:47.73983
1635	1635	55000	2025-07-18 16:43:47.73983	2025-07-18 16:43:47.741816
1636	1636	2500	2025-07-18 16:43:47.741816	2025-07-18 16:43:47.745051
1637	1637	3000	2025-07-18 16:43:47.745051	2025-07-18 16:43:47.74866
1638	1638	4000	2025-07-18 16:43:47.74866	2025-07-18 16:43:47.751718
1639	1639	4500	2025-07-18 16:43:47.751718	2025-07-18 16:43:47.754705
1640	1640	3500	2025-07-18 16:43:47.754705	2025-07-18 16:43:47.75672
1641	1641	3500	2025-07-18 16:43:47.75672	2025-07-18 16:43:47.758704
1642	1642	5000	2025-07-18 16:43:47.758704	2025-07-18 16:43:47.760719
1643	1643	2000	2025-07-18 16:43:47.761719	2025-07-18 16:43:47.763718
1644	1644	500	2025-07-18 16:43:47.763718	2025-07-18 16:43:47.765712
1645	1645	1000	2025-07-18 16:43:47.766702	2025-07-18 16:43:47.768702
1646	1646	5000	2025-07-18 16:43:47.768702	2025-07-18 16:43:47.770705
1647	1647	3500	2025-07-18 16:43:47.770705	2025-07-18 16:43:47.77275
1648	1648	6000	2025-07-18 16:43:47.77275	2025-07-18 16:43:47.775751
1649	1649	10000	2025-07-18 16:43:47.775751	2025-07-18 16:43:47.778718
1650	1650	8000	2025-07-18 16:43:47.779735	2025-07-18 16:43:47.781751
1651	1651	10000	2025-07-18 16:43:47.781751	2025-07-18 16:43:47.783751
1652	1652	2500	2025-07-18 16:43:47.783751	2025-07-18 16:43:47.785751
1653	1653	2500	2025-07-18 16:43:47.785751	2025-07-18 16:43:47.788929
1654	1654	2500	2025-07-18 16:43:47.789973	2025-07-18 16:43:47.791999
1655	1655	200000	2025-07-18 16:43:47.791999	2025-07-18 16:43:47.794984
1656	1656	4000	2025-07-18 16:43:47.794984	2025-07-18 16:43:47.796998
1657	1657	0	2025-07-18 16:43:47.796998	2025-07-18 16:43:47.799963
1658	1658	1000	2025-07-18 16:43:47.800982	2025-07-18 16:43:47.802984
1659	1659	2500	2025-07-18 16:43:47.802984	2025-07-18 16:43:47.804984
1660	1660	1000	2025-07-18 16:43:47.804984	2025-07-18 16:43:47.805984
1661	1661	1500	2025-07-18 16:43:47.805984	2025-07-18 16:43:47.807984
1662	1662	1500	2025-07-18 16:43:47.807984	2025-07-18 16:43:47.810982
1663	1663	4000	2025-07-18 16:43:47.810982	2025-07-18 16:43:47.814178
1664	1664	2500	2025-07-18 16:43:47.814178	2025-07-18 16:43:47.816164
1665	1665	550000	2025-07-18 16:43:47.816164	2025-07-18 16:43:47.817164
1666	1666	1200000	2025-07-18 16:43:47.817164	2025-07-18 16:43:47.819178
1667	1667	10000	2025-07-18 16:43:47.820178	2025-07-18 16:43:47.822178
1668	1668	20000	2025-07-18 16:43:47.823209	2025-07-18 16:43:47.825225
1669	1669	20000	2025-07-18 16:43:47.825225	2025-07-18 16:43:47.828225
1670	1670	20000	2025-07-18 16:43:47.828225	2025-07-18 16:43:47.830225
1671	1671	50000	2025-07-18 16:43:47.831226	2025-07-18 16:43:47.833194
1672	1672	5000	2025-07-18 16:43:47.833194	2025-07-18 16:43:47.836211
1673	1673	5000	2025-07-18 16:43:47.836211	2025-07-18 16:43:47.83979
1674	1674	5000	2025-07-18 16:43:47.83979	2025-07-18 16:43:47.841592
1675	1675	6000	2025-07-18 16:43:47.842792	2025-07-18 16:43:47.845467
1676	1676	6000	2025-07-18 16:43:47.845467	2025-07-18 16:43:47.847553
1677	1677	5000	2025-07-18 16:43:47.847553	2025-07-18 16:43:47.850249
1678	1678	6000	2025-07-18 16:43:47.850249	2025-07-18 16:43:47.852249
1679	1679	29500	2025-07-18 16:43:47.852249	2025-07-18 16:43:47.85525
1680	1680	20000	2025-07-18 16:43:47.85525	2025-07-18 16:43:47.857738
1681	1681	1500	2025-07-18 16:43:47.857738	2025-07-18 16:43:47.861796
1682	1682	60000	2025-07-18 16:43:47.861796	2025-07-18 16:43:47.863783
1683	1683	95000	2025-07-18 16:43:47.863783	2025-07-18 16:43:47.865764
1684	1684	90000	2025-07-18 16:43:47.865764	2025-07-18 16:43:47.868864
1685	1685	25000	2025-07-18 16:43:47.868864	2025-07-18 16:43:47.870923
1686	1686	65000	2025-07-18 16:43:47.870923	2025-07-18 16:43:47.872922
1687	1687	105000	2025-07-18 16:43:47.872922	2025-07-18 16:43:47.874953
1688	1688	37000	2025-07-18 16:43:47.874953	2025-07-18 16:43:47.876969
1689	1689	16000	2025-07-18 16:43:47.876969	2025-07-18 16:43:47.87993
1690	1690	15000	2025-07-18 16:43:47.880969	2025-07-18 16:43:47.883969
1691	1691	110000	2025-07-18 16:43:47.883969	2025-07-18 16:43:47.885955
1692	1692	130000	2025-07-18 16:43:47.885955	2025-07-18 16:43:47.887933
1693	1693	120000	2025-07-18 16:43:47.887933	2025-07-18 16:43:47.891247
1694	1694	60000	2025-07-18 16:43:47.891247	2025-07-18 16:43:47.893301
1695	1695	110000	2025-07-18 16:43:47.893301	2025-07-18 16:43:47.894301
1696	1696	45000	2025-07-18 16:43:47.894301	2025-07-18 16:43:47.896315
1697	1697	100000	2025-07-18 16:43:47.897316	2025-07-18 16:43:47.899318
1698	1698	55000	2025-07-18 16:43:47.899318	2025-07-18 16:43:47.901299
1699	1699	25000	2025-07-18 16:43:47.901299	2025-07-18 16:43:47.90336
1700	1700	50000	2025-07-18 16:43:47.90436	2025-07-18 16:43:47.906359
1701	1701	40000	2025-07-18 16:43:47.906359	2025-07-18 16:43:47.90836
1702	1702	5000	2025-07-18 16:43:47.90936	2025-07-18 16:43:47.911359
1703	1703	1500	2025-07-18 16:43:47.911359	2025-07-18 16:43:47.913359
1704	1704	2500	2025-07-18 16:43:47.913359	2025-07-18 16:43:47.91636
1705	1705	60000	2025-07-18 16:43:47.91636	2025-07-18 16:43:47.918359
1706	1706	10000	2025-07-18 16:43:47.918359	2025-07-18 16:43:47.920359
1707	1707	45000	2025-07-18 16:43:47.921327	2025-07-18 16:43:47.923563
1708	1708	35000	2025-07-18 16:43:47.923563	2025-07-18 16:43:47.925889
1709	1709	7850000	2025-07-18 16:43:47.925889	2025-07-18 16:43:47.927903
1710	1710	125000	2025-07-18 16:43:47.927903	2025-07-18 16:43:47.929903
1711	1711	130000	2025-07-18 16:43:47.930904	2025-07-18 16:43:47.932903
1712	1712	95000	2025-07-18 16:43:47.933887	2025-07-18 16:43:47.935904
1713	1713	18000	2025-07-18 16:43:47.936889	2025-07-18 16:43:47.938433
1714	1714	5000	2025-07-18 16:43:47.938433	2025-07-18 16:43:47.940484
1715	1715	5000	2025-07-18 16:43:47.941484	2025-07-18 16:43:47.943472
1716	1716	123876	2025-07-18 16:43:47.943472	2025-07-18 16:43:47.945617
1717	1717	156000	2025-07-18 16:43:47.945617	2025-07-18 16:43:47.948117
1718	1718	13000	2025-07-18 16:43:47.948117	2025-07-18 16:43:47.950117
1719	1719	17000	2025-07-18 16:43:47.950117	2025-07-18 16:43:47.952106
1720	1720	90000	2025-07-18 16:43:47.952106	2025-07-18 16:43:47.954131
1721	1721	20000	2025-07-18 16:43:47.954131	2025-07-18 16:43:47.957115
1722	1722	150000	2025-07-18 16:43:47.958117	2025-07-18 16:43:47.959117
1723	1723	95000	2025-07-18 16:43:47.959117	2025-07-18 16:43:47.962131
1724	1724	90000	2025-07-18 16:43:47.962131	2025-07-18 16:43:47.964131
1725	1725	250000	2025-07-18 16:43:47.964131	2025-07-18 16:43:47.967115
1726	1726	280000	2025-07-18 16:43:47.967115	2025-07-18 16:43:47.968098
1727	1727	92500	2025-07-18 16:43:47.968098	2025-07-18 16:43:47.970117
1728	1728	92500	2025-07-18 16:43:47.970117	2025-07-18 16:43:47.972131
1729	1729	92500	2025-07-18 16:43:47.972131	2025-07-18 16:43:47.974162
1730	1730	92500	2025-07-18 16:43:47.975163	2025-07-18 16:43:47.977129
1731	1731	92500	2025-07-18 16:43:47.978148	2025-07-18 16:43:47.980147
1732	1732	265000	2025-07-18 16:43:47.981148	2025-07-18 16:43:47.983149
1733	1733	265000	2025-07-18 16:43:47.984162	2025-07-18 16:43:47.986149
1734	1734	265000	2025-07-18 16:43:47.986149	2025-07-18 16:43:47.988641
1735	1735	265000	2025-07-18 16:43:47.988641	2025-07-18 16:43:47.991141
1736	1736	265000	2025-07-18 16:43:47.992218	2025-07-18 16:43:47.994218
1737	1737	438000	2025-07-18 16:43:47.994218	2025-07-18 16:43:47.996218
1738	1738	438000	2025-07-18 16:43:47.996218	2025-07-18 16:43:47.999185
1739	1739	2236000	2025-07-18 16:43:47.999185	2025-07-18 16:43:48.001369
1740	1740	469000	2025-07-18 16:43:48.001369	2025-07-18 16:43:48.002793
1741	1741	702000	2025-07-18 16:43:48.002793	2025-07-18 16:43:48.004837
1742	1742	469000	2025-07-18 16:43:48.004837	2025-07-18 16:43:48.006837
1743	1743	469000	2025-07-18 16:43:48.006837	2025-07-18 16:43:48.008852
1744	1744	702000	2025-07-18 16:43:48.009851	2025-07-18 16:43:48.012838
1745	1745	702000	2025-07-18 16:43:48.012838	2025-07-18 16:43:48.014837
1746	1746	702000	2025-07-18 16:43:48.015851	2025-07-18 16:43:48.017837
1747	1747	628000	2025-07-18 16:43:48.017837	2025-07-18 16:43:48.018838
1748	1748	673000	2025-07-18 16:43:48.018838	2025-07-18 16:43:48.020838
1749	1749	673000	2025-07-18 16:43:48.020838	2025-07-18 16:43:48.022835
1750	1750	673000	2025-07-18 16:43:48.022835	2025-07-18 16:43:48.024867
1751	1751	673000	2025-07-18 16:43:48.025867	2025-07-18 16:43:48.027881
1752	1752	954000	2025-07-18 16:43:48.027881	2025-07-18 16:43:48.029881
1753	1753	954000	2025-07-18 16:43:48.029881	2025-07-18 16:43:48.031881
1754	1754	184000	2025-07-18 16:43:48.032882	2025-07-18 16:43:48.035867
1755	1755	257000	2025-07-18 16:43:48.035867	2025-07-18 16:43:48.037881
1756	1756	65000	2025-07-18 16:43:48.037881	2025-07-18 16:43:48.041432
1757	1757	266000	2025-07-18 16:43:48.041432	2025-07-18 16:43:48.043423
1758	1758	226000	2025-07-18 16:43:48.043423	2025-07-18 16:43:48.046432
1759	1759	83000	2025-07-18 16:43:48.046432	2025-07-18 16:43:48.049446
1760	1760	312000	2025-07-18 16:43:48.049446	2025-07-18 16:43:48.051446
1761	1761	251000	2025-07-18 16:43:48.051446	2025-07-18 16:43:48.053446
1762	1762	23000	2025-07-18 16:43:48.054446	2025-07-18 16:43:48.056446
1763	1763	47000	2025-07-18 16:43:48.05743	2025-07-18 16:43:48.059446
1764	1764	21000	2025-07-18 16:43:48.059446	2025-07-18 16:43:48.061446
1765	1765	149000	2025-07-18 16:43:48.061446	2025-07-18 16:43:48.063961
1766	1766	194000	2025-07-18 16:43:48.063961	2025-07-18 16:43:48.066106
1767	1767	232000	2025-07-18 16:43:48.066106	2025-07-18 16:43:48.068156
1768	1768	223000	2025-07-18 16:43:48.068156	2025-07-18 16:43:48.071034
1769	1769	103000	2025-07-18 16:43:48.071034	2025-07-18 16:43:48.073071
1770	1770	42600	2025-07-18 16:43:48.073071	2025-07-18 16:43:48.075103
1771	1771	71000	2025-07-18 16:43:48.075103	2025-07-18 16:43:48.077102
1772	1772	89000	2025-07-18 16:43:48.077102	2025-07-18 16:43:48.080116
1773	1773	255000	2025-07-18 16:43:48.080116	2025-07-18 16:43:48.082102
1774	1774	18700	2025-07-18 16:43:48.082102	2025-07-18 16:43:48.083102
1775	1775	121000	2025-07-18 16:43:48.084102	2025-07-18 16:43:48.085102
1776	1776	31000	2025-07-18 16:43:48.085102	2025-07-18 16:43:48.087116
1777	1777	22000	2025-07-18 16:43:48.087116	2025-07-18 16:43:48.090159
1778	1778	18700	2025-07-18 16:43:48.091159	2025-07-18 16:43:48.092161
1779	1779	18700	2025-07-18 16:43:48.093161	2025-07-18 16:43:48.095175
1780	1780	31000	2025-07-18 16:43:48.095175	2025-07-18 16:43:48.097175
1781	1781	22000	2025-07-18 16:43:48.097175	2025-07-18 16:43:48.099141
1782	1782	18700	2025-07-18 16:43:48.100176	2025-07-18 16:43:48.101443
1783	1783	31000	2025-07-18 16:43:48.102473	2025-07-18 16:43:48.104494
1784	1784	22000	2025-07-18 16:43:48.10548	2025-07-18 16:43:48.10748
1785	1785	249000	2025-07-18 16:43:48.10748	2025-07-18 16:43:48.109494
1786	1786	249000	2025-07-18 16:43:48.109494	2025-07-18 16:43:48.112478
1787	1787	249000	2025-07-18 16:43:48.112478	2025-07-18 16:43:48.114564
1788	1788	107000	2025-07-18 16:43:48.114564	2025-07-18 16:43:48.117563
1789	1789	99000	2025-07-18 16:43:48.117563	2025-07-18 16:43:48.119563
1790	1790	0	2025-07-18 16:43:48.120564	2025-07-18 16:43:48.122563
1791	1791	110000	2025-07-18 16:43:48.122563	2025-07-18 16:43:48.126611
1792	1792	140000	2025-07-18 16:43:48.126611	2025-07-18 16:43:48.128597
1793	1793	20000	2025-07-18 16:43:48.128597	2025-07-18 16:43:48.130611
1794	1794	4000	2025-07-18 16:43:48.130611	2025-07-18 16:43:48.133579
1795	1795	1050000	2025-07-18 16:43:48.133579	2025-07-18 16:43:48.136611
1796	1796	2220000	2025-07-18 16:43:48.136611	2025-07-18 16:43:48.138611
1797	1797	2200000	2025-07-18 16:43:48.139612	2025-07-18 16:43:48.141137
1798	1798	2400000	2025-07-18 16:43:48.142138	2025-07-18 16:43:48.144138
1799	1799	7160000	2025-07-18 16:43:48.144138	2025-07-18 16:43:48.146136
1800	1800	4400000	2025-07-18 16:43:48.146136	2025-07-18 16:43:48.148123
1801	1801	4450000	2025-07-18 16:43:48.148123	2025-07-18 16:43:48.150123
1802	1802	1800000	2025-07-18 16:43:48.150123	2025-07-18 16:43:48.151123
1803	1803	184000	2025-07-18 16:43:48.151123	2025-07-18 16:43:48.153138
1804	1804	160000	2025-07-18 16:43:48.153138	2025-07-18 16:43:48.156138
1805	1805	280000	2025-07-18 16:43:48.157151	2025-07-18 16:43:48.158129
1806	1806	5000	2025-07-18 16:43:48.159124	2025-07-18 16:43:48.161138
1807	1807	550000	2025-07-18 16:43:48.161138	2025-07-18 16:43:48.163137
1808	1808	110000	2025-07-18 16:43:48.163137	2025-07-18 16:43:48.165137
1809	1809	190000	2025-07-18 16:43:48.166105	2025-07-18 16:43:48.168122
1810	1810	120000	2025-07-18 16:43:48.168122	2025-07-18 16:43:48.170139
1811	1811	220000	2025-07-18 16:43:48.170139	2025-07-18 16:43:48.172124
1812	1812	90000	2025-07-18 16:43:48.172124	2025-07-18 16:43:48.174155
1813	1813	150000	2025-07-18 16:43:48.174155	2025-07-18 16:43:48.175153
1814	1814	100000	2025-07-18 16:43:48.175153	2025-07-18 16:43:48.17817
1815	1815	100000	2025-07-18 16:43:48.17817	2025-07-18 16:43:48.180153
1816	1816	130000	2025-07-18 16:43:48.181169	2025-07-18 16:43:48.183156
1817	1817	135000	2025-07-18 16:43:48.183156	2025-07-18 16:43:48.185169
1818	1818	65000	2025-07-18 16:43:48.185169	2025-07-18 16:43:48.187169
1819	1819	105000	2025-07-18 16:43:48.187169	2025-07-18 16:43:48.1902
1820	1820	55000	2025-07-18 16:43:48.1902	2025-07-18 16:43:48.192397
1821	1821	18000	2025-07-18 16:43:48.192397	2025-07-18 16:43:48.194412
1822	1822	40000	2025-07-18 16:43:48.194412	2025-07-18 16:43:48.196411
1823	1823	7000	2025-07-18 16:43:48.197397	2025-07-18 16:43:48.199378
1824	1824	18000	2025-07-18 16:43:48.199378	2025-07-18 16:43:48.201395
1825	1825	20000	2025-07-18 16:43:48.202396	2025-07-18 16:43:48.204411
1826	1826	10000	2025-07-18 16:43:48.204411	2025-07-18 16:43:48.206411
1827	1827	5000	2025-07-18 16:43:48.206411	2025-07-18 16:43:48.209412
1828	1828	18000	2025-07-18 16:43:48.209412	2025-07-18 16:43:48.211397
1829	1829	20000	2025-07-18 16:43:48.211397	2025-07-18 16:43:48.213398
1830	1830	15000	2025-07-18 16:43:48.214397	2025-07-18 16:43:48.216411
1831	1831	15000	2025-07-18 16:43:48.216411	2025-07-18 16:43:48.218411
1832	1832	10000	2025-07-18 16:43:48.218411	2025-07-18 16:43:48.221415
1833	1833	6000	2025-07-18 16:43:48.221415	2025-07-18 16:43:48.222848
1834	1834	400000	2025-07-18 16:43:48.223883	2025-07-18 16:43:48.2249
1835	1835	850000	2025-07-18 16:43:48.225947	2025-07-18 16:43:48.227946
1836	1836	600000	2025-07-18 16:43:48.227946	2025-07-18 16:43:48.229946
1837	1837	1250000	2025-07-18 16:43:48.230947	2025-07-18 16:43:48.233933
1838	1838	420000	2025-07-18 16:43:48.233933	2025-07-18 16:43:48.236947
1839	1839	70000	2025-07-18 16:43:48.236947	2025-07-18 16:43:48.238933
1840	1840	50000	2025-07-18 16:43:48.238933	2025-07-18 16:43:48.241528
1841	1841	70000	2025-07-18 16:43:48.241528	2025-07-18 16:43:48.243528
1842	1842	70000	2025-07-18 16:43:48.243528	2025-07-18 16:43:48.246516
1843	1843	10000	2025-07-18 16:43:48.246516	2025-07-18 16:43:48.249514
1844	1844	15000	2025-07-18 16:43:48.249514	2025-07-18 16:43:48.250514
1845	1845	15000	2025-07-18 16:43:48.251528	2025-07-18 16:43:48.252528
1846	1846	10000	2025-07-18 16:43:48.253514	2025-07-18 16:43:48.254514
1847	1847	15000	2025-07-18 16:43:48.254514	2025-07-18 16:43:48.256512
1848	1848	15000	2025-07-18 16:43:48.256512	2025-07-18 16:43:48.258514
1849	1849	15000	2025-07-18 16:43:48.258514	2025-07-18 16:43:48.260528
1850	1850	28000	2025-07-18 16:43:48.260528	2025-07-18 16:43:48.262528
1851	1851	228000	2025-07-18 16:43:48.262528	2025-07-18 16:43:48.264528
1852	1852	20000	2025-07-18 16:43:48.265528	2025-07-18 16:43:48.268503
1853	1853	25000	2025-07-18 16:43:48.268503	2025-07-18 16:43:48.269514
1854	1854	40000	2025-07-18 16:43:48.270514	2025-07-18 16:43:48.272528
1855	1855	45000	2025-07-18 16:43:48.272528	2025-07-18 16:43:48.274575
1856	1856	80000	2025-07-18 16:43:48.274575	2025-07-18 16:43:48.276575
1857	1857	8000	2025-07-18 16:43:48.277567	2025-07-18 16:43:48.280561
1858	1858	8000	2025-07-18 16:43:48.280561	2025-07-18 16:43:48.282561
1859	1859	10000	2025-07-18 16:43:48.282561	2025-07-18 16:43:48.28437
1860	1860	0	2025-07-18 16:43:48.28437	2025-07-18 16:43:48.286597
1861	1861	25000	2025-07-18 16:43:48.286597	2025-07-18 16:43:48.288917
1862	1862	45000	2025-07-18 16:43:48.288917	2025-07-18 16:43:48.291581
1863	1863	3000	2025-07-18 16:43:48.291581	2025-07-18 16:43:48.295311
1864	1864	3000	2025-07-18 16:43:48.295311	2025-07-18 16:43:48.296311
1865	1865	5000	2025-07-18 16:43:48.296311	2025-07-18 16:43:48.299327
1866	1866	3000	2025-07-18 16:43:48.299327	2025-07-18 16:43:48.301309
1867	1867	12000	2025-07-18 16:43:48.302325	2025-07-18 16:43:48.303311
1868	1868	10000	2025-07-18 16:43:48.304311	2025-07-18 16:43:48.306325
1869	1869	45000	2025-07-18 16:43:48.306325	2025-07-18 16:43:48.308325
1870	1870	135000	2025-07-18 16:43:48.308325	2025-07-18 16:43:48.310325
1871	1871	165000	2025-07-18 16:43:48.311326	2025-07-18 16:43:48.313309
1872	1872	250000	2025-07-18 16:43:48.314311	2025-07-18 16:43:48.317325
1873	1873	420000	2025-07-18 16:43:48.317325	2025-07-18 16:43:48.319311
1874	1874	1250000	2025-07-18 16:43:48.319311	2025-07-18 16:43:48.321325
1875	1875	2050000	2025-07-18 16:43:48.321325	2025-07-18 16:43:48.325325
1876	1876	1450000	2025-07-18 16:43:48.325325	2025-07-18 16:43:48.326311
1877	1877	1720000	2025-07-18 16:43:48.327343	2025-07-18 16:43:48.328343
1878	1878	1300000	2025-07-18 16:43:48.328343	2025-07-18 16:43:48.330343
1879	1879	500000	2025-07-18 16:43:48.330343	2025-07-18 16:43:48.332357
1880	1880	65000	2025-07-18 16:43:48.332357	2025-07-18 16:43:48.335341
1881	1881	1950000	2025-07-18 16:43:48.335341	2025-07-18 16:43:48.338619
1882	1882	145000	2025-07-18 16:43:48.338619	2025-07-18 16:43:48.341129
1883	1883	1700000	2025-07-18 16:43:48.341129	2025-07-18 16:43:48.34318
1884	1884	380000	2025-07-18 16:43:48.34318	2025-07-18 16:43:48.346165
1885	1885	1660000	2025-07-18 16:43:48.346165	2025-07-18 16:43:48.34918
1886	1886	180000	2025-07-18 16:43:48.34918	2025-07-18 16:43:48.35118
1887	1887	170000	2025-07-18 16:43:48.35118	2025-07-18 16:43:48.353181
1888	1888	195000	2025-07-18 16:43:48.35418	2025-07-18 16:43:48.356166
1889	1889	0	2025-07-18 16:43:48.35718	2025-07-18 16:43:48.359551
1890	1890	220000	2025-07-18 16:43:48.359551	2025-07-18 16:43:48.361565
1891	1891	250000	2025-07-18 16:43:48.361565	2025-07-18 16:43:48.363565
1892	1892	240000	2025-07-18 16:43:48.363565	2025-07-18 16:43:48.366566
1893	1893	2550000	2025-07-18 16:43:48.366566	2025-07-18 16:43:48.369551
1894	1894	850000	2025-07-18 16:43:48.369551	2025-07-18 16:43:48.370551
1895	1895	800000	2025-07-18 16:43:48.370551	2025-07-18 16:43:48.373565
1896	1896	800000	2025-07-18 16:43:48.373565	2025-07-18 16:43:48.375612
1897	1897	320000	2025-07-18 16:43:48.375612	2025-07-18 16:43:48.378614
1898	1898	500000	2025-07-18 16:43:48.378614	2025-07-18 16:43:48.379597
1899	1899	340000	2025-07-18 16:43:48.380596	2025-07-18 16:43:48.381598
1900	1900	370000	2025-07-18 16:43:48.381598	2025-07-18 16:43:48.383598
1901	1901	370000	2025-07-18 16:43:48.383598	2025-07-18 16:43:48.385613
1902	1902	1250000	2025-07-18 16:43:48.386612	2025-07-18 16:43:48.389128
1903	1903	1620000	2025-07-18 16:43:48.389128	2025-07-18 16:43:48.391698
1904	1904	75000	2025-07-18 16:43:48.391698	2025-07-18 16:43:48.392732
1905	1905	165000	2025-07-18 16:43:48.393732	2025-07-18 16:43:48.394732
1906	1906	75000	2025-07-18 16:43:48.395732	2025-07-18 16:43:48.397731
1907	1907	135000	2025-07-18 16:43:48.397731	2025-07-18 16:43:48.400732
1908	1908	135000	2025-07-18 16:43:48.400732	2025-07-18 16:43:48.402732
1909	1909	75000	2025-07-18 16:43:48.403732	2025-07-18 16:43:48.405746
1910	1910	15000	2025-07-18 16:43:48.405746	2025-07-18 16:43:48.407746
1911	1911	320000	2025-07-18 16:43:48.407746	2025-07-18 16:43:48.410713
1912	1912	35000	2025-07-18 16:43:48.410713	2025-07-18 16:43:48.41273
1913	1913	50000	2025-07-18 16:43:48.41273	2025-07-18 16:43:48.414747
1914	1914	80000	2025-07-18 16:43:48.415732	2025-07-18 16:43:48.416746
1915	1915	70000	2025-07-18 16:43:48.417746	2025-07-18 16:43:48.419746
1916	1916	275000	2025-07-18 16:43:48.419746	2025-07-18 16:43:48.422746
1917	1917	90000	2025-07-18 16:43:48.422746	2025-07-18 16:43:48.424732
1918	1918	70000	2025-07-18 16:43:48.424732	2025-07-18 16:43:48.425732
1919	1919	45000	2025-07-18 16:43:48.426746	2025-07-18 16:43:48.428779
1920	1920	65000	2025-07-18 16:43:48.428779	2025-07-18 16:43:48.431085
1921	1921	135000	2025-07-18 16:43:48.431085	2025-07-18 16:43:48.432094
1922	1922	135000	2025-07-18 16:43:48.432094	2025-07-18 16:43:48.435103
1923	1923	120000	2025-07-18 16:43:48.435103	2025-07-18 16:43:48.437151
1924	1924	100000	2025-07-18 16:43:48.437151	2025-07-18 16:43:48.439165
1925	1925	95000	2025-07-18 16:43:48.439165	2025-07-18 16:43:48.441165
1926	1926	100000	2025-07-18 16:43:48.442166	2025-07-18 16:43:48.444623
1927	1927	95000	2025-07-18 16:43:48.444623	2025-07-18 16:43:48.446648
1928	1928	115000	2025-07-18 16:43:48.446648	2025-07-18 16:43:48.449642
1929	1929	82000	2025-07-18 16:43:48.449642	2025-07-18 16:43:48.451656
1930	1930	96000	2025-07-18 16:43:48.451656	2025-07-18 16:43:48.453656
1931	1931	85000	2025-07-18 16:43:48.453656	2025-07-18 16:43:48.45664
1932	1932	160000	2025-07-18 16:43:48.45664	2025-07-18 16:43:48.460005
1933	1933	70000	2025-07-18 16:43:48.460005	2025-07-18 16:43:48.46203
1934	1934	280000	2025-07-18 16:43:48.46203	2025-07-18 16:43:48.46403
1935	1935	500000	2025-07-18 16:43:48.46403	2025-07-18 16:43:48.466999
1936	1936	85000	2025-07-18 16:43:48.468014	2025-07-18 16:43:48.471031
1937	1937	85000	2025-07-18 16:43:48.471031	2025-07-18 16:43:48.473016
1938	1938	102600	2025-07-18 16:43:48.473016	2025-07-18 16:43:48.475061
1939	1939	135000	2025-07-18 16:43:48.475061	2025-07-18 16:43:48.478062
1940	1940	50000	2025-07-18 16:43:48.478062	2025-07-18 16:43:48.480045
1941	1941	60000	2025-07-18 16:43:48.480045	2025-07-18 16:43:48.482061
1942	1942	80000	2025-07-18 16:43:48.482061	2025-07-18 16:43:48.485061
1943	1943	125000	2025-07-18 16:43:48.485061	2025-07-18 16:43:48.487061
1944	1944	25000	2025-07-18 16:43:48.487061	2025-07-18 16:43:48.489583
1945	1945	155000	2025-07-18 16:43:48.490592	2025-07-18 16:43:48.492683
1946	1946	180000	2025-07-18 16:43:48.492683	2025-07-18 16:43:48.494734
1947	1947	30000	2025-07-18 16:43:48.494734	2025-07-18 16:43:48.496734
1948	1948	35000	2025-07-18 16:43:48.496734	2025-07-18 16:43:48.498734
1949	1949	40000	2025-07-18 16:43:48.499735	2025-07-18 16:43:48.502718
1950	1950	260000	2025-07-18 16:43:48.502718	2025-07-18 16:43:48.50472
1951	1951	50000	2025-07-18 16:43:48.50472	2025-07-18 16:43:48.505457
1952	1952	40000	2025-07-18 16:43:48.505457	2025-07-18 16:43:48.507759
1953	1953	190000	2025-07-18 16:43:48.507759	2025-07-18 16:43:48.509853
1954	1954	260000	2025-07-18 16:43:48.509853	2025-07-18 16:43:48.513245
1955	1955	175000	2025-07-18 16:43:48.513245	2025-07-18 16:43:48.515293
1956	1956	240000	2025-07-18 16:43:48.515293	2025-07-18 16:43:48.517278
1957	1957	250000	2025-07-18 16:43:48.517278	2025-07-18 16:43:48.518278
1958	1958	145000	2025-07-18 16:43:48.518278	2025-07-18 16:43:48.520292
1959	1959	145000	2025-07-18 16:43:48.521293	2025-07-18 16:43:48.523292
1960	1960	165000	2025-07-18 16:43:48.523292	2025-07-18 16:43:48.526276
1961	1961	175000	2025-07-18 16:43:48.526276	2025-07-18 16:43:48.528339
1962	1962	200000	2025-07-18 16:43:48.528339	2025-07-18 16:43:48.530339
1963	1963	240000	2025-07-18 16:43:48.530339	2025-07-18 16:43:48.532339
1964	1964	380000	2025-07-18 16:43:48.53334	2025-07-18 16:43:48.535325
1965	1965	65000	2025-07-18 16:43:48.535325	2025-07-18 16:43:48.537339
1966	1966	75000	2025-07-18 16:43:48.537339	2025-07-18 16:43:48.540339
1967	1967	90000	2025-07-18 16:43:48.540339	2025-07-18 16:43:48.541325
1968	1968	120000	2025-07-18 16:43:48.54287	2025-07-18 16:43:48.54492
1969	1969	175000	2025-07-18 16:43:48.54492	2025-07-18 16:43:48.546888
1970	1970	175000	2025-07-18 16:43:48.547905	2025-07-18 16:43:48.548937
1971	1971	165000	2025-07-18 16:43:48.548937	2025-07-18 16:43:48.549948
1972	1972	220000	2025-07-18 16:43:48.550947	2025-07-18 16:43:48.552947
1973	1973	20000	2025-07-18 16:43:48.552947	2025-07-18 16:43:48.554947
1974	1974	35000	2025-07-18 16:43:48.555936	2025-07-18 16:43:48.557947
1975	1975	19000	2025-07-18 16:43:48.557947	2025-07-18 16:43:48.560962
1976	1976	35000	2025-07-18 16:43:48.560962	2025-07-18 16:43:48.562947
1977	1977	25000	2025-07-18 16:43:48.562947	2025-07-18 16:43:48.564962
1978	1978	10000	2025-07-18 16:43:48.564962	2025-07-18 16:43:48.56793
1979	1979	290000	2025-07-18 16:43:48.56793	2025-07-18 16:43:48.570945
1980	1980	260000	2025-07-18 16:43:48.570945	2025-07-18 16:43:48.573962
1981	1981	80000	2025-07-18 16:43:48.573962	2025-07-18 16:43:48.576009
1982	1982	170000	2025-07-18 16:43:48.576009	2025-07-18 16:43:48.57901
1983	1983	2000	2025-07-18 16:43:48.57901	2025-07-18 16:43:48.580006
1984	1984	420000	2025-07-18 16:43:48.580006	2025-07-18 16:43:48.581996
1985	1985	25000	2025-07-18 16:43:48.581996	2025-07-18 16:43:48.583996
1986	1986	35000	2025-07-18 16:43:48.583996	2025-07-18 16:43:48.58601
1987	1987	55000	2025-07-18 16:43:48.58601	2025-07-18 16:43:48.588009
1988	1988	1000	2025-07-18 16:43:48.588009	2025-07-18 16:43:48.59151
1989	1989	50000	2025-07-18 16:43:48.59151	2025-07-18 16:43:48.59407
1990	1990	7000	2025-07-18 16:43:48.59407	2025-07-18 16:43:48.597075
1991	1991	80000	2025-07-18 16:43:48.597075	2025-07-18 16:43:48.599086
1992	1992	40000	2025-07-18 16:43:48.599086	2025-07-18 16:43:48.602528
1993	1993	60000	2025-07-18 16:43:48.602528	2025-07-18 16:43:48.605539
1994	1994	25000	2025-07-18 16:43:48.605539	2025-07-18 16:43:48.608553
1995	1995	20000	2025-07-18 16:43:48.608553	2025-07-18 16:43:48.610553
1996	1996	440000	2025-07-18 16:43:48.610553	2025-07-18 16:43:48.614553
1997	1997	304000	2025-07-18 16:43:48.614553	2025-07-18 16:43:48.617784
1998	1998	60000	2025-07-18 16:43:48.617784	2025-07-18 16:43:48.620798
1999	1999	30000	2025-07-18 16:43:48.620798	2025-07-18 16:43:48.623776
2000	2000	10000	2025-07-18 16:43:48.623776	2025-07-18 16:43:48.626782
2001	2001	35000	2025-07-18 16:43:48.626782	2025-07-18 16:43:48.628813
2002	2002	1000	2025-07-18 16:43:48.628813	2025-07-18 16:43:48.631829
2003	2003	6000	2025-07-18 16:43:48.631829	2025-07-18 16:43:48.633797
2004	2004	187000	2025-07-18 16:43:48.633797	2025-07-18 16:43:48.636824
2005	2005	187000	2025-07-18 16:43:48.636824	2025-07-18 16:43:48.638827
2006	2006	187000	2025-07-18 16:43:48.638827	2025-07-18 16:43:48.640827
2007	2007	4565000	2025-07-18 16:43:48.640827	2025-07-18 16:43:48.641813
2008	2008	187000	2025-07-18 16:43:48.641813	2025-07-18 16:43:48.646189
2009	2009	2574000	2025-07-18 16:43:48.646189	2025-07-18 16:43:48.648175
2010	2010	528000	2025-07-18 16:43:48.648175	2025-07-18 16:43:48.65119
2011	2011	528000	2025-07-18 16:43:48.65119	2025-07-18 16:43:48.653189
2012	2012	632500	2025-07-18 16:43:48.653189	2025-07-18 16:43:48.655189
2013	2013	858000	2025-07-18 16:43:48.655189	2025-07-18 16:43:48.658455
2014	2014	1243000	2025-07-18 16:43:48.658455	2025-07-18 16:43:48.660513
2015	2015	2574000	2025-07-18 16:43:48.660513	2025-07-18 16:43:48.663497
2016	2016	2574000	2025-07-18 16:43:48.663497	2025-07-18 16:43:48.666507
2017	2017	1661000	2025-07-18 16:43:48.666507	2025-07-18 16:43:48.667514
2018	2018	800000	2025-07-18 16:43:48.667514	2025-07-18 16:43:48.670499
2019	2019	5600000	2025-07-18 16:43:48.670499	2025-07-18 16:43:48.672513
2020	2020	3800000	2025-07-18 16:43:48.672513	2025-07-18 16:43:48.674546
2021	2021	5500000	2025-07-18 16:43:48.674546	2025-07-18 16:43:48.67656
2022	2022	2700000	2025-07-18 16:43:48.67656	2025-07-18 16:43:48.679546
2023	2023	3500000	2025-07-18 16:43:48.679546	2025-07-18 16:43:48.68156
2024	2024	3500000	2025-07-18 16:43:48.68156	2025-07-18 16:43:48.683546
2025	2025	750000	2025-07-18 16:43:48.683546	2025-07-18 16:43:48.685546
2026	2026	1280000	2025-07-18 16:43:48.685546	2025-07-18 16:43:48.68756
2027	2027	1300000	2025-07-18 16:43:48.68756	2025-07-18 16:43:48.690156
2028	2028	1250000	2025-07-18 16:43:48.69114	2025-07-18 16:43:48.693142
2029	2029	650000	2025-07-18 16:43:48.693142	2025-07-18 16:43:48.69465
2030	2030	750000	2025-07-18 16:43:48.695681	2025-07-18 16:43:48.697698
2031	2031	1700000	2025-07-18 16:43:48.697698	2025-07-18 16:43:48.699698
2032	2032	1300000	2025-07-18 16:43:48.699698	2025-07-18 16:43:48.702675
2033	2033	1030000	2025-07-18 16:43:48.702675	2025-07-18 16:43:48.704682
2034	2034	650000	2025-07-18 16:43:48.705684	2025-07-18 16:43:48.706683
2035	2035	4200000	2025-07-18 16:43:48.706683	2025-07-18 16:43:48.708684
2036	2036	200000	2025-07-18 16:43:48.708684	2025-07-18 16:43:48.710698
2037	2037	100000	2025-07-18 16:43:48.710698	2025-07-18 16:43:48.712683
2038	2038	50000	2025-07-18 16:43:48.712683	2025-07-18 16:43:48.714684
2039	2039	60000	2025-07-18 16:43:48.714684	2025-07-18 16:43:48.716682
2040	2040	31320	2025-07-18 16:43:48.716682	2025-07-18 16:43:48.718698
2041	2041	121255	2025-07-18 16:43:48.718698	2025-07-18 16:43:48.721698
2042	2042	141790	2025-07-18 16:43:48.721698	2025-07-18 16:43:48.723698
2043	2043	870000	2025-07-18 16:43:48.723698	2025-07-18 16:43:48.725456
2044	2044	290000	2025-07-18 16:43:48.725456	2025-07-18 16:43:48.727725
2045	2045	750000	2025-07-18 16:43:48.727725	2025-07-18 16:43:48.729288
2046	2046	300000	2025-07-18 16:43:48.729288	2025-07-18 16:43:48.731937
2047	2047	1200000	2025-07-18 16:43:48.731937	2025-07-18 16:43:48.73462
2048	2048	200000	2025-07-18 16:43:48.735618	2025-07-18 16:43:48.737626
2049	2049	55000	2025-07-18 16:43:48.737626	2025-07-18 16:43:48.738662
2050	2050	50000	2025-07-18 16:43:48.739676	2025-07-18 16:43:48.741676
2051	2051	1200000	2025-07-18 16:43:48.741676	2025-07-18 16:43:48.743676
2052	2052	33000	2025-07-18 16:43:48.743676	2025-07-18 16:43:48.747239
2053	2053	50000	2025-07-18 16:43:48.747239	2025-07-18 16:43:48.74924
2054	2054	65000	2025-07-18 16:43:48.74924	2025-07-18 16:43:48.751255
2055	2055	50000	2025-07-18 16:43:48.751255	2025-07-18 16:43:48.753255
2056	2056	50000	2025-07-18 16:43:48.753255	2025-07-18 16:43:48.756255
2057	2057	55000	2025-07-18 16:43:48.756255	2025-07-18 16:43:48.75824
2058	2058	65000	2025-07-18 16:43:48.759283	2025-07-18 16:43:48.761299
2059	2059	50000	2025-07-18 16:43:48.761299	2025-07-18 16:43:48.763298
2060	2060	248500	2025-07-18 16:43:48.763298	2025-07-18 16:43:48.765284
2061	2061	208000	2025-07-18 16:43:48.765284	2025-07-18 16:43:48.768261
2062	2062	165000	2025-07-18 16:43:48.769283	2025-07-18 16:43:48.771284
2063	2063	190000	2025-07-18 16:43:48.772284	2025-07-18 16:43:48.774284
2064	2064	248500	2025-07-18 16:43:48.774284	2025-07-18 16:43:48.775316
2065	2065	158500	2025-07-18 16:43:48.775316	2025-07-18 16:43:48.77733
2066	2066	175000	2025-07-18 16:43:48.778318	2025-07-18 16:43:48.779316
2067	2067	208000	2025-07-18 16:43:48.779316	2025-07-18 16:43:48.781317
2068	2068	248000	2025-07-18 16:43:48.781317	2025-07-18 16:43:48.783314
2069	2069	62000	2025-07-18 16:43:48.783314	2025-07-18 16:43:48.78533
2070	2070	62000	2025-07-18 16:43:48.78633	2025-07-18 16:43:48.78833
2071	2071	62000	2025-07-18 16:43:48.78833	2025-07-18 16:43:48.791732
2072	2072	62000	2025-07-18 16:43:48.791732	2025-07-18 16:43:48.793718
2073	2073	62000	2025-07-18 16:43:48.793718	2025-07-18 16:43:48.795732
2074	2074	62000	2025-07-18 16:43:48.795732	2025-07-18 16:43:48.798296
2075	2075	72000	2025-07-18 16:43:48.798296	2025-07-18 16:43:48.800296
2076	2076	72000	2025-07-18 16:43:48.800296	2025-07-18 16:43:48.802296
2077	2077	136000	2025-07-18 16:43:48.802296	2025-07-18 16:43:48.804282
2078	2078	136000	2025-07-18 16:43:48.805282	2025-07-18 16:43:48.806282
2079	2079	136000	2025-07-18 16:43:48.806282	2025-07-18 16:43:48.808296
2080	2080	136000	2025-07-18 16:43:48.808296	2025-07-18 16:43:48.811296
2081	2081	136000	2025-07-18 16:43:48.811296	2025-07-18 16:43:48.814297
2082	2082	158500	2025-07-18 16:43:48.814297	2025-07-18 16:43:48.816282
2083	2083	158500	2025-07-18 16:43:48.816282	2025-07-18 16:43:48.818296
2084	2084	45000	2025-07-18 16:43:48.818296	2025-07-18 16:43:48.820296
2085	2085	40000	2025-07-18 16:43:48.821297	2025-07-18 16:43:48.823296
2086	2086	5000	2025-07-18 16:43:48.823296	2025-07-18 16:43:48.825282
2087	2087	10000	2025-07-18 16:43:48.825282	2025-07-18 16:43:48.827282
2088	2088	10000	2025-07-18 16:43:48.827282	2025-07-18 16:43:48.829296
2089	2089	70000	2025-07-18 16:43:48.829296	2025-07-18 16:43:48.831343
2090	2090	620000	2025-07-18 16:43:48.832329	2025-07-18 16:43:48.834358
2091	2091	117200	2025-07-18 16:43:48.834358	2025-07-18 16:43:48.837318
2092	2092	117200	2025-07-18 16:43:48.83835	2025-07-18 16:43:48.839369
2093	2093	13800	2025-07-18 16:43:48.840369	2025-07-18 16:43:48.842369
2094	2094	29800	2025-07-18 16:43:48.842369	2025-07-18 16:43:48.844369
2095	2095	85000	2025-07-18 16:43:48.845914	2025-07-18 16:43:48.847948
2096	2096	12600	2025-07-18 16:43:48.847948	2025-07-18 16:43:48.850646
2097	2097	53500	2025-07-18 16:43:48.851948	2025-07-18 16:43:48.853962
2098	2098	119000	2025-07-18 16:43:48.854962	2025-07-18 16:43:48.857937
2099	2099	53500	2025-07-18 16:43:48.858946	2025-07-18 16:43:48.861962
2100	2100	13500	2025-07-18 16:43:48.861962	2025-07-18 16:43:48.863948
2101	2101	13500	2025-07-18 16:43:48.863948	2025-07-18 16:43:48.865948
2102	2102	13500	2025-07-18 16:43:48.865948	2025-07-18 16:43:48.868217
2103	2103	26800	2025-07-18 16:43:48.868217	2025-07-18 16:43:48.871236
2104	2104	26800	2025-07-18 16:43:48.872252	2025-07-18 16:43:48.873238
2105	2105	26800	2025-07-18 16:43:48.874238	2025-07-18 16:43:48.876284
2106	2106	26200	2025-07-18 16:43:48.876284	2025-07-18 16:43:48.879248
2107	2107	54000	2025-07-18 16:43:48.879248	2025-07-18 16:43:48.883285
2108	2108	62500	2025-07-18 16:43:48.883285	2025-07-18 16:43:48.885284
2109	2109	102000	2025-07-18 16:43:48.885284	2025-07-18 16:43:48.888284
2110	2110	102000	2025-07-18 16:43:48.888284	2025-07-18 16:43:48.890765
2111	2111	10200	2025-07-18 16:43:48.890765	2025-07-18 16:43:48.893794
2112	2112	17800	2025-07-18 16:43:48.893794	2025-07-18 16:43:48.894798
2113	2113	65500	2025-07-18 16:43:48.896328	2025-07-18 16:43:48.897376
2114	2114	16500	2025-07-18 16:43:48.897376	2025-07-18 16:43:48.899727
2115	2115	49600	2025-07-18 16:43:48.900729	2025-07-18 16:43:48.903729
2116	2116	65600	2025-07-18 16:43:48.903729	2025-07-18 16:43:48.905743
2117	2117	40200	2025-07-18 16:43:48.905743	2025-07-18 16:43:48.907743
2118	2118	12500	2025-07-18 16:43:48.908743	2025-07-18 16:43:48.910743
2119	2119	12500	2025-07-18 16:43:48.910743	2025-07-18 16:43:48.913722
2120	2120	12500	2025-07-18 16:43:48.914707	2025-07-18 16:43:48.915718
2121	2121	15800	2025-07-18 16:43:48.916729	2025-07-18 16:43:48.917729
2122	2122	15800	2025-07-18 16:43:48.917729	2025-07-18 16:43:48.919729
2123	2123	15800	2025-07-18 16:43:48.919729	2025-07-18 16:43:48.921743
2124	2124	29500	2025-07-18 16:43:48.921743	2025-07-18 16:43:48.924745
2125	2125	41800	2025-07-18 16:43:48.924745	2025-07-18 16:43:48.925709
2126	2126	36200	2025-07-18 16:43:48.926728	2025-07-18 16:43:48.927726
2127	2127	44600	2025-07-18 16:43:48.927726	2025-07-18 16:43:48.929559
2128	2128	57000	2025-07-18 16:43:48.929559	2025-07-18 16:43:48.931779
2129	2129	43500	2025-07-18 16:43:48.932829	2025-07-18 16:43:48.93477
2130	2130	43500	2025-07-18 16:43:48.93477	2025-07-18 16:43:48.936898
2131	2131	54800	2025-07-18 16:43:48.936898	2025-07-18 16:43:48.940398
2132	2132	116500	2025-07-18 16:43:48.940398	2025-07-18 16:43:48.943422
2133	2133	123600	2025-07-18 16:43:48.943422	2025-07-18 16:43:48.946921
2134	2134	10800	2025-07-18 16:43:48.946921	2025-07-18 16:43:48.948956
2135	2135	19200	2025-07-18 16:43:48.948956	2025-07-18 16:43:48.951967
2136	2136	69200	2025-07-18 16:43:48.951967	2025-07-18 16:43:48.953967
2137	2137	19200	2025-07-18 16:43:48.953967	2025-07-18 16:43:48.956938
2138	2138	60000	2025-07-18 16:43:48.956938	2025-07-18 16:43:48.959968
2139	2139	72800	2025-07-18 16:43:48.959968	2025-07-18 16:43:48.962169
2140	2140	40800	2025-07-18 16:43:48.963185	2025-07-18 16:43:48.965171
2141	2141	13500	2025-07-18 16:43:48.965171	2025-07-18 16:43:48.966171
2142	2142	13500	2025-07-18 16:43:48.966171	2025-07-18 16:43:48.969185
2143	2143	13500	2025-07-18 16:43:48.969185	2025-07-18 16:43:48.971172
2144	2144	18200	2025-07-18 16:43:48.971172	2025-07-18 16:43:48.973171
2145	2145	18200	2025-07-18 16:43:48.973171	2025-07-18 16:43:48.975216
2146	2146	18200	2025-07-18 16:43:48.976218	2025-07-18 16:43:48.977699
2147	2147	35500	2025-07-18 16:43:48.978723	2025-07-18 16:43:48.980735
2148	2148	50200	2025-07-18 16:43:48.980735	2025-07-18 16:43:48.983741
2149	2149	43500	2025-07-18 16:43:48.983741	2025-07-18 16:43:48.985757
2150	2150	43500	2025-07-18 16:43:48.986757	2025-07-18 16:43:48.987743
2151	2151	53500	2025-07-18 16:43:48.987743	2025-07-18 16:43:48.991649
2152	2152	68500	2025-07-18 16:43:48.991649	2025-07-18 16:43:48.993704
2153	2153	52200	2025-07-18 16:43:48.993704	2025-07-18 16:43:48.995717
2154	2154	52200	2025-07-18 16:43:48.996704	2025-07-18 16:43:48.998161
2155	2155	65800	2025-07-18 16:43:48.999148	2025-07-18 16:43:49.001161
2156	2156	948000	2025-07-18 16:43:49.001161	2025-07-18 16:43:49.004161
2157	2157	620000	2025-07-18 16:43:49.005151	2025-07-18 16:43:49.007133
2158	2158	117000	2025-07-18 16:43:49.008129	2025-07-18 16:43:49.009136
2159	2159	152000	2025-07-18 16:43:49.010145	2025-07-18 16:43:49.011147
2160	2160	230000	2025-07-18 16:43:49.012128	2025-07-18 16:43:49.014555
2161	2161	266000	2025-07-18 16:43:49.014555	2025-07-18 16:43:49.016609
2162	2162	55000	2025-07-18 16:43:49.016609	2025-07-18 16:43:49.018623
2163	2163	55000	2025-07-18 16:43:49.018623	2025-07-18 16:43:49.020623
2164	2164	160000	2025-07-18 16:43:49.021623	2025-07-18 16:43:49.023623
2165	2165	55000	2025-07-18 16:43:49.024623	2025-07-18 16:43:49.026768
2166	2166	150000	2025-07-18 16:43:49.027777	2025-07-18 16:43:49.028789
2167	2167	168000	2025-07-18 16:43:49.029779	2025-07-18 16:43:49.031781
2168	2168	75000	2025-07-18 16:43:49.031781	2025-07-18 16:43:49.033787
2169	2169	185000	2025-07-18 16:43:49.03479	2025-07-18 16:43:49.037786
2170	2170	230000	2025-07-18 16:43:49.037786	2025-07-18 16:43:49.038786
2171	2171	235000	2025-07-18 16:43:49.038786	2025-07-18 16:43:49.040796
2172	2172	75000	2025-07-18 16:43:49.040796	2025-07-18 16:43:49.042786
2173	2173	80000	2025-07-18 16:43:49.042786	2025-07-18 16:43:49.043786
2174	2174	85000	2025-07-18 16:43:49.044786	2025-07-18 16:43:49.046788
2175	2175	15000	2025-07-18 16:43:49.046788	2025-07-18 16:43:49.050079
2176	2176	30000	2025-07-18 16:43:49.050079	2025-07-18 16:43:49.052081
2177	2177	30000	2025-07-18 16:43:49.052081	2025-07-18 16:43:49.055078
2178	2178	30000	2025-07-18 16:43:49.055078	2025-07-18 16:43:49.05708
2179	2179	30000	2025-07-18 16:43:49.05708	2025-07-18 16:43:49.059076
2180	2180	30000	2025-07-18 16:43:49.059076	2025-07-18 16:43:49.061078
2181	2181	30000	2025-07-18 16:43:49.061078	2025-07-18 16:43:49.063076
2182	2182	85000	2025-07-18 16:43:49.063076	2025-07-18 16:43:49.065077
2183	2183	225000	2025-07-18 16:43:49.065077	2025-07-18 16:43:49.068081
2184	2184	225000	2025-07-18 16:43:49.069076	2025-07-18 16:43:49.073087
2185	2185	225000	2025-07-18 16:43:49.073087	2025-07-18 16:43:49.075108
2186	2186	235000	2025-07-18 16:43:49.075108	2025-07-18 16:43:49.077107
2187	2187	85000	2025-07-18 16:43:49.078108	2025-07-18 16:43:49.080107
2188	2188	225000	2025-07-18 16:43:49.080107	2025-07-18 16:43:49.082109
2189	2189	235000	2025-07-18 16:43:49.083109	2025-07-18 16:43:49.085105
2190	2190	85000	2025-07-18 16:43:49.085105	2025-07-18 16:43:49.087108
2191	2191	235000	2025-07-18 16:43:49.087108	2025-07-18 16:43:49.089611
2192	2192	13000	2025-07-18 16:43:49.090619	2025-07-18 16:43:49.091619
2193	2193	25000	2025-07-18 16:43:49.091619	2025-07-18 16:43:49.093622
2194	2194	6100	2025-07-18 16:43:49.094621	2025-07-18 16:43:49.09562
2195	2195	5920	2025-07-18 16:43:49.097126	2025-07-18 16:43:49.099137
2196	2196	6880	2025-07-18 16:43:49.099137	2025-07-18 16:43:49.102604
2197	2197	6100	2025-07-18 16:43:49.102604	2025-07-18 16:43:49.105088
2198	2198	5920	2025-07-18 16:43:49.106084	2025-07-18 16:43:49.108084
2199	2199	6880	2025-07-18 16:43:49.108084	2025-07-18 16:43:49.110085
2200	2200	3380	2025-07-18 16:43:49.110085	2025-07-18 16:43:49.113087
2201	2201	4850	2025-07-18 16:43:49.113087	2025-07-18 16:43:49.115362
2202	2202	8000	2025-07-18 16:43:49.115362	2025-07-18 16:43:49.116468
2203	2203	11600	2025-07-18 16:43:49.116468	2025-07-18 16:43:49.118468
2204	2204	3000	2025-07-18 16:43:49.118468	2025-07-18 16:43:49.12047
2205	2205	4200	2025-07-18 16:43:49.121467	2025-07-18 16:43:49.122469
2206	2206	7000	2025-07-18 16:43:49.123469	2025-07-18 16:43:49.125469
2207	2207	10200	2025-07-18 16:43:49.126467	2025-07-18 16:43:49.127467
2208	2208	2500	2025-07-18 16:43:49.128468	2025-07-18 16:43:49.130469
2209	2209	190000	2025-07-18 16:43:49.130469	2025-07-18 16:43:49.132468
2210	2210	232000	2025-07-18 16:43:49.132468	2025-07-18 16:43:49.133474
2211	2211	3500	2025-07-18 16:43:49.134473	2025-07-18 16:43:49.135841
2212	2212	261000	2025-07-18 16:43:49.135841	2025-07-18 16:43:49.138877
2213	2213	10000	2025-07-18 16:43:49.138877	2025-07-18 16:43:49.140877
2214	2214	356000	2025-07-18 16:43:49.140877	2025-07-18 16:43:49.143877
2215	2215	20000	2025-07-18 16:43:49.143877	2025-07-18 16:43:49.145888
2216	2216	27600	2025-07-18 16:43:49.145888	2025-07-18 16:43:49.149452
2217	2217	40500	2025-07-18 16:43:49.149452	2025-07-18 16:43:49.152468
2218	2218	82000	2025-07-18 16:43:49.152468	2025-07-18 16:43:49.154468
2219	2219	1060	2025-07-18 16:43:49.154468	2025-07-18 16:43:49.157439
2220	2220	1160	2025-07-18 16:43:49.157439	2025-07-18 16:43:49.160454
2221	2221	2200	2025-07-18 16:43:49.160454	2025-07-18 16:43:49.162454
2222	2222	2420	2025-07-18 16:43:49.162454	2025-07-18 16:43:49.163454
2223	2223	45000	2025-07-18 16:43:49.163454	2025-07-18 16:43:49.165454
2224	2224	0	2025-07-18 16:43:49.165454	2025-07-18 16:43:49.167468
2225	2225	80000	2025-07-18 16:43:49.167468	2025-07-18 16:43:49.170437
2226	2226	85000	2025-07-18 16:43:49.170437	2025-07-18 16:43:49.172452
2227	2227	900	2025-07-18 16:43:49.172452	2025-07-18 16:43:49.174454
2228	2228	980	2025-07-18 16:43:49.174454	2025-07-18 16:43:49.176501
2229	2229	1600	2025-07-18 16:43:49.1775	2025-07-18 16:43:49.179963
2230	2230	2200	2025-07-18 16:43:49.179963	2025-07-18 16:43:49.182087
2231	2231	2200	2025-07-18 16:43:49.182087	2025-07-18 16:43:49.18509
2232	2232	2320	2025-07-18 16:43:49.18509	2025-07-18 16:43:49.1871
2233	2233	2950	2025-07-18 16:43:49.1871	2025-07-18 16:43:49.189631
2234	2234	4900	2025-07-18 16:43:49.189631	2025-07-18 16:43:49.192666
2235	2235	4900	2025-07-18 16:43:49.192666	2025-07-18 16:43:49.194668
2236	2236	6850	2025-07-18 16:43:49.194668	2025-07-18 16:43:49.197658
2237	2237	8750	2025-07-18 16:43:49.197658	2025-07-18 16:43:49.200212
2238	2238	11200	2025-07-18 16:43:49.200212	2025-07-18 16:43:49.203715
2239	2239	4350	2025-07-18 16:43:49.203715	2025-07-18 16:43:49.20676
2240	2240	5720	2025-07-18 16:43:49.20676	2025-07-18 16:43:49.208747
2241	2241	7650	2025-07-18 16:43:49.208747	2025-07-18 16:43:49.21076
2242	2242	9580	2025-07-18 16:43:49.21076	2025-07-18 16:43:49.214744
2243	2243	20000	2025-07-18 16:43:49.214744	2025-07-18 16:43:49.21676
2244	2244	250000	2025-07-18 16:43:49.21676	2025-07-18 16:43:49.21976
2245	2245	25000	2025-07-18 16:43:49.21976	2025-07-18 16:43:49.22176
2246	2246	35000	2025-07-18 16:43:49.22176	2025-07-18 16:43:49.22473
2247	2247	45000	2025-07-18 16:43:49.22473	2025-07-18 16:43:49.22776
2248	2248	125000	2025-07-18 16:43:49.22776	2025-07-18 16:43:49.22976
2249	2249	145000	2025-07-18 16:43:49.22976	2025-07-18 16:43:49.23176
2250	2250	0	2025-07-18 16:43:49.23276	2025-07-18 16:43:49.234807
2251	2251	125000	2025-07-18 16:43:49.235793	2025-07-18 16:43:49.238791
2252	2252	560000	2025-07-18 16:43:49.238791	2025-07-18 16:43:49.240807
2253	2253	35000	2025-07-18 16:43:49.241793	2025-07-18 16:43:49.243808
2254	2254	130000	2025-07-18 16:43:49.243808	2025-07-18 16:43:49.245771
2255	2255	180000	2025-07-18 16:43:49.245771	2025-07-18 16:43:49.2483
2256	2256	200000	2025-07-18 16:43:49.2483	2025-07-18 16:43:49.249332
2257	2257	950000	2025-07-18 16:43:49.250332	2025-07-18 16:43:49.251333
2258	2258	65000	2025-07-18 16:43:49.251333	2025-07-18 16:43:49.253332
2259	2259	1550000	2025-07-18 16:43:49.253332	2025-07-18 16:43:49.255346
2260	2260	1650000	2025-07-18 16:43:49.255346	2025-07-18 16:43:49.258331
2261	2261	450000	2025-07-18 16:43:49.258331	2025-07-18 16:43:49.26131
2262	2262	50000	2025-07-18 16:43:49.26131	2025-07-18 16:43:49.263346
2263	2263	90000	2025-07-18 16:43:49.263346	2025-07-18 16:43:49.266346
2264	2264	2000	2025-07-18 16:43:49.266346	2025-07-18 16:43:49.26931
2265	2265	6000	2025-07-18 16:43:49.26931	2025-07-18 16:43:49.272331
2266	2266	7000	2025-07-18 16:43:49.273322	2025-07-18 16:43:49.276379
2267	2267	2000	2025-07-18 16:43:49.276379	2025-07-18 16:43:49.279002
2268	2268	8000	2025-07-18 16:43:49.279002	2025-07-18 16:43:49.281051
2269	2269	2000	2025-07-18 16:43:49.281051	2025-07-18 16:43:49.283066
2270	2270	4000	2025-07-18 16:43:49.283066	2025-07-18 16:43:49.285065
2271	2271	50000	2025-07-18 16:43:49.285065	2025-07-18 16:43:49.287065
2272	2272	26000	2025-07-18 16:43:49.288065	2025-07-18 16:43:49.290662
2273	2273	30000	2025-07-18 16:43:49.290662	2025-07-18 16:43:49.293624
2274	2274	10000	2025-07-18 16:43:49.293624	2025-07-18 16:43:49.295646
2275	2275	7000	2025-07-18 16:43:49.295646	2025-07-18 16:43:49.296648
2276	2276	10000	2025-07-18 16:43:49.296648	2025-07-18 16:43:49.299226
2277	2277	35000	2025-07-18 16:43:49.299226	2025-07-18 16:43:49.303226
2278	2278	40000	2025-07-18 16:43:49.303226	2025-07-18 16:43:49.305197
2279	2279	45000	2025-07-18 16:43:49.306226	2025-07-18 16:43:49.308203
2280	2280	310000	2025-07-18 16:43:49.30921	2025-07-18 16:43:49.310212
2281	2281	8000	2025-07-18 16:43:49.310212	2025-07-18 16:43:49.313226
2282	2282	15000	2025-07-18 16:43:49.313226	2025-07-18 16:43:49.315212
2283	2283	60000	2025-07-18 16:43:49.315212	2025-07-18 16:43:49.316212
2284	2284	65000	2025-07-18 16:43:49.317226	2025-07-18 16:43:49.319212
2285	2285	50000	2025-07-18 16:43:49.319212	2025-07-18 16:43:49.320212
2286	2286	50000	2025-07-18 16:43:49.320212	2025-07-18 16:43:49.322226
2287	2287	55000	2025-07-18 16:43:49.323212	2025-07-18 16:43:49.326226
2288	2288	30000	2025-07-18 16:43:49.326226	2025-07-18 16:43:49.328212
2289	2289	90000	2025-07-18 16:43:49.328212	2025-07-18 16:43:49.329212
2290	2290	170000	2025-07-18 16:43:49.329212	2025-07-18 16:43:49.331212
2291	2291	45000	2025-07-18 16:43:49.331212	2025-07-18 16:43:49.333226
2292	2292	45000	2025-07-18 16:43:49.333226	2025-07-18 16:43:49.336258
2293	2293	25000	2025-07-18 16:43:49.337257	2025-07-18 16:43:49.339273
2294	2294	65000	2025-07-18 16:43:49.339273	2025-07-18 16:43:49.341273
2295	2295	7000	2025-07-18 16:43:49.342274	2025-07-18 16:43:49.344273
2296	2296	8000	2025-07-18 16:43:49.344273	2025-07-18 16:43:49.34726
2297	2297	65000	2025-07-18 16:43:49.34726	2025-07-18 16:43:49.349439
2298	2298	65000	2025-07-18 16:43:49.349439	2025-07-18 16:43:49.35144
2299	2299	60000	2025-07-18 16:43:49.35144	2025-07-18 16:43:49.353454
2300	2300	40000	2025-07-18 16:43:49.353454	2025-07-18 16:43:49.356285
2301	2301	6000	2025-07-18 16:43:49.356794	2025-07-18 16:43:49.359927
2302	2302	7000	2025-07-18 16:43:49.359927	2025-07-18 16:43:49.361949
2303	2303	6000	2025-07-18 16:43:49.361949	2025-07-18 16:43:49.363959
2304	2304	12000	2025-07-18 16:43:49.363959	2025-07-18 16:43:49.366996
2305	2305	15000	2025-07-18 16:43:49.366996	2025-07-18 16:43:49.369971
2306	2306	15000	2025-07-18 16:43:49.369971	2025-07-18 16:43:49.372996
2307	2307	15000	2025-07-18 16:43:49.372996	2025-07-18 16:43:49.375027
2308	2308	15000	2025-07-18 16:43:49.375027	2025-07-18 16:43:49.377027
2309	2309	20000	2025-07-18 16:43:49.378027	2025-07-18 16:43:49.380027
2310	2310	20000	2025-07-18 16:43:49.380027	2025-07-18 16:43:49.383082
2311	2311	50000	2025-07-18 16:43:49.383082	2025-07-18 16:43:49.385096
2312	2312	90000	2025-07-18 16:43:49.38606	2025-07-18 16:43:49.38808
2313	2313	230000	2025-07-18 16:43:49.38808	2025-07-18 16:43:49.392674
2314	2314	550000	2025-07-18 16:43:49.392674	2025-07-18 16:43:49.39466
2315	2315	800000	2025-07-18 16:43:49.39466	2025-07-18 16:43:49.39666
2316	2316	650000	2025-07-18 16:43:49.39666	2025-07-18 16:43:49.39866
2317	2317	420000	2025-07-18 16:43:49.39866	2025-07-18 16:43:49.400216
2318	2318	700000	2025-07-18 16:43:49.400216	2025-07-18 16:43:49.403216
2319	2319	560000	2025-07-18 16:43:49.403216	2025-07-18 16:43:49.405202
2320	2320	450000	2025-07-18 16:43:49.405202	2025-07-18 16:43:49.406202
2321	2321	480000	2025-07-18 16:43:49.407202	2025-07-18 16:43:49.409217
2322	2322	700000	2025-07-18 16:43:49.409217	2025-07-18 16:43:49.411216
2323	2323	350000	2025-07-18 16:43:49.411216	2025-07-18 16:43:49.414217
2324	2324	1600000	2025-07-18 16:43:49.414217	2025-07-18 16:43:49.417202
2325	2325	45000	2025-07-18 16:43:49.417202	2025-07-18 16:43:49.418202
2326	2326	30000	2025-07-18 16:43:49.419216	2025-07-18 16:43:49.421202
2327	2327	20000	2025-07-18 16:43:49.421202	2025-07-18 16:43:49.423216
2328	2328	50000	2025-07-18 16:43:49.423216	2025-07-18 16:43:49.426227
2329	2329	45000	2025-07-18 16:43:49.426227	2025-07-18 16:43:49.428202
2330	2330	28000	2025-07-18 16:43:49.428202	2025-07-18 16:43:49.430202
2331	2331	25000	2025-07-18 16:43:49.430202	2025-07-18 16:43:49.432202
2332	2332	25000	2025-07-18 16:43:49.432202	2025-07-18 16:43:49.434263
2333	2333	35000	2025-07-18 16:43:49.434263	2025-07-18 16:43:49.437249
2334	2334	25000	2025-07-18 16:43:49.437249	2025-07-18 16:43:49.439248
2335	2335	80000	2025-07-18 16:43:49.439248	2025-07-18 16:43:49.441263
2336	2336	25000	2025-07-18 16:43:49.44225	2025-07-18 16:43:49.444264
2337	2337	25000	2025-07-18 16:43:49.444264	2025-07-18 16:43:49.446269
2338	2338	25000	2025-07-18 16:43:49.446269	2025-07-18 16:43:49.448781
2339	2339	15000	2025-07-18 16:43:49.448781	2025-07-18 16:43:49.450813
2340	2340	50000	2025-07-18 16:43:49.450813	2025-07-18 16:43:49.451816
2341	2341	25000	2025-07-18 16:43:49.451816	2025-07-18 16:43:49.453829
2342	2342	110000	2025-07-18 16:43:49.454829	2025-07-18 16:43:49.456829
2343	2343	90000	2025-07-18 16:43:49.456829	2025-07-18 16:43:49.459814
2344	2344	110000	2025-07-18 16:43:49.459814	2025-07-18 16:43:49.461815
2345	2345	85000	2025-07-18 16:43:49.461815	2025-07-18 16:43:49.463829
2346	2346	85000	2025-07-18 16:43:49.463829	2025-07-18 16:43:49.466813
2347	2347	230000	2025-07-18 16:43:49.467822	2025-07-18 16:43:49.470829
2348	2348	30000	2025-07-18 16:43:49.470829	2025-07-18 16:43:49.472815
2349	2349	55000	2025-07-18 16:43:49.472815	2025-07-18 16:43:49.474829
2350	2350	110000	2025-07-18 16:43:49.474829	2025-07-18 16:43:49.476875
2351	2351	35000	2025-07-18 16:43:49.476875	2025-07-18 16:43:49.479876
2352	2352	240000	2025-07-18 16:43:49.479876	2025-07-18 16:43:49.481862
2353	2353	240000	2025-07-18 16:43:49.481862	2025-07-18 16:43:49.484406
2354	2354	195000	2025-07-18 16:43:49.484406	2025-07-18 16:43:49.485511
2355	2355	250000	2025-07-18 16:43:49.486568	2025-07-18 16:43:49.487555
2356	2356	320000	2025-07-18 16:43:49.487555	2025-07-18 16:43:49.488555
2357	2357	260000	2025-07-18 16:43:49.490085	2025-07-18 16:43:49.492133
2358	2358	185000	2025-07-18 16:43:49.492133	2025-07-18 16:43:49.494119
2359	2359	1450000	2025-07-18 16:43:49.494119	2025-07-18 16:43:49.496132
2360	2360	250000	2025-07-18 16:43:49.496132	2025-07-18 16:43:49.499132
2361	2361	30000	2025-07-18 16:43:49.499132	2025-07-18 16:43:49.500689
2362	2362	0	2025-07-18 16:43:49.501699	2025-07-18 16:43:49.504675
2363	2363	35000	2025-07-18 16:43:49.504675	2025-07-18 16:43:49.506675
2364	2364	20000	2025-07-18 16:43:49.506675	2025-07-18 16:43:49.508689
2365	2365	30000	2025-07-18 16:43:49.508689	2025-07-18 16:43:49.510689
2366	2366	45000	2025-07-18 16:43:49.510689	2025-07-18 16:43:49.513674
2367	2367	20000	2025-07-18 16:43:49.514673	2025-07-18 16:43:49.516689
2368	2368	25000	2025-07-18 16:43:49.516689	2025-07-18 16:43:49.518689
2369	2369	45000	2025-07-18 16:43:49.51969	2025-07-18 16:43:49.521689
2370	2370	35000	2025-07-18 16:43:49.521689	2025-07-18 16:43:49.52469
2371	2371	45000	2025-07-18 16:43:49.52469	2025-07-18 16:43:49.526675
2372	2372	95000	2025-07-18 16:43:49.526675	2025-07-18 16:43:49.528673
2373	2373	200000	2025-07-18 16:43:49.528673	2025-07-18 16:43:49.529675
2374	2374	95000	2025-07-18 16:43:49.529675	2025-07-18 16:43:49.531675
2375	2375	75000	2025-07-18 16:43:49.531675	2025-07-18 16:43:49.533689
2376	2376	115000	2025-07-18 16:43:49.533689	2025-07-18 16:43:49.536739
2377	2377	25000	2025-07-18 16:43:49.5377	2025-07-18 16:43:49.540227
2378	2378	17000	2025-07-18 16:43:49.540227	2025-07-18 16:43:49.542226
2379	2379	15000	2025-07-18 16:43:49.542226	2025-07-18 16:43:49.544225
2380	2380	45000	2025-07-18 16:43:49.544225	2025-07-18 16:43:49.545225
2381	2381	57000	2025-07-18 16:43:49.546227	2025-07-18 16:43:49.548226
2382	2382	69000	2025-07-18 16:43:49.548226	2025-07-18 16:43:49.550551
2383	2383	30000	2025-07-18 16:43:49.550551	2025-07-18 16:43:49.551551
2384	2384	80000	2025-07-18 16:43:49.551551	2025-07-18 16:43:49.554554
2385	2385	65000	2025-07-18 16:43:49.554554	2025-07-18 16:43:49.556049
2386	2386	150000	2025-07-18 16:43:49.556049	2025-07-18 16:43:49.558053
2387	2387	50000	2025-07-18 16:43:49.558053	2025-07-18 16:43:49.562094
2388	2388	80000	2025-07-18 16:43:49.562094	2025-07-18 16:43:49.564102
2389	2389	3500	2025-07-18 16:43:49.564102	2025-07-18 16:43:49.566093
2390	2390	220000	2025-07-18 16:43:49.566093	2025-07-18 16:43:49.569093
2391	2391	82000	2025-07-18 16:43:49.569093	2025-07-18 16:43:49.572088
2392	2392	200000	2025-07-18 16:43:49.572088	2025-07-18 16:43:49.573092
2393	2393	65000	2025-07-18 16:43:49.574091	2025-07-18 16:43:49.575091
2394	2394	30000	2025-07-18 16:43:49.575091	2025-07-18 16:43:49.577704
2395	2395	0	2025-07-18 16:43:49.577704	2025-07-18 16:43:49.579885
2396	2396	0	2025-07-18 16:43:49.581468	2025-07-18 16:43:49.5835
2397	2397	15000	2025-07-18 16:43:49.5835	2025-07-18 16:43:49.585447
2398	2398	30000	2025-07-18 16:43:49.586477	2025-07-18 16:43:49.588493
2399	2399	35000	2025-07-18 16:43:49.588493	2025-07-18 16:43:49.591048
2400	2400	65000	2025-07-18 16:43:49.592058	2025-07-18 16:43:49.594058
2401	2401	55000	2025-07-18 16:43:49.594058	2025-07-18 16:43:49.596072
2402	2402	4909	2025-07-18 16:43:49.596072	2025-07-18 16:43:49.598071
2403	2403	7953	2025-07-18 16:43:49.598071	2025-07-18 16:43:49.600627
2404	2404	11978	2025-07-18 16:43:49.600627	2025-07-18 16:43:49.604596
2405	2405	23662	2025-07-18 16:43:49.604596	2025-07-18 16:43:49.60759
2406	2406	45262	2025-07-18 16:43:49.60759	2025-07-18 16:43:49.609629
2407	2407	103582	2025-07-18 16:43:49.609629	2025-07-18 16:43:49.611614
2408	2408	4909	2025-07-18 16:43:49.611614	2025-07-18 16:43:49.614646
2409	2409	6971	2025-07-18 16:43:49.614646	2025-07-18 16:43:49.617612
2410	2410	6971	2025-07-18 16:43:49.618628	2025-07-18 16:43:49.619614
2411	2411	10800	2025-07-18 16:43:49.620614	2025-07-18 16:43:49.622628
2412	2412	10800	2025-07-18 16:43:49.622628	2025-07-18 16:43:49.62463
2413	2413	10800	2025-07-18 16:43:49.625628	2025-07-18 16:43:49.627628
2414	2414	19440	2025-07-18 16:43:49.627628	2025-07-18 16:43:49.629628
2415	2415	19440	2025-07-18 16:43:49.629628	2025-07-18 16:43:49.632629
2416	2416	19440	2025-07-18 16:43:49.632629	2025-07-18 16:43:49.634628
2417	2417	19440	2025-07-18 16:43:49.634628	2025-07-18 16:43:49.636675
2418	2418	37603	2025-07-18 16:43:49.637658	2025-07-18 16:43:49.639675
2419	2419	5989	2025-07-18 16:43:49.639675	2025-07-18 16:43:49.641674
2420	2420	7953	2025-07-18 16:43:49.641674	2025-07-18 16:43:49.643674
2421	2421	13942	2025-07-18 16:43:49.644676	2025-07-18 16:43:49.646644
2422	2422	22582	2025-07-18 16:43:49.646644	2025-07-18 16:43:49.649642
2423	2423	39665	2025-07-18 16:43:49.649642	2025-07-18 16:43:49.653781
2424	2424	121353	2025-07-18 16:43:49.653781	2025-07-18 16:43:49.655782
2425	2425	61069	2025-07-18 16:43:49.655782	2025-07-18 16:43:49.659766
2426	2426	69022	2025-07-18 16:43:49.660766	2025-07-18 16:43:49.662768
2427	2427	81589	2025-07-18 16:43:49.662768	2025-07-18 16:43:49.664782
2428	2428	43397	2025-07-18 16:43:49.664782	2025-07-18 16:43:49.666781
2429	2429	49287	2025-07-18 16:43:49.666781	2025-07-18 16:43:49.669757
2430	2430	67600	2025-07-18 16:43:49.669757	2025-07-18 16:43:49.672768
2431	2431	3142	2025-07-18 16:43:49.672768	2025-07-18 16:43:49.674784
2432	2432	5302	2025-07-18 16:43:49.674784	2025-07-18 16:43:49.676829
2433	2433	8247	2025-07-18 16:43:49.676829	2025-07-18 16:43:49.678829
2434	2434	13157	2025-07-18 16:43:49.678829	2025-07-18 16:43:49.681811
2435	2435	23563	2025-07-18 16:43:49.681811	2025-07-18 16:43:49.683829
2436	2436	47225	2025-07-18 16:43:49.683829	2025-07-18 16:43:49.685829
2437	2437	49287	2025-07-18 16:43:49.685829	2025-07-18 16:43:49.687859
2438	2438	56945	2025-07-18 16:43:49.687859	2025-07-18 16:43:49.691483
2439	2439	68727	2025-07-18 16:43:49.691483	2025-07-18 16:43:49.693468
2440	2440	101618	2025-07-18 16:43:49.693468	2025-07-18 16:43:49.695482
2441	2441	295527	2025-07-18 16:43:49.696468	2025-07-18 16:43:49.698482
2442	2442	369360	2025-07-18 16:43:49.698482	2025-07-18 16:43:49.700027
2443	2443	626000	2025-07-18 16:43:49.700027	2025-07-18 16:43:49.704041
2444	2444	38978	2025-07-18 16:43:49.704041	2025-07-18 16:43:49.707039
2445	2445	47717	2025-07-18 16:43:49.707039	2025-07-18 16:43:49.709066
2446	2446	53125	2025-07-18 16:43:49.710062	2025-07-18 16:43:49.712064
2447	2447	86793	2025-07-18 16:43:49.712064	2025-07-18 16:43:49.71447
2448	2448	215018	2025-07-18 16:43:49.715519	2025-07-18 16:43:49.718494
2449	2449	285218	2025-07-18 16:43:49.719529	2025-07-18 16:43:49.721528
2450	2450	3000	2025-07-18 16:43:49.721528	2025-07-18 16:43:49.723542
2451	2451	5200	2025-07-18 16:43:49.723542	2025-07-18 16:43:49.726547
2452	2452	6800	2025-07-18 16:43:49.727543	2025-07-18 16:43:49.730542
2453	2453	10300	2025-07-18 16:43:49.730542	2025-07-18 16:43:49.733543
2454	2454	19400	2025-07-18 16:43:49.733543	2025-07-18 16:43:49.73659
2455	2455	15700	2025-07-18 16:43:49.73759	2025-07-18 16:43:49.738591
2456	2456	29300	2025-07-18 16:43:49.739576	2025-07-18 16:43:49.74159
2457	2457	23957	2025-07-18 16:43:49.74159	2025-07-18 16:43:49.74359
2458	2458	42807	2025-07-18 16:43:49.74359	2025-07-18 16:43:49.74659
2459	2459	55473	2025-07-18 16:43:49.74659	2025-07-18 16:43:49.748594
2460	2460	74422	2025-07-18 16:43:49.748594	2025-07-18 16:43:49.751107
2461	2461	109080	2025-07-18 16:43:49.751107	2025-07-18 16:43:49.753277
2462	2462	173389	2025-07-18 16:43:49.753277	2025-07-18 16:43:49.755275
2463	2463	29651	2025-07-18 16:43:49.756276	2025-07-18 16:43:49.758275
2464	2464	52037	2025-07-18 16:43:49.758275	2025-07-18 16:43:49.760863
2465	2465	76582	2025-07-18 16:43:49.761897	2025-07-18 16:43:49.764911
2466	2466	118505	2025-07-18 16:43:49.764911	2025-07-18 16:43:49.766897
2467	2467	184189	2025-07-18 16:43:49.766897	2025-07-18 16:43:49.769897
2468	2468	38978	2025-07-18 16:43:49.769897	2025-07-18 16:43:49.771874
2469	2469	57437	2025-07-18 16:43:49.772895	2025-07-18 16:43:49.774911
2470	2470	82669	2025-07-18 16:43:49.774911	2025-07-18 16:43:49.776957
2471	2471	94942	2025-07-18 16:43:49.777959	2025-07-18 16:43:49.779958
2472	2472	142658	2025-07-18 16:43:49.780944	2025-07-18 16:43:49.783942
2473	2473	99065	2025-07-18 16:43:49.783942	2025-07-18 16:43:49.785943
2474	2474	154440	2025-07-18 16:43:49.785943	2025-07-18 16:43:49.787957
2475	2475	242705	2025-07-18 16:43:49.787957	2025-07-18 16:43:49.790457
2476	2476	360131	2025-07-18 16:43:49.790457	2025-07-18 16:43:49.79448
2477	2477	635629	2025-07-18 16:43:49.79448	2025-07-18 16:43:49.796394
2478	2478	859778	2025-07-18 16:43:49.79748	2025-07-18 16:43:49.798519
2479	2479	92880	2025-07-18 16:43:49.798519	2025-07-18 16:43:49.800543
2480	2480	148745	2025-07-18 16:43:49.801057	2025-07-18 16:43:49.802583
2481	2481	218062	2025-07-18 16:43:49.803697	2025-07-18 16:43:49.804713
2482	2482	341673	2025-07-18 16:43:49.804713	2025-07-18 16:43:49.806853
2483	2483	595080	2025-07-18 16:43:49.806853	2025-07-18 16:43:49.808855
2484	2484	6971	2025-07-18 16:43:49.808855	2025-07-18 16:43:49.810868
2485	2485	10800	2025-07-18 16:43:49.810868	2025-07-18 16:43:49.813871
2486	2486	17771	2025-07-18 16:43:49.813871	2025-07-18 16:43:49.815868
2487	2487	27687	2025-07-18 16:43:49.816854	2025-07-18 16:43:49.817854
2488	2488	54393	2025-07-18 16:43:49.817854	2025-07-18 16:43:49.820869
2489	2489	136473	2025-07-18 16:43:49.820869	2025-07-18 16:43:49.822868
2490	2490	129011	2025-07-18 16:43:49.822868	2025-07-18 16:43:49.824868
2491	2491	129011	2025-07-18 16:43:49.825868	2025-07-18 16:43:49.827854
2492	2492	43789	2025-07-18 16:43:49.827854	2025-07-18 16:43:49.829868
2493	2493	46833	2025-07-18 16:43:49.829868	2025-07-18 16:43:49.831868
2494	2494	68237	2025-07-18 16:43:49.832869	2025-07-18 16:43:49.834868
2495	2495	10800	2025-07-18 16:43:49.834868	2025-07-18 16:43:49.8379
2496	2496	19047	2025-07-18 16:43:49.8379	2025-07-18 16:43:49.839886
2497	2497	19047	2025-07-18 16:43:49.839886	2025-07-18 16:43:49.8419
2498	2498	41825	2025-07-18 16:43:49.8419	2025-07-18 16:43:49.844885
2499	2499	41825	2025-07-18 16:43:49.845884	2025-07-18 16:43:49.8489
2500	2500	41825	2025-07-18 16:43:49.8489	2025-07-18 16:43:49.8499
2501	2501	73440	2025-07-18 16:43:49.8499	2025-07-18 16:43:49.852479
2502	2502	73440	2025-07-18 16:43:49.85348	2025-07-18 16:43:49.855479
2503	2503	73440	2025-07-18 16:43:49.855479	2025-07-18 16:43:49.857446
2504	2504	73440	2025-07-18 16:43:49.85845	2025-07-18 16:43:49.860463
2505	2505	1364629	2025-07-18 16:43:49.860463	2025-07-18 16:43:49.862479
2506	2506	205200	2025-07-18 16:43:49.862479	2025-07-18 16:43:49.86548
2507	2507	236029	2025-07-18 16:43:49.86548	2025-07-18 16:43:49.867479
2508	2508	338629	2025-07-18 16:43:49.867479	2025-07-18 16:43:49.870463
2509	2509	569945	2025-07-18 16:43:49.870463	2025-07-18 16:43:49.872463
2510	2510	888840	2025-07-18 16:43:49.872463	2025-07-18 16:43:49.875698
2511	2511	26730	2025-07-18 16:43:49.875698	2025-07-18 16:43:49.878756
2512	2512	29810	2025-07-18 16:43:49.879756	2025-07-18 16:43:49.881722
2513	2513	31020	2025-07-18 16:43:49.88274	2025-07-18 16:43:49.88474
2514	2514	33110	2025-07-18 16:43:49.88474	2025-07-18 16:43:49.886756
2515	2515	34980	2025-07-18 16:43:49.886756	2025-07-18 16:43:49.888756
2516	2516	9790	2025-07-18 16:43:49.888756	2025-07-18 16:43:49.892295
2517	2517	9790	2025-07-18 16:43:49.892295	2025-07-18 16:43:49.895689
2518	2518	9790	2025-07-18 16:43:49.895689	2025-07-18 16:43:49.89769
2519	2519	9790	2025-07-18 16:43:49.89769	2025-07-18 16:43:49.899705
2520	2520	14960	2025-07-18 16:43:49.899705	2025-07-18 16:43:49.902224
2521	2521	14960	2025-07-18 16:43:49.902224	2025-07-18 16:43:49.904257
2522	2522	15840	2025-07-18 16:43:49.905268	2025-07-18 16:43:49.907589
2523	2523	17050	2025-07-18 16:43:49.907589	2025-07-18 16:43:49.909657
2524	2524	15180	2025-07-18 16:43:49.909657	2025-07-18 16:43:49.911657
2525	2525	7000	2025-07-18 16:43:49.911657	2025-07-18 16:43:49.915657
2526	2526	15000	2025-07-18 16:43:49.915657	2025-07-18 16:43:49.917657
2527	2527	25000	2025-07-18 16:43:49.917657	2025-07-18 16:43:49.920657
2528	2528	2000	2025-07-18 16:43:49.920657	2025-07-18 16:43:49.923641
2529	2529	2500	2025-07-18 16:43:49.923641	2025-07-18 16:43:49.927621
2530	2530	3000	2025-07-18 16:43:49.927621	2025-07-18 16:43:49.929398
2531	2531	3500	2025-07-18 16:43:49.930389	2025-07-18 16:43:49.932389
2532	2532	4000	2025-07-18 16:43:49.932389	2025-07-18 16:43:49.933389
2533	2533	4500	2025-07-18 16:43:49.933389	2025-07-18 16:43:49.935389
2534	2534	5000	2025-07-18 16:43:49.936412	2025-07-18 16:43:49.93842
2535	2535	6000	2025-07-18 16:43:49.939421	2025-07-18 16:43:49.940945
2536	2536	46000	2025-07-18 16:43:49.940945	2025-07-18 16:43:49.942944
2537	2537	32780	2025-07-18 16:43:49.942944	2025-07-18 16:43:49.944946
2538	2538	11660	2025-07-18 16:43:49.944946	2025-07-18 16:43:49.947945
2539	2539	16940	2025-07-18 16:43:49.947945	2025-07-18 16:43:49.951218
2540	2540	24640	2025-07-18 16:43:49.951218	2025-07-18 16:43:49.953731
2541	2541	37800	2025-07-18 16:43:49.95473	2025-07-18 16:43:49.956731
2542	2542	66744	2025-07-18 16:43:49.956731	2025-07-18 16:43:49.957731
2543	2543	83000	2025-07-18 16:43:49.957731	2025-07-18 16:43:49.959731
2544	2544	2000	2025-07-18 16:43:49.959731	2025-07-18 16:43:49.96161
2545	2545	2000	2025-07-18 16:43:49.96161	2025-07-18 16:43:49.963586
2546	2546	2860	2025-07-18 16:43:49.963586	2025-07-18 16:43:49.965585
2547	2547	4290	2025-07-18 16:43:49.965585	2025-07-18 16:43:49.967585
2548	2548	6820	2025-07-18 16:43:49.967585	2025-07-18 16:43:49.970583
2549	2549	10908	2025-07-18 16:43:49.970583	2025-07-18 16:43:49.972607
2550	2550	18900	2025-07-18 16:43:49.973607	2025-07-18 16:43:49.975645
2551	2551	24732	2025-07-18 16:43:49.975645	2025-07-18 16:43:49.977657
2552	2552	21708	2025-07-18 16:43:49.977657	2025-07-18 16:43:49.980635
2553	2553	20844	2025-07-18 16:43:49.980635	2025-07-18 16:43:49.983622
2554	2554	20844	2025-07-18 16:43:49.984642	2025-07-18 16:43:49.986657
2555	2555	21708	2025-07-18 16:43:49.987658	2025-07-18 16:43:49.989657
2556	2556	22032	2025-07-18 16:43:49.989657	2025-07-18 16:43:49.992899
2557	2557	22572	2025-07-18 16:43:49.992899	2025-07-18 16:43:49.994899
2558	2558	2000	2025-07-18 16:43:49.994899	2025-07-18 16:43:49.996912
2559	2559	2000	2025-07-18 16:43:49.996912	2025-07-18 16:43:49.999913
2560	2560	2420	2025-07-18 16:43:49.999913	2025-07-18 16:43:50.000881
2561	2561	2860	2025-07-18 16:43:50.002387	2025-07-18 16:43:50.004405
2562	2562	2970	2025-07-18 16:43:50.005419	2025-07-18 16:43:50.007434
2563	2563	3190	2025-07-18 16:43:50.007434	2025-07-18 16:43:50.010433
2564	2564	5000	2025-07-18 16:43:50.010433	2025-07-18 16:43:50.012433
2565	2565	5000	2025-07-18 16:43:50.012433	2025-07-18 16:43:50.015415
2566	2566	5000	2025-07-18 16:43:50.015415	2025-07-18 16:43:50.017265
2567	2567	5000	2025-07-18 16:43:50.017265	2025-07-18 16:43:50.019357
2568	2568	5280	2025-07-18 16:43:50.019357	2025-07-18 16:43:50.021447
2569	2569	6380	2025-07-18 16:43:50.022498	2025-07-18 16:43:50.025039
2570	2570	6380	2025-07-18 16:43:50.025039	2025-07-18 16:43:50.027106
2571	2571	6380	2025-07-18 16:43:50.027106	2025-07-18 16:43:50.029117
2572	2572	6820	2025-07-18 16:43:50.029117	2025-07-18 16:43:50.030117
2573	2573	10000	2025-07-18 16:43:50.031131	2025-07-18 16:43:50.032131
2574	2574	10120	2025-07-18 16:43:50.033117	2025-07-18 16:43:50.034116
2575	2575	10120	2025-07-18 16:43:50.034116	2025-07-18 16:43:50.037132
2576	2576	10120	2025-07-18 16:43:50.037132	2025-07-18 16:43:50.038164
2577	2577	10670	2025-07-18 16:43:50.039164	2025-07-18 16:43:50.040164
2578	2578	12760	2025-07-18 16:43:50.040164	2025-07-18 16:43:50.042178
2579	2579	13970	2025-07-18 16:43:50.042178	2025-07-18 16:43:50.044179
2580	2580	13970	2025-07-18 16:43:50.045178	2025-07-18 16:43:50.048143
2581	2581	14410	2025-07-18 16:43:50.048143	2025-07-18 16:43:50.051163
2582	2582	15730	2025-07-18 16:43:50.051163	2025-07-18 16:43:50.053743
2583	2583	48060	2025-07-18 16:43:50.053743	2025-07-18 16:43:50.055757
2584	2584	148000	2025-07-18 16:43:50.055757	2025-07-18 16:43:50.058722
2585	2585	301752	2025-07-18 16:43:50.058722	2025-07-18 16:43:50.060757
2586	2586	2000	2025-07-18 16:43:50.061743	2025-07-18 16:43:50.062743
2587	2587	2500	2025-07-18 16:43:50.062743	2025-07-18 16:43:50.064743
2588	2588	3410	2025-07-18 16:43:50.064743	2025-07-18 16:43:50.066743
2589	2589	5610	2025-07-18 16:43:50.066743	2025-07-18 16:43:50.068726
2590	2590	8800	2025-07-18 16:43:50.068726	2025-07-18 16:43:50.071727
2591	2591	12744	2025-07-18 16:43:50.071727	2025-07-18 16:43:50.073741
2592	2592	23000	2025-07-18 16:43:50.073741	2025-07-18 16:43:50.075757
2593	2593	30024	2025-07-18 16:43:50.075757	2025-07-18 16:43:50.077804
2594	2594	152240	2025-07-18 16:43:50.078803	2025-07-18 16:43:50.081771
2595	2595	5000	2025-07-18 16:43:50.081771	2025-07-18 16:43:50.084788
2596	2596	5900	2025-07-18 16:43:50.084788	2025-07-18 16:43:50.08679
2597	2597	84200	2025-07-18 16:43:50.08679	2025-07-18 16:43:50.088803
2598	2598	9000	2025-07-18 16:43:50.088803	2025-07-18 16:43:50.092362
2599	2599	17500	2025-07-18 16:43:50.092362	2025-07-18 16:43:50.094347
2600	2600	40000	2025-07-18 16:43:50.094347	2025-07-18 16:43:50.096345
2601	2601	2000	2025-07-18 16:43:50.096345	2025-07-18 16:43:50.098324
2602	2602	2000	2025-07-18 16:43:50.099345	2025-07-18 16:43:50.101361
2603	2603	2500	2025-07-18 16:43:50.101361	2025-07-18 16:43:50.103957
2604	2604	4000	2025-07-18 16:43:50.104957	2025-07-18 16:43:50.106943
2605	2605	5000	2025-07-18 16:43:50.106943	2025-07-18 16:43:50.107943
2606	2606	8000	2025-07-18 16:43:50.108943	2025-07-18 16:43:50.109943
2607	2607	10000	2025-07-18 16:43:50.109943	2025-07-18 16:43:50.112241
2608	2608	14000	2025-07-18 16:43:50.112241	2025-07-18 16:43:50.115242
2609	2609	7000	2025-07-18 16:43:50.115242	2025-07-18 16:43:50.117227
2610	2610	126000	2025-07-18 16:43:50.117227	2025-07-18 16:43:50.119241
2611	2611	65000	2025-07-18 16:43:50.120227	2025-07-18 16:43:50.122242
2612	2612	90000	2025-07-18 16:43:50.122242	2025-07-18 16:43:50.124241
2613	2613	72576	2025-07-18 16:43:50.124241	2025-07-18 16:43:50.127217
2614	2614	148284	2025-07-18 16:43:50.127217	2025-07-18 16:43:50.129227
2615	2615	8470	2025-07-18 16:43:50.129227	2025-07-18 16:43:50.131241
2616	2616	10780	2025-07-18 16:43:50.131241	2025-07-18 16:43:50.133242
2617	2617	12744	2025-07-18 16:43:50.134242	2025-07-18 16:43:50.136242
2618	2618	18590	2025-07-18 16:43:50.137227	2025-07-18 16:43:50.140239
2619	2619	22356	2025-07-18 16:43:50.140239	2025-07-18 16:43:50.143253
2620	2620	29700	2025-07-18 16:43:50.143253	2025-07-18 16:43:50.146253
2621	2621	41360	2025-07-18 16:43:50.146253	2025-07-18 16:43:50.149229
2622	2622	49390	2025-07-18 16:43:50.149229	2025-07-18 16:43:50.151237
2623	2623	84564	2025-07-18 16:43:50.151237	2025-07-18 16:43:50.153764
2624	2624	105000	2025-07-18 16:43:50.153764	2025-07-18 16:43:50.15581
2625	2625	130680	2025-07-18 16:43:50.15581	2025-07-18 16:43:50.158778
2626	2626	172800	2025-07-18 16:43:50.158778	2025-07-18 16:43:50.161795
2627	2627	9072	2025-07-18 16:43:50.161795	2025-07-18 16:43:50.162786
2628	2628	12420	2025-07-18 16:43:50.164829	2025-07-18 16:43:50.166811
2629	2629	15950	2025-07-18 16:43:50.166811	2025-07-18 16:43:50.16881
2630	2630	21492	2025-07-18 16:43:50.16881	2025-07-18 16:43:50.171773
2631	2631	26070	2025-07-18 16:43:50.171773	2025-07-18 16:43:50.174811
2632	2632	36180	2025-07-18 16:43:50.174811	2025-07-18 16:43:50.176842
2633	2633	46008	2025-07-18 16:43:50.176842	2025-07-18 16:43:50.178841
2634	2634	56808	2025-07-18 16:43:50.178841	2025-07-18 16:43:50.182828
2635	2635	96228	2025-07-18 16:43:50.182828	2025-07-18 16:43:50.183827
2636	2636	312984	2025-07-18 16:43:50.184841	2025-07-18 16:43:50.186828
2637	2637	10908	2025-07-18 16:43:50.186828	2025-07-18 16:43:50.187828
2638	2638	13824	2025-07-18 16:43:50.188828	2025-07-18 16:43:50.189825
2639	2639	19116	2025-07-18 16:43:50.189825	2025-07-18 16:43:50.192098
2640	2640	24408	2025-07-18 16:43:50.192098	2025-07-18 16:43:50.195113
2641	2641	29484	2025-07-18 16:43:50.195113	2025-07-18 16:43:50.197115
2642	2642	42120	2025-07-18 16:43:50.197115	2025-07-18 16:43:50.199113
2643	2643	60000	2025-07-18 16:43:50.199113	2025-07-18 16:43:50.201112
2644	2644	65664	2025-07-18 16:43:50.201112	2025-07-18 16:43:50.203658
2645	2645	134784	2025-07-18 16:43:50.203658	2025-07-18 16:43:50.205695
2646	2646	12800	2025-07-18 16:43:50.205695	2025-07-18 16:43:50.207708
2647	2647	35640	2025-07-18 16:43:50.207708	2025-07-18 16:43:50.210675
2648	2648	50976	2025-07-18 16:43:50.210675	2025-07-18 16:43:50.212693
2649	2649	74304	2025-07-18 16:43:50.212693	2025-07-18 16:43:50.214671
2650	2650	86076	2025-07-18 16:43:50.214671	2025-07-18 16:43:50.216694
2651	2651	80520	2025-07-18 16:43:50.217694	2025-07-18 16:43:50.219709
2652	2652	99880	2025-07-18 16:43:50.219709	2025-07-18 16:43:50.221709
2653	2653	65340	2025-07-18 16:43:50.221709	2025-07-18 16:43:50.223708
2654	2654	6930	2025-07-18 16:43:50.223708	2025-07-18 16:43:50.22669
2655	2655	8580	2025-07-18 16:43:50.22669	2025-07-18 16:43:50.228695
2656	2656	11110	2025-07-18 16:43:50.228695	2025-07-18 16:43:50.230708
2657	2657	16610	2025-07-18 16:43:50.230708	2025-07-18 16:43:50.232709
2658	2658	19470	2025-07-18 16:43:50.233709	2025-07-18 16:43:50.236567
2659	2659	25300	2025-07-18 16:43:50.236567	2025-07-18 16:43:50.237573
2660	2660	35420	2025-07-18 16:43:50.237573	2025-07-18 16:43:50.240055
2661	2661	43230	2025-07-18 16:43:50.241063	2025-07-18 16:43:50.243108
2662	2662	59832	2025-07-18 16:43:50.243108	2025-07-18 16:43:50.24412
2663	2663	2000	2025-07-18 16:43:50.24412	2025-07-18 16:43:50.246149
2664	2664	2000	2025-07-18 16:43:50.247153	2025-07-18 16:43:50.250129
2665	2665	4180	2025-07-18 16:43:50.250129	2025-07-18 16:43:50.252371
2666	2666	5940	2025-07-18 16:43:50.252371	2025-07-18 16:43:50.25486
2667	2667	9460	2025-07-18 16:43:50.25486	2025-07-18 16:43:50.25587
2668	2668	10476	2025-07-18 16:43:50.25687	2025-07-18 16:43:50.258873
2669	2669	23652	2025-07-18 16:43:50.258873	2025-07-18 16:43:50.260886
2670	2670	61020	2025-07-18 16:43:50.260886	2025-07-18 16:43:50.262869
2671	2671	1500	2025-07-18 16:43:50.262869	2025-07-18 16:43:50.263869
2672	2672	1650	2025-07-18 16:43:50.263869	2025-07-18 16:43:50.265869
2673	2673	2970	2025-07-18 16:43:50.265869	2025-07-18 16:43:50.268994
2674	2674	4180	2025-07-18 16:43:50.269989	2025-07-18 16:43:50.272966
2675	2675	5940	2025-07-18 16:43:50.272966	2025-07-18 16:43:50.276571
2676	2676	8360	2025-07-18 16:43:50.276571	2025-07-18 16:43:50.277574
2677	2677	16632	2025-07-18 16:43:50.277574	2025-07-18 16:43:50.28057
2678	2678	26460	2025-07-18 16:43:50.28057	2025-07-18 16:43:50.283577
2679	2679	157410	2025-07-18 16:43:50.283577	2025-07-18 16:43:50.286572
2680	2680	28820	2025-07-18 16:43:50.286572	2025-07-18 16:43:50.288571
2681	2681	39380	2025-07-18 16:43:50.288571	2025-07-18 16:43:50.289568
2682	2682	63910	2025-07-18 16:43:50.289568	2025-07-18 16:43:50.292079
2683	2683	111540	2025-07-18 16:43:50.292079	2025-07-18 16:43:50.294275
2684	2684	141790	2025-07-18 16:43:50.294275	2025-07-18 16:43:50.296277
2685	2685	67932	2025-07-18 16:43:50.297279	2025-07-18 16:43:50.300775
2686	2686	114000	2025-07-18 16:43:50.300775	2025-07-18 16:43:50.305324
2687	2687	2310	2025-07-18 16:43:50.305324	2025-07-18 16:43:50.307346
2688	2688	3850	2025-07-18 16:43:50.307346	2025-07-18 16:43:50.310361
2689	2689	5170	2025-07-18 16:43:50.310361	2025-07-18 16:43:50.312361
2690	2690	7370	2025-07-18 16:43:50.312361	2025-07-18 16:43:50.316345
2691	2691	11000	2025-07-18 16:43:50.316345	2025-07-18 16:43:50.318361
2692	2692	17064	2025-07-18 16:43:50.318361	2025-07-18 16:43:50.321361
2693	2693	29052	2025-07-18 16:43:50.321361	2025-07-18 16:43:50.323361
2694	2694	40068	2025-07-18 16:43:50.323361	2025-07-18 16:43:50.326362
2695	2695	77436	2025-07-18 16:43:50.326362	2025-07-18 16:43:50.329361
2696	2696	20127	2025-07-18 16:43:50.329361	2025-07-18 16:43:50.331347
2697	2697	46440	2025-07-18 16:43:50.331347	2025-07-18 16:43:50.332347
2698	2698	39600	2025-07-18 16:43:50.333361	2025-07-18 16:43:50.335361
2699	2699	40040	2025-07-18 16:43:50.335361	2025-07-18 16:43:50.337346
2700	2700	42020	2025-07-18 16:43:50.33833	2025-07-18 16:43:50.339345
2701	2701	46530	2025-07-18 16:43:50.340376	2025-07-18 16:43:50.34239
2702	2702	49170	2025-07-18 16:43:50.34239	2025-07-18 16:43:50.345391
2703	2703	57780	2025-07-18 16:43:50.345391	2025-07-18 16:43:50.348374
2704	2704	2970	2025-07-18 16:43:50.348374	2025-07-18 16:43:50.349366
2705	2705	3850	2025-07-18 16:43:50.35039	2025-07-18 16:43:50.35239
2706	2706	4180	2025-07-18 16:43:50.35239	2025-07-18 16:43:50.35492
2707	2707	5060	2025-07-18 16:43:50.35492	2025-07-18 16:43:50.356971
2708	2708	5610	2025-07-18 16:43:50.356971	2025-07-18 16:43:50.360956
2709	2709	6820	2025-07-18 16:43:50.360956	2025-07-18 16:43:50.36271
2710	2710	8250	2025-07-18 16:43:50.363955	2025-07-18 16:43:50.365376
2711	2711	8360	2025-07-18 16:43:50.365376	2025-07-18 16:43:50.367445
2712	2712	8800	2025-07-18 16:43:50.367445	2025-07-18 16:43:50.371804
2713	2713	11124	2025-07-18 16:43:50.371804	2025-07-18 16:43:50.374837
2714	2714	10230	2025-07-18 16:43:50.374837	2025-07-18 16:43:50.375839
2715	2715	11550	2025-07-18 16:43:50.376884	2025-07-18 16:43:50.378847
2716	2716	12650	2025-07-18 16:43:50.378847	2025-07-18 16:43:50.381869
2717	2717	13716	2025-07-18 16:43:50.382881	2025-07-18 16:43:50.384868
2718	2718	14630	2025-07-18 16:43:50.384868	2025-07-18 16:43:50.385868
2719	2719	18500	2025-07-18 16:43:50.385868	2025-07-18 16:43:50.38787
2720	2720	19000	2025-07-18 16:43:50.38787	2025-07-18 16:43:50.38887
2721	2721	20196	2025-07-18 16:43:50.38887	2025-07-18 16:43:50.391441
2722	2722	23320	2025-07-18 16:43:50.392454	2025-07-18 16:43:50.394475
2723	2723	26070	2025-07-18 16:43:50.394475	2025-07-18 16:43:50.396491
2724	2724	18500	2025-07-18 16:43:50.396491	2025-07-18 16:43:50.399492
2725	2725	31790	2025-07-18 16:43:50.399492	2025-07-18 16:43:50.401491
2726	2726	25380	2025-07-18 16:43:50.401491	2025-07-18 16:43:50.403491
2727	2727	31460	2025-07-18 16:43:50.405022	2025-07-18 16:43:50.407055
2728	2728	38280	2025-07-18 16:43:50.407055	2025-07-18 16:43:50.408057
2729	2729	40040	2025-07-18 16:43:50.409057	2025-07-18 16:43:50.411057
2730	2730	104000	2025-07-18 16:43:50.411057	2025-07-18 16:43:50.412055
2731	2731	60000	2025-07-18 16:43:50.412055	2025-07-18 16:43:50.415038
2732	2732	74844	2025-07-18 16:43:50.415038	2025-07-18 16:43:50.417033
2733	2733	150000	2025-07-18 16:43:50.417033	2025-07-18 16:43:50.419055
2734	2734	240000	2025-07-18 16:43:50.420056	2025-07-18 16:43:50.422071
2735	2735	5940	2025-07-18 16:43:50.422071	2025-07-18 16:43:50.424071
2736	2736	6160	2025-07-18 16:43:50.424071	2025-07-18 16:43:50.42851
2737	2737	8250	2025-07-18 16:43:50.428832	2025-07-18 16:43:50.430856
2738	2738	15950	2025-07-18 16:43:50.431898	2025-07-18 16:43:50.433885
2739	2739	21060	2025-07-18 16:43:50.433885	2025-07-18 16:43:50.435898
2740	2740	40500	2025-07-18 16:43:50.435898	2025-07-18 16:43:50.437897
2741	2741	49572	2025-07-18 16:43:50.437897	2025-07-18 16:43:50.439897
2742	2742	75000	2025-07-18 16:43:50.439897	2025-07-18 16:43:50.441941
2743	2743	0	2025-07-18 16:43:50.442928	2025-07-18 16:43:50.444942
2744	2744	72160	2025-07-18 16:43:50.444942	2025-07-18 16:43:50.446942
2745	2745	50000	2025-07-18 16:43:50.446942	2025-07-18 16:43:50.449904
2746	2746	1350000	2025-07-18 16:43:50.449904	2025-07-18 16:43:50.451926
2747	2747	61000	2025-07-18 16:43:50.451926	2025-07-18 16:43:50.453942
2748	2748	61000	2025-07-18 16:43:50.453942	2025-07-18 16:43:50.456317
2749	2749	5100	2025-07-18 16:43:50.457367	2025-07-18 16:43:50.460367
2750	2750	5100	2025-07-18 16:43:50.460367	2025-07-18 16:43:50.462367
2751	2751	7530	2025-07-18 16:43:50.462367	2025-07-18 16:43:50.464368
2752	2752	7530	2025-07-18 16:43:50.465368	2025-07-18 16:43:50.467367
2753	2753	7530	2025-07-18 16:43:50.467367	2025-07-18 16:43:50.469345
2754	2754	7530	2025-07-18 16:43:50.469345	2025-07-18 16:43:50.471352
2755	2755	49500	2025-07-18 16:43:50.471352	2025-07-18 16:43:50.474007
2756	2756	49500	2025-07-18 16:43:50.474007	2025-07-18 16:43:50.475996
2757	2757	12240	2025-07-18 16:43:50.475996	2025-07-18 16:43:50.478002
2758	2758	12240	2025-07-18 16:43:50.478002	2025-07-18 16:43:50.479003
2759	2759	12240	2025-07-18 16:43:50.480002	2025-07-18 16:43:50.482005
2760	2760	12240	2025-07-18 16:43:50.482005	2025-07-18 16:43:50.484784
2761	2761	18800	2025-07-18 16:43:50.484784	2025-07-18 16:43:50.486783
2762	2762	18800	2025-07-18 16:43:50.486783	2025-07-18 16:43:50.488783
2763	2763	18800	2025-07-18 16:43:50.488783	2025-07-18 16:43:50.491313
2764	2764	18800	2025-07-18 16:43:50.491313	2025-07-18 16:43:50.493859
2765	2765	27940	2025-07-18 16:43:50.494871	2025-07-18 16:43:50.49689
2766	2766	27940	2025-07-18 16:43:50.497902	2025-07-18 16:43:50.499906
2767	2767	27940	2025-07-18 16:43:50.499906	2025-07-18 16:43:50.501906
2768	2768	9130	2025-07-18 16:43:50.501906	2025-07-18 16:43:50.504887
2769	2769	11700	2025-07-18 16:43:50.505876	2025-07-18 16:43:50.507985
2770	2770	16060	2025-07-18 16:43:50.508978	2025-07-18 16:43:50.510986
2771	2771	26400	2025-07-18 16:43:50.510986	2025-07-18 16:43:50.512985
2772	2772	39700	2025-07-18 16:43:50.512985	2025-07-18 16:43:50.515992
2773	2773	58740	2025-07-18 16:43:50.515992	2025-07-18 16:43:50.517971
2774	2774	1300000	2025-07-18 16:43:50.517971	2025-07-18 16:43:50.519985
2775	2775	0	2025-07-18 16:43:50.519985	2025-07-18 16:43:50.521969
2776	2776	12000	2025-07-18 16:43:50.521969	2025-07-18 16:43:50.524953
2777	2777	15000	2025-07-18 16:43:50.524953	2025-07-18 16:43:50.52797
2778	2778	25000	2025-07-18 16:43:50.52797	2025-07-18 16:43:50.529985
2779	2779	35000	2025-07-18 16:43:50.529985	2025-07-18 16:43:50.530971
2780	2780	0	2025-07-18 16:43:50.531971	2025-07-18 16:43:50.532971
2781	2781	65000	2025-07-18 16:43:50.532971	2025-07-18 16:43:50.534971
2782	2782	70000	2025-07-18 16:43:50.534971	2025-07-18 16:43:50.537969
2783	2783	100000	2025-07-18 16:43:50.537969	2025-07-18 16:43:50.541985
2784	2784	150000	2025-07-18 16:43:50.541985	2025-07-18 16:43:50.544032
2785	2785	150000	2025-07-18 16:43:50.544032	2025-07-18 16:43:50.546032
2786	2786	25000	2025-07-18 16:43:50.547033	2025-07-18 16:43:50.550016
2787	2787	350000	2025-07-18 16:43:50.550016	2025-07-18 16:43:50.551018
2788	2788	247000	2025-07-18 16:43:50.552033	2025-07-18 16:43:50.554032
2789	2789	380000	2025-07-18 16:43:50.554032	2025-07-18 16:43:50.556032
2790	2790	650000	2025-07-18 16:43:50.556032	2025-07-18 16:43:50.559324
2791	2791	210000	2025-07-18 16:43:50.559324	2025-07-18 16:43:50.562324
2792	2792	300000	2025-07-18 16:43:50.562324	2025-07-18 16:43:50.563324
2793	2793	105000	2025-07-18 16:43:50.563324	2025-07-18 16:43:50.566339
2794	2794	135000	2025-07-18 16:43:50.566339	2025-07-18 16:43:50.568338
2795	2795	350000	2025-07-18 16:43:50.568338	2025-07-18 16:43:50.570763
2796	2796	105000	2025-07-18 16:43:50.570763	2025-07-18 16:43:50.573817
2797	2797	165000	2025-07-18 16:43:50.573817	2025-07-18 16:43:50.575831
2798	2798	175000	2025-07-18 16:43:50.575831	2025-07-18 16:43:50.577878
2799	2799	210000	2025-07-18 16:43:50.577878	2025-07-18 16:43:50.579878
2800	2800	350000	2025-07-18 16:43:50.580841	2025-07-18 16:43:50.583878
2801	2801	380000	2025-07-18 16:43:50.584863	2025-07-18 16:43:50.586878
2802	2802	680000	2025-07-18 16:43:50.586878	2025-07-18 16:43:50.589878
2803	2803	1400000	2025-07-18 16:43:50.589878	2025-07-18 16:43:50.592505
2804	2804	1100000	2025-07-18 16:43:50.592505	2025-07-18 16:43:50.594552
2805	2805	858000	2025-07-18 16:43:50.595562	2025-07-18 16:43:50.596607
2806	2806	741000	2025-07-18 16:43:50.596607	2025-07-18 16:43:50.598621
2807	2807	230000	2025-07-18 16:43:50.598621	2025-07-18 16:43:50.59962
2808	2808	580000	2025-07-18 16:43:50.59962	2025-07-18 16:43:50.60262
2809	2809	680000	2025-07-18 16:43:50.60262	2025-07-18 16:43:50.605605
2810	2810	380000	2025-07-18 16:43:50.605605	2025-07-18 16:43:50.608184
2811	2811	145000	2025-07-18 16:43:50.608184	2025-07-18 16:43:50.611183
2812	2812	150000	2025-07-18 16:43:50.611183	2025-07-18 16:43:50.613183
2813	2813	105000	2025-07-18 16:43:50.614151	2025-07-18 16:43:50.616167
2814	2814	200000	2025-07-18 16:43:50.616167	2025-07-18 16:43:50.618169
2815	2815	220000	2025-07-18 16:43:50.618169	2025-07-18 16:43:50.621183
2816	2816	15000	2025-07-18 16:43:50.621183	2025-07-18 16:43:50.623183
2817	2817	120000	2025-07-18 16:43:50.623183	2025-07-18 16:43:50.626184
2818	2818	200000	2025-07-18 16:43:50.626184	2025-07-18 16:43:50.628174
2819	2819	170000	2025-07-18 16:43:50.628174	2025-07-18 16:43:50.630184
2820	2820	220000	2025-07-18 16:43:50.631183	2025-07-18 16:43:50.633183
2821	2821	115000	2025-07-18 16:43:50.633183	2025-07-18 16:43:50.635183
2822	2822	120000	2025-07-18 16:43:50.635183	2025-07-18 16:43:50.638183
2823	2823	75000	2025-07-18 16:43:50.638183	2025-07-18 16:43:50.640169
2824	2824	82000	2025-07-18 16:43:50.640169	2025-07-18 16:43:50.642183
2825	2825	28500	2025-07-18 16:43:50.642183	2025-07-18 16:43:50.64523
2826	2826	20000	2025-07-18 16:43:50.64523	2025-07-18 16:43:50.64723
2827	2827	35000	2025-07-18 16:43:50.64723	2025-07-18 16:43:50.650214
2828	2828	35000	2025-07-18 16:43:50.650214	2025-07-18 16:43:50.652216
2829	2829	9000	2025-07-18 16:43:50.652216	2025-07-18 16:43:50.65423
2830	2830	15000	2025-07-18 16:43:50.65423	2025-07-18 16:43:50.65723
2831	2831	1000	2025-07-18 16:43:50.65723	2025-07-18 16:43:50.659787
2832	2832	4500	2025-07-18 16:43:50.659787	2025-07-18 16:43:50.660771
2833	2833	4300	2025-07-18 16:43:50.660771	2025-07-18 16:43:50.663118
2834	2834	2300	2025-07-18 16:43:50.663118	2025-07-18 16:43:50.66468
2835	2835	2500	2025-07-18 16:43:50.66468	2025-07-18 16:43:50.666206
2836	2836	3000	2025-07-18 16:43:50.666206	2025-07-18 16:43:50.670841
2837	2837	3500	2025-07-18 16:43:50.670841	2025-07-18 16:43:50.672872
2838	2838	65000	2025-07-18 16:43:50.672872	2025-07-18 16:43:50.674888
2839	2839	180000	2025-07-18 16:43:50.674888	2025-07-18 16:43:50.676898
2840	2840	35000	2025-07-18 16:43:50.676898	2025-07-18 16:43:50.679898
2841	2841	60000	2025-07-18 16:43:50.679898	2025-07-18 16:43:50.681898
2842	2842	180000	2025-07-18 16:43:50.682882	2025-07-18 16:43:50.683882
2843	2843	230000	2025-07-18 16:43:50.684884	2025-07-18 16:43:50.685884
2844	2844	440000	2025-07-18 16:43:50.685884	2025-07-18 16:43:50.687898
2845	2845	85000	2025-07-18 16:43:50.687898	2025-07-18 16:43:50.689898
2846	2846	50000	2025-07-18 16:43:50.689898	2025-07-18 16:43:50.693518
2847	2847	100000	2025-07-18 16:43:50.693518	2025-07-18 16:43:50.696055
2848	2848	55000	2025-07-18 16:43:50.696055	2025-07-18 16:43:50.699123
2849	2849	25000	2025-07-18 16:43:50.699123	2025-07-18 16:43:50.701123
2850	2850	18000	2025-07-18 16:43:50.701123	2025-07-18 16:43:50.704123
2851	2851	30000	2025-07-18 16:43:50.704123	2025-07-18 16:43:50.706107
2852	2852	25000	2025-07-18 16:43:50.707638	2025-07-18 16:43:50.709695
2853	2853	70000	2025-07-18 16:43:50.71067	2025-07-18 16:43:50.711671
2854	2854	45000	2025-07-18 16:43:50.712672	2025-07-18 16:43:50.713672
2855	2855	35000	2025-07-18 16:43:50.714672	2025-07-18 16:43:50.716686
2856	2856	60000	2025-07-18 16:43:50.717692	2025-07-18 16:43:50.720672
2857	2857	55000	2025-07-18 16:43:50.720672	2025-07-18 16:43:50.721672
2858	2858	25000	2025-07-18 16:43:50.722685	2025-07-18 16:43:50.723672
2859	2859	0	2025-07-18 16:43:50.724672	2025-07-18 16:43:50.726713
2860	2860	85000	2025-07-18 16:43:50.727726	2025-07-18 16:43:50.730761
2861	2861	130000	2025-07-18 16:43:50.730761	2025-07-18 16:43:50.732747
2862	2862	108000	2025-07-18 16:43:50.732747	2025-07-18 16:43:50.734761
2863	2863	250000	2025-07-18 16:43:50.734761	2025-07-18 16:43:50.737731
2864	2864	80000	2025-07-18 16:43:50.738726	2025-07-18 16:43:50.740745
2865	2865	30000	2025-07-18 16:43:50.741745	2025-07-18 16:43:50.742746
2866	2866	39000	2025-07-18 16:43:50.743777	2025-07-18 16:43:50.744792
2867	2867	70000	2025-07-18 16:43:50.745791	2025-07-18 16:43:50.748777
2868	2868	65000	2025-07-18 16:43:50.748777	2025-07-18 16:43:50.749777
2869	2869	70000	2025-07-18 16:43:50.750777	2025-07-18 16:43:50.751775
2870	2870	300000	2025-07-18 16:43:50.751775	2025-07-18 16:43:50.752777
2871	2871	18000	2025-07-18 16:43:50.753777	2025-07-18 16:43:50.755791
2872	2872	25000	2025-07-18 16:43:50.755791	2025-07-18 16:43:50.757791
2873	2873	30000	2025-07-18 16:43:50.757791	2025-07-18 16:43:50.76092
2874	2874	50000	2025-07-18 16:43:50.76092	2025-07-18 16:43:50.762905
2875	2875	70000	2025-07-18 16:43:50.762905	2025-07-18 16:43:50.764918
2876	2876	90000	2025-07-18 16:43:50.764918	2025-07-18 16:43:50.766918
2877	2877	0	2025-07-18 16:43:50.767919	2025-07-18 16:43:50.769918
2878	2878	40000	2025-07-18 16:43:50.769918	2025-07-18 16:43:50.773011
2879	2879	120000	2025-07-18 16:43:50.773011	2025-07-18 16:43:50.775056
2880	2880	300000	2025-07-18 16:43:50.775056	2025-07-18 16:43:50.777117
2881	2881	110000	2025-07-18 16:43:50.777117	2025-07-18 16:43:50.779117
2882	2882	260000	2025-07-18 16:43:50.779117	2025-07-18 16:43:50.782129
2883	2883	100000	2025-07-18 16:43:50.782129	2025-07-18 16:43:50.784103
2884	2884	250000	2025-07-18 16:43:50.784103	2025-07-18 16:43:50.785103
2885	2885	18000	2025-07-18 16:43:50.785103	2025-07-18 16:43:50.788089
2886	2886	30000	2025-07-18 16:43:50.788089	2025-07-18 16:43:50.791609
2887	2887	6800	2025-07-18 16:43:50.791609	2025-07-18 16:43:50.793688
2888	2888	10200	2025-07-18 16:43:50.794705	2025-07-18 16:43:50.795696
2889	2889	16600	2025-07-18 16:43:50.796697	2025-07-18 16:43:50.797699
2890	2890	32100	2025-07-18 16:43:50.798699	2025-07-18 16:43:50.800699
2891	2891	61400	2025-07-18 16:43:50.800699	2025-07-18 16:43:50.802698
2892	2892	9200	2025-07-18 16:43:50.803699	2025-07-18 16:43:50.806055
2893	2893	21300	2025-07-18 16:43:50.807068	2025-07-18 16:43:50.809619
2894	2894	7300	2025-07-18 16:43:50.810619	2025-07-18 16:43:50.811605
2895	2895	10700	2025-07-18 16:43:50.812605	2025-07-18 16:43:50.814702
2896	2896	11600	2025-07-18 16:43:50.814702	2025-07-18 16:43:50.817735
2897	2897	17500	2025-07-18 16:43:50.818787	2025-07-18 16:43:50.81984
2898	2898	19200	2025-07-18 16:43:50.81984	2025-07-18 16:43:50.821899
2899	2899	27700	2025-07-18 16:43:50.822899	2025-07-18 16:43:50.824899
2900	2900	28100	2025-07-18 16:43:50.824899	2025-07-18 16:43:50.827885
2901	2901	29600	2025-07-18 16:43:50.827885	2025-07-18 16:43:50.829899
2902	2902	7800	2025-07-18 16:43:50.829899	2025-07-18 16:43:50.831883
2903	2903	12500	2025-07-18 16:43:50.832889	2025-07-18 16:43:50.834899
2904	2904	17000	2025-07-18 16:43:50.834899	2025-07-18 16:43:50.836899
2905	2905	19300	2025-07-18 16:43:50.836899	2025-07-18 16:43:50.839885
2906	2906	26800	2025-07-18 16:43:50.839885	2025-07-18 16:43:50.841883
2907	2907	30900	2025-07-18 16:43:50.841883	2025-07-18 16:43:50.843909
2908	2908	56800	2025-07-18 16:43:50.843909	2025-07-18 16:43:50.846909
2909	2909	95600	2025-07-18 16:43:50.846909	2025-07-18 16:43:50.848909
2910	2910	98600	2025-07-18 16:43:50.848909	2025-07-18 16:43:50.85191
2911	2911	149100	2025-07-18 16:43:50.85191	2025-07-18 16:43:50.853909
2912	2912	62200	2025-07-18 16:43:50.853909	2025-07-18 16:43:50.856895
2913	2913	67800	2025-07-18 16:43:50.856895	2025-07-18 16:43:50.859476
2914	2914	84700	2025-07-18 16:43:50.859476	2025-07-18 16:43:50.861474
2915	2915	5700	2025-07-18 16:43:50.861474	2025-07-18 16:43:50.86349
2916	2916	8300	2025-07-18 16:43:50.86349	2025-07-18 16:43:50.86549
2917	2917	12100	2025-07-18 16:43:50.86549	2025-07-18 16:43:50.86849
2918	2918	12500	2025-07-18 16:43:50.86849	2025-07-18 16:43:50.871476
2919	2919	17200	2025-07-18 16:43:50.871476	2025-07-18 16:43:50.874476
2920	2920	19200	2025-07-18 16:43:50.875474	2025-07-18 16:43:50.877537
2921	2921	34100	2025-07-18 16:43:50.877537	2025-07-18 16:43:50.880537
2922	2922	91800	2025-07-18 16:43:50.880537	2025-07-18 16:43:50.883274
2923	2923	93600	2025-07-18 16:43:50.883274	2025-07-18 16:43:50.886564
2924	2924	140400	2025-07-18 16:43:50.888313	2025-07-18 16:43:50.889324
2925	2925	264800	2025-07-18 16:43:50.889324	2025-07-18 16:43:50.892461
2926	2926	418400	2025-07-18 16:43:50.892461	2025-07-18 16:43:50.895539
2927	2927	497600	2025-07-18 16:43:50.895539	2025-07-18 16:43:50.897525
2928	2928	58300	2025-07-18 16:43:50.897525	2025-07-18 16:43:50.899539
2929	2929	66400	2025-07-18 16:43:50.899539	2025-07-18 16:43:50.901539
2930	2930	77800	2025-07-18 16:43:50.901539	2025-07-18 16:43:50.904539
2931	2931	215300	2025-07-18 16:43:50.904539	2025-07-18 16:43:50.905525
2932	2932	334200	2025-07-18 16:43:50.906525	2025-07-18 16:43:50.907525
2933	2933	392900	2025-07-18 16:43:50.907525	2025-07-18 16:43:50.909035
2934	2934	96200	2025-07-18 16:43:50.909035	2025-07-18 16:43:50.911081
2935	2935	155500	2025-07-18 16:43:50.911081	2025-07-18 16:43:50.913081
2936	2936	4900	2025-07-18 16:43:50.914081	2025-07-18 16:43:50.917067
2937	2937	6400	2025-07-18 16:43:50.917067	2025-07-18 16:43:50.919263
2938	2938	10500	2025-07-18 16:43:50.919263	2025-07-18 16:43:50.921808
2939	2939	18500	2025-07-18 16:43:50.921808	2025-07-18 16:43:50.923858
2940	2940	30800	2025-07-18 16:43:50.924858	2025-07-18 16:43:50.926858
2941	2941	31900	2025-07-18 16:43:50.926858	2025-07-18 16:43:50.929843
2942	2942	50600	2025-07-18 16:43:50.929843	2025-07-18 16:43:50.931844
2943	2943	70900	2025-07-18 16:43:50.931844	2025-07-18 16:43:50.932844
2944	2944	112400	2025-07-18 16:43:50.932844	2025-07-18 16:43:50.934858
2945	2945	171800	2025-07-18 16:43:50.935859	2025-07-18 16:43:50.937858
2946	2946	45500	2025-07-18 16:43:50.937858	2025-07-18 16:43:50.939824
2947	2947	70900	2025-07-18 16:43:50.940842	2025-07-18 16:43:50.942858
2948	2948	112300	2025-07-18 16:43:50.942858	2025-07-18 16:43:50.94489
2949	2949	177200	2025-07-18 16:43:50.94489	2025-07-18 16:43:50.948317
2950	2950	269300	2025-07-18 16:43:50.948317	2025-07-18 16:43:50.951078
2951	2951	84000	2025-07-18 16:43:50.951078	2025-07-18 16:43:50.953128
2952	2952	125800	2025-07-18 16:43:50.953128	2025-07-18 16:43:50.956128
2953	2953	184800	2025-07-18 16:43:50.956128	2025-07-18 16:43:50.958659
2954	2954	294000	2025-07-18 16:43:50.958659	2025-07-18 16:43:50.960795
2955	2955	472000	2025-07-18 16:43:50.960795	2025-07-18 16:43:50.963796
2956	2956	169100	2025-07-18 16:43:50.963796	2025-07-18 16:43:50.965781
2957	2957	285300	2025-07-18 16:43:50.965781	2025-07-18 16:43:50.967781
2958	2958	348000	2025-07-18 16:43:50.967781	2025-07-18 16:43:50.968781
2959	2959	491300	2025-07-18 16:43:50.968781	2025-07-18 16:43:50.971779
2960	2960	947700	2025-07-18 16:43:50.971779	2025-07-18 16:43:50.973781
2961	2961	153500	2025-07-18 16:43:50.973781	2025-07-18 16:43:50.975795
2962	2962	226300	2025-07-18 16:43:50.976794	2025-07-18 16:43:50.978842
2963	2963	311700	2025-07-18 16:43:50.978842	2025-07-18 16:43:50.980826
2964	2964	474900	2025-07-18 16:43:50.980826	2025-07-18 16:43:50.982826
2965	2965	9500	2025-07-18 16:43:50.982826	2025-07-18 16:43:50.984826
2966	2966	17000	2025-07-18 16:43:50.984826	2025-07-18 16:43:50.98684
2967	2967	24100	2025-07-18 16:43:50.98684	2025-07-18 16:43:50.98884
2968	2968	25400	2025-07-18 16:43:50.989841	2025-07-18 16:43:50.99184
2969	2969	42500	2025-07-18 16:43:50.992366	2025-07-18 16:43:50.995454
2970	2970	74400	2025-07-18 16:43:50.995454	2025-07-18 16:43:50.997455
2971	2971	64900	2025-07-18 16:43:50.997455	2025-07-18 16:43:50.999456
2972	2972	66500	2025-07-18 16:43:50.999456	2025-07-18 16:43:51.001469
2973	2973	15500	2025-07-18 16:43:51.001469	2025-07-18 16:43:51.003484
2974	2974	25700	2025-07-18 16:43:51.004456	2025-07-18 16:43:51.006454
2975	2975	26800	2025-07-18 16:43:51.00747	2025-07-18 16:43:51.009001
2976	2976	47100	2025-07-18 16:43:51.009001	2025-07-18 16:43:51.010035
2977	2977	47100	2025-07-18 16:43:51.011035	2025-07-18 16:43:51.012035
2978	2978	47100	2025-07-18 16:43:51.012035	2025-07-18 16:43:51.014035
2979	2979	75600	2025-07-18 16:43:51.014035	2025-07-18 16:43:51.017491
2980	2980	75600	2025-07-18 16:43:51.017491	2025-07-18 16:43:51.02005
2981	2981	75600	2025-07-18 16:43:51.02005	2025-07-18 16:43:51.022043
2982	2982	84900	2025-07-18 16:43:51.022043	2025-07-18 16:43:51.024044
2983	2983	348500	2025-07-18 16:43:51.024044	2025-07-18 16:43:51.027329
2984	2984	429800	2025-07-18 16:43:51.027329	2025-07-18 16:43:51.030345
2985	2985	563000	2025-07-18 16:43:51.030345	2025-07-18 16:43:51.032344
2986	2986	962300	2025-07-18 16:43:51.032344	2025-07-18 16:43:51.034345
2987	2987	1385100	2025-07-18 16:43:51.035345	2025-07-18 16:43:51.037334
2988	2988	80000	2025-07-18 16:43:51.037334	2025-07-18 16:43:51.039329
2989	2989	125000	2025-07-18 16:43:51.040329	2025-07-18 16:43:51.041331
2990	2990	160000	2025-07-18 16:43:51.041331	2025-07-18 16:43:51.04333
2991	2991	110000	2025-07-18 16:43:51.04333	2025-07-18 16:43:51.04433
2992	2992	110000	2025-07-18 16:43:51.04433	2025-07-18 16:43:51.046376
2993	2993	0	2025-07-18 16:43:51.046376	2025-07-18 16:43:51.050366
2994	2994	1000	2025-07-18 16:43:51.050366	2025-07-18 16:43:51.05236
2995	2995	145000	2025-07-18 16:43:51.05236	2025-07-18 16:43:51.055376
2996	2996	40000	2025-07-18 16:43:51.055376	2025-07-18 16:43:51.05836
2997	2997	1000	2025-07-18 16:43:51.05836	2025-07-18 16:43:51.060902
2998	2998	50000	2025-07-18 16:43:51.060902	2025-07-18 16:43:51.063916
2999	2999	80000	2025-07-18 16:43:51.063916	2025-07-18 16:43:51.065916
3000	3000	35000	2025-07-18 16:43:51.066902	2025-07-18 16:43:51.068916
3001	3001	75000	2025-07-18 16:43:51.068916	2025-07-18 16:43:51.070916
3002	3002	50000	2025-07-18 16:43:51.071902	2025-07-18 16:43:51.072902
3003	3003	50000	2025-07-18 16:43:51.072902	2025-07-18 16:43:51.074902
3004	3004	50000	2025-07-18 16:43:51.074902	2025-07-18 16:43:51.076916
3005	3005	50000	2025-07-18 16:43:51.076916	2025-07-18 16:43:51.079963
3006	3006	70000	2025-07-18 16:43:51.079963	2025-07-18 16:43:51.081962
3007	3007	80000	2025-07-18 16:43:51.082949	2025-07-18 16:43:51.085964
3008	3008	150000	2025-07-18 16:43:51.085964	2025-07-18 16:43:51.086949
3009	3009	35000	2025-07-18 16:43:51.086949	2025-07-18 16:43:51.088949
3010	3010	35000	2025-07-18 16:43:51.088949	2025-07-18 16:43:51.090962
3011	3011	35000	2025-07-18 16:43:51.090962	2025-07-18 16:43:51.094524
3012	3012	55000	2025-07-18 16:43:51.094524	2025-07-18 16:43:51.095554
3013	3013	100000	2025-07-18 16:43:51.09657	2025-07-18 16:43:51.09857
3014	3014	100000	2025-07-18 16:43:51.09857	2025-07-18 16:43:51.10057
3015	3015	100000	2025-07-18 16:43:51.10157	2025-07-18 16:43:51.10357
3016	3016	100000	2025-07-18 16:43:51.10357	2025-07-18 16:43:51.105823
3017	3017	43000	2025-07-18 16:43:51.105823	2025-07-18 16:43:51.107912
3018	3018	40000	2025-07-18 16:43:51.107912	2025-07-18 16:43:51.11106
3019	3019	40000	2025-07-18 16:43:51.11106	2025-07-18 16:43:51.112736
3020	3020	40000	2025-07-18 16:43:51.112736	2025-07-18 16:43:51.115784
3021	3021	40000	2025-07-18 16:43:51.115784	2025-07-18 16:43:51.117769
3022	3022	40000	2025-07-18 16:43:51.117769	2025-07-18 16:43:51.118769
3023	3023	5000	2025-07-18 16:43:51.118769	2025-07-18 16:43:51.120783
3024	3024	50000	2025-07-18 16:43:51.120783	2025-07-18 16:43:51.123783
3025	3025	230000	2025-07-18 16:43:51.123783	2025-07-18 16:43:51.125783
3026	3026	230000	2025-07-18 16:43:51.126769	2025-07-18 16:43:51.128783
3027	3027	2000	2025-07-18 16:43:51.128783	2025-07-18 16:43:51.129769
3028	3028	90000	2025-07-18 16:43:51.130769	2025-07-18 16:43:51.131769
3029	3029	225000	2025-07-18 16:43:51.131769	2025-07-18 16:43:51.133769
3030	3030	125000	2025-07-18 16:43:51.133769	2025-07-18 16:43:51.135783
3031	3031	90000	2025-07-18 16:43:51.135783	2025-07-18 16:43:51.13875
3032	3032	70000	2025-07-18 16:43:51.13875	2025-07-18 16:43:51.141783
3033	3033	87000	2025-07-18 16:43:51.141783	2025-07-18 16:43:51.143783
3034	3034	97000	2025-07-18 16:43:51.144785	2025-07-18 16:43:51.146832
3035	3035	120000	2025-07-18 16:43:51.146832	2025-07-18 16:43:51.148832
3036	3036	145000	2025-07-18 16:43:51.149818	2025-07-18 16:43:51.152817
3037	3037	70000	2025-07-18 16:43:51.152817	2025-07-18 16:43:51.155819
3038	3038	85000	2025-07-18 16:43:51.155819	2025-07-18 16:43:51.157833
3039	3039	130000	2025-07-18 16:43:51.157833	2025-07-18 16:43:51.159817
3040	3040	70000	2025-07-18 16:43:51.161061	2025-07-18 16:43:51.164059
3041	3041	110000	2025-07-18 16:43:51.164059	2025-07-18 16:43:51.16606
3042	3042	70000	2025-07-18 16:43:51.16706	2025-07-18 16:43:51.170074
3043	3043	80000	2025-07-18 16:43:51.170074	2025-07-18 16:43:51.17306
3044	3044	150000	2025-07-18 16:43:51.17306	2025-07-18 16:43:51.174058
3045	3045	40000	2025-07-18 16:43:51.174058	2025-07-18 16:43:51.176074
3046	3046	50000	2025-07-18 16:43:51.177075	2025-07-18 16:43:51.179122
3047	3047	55000	2025-07-18 16:43:51.179122	2025-07-18 16:43:51.181122
3048	3048	50000	2025-07-18 16:43:51.181122	2025-07-18 16:43:51.185097
3049	3049	50000	2025-07-18 16:43:51.185097	2025-07-18 16:43:51.188108
3050	3050	55000	2025-07-18 16:43:51.188108	2025-07-18 16:43:51.190122
3051	3051	50000	2025-07-18 16:43:51.190122	2025-07-18 16:43:51.192645
3052	3052	50000	2025-07-18 16:43:51.192645	2025-07-18 16:43:51.195724
3053	3053	99800	2025-07-18 16:43:51.195724	2025-07-18 16:43:51.197727
3054	3054	15000	2025-07-18 16:43:51.197727	2025-07-18 16:43:51.199726
3055	3055	15000	2025-07-18 16:43:51.199726	2025-07-18 16:43:51.201726
3056	3056	120000	2025-07-18 16:43:51.201726	2025-07-18 16:43:51.202726
3057	3057	40000	2025-07-18 16:43:51.20374	2025-07-18 16:43:51.205726
3058	3058	3500000	2025-07-18 16:43:51.205726	2025-07-18 16:43:51.207726
3059	3059	350000	2025-07-18 16:43:51.207726	2025-07-18 16:43:51.208724
3060	3060	125000	2025-07-18 16:43:51.208724	2025-07-18 16:43:51.212699
3061	3061	350000	2025-07-18 16:43:51.213713	2025-07-18 16:43:51.215696
3062	3062	500000	2025-07-18 16:43:51.215696	2025-07-18 16:43:51.217692
3063	3063	550000	2025-07-18 16:43:51.217692	2025-07-18 16:43:51.220713
3064	3064	600000	2025-07-18 16:43:51.220713	2025-07-18 16:43:51.222695
3065	3065	400000	2025-07-18 16:43:51.223714	2025-07-18 16:43:51.226715
3066	3066	960000	2025-07-18 16:43:51.226715	2025-07-18 16:43:51.230198
3067	3067	1650000	2025-07-18 16:43:51.230198	2025-07-18 16:43:51.233288
3068	3068	1750000	2025-07-18 16:43:51.233288	2025-07-18 16:43:51.235428
3069	3069	1150000	2025-07-18 16:43:51.235428	2025-07-18 16:43:51.23843
3070	3070	950000	2025-07-18 16:43:51.23843	2025-07-18 16:43:51.240982
3071	3071	900000	2025-07-18 16:43:51.240982	2025-07-18 16:43:51.241992
3072	3072	680000	2025-07-18 16:43:51.242991	2025-07-18 16:43:51.244404
3073	3073	750000	2025-07-18 16:43:51.244404	2025-07-18 16:43:51.246551
3074	3074	115000	2025-07-18 16:43:51.246551	2025-07-18 16:43:51.249609
3075	3075	75000	2025-07-18 16:43:51.25059	2025-07-18 16:43:51.252588
3076	3076	55000	2025-07-18 16:43:51.253589	2025-07-18 16:43:51.255605
3077	3077	40000	2025-07-18 16:43:51.257025	2025-07-18 16:43:51.258059
3078	3078	15000	2025-07-18 16:43:51.258059	2025-07-18 16:43:51.261044
3079	3079	120000	2025-07-18 16:43:51.261548	2025-07-18 16:43:51.263556
3080	3080	0	2025-07-18 16:43:51.263556	2025-07-18 16:43:51.266577
3081	3081	0	2025-07-18 16:43:51.266577	2025-07-18 16:43:51.26758
3082	3082	15000	2025-07-18 16:43:51.26758	2025-07-18 16:43:51.26958
3083	3083	145000	2025-07-18 16:43:51.270564	2025-07-18 16:43:51.271818
3084	3084	70000	2025-07-18 16:43:51.273022	2025-07-18 16:43:51.275034
3085	3085	170000	2025-07-18 16:43:51.276035	2025-07-18 16:43:51.278065
3086	3086	1450000	2025-07-18 16:43:51.278065	2025-07-18 16:43:51.280053
3087	3087	1800000	2025-07-18 16:43:51.280053	2025-07-18 16:43:51.28305
3088	3088	750000	2025-07-18 16:43:51.28305	2025-07-18 16:43:51.286051
3089	3089	100000	2025-07-18 16:43:51.286051	2025-07-18 16:43:51.289062
3090	3090	125000	2025-07-18 16:43:51.289062	2025-07-18 16:43:51.291072
3091	3091	25000	2025-07-18 16:43:51.291072	2025-07-18 16:43:51.294169
3092	3092	600000	2025-07-18 16:43:51.294169	2025-07-18 16:43:51.297491
3093	3093	750000	2025-07-18 16:43:51.297491	2025-07-18 16:43:51.300491
3094	3094	300000	2025-07-18 16:43:51.300491	2025-07-18 16:43:51.30249
3095	3095	270000	2025-07-18 16:43:51.30249	2025-07-18 16:43:51.305716
3096	3096	160000	2025-07-18 16:43:51.305716	2025-07-18 16:43:51.308747
3097	3097	160000	2025-07-18 16:43:51.309745	2025-07-18 16:43:51.311769
3098	3098	350000	2025-07-18 16:43:51.311769	2025-07-18 16:43:51.31611
3099	3099	800000	2025-07-18 16:43:51.31611	2025-07-18 16:43:51.31911
3100	3100	620000	2025-07-18 16:43:51.32011	2025-07-18 16:43:51.32311
3101	3101	1550000	2025-07-18 16:43:51.32311	2025-07-18 16:43:51.326966
3102	3102	1650000	2025-07-18 16:43:51.327497	2025-07-18 16:43:51.329644
3103	3103	950000	2025-07-18 16:43:51.330655	2025-07-18 16:43:51.332168
3104	3104	1150000	2025-07-18 16:43:51.333179	2025-07-18 16:43:51.334691
3105	3105	480000	2025-07-18 16:43:51.334691	2025-07-18 16:43:51.337689
3106	3106	1450000	2025-07-18 16:43:51.337689	2025-07-18 16:43:51.340689
3107	3107	780000	2025-07-18 16:43:51.340689	2025-07-18 16:43:51.343691
3108	3108	350000	2025-07-18 16:43:51.343691	2025-07-18 16:43:51.34669
3109	3109	800000	2025-07-18 16:43:51.34669	2025-07-18 16:43:51.350692
3110	3110	650000	2025-07-18 16:43:51.350692	2025-07-18 16:43:51.353689
3111	3111	300000	2025-07-18 16:43:51.353689	2025-07-18 16:43:51.356691
3112	3112	120000	2025-07-18 16:43:51.356691	2025-07-18 16:43:51.359688
3113	3113	430000	2025-07-18 16:43:51.359688	2025-07-18 16:43:51.36269
3114	3114	550000	2025-07-18 16:43:51.363691	2025-07-18 16:43:51.366694
3115	3115	750000	2025-07-18 16:43:51.366694	2025-07-18 16:43:51.369689
3116	3116	800000	2025-07-18 16:43:51.370692	2025-07-18 16:43:51.373706
3117	3117	750000	2025-07-18 16:43:51.373706	2025-07-18 16:43:51.37669
3118	3118	1000000	2025-07-18 16:43:51.37669	2025-07-18 16:43:51.379713
3119	3119	650000	2025-07-18 16:43:51.379713	2025-07-18 16:43:51.381695
3120	3120	40000	2025-07-18 16:43:51.381695	2025-07-18 16:43:51.384696
3121	3121	160000	2025-07-18 16:43:51.384696	2025-07-18 16:43:51.387693
3122	3122	135000	2025-07-18 16:43:51.388703	2025-07-18 16:43:51.390722
3123	3123	110000	2025-07-18 16:43:51.390722	2025-07-18 16:43:51.395318
3124	3124	320000	2025-07-18 16:43:51.395318	2025-07-18 16:43:51.398379
3125	3125	0	2025-07-18 16:43:51.399385	2025-07-18 16:43:51.402385
3126	3126	35000	2025-07-18 16:43:51.403385	2025-07-18 16:43:51.40637
3127	3127	380000	2025-07-18 16:43:51.40637	2025-07-18 16:43:51.408371
3128	3128	350000	2025-07-18 16:43:51.409385	2025-07-18 16:43:51.411371
3129	3129	60000	2025-07-18 16:43:51.411371	2025-07-18 16:43:51.413385
3130	3130	60000	2025-07-18 16:43:51.413385	2025-07-18 16:43:51.416371
3131	3131	65000	2025-07-18 16:43:51.416371	2025-07-18 16:43:51.420369
3132	3132	35000	2025-07-18 16:43:51.420369	2025-07-18 16:43:51.422385
3133	3133	50000	2025-07-18 16:43:51.423371	2025-07-18 16:43:51.425385
3134	3134	75000	2025-07-18 16:43:51.425385	2025-07-18 16:43:51.428357
3135	3135	7000	2025-07-18 16:43:51.428357	2025-07-18 16:43:51.430385
3136	3136	109512	2025-07-18 16:43:51.430385	2025-07-18 16:43:51.432385
3137	3137	90000	2025-07-18 16:43:51.433371	2025-07-18 16:43:51.435371
3138	3138	260000	2025-07-18 16:43:51.435371	2025-07-18 16:43:51.437379
3139	3139	220000	2025-07-18 16:43:51.437379	2025-07-18 16:43:51.439371
3140	3140	90000	2025-07-18 16:43:51.440369	2025-07-18 16:43:51.44137
3141	3141	260000	2025-07-18 16:43:51.442371	2025-07-18 16:43:51.444385
3142	3142	50000	2025-07-18 16:43:51.444385	2025-07-18 16:43:51.446385
3143	3143	60000	2025-07-18 16:43:51.447371	2025-07-18 16:43:51.449356
3144	3144	100000	2025-07-18 16:43:51.449356	2025-07-18 16:43:51.451369
3145	3145	50000	2025-07-18 16:43:51.452369	2025-07-18 16:43:51.454347
3146	3146	110000	2025-07-18 16:43:51.454347	2025-07-18 16:43:51.456347
3147	3147	10000	2025-07-18 16:43:51.456347	2025-07-18 16:43:51.457347
3148	3148	30000	2025-07-18 16:43:51.457347	2025-07-18 16:43:51.459349
3149	3149	35000	2025-07-18 16:43:51.460348	2025-07-18 16:43:51.46235
3150	3150	950000	2025-07-18 16:43:51.46235	2025-07-18 16:43:51.464345
3151	3151	75000	2025-07-18 16:43:51.464345	2025-07-18 16:43:51.46635
3152	3152	25000	2025-07-18 16:43:51.46635	2025-07-18 16:43:51.468354
3153	3153	320000	2025-07-18 16:43:51.468354	2025-07-18 16:43:51.469348
3154	3154	860000	2025-07-18 16:43:51.469348	2025-07-18 16:43:51.472351
3155	3155	65000	2025-07-18 16:43:51.472351	2025-07-18 16:43:51.474347
3156	3156	260000	2025-07-18 16:43:51.474347	2025-07-18 16:43:51.476347
3157	3157	145000	2025-07-18 16:43:51.476347	2025-07-18 16:43:51.478353
3158	3158	250000	2025-07-18 16:43:51.478353	2025-07-18 16:43:51.481353
3159	3159	220000	2025-07-18 16:43:51.481353	2025-07-18 16:43:51.483376
3160	3160	260000	2025-07-18 16:43:51.483376	2025-07-18 16:43:51.485353
3161	3161	120000	2025-07-18 16:43:51.48642	2025-07-18 16:43:51.488438
3162	3162	70000	2025-07-18 16:43:51.488438	2025-07-18 16:43:51.49044
3163	3163	10000	2025-07-18 16:43:51.491436	2025-07-18 16:43:51.493466
3164	3164	150000	2025-07-18 16:43:51.494451	2025-07-18 16:43:51.496596
3165	3165	7000	2025-07-18 16:43:51.497596	2025-07-18 16:43:51.499594
3166	3166	18000	2025-07-18 16:43:51.499594	2025-07-18 16:43:51.501597
3167	3167	10000	2025-07-18 16:43:51.501597	2025-07-18 16:43:51.50486
3168	3168	155000	2025-07-18 16:43:51.50486	2025-07-18 16:43:51.50786
3169	3169	1000	2025-07-18 16:43:51.50786	2025-07-18 16:43:51.510859
3170	3170	50000	2025-07-18 16:43:51.510859	2025-07-18 16:43:51.513862
\.


--
-- TOC entry 4945 (class 0 OID 16664)
-- Dependencies: 218
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."user" (id, username, hashed_password, is_active, is_admin) FROM stdin;
1	admin	$2b$12$ZYHYDjyEpF2LlJmUzxSkxOJ2rg.AYQbBSt8hNHCcuZizDh0GSL.KK	t	t
2	ketoan1	$2b$12$2FnRA3gcjap1lKIYerrjqOs.pWsay5jW1hXIa6Bnz6YcyGc9WTjrS	t	f
3	ketoan2	$2b$12$FH6cZySt6Ozu/BxqNHcYPewSbcgnBOyssyxJTC8BZDNFwaqguxdGq	t	f
\.


--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 219
-- Name: customer_makh_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.customer_makh_seq', 6, true);


--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 226
-- Name: invoicedetail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.invoicedetail_id_seq', 33, true);


--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 221
-- Name: product_masp_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.product_masp_seq', 3170, true);


--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 223
-- Name: productpricehistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.productpricehistory_id_seq', 3170, true);


--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- TOC entry 4778 (class 2606 OID 16681)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (makh);


--
-- TOC entry 4788 (class 2606 OID 16713)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (mahd);


--
-- TOC entry 4792 (class 2606 OID 16729)
-- Name: invoicedetail invoicedetail_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.invoicedetail
    ADD CONSTRAINT invoicedetail_pkey PRIMARY KEY (id);


--
-- TOC entry 4783 (class 2606 OID 16692)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (masp);


--
-- TOC entry 4786 (class 2606 OID 16700)
-- Name: productpricehistory productpricehistory_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.productpricehistory
    ADD CONSTRAINT productpricehistory_pkey PRIMARY KEY (id);


--
-- TOC entry 4776 (class 2606 OID 16671)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 1259 OID 16682)
-- Name: ix_customer_tenkh; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_customer_tenkh ON public.customer USING btree (tenkh);


--
-- TOC entry 4780 (class 1259 OID 16683)
-- Name: ix_customer_tenkh_khongdau; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_customer_tenkh_khongdau ON public.customer USING btree (tenkh_khongdau);


--
-- TOC entry 4789 (class 1259 OID 16719)
-- Name: ix_invoice_mahd; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_invoice_mahd ON public.invoice USING btree (mahd);


--
-- TOC entry 4790 (class 1259 OID 16720)
-- Name: ix_invoice_makh; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_invoice_makh ON public.invoice USING btree (makh);


--
-- TOC entry 4793 (class 1259 OID 16740)
-- Name: ix_invoicedetail_mahd; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_invoicedetail_mahd ON public.invoicedetail USING btree (mahd);


--
-- TOC entry 4794 (class 1259 OID 16741)
-- Name: ix_invoicedetail_masp; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_invoicedetail_masp ON public.invoicedetail USING btree (masp);


--
-- TOC entry 4781 (class 1259 OID 16693)
-- Name: ix_product_tensp_khongdau; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_product_tensp_khongdau ON public.product USING btree (tensp_khongdau);


--
-- TOC entry 4784 (class 1259 OID 16706)
-- Name: ix_productpricehistory_product_masp; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX ix_productpricehistory_product_masp ON public.productpricehistory USING btree (product_masp);


--
-- TOC entry 4774 (class 1259 OID 16672)
-- Name: ix_user_username; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX ix_user_username ON public."user" USING btree (username);


--
-- TOC entry 4796 (class 2606 OID 16714)
-- Name: invoice invoice_makh_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_makh_fkey FOREIGN KEY (makh) REFERENCES public.customer(makh);


--
-- TOC entry 4797 (class 2606 OID 16730)
-- Name: invoicedetail invoicedetail_mahd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.invoicedetail
    ADD CONSTRAINT invoicedetail_mahd_fkey FOREIGN KEY (mahd) REFERENCES public.invoice(mahd);


--
-- TOC entry 4798 (class 2606 OID 16735)
-- Name: invoicedetail invoicedetail_masp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.invoicedetail
    ADD CONSTRAINT invoicedetail_masp_fkey FOREIGN KEY (masp) REFERENCES public.product(masp);


--
-- TOC entry 4795 (class 2606 OID 16701)
-- Name: productpricehistory productpricehistory_product_masp_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.productpricehistory
    ADD CONSTRAINT productpricehistory_product_masp_fkey FOREIGN KEY (product_masp) REFERENCES public.product(masp);


-- Completed on 2025-07-21 15:06:01

--
-- PostgreSQL database dump complete
--

