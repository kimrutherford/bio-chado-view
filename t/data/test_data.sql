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
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_sample_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_sequencing_centre_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_quality_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_multiplexing_type_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_initial_pipeprocess_fkey;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_initial_pipedata_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_treatment_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_tissue_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_processing_requirement_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_pipeproject_fkey;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_sample_fkey;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_pipedata_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_molecule_type_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_genotype_fkey;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_fractionation_type_fkey;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_sample_fkey;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_ecotype_fkey;
ALTER TABLE ONLY public.process_conf DROP CONSTRAINT process_conf_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_process_conf_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_format_type_fkey;
ALTER TABLE ONLY public.process_conf_input DROP CONSTRAINT process_conf_input_ecotype_fkey;
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
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_sequencing_sample_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_sample_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_coded_sample_type_fkey;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_barcode_fkey;
ALTER TABLE ONLY public.tissue DROP CONSTRAINT tissue_id_pk;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_identifier_key;
ALTER TABLE ONLY public.sequencingrun DROP CONSTRAINT sequencingrun_id_pk;
ALTER TABLE ONLY public.sequencing_sample DROP CONSTRAINT sequencing_sample_name_key;
ALTER TABLE ONLY public.sequencing_sample DROP CONSTRAINT sequencing_sample_id_pk;
ALTER TABLE ONLY public.sample_pipedata DROP CONSTRAINT sample_pipedata_id_pk;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_name_key;
ALTER TABLE ONLY public.sample DROP CONSTRAINT sample_id_pk;
ALTER TABLE ONLY public.sample_ecotype DROP CONSTRAINT sample_ecotype_id_pk;
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
ALTER TABLE ONLY public.organism DROP CONSTRAINT organism_full_name_constraint;
ALTER TABLE ONLY public.organisation DROP CONSTRAINT organisation_id_pk;
ALTER TABLE ONLY public.genotype DROP CONSTRAINT genotype_id_pk;
ALTER TABLE ONLY public.ecotype DROP CONSTRAINT ecotype_id_pk;
ALTER TABLE ONLY public.cvterm DROP CONSTRAINT cvterm_pkey;
ALTER TABLE ONLY public.cv DROP CONSTRAINT cv_pkey;
ALTER TABLE ONLY public.cv DROP CONSTRAINT cv_c1;
ALTER TABLE ONLY public.coded_sample DROP CONSTRAINT coded_sample_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_identifier_key;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_id_pk;
ALTER TABLE ONLY public.barcode DROP CONSTRAINT barcode_code_key;
ALTER TABLE public.tissue ALTER COLUMN tissue_id DROP DEFAULT;
ALTER TABLE public.sequencingrun ALTER COLUMN sequencingrun_id DROP DEFAULT;
ALTER TABLE public.sequencing_sample ALTER COLUMN sequencing_sample_id DROP DEFAULT;
ALTER TABLE public.sample_pipedata ALTER COLUMN sample_pipedata_id DROP DEFAULT;
ALTER TABLE public.sample_ecotype ALTER COLUMN sample_ecotype_id DROP DEFAULT;
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
ALTER TABLE public.coded_sample ALTER COLUMN coded_sample_id DROP DEFAULT;
ALTER TABLE public.barcode ALTER COLUMN barcode_id DROP DEFAULT;
DROP SEQUENCE public.tissue_tissue_id_seq;
DROP SEQUENCE public.sequencingrun_sequencingrun_id_seq;
DROP SEQUENCE public.sequencing_sample_sequencing_sample_id_seq;
DROP SEQUENCE public.sample_sample_id_seq;
DROP SEQUENCE public.sample_pipedata_sample_pipedata_id_seq;
DROP SEQUENCE public.sample_ecotype_sample_ecotype_id_seq;
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
DROP SEQUENCE public.coded_sample_coded_sample_id_seq;
DROP SEQUENCE public.barcode_barcode_id_seq;
DROP OPERATOR CLASS public.gist_bioseg_ops USING gist;
DROP OPERATOR CLASS public.bioseg_ops USING btree;
DROP OPERATOR public.@> (bioseg, bioseg);
DROP OPERATOR public.>> (bioseg, bioseg);
DROP OPERATOR public.>= (bioseg, bioseg);
DROP OPERATOR public.> (bioseg, bioseg);
DROP OPERATOR public.= (bioseg, bioseg);
DROP OPERATOR public.<@ (bioseg, bioseg);
DROP OPERATOR public.<> (bioseg, bioseg);
DROP OPERATOR public.<= (bioseg, bioseg);
DROP OPERATOR public.<< (bioseg, bioseg);
DROP OPERATOR public.< (bioseg, bioseg);
DROP OPERATOR public.&> (bioseg, bioseg);
DROP OPERATOR public.&< (bioseg, bioseg);
DROP OPERATOR public.&& (bioseg, bioseg);
DROP FUNCTION public.bioseg_upper(bioseg);
DROP FUNCTION public.bioseg_size(bioseg);
DROP FUNCTION public.bioseg_sel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_same(bioseg, bioseg);
DROP FUNCTION public.bioseg_right(bioseg, bioseg);
DROP FUNCTION public.bioseg_overlap(bioseg, bioseg);
DROP FUNCTION public.bioseg_over_right(bioseg, bioseg);
DROP FUNCTION public.bioseg_over_left(bioseg, bioseg);
DROP FUNCTION public.bioseg_lt(bioseg, bioseg);
DROP FUNCTION public.bioseg_lower(bioseg);
DROP FUNCTION public.bioseg_left(bioseg, bioseg);
DROP FUNCTION public.bioseg_le(bioseg, bioseg);
DROP FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint);
DROP FUNCTION public.bioseg_gt(bioseg, bioseg);
DROP FUNCTION public.bioseg_gist_union(internal, internal);
DROP FUNCTION public.bioseg_gist_same(bioseg, bioseg, internal);
DROP FUNCTION public.bioseg_gist_picksplit(internal, internal);
DROP FUNCTION public.bioseg_gist_penalty(internal, internal, internal);
DROP FUNCTION public.bioseg_gist_decompress(internal);
DROP FUNCTION public.bioseg_gist_consistent(internal, bioseg, integer);
DROP FUNCTION public.bioseg_gist_compress(internal);
DROP FUNCTION public.bioseg_ge(bioseg, bioseg);
DROP FUNCTION public.bioseg_different(bioseg, bioseg);
DROP FUNCTION public.bioseg_create(integer, integer);
DROP FUNCTION public.bioseg_contsel(internal, oid, internal, integer);
DROP FUNCTION public.bioseg_contjoinsel(internal, oid, internal, smallint);
DROP FUNCTION public.bioseg_contains(bioseg, bioseg);
DROP FUNCTION public.bioseg_contained(bioseg, bioseg);
DROP FUNCTION public.bioseg_cmp(bioseg, bioseg);
DROP TABLE public.tissue;
DROP TABLE public.sequencingrun;
DROP TABLE public.sequencing_sample;
DROP TABLE public.sample_pipedata;
DROP TABLE public.sample_ecotype;
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
DROP TABLE public.coded_sample;
DROP TYPE public.bioseg CASCADE;
DROP FUNCTION public.bioseg_out(bioseg);
DROP FUNCTION public.bioseg_in(cstring);
DROP TABLE public.barcode;
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
-- Name: bioseg; Type: SHELL TYPE; Schema: public; Owner: postgres
--

