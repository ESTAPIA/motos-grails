--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-07-15 01:20:16

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 25782)
-- Name: artc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artc (
    artc__id bigint NOT NULL,
    artcimgn character varying(100),
    artcprbs numeric(19,2) NOT NULL,
    tpac__id bigint NOT NULL,
    artcdscr text,
    artcnmbr character varying(100) NOT NULL,
    artcstock integer DEFAULT 0,
    artcdtcr timestamp without time zone,
    artcdtup timestamp without time zone
);


ALTER TABLE public.artc OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25781)
-- Name: artc_artc__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.artc_artc__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.artc_artc__id_seq OWNER TO postgres;

--
-- TOC entry 5004 (class 0 OID 0)
-- Dependencies: 217
-- Name: artc_artc__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artc_artc__id_seq OWNED BY public.artc.artc__id;


--
-- TOC entry 220 (class 1259 OID 25791)
-- Name: dtft; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dtft (
    dtft__id bigint NOT NULL,
    fact__id bigint NOT NULL,
    dtftcntd integer NOT NULL,
    dtftprun numeric(19,2) NOT NULL,
    artc__id bigint NOT NULL
);


ALTER TABLE public.dtft OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25790)
-- Name: dtft_dtft__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dtft_dtft__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dtft_dtft__id_seq OWNER TO postgres;

--
-- TOC entry 5005 (class 0 OID 0)
-- Dependencies: 219
-- Name: dtft_dtft__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dtft_dtft__id_seq OWNED BY public.dtft.dtft__id;


--
-- TOC entry 222 (class 1259 OID 25798)
-- Name: dtpd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dtpd (
    dtpd__id bigint NOT NULL,
    dtpdcntd integer NOT NULL,
    dtpdprun numeric(19,2) NOT NULL,
    pedd__id bigint NOT NULL,
    artc__id bigint NOT NULL
);


ALTER TABLE public.dtpd OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25797)
-- Name: dtpd_dtpd__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dtpd_dtpd__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dtpd_dtpd__id_seq OWNER TO postgres;

--
-- TOC entry 5006 (class 0 OID 0)
-- Dependencies: 221
-- Name: dtpd_dtpd__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dtpd_dtpd__id_seq OWNED BY public.dtpd.dtpd__id;


--
-- TOC entry 224 (class 1259 OID 25805)
-- Name: fact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact (
    fact__id bigint NOT NULL,
    factttl numeric(19,2) NOT NULL,
    pedd__id bigint NOT NULL,
    factfcem timestamp without time zone NOT NULL
);


ALTER TABLE public.fact OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25804)
-- Name: fact_fact__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fact_fact__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fact_fact__id_seq OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 223
-- Name: fact_fact__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_fact__id_seq OWNED BY public.fact.fact__id;


--
-- TOC entry 226 (class 1259 OID 25812)
-- Name: pedd; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pedd (
    pedd__id bigint NOT NULL,
    peddestd character varying(20) NOT NULL,
    prsn__id bigint NOT NULL,
    peddfchp timestamp without time zone NOT NULL
);


ALTER TABLE public.pedd OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25811)
-- Name: pedd_pedd__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pedd_pedd__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedd_pedd__id_seq OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 225
-- Name: pedd_pedd__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedd_pedd__id_seq OWNED BY public.pedd.pedd__id;


--
-- TOC entry 228 (class 1259 OID 25819)
-- Name: prfl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prfl (
    prfl__id bigint NOT NULL,
    prflpdre bigint,
    prflcdgo character varying(255) NOT NULL,
    prfldscr character varying(255) NOT NULL,
    prflobsr character varying(255),
    prflnmbr character varying(255) NOT NULL
);


ALTER TABLE public.prfl OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25818)
-- Name: prfl_prfl__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prfl_prfl__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prfl_prfl__id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 227
-- Name: prfl_prfl__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prfl_prfl__id_seq OWNED BY public.prfl.prfl__id;


