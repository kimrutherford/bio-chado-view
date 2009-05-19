--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.tissue DROP CONSTRAINT tissue_type_fkey;
ALTER TABLE ONLY public.tissue DROP CONSTRAINT tissue_organism_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_type_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_centre_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_quality_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_multiplexing_type_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_initial_pipeprocess_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_initial_pipedata_fkey;
ALTER TABLE ONLY public.samplerun DROP CONSTRAINT samplerun_sequencingrun_fkey;
ALTER TABLE ONLY public.samplerun DROP CONSTRAINT samplerun_samplerun_type_fkey;
ALTER TABLE ONLY public.samplerun DROP CONSTRAINT samplerun_sample_fkey;
ALTER TABLE ONLY public.samplerun DROP CONSTRAINT samplerun_barcode_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_treatment_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_tissue_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_pipeproject_fkey;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_sample_fkey;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_pipedata_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_molecule_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_genotype_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_fractionation_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_ecotype_fkey;
ALTER TABLE ONLY public.process_conf DROP CONSTRAINT process_conf_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_process_conf_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_format_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_content_type_fkey;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_type_fkey;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_owner_fkey;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_funder_fkey;
ALTER TABLE ONLY public.pipeprocess DROP CONSTRAINT pipeprocess_status_fkey;
ALTER TABLE ONLY public.pipeprocess DROP CONSTRAINT pipeprocess_process_conf_fkey;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pipedata_pipeprocess_fkey;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pipedata_pipedata_fkey;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_generating_pipeprocess_fkey;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_format_type_fkey;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_content_type_fkey;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_organisation_fkey;
ALTER TABLE ONLY public.genotype DROP CONSTRAINT genotype_type_fkey;
ALTER TABLE ONLY public.genotype DROP CONSTRAINT genotype_organism_fkey;
ALTER TABLE ONLY public.ecotype DROP CONSTRAINT ecotype_organism_fkey;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_cv_id_fkey;
ALTER TABLE ONLY public.tissue DROP CONSTRAINT tissue_id_pk;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_identifier_key;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_id_pk;
ALTER TABLE ONLY public.samplerun DROP CONSTRAINT samplerun_id_pk;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_id_pk;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_name_key;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_id_pk;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_id_pk;
ALTER TABLE ONLY public.process_conf DROP CONSTRAINT process_conf_id_pk;
ALTER TABLE ONLY public.pipeproject DROP CONSTRAINT pipeproject_id_pk;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pk_constraint;
ALTER TABLE ONLY public.pipeprocess_in_pipedata DROP CONSTRAINT pipeprocess_in_pipedata_id_pk;
ALTER TABLE ONLY public.pipeprocess DROP CONSTRAINT pipeprocess_id_pk;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_id_pk;
ALTER TABLE ONLY public.pipedata DROP CONSTRAINT pipedata_file_name_key;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_user_name_key;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_id_pk;
ALTER TABLE ONLY public.person DROP CONSTRAINT person_full_name_constraint;
ALTER TABLE ONLY public.organism DROP CONSTRAINT organism_id_pk;
ALTER TABLE ONLY public.organisation DROP CONSTRAINT organisation_id_pk;
ALTER TABLE ONLY public.genotype DROP CONSTRAINT genotype_id_pk;
ALTER TABLE ONLY public.ecotype DROP CONSTRAINT ecotype_id_pk;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_pkey;
ALTER TABLE ONLY public.cv DROP CONSTRAINT cv_pkey;
ALTER TABLE ONLY public.cv DROP CONSTRAINT cv_c1;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_identifier_key;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_code_key;
ALTER TABLE public.tissue ALTER COLUMN tissue_id DROP DEFAULT;
ALTER TABLE public.sequencingrun ALTER COLUMN sequencingrun_id DROP DEFAULT;
ALTER TABLE public.samplerun ALTER COLUMN samplerun_id DROP DEFAULT;
ALTER TABLE public.sample_pipedata ALTER COLUMN sample_pipedata_id DROP DEFAULT;
ALTER TABLE public.sample ALTER COLUMN sample_id DROP DEFAULT;
ALTER TABLE public.process_conf_input ALTER COLUMN process_conf_input_id DROP DEFAULT;
ALTER TABLE public.process_conf ALTER COLUMN process_conf_id DROP DEFAULT;
ALTER TABLE public.pipeproject ALTER COLUMN pipeproject_id DROP DEFAULT;
ALTER TABLE public.pipeprocess_in_pipedata ALTER COLUMN pipeprocess_in_pipedata_id DROP DEFAULT;
ALTER TABLE public.pipeprocess ALTER COLUMN pipeprocess_id DROP DEFAULT;
ALTER TABLE public.pipedata ALTER COLUMN pipedata_id DROP DEFAULT;
ALTER TABLE public.person ALTER COLUMN person_id DROP DEFAULT;
ALTER TABLE public.organism ALTER COLUMN organism_id DROP DEFAULT;
ALTER TABLE public.organisation ALTER COLUMN organisation_id DROP DEFAULT;
ALTER TABLE public.genotype ALTER COLUMN genotype_id DROP DEFAULT;
ALTER TABLE public.ecotype ALTER COLUMN ecotype_id DROP DEFAULT;
ALTER TABLE public.barcode ALTER COLUMN barcode_id DROP DEFAULT;
DROP SEQUENCE public.tissue_tissue_id_seq;
DROP SEQUENCE public.sequencingrun_sequencingrun_id_seq;
DROP SEQUENCE public.samplerun_samplerun_id_seq;
DROP SEQUENCE public.sample_sample_id_seq;
DROP SEQUENCE public.sample_pipedata_sample_pipedata_id_seq;
DROP SEQUENCE public.process_conf_process_conf_id_seq;
DROP SEQUENCE public.process_conf_input_process_conf_input_id_seq;
DROP SEQUENCE public.pipeproject_pipeproject_id_seq;
DROP SEQUENCE public.pipeprocess_pipeprocess_id_seq;
DROP SEQUENCE public.pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq;
DROP SEQUENCE public.pipedata_pipedata_id_seq;
DROP SEQUENCE public.person_person_id_seq;
DROP SEQUENCE public.organism_organism_id_seq;
DROP SEQUENCE public.organisation_organisation_id_seq;
DROP SEQUENCE public.genotype_genotype_id_seq;
DROP SEQUENCE public.ecotype_ecotype_id_seq;
DROP SEQUENCE public.barcode_barcode_id_seq;
DROP FUNCTION public.bioseg_sel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint);
DROP FUNCTION public.bioseg_gist_picksplit(internal, internal);
DROP FUNCTION public.bioseg_gist_penalty(internal, internal, internal);
DROP FUNCTION public.bioseg_gist_decompress(internal);
DROP FUNCTION public.bioseg_gist_compress(internal);
DROP FUNCTION public.bioseg_contsel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_contjoinsel(internal, oid, internal, smallint);
DROP TABLE public.tissue;
DROP TABLE public.sequencingrun;
DROP TABLE public.samplerun;
DROP TABLE public.sample_pipedata;
DROP TABLE public.sample;
DROP TABLE public.process_conf_input;
DROP TABLE public.process_conf;
DROP TABLE public.pipeproject;
DROP TABLE public.pipeprocess_in_pipedata;
DROP TABLE public.pipeprocess;
DROP TABLE public.pipedata;
DROP TABLE public.person;
DROP TABLE public.organism;
DROP TABLE public.organisation;
DROP TABLE public.genotype;
DROP TABLE public.ecotype;
DROP TABLE public.cvterm;
DROP SEQUENCE public.cvterm_cvterm_id_seq;
DROP TABLE public.cv;
DROP SEQUENCE public.cv_cv_id_seq;
DROP TABLE public.barcode;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: barcode; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE barcode (
    barcode_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    identifier text NOT NULL,
    code text NOT NULL
);


