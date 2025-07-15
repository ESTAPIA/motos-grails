--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Data for Name: tpac; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tpac (tpac__id, tpactpac) FROM stdin;
2	Guantes
3	Chaqueta
4	Moto
5	Botas
\.


--
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
-- Data for Name: prfl; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prfl (prfl__id, prflpdre, prflcdgo, prfldscr, prflobsr, prflnmbr) FROM stdin;
1	\N	ADM	Perfil de administrador	\N	Admin
2	\N	CLI	Perfil de cliente	\N	Cliente
\.


--
-- Data for Name: tppr; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tppr (tppr__id, tpprdtcr, tpprdtup, tpprdscr) FROM stdin;
1	2025-06-29 22:51:04.210496	2025-06-29 22:51:04.210496	Administrador
2	2025-06-29 23:03:08.640078	2025-06-29 23:03:08.640078	Cliente
\.


--
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
-- Name: artc_artc__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.artc_artc__id_seq', 9, true);


--
-- Name: dtft_dtft__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dtft_dtft__id_seq', 15, true);


--
-- Name: dtpd_dtpd__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dtpd_dtpd__id_seq', 15, true);


--
-- Name: fact_fact__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fact_fact__id_seq', 12, true);


--
-- Name: pedd_pedd__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pedd_pedd__id_seq', 12, true);


--
-- Name: prfl_prfl__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prfl_prfl__id_seq', 1, false);


--
-- Name: prsn_prsn__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prsn_prsn__id_seq', 7, true);


--
-- Name: sesn_sesn__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sesn_sesn__id_seq', 138, true);


--
-- Name: tpac_tpac__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tpac_tpac__id_seq', 5, true);


--
-- Name: tppr_tppr__id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tppr_tppr__id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