--
-- TOC entry 230 (class 1259 OID 25828)
-- Name: prsn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prsn (
    prsn__id bigint NOT NULL,
    prsnlogn character varying(255),
    prsnapll character varying(31),
    prsnsexo character varying(255),
    prsnmail character varying(255) NOT NULL,
    tppr__id bigint NOT NULL,
    prsnfcin timestamp without time zone,
    prsnactv integer NOT NULL,
    prsntelf character varying(31),
    prsnpass character varying(63),
    prsnfcfn timestamp without time zone,
    prsncdla character varying(255),
    prsnnmbr character varying(31) NOT NULL,
    prfl__id bigint,
    prsndire character varying(255)
);


ALTER TABLE public.prsn OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25827)
-- Name: prsn_prsn__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prsn_prsn__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prsn_prsn__id_seq OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 229
-- Name: prsn_prsn__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prsn_prsn__id_seq OWNED BY public.prsn.prsn__id;


--
-- TOC entry 232 (class 1259 OID 25837)
-- Name: sesn; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sesn (
    sesn__id bigint NOT NULL,
    sesnfcin timestamp without time zone,
    prsn__id bigint NOT NULL,
    sesnfcfn timestamp without time zone,
    prfl__id bigint NOT NULL
);


ALTER TABLE public.sesn OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25836)
-- Name: sesn_sesn__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sesn_sesn__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sesn_sesn__id_seq OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 231
-- Name: sesn_sesn__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sesn_sesn__id_seq OWNED BY public.sesn.sesn__id;


--
-- TOC entry 234 (class 1259 OID 25844)
-- Name: tpac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tpac (
    tpac__id bigint NOT NULL,
    tpactpac character varying(50) NOT NULL
);


ALTER TABLE public.tpac OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25843)
-- Name: tpac_tpac__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tpac_tpac__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tpac_tpac__id_seq OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 233
-- Name: tpac_tpac__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tpac_tpac__id_seq OWNED BY public.tpac.tpac__id;


--
-- TOC entry 236 (class 1259 OID 25851)
-- Name: tppr; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tppr (
    tppr__id bigint NOT NULL,
    tpprdtcr timestamp without time zone,
    tpprdtup timestamp without time zone,
    tpprdscr character varying(50) NOT NULL
);


ALTER TABLE public.tppr OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25850)
-- Name: tppr_tppr__id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tppr_tppr__id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tppr_tppr__id_seq OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 235
-- Name: tppr_tppr__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tppr_tppr__id_seq OWNED BY public.tppr.tppr__id;


--
-- TOC entry 4787 (class 2604 OID 25785)
-- Name: artc artc__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artc ALTER COLUMN artc__id SET DEFAULT nextval('public.artc_artc__id_seq'::regclass);