ALTER TABLE public.barcode OWNER TO kmr44;

--
-- Name: cv_cv_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE cv_cv_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cv_cv_id_seq OWNER TO kmr44;

--
-- Name: cv_cv_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('cv_cv_id_seq', 12, true);


--
-- Name: cv; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE cv (
    cv_id integer DEFAULT nextval('cv_cv_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    definition text
);


ALTER TABLE public.cv OWNER TO kmr44;

--
-- Name: cvterm_cvterm_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE cvterm_cvterm_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.cvterm_cvterm_id_seq OWNER TO kmr44;

--
-- Name: cvterm_cvterm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('cvterm_cvterm_id_seq', 52, true);


--
-- Name: cvterm; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE cvterm (
    cvterm_id integer DEFAULT nextval('cvterm_cvterm_id_seq'::regclass) NOT NULL,
    cv_id integer NOT NULL,
    name character varying(1024) NOT NULL,
    definition text,
    dbxref_id integer,
    is_obsolete integer DEFAULT 0 NOT NULL,
    is_relationshiptype integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.cvterm OWNER TO kmr44;

--
-- Name: ecotype; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE ecotype (
    ecotype_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    organism integer NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.ecotype OWNER TO kmr44;

--
-- Name: genotype; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE genotype (
    genotype_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    organism integer NOT NULL,
    type integer NOT NULL,
    description text,
    CONSTRAINT genotype_check CHECK ((((description IS NULL) AND (type IS NOT NULL)) OR ((description IS NOT NULL) AND (type IS NULL))))
);


ALTER TABLE public.genotype OWNER TO kmr44;

--
-- Name: organisation; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE organisation (
    organisation_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    description text
);


ALTER TABLE public.organisation OWNER TO kmr44;

--
-- Name: organism; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE organism (
    organism_id integer NOT NULL,
    abbreviation character varying(255),
    genus character varying(255) NOT NULL,
    species character varying(255) NOT NULL,
    common_name character varying(255),
    comment text
);


ALTER TABLE public.organism OWNER TO kmr44;

--
-- Name: person; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE person (
    person_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    user_name text NOT NULL,
    password text,
    organisation integer NOT NULL
);


ALTER TABLE public.person OWNER TO kmr44;

--
-- Name: pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipedata (
    pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    format_type integer NOT NULL,
    content_type integer NOT NULL,
    file_name text NOT NULL,
    generating_pipeprocess integer NOT NULL
);


ALTER TABLE public.pipedata OWNER TO kmr44;

--
-- Name: pipeprocess; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeprocess (
    pipeprocess_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    description text NOT NULL,
    process_conf integer NOT NULL,
    status integer NOT NULL,
    job_identifier text,
    time_queued timestamp without time zone,
    time_started timestamp without time zone,
    time_finished timestamp without time zone
);


ALTER TABLE public.pipeprocess OWNER TO kmr44;

--
-- Name: pipeprocess_in_pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeprocess_in_pipedata (
    pipeprocess_in_pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    pipeprocess integer,
    pipedata integer
);


ALTER TABLE public.pipeprocess_in_pipedata OWNER TO kmr44;

--
-- Name: TABLE pipeprocess_in_pipedata; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE pipeprocess_in_pipedata IS 'Join table containing the input pipedatas for a pipeprocess';


--
-- Name: pipeproject; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE pipeproject (
    pipeproject_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    type integer NOT NULL,
    owner integer NOT NULL,
    funder integer
);


ALTER TABLE public.pipeproject OWNER TO kmr44;

--
-- Name: process_conf; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE process_conf (
    process_conf_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    runable_name text,
    detail text,
    type integer NOT NULL
);


ALTER TABLE public.process_conf OWNER TO kmr44;

--
-- Name: process_conf_input; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE process_conf_input (
    process_conf_input_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    process_conf integer NOT NULL,
    format_type integer NOT NULL,
    content_type integer NOT NULL
);


ALTER TABLE public.process_conf_input OWNER TO kmr44;

--
-- Name: sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample (
    sample_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    name text NOT NULL,
    pipeproject integer NOT NULL,
    ecotype integer NOT NULL,
    genotype integer,
    description text,
    protocol text,
    molecule_type integer NOT NULL,
    treatment_type integer,
    fractionation_type integer,
    tissue integer
);


ALTER TABLE public.sample OWNER TO kmr44;

--
-- Name: sample_pipedata; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample_pipedata (
    sample_pipedata_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    sample integer NOT NULL,
    pipedata integer NOT NULL
);


ALTER TABLE public.sample_pipedata OWNER TO kmr44;

--
-- Name: samplerun; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE samplerun (
    samplerun_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    description text NOT NULL,
    samplerun_type integer NOT NULL,
    sample integer NOT NULL,
    barcode integer,
    sequencingrun integer NOT NULL
);


ALTER TABLE public.samplerun OWNER TO kmr44;

--
-- Name: TABLE samplerun; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE samplerun IS 'This table records the many-to-many relationship between samples and sequencing runs and the type of the run (intial, re-run, replicate etc.)';


--
-- Name: sequencingrun; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencingrun (
    sequencingrun_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    identifier text NOT NULL,
    initial_pipedata integer,
    sequencing_centre integer NOT NULL,
    initial_pipeprocess integer,
    submission_date date,
    run_date date,
    data_received_date date,
    quality integer NOT NULL,
    sequencing_type integer NOT NULL,
    multiplexing_type integer NOT NULL,
    CONSTRAINT sequencingrun_check CHECK (CASE WHEN (run_date IS NULL) THEN (data_received_date IS NULL) ELSE true END)
);


ALTER TABLE public.sequencingrun OWNER TO kmr44;

--
-- Name: tissue; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE tissue (
    tissue_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    organism integer NOT NULL,
    type integer,
    description text,
    CONSTRAINT tissue_check CHECK ((((description IS NULL) AND (type IS NOT NULL)) OR ((description IS NOT NULL) AND (type IS NULL))))
);


ALTER TABLE public.tissue OWNER TO kmr44;

--
-- Name: bioseg_contjoinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contjoinsel(internal, oid, internal, smallint) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_contjoinsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contjoinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: bioseg_contsel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contsel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_contsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contsel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: bioseg_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_compress(internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_compress(internal) OWNER TO postgres;

--
-- Name: bioseg_gist_decompress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_decompress(internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_decompress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_decompress(internal) OWNER TO postgres;

--
-- Name: bioseg_gist_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_penalty(internal, internal, internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_penalty'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_gist_penalty(internal, internal, internal) OWNER TO postgres;

--
-- Name: bioseg_gist_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_picksplit(internal, internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_picksplit'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_picksplit(internal, internal) OWNER TO postgres;

--
-- Name: bioseg_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_joinsel(internal, oid, internal, smallint) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_joinsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: bioseg_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_sel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_sel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_sel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: barcode_barcode_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE barcode_barcode_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.barcode_barcode_id_seq OWNER TO kmr44;

--
-- Name: barcode_barcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE barcode_barcode_id_seq OWNED BY barcode.barcode_id;


--
-- Name: barcode_barcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('barcode_barcode_id_seq', 11, true);


--
-- Name: ecotype_ecotype_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE ecotype_ecotype_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ecotype_ecotype_id_seq OWNER TO kmr44;

--
-- Name: ecotype_ecotype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE ecotype_ecotype_id_seq OWNED BY ecotype.ecotype_id;


--
-- Name: ecotype_ecotype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('ecotype_ecotype_id_seq', 10, true);


--
-- Name: genotype_genotype_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE genotype_genotype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.genotype_genotype_id_seq OWNER TO kmr44;

--
-- Name: genotype_genotype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE genotype_genotype_id_seq OWNED BY genotype.genotype_id;


--
-- Name: genotype_genotype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('genotype_genotype_id_seq', 1, false);


--
-- Name: organisation_organisation_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE organisation_organisation_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organisation_organisation_id_seq OWNER TO kmr44;

--
-- Name: organisation_organisation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE organisation_organisation_id_seq OWNED BY organisation.organisation_id;


--
-- Name: organisation_organisation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('organisation_organisation_id_seq', 4, true);


--
-- Name: organism_organism_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE organism_organism_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.organism_organism_id_seq OWNER TO kmr44;

--
-- Name: organism_organism_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE organism_organism_id_seq OWNED BY organism.organism_id;


--
-- Name: organism_organism_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('organism_organism_id_seq', 11, true);


--
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE person_person_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.person_person_id_seq OWNER TO kmr44;

--
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE person_person_id_seq OWNED BY person.person_id;


--
-- Name: person_person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('person_person_id_seq', 21, true);


--
-- Name: pipedata_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipedata_pipedata_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipedata_pipedata_id_seq OWNER TO kmr44;

--
-- Name: pipedata_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipedata_pipedata_id_seq OWNED BY pipedata.pipedata_id;


--
-- Name: pipedata_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipedata_pipedata_id_seq', 4, true);


--
-- Name: pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq OWNER TO kmr44;

--
-- Name: pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq OWNED BY pipeprocess_in_pipedata.pipeprocess_in_pipedata_id;


--
-- Name: pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq', 1, false);


--
-- Name: pipeprocess_pipeprocess_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeprocess_pipeprocess_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeprocess_pipeprocess_id_seq OWNER TO kmr44;

--
-- Name: pipeprocess_pipeprocess_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeprocess_pipeprocess_id_seq OWNED BY pipeprocess.pipeprocess_id;


--
-- Name: pipeprocess_pipeprocess_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeprocess_pipeprocess_id_seq', 4, true);


--
-- Name: pipeproject_pipeproject_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE pipeproject_pipeproject_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.pipeproject_pipeproject_id_seq OWNER TO kmr44;

--
-- Name: pipeproject_pipeproject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE pipeproject_pipeproject_id_seq OWNED BY pipeproject.pipeproject_id;


--
-- Name: pipeproject_pipeproject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('pipeproject_pipeproject_id_seq', 4, true);


--
-- Name: process_conf_input_process_conf_input_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE process_conf_input_process_conf_input_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.process_conf_input_process_conf_input_id_seq OWNER TO kmr44;

--
-- Name: process_conf_input_process_conf_input_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE process_conf_input_process_conf_input_id_seq OWNED BY process_conf_input.process_conf_input_id;


--
-- Name: process_conf_input_process_conf_input_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('process_conf_input_process_conf_input_id_seq', 7, true);


--
-- Name: process_conf_process_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE process_conf_process_conf_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.process_conf_process_conf_id_seq OWNER TO kmr44;

--
-- Name: process_conf_process_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE process_conf_process_conf_id_seq OWNED BY process_conf.process_conf_id;


--
-- Name: process_conf_process_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('process_conf_process_conf_id_seq', 10, true);


--
-- Name: sample_pipedata_sample_pipedata_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_pipedata_sample_pipedata_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_pipedata_sample_pipedata_id_seq OWNER TO kmr44;

--
-- Name: sample_pipedata_sample_pipedata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_pipedata_sample_pipedata_id_seq OWNED BY sample_pipedata.sample_pipedata_id;


--
-- Name: sample_pipedata_sample_pipedata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_pipedata_sample_pipedata_id_seq', 6, true);


--
-- Name: sample_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_sample_id_seq OWNER TO kmr44;

--
-- Name: sample_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_sample_id_seq OWNED BY sample.sample_id;


--
-- Name: sample_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_sample_id_seq', 6, true);


--
-- Name: samplerun_samplerun_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE samplerun_samplerun_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.samplerun_samplerun_id_seq OWNER TO kmr44;

--
-- Name: samplerun_samplerun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE samplerun_samplerun_id_seq OWNED BY samplerun.samplerun_id;


--
-- Name: samplerun_samplerun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('samplerun_samplerun_id_seq', 6, true);


--
-- Name: sequencingrun_sequencingrun_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sequencingrun_sequencingrun_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sequencingrun_sequencingrun_id_seq OWNER TO kmr44;

--
-- Name: sequencingrun_sequencingrun_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sequencingrun_sequencingrun_id_seq OWNED BY sequencingrun.sequencingrun_id;


--
-- Name: sequencingrun_sequencingrun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sequencingrun_sequencingrun_id_seq', 4, true);


--
-- Name: tissue_tissue_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE tissue_tissue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tissue_tissue_id_seq OWNER TO kmr44;

--
-- Name: tissue_tissue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE tissue_tissue_id_seq OWNED BY tissue.tissue_id;


--
-- Name: tissue_tissue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('tissue_tissue_id_seq', 1, false);


--
-- Name: barcode_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE barcode ALTER COLUMN barcode_id SET DEFAULT nextval('barcode_barcode_id_seq'::regclass);


--
-- Name: ecotype_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE ecotype ALTER COLUMN ecotype_id SET DEFAULT nextval('ecotype_ecotype_id_seq'::regclass);


--
-- Name: genotype_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE genotype ALTER COLUMN genotype_id SET DEFAULT nextval('genotype_genotype_id_seq'::regclass);


--
-- Name: organisation_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE organisation ALTER COLUMN organisation_id SET DEFAULT nextval('organisation_organisation_id_seq'::regclass);


--
-- Name: organism_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE organism ALTER COLUMN organism_id SET DEFAULT nextval('organism_organism_id_seq'::regclass);


--
-- Name: person_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE person ALTER COLUMN person_id SET DEFAULT nextval('person_person_id_seq'::regclass);


--
-- Name: pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipedata ALTER COLUMN pipedata_id SET DEFAULT nextval('pipedata_pipedata_id_seq'::regclass);


--
-- Name: pipeprocess_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeprocess ALTER COLUMN pipeprocess_id SET DEFAULT nextval('pipeprocess_pipeprocess_id_seq'::regclass);


--
-- Name: pipeprocess_in_pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeprocess_in_pipedata ALTER COLUMN pipeprocess_in_pipedata_id SET DEFAULT nextval('pipeprocess_in_pipedata_pipeprocess_in_pipedata_id_seq'::regclass);


--
-- Name: pipeproject_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE pipeproject ALTER COLUMN pipeproject_id SET DEFAULT nextval('pipeproject_pipeproject_id_seq'::regclass);


--
-- Name: process_conf_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE process_conf ALTER COLUMN process_conf_id SET DEFAULT nextval('process_conf_process_conf_id_seq'::regclass);


--
-- Name: process_conf_input_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE process_conf_input ALTER COLUMN process_conf_input_id SET DEFAULT nextval('process_conf_input_process_conf_input_id_seq'::regclass);


--
-- Name: sample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample ALTER COLUMN sample_id SET DEFAULT nextval('sample_sample_id_seq'::regclass);


--
-- Name: sample_pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample_pipedata ALTER COLUMN sample_pipedata_id SET DEFAULT nextval('sample_pipedata_sample_pipedata_id_seq'::regclass);


--
-- Name: samplerun_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE samplerun ALTER COLUMN samplerun_id SET DEFAULT nextval('samplerun_samplerun_id_seq'::regclass);


--
-- Name: sequencingrun_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sequencingrun ALTER COLUMN sequencingrun_id SET DEFAULT nextval('sequencingrun_sequencingrun_id_seq'::regclass);


--
-- Name: tissue_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE tissue ALTER COLUMN tissue_id SET DEFAULT nextval('tissue_tissue_id_seq'::regclass);


--
-- Data for Name: barcode; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY barcode (barcode_id, created_stamp, identifier, code) FROM stdin;
1	2009-05-15 17:49:04.432548	A	TACCT
2	2009-05-15 17:49:04.432548	B	TACGA
3	2009-05-15 17:49:04.432548	C	TAGCA
4	2009-05-15 17:49:04.432548	D	TAGGT
5	2009-05-15 17:49:04.432548	E	TCAAG
6	2009-05-15 17:49:04.432548	F	TCATC
7	2009-05-15 17:49:04.432548	G	TCTAC
8	2009-05-15 17:49:04.432548	H	TCTTG
9	2009-05-15 17:49:04.432548	I	TGAAC
10	2009-05-15 17:49:04.432548	K	TGTTC
11	2009-05-15 17:49:04.432548	J	TGTTG
\.


--
-- Data for Name: cv; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cv (cv_id, name, definition) FROM stdin;
1	tracking analysis types	\N
2	tracking file content types	\N
3	tracking file format types	\N
4	tracking fractionation types	\N
5	tracking molecule types	\N
6	tracking multiplexing types	\N
7	tracking pipeprocess status	\N
8	tracking project types	\N
9	tracking quality values	\N
10	tracking samplerun types	\N
11	tracking sequencing method	\N
12	tracking treatment types	\N
\.


--
-- Data for Name: cvterm; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cvterm (cvterm_id, cv_id, name, definition, dbxref_id, is_obsolete, is_relationshiptype) FROM stdin;
1	1	fasta index	Create an index of FASTA file	\N	0	0
2	1	gff3 index	Create an index of GFF3 file	\N	0	0
3	1	multiplexed sequencing run	This pseudo-analysis generates raw sequence files, with quality scores, and uses multiplexing/barcodes	\N	0	0
4	1	non-multiplexed sequencing run	This pseudo-analysis generates raw sequence files, with quality scores, with no multiplexing	\N	0	0
5	1	remove adapters	Read FastQ files, process each read to remove the adapter	\N	0	0
6	1	remove adapters and de-multiplex	Read FastQ files, process each read to remove the adapter and split the result based on the barcode	\N	0	0
7	1	remove redundant reads	Read a fasta file of short sequences, remove redundant reads and add a count to the header	\N	0	0
8	1	ssaha alignment	Align reads against a sequence database with SSAHA	\N	0	0
9	1	summarise fasta first base	Read a fasta file of short sequences and summarise the first base composition	\N	0	0
10	1	trim reads	Read FastQ files, trim each read to a fixed length and then create a fasta file	\N	0	0
11	2	fasta_index	An index of a fasta file that has the sequence as the key	\N	0	0
12	2	first_base_summary	A summary of the first base composition of sequences from a fasta file	\N	0	0
13	2	genome_aligned_srna_reads	Small RNA reads that have been aligned against the genome	\N	0	0
14	2	genomic_dna_tags	DNA reads that have been trimmed to a fixed number of bases	\N	0	0
15	2	gff3_index	An index of a gff3 file that has the read sequence as the key	\N	0	0
16	2	multiplexed_small_rna_reads	Raw small RNA sequence with quality scores from a multiplexed sequencing run	\N	0	0
17	2	non_redundant_small_rna	Small RNA sequence reads without adapters with redundant sequences removed	\N	0	0
18	2	raw_genomic_dna_reads	Raw DNA sequence reads with quality scores	\N	0	0
19	2	raw_small_rna_reads	Raw small RNA sequence with quality scores from a non-multiplexed sequencing run	\N	0	0
20	2	remove_adapters_rejected_reads	Small RNA sequence reads that were rejected by the remove adapters step	\N	0	0
21	2	remove_adapters_unknown_barcode	Small RNA sequence reads that were rejected by the remove adapters step because they did not match an expected barcode	\N	0	0
22	2	small_rna_reads_chloroplast_alignment	Small RNA to chloroplast dna alignments	\N	0	0
23	2	small_rna_reads_mitochondrial_alignment	Small RNA to mitochondrial dna alignments	\N	0	0
24	2	small_rna_reads_nuclear_alignment	Small RNA to genome alignments	\N	0	0
25	2	small_rna	Small RNA sequence reads that have been processed to remove adapters	\N	0	0
26	3	fasta	FASTA format	\N	0	0
27	3	fastq	FastQ format file	\N	0	0
28	3	fs	FASTA format with an empty description line	\N	0	0
29	3	gff3	GFF3 format	\N	0	0
30	3	seq_offset_index	An index of a GFF3 format file	\N	0	0
31	3	text	A human readable text file with summaries or statistics	\N	0	0
32	4	no fractionation	no fractionation	\N	0	0
33	5	DNA	Deoxyribonucleic acid	\N	0	0
34	5	RNA	Ribonucleic acid	\N	0	0
35	6	DCB multiplexed	multiplexed sequencing run using DCB group barcodes	\N	0	0
36	6	non-multiplexed	One sample per sequencing run	\N	0	0
37	7	finished	Processing is done	\N	0	0
38	7	not_started	Process has not been queued yet	\N	0	0
39	7	queued	A job is queued to run this process	\N	0	0
40	7	started	Processing has started	\N	0	0
41	8	DNA tag sequencing	Sequencing of fragments of genomic DNA	\N	0	0
42	8	small RNA sequencing	Small RNA sequencing	\N	0	0
43	9	high	high quality	\N	0	0
44	9	low	low quality	\N	0	0
45	9	medium	medium quality	\N	0	0
46	9	unknown	unknown quality	\N	0	0
47	10	biological replicate	biological replicate/re-run	\N	0	0
48	10	failure re-run	re-run because of failure	\N	0	0
49	10	initial run	intial sequencing run	\N	0	0
50	10	technical replicate	technical replicate/re-run	\N	0	0
51	11	Illumina	Illumina sequencing method	\N	0	0
52	12	no treatment	no treatment	\N	0	0
\.


--
-- Data for Name: ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY ecotype (ecotype_id, created_stamp, organism, description) FROM stdin;
1	2009-05-15 17:49:04.587927	1	unspecified
2	2009-05-15 17:49:04.587927	2	unspecified
3	2009-05-15 17:49:04.587927	9	unspecified
4	2009-05-15 17:49:04.587927	4	unspecified
5	2009-05-15 17:49:04.587927	5	unspecified
6	2009-05-15 17:49:04.587927	6	unspecified
7	2009-05-15 17:49:04.587927	7	unspecified
8	2009-05-15 17:49:04.587927	8	unspecified
9	2009-05-15 17:49:04.587927	10	unspecified
10	2009-05-15 17:49:04.587927	11	unspecified
\.


--
-- Data for Name: genotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY genotype (genotype_id, created_stamp, organism, type, description) FROM stdin;
\.


--
-- Data for Name: organisation; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY organisation (organisation_id, created_stamp, name, description) FROM stdin;
1	2009-05-15 17:49:04.557031	DCB	David Baulcombe Lab, University of Cambridge, Dept. of Plant Sciences
2	2009-05-15 17:49:04.557031	CRUK CRI	Cancer Research UK, Cambridge Research Institute
3	2009-05-15 17:49:04.557031	Sainsbury	The Sainsbury Laboratory
4	2009-05-15 17:49:04.557031	JIC	The John Innes Centre
\.


--
-- Data for Name: organism; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY organism (organism_id, abbreviation, genus, species, common_name, comment) FROM stdin;
1	\N	Arabidopsis	thaliana	\N	\N
2	\N	Chlamydomonas	reinhardtii	\N	\N
3	\N	Cardamine	hirsuta	\N	\N
4	\N	Caenorhabditis	elegans	\N	\N
5	\N	Dictyostelium	discoideum	\N	\N
6	\N	Homo	sapiens	\N	\N
7	\N	Lycopersicon	esculentum	\N	\N
8	\N	Zea	mays	\N	\N
9	\N	Cardamine	hirsuta	\N	\N
10	\N	Nicotiana	benthamiana	\N	\N
11	\N	Schizosaccharomyces	pombe	\N	\N
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY person (person_id, created_stamp, first_name, last_name, user_name, password, organisation) FROM stdin;
1	2009-05-15 17:49:04.606955	Andy	Bassett	andy_bassett	andy_bassett	1
2	2009-05-15 17:49:04.606955	David	Baulcombe	david_baulcombe	david_baulcombe	1
3	2009-05-15 17:49:04.606955	Amy	Beeken	amy_beeken	amy_beeken	1
4	2009-05-15 17:49:04.606955	Paola	Fedita	paola_fedita	paola_fedita	1
5	2009-05-15 17:49:04.606955	Susi	Heimstaedt	susi_heimstaedt	susi_heimstaedt	1
6	2009-05-15 17:49:04.606955	Jagger	Harvey	jagger_harvey	jagger_harvey	1
7	2009-05-15 17:49:04.606955	Ericka	Havecker	ericka_havecker	ericka_havecker	1
8	2009-05-15 17:49:04.606955	Ian	Henderson	ian_henderson	ian_henderson	1
9	2009-05-15 17:49:04.606955	Charles	Melnyk	charles_melnyk	charles_melnyk	1
10	2009-05-15 17:49:04.606955	Attila	Molnar	attila_molnar	attila_molnar	1
11	2009-05-15 17:49:04.606955	Becky	Mosher	becky_mosher	becky_mosher	1
12	2009-05-15 17:49:04.606955	Kanu	Patel	kanu_patel	kanu_patel	1
13	2009-05-15 17:49:04.606955	Anna	Peters	anna_peters	anna_peters	1
14	2009-05-15 17:49:04.606955	Kim	Rutherford	kim_rutherford	kim_rutherford	1
15	2009-05-15 17:49:04.606955	Iain	Searle	iain_searle	iain_searle	1
16	2009-05-15 17:49:04.606955	Padubidri	Shivaprasad	padubidri_shivaprasad	padubidri_shivaprasad	1
17	2009-05-15 17:49:04.606955	Shuoya	Tang	shuoya_tang	shuoya_tang	1
18	2009-05-15 17:49:04.606955	Laura	Taylor	laura_taylor	laura_taylor	1
19	2009-05-15 17:49:04.606955	Craig	Thompson	craig_thompson	craig_thompson	1
20	2009-05-15 17:49:04.606955	Natasha	Elina	natasha_elina	natasha_elina	1
21	2009-05-15 17:49:04.606955	Hannes	V	hannes_v	hannes_v	1
\.


--
-- Data for Name: pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipedata (pipedata_id, created_stamp, format_type, content_type, file_name, generating_pipeprocess) FROM stdin;
1	2009-05-15 17:49:05.595647	27	18	fastq/ID24_171007_FC5359.lane4.fq	1
2	2009-05-15 17:49:05.595647	27	18	fastq/ID24_171007_FC5359.lane5.fq	2
3	2009-05-15 17:49:05.595647	27	16	fastq/SL234_BCF.090202.30W8NAAXX.s_1.fq	3
4	2009-05-15 17:49:05.595647	27	19	fastq/SL236.090227.311F6AAXX.s_1.fq	4
\.


--
-- Data for Name: pipeprocess; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeprocess (pipeprocess_id, created_stamp, description, process_conf, status, job_identifier, time_queued, time_started, time_finished) FROM stdin;
1	2009-05-15 17:49:05.595647	Sequencing by Sainsbury for: SL54	1	37	\N	\N	\N	\N
2	2009-05-15 17:49:05.595647	Sequencing by Sainsbury for: SL55	1	37	\N	\N	\N	\N
3	2009-05-15 17:49:05.595647	Sequencing by CRUK CRI for: SL234_B, SL234_C, SL234_F	2	37	\N	\N	\N	\N
4	2009-05-15 17:49:05.595647	Sequencing by CRUK CRI for: SL236	2	37	\N	\N	\N	\N
\.


--
-- Data for Name: pipeprocess_in_pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeprocess_in_pipedata (pipeprocess_in_pipedata_id, created_stamp, pipeprocess, pipedata) FROM stdin;
\.


--
-- Data for Name: pipeproject; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeproject (pipeproject_id, created_stamp, name, description, type, owner, funder) FROM stdin;
1	2009-05-15 17:49:05.595647	P_SL54	P_SL54	41	1	\N
2	2009-05-15 17:49:05.595647	P_SL55	P_SL55	41	1	\N
3	2009-05-15 17:49:05.595647	P_SL234_BCF	P_SL234_BCF	42	7	\N
4	2009-05-15 17:49:05.595647	P_SL236	P_SL236	42	10	\N
\.


--
-- Data for Name: process_conf; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf (process_conf_id, created_stamp, runable_name, detail, type) FROM stdin;
1	2009-05-15 17:49:04.67219	\N	Sainsbury	4
2	2009-05-15 17:49:04.67219	\N	CRI	4
3	2009-05-15 17:49:04.67219	\N	CRI	3
4	2009-05-15 17:49:04.67219	SmallRNA::Runable::RemoveAdaptersRunable	\N	5
5	2009-05-15 17:49:04.67219	SmallRNA::Runable::RemoveAdaptersRunable	\N	6
6	2009-05-15 17:49:04.67219	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	9
7	2009-05-15 17:49:04.67219	SmallRNA::Runable::NonRedundantFastaRunable	\N	7
8	2009-05-15 17:49:04.67219	SmallRNA::Runable::CreateIndexRunable	\N	2
9	2009-05-15 17:49:04.67219	SmallRNA::Runable::CreateIndexRunable	\N	1
10	2009-05-15 17:49:04.67219	SmallRNA::Runable::SSAHASearchRunable	versus: nuclear_genome	8
\.


--
-- Data for Name: process_conf_input; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf_input (process_conf_input_id, created_stamp, process_conf, format_type, content_type) FROM stdin;
1	2009-05-15 17:49:04.67219	4	27	19
2	2009-05-15 17:49:04.67219	5	27	16
3	2009-05-15 17:49:04.67219	6	26	25
4	2009-05-15 17:49:04.67219	7	26	25
5	2009-05-15 17:49:04.67219	8	29	13
6	2009-05-15 17:49:04.67219	9	26	17
7	2009-05-15 17:49:04.67219	10	26	17
\.


--
-- Data for Name: sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample (sample_id, created_stamp, name, pipeproject, ecotype, genotype, description, protocol, molecule_type, treatment_type, fractionation_type, tissue) FROM stdin;
1	2009-05-15 17:49:05.595647	SL54	1	2	\N	Chlamy total DNA (mononuc)	\N	33	\N	\N	\N
2	2009-05-15 17:49:05.595647	SL55	2	2	\N	Chlamy methylated DNA IP (mononuc)	\N	33	\N	\N	\N
3	2009-05-15 17:49:05.595647	SL234_B	3	1	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP 	\N	34	\N	\N	\N
4	2009-05-15 17:49:05.595647	SL234_C	3	1	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP 	\N	34	\N	\N	\N
5	2009-05-15 17:49:05.595647	SL234_F	3	1	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP 	\N	34	\N	\N	\N
6	2009-05-15 17:49:05.595647	SL236	4	1	\N	grafting dcl234/dcl234	\N	34	\N	\N	\N
\.


--
-- Data for Name: sample_pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_pipedata (sample_pipedata_id, created_stamp, sample, pipedata) FROM stdin;
1	2009-05-15 17:49:05.595647	1	1
2	2009-05-15 17:49:05.595647	2	2
3	2009-05-15 17:49:05.595647	3	3
4	2009-05-15 17:49:05.595647	4	3
5	2009-05-15 17:49:05.595647	5	3
6	2009-05-15 17:49:05.595647	6	4
\.


--
-- Data for Name: samplerun; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY samplerun (samplerun_id, created_stamp, description, samplerun_type, sample, barcode, sequencingrun) FROM stdin;
1	2009-05-15 17:49:05.595647	sample run for: SL54	49	1	\N	1
2	2009-05-15 17:49:05.595647	sample run for: SL55	49	2	\N	2
3	2009-05-15 17:49:05.595647	sample run for: SL234_B	49	3	2	3
4	2009-05-15 17:49:05.595647	sample run for: SL234_C	49	4	3	3
5	2009-05-15 17:49:05.595647	sample run for: SL234_F	49	5	6	3
6	2009-05-15 17:49:05.595647	sample run for: SL236	49	6	\N	4
\.


--
-- Data for Name: sequencingrun; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencingrun (sequencingrun_id, created_stamp, identifier, initial_pipedata, sequencing_centre, initial_pipeprocess, submission_date, run_date, data_received_date, quality, sequencing_type, multiplexing_type) FROM stdin;
1	2009-05-15 17:49:05.595647	R_SL54	1	3	1	\N	\N	\N	46	51	36
2	2009-05-15 17:49:05.595647	R_SL55	2	3	2	\N	\N	\N	46	51	36
3	2009-05-15 17:49:05.595647	R_SL234_BCF	3	2	3	2009-01-20	2009-02-10	2009-02-10	46	51	35
4	2009-05-15 17:49:05.595647	R_SL236	4	2	4	2009-02-10	2009-03-09	2009-03-09	46	51	36
\.


--
-- Data for Name: tissue; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY tissue (tissue_id, created_stamp, organism, type, description) FROM stdin;
\.


--
-- Name: barcode_code_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_code_key UNIQUE (code);


--
-- Name: barcode_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_id_pk PRIMARY KEY (barcode_id);


--
-- Name: barcode_identifier_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY barcode
    ADD CONSTRAINT barcode_identifier_key UNIQUE (identifier);


--
-- Name: cv_c1; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cv
    ADD CONSTRAINT cv_c1 UNIQUE (name);


--
-- Name: cv_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cv
    ADD CONSTRAINT cv_pkey PRIMARY KEY (cv_id);


--
-- Name: cvterm_pkey; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_pkey PRIMARY KEY (cvterm_id);


--
-- Name: ecotype_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY ecotype
    ADD CONSTRAINT ecotype_id_pk PRIMARY KEY (ecotype_id);


--
-- Name: genotype_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY genotype
    ADD CONSTRAINT genotype_id_pk PRIMARY KEY (genotype_id);


--
-- Name: organisation_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organisation
    ADD CONSTRAINT organisation_id_pk PRIMARY KEY (organisation_id);


--
-- Name: organism_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organism
    ADD CONSTRAINT organism_id_pk PRIMARY KEY (organism_id);


--
-- Name: person_full_name_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_full_name_constraint UNIQUE (first_name, last_name);


--
-- Name: person_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_id_pk PRIMARY KEY (person_id);


--
-- Name: person_user_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_user_name_key UNIQUE (user_name);


--
-- Name: pipedata_file_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_file_name_key UNIQUE (file_name);


--
-- Name: pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_id_pk PRIMARY KEY (pipedata_id);


--
-- Name: pipeprocess_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_id_pk PRIMARY KEY (pipeprocess_id);


--
-- Name: pipeprocess_in_pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_id_pk PRIMARY KEY (pipeprocess_in_pipedata_id);


--
-- Name: pipeprocess_in_pk_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pk_constraint UNIQUE (pipeprocess, pipedata);


--
-- Name: pipeproject_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_id_pk PRIMARY KEY (pipeproject_id);


--
-- Name: process_conf_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY process_conf
    ADD CONSTRAINT process_conf_id_pk PRIMARY KEY (process_conf_id);


--
-- Name: process_conf_input_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_id_pk PRIMARY KEY (process_conf_input_id);


--
-- Name: sample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_id_pk PRIMARY KEY (sample_id);


--
-- Name: sample_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_name_key UNIQUE (name);


--
-- Name: sample_pipedata_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_pipedata
    ADD CONSTRAINT sample_pipedata_id_pk PRIMARY KEY (sample_pipedata_id);


--
-- Name: samplerun_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY samplerun
    ADD CONSTRAINT samplerun_id_pk PRIMARY KEY (samplerun_id);


--
-- Name: sequencingrun_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_id_pk PRIMARY KEY (sequencingrun_id);


--
-- Name: sequencingrun_identifier_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_identifier_key UNIQUE (identifier);


--
-- Name: tissue_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY tissue
    ADD CONSTRAINT tissue_id_pk PRIMARY KEY (tissue_id);


--
-- Name: cvterm_cv_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY cvterm
    ADD CONSTRAINT cvterm_cv_id_fkey FOREIGN KEY (cv_id) REFERENCES cv(cv_id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ecotype_organism_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY ecotype
    ADD CONSTRAINT ecotype_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id);


--
-- Name: genotype_organism_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY genotype
    ADD CONSTRAINT genotype_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id);


--
-- Name: genotype_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY genotype
    ADD CONSTRAINT genotype_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id);


--
-- Name: person_organisation_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_organisation_fkey FOREIGN KEY (organisation) REFERENCES organisation(organisation_id);


--
-- Name: pipedata_content_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_content_type_fkey FOREIGN KEY (content_type) REFERENCES cvterm(cvterm_id);


--
-- Name: pipedata_format_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_format_type_fkey FOREIGN KEY (format_type) REFERENCES cvterm(cvterm_id);


--
-- Name: pipedata_generating_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipedata
    ADD CONSTRAINT pipedata_generating_pipeprocess_fkey FOREIGN KEY (generating_pipeprocess) REFERENCES pipeprocess(pipeprocess_id);


--
-- Name: pipeprocess_in_pipedata_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: pipeprocess_in_pipedata_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess_in_pipedata
    ADD CONSTRAINT pipeprocess_in_pipedata_pipeprocess_fkey FOREIGN KEY (pipeprocess) REFERENCES pipeprocess(pipeprocess_id);


--
-- Name: pipeprocess_process_conf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_process_conf_fkey FOREIGN KEY (process_conf) REFERENCES process_conf(process_conf_id);


--
-- Name: pipeprocess_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeprocess
    ADD CONSTRAINT pipeprocess_status_fkey FOREIGN KEY (status) REFERENCES cvterm(cvterm_id);


--
-- Name: pipeproject_funder_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_funder_fkey FOREIGN KEY (funder) REFERENCES organisation(organisation_id);


--
-- Name: pipeproject_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_owner_fkey FOREIGN KEY (owner) REFERENCES person(person_id);


--
-- Name: pipeproject_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY pipeproject
    ADD CONSTRAINT pipeproject_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id);


--
-- Name: process_conf_input_content_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_content_type_fkey FOREIGN KEY (content_type) REFERENCES cvterm(cvterm_id);


--
-- Name: process_conf_input_format_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_format_type_fkey FOREIGN KEY (format_type) REFERENCES cvterm(cvterm_id);


--
-- Name: process_conf_input_process_conf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_process_conf_fkey FOREIGN KEY (process_conf) REFERENCES process_conf(process_conf_id);


--
-- Name: process_conf_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf
    ADD CONSTRAINT process_conf_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id);


--
-- Name: sample_fractionation_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_fractionation_type_fkey FOREIGN KEY (fractionation_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_genotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_genotype_fkey FOREIGN KEY (genotype) REFERENCES genotype(genotype_id);


--
-- Name: sample_molecule_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_molecule_type_fkey FOREIGN KEY (molecule_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sample_pipedata_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_pipedata
    ADD CONSTRAINT sample_pipedata_pipedata_fkey FOREIGN KEY (pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: sample_pipedata_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_pipedata
    ADD CONSTRAINT sample_pipedata_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: sample_pipeproject_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_pipeproject_fkey FOREIGN KEY (pipeproject) REFERENCES pipeproject(pipeproject_id);


--
-- Name: sample_tissue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_tissue_fkey FOREIGN KEY (tissue) REFERENCES tissue(tissue_id);


--
-- Name: sample_treatment_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_treatment_type_fkey FOREIGN KEY (treatment_type) REFERENCES cvterm(cvterm_id);


--
-- Name: samplerun_barcode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY samplerun
    ADD CONSTRAINT samplerun_barcode_fkey FOREIGN KEY (barcode) REFERENCES barcode(barcode_id);


--
-- Name: samplerun_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY samplerun
    ADD CONSTRAINT samplerun_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: samplerun_samplerun_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY samplerun
    ADD CONSTRAINT samplerun_samplerun_type_fkey FOREIGN KEY (samplerun_type) REFERENCES cvterm(cvterm_id);


--
-- Name: samplerun_sequencingrun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY samplerun
    ADD CONSTRAINT samplerun_sequencingrun_fkey FOREIGN KEY (sequencingrun) REFERENCES sequencingrun(sequencingrun_id);


--
-- Name: sequencingrun_initial_pipedata_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_initial_pipedata_fkey FOREIGN KEY (initial_pipedata) REFERENCES pipedata(pipedata_id);


--
-- Name: sequencingrun_initial_pipeprocess_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_initial_pipeprocess_fkey FOREIGN KEY (initial_pipeprocess) REFERENCES pipeprocess(pipeprocess_id);


--
-- Name: sequencingrun_multiplexing_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_multiplexing_type_fkey FOREIGN KEY (multiplexing_type) REFERENCES cvterm(cvterm_id);


--
-- Name: sequencingrun_quality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_quality_fkey FOREIGN KEY (quality) REFERENCES cvterm(cvterm_id);


--
-- Name: sequencingrun_sequencing_centre_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_sequencing_centre_fkey FOREIGN KEY (sequencing_centre) REFERENCES organisation(organisation_id);


--
-- Name: sequencingrun_sequencing_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_sequencing_type_fkey FOREIGN KEY (sequencing_type) REFERENCES cvterm(cvterm_id);


--
-- Name: tissue_organism_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY tissue
    ADD CONSTRAINT tissue_organism_fkey FOREIGN KEY (organism) REFERENCES organism(organism_id);


--
-- Name: tissue_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY tissue
    ADD CONSTRAINT tissue_type_fkey FOREIGN KEY (type) REFERENCES cvterm(cvterm_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