CREATE TYPE bioseg;


--
-- Name: bioseg_in(cstring); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_in(cstring) RETURNS bioseg
    AS '$libdir/bioseg', 'bioseg_in'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_in(cstring) OWNER TO postgres;

--
-- Name: bioseg_out(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_out(bioseg) RETURNS cstring
    AS '$libdir/bioseg', 'bioseg_out'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_out(bioseg) OWNER TO postgres;

--
-- Name: bioseg; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE bioseg (
    INTERNALLENGTH = 8,
    INPUT = bioseg_in,
    OUTPUT = bioseg_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.bioseg OWNER TO postgres;

--
-- Name: TYPE bioseg; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE bioseg IS 'integer point interval ''INT..INT'', ''INT...INT'', or ''INT''';


--
-- Name: coded_sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE coded_sample (
    coded_sample_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    description text NOT NULL,
    coded_sample_type integer NOT NULL,
    sample integer NOT NULL,
    sequencing_sample integer NOT NULL,
    barcode integer
);


ALTER TABLE public.coded_sample OWNER TO kmr44;

--
-- Name: TABLE coded_sample; Type: COMMENT; Schema: public; Owner: kmr44
--

COMMENT ON TABLE coded_sample IS 'This table records the many-to-many relationship between samples and sequencing runs and the type of the run (intial, re-run, replicate etc.)';


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

SELECT pg_catalog.setval('cv_cv_id_seq', 13, true);


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

SELECT pg_catalog.setval('cvterm_cvterm_id_seq', 57, true);


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
    file_length bigint NOT NULL,
    generating_pipeprocess integer
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
    content_type integer NOT NULL,
    ecotype integer
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
    genotype integer,
    description text,
    protocol text,
    molecule_type integer NOT NULL,
    treatment_type integer,
    fractionation_type integer,
    processing_requirement integer NOT NULL,
    tissue integer
);


ALTER TABLE public.sample OWNER TO kmr44;

--
-- Name: sample_ecotype; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sample_ecotype (
    sample_ecotype_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    sample integer NOT NULL,
    ecotype integer NOT NULL
);


ALTER TABLE public.sample_ecotype OWNER TO kmr44;

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
-- Name: sequencing_sample; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencing_sample (
    sequencing_sample_id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.sequencing_sample OWNER TO kmr44;

--
-- Name: sequencingrun; Type: TABLE; Schema: public; Owner: kmr44; Tablespace: 
--

CREATE TABLE sequencingrun (
    sequencingrun_id integer NOT NULL,
    created_stamp timestamp without time zone DEFAULT now() NOT NULL,
    identifier text NOT NULL,
    sequencing_sample integer NOT NULL,
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
-- Name: bioseg_cmp(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_cmp(bioseg, bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_cmp'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_cmp(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_cmp(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_cmp(bioseg, bioseg) IS 'btree comparison function';


--
-- Name: bioseg_contained(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contained(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_contained'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contained(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_contained(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_contained(bioseg, bioseg) IS 'contained in';


--
-- Name: bioseg_contains(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_contains(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_contains'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_contains(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_contains(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_contains(bioseg, bioseg) IS 'contains';


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
-- Name: bioseg_create(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_create(integer, integer) RETURNS bioseg
    AS '$libdir/bioseg', 'bioseg_create'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_create(integer, integer) OWNER TO postgres;

--
-- Name: bioseg_different(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_different(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_different'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_different(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_different(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_different(bioseg, bioseg) IS 'different';


--
-- Name: bioseg_ge(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_ge(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_ge'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_ge(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_ge(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_ge(bioseg, bioseg) IS 'greater than or equal';


--
-- Name: bioseg_gist_compress(internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_compress(internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_compress'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_compress(internal) OWNER TO postgres;

--
-- Name: bioseg_gist_consistent(internal, bioseg, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_consistent(internal, bioseg, integer) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_gist_consistent'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_consistent(internal, bioseg, integer) OWNER TO postgres;

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
-- Name: bioseg_gist_same(bioseg, bioseg, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_same(bioseg, bioseg, internal) RETURNS internal
    AS '$libdir/bioseg', 'bioseg_gist_same'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_same(bioseg, bioseg, internal) OWNER TO postgres;

--
-- Name: bioseg_gist_union(internal, internal); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gist_union(internal, internal) RETURNS bioseg
    AS '$libdir/bioseg', 'bioseg_gist_union'
    LANGUAGE c IMMUTABLE;


ALTER FUNCTION public.bioseg_gist_union(internal, internal) OWNER TO postgres;

--
-- Name: bioseg_gt(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_gt(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_gt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_gt(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_gt(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_gt(bioseg, bioseg) IS 'greater than';


--
-- Name: bioseg_joinsel(internal, oid, internal, smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_joinsel(internal, oid, internal, smallint) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_joinsel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_joinsel(internal, oid, internal, smallint) OWNER TO postgres;

--
-- Name: bioseg_le(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_le(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_le'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_le(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_le(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_le(bioseg, bioseg) IS 'less than or equal';


--
-- Name: bioseg_left(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_left(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_left'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_left(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_left(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_left(bioseg, bioseg) IS 'is left of';


--
-- Name: bioseg_lower(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_lower(bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_lower'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_lower(bioseg) OWNER TO postgres;

--
-- Name: bioseg_lt(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_lt(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_lt'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_lt(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_lt(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_lt(bioseg, bioseg) IS 'less than';


--
-- Name: bioseg_over_left(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_over_left(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_over_left'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_over_left(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_over_left(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_over_left(bioseg, bioseg) IS 'overlaps or is left of';


--
-- Name: bioseg_over_right(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_over_right(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_over_right'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_over_right(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_over_right(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_over_right(bioseg, bioseg) IS 'overlaps or is right of';


--
-- Name: bioseg_overlap(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_overlap(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_overlap'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_overlap(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_overlap(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_overlap(bioseg, bioseg) IS 'overlaps';


--
-- Name: bioseg_right(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_right(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_right'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_right(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_right(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_right(bioseg, bioseg) IS 'is right of';


--
-- Name: bioseg_same(bioseg, bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_same(bioseg, bioseg) RETURNS boolean
    AS '$libdir/bioseg', 'bioseg_same'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_same(bioseg, bioseg) OWNER TO postgres;

--
-- Name: FUNCTION bioseg_same(bioseg, bioseg); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION bioseg_same(bioseg, bioseg) IS 'same as';


--
-- Name: bioseg_sel(internal, oid, internal, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_sel(internal, oid, internal, integer) RETURNS double precision
    AS '$libdir/bioseg', 'bioseg_sel'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_sel(internal, oid, internal, integer) OWNER TO postgres;

--
-- Name: bioseg_size(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_size(bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_size'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_size(bioseg) OWNER TO postgres;

--
-- Name: bioseg_upper(bioseg); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION bioseg_upper(bioseg) RETURNS integer
    AS '$libdir/bioseg', 'bioseg_upper'
    LANGUAGE c IMMUTABLE STRICT;


ALTER FUNCTION public.bioseg_upper(bioseg) OWNER TO postgres;

--
-- Name: &&; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR && (
    PROCEDURE = bioseg_overlap,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = &&,
    RESTRICT = bioseg_sel,
    JOIN = bioseg_joinsel
);


ALTER OPERATOR public.&& (bioseg, bioseg) OWNER TO postgres;

--
-- Name: &<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &< (
    PROCEDURE = bioseg_over_left,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&< (bioseg, bioseg) OWNER TO postgres;

--
-- Name: &>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR &> (
    PROCEDURE = bioseg_over_right,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.&> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR < (
    PROCEDURE = bioseg_lt,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.< (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <<; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR << (
    PROCEDURE = bioseg_left,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = >>,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.<< (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <= (
    PROCEDURE = bioseg_le,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


ALTER OPERATOR public.<= (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <> (
    PROCEDURE = bioseg_different,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: <@; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR <@ (
    PROCEDURE = bioseg_contained,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = @>,
    RESTRICT = bioseg_contsel,
    JOIN = bioseg_contjoinsel
);


ALTER OPERATOR public.<@ (bioseg, bioseg) OWNER TO postgres;

--
-- Name: =; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR = (
    PROCEDURE = bioseg_same,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = =,
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (bioseg, bioseg) OWNER TO postgres;

--
-- Name: >; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR > (
    PROCEDURE = bioseg_gt,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: >=; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >= (
    PROCEDURE = bioseg_ge,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


ALTER OPERATOR public.>= (bioseg, bioseg) OWNER TO postgres;

--
-- Name: >>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR >> (
    PROCEDURE = bioseg_right,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <<,
    RESTRICT = positionsel,
    JOIN = positionjoinsel
);


ALTER OPERATOR public.>> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: @>; Type: OPERATOR; Schema: public; Owner: postgres
--

CREATE OPERATOR @> (
    PROCEDURE = bioseg_contains,
    LEFTARG = bioseg,
    RIGHTARG = bioseg,
    COMMUTATOR = <@,
    RESTRICT = bioseg_contsel,
    JOIN = bioseg_contjoinsel
);


ALTER OPERATOR public.@> (bioseg, bioseg) OWNER TO postgres;

--
-- Name: bioseg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS bioseg_ops
    DEFAULT FOR TYPE bioseg USING btree AS
    OPERATOR 1 <(bioseg,bioseg) ,
    OPERATOR 2 <=(bioseg,bioseg) ,
    OPERATOR 3 =(bioseg,bioseg) ,
    OPERATOR 4 >=(bioseg,bioseg) ,
    OPERATOR 5 >(bioseg,bioseg) ,
    FUNCTION 1 bioseg_cmp(bioseg,bioseg);


ALTER OPERATOR CLASS public.bioseg_ops USING btree OWNER TO postgres;

--
-- Name: gist_bioseg_ops; Type: OPERATOR CLASS; Schema: public; Owner: postgres
--

CREATE OPERATOR CLASS gist_bioseg_ops
    DEFAULT FOR TYPE bioseg USING gist AS
    OPERATOR 1 <<(bioseg,bioseg) ,
    OPERATOR 2 &<(bioseg,bioseg) ,
    OPERATOR 3 &&(bioseg,bioseg) ,
    OPERATOR 4 &>(bioseg,bioseg) ,
    OPERATOR 5 >>(bioseg,bioseg) ,
    OPERATOR 6 =(bioseg,bioseg) ,
    OPERATOR 7 @>(bioseg,bioseg) ,
    OPERATOR 8 <@(bioseg,bioseg) ,
    FUNCTION 1 bioseg_gist_consistent(internal,bioseg,integer) ,
    FUNCTION 2 bioseg_gist_union(internal,internal) ,
    FUNCTION 3 bioseg_gist_compress(internal) ,
    FUNCTION 4 bioseg_gist_decompress(internal) ,
    FUNCTION 5 bioseg_gist_penalty(internal,internal,internal) ,
    FUNCTION 6 bioseg_gist_picksplit(internal,internal) ,
    FUNCTION 7 bioseg_gist_same(bioseg,bioseg,internal);


ALTER OPERATOR CLASS public.gist_bioseg_ops USING gist OWNER TO postgres;

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
-- Name: coded_sample_coded_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE coded_sample_coded_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.coded_sample_coded_sample_id_seq OWNER TO kmr44;

--
-- Name: coded_sample_coded_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE coded_sample_coded_sample_id_seq OWNED BY coded_sample.coded_sample_id;


--
-- Name: coded_sample_coded_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('coded_sample_coded_sample_id_seq', 8, true);


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

SELECT pg_catalog.setval('ecotype_ecotype_id_seq', 14, true);


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

SELECT pg_catalog.setval('organisation_organisation_id_seq', 5, true);


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

SELECT pg_catalog.setval('organism_organism_id_seq', 14, true);


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

SELECT pg_catalog.setval('person_person_id_seq', 22, true);


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

SELECT pg_catalog.setval('pipedata_pipedata_id_seq', 6, true);


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

SELECT pg_catalog.setval('pipeprocess_pipeprocess_id_seq', 6, true);


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

SELECT pg_catalog.setval('pipeproject_pipeproject_id_seq', 6, true);


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

SELECT pg_catalog.setval('process_conf_input_process_conf_input_id_seq', 15, true);


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

SELECT pg_catalog.setval('process_conf_process_conf_id_seq', 19, true);


--
-- Name: sample_ecotype_sample_ecotype_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sample_ecotype_sample_ecotype_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sample_ecotype_sample_ecotype_id_seq OWNER TO kmr44;

--
-- Name: sample_ecotype_sample_ecotype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sample_ecotype_sample_ecotype_id_seq OWNED BY sample_ecotype.sample_ecotype_id;


--
-- Name: sample_ecotype_sample_ecotype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sample_ecotype_sample_ecotype_id_seq', 8, true);


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

SELECT pg_catalog.setval('sample_sample_id_seq', 8, true);


--
-- Name: sequencing_sample_sequencing_sample_id_seq; Type: SEQUENCE; Schema: public; Owner: kmr44
--

CREATE SEQUENCE sequencing_sample_sequencing_sample_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.sequencing_sample_sequencing_sample_id_seq OWNER TO kmr44;

--
-- Name: sequencing_sample_sequencing_sample_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kmr44
--

ALTER SEQUENCE sequencing_sample_sequencing_sample_id_seq OWNED BY sequencing_sample.sequencing_sample_id;


--
-- Name: sequencing_sample_sequencing_sample_id_seq; Type: SEQUENCE SET; Schema: public; Owner: kmr44
--

SELECT pg_catalog.setval('sequencing_sample_sequencing_sample_id_seq', 6, true);


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

SELECT pg_catalog.setval('sequencingrun_sequencingrun_id_seq', 6, true);


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
-- Name: coded_sample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE coded_sample ALTER COLUMN coded_sample_id SET DEFAULT nextval('coded_sample_coded_sample_id_seq'::regclass);


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
-- Name: sample_ecotype_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample_ecotype ALTER COLUMN sample_ecotype_id SET DEFAULT nextval('sample_ecotype_sample_ecotype_id_seq'::regclass);


--
-- Name: sample_pipedata_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sample_pipedata ALTER COLUMN sample_pipedata_id SET DEFAULT nextval('sample_pipedata_sample_pipedata_id_seq'::regclass);


--
-- Name: sequencing_sample_id; Type: DEFAULT; Schema: public; Owner: kmr44
--

ALTER TABLE sequencing_sample ALTER COLUMN sequencing_sample_id SET DEFAULT nextval('sequencing_sample_sequencing_sample_id_seq'::regclass);


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
1	2009-06-18 16:52:43.889804	A	TACCT
2	2009-06-18 16:52:43.889804	B	TACGA
3	2009-06-18 16:52:43.889804	C	TAGCA
4	2009-06-18 16:52:43.889804	D	TAGGT
5	2009-06-18 16:52:43.889804	E	TCAAG
6	2009-06-18 16:52:43.889804	F	TCATC
7	2009-06-18 16:52:43.889804	G	TCTAC
8	2009-06-18 16:52:43.889804	H	TCTTG
9	2009-06-18 16:52:43.889804	I	TGAAC
10	2009-06-18 16:52:43.889804	K	TGTTC
11	2009-06-18 16:52:43.889804	J	TGTTG
\.


--
-- Data for Name: coded_sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY coded_sample (coded_sample_id, created_stamp, description, coded_sample_type, sample, sequencing_sample, barcode) FROM stdin;
1	2009-06-18 16:52:45.820034	non-barcoded sample for: SL11	14	1	1	\N
2	2009-06-18 16:52:45.820034	non-barcoded sample for: SL54	14	2	2	\N
3	2009-06-18 16:52:45.820034	non-barcoded sample for: SL55	14	3	3	\N
4	2009-06-18 16:52:45.820034	non-barcoded sample for: SL165_1	14	4	4	\N
5	2009-06-18 16:52:45.820034	barcoded sample for: SL234_B using barcode: B	14	5	5	2
6	2009-06-18 16:52:45.820034	barcoded sample for: SL234_C using barcode: C	14	6	5	3
7	2009-06-18 16:52:45.820034	barcoded sample for: SL234_F using barcode: F	14	7	5	6
8	2009-06-18 16:52:45.820034	non-barcoded sample for: SL236	14	8	6	\N
\.


--
-- Data for Name: cv; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cv (cv_id, name, definition) FROM stdin;
1	tracking analysis types	\N
2	tracking coded sample types	\N
3	tracking file content types	\N
4	tracking file format types	\N
5	tracking fractionation types	\N
6	tracking molecule types	\N
7	tracking multiplexing types	\N
8	tracking pipeprocess status	\N
9	tracking project types	\N
10	tracking quality values	\N
11	tracking sample processing requirements	\N
12	tracking sequencing method	\N
13	tracking treatment types	\N
\.


--
-- Data for Name: cvterm; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY cvterm (cvterm_id, cv_id, name, definition, dbxref_id, is_obsolete, is_relationshiptype) FROM stdin;
1	1	fasta index	Create an index of FASTA file	\N	0	0
2	1	genome aligned reads filter	Filter a fasta file, creating a file containing only genome aligned reads	\N	0	0
3	1	gff3 index	Create an index of GFF3 file	\N	0	0
4	1	multiplexed sequencing run	This pseudo-analysis generates raw sequence files, with quality scores, and uses multiplexing/barcodes	\N	0	0
5	1	non-multiplexed sequencing run	This pseudo-analysis generates raw sequence files, with quality scores, with no multiplexing	\N	0	0
6	1	remove adapters	Read FastQ files, process each read to remove the adapter	\N	0	0
7	1	remove adapters and de-multiplex	Read FastQ files, process each read to remove the adapter and split the result based on the barcode	\N	0	0
8	1	remove redundant reads	Read a fasta file of short sequences, remove redundant reads and add a count to the header	\N	0	0
9	1	ssaha alignment	Align reads against a sequence database with SSAHA	\N	0	0
10	1	summarise fasta first base	Read a fasta file of short sequences and summarise the first base composition	\N	0	0
11	1	trim reads	Read FastQ files, trim each read to a fixed length and then create a fasta file	\N	0	0
12	2	biological replicate	biological replicate/re-run	\N	0	0
13	2	failure re-run	re-run because of failure	\N	0	0
14	2	initial run	intial sequencing run	\N	0	0
15	2	technical replicate	technical replicate/re-run	\N	0	0
16	3	fasta_index	An index of a fasta file that has the sequence as the key	\N	0	0
17	3	first_base_summary	A summary of the first base composition of sequences from a fasta file	\N	0	0
18	3	genome_aligned_srna_reads	Small RNA reads that have been aligned against the genome	\N	0	0
19	3	genome_matching_srna	Reads that match the genome with a 100% full-length match	\N	0	0
20	3	genomic_dna_tags	DNA reads that have been trimmed to a fixed number of bases	\N	0	0
21	3	gff3_index	An index of a gff3 file that has the read sequence as the key	\N	0	0
22	3	multiplexed_small_rna_reads	Raw small RNA sequence reads from a multiplexed sequencing run, before any processing	\N	0	0
23	3	non_redundant_small_rna	Small RNA sequence reads without adapters with redundant sequences removed	\N	0	0
24	3	raw_genomic_dna_reads	Raw DNA sequence reads with quality scores	\N	0	0
25	3	raw_small_rna_reads	Raw small RNA sequence reads from a non-multiplexed sequencing run, before any processing	\N	0	0
26	3	remove_adapter_rejects	Small RNA sequence reads that were rejected by the remove adapters step	\N	0	0
27	3	remove_adapter_unknown_barcode	Small RNA sequence reads that were rejected by the remove adapters step because they did not match an expected barcode	\N	0	0
28	3	small_rna	Small RNA sequence reads that have been processed to remove adapters	\N	0	0
29	3	small_rna_reads_chloroplast_alignment	Small RNA to chloroplast dna alignments	\N	0	0
30	3	small_rna_reads_mitochondrial_alignment	Small RNA to mitochondrial dna alignments	\N	0	0
31	3	small_rna_reads_nuclear_alignment	Small RNA to genome alignments	\N	0	0
32	4	fasta	FASTA format	\N	0	0
33	4	fastq	FastQ format file	\N	0	0
34	4	fs	FASTA format with an empty description line	\N	0	0
35	4	gff3	GFF3 format	\N	0	0
36	4	seq_offset_index	An index of a GFF3 or FASTA format file	\N	0	0
37	4	text	A human readable text file with summaries or statistics	\N	0	0
38	4	tsv	A file containing tab-separated value	\N	0	0
39	5	no fractionation	no fractionation	\N	0	0
40	6	DNA	Deoxyribonucleic acid	\N	0	0
41	6	RNA	Ribonucleic acid	\N	0	0
42	7	DCB multiplexed	multiplexed sequencing run using DCB group barcodes	\N	0	0
43	7	non-multiplexed	One sample per sequencing run	\N	0	0
44	8	finished	Processing is done	\N	0	0
45	8	not_started	Process has not been queued yet	\N	0	0
46	8	queued	A job is queued to run this process	\N	0	0
47	8	started	Processing has started	\N	0	0
48	9	DNA tag sequencing	Sequencing of fragments of genomic DNA	\N	0	0
49	9	small RNA sequencing	Small RNA sequencing	\N	0	0
50	10	high	high quality	\N	0	0
51	10	low	low quality	\N	0	0
52	10	medium	medium quality	\N	0	0
53	10	unknown	unknown quality	\N	0	0
54	11	needs processing	 Processing should be performed for this sample	\N	0	0
55	11	no processing	Processing should not be performed for this sample	\N	0	0
56	12	Illumina	Illumina sequencing method	\N	0	0
57	13	no treatment	no treatment	\N	0	0
\.


--
-- Data for Name: ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY ecotype (ecotype_id, created_stamp, organism, description) FROM stdin;
1	2009-06-18 16:52:44.043242	1	unspecified
2	2009-06-18 16:52:44.043242	2	unspecified
3	2009-06-18 16:52:44.043242	3	unspecified
4	2009-06-18 16:52:44.043242	4	unspecified
5	2009-06-18 16:52:44.043242	5	unspecified
6	2009-06-18 16:52:44.043242	6	unspecified
7	2009-06-18 16:52:44.043242	7	unspecified
8	2009-06-18 16:52:44.043242	8	unspecified
9	2009-06-18 16:52:44.043242	10	unspecified
10	2009-06-18 16:52:44.043242	11	unspecified
11	2009-06-18 16:52:44.043242	9	unspecified
12	2009-06-18 16:52:44.043242	12	unspecified
13	2009-06-18 16:52:44.043242	13	unspecified
14	2009-06-18 16:52:44.043242	14	unspecified
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
1	2009-06-18 16:52:44.012638	DCB	David Baulcombe Lab, University of Cambridge, Dept. of Plant Sciences
2	2009-06-18 16:52:44.012638	CRUK CRI	Cancer Research UK, Cambridge Research Institute
3	2009-06-18 16:52:44.012638	Sainsbury	Sainsbury Laboratory
4	2009-06-18 16:52:44.012638	JIC	John Innes Centre
5	2009-06-18 16:52:44.012638	BGI	Beijing Genomics Institute
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
9	\N	Oryza	sativa	\N	\N
10	\N	Nicotiana	benthamiana	\N	\N
11	\N	Schizosaccharomyces	pombe	\N	\N
12	\N	Carmovirus	turnip crinkle virus	\N	\N
13	\N	Benyvirus	rice stripe virus	\N	\N
14	\N	Unknown	unknown	\N	\N
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY person (person_id, created_stamp, first_name, last_name, user_name, password, organisation) FROM stdin;
1	2009-06-18 16:52:44.063787	Andy	Bassett	andy_bassett	andy_bassett	1
2	2009-06-18 16:52:44.063787	David	Baulcombe	david_baulcombe	david_baulcombe	1
3	2009-06-18 16:52:44.063787	Amy	Beeken	amy_beeken	amy_beeken	1
4	2009-06-18 16:52:44.063787	Paola	Fedita	paola_fedita	paola_fedita	1
5	2009-06-18 16:52:44.063787	Susi	Heimstaedt	susi_heimstaedt	susi_heimstaedt	1
6	2009-06-18 16:52:44.063787	Jagger	Harvey	jagger_harvey	jagger_harvey	1
7	2009-06-18 16:52:44.063787	Ericka	Havecker	ericka_havecker	ericka_havecker	1
8	2009-06-18 16:52:44.063787	Ian	Henderson	ian_henderson	ian_henderson	1
9	2009-06-18 16:52:44.063787	Charles	Melnyk	charles_melnyk	charles_melnyk	1
10	2009-06-18 16:52:44.063787	Attila	Molnar	attila_molnar	attila_molnar	1
11	2009-06-18 16:52:44.063787	Becky	Mosher	becky_mosher	becky_mosher	1
12	2009-06-18 16:52:44.063787	Kanu	Patel	kanu_patel	kanu_patel	1
13	2009-06-18 16:52:44.063787	Anna	Peters	anna_peters	anna_peters	1
14	2009-06-18 16:52:44.063787	Kim	Rutherford	kim_rutherford	kim_rutherford	1
15	2009-06-18 16:52:44.063787	Iain	Searle	iain_searle	iain_searle	1
16	2009-06-18 16:52:44.063787	Padubidri	Shivaprasad	padubidri_shivaprasad	padubidri_shivaprasad	1
17	2009-06-18 16:52:44.063787	Shuoya	Tang	shuoya_tang	shuoya_tang	1
18	2009-06-18 16:52:44.063787	Laura	Taylor	laura_taylor	laura_taylor	1
19	2009-06-18 16:52:44.063787	Craig	Thompson	craig_thompson	craig_thompson	1
20	2009-06-18 16:52:44.063787	Natasha	Elina	natasha_elina	natasha_elina	1
21	2009-06-18 16:52:44.063787	Krys	Kelly	krys_kelly	krys_kelly	1
22	2009-06-18 16:52:44.063787	Hannes	V	hannes_v	hannes_v	1
\.


--
-- Data for Name: pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipedata (pipedata_id, created_stamp, format_type, content_type, file_name, file_length, generating_pipeprocess) FROM stdin;
1	2009-06-18 16:52:45.820034	32	28	SL11/SL11.ID15_FC5372.lane2.reads.7_5_2008.fa	85196121	1
2	2009-06-18 16:52:45.820034	33	24	fastq/SL54.ID24_171007_FC5359.lane4.fq	308933804	2
3	2009-06-18 16:52:45.820034	33	24	fastq/SL55.ID24_171007_FC5359.lane5.fq	305662338	3
4	2009-06-18 16:52:45.820034	33	25	fastq/SL165.080905.306BFAAXX.s_5.fq	1026029170	4
5	2009-06-18 16:52:45.820034	33	22	fastq/SL234_BCF.090202.30W8NAAXX.s_1.fq	517055794	5
6	2009-06-18 16:52:45.820034	33	25	fastq/SL236.090227.311F6AAXX.s_1.fq	1203596662	6
\.


--
-- Data for Name: pipeprocess; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY pipeprocess (pipeprocess_id, created_stamp, description, process_conf, status, job_identifier, time_queued, time_started, time_finished) FROM stdin;
1	2009-06-18 16:52:45.820034	Sequencing by Sainsbury for: SL11	1	44	\N	\N	\N	\N
2	2009-06-18 16:52:45.820034	Sequencing by Sainsbury for: SL54	1	44	\N	\N	\N	\N
3	2009-06-18 16:52:45.820034	Sequencing by Sainsbury for: SL55	1	44	\N	\N	\N	\N
4	2009-06-18 16:52:45.820034	Sequencing by CRUK CRI for: SL165_1	2	44	\N	\N	\N	\N
5	2009-06-18 16:52:45.820034	Sequencing by CRUK CRI for: SL234_B, SL234_C, SL234_F	2	44	\N	\N	\N	\N
6	2009-06-18 16:52:45.820034	Sequencing by CRUK CRI for: SL236	2	44	\N	\N	\N	\N
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
1	2009-06-18 16:52:45.820034	P_SL11	P_SL11	49	7	\N
2	2009-06-18 16:52:45.820034	P_SL54	P_SL54	48	1	\N
3	2009-06-18 16:52:45.820034	P_SL55	P_SL55	48	1	\N
4	2009-06-18 16:52:45.820034	P_SL165_1	P_SL165_1	49	1	\N
5	2009-06-18 16:52:45.820034	P_SL234_BCF	P_SL234_BCF	49	7	\N
6	2009-06-18 16:52:45.820034	P_SL236	P_SL236	49	10	\N
\.


--
-- Data for Name: process_conf; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf (process_conf_id, created_stamp, runable_name, detail, type) FROM stdin;
1	2009-06-18 16:52:44.116995	\N	Sainsbury	5
2	2009-06-18 16:52:44.116995	\N	CRI	5
3	2009-06-18 16:52:44.116995	\N	CRI	4
4	2009-06-18 16:52:44.116995	\N	BGI	5
5	2009-06-18 16:52:44.116995	SmallRNA::Runable::RemoveAdaptersRunable	\N	6
6	2009-06-18 16:52:44.116995	SmallRNA::Runable::RemoveAdaptersRunable	\N	7
7	2009-06-18 16:52:44.116995	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	10
8	2009-06-18 16:52:44.116995	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	10
9	2009-06-18 16:52:44.116995	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	10
10	2009-06-18 16:52:44.116995	SmallRNA::Runable::FirstBaseCompSummaryRunable	\N	10
11	2009-06-18 16:52:44.116995	SmallRNA::Runable::NonRedundantFastaRunable	\N	8
12	2009-06-18 16:52:44.116995	SmallRNA::Runable::CreateIndexRunable	\N	3
13	2009-06-18 16:52:44.116995	SmallRNA::Runable::CreateIndexRunable	\N	1
14	2009-06-18 16:52:44.116995	SmallRNA::Runable::SSAHASearchRunable	component: genome	9
15	2009-06-18 16:52:44.116995	SmallRNA::Runable::SSAHASearchRunable	component: genome	9
16	2009-06-18 16:52:44.116995	SmallRNA::Runable::SSAHASearchRunable	component: genome	9
17	2009-06-18 16:52:44.116995	SmallRNA::Runable::SSAHASearchRunable	component: genome	9
18	2009-06-18 16:52:44.116995	SmallRNA::Runable::SSAHASearchRunable	component: genome	9
19	2009-06-18 16:52:44.116995	SmallRNA::Runable::GenomeMatchingReadsRunable	\N	2
\.


--
-- Data for Name: process_conf_input; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY process_conf_input (process_conf_input_id, created_stamp, process_conf, format_type, content_type, ecotype) FROM stdin;
1	2009-06-18 16:52:44.116995	5	33	25	\N
2	2009-06-18 16:52:44.116995	6	33	22	\N
3	2009-06-18 16:52:44.116995	7	32	28	\N
4	2009-06-18 16:52:44.116995	8	32	23	\N
5	2009-06-18 16:52:44.116995	9	32	25	\N
6	2009-06-18 16:52:44.116995	10	32	22	\N
7	2009-06-18 16:52:44.116995	11	32	28	\N
8	2009-06-18 16:52:44.116995	12	35	18	\N
9	2009-06-18 16:52:44.116995	13	32	23	\N
10	2009-06-18 16:52:44.116995	14	32	23	1
11	2009-06-18 16:52:44.116995	15	32	23	12
12	2009-06-18 16:52:44.116995	16	32	23	11
13	2009-06-18 16:52:44.116995	17	32	23	13
14	2009-06-18 16:52:44.116995	18	32	23	2
15	2009-06-18 16:52:44.116995	19	35	18	\N
\.


--
-- Data for Name: sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample (sample_id, created_stamp, name, pipeproject, genotype, description, protocol, molecule_type, treatment_type, fractionation_type, processing_requirement, tissue) FROM stdin;
1	2009-06-18 16:52:45.820034	SL11	1	\N	AGO9 associated small RNAs Rep1 (mixed Col-0 floral + silique)	\N	41	\N	\N	54	\N
2	2009-06-18 16:52:45.820034	SL54	2	\N	Chlamy total DNA (mononuc)	\N	40	\N	\N	54	\N
3	2009-06-18 16:52:45.820034	SL55	3	\N	Chlamy methylated DNA IP (mononuc)	\N	40	\N	\N	54	\N
4	2009-06-18 16:52:45.820034	SL165_1	4	\N	Total sRNA mono-P	\N	41	\N	\N	54	\N
5	2009-06-18 16:52:45.820034	SL234_B	5	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode B	\N	41	\N	\N	54	\N
6	2009-06-18 16:52:45.820034	SL234_C	5	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode C	\N	41	\N	\N	54	\N
7	2009-06-18 16:52:45.820034	SL234_F	5	\N	B: Ago4p:AGO4 IP C: AGO4p:AGO6 IP F: AGO4p:AGO9 IP  - barcode F	\N	41	\N	\N	54	\N
8	2009-06-18 16:52:45.820034	SL236	6	\N	grafting dcl234/dcl234	\N	41	\N	\N	54	\N
\.


--
-- Data for Name: sample_ecotype; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_ecotype (sample_ecotype_id, created_stamp, sample, ecotype) FROM stdin;
1	2009-06-18 16:52:45.820034	1	1
2	2009-06-18 16:52:45.820034	2	2
3	2009-06-18 16:52:45.820034	3	2
4	2009-06-18 16:52:45.820034	4	2
5	2009-06-18 16:52:45.820034	5	1
6	2009-06-18 16:52:45.820034	6	1
7	2009-06-18 16:52:45.820034	7	1
8	2009-06-18 16:52:45.820034	8	1
\.


--
-- Data for Name: sample_pipedata; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sample_pipedata (sample_pipedata_id, created_stamp, sample, pipedata) FROM stdin;
1	2009-06-18 16:52:45.820034	1	1
2	2009-06-18 16:52:45.820034	2	2
3	2009-06-18 16:52:45.820034	3	3
4	2009-06-18 16:52:45.820034	4	4
5	2009-06-18 16:52:45.820034	5	5
6	2009-06-18 16:52:45.820034	8	6
\.


--
-- Data for Name: sequencing_sample; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencing_sample (sequencing_sample_id, name) FROM stdin;
1	CRI_SL11
2	CRI_SL54
3	CRI_SL55
4	CRI_SL165_1
5	CRI_SL234_BCF
6	CRI_SL236
\.


--
-- Data for Name: sequencingrun; Type: TABLE DATA; Schema: public; Owner: kmr44
--

COPY sequencingrun (sequencingrun_id, created_stamp, identifier, sequencing_sample, initial_pipedata, sequencing_centre, initial_pipeprocess, submission_date, run_date, data_received_date, quality, sequencing_type, multiplexing_type) FROM stdin;
1	2009-06-18 16:52:45.820034	Run_SL11	1	1	3	1	\N	\N	\N	53	56	43
2	2009-06-18 16:52:45.820034	Run_SL54	2	2	3	2	\N	\N	\N	53	56	43
3	2009-06-18 16:52:45.820034	Run_SL55	3	3	3	3	\N	\N	\N	53	56	43
4	2009-06-18 16:52:45.820034	Run_SL165_1	4	4	2	4	2008-08-27	2008-09-11	2008-09-11	53	56	43
5	2009-06-18 16:52:45.820034	Run_SL234_BCF	5	5	2	5	2009-01-20	2009-02-10	2009-02-10	53	56	42
6	2009-06-18 16:52:45.820034	Run_SL236	6	6	2	6	2009-02-10	2009-03-09	2009-03-09	53	56	43
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
-- Name: coded_sample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_id_pk PRIMARY KEY (coded_sample_id);


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
-- Name: organism_full_name_constraint; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY organism
    ADD CONSTRAINT organism_full_name_constraint UNIQUE (genus, species);


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
-- Name: sample_ecotype_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_id_pk PRIMARY KEY (sample_ecotype_id);


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
-- Name: sequencing_sample_id_pk; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencing_sample
    ADD CONSTRAINT sequencing_sample_id_pk PRIMARY KEY (sequencing_sample_id);


--
-- Name: sequencing_sample_name_key; Type: CONSTRAINT; Schema: public; Owner: kmr44; Tablespace: 
--

ALTER TABLE ONLY sequencing_sample
    ADD CONSTRAINT sequencing_sample_name_key UNIQUE (name);


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
-- Name: coded_sample_barcode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_barcode_fkey FOREIGN KEY (barcode) REFERENCES barcode(barcode_id);


--
-- Name: coded_sample_coded_sample_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_coded_sample_type_fkey FOREIGN KEY (coded_sample_type) REFERENCES cvterm(cvterm_id);


--
-- Name: coded_sample_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


--
-- Name: coded_sample_sequencing_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY coded_sample
    ADD CONSTRAINT coded_sample_sequencing_sample_fkey FOREIGN KEY (sequencing_sample) REFERENCES sequencing_sample(sequencing_sample_id);


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
-- Name: process_conf_input_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY process_conf_input
    ADD CONSTRAINT process_conf_input_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id);


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
-- Name: sample_ecotype_ecotype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_ecotype_fkey FOREIGN KEY (ecotype) REFERENCES ecotype(ecotype_id);


--
-- Name: sample_ecotype_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample_ecotype
    ADD CONSTRAINT sample_ecotype_sample_fkey FOREIGN KEY (sample) REFERENCES sample(sample_id);


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
-- Name: sample_processing_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sample
    ADD CONSTRAINT sample_processing_requirement_fkey FOREIGN KEY (processing_requirement) REFERENCES cvterm(cvterm_id);


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
-- Name: sequencingrun_sequencing_sample_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kmr44
--

ALTER TABLE ONLY sequencingrun
    ADD CONSTRAINT sequencingrun_sequencing_sample_fkey FOREIGN KEY (sequencing_sample) REFERENCES sequencing_sample(sequencing_sample_id);


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

