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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: artc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artc (
    artc__id bigint NOT NULL,
    artcimgn character varying(100),
    artcprbs numeric(19,2) NOT NULL,
    tpac__id bigint NOT NULL,
    artcdscr text,
    artcnmbr character varying(100) NOT NULL,
    artcstock integer DEFAULT 0
);


ALTER TABLE public.artc OWNER TO postgres;

--
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
-- Name: artc_artc__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.artc_artc__id_seq OWNED BY public.artc.artc__id;


--
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
-- Name: dtft_dtft__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dtft_dtft__id_seq OWNED BY public.dtft.dtft__id;


--
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
-- Name: dtpd_dtpd__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dtpd_dtpd__id_seq OWNED BY public.dtpd.dtpd__id;


--
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
-- Name: fact_fact__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fact_fact__id_seq OWNED BY public.fact.fact__id;


--
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
-- Name: pedd_pedd__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pedd_pedd__id_seq OWNED BY public.pedd.pedd__id;


--
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
-- Name: prfl_prfl__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prfl_prfl__id_seq OWNED BY public.prfl.prfl__id;


--
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
-- Name: prsn_prsn__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prsn_prsn__id_seq OWNED BY public.prsn.prsn__id;


--
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
-- Name: sesn_sesn__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sesn_sesn__id_seq OWNED BY public.sesn.sesn__id;


--
-- Name: tpac; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tpac (
    tpac__id bigint NOT NULL,
    tpactpac character varying(50) NOT NULL
);


ALTER TABLE public.tpac OWNER TO postgres;

--
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
-- Name: tpac_tpac__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tpac_tpac__id_seq OWNED BY public.tpac.tpac__id;


--
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
-- Name: tppr_tppr__id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tppr_tppr__id_seq OWNED BY public.tppr.tppr__id;


--
-- Name: artc artc__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artc ALTER COLUMN artc__id SET DEFAULT nextval('public.artc_artc__id_seq'::regclass);


--
-- Name: dtft dtft__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft ALTER COLUMN dtft__id SET DEFAULT nextval('public.dtft_dtft__id_seq'::regclass);


--
-- Name: dtpd dtpd__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd ALTER COLUMN dtpd__id SET DEFAULT nextval('public.dtpd_dtpd__id_seq'::regclass);


--
-- Name: fact fact__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact ALTER COLUMN fact__id SET DEFAULT nextval('public.fact_fact__id_seq'::regclass);


--
-- Name: pedd pedd__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedd ALTER COLUMN pedd__id SET DEFAULT nextval('public.pedd_pedd__id_seq'::regclass);


--
-- Name: prfl prfl__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prfl ALTER COLUMN prfl__id SET DEFAULT nextval('public.prfl_prfl__id_seq'::regclass);


--
-- Name: prsn prsn__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn ALTER COLUMN prsn__id SET DEFAULT nextval('public.prsn_prsn__id_seq'::regclass);


--
-- Name: sesn sesn__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn ALTER COLUMN sesn__id SET DEFAULT nextval('public.sesn_sesn__id_seq'::regclass);


--
-- Name: tpac tpac__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tpac ALTER COLUMN tpac__id SET DEFAULT nextval('public.tpac_tpac__id_seq'::regclass);


--
-- Name: tppr tppr__id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tppr ALTER COLUMN tppr__id SET DEFAULT nextval('public.tppr_tppr__id_seq'::regclass);


--
-- Name: artc artc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artc
    ADD CONSTRAINT artc_pkey PRIMARY KEY (artc__id);


--
-- Name: dtft dtft_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft
    ADD CONSTRAINT dtft_pkey PRIMARY KEY (dtft__id);


--
-- Name: dtpd dtpd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd
    ADD CONSTRAINT dtpd_pkey PRIMARY KEY (dtpd__id);


--
-- Name: fact fact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact
    ADD CONSTRAINT fact_pkey PRIMARY KEY (fact__id);


--
-- Name: pedd pedd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedd
    ADD CONSTRAINT pedd_pkey PRIMARY KEY (pedd__id);


--
-- Name: prfl prfl_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prfl
    ADD CONSTRAINT prfl_pkey PRIMARY KEY (prfl__id);