--
-- TOC entry 4789 (class 2604 OID 25794)
-- Name: dtft dtft__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft ALTER COLUMN dtft__id SET DEFAULT nextval('public.dtft_dtft__id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 25801)
-- Name: dtpd dtpd__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd ALTER COLUMN dtpd__id SET DEFAULT nextval('public.dtpd_dtpd__id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 25808)
-- Name: fact fact__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact ALTER COLUMN fact__id SET DEFAULT nextval('public.fact_fact__id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 25815)
-- Name: pedd pedd__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedd ALTER COLUMN pedd__id SET DEFAULT nextval('public.pedd_pedd__id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 25822)
-- Name: prfl prfl__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prfl ALTER COLUMN prfl__id SET DEFAULT nextval('public.prfl_prfl__id_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 25831)
-- Name: prsn prsn__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn ALTER COLUMN prsn__id SET DEFAULT nextval('public.prsn_prsn__id_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 25840)
-- Name: sesn sesn__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn ALTER COLUMN sesn__id SET DEFAULT nextval('public.sesn_sesn__id_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 25847)
-- Name: tpac tpac__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tpac ALTER COLUMN tpac__id SET DEFAULT nextval('public.tpac_tpac__id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 25854)
-- Name: tppr tppr__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tppr ALTER COLUMN tppr__id SET DEFAULT nextval('public.tppr_tppr__id_seq'::regclass);


--
-- TOC entry 4980 (class 0 OID 25782)
-- Dependencies: 218
-- Data for Name: artc; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artc (artc__id, artcimgn, artcprbs, tpac__id, artcdscr, artcnmbr, artcstock, artcdtcr, artcdtup) FROM stdin;
3	https://m.media-amazon.com/images/I/717tJ9XYTGL._UF1000,1000_QL80_.jpg	35.50	2	Guantes de cuero reforzados	Guantes Racing	0	\N	\N
4	https://m.media-amazon.com/images/I/71Ue+SEek2L._UY1000_.jpg	200.00	3	Chaqueta impermeable con protecciones	Chaqueta Touring	400	\N	\N
8	https://igmmotos.com/wp-content/uploads/2023/03/igm-caballito-125-imagen-main-1.webp	1500.00	4	moto cc175	Moto New Era	90	\N	\N
6	https://m.media-amazon.com/images/I/71DjEVs9eKL._UY900_.jpg	100.00	5	Botas de lluvia	Botas para moto	89	\N	2025-07-14 21:30:46.881
9	https://igmmotos.com/wp-content/uploads/2024/08/igm-cafe-racer-2025-grilla.webp	8000.00	4	Moto new	Moto New Era II	49	\N	2025-07-14 21:31:31.798
\.


--
-- TOC entry 4982 (class 0 OID 25791)
-- Dependencies: 220
-- Data for Name: dtft; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dtft (dtft__id, fact__id, dtftcntd, dtftprun, artc__id) FROM stdin;
1	2	1	100.00	6
2	3	1	200.00	4
3	4	101	100.00	6
4	5	1	100.00	6
5	6	1	100.00	6
6	7	1	35.50	3
7	8	2	100.00	6
8	8	2	200.00	4
9	9	1	100.00	6
10	9	1	200.00	4
11	10	97	200.00	4
12	10	7	100.00	6
13	10	10	1500.00	8
14	11	1	100.00	6
15	12	1	8000.00	9
\.


--
-- TOC entry 4984 (class 0 OID 25798)
-- Dependencies: 222
-- Data for Name: dtpd; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dtpd (dtpd__id, dtpdcntd, dtpdprun, pedd__id, artc__id) FROM stdin;
1	1	100.00	2	6
2	1	200.00	3	4
3	101	100.00	4	6
4	1	100.00	5	6
5	1	100.00	6	6
6	1	35.50	7	3
7	2	100.00	8	6
8	2	200.00	8	4
9	1	100.00	9	6
10	1	200.00	9	4
11	7	100.00	10	6
12	97	200.00	10	4
13	10	1500.00	10	8
14	1	100.00	11	6
15	1	8000.00	12	9
\.


--
-- TOC entry 4986 (class 0 OID 25805)
-- Dependencies: 224
-- Data for Name: fact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fact (fact__id, factttl, pedd__id, factfcem) FROM stdin;
1	0.00	1	2025-06-29 22:58:12.408
2	100.00	2	2025-06-30 07:46:35.825
3	200.00	3	2025-07-02 09:32:42.568
4	10100.00	4	2025-07-02 09:33:25.607
5	100.00	5	2025-07-02 09:34:59.355
6	100.00	6	2025-07-02 09:36:55.395
7	35.50	7	2025-07-02 10:39:01.502
8	600.00	8	2025-07-02 11:47:55.264
9	300.00	9	2025-07-02 11:54:15.253
10	35100.00	10	2025-07-07 00:31:04.309
11	100.00	11	2025-07-14 21:30:46.895
12	8000.00	12	2025-07-14 21:31:31.801
\.


--
-- TOC entry 4988 (class 0 OID 25812)
-- Dependencies: 226
-- Data for Name: pedd; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pedd (pedd__id, peddestd, prsn__id, peddfchp) FROM stdin;
1	PROCESANDO	3	2025-06-29 22:58:08.479
2	PROCESANDO	3	2025-06-30 07:46:22.686
3	CONFIRMADO	3	2025-07-02 09:32:26.754
4	CONFIRMADO	3	2025-07-02 09:33:22.829
5	CONFIRMADO	3	2025-07-02 09:34:36.497
6	CONFIRMADO	3	2025-07-02 09:35:11.608
7	CONFIRMADO	3	2025-07-02 10:38:55.349
8	CONFIRMADO	5	2025-07-02 11:47:53.83
9	CONFIRMADO	5	2025-07-02 11:54:08.057
10	CONFIRMADO	7	2025-07-07 00:29:26.139
11	CONFIRMADO	5	2025-07-14 21:30:44.782
12	CONFIRMADO	5	2025-07-14 21:31:30.16
\.


--
-- TOC entry 4990 (class 0 OID 25819)
-- Dependencies: 228
-- Data for Name: prfl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prfl (prfl__id, prflpdre, prflcdgo, prfldscr, prflobsr, prflnmbr) FROM stdin;
1	\N	ADM	Perfil de administrador	\N	Admin
2	\N	CLI	Perfil de cliente	\N	Cliente
\.


--
-- TOC entry 4992 (class 0 OID 25828)
-- Dependencies: 230
-- Data for Name: prsn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prsn (prsn__id, prsnlogn, prsnapll, prsnsexo, prsnmail, tppr__id, prsnfcin, prsnactv, prsntelf, prsnpass, prsnfcfn, prsncdla, prsnnmbr, prfl__id, prsndire) FROM stdin;
1	juan	Pérez	M	juan@ejemplo.com	1	\N	1	0999999999	81dc9bdb52d04dc20036dbd8313ed055	\N	1234567890	Juan	1	Calle Falsa 123
4	sosa	Sosaa	F	anthony@gmail.com	2	\N	1	0985526352	2e99bf4e42962410038bc6fa4ce40d97	\N	1707988105	Anthony	2	Av Maldonado
3	carlos	Saavedra	M	carlos@ejemplo.com	2	\N	1	0977777777	d9b1d7db4cd6e70935368a1efb10e377	\N	1122334455	Carlos	2	Av. Cliente 789
5	admin	admin	\N	admin@gmail.com	2	\N	1	0985526352	202cb962ac59075b964b07152d234b70	\N	7777777777	admin	2	Av Maldonado
6	admin1	Administrador	\N	admin@admin.com	1	2025-07-02 00:00:00	1	\N	202cb962ac59075b964b07152d234b70	\N	\N	Administrador	1	\N
2	saul	Tapia	M	saul@ejemplo.com	1	\N	1	0988888888	202cb962ac59075b964b07152d234b70	\N	0987654321	Saul	1	Calle Real 456
7	prueba	prueba	\N	prueba@gmail.com	2	\N	1	0987654321	202cb962ac59075b964b07152d234b70	\N	5555555555	prueba	2	Av Maldonado
\.


--
-- TOC entry 4994 (class 0 OID 25837)
-- Dependencies: 232
-- Data for Name: sesn; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sesn (sesn__id, sesnfcin, prsn__id, sesnfcfn, prfl__id) FROM stdin;
1	2025-06-29 22:53:28.305	1	\N	1
2	2025-06-29 22:53:31.482	1	2025-06-29 22:54:44.493	1
3	2025-06-29 22:54:52.333	2	\N	1
4	2025-06-29 22:57:53.738	3	2025-06-29 22:58:24.645	2
5	2025-06-29 22:58:36.539	2	\N	1
6	2025-06-29 22:58:38.297	2	\N	1
7	2025-06-29 23:08:47.319	2	\N	1
8	2025-06-29 23:08:49.376	2	2025-06-29 23:11:16.418	1
9	2025-06-29 23:11:27.081	3	2025-06-29 23:12:17.359	2
10	2025-06-29 23:12:24.56	2	\N	1
11	2025-06-29 23:12:33.44	2	2025-06-29 23:14:11.415	1
12	2025-06-29 23:14:15.807	3	2025-06-29 23:14:30.871	2
13	2025-06-29 23:14:36.83	2	\N	1
14	2025-06-29 23:14:37.736	2	\N	1
15	2025-06-30 07:26:48.102	2	\N	1
16	2025-06-30 07:26:49.55	2	\N	1
17	2025-06-30 07:35:55.615	2	\N	1
18	2025-06-30 07:35:57.296	2	2025-06-30 07:39:45.243	1
19	2025-06-30 07:43:53.373	2	\N	1
20	2025-06-30 07:43:54.944	2	2025-06-30 07:45:39.463	1
21	2025-06-30 07:45:58.269	3	2025-06-30 07:47:09.022	2
22	2025-06-30 08:07:19.649	2	\N	1
23	2025-06-30 08:07:21.606	2	2025-06-30 08:08:49.034	1
24	2025-06-30 08:12:51.238	2	\N	1
25	2025-06-30 08:12:53.682	2	2025-06-30 08:22:10.215	1
26	2025-06-30 08:22:15.512	3	\N	2
27	2025-07-02 09:18:13.46	2	\N	1
28	2025-07-02 09:18:15.917	2	2025-07-02 09:32:09.056	1
29	2025-07-02 09:32:12.294	3	2025-07-02 09:38:28.437	2
30	2025-07-02 09:38:32.43	2	\N	1
31	2025-07-02 09:38:33.736	2	2025-07-02 09:38:53.81	1
32	2025-07-02 09:38:57.116	3	\N	2
33	2025-07-02 09:46:03.261	3	2025-07-02 09:52:30.837	2
34	2025-07-02 09:52:34.333	2	\N	1
35	2025-07-02 09:52:36.417	2	2025-07-02 09:52:48.196	1
36	2025-07-02 09:52:51.473	3	\N	2
37	2025-07-02 10:23:13.707	3	\N	2
38	2025-07-02 10:28:10.475	3	\N	2
39	2025-07-02 10:31:42.534	3	\N	2
40	2025-07-02 10:38:49.053	3	2025-07-02 10:43:44.847	2
41	2025-07-02 10:43:48.151	2	\N	1
42	2025-07-02 10:43:49.324	2	2025-07-02 10:44:08.028	1
43	2025-07-02 10:44:12.291	3	\N	2
44	2025-07-02 10:49:35.732	3	2025-07-02 10:49:47.064	2
45	2025-07-02 10:51:49.675	4	2025-07-02 11:17:15.792	2
46	2025-07-02 11:17:19.749	4	2025-07-02 11:17:24.908	2
47	2025-07-02 11:18:23.868	2	\N	1
48	2025-07-02 11:18:26.427	2	2025-07-02 11:18:29.979	1
49	2025-07-02 11:18:34.044	2	\N	1
50	2025-07-02 11:18:34.898	2	2025-07-02 11:20:32.456	1
51	2025-07-02 11:26:08.222	5	2025-07-02 11:26:11.192	2
52	2025-07-02 11:29:13.672	5	2025-07-02 11:29:15.708	2
53	2025-07-02 11:30:56.132	5	2025-07-02 11:30:58.065	2
54	2025-07-02 11:31:01.751	5	2025-07-02 11:31:04.217	2
55	2025-07-02 11:35:58.835	6	\N	1
56	2025-07-02 11:36:02.633	6	2025-07-02 11:36:04.943	1
57	2025-07-02 11:36:08.57	6	\N	1
58	2025-07-02 11:36:09.333	6	2025-07-02 11:36:11.53	1
59	2025-07-02 11:36:16.049	5	2025-07-02 11:36:29.268	2
60	2025-07-02 11:36:32.955	6	\N	1
61	2025-07-02 11:36:33.995	6	2025-07-02 11:36:50.514	1
62	2025-07-02 11:36:53.788	2	\N	1
63	2025-07-02 11:36:54.602	2	2025-07-02 11:39:49.255	1
64	2025-07-02 11:40:30.631	7	2025-07-02 11:40:33.876	2
65	2025-07-02 11:41:53.037	7	2025-07-02 11:41:58.819	2
66	2025-07-02 11:42:08.476	5	2025-07-02 11:42:10.797	2
67	2025-07-02 11:42:14.252	6	\N	1
68	2025-07-02 11:42:18.006	6	2025-07-02 11:44:03.646	1
69	2025-07-02 11:44:08.43	5	2025-07-02 11:46:06.29	2
70	2025-07-02 11:47:42.841	5	2025-07-02 11:48:07.691	2
71	2025-07-02 11:52:15.835	6	\N	1
72	2025-07-02 11:52:18.374	6	2025-07-02 11:53:16.585	1
73	2025-07-02 11:53:22.551	5	2025-07-02 11:54:54.775	2
74	2025-07-07 00:08:04.574	6	\N	1
75	2025-07-07 00:09:07.111	6	2025-07-07 00:09:08.9	1
76	2025-07-07 00:10:49.501	6	\N	1
77	2025-07-07 00:10:50.976	6	2025-07-07 00:25:30.347	1
78	2025-07-07 00:25:46.043	7	2025-07-07 00:25:51.461	2
79	2025-07-07 00:25:59.668	7	2025-07-07 00:33:42.651	2
80	2025-07-07 00:33:54.721	7	2025-07-07 00:34:10.786	2
81	2025-07-07 00:35:29.919	7	2025-07-07 00:36:39.485	2
82	2025-07-07 00:36:47.166	6	\N	1
83	2025-07-07 00:36:48.131	6	\N	1
84	2025-07-09 09:51:44.698	6	\N	1
85	2025-07-09 09:51:48.199	6	\N	1
86	2025-07-09 10:14:53.642	6	\N	1
87	2025-07-09 10:14:54.89	6	\N	1
88	2025-07-09 10:24:35.727	6	\N	1
89	2025-07-09 10:24:37.092	6	\N	1
90	2025-07-09 10:27:58.902	6	\N	1
91	2025-07-09 10:27:59.906	6	\N	1
92	2025-07-09 10:33:59.3	6	\N	1
93	2025-07-09 10:34:00.8	6	\N	1
94	2025-07-09 10:38:14.096	6	\N	1
95	2025-07-09 10:38:15.145	6	\N	1
96	2025-07-09 10:40:34.554	6	\N	1
97	2025-07-09 10:40:35.661	6	\N	1
98	2025-07-09 10:53:56.738	6	\N	1
99	2025-07-09 10:53:57.977	6	\N	1
100	2025-07-09 10:57:40.335	6	\N	1
101	2025-07-09 10:57:41.82	6	\N	1
102	2025-07-09 11:09:34.51	6	\N	1
103	2025-07-09 11:09:37.165	6	2025-07-09 11:45:11.925	1
104	2025-07-09 11:45:14.794	5	2025-07-09 11:54:21.195	2
105	2025-07-09 11:54:30.532	6	\N	1
106	2025-07-09 11:54:36.122	6	2025-07-09 11:55:00.484	1
107	2025-07-09 11:55:07.155	6	\N	1
108	2025-07-09 11:55:36.392	6	\N	1
109	2025-07-14 11:14:18.239	6	\N	1
110	2025-07-14 11:14:19.869	6	\N	1
111	2025-07-14 11:20:00.293	6	\N	1
112	2025-07-14 11:20:01.917	6	2025-07-14 11:20:19.083	1
113	2025-07-14 11:20:27.855	5	\N	2
114	2025-07-14 19:18:23.015	6	\N	1
115	2025-07-14 19:18:24.33	6	\N	1
116	2025-07-14 19:43:52.535	6	\N	1
117	2025-07-14 19:43:54.138	6	\N	1
118	2025-07-14 20:01:53.658	6	\N	1
119	2025-07-14 20:01:55.321	6	\N	1
120	2025-07-14 20:54:39.408	6	\N	1
121	2025-07-14 20:54:40.558	6	\N	1
122	2025-07-14 21:02:29.674	6	\N	1
123	2025-07-14 21:02:31.34	6	\N	1
124	2025-07-14 21:10:08.139	6	\N	1
125	2025-07-14 21:10:09.517	6	\N	1
126	2025-07-14 21:19:29.439	6	\N	1
127	2025-07-14 21:19:31.106	6	2025-07-14 21:30:32.171	1
128	2025-07-14 21:30:35.153	5	2025-07-14 21:30:59.199	2
129	2025-07-14 21:31:03.338	6	\N	1
130	2025-07-14 21:31:04.236	6	2025-07-14 21:31:15.042	1
131	2025-07-14 21:31:20.89	5	2025-07-14 21:31:34.271	2
132	2025-07-14 21:31:39.38	6	\N	1
133	2025-07-14 21:31:41.422	6	2025-07-14 21:31:49.123	1
134	2025-07-14 21:31:53.144	5	2025-07-14 21:32:10.749	2
135	2025-07-14 21:32:15.641	6	\N	1
136	2025-07-14 21:32:16.482	6	\N	1
137	2025-07-14 22:15:55.266	5	\N	2
138	2025-07-14 22:31:38.296	5	\N	2
\.


--
-- TOC entry 4996 (class 0 OID 25844)
-- Dependencies: 234
-- Data for Name: tpac; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tpac (tpac__id, tpactpac) FROM stdin;
2	Guantes
3	Chaqueta
4	Moto
5	Botas
\.


--
-- TOC entry 4998 (class 0 OID 25851)
-- Dependencies: 236
-- Data for Name: tppr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tppr (tppr__id, tpprdtcr, tpprdtup, tpprdscr) FROM stdin;
1	2025-06-29 22:51:04.210496	2025-06-29 22:51:04.210496	Administrador
2	2025-06-29 23:03:08.640078	2025-06-29 23:03:08.640078	Cliente
\.


--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 217
-- Name: artc_artc__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artc_artc__id_seq', 9, true);


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 219
-- Name: dtft_dtft__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dtft_dtft__id_seq', 15, true);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 221
-- Name: dtpd_dtpd__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dtpd_dtpd__id_seq', 15, true);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 223
-- Name: fact_fact__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_fact__id_seq', 12, true);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 225
-- Name: pedd_pedd__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedd_pedd__id_seq', 12, true);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 227
-- Name: prfl_prfl__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prfl_prfl__id_seq', 1, false);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 229
-- Name: prsn_prsn__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prsn_prsn__id_seq', 7, true);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 231
-- Name: sesn_sesn__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sesn_sesn__id_seq', 138, true);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 233
-- Name: tpac_tpac__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tpac_tpac__id_seq', 5, true);


--
-- TOC entry 5023 (class 0 OID 0)
-- Dependencies: 235
-- Name: tppr_tppr__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tppr_tppr__id_seq', 1, false);


--
-- TOC entry 4799 (class 2606 OID 25789)
-- Name: artc artc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artc
    ADD CONSTRAINT artc_pkey PRIMARY KEY (artc__id);


--
-- TOC entry 4801 (class 2606 OID 25796)
-- Name: dtft dtft_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft
    ADD CONSTRAINT dtft_pkey PRIMARY KEY (dtft__id);


--
-- TOC entry 4803 (class 2606 OID 25803)
-- Name: dtpd dtpd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd
    ADD CONSTRAINT dtpd_pkey PRIMARY KEY (dtpd__id);


--
-- TOC entry 4805 (class 2606 OID 25810)
-- Name: fact fact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact
    ADD CONSTRAINT fact_pkey PRIMARY KEY (fact__id);


--
-- TOC entry 4809 (class 2606 OID 25817)
-- Name: pedd pedd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedd
    ADD CONSTRAINT pedd_pkey PRIMARY KEY (pedd__id);


--
-- TOC entry 4811 (class 2606 OID 25826)
-- Name: prfl prfl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prfl
    ADD CONSTRAINT prfl_pkey PRIMARY KEY (prfl__id);


--
-- TOC entry 4813 (class 2606 OID 25835)
-- Name: prsn prsn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT prsn_pkey PRIMARY KEY (prsn__id);


--
-- TOC entry 4817 (class 2606 OID 25842)
-- Name: sesn sesn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn
    ADD CONSTRAINT sesn_pkey PRIMARY KEY (sesn__id);


--
-- TOC entry 4819 (class 2606 OID 25849)
-- Name: tpac tpac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tpac
    ADD CONSTRAINT tpac_pkey PRIMARY KEY (tpac__id);


--
-- TOC entry 4821 (class 2606 OID 25856)
-- Name: tppr tppr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tppr
    ADD CONSTRAINT tppr_pkey PRIMARY KEY (tppr__id);


--
-- TOC entry 4815 (class 2606 OID 25860)
-- Name: prsn uk_jx1yj3rkdawlxgc51ikt2tlwx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT uk_jx1yj3rkdawlxgc51ikt2tlwx UNIQUE (prsnlogn);


--
-- TOC entry 4807 (class 2606 OID 25858)
-- Name: fact uk_nlari9wvonx37gsfi42ajr3hq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact
    ADD CONSTRAINT uk_nlari9wvonx37gsfi42ajr3hq UNIQUE (pedd__id);


--
-- TOC entry 4825 (class 2606 OID 25881)
-- Name: dtpd fk1si6l3iiapfrbv2ia6cdn4ftr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd
    ADD CONSTRAINT fk1si6l3iiapfrbv2ia6cdn4ftr FOREIGN KEY (artc__id) REFERENCES public.artc(artc__id);


--
-- TOC entry 4830 (class 2606 OID 25906)
-- Name: prsn fk6qilpga99l5yw3dqjsy5or9uo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT fk6qilpga99l5yw3dqjsy5or9uo FOREIGN KEY (prfl__id) REFERENCES public.prfl(prfl__id);


--
-- TOC entry 4829 (class 2606 OID 25896)
-- Name: prfl fka5u4qmvg8v5dxmywu1hi9hxv1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prfl
    ADD CONSTRAINT fka5u4qmvg8v5dxmywu1hi9hxv1 FOREIGN KEY (prflpdre) REFERENCES public.prfl(prfl__id);


--
-- TOC entry 4831 (class 2606 OID 25901)
-- Name: prsn fkd295t7k9f6tlkmt1drvv0nxhs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT fkd295t7k9f6tlkmt1drvv0nxhs FOREIGN KEY (tppr__id) REFERENCES public.tppr(tppr__id);


--
-- TOC entry 4826 (class 2606 OID 25876)
-- Name: dtpd fke65aeg86xoxoj9ayu0tyle8v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd
    ADD CONSTRAINT fke65aeg86xoxoj9ayu0tyle8v FOREIGN KEY (pedd__id) REFERENCES public.pedd(pedd__id);


--
-- TOC entry 4827 (class 2606 OID 25886)
-- Name: fact fkfh1jug5dxpqt8gmvt1ydvq3v4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact
    ADD CONSTRAINT fkfh1jug5dxpqt8gmvt1ydvq3v4 FOREIGN KEY (pedd__id) REFERENCES public.pedd(pedd__id);


--
-- TOC entry 4823 (class 2606 OID 25866)
-- Name: dtft fkg61to9va1x5fpk4ilaijhpuwm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft
    ADD CONSTRAINT fkg61to9va1x5fpk4ilaijhpuwm FOREIGN KEY (fact__id) REFERENCES public.fact(fact__id);


--
-- TOC entry 4828 (class 2606 OID 25891)
-- Name: pedd fkjw4tl2opl5qugypn1ksr535ib; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedd
    ADD CONSTRAINT fkjw4tl2opl5qugypn1ksr535ib FOREIGN KEY (prsn__id) REFERENCES public.prsn(prsn__id);


--
-- TOC entry 4832 (class 2606 OID 25911)
-- Name: sesn fkk603twyrgl2rsyyy3woa88rpd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn
    ADD CONSTRAINT fkk603twyrgl2rsyyy3woa88rpd FOREIGN KEY (prsn__id) REFERENCES public.prsn(prsn__id);


--
-- TOC entry 4822 (class 2606 OID 25861)
-- Name: artc fklape2djy1xoca2q5xw9xcausk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artc
    ADD CONSTRAINT fklape2djy1xoca2q5xw9xcausk FOREIGN KEY (tpac__id) REFERENCES public.tpac(tpac__id);


--
-- TOC entry 4824 (class 2606 OID 25871)
-- Name: dtft fks6j0ykomgi38804y5ppanw45e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft
    ADD CONSTRAINT fks6j0ykomgi38804y5ppanw45e FOREIGN KEY (artc__id) REFERENCES public.artc(artc__id);


--
-- TOC entry 4833 (class 2606 OID 25916)
-- Name: sesn fktmpbdqc42dilrcw2dr4k2j1o6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn
    ADD CONSTRAINT fktmpbdqc42dilrcw2dr4k2j1o6 FOREIGN KEY (prfl__id) REFERENCES public.prfl(prfl__id);


-- Completed on 2025-07-15 01:20:20

--
-- PostgreSQL database dump complete
--