--
-- Name: prsn prsn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT prsn_pkey PRIMARY KEY (prsn__id);


--
-- Name: sesn sesn_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn
    ADD CONSTRAINT sesn_pkey PRIMARY KEY (sesn__id);


--
-- Name: tpac tpac_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tpac
    ADD CONSTRAINT tpac_pkey PRIMARY KEY (tpac__id);


--
-- Name: tppr tppr_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tppr
    ADD CONSTRAINT tppr_pkey PRIMARY KEY (tppr__id);


--
-- Name: prsn uk_jx1yj3rkdawlxgc51ikt2tlwx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT uk_jx1yj3rkdawlxgc51ikt2tlwx UNIQUE (prsnlogn);


--
-- Name: fact uk_nlari9wvonx37gsfi42ajr3hq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact
    ADD CONSTRAINT uk_nlari9wvonx37gsfi42ajr3hq UNIQUE (pedd__id);


--
-- Name: dtpd fk1si6l3iiapfrbv2ia6cdn4ftr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd
    ADD CONSTRAINT fk1si6l3iiapfrbv2ia6cdn4ftr FOREIGN KEY (artc__id) REFERENCES public.artc(artc__id);


--
-- Name: prsn fk6qilpga99l5yw3dqjsy5or9uo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT fk6qilpga99l5yw3dqjsy5or9uo FOREIGN KEY (prfl__id) REFERENCES public.prfl(prfl__id);


--
-- Name: prfl fka5u4qmvg8v5dxmywu1hi9hxv1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prfl
    ADD CONSTRAINT fka5u4qmvg8v5dxmywu1hi9hxv1 FOREIGN KEY (prflpdre) REFERENCES public.prfl(prfl__id);


--
-- Name: prsn fkd295t7k9f6tlkmt1drvv0nxhs; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prsn
    ADD CONSTRAINT fkd295t7k9f6tlkmt1drvv0nxhs FOREIGN KEY (tppr__id) REFERENCES public.tppr(tppr__id);


--
-- Name: dtpd fke65aeg86xoxoj9ayu0tyle8v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtpd
    ADD CONSTRAINT fke65aeg86xoxoj9ayu0tyle8v FOREIGN KEY (pedd__id) REFERENCES public.pedd(pedd__id);


--
-- Name: fact fkfh1jug5dxpqt8gmvt1ydvq3v4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fact
    ADD CONSTRAINT fkfh1jug5dxpqt8gmvt1ydvq3v4 FOREIGN KEY (pedd__id) REFERENCES public.pedd(pedd__id);


--
-- Name: dtft fkg61to9va1x5fpk4ilaijhpuwm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft
    ADD CONSTRAINT fkg61to9va1x5fpk4ilaijhpuwm FOREIGN KEY (fact__id) REFERENCES public.fact(fact__id);


--
-- Name: pedd fkjw4tl2opl5qugypn1ksr535ib; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pedd
    ADD CONSTRAINT fkjw4tl2opl5qugypn1ksr535ib FOREIGN KEY (prsn__id) REFERENCES public.prsn(prsn__id);


--
-- Name: sesn fkk603twyrgl2rsyyy3woa88rpd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn
    ADD CONSTRAINT fkk603twyrgl2rsyyy3woa88rpd FOREIGN KEY (prsn__id) REFERENCES public.prsn(prsn__id);


--
-- Name: artc fklape2djy1xoca2q5xw9xcausk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artc
    ADD CONSTRAINT fklape2djy1xoca2q5xw9xcausk FOREIGN KEY (tpac__id) REFERENCES public.tpac(tpac__id);


--
-- Name: dtft fks6j0ykomgi38804y5ppanw45e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dtft
    ADD CONSTRAINT fks6j0ykomgi38804y5ppanw45e FOREIGN KEY (artc__id) REFERENCES public.artc(artc__id);


--
-- Name: sesn fktmpbdqc42dilrcw2dr4k2j1o6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sesn
    ADD CONSTRAINT fktmpbdqc42dilrcw2dr4k2j1o6 FOREIGN KEY (prfl__id) REFERENCES public.prfl(prfl__id);


--
-- PostgreSQL database dump complete
--

