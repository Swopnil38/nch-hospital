--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: cms; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA cms;


ALTER SCHEMA cms OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: content; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.content (
    pk integer NOT NULL,
    slug character varying(100),
    title character varying(128),
    content text,
    summary character varying(250),
    tags character varying(15)[],
    links character varying(128),
    "linkHeader" character varying(128),
    "linkCaption" character varying(128),
    cover character varying(128),
    symptoms text,
    procedure text,
    treatments text,
    tech text,
    edit character varying(2),
    action character varying(2),
    category character varying(16),
    stages character varying(16),
    "subCategory" character varying(16),
    department_id integer,
    "publishedOn" timestamp with time zone
);


ALTER TABLE cms.content OWNER TO postgres;

--
-- Name: content_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.content_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.content_pk_seq OWNER TO postgres;

--
-- Name: content_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.content_pk_seq OWNED BY cms.content.pk;


--
-- Name: department; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.department (
    pk integer NOT NULL,
    department_name character varying,
    "publishedOn" timestamp with time zone
);


ALTER TABLE cms.department OWNER TO postgres;

--
-- Name: department_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.department_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.department_pk_seq OWNER TO postgres;

--
-- Name: department_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.department_pk_seq OWNED BY cms.department.pk;


--
-- Name: employees; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.employees (
    pk integer NOT NULL,
    name character varying,
    email character varying,
    slug character varying(100),
    mobile bigint,
    landline character varying,
    designation character varying,
    cover character varying(128),
    stages character varying(16),
    display_order double precision,
    content text,
    tags character varying(15)[],
    department_id integer,
    "publishedOn" timestamp with time zone,
    type character varying(50),
    edit character varying(8)
);


ALTER TABLE cms.employees OWNER TO postgres;

--
-- Name: employees_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.employees_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.employees_pk_seq OWNER TO postgres;

--
-- Name: employees_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.employees_pk_seq OWNED BY cms.employees.pk;


--
-- Name: feedback; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.feedback (
    pk integer NOT NULL,
    feedback_by character varying,
    date timestamp with time zone,
    message character varying,
    phone bigint,
    email character varying,
    "publishedOn" timestamp with time zone
);


ALTER TABLE cms.feedback OWNER TO postgres;

--
-- Name: feedback_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.feedback_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.feedback_pk_seq OWNER TO postgres;

--
-- Name: feedback_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.feedback_pk_seq OWNED BY cms.feedback.pk;


--
-- Name: files; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.files (
    pk integer NOT NULL,
    name character varying,
    size integer,
    mime character varying,
    path character varying(256) NOT NULL,
    md5sum uuid,
    via character varying(128),
    inode integer,
    route character varying(256),
    tags character varying(15)[],
    description character varying(128),
    "publishedOn" timestamp with time zone
);


ALTER TABLE cms.files OWNER TO postgres;

--
-- Name: TABLE files; Type: COMMENT; Schema: cms; Owner: postgres
--

COMMENT ON TABLE cms.files IS 'file tracker';


--
-- Name: files_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.files_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.files_pk_seq OWNER TO postgres;

--
-- Name: files_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.files_pk_seq OWNED BY cms.files.pk;


--
-- Name: packages; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.packages (
    pk integer NOT NULL,
    slug character varying(100),
    title character varying(128),
    content text,
    prices integer,
    cover character varying(128),
    edit character varying(2),
    action character varying(2),
    stages character varying(16),
    "publishedOn" timestamp with time zone,
    category character varying(32)
);


ALTER TABLE cms.packages OWNER TO postgres;

--
-- Name: packages_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.packages_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.packages_pk_seq OWNER TO postgres;

--
-- Name: packages_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.packages_pk_seq OWNED BY cms.packages.pk;


--
-- Name: posts; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.posts (
    pk integer NOT NULL,
    slug character varying(100),
    title character varying(128),
    content text,
    summary character varying(250),
    cover character varying(128),
    "isSticky" boolean,
    "publishedOn" timestamp with time zone,
    tags character varying(15)[],
    category character varying(16),
    stages character varying(16),
    "subCategory" character varying(16)
);


ALTER TABLE cms.posts OWNER TO postgres;

--
-- Name: TABLE posts; Type: COMMENT; Schema: cms; Owner: postgres
--

COMMENT ON TABLE cms.posts IS 'blog posts';


--
-- Name: posts_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.posts_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.posts_pk_seq OWNER TO postgres;

--
-- Name: posts_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.posts_pk_seq OWNED BY cms.posts.pk;


--
-- Name: testinmonials; Type: TABLE; Schema: cms; Owner: postgres
--

CREATE TABLE cms.testinmonials (
    pk integer NOT NULL,
    name character varying,
    title character varying,
    date timestamp with time zone,
    message character varying,
    phone bigint,
    email character varying,
    "publishedOn" timestamp with time zone,
    cover character varying(255)
);


ALTER TABLE cms.testinmonials OWNER TO postgres;

--
-- Name: testinmonials_pk_seq; Type: SEQUENCE; Schema: cms; Owner: postgres
--

CREATE SEQUENCE cms.testinmonials_pk_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cms.testinmonials_pk_seq OWNER TO postgres;

--
-- Name: testinmonials_pk_seq; Type: SEQUENCE OWNED BY; Schema: cms; Owner: postgres
--

ALTER SEQUENCE cms.testinmonials_pk_seq OWNED BY cms.testinmonials.pk;


--
-- Name: content pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.content ALTER COLUMN pk SET DEFAULT nextval('cms.content_pk_seq'::regclass);


--
-- Name: department pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.department ALTER COLUMN pk SET DEFAULT nextval('cms.department_pk_seq'::regclass);


--
-- Name: employees pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.employees ALTER COLUMN pk SET DEFAULT nextval('cms.employees_pk_seq'::regclass);


--
-- Name: feedback pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.feedback ALTER COLUMN pk SET DEFAULT nextval('cms.feedback_pk_seq'::regclass);


--
-- Name: files pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.files ALTER COLUMN pk SET DEFAULT nextval('cms.files_pk_seq'::regclass);


--
-- Name: packages pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.packages ALTER COLUMN pk SET DEFAULT nextval('cms.packages_pk_seq'::regclass);


--
-- Name: posts pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.posts ALTER COLUMN pk SET DEFAULT nextval('cms.posts_pk_seq'::regclass);


--
-- Name: testinmonials pk; Type: DEFAULT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.testinmonials ALTER COLUMN pk SET DEFAULT nextval('cms.testinmonials_pk_seq'::regclass);


--
-- Data for Name: content; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.content (pk, slug, title, content, summary, tags, links, "linkHeader", "linkCaption", cover, symptoms, procedure, treatments, tech, edit, action, category, stages, "subCategory", department_id, "publishedOn") FROM stdin;

11  'Department-of-ENT-Head-And-Neck-Surgery'   'Department of ENT-Head And Neck Surgery'   <p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 18pt;"><span lang="en-US"><strong>Overview</strong></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">The Department of Otolaryngology (ENT)-Head and Neck Surgery at Nationalcity, Nepal specializes in the evaluation and state-of-the-art treatment of patients with ear, nose, throat disorders; voice and swallowing disorders; and cancers and non-malignant conditions of the head and neck, like thyroid and Parotids and voice box, upper food passage, oral tumors, and cancers. The Head and Neck Surgery team is multidisciplinary to ensure that each patient receives well-coordinated care by specialists in head and neck surgery, radiology, medical oncology, radiation oncology, plastic and reconstructive surgery, and other appropriate specialties, as well as healthcare professionals in speech and swallowing, nutrition, and other areas.</span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">The team experts are always there to provide the ultimate care in the field. For people with suspected or known hearing loss, we provide complete hearing evaluation, and auditory rehabilitation (therapy that helps hearing-impaired patients improve their ability to communicate through speech reading and auditory training).</span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 18pt;"><strong><span style="font-family: 'Times New Roman', serif;"><span lang="en-US">Services</span></span></strong></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Ear Surgeries including Middle Ear &amp; Implant Surgeries</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Endoscopic Sinus, Nasal Surgeries</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Laryngeal (Voice Box) Surgeries</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Thyroid &amp; Parathyroid surgeries </span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Head &amp; Neck Cancer Surgeries</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Salivary gland Surgeries </span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Foreign body removal (Esophagus/Bronchus)</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">All general ENT Surgeries (TONSILLECTOMY, SEPTOPLASTY) </span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 18pt;"><strong><span style="font-family: Times New Roman, serif;"><span lang="en-US">Facilities</span></span></strong></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Fiberoptic Nasopharyngeal Endoscopy</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Hearing Evaluation (PTA, Impedance, OAE)</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-size: 12pt;">&bull; <span style="font-family: Times New Roman, serif;"><span lang="en-US">Speech, Voice &amp; Swallowing Therapies</span></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">We offer the entire spectrum of services, providing patients with convenient care that too at comparable and affordable costs.As a leader in ENT-Head and Neck Surgery, we provide patients with the latest, most effective treatments using the most advanced technologies, for instance, Lasers, ultrasonic cutting machines, nerve monitors, and navigation systems to name a few.</span></span></p>	The team experts are always there to provide the ultimate care in the field.	{}	\N	\N	\N	/media/uploads/services/1689782937354.jpeg	\N	\N	\N	\N	\N	\N	blog	publish	\N	7	2023-07-19 21:54:03.583691+05:45
7	Department-of-Gastroenterology-Hepatology-and-Endoscopy	Department of Gastroenterology, Hepatology and Endoscopy	<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 18pt;"><span lang="en-US"><strong>Overview</strong></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Associate.Prof.Dr.Barun Shrestha, the <strong>Department of Gastroenterology, Hepatology and Endoscopy</strong> features state-of-the-art facilities for the management of a wide variety of gastrointestinal-related diseases and their complications, liver disorders, pancreatic and biliary tract diseases and many other digestive problems. </span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">We have some of the best and most trusted gastroenterologists and hepatologists, who perform complex and routine endoscopy procedures and offer specialized services using new techniques and equipment to diagnose and treat diseases of the digestive system. Our team is committed to setting the standard for excellence in patient care.</span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 18pt;"><span lang="en-US"><strong>Services</strong></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Our doctors provide comprehensive treatment for most of the gastrointestinal and digestive disorders:</span></span></p>\r\n<ul>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Esophagus and Stomach</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Peptic Ulcer Disease</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Gastroesophageal Reflux Disease (GERD)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Stomach (Gastric) Cancer</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Esophageal Cancer</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Swallowing Disorders</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Achalasia </span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Barrett&rsquo;s Esophagus</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-size: 12pt;"><span style="font-family: Times New Roman, serif;"><span lang="en-US">Colon Cancer</span></span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" lang="en-GB"><span style="font-size: 14pt;"><strong><span style="font-family: 'Times New Roman', serif;"><span lang="en-US">Liver</span></span></strong></span></p>\r\n<ul>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Cirrhosis of liver, Portal hypertension, Hepatic encephalopathy, hepatic renal syndrome</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Acute Liver failure</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Alcoholic liver disease</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Drug-induced liver injury</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Non-alcoholic fatty liver disease (NAFLD)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Viral hepatitis</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Autoimmune and cholestatic liver disease</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Hepatocellular Carcinoma (Liver Cancer)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Liver Transplant Workup</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Others</span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" lang="en-GB"><span style="font-size: 14pt;"><strong><span style="font-family: 'Times New Roman', serif;"><span lang="en-US">Pancreas and Biliary Tract</span></span></strong></span></p>\r\n<ul>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Acute pancreatitis</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Chronic pancreatitis</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Pancreatic cancer</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Cholangitis</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Bile duct stones</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Bile duct cancer (Cholangiocarcinoma)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Cysts in the pancreas (sac-like structures that can be either benign, cancerous, or somewhere in between)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Sphincter of Oddi dysfunction (when a spasm in the sphincter or muscle prevents pancreatic juices from emptying, leading ot inflammation)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Pancreas divisum </span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Others</span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" lang="en-GB"><span style="font-size: 14pt;"><strong><span style="font-family: Times New Roman, serif;"><span lang="en-US">Small and Large Intestine</span></span></strong></span></p>\r\n<ul>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Inflammatory Bowel Disease, IBD (Ulcerative Colitis, Crohn&rsquo;s Disease)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Colon Polyps</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Colorectal Cancer</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Irritable Bowel Syndrome (IBS)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Celiac disease and non-celiac gluten sensitivity</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Abdominal tuberculosis</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Others</span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 14pt;"><span lang="en-US"><strong>Facilities</strong></span></span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">These are the partial lists of the diagnostic tests performed:</span></span></p>\r\n<ul>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Upper Gastrointestinal Endoscopy (Esophago-gastro-duodenoscopy)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Colonoscopy</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Endoscopic Retrograde Cholangiopancreatography (ERCP)</span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western">&nbsp;</p>\r\n<p class="western" lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">We perform many procedures to treat our patients and free them from digestive diseases:</span></span></p>\r\n<ul>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">ERCP with sphincterotomy/ sphincteroplasty</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">ERCP with Stenting/ CBD Stone Removal/ Pancreatic Stone Removal</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Polypectomy of Polyp in Esophagus or Stomach or Duodenum or Colon</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Endoscopic Mucosal Resection (EMR)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Endoscopic Variceal Band Ligation (EVL)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Glue therapy</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Hemostasis of the bleeding ulcers by endoscopic clipping or epinephrine injection methods of coagulation (monopolar, bipolar)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Endoscopic Foreign Body Removal</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Balloon Dilatation in the Stricture of Esophagus or Pylorus or Duodenum</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Palliative treatment by opening up the lumen of the digestive tract in esophageal cancer, gastric cancer, and duodenal cancer by metallic stenting</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Balloon Dilatation of Achalasia Cardia</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Percutaneous Endoscopic Gastrostomy (PEG)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Percutaneous Endoscopic Jejunostomy (PEJ)</span></span></p>\r\n</li>\r\n<li style="font-size: 12pt;">\r\n<p lang="en-GB"><span style="font-family: 'Times New Roman', serif; font-size: 12pt;"><span lang="en-US">Fibro Scan</span></span></p>\r\n</li>\r\n</ul>\r\n<p>&nbsp;</p>	Associate.Prof.Dr.Barun Shrestha, the Department of Gastroenterology, Hepatology and Endoscopy features state-of-the-art facilities	{}	\N	\N	\N	/media/uploads/services/1689782080248.jpeg	\N	\N	\N	\N	\N	\N	blog	publish	\N	3	2023-08-22 14:44:21.220191+05:45
8	Department-of-Obstetrics-And-Gynaecology	Department of Obstetrics And Gynaecology	<p class="western" lang="en-GB"><span style="font-size: large; font-family: 'Times New Roman', serif;">The Department of Obstetrics and Gynaecology offers the full spectrum of women&rsquo;s health care services. We offer state-of-the-art technologies with superior care providing a range of services such as painless deliveries, and management of high-risk pregnancies/late pregnancies, among others. The department offers expert gynecological treatment and specialist services for all varieties of Gynaecological ailments. It also provides all varieties of Laparoscopic Gynaecological surgeries for Uterus / Fallopian Tube &amp; Ovarian Disease. Furthermore, Open Gynaecological surgeries like Laparotomy / Hysterectomy / Cystectomy / Myomectomy/Normal delivery/Vaccum Delivery/Pelvic Floor Repair/MVA are also performed. For female cancers, the department runs regular screening programs for preventive services and also undertakes Gynaecological cancer surgeries like Radical Hysterectomy with Pelvic Lymph Node Dissection.Focusing on the expected parents, Antenatal and Pre-natal classes are conducted on a routine basis.</span></p>\r\n<p class="western" lang="en-GB"><span style="font-family: Times New Roman, serif;"><span style="font-size: large;"><span lang="en-US">Obstetrics and Gynaecology is the medical specialty that deals with all aspects of the female reproductive system. Obstetrics deals with pregnancy and pregnancy-related problems. Gynecology deals with functions and diseases specific to women and girls, especially those affecting the reproductive system.</span></span></span></p>\r\n<p class="western" lang="en-GB">&nbsp;</p>\r\n<p class="western"><strong>Services:</strong></p>\r\n<ul>\r\n<li class="western">Well women clinic</li>\r\n<li class="western">Obstetric care: Prenatal checkups, Perinatal care, Delivery, Cesarean Section</li>\r\n<li class="western">General Gynecology: abnormal uterine bleeding, Chronic pelvic pain</li>\r\n<li class="western">Infertility care</li>\r\n<li class="western">Gynecological malignancies: Cancer cervix, Ovary, Preventive opportunistic screening.</li>\r\n<li class="western">Operation service: TAH, VH, LAVH, TLH, colposuspesion, Genital surgeries, Hysteroscopic surgeries</li>\r\n</ul>	The Department of Obstetrics and Gynaecology offers the full spectrum of women’s health care services. We offer state-of-the-art technologies with superior care providing a range of services such as p	{}	\N	\N	\N	/media/uploads/services/1689782282379.png	\N	\N	\N	\N	\N	\N	blog	publish	\N	4	2023-08-22 14:47:27.134694+05:45
20	Department-of-Dermatology	Department of Dermatology	<p class="western"><br><br></p>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Skin being the largest organ of the human body and first line defense needs utmost care and priority. Department of Dermatology excels at diagnosing and treating conditions affecting the skin, hair and nails. </span></span></span><span style="color: #191919;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">We are committed to advancing the field of dermatology through field- clinical innovation, leading education and exceptional patient care.</span></span></span></p>\r\n<p class="western"><span style="color: #080808;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Individual seeking answers about diseases of the skin, mucous membranes and nails, hair loss, and facial aging find the help they need&nbsp;at our department.</span></span></span></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><span style="color: #1f4e79;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Services:</span></span></span></p>\r\n<ul>\r\n<li>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Medical, surgical and cosmetic dermatology services</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Patch testing services for allergic contact dermatitis</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Punch biopsy for diagnosis</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Anti-aging treatment </span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Hair transplant </span></span></span></p>\r\n</li>\r\n</ul>	\r\n\r\n\r\n\r\nSkin being the largest organ of the human body and first line defense needs utmost care and priority. Department of Dermatology excels at diagnosing and treating conditions affecting the skin, hai	{}	\N	\N	\N	/media/uploads/services/1692693578948.png	\N	\N	\N	\N	\N	\N	blog	publish	\N	19	2023-08-22 14:24:51.659562+05:45
21	Department-of-hematology	Department of hematology	<p><strong>Department of hematology</strong> is concerned with the study of blood and bone marrow in health and disease. The department is responsible for treatment of all hematological disorders according to internationally accepted guidelines and protocols. The department is a center of expertise for the treatment of blood and lymph-node diseases.</p>\r\n<p><br>Our doctors shall take time to listen to your concerns and are dedicated to doing what is medically best for every patient.<br>Our constant effort is to advance our knowledge and methods which puts us at the extreme edge of what is possible, offering superlative clinical quality. We provide consultative services and accept referrals from family physicians and specialists. Our scope of practice includes treating patients with primary hematological problems or secondarily due to other etiology.<br>We provide patient care on OPD basis or in-patient, further also as day-care for chemotherapy, for which hematologists with significant expertise in various blood disorders participate in providing innovative comprehensive diagnosis and treatment.<br>Hematologist with thorough knowledge in scientific laboratory matters and sound clinical skills make them ability to follow through from diagnosis to prognosis to treatment.<br>We &nbsp; are treating wide spectrum of conditions related to hematology from Iron deficiency anemia, Iron-refractory iron deficiency anemia (IRIDA), Lymphoma to Leukemia, and are focused on care for cure with involvement of consultant, registrar, nurses, lab scientist and biology scholar.</p>\r\n<p><br>Services:<br>&nbsp; &nbsp; &bull; OPDs: Hematology OPD, Leukemia and Lymphoma clinic, post BMT follow up OPD.&nbsp;<br>&nbsp; &nbsp; &bull; Chemotherapy/ IP care/ Day care services&nbsp;<br>&nbsp; &nbsp; &bull; Blood component transfusion&nbsp;<br>&nbsp; &nbsp; &bull; Comprehensive Blood Profile including cellular indices&nbsp;<br>&nbsp; &nbsp; &bull; Diagnostic Bone marrow aspiration/ biopsy with interpretation &nbsp;<br>&nbsp; &nbsp; &bull; Consultative Hematology&nbsp;</p>\r\n<p>Near time services available:</p>\r\n<p>&nbsp; &nbsp; &bull; Apheresis service for blood component&nbsp;<br>&nbsp; &nbsp; &bull; Flow-cytometry for immunophenotype</p>	Department of hematology is concerned with the study of blood and bone marrow in health and disease. The department is responsible for treatment of all hematological disorders according to internation	{}	\N	\N	\N	/media/uploads/services/1692693791195.png	\N	\N	\N	\N	\N	\N	blog	publish	\N	8	2023-08-22 14:28:27.521818+05:45
22	Department-of-Nephrology	Department of Nephrology	<p>Our department of Nephrology deals with finding the correct diagnosis and treatment of kidney-related diseases. Every human body has two kidneys; which are responsible for removing waste products and excess fluid from the body. They are also critical for retaining fluid of the body and maintaining electrolyte concentrations that may be subjected to change due to numerous pathology.<br>Our consultant is expert in all facets of kidney disease including management of acute and chronic kidney disease, dialysis management, genetic kidney disease, glomerulonephritis, complicated hypertension management and electrolyte and acid base disorders.</p>\r\n<p><br>Services:<br>&nbsp; &nbsp; &bull; Renal disease counseling and management&nbsp;<br>&nbsp; &nbsp; &bull; Hemodialysis&nbsp;<br>&nbsp; &nbsp; &bull; 24 hr. emergency Dialysis facility&nbsp;<br>&nbsp; &nbsp; &bull; Renal Biopsy and further diagnostic workup&nbsp;<br>&nbsp; &nbsp; &bull; Renal clinics (Nephrology clinic, HD clinic, Screening of renal dysfunction.)&nbsp;<br>&nbsp; &nbsp; &bull; AV Fistula surgery&nbsp;<br>&nbsp; &nbsp; &bull; Managing target organ damage due to chronic diseases &nbsp;like &nbsp;diabetes and hypertension on the kidneys<br>&nbsp; &nbsp; &bull; Diagnosing and managing Autoimmune diseases including lupus and autoimmune vasculitis</p>\r\n<p>Faculty:<br>Dr DM MD MBBS&nbsp;</p>	Our department of Nephrology deals with finding the correct diagnosis and treatment of kidney-related diseases. Every human body has two kidneys; which are responsible for removing waste products and 	{}	\N	\N	\N	/media/uploads/services/1692694236871.png	\N	\N	\N	\N	\N	\N	blog	publish	\N	21	2023-08-22 14:35:48.813943+05:45
23	Department-of-Clinical-Laboratory	Department of Clinical Laboratory	<p>As the famous sayings &ldquo;Stitches in time saves nine&rdquo;, there are numerous diseases which are gradually developing inside the body due to ageing/ environment etc and will ultimately declare in due course of time, or incidentally detected as full blown disease. Some diseases have subtle findings and will be delayed till it becomes advanced disease. So, in the well persons clinic, a person is advised for physical examination and laboratory tests as per the age recommendation and international screening recommendations to find out &nbsp;the latent disease and also for the promotion of health. This in long term will lead to increase the chances of cure of disease and also enhance quality of life. With aim of assuring individual to be healthy and to detect early curable disease, we have established Well Person clinic where an individual without any visible complains can talk and consult with our health care provider and get benefitted from the evaluation.&nbsp;</p>\r\n<p><br>Services :<br>&nbsp; &nbsp; &bull; Teach you ways to make better decisions about your health to prevent disease. For example, your PCP can guide efforts to quit smoking, eat more nutritious foods or manage stress<br>&nbsp; &nbsp; &bull; Make sure your vaccines are up to date to prevent illnesses<br>&nbsp; &nbsp; &bull; Suggest screening tests to detect problems before you even notice them (like a mammogram for breast cancer)<br>&nbsp; &nbsp; &bull; Help you manage long-term health problems<br>&nbsp; &nbsp; &bull; Find a medical specialist if you need one&nbsp;</p>\r\n<p>Experts:</p>\r\n<p>Nurse/Paramedics<br>General Physician (GP)<br>Senior Medical Officer</p>	As the famous sayings “Stitches in time saves nine”, there are numerous diseases which are gradually developing inside the body due to ageing/ environment etc and will ultimately declare in due course	{}	\N	\N	\N	/media/uploads/services/1692694370830.png	fnff	ffbfb	\N	\N	\N	\N	blog	publish	\N	17	2023-08-22 22:23:52.257416+05:45
9	Department-of-Orthopaedic-Surgery	Department of Orthopaedic Surgery	<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">The Department of Orthopaedics at National City Hospital stands as a beacon of advanced medical care, offering a comprehensive range of services that encompass Fractures, Trauma, Arthroscopy, Sports Injuries, Orthopaedic Oncology, and Rehabilitation. With a dedicated team of skilled orthopaedic specialists, cutting-edge technology, and a patient-centered approach, the department strives to provide the highest quality care to its patients.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">The department's current services are a testament to their commitment to addressing a wide spectrum of orthopaedic conditions. From the delicate intricacies of Arthroscopy to the complexities of Orthopaedic Oncology, each area is handled with expertise and precision. The inclusion of Rehabilitation services underscores their holistic approach to patient well-being, ensuring a smoother path to recovery.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Looking ahead, the department has ambitious plans to further expand its offerings. The imminent introduction of services in Joint Replacement and Spine Surgery, among other Orthopaedic subspecialties, demonstrates their dedication to constant improvement and evolution. This gradual expansion enables them to cater to a broader array of patient needs, all within the familiar walls of National City Hospital.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Central to the department's ethos is the promise to provide outstanding care at an affordable cost. This commitment sets them apart as champions of accessible healthcare, ensuring that patients can access state-of-the-art treatments without financial strain. By harmonizing quality and affordability, the department aims to alleviate the burden on patients and their families.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">In essence, the Department of Orthopaedics at National City Hospital isn't just a medical facility; it's a sanctuary of innovation, compassion, and expertise. Through their current services and their ambitious future plans, they exemplify the fusion of medical excellence and patient-centered care. As they embark on their journey towards offering Joint Replacement, Spine Surgery, and various Orthopaedic subspecialties, their unwavering commitment to exceptional yet affordable healthcare remains steadfast.</span></span></span></span></p>	At National city Hospital, we can take care of any problem you may face in your bones joints.	{}	\N	\N	\N	/media/uploads/services/1689782572372.jpeg	\N	\N	\N	\N	\N	\N	blog	publish	\N	5	2023-08-22 13:53:10.635662+05:45
10	Department-of-Urology	Department of Urology	<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Welcome to the Urology Department at NCH, where we specialize in the diagnosis and treatment of a diverse range of urinary and genital issues. Our dedicated team is committed to ensuring rapid and accurate diagnoses, as well as providing effective treatments for various urological conditions.</span></span></span></p>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Our comprehensive care spans diseases of the kidneys, ureters, urinary bladder, prostate, urethra, and male reproductive organs. This includes ailments like stones, hematuria, urinary tract infections, retention or incontinence, prostate concerns, infertility, impotence, and genitourinary cancers.</span></span></span></p>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">In line with modern medical advancements, our focus is on delivering minimally invasive treatment options. This approach is particularly evident in the majority of stone and prostate treatments, resulting in improved outcomes and quicker recovery times that allow patients to return home sooner.</span></span></span></p>\r\n<p><strong><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Our expertise encompasses a wide array of urological disciplines, including:</span></span></span></strong></p>\r\n<ol>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Endourology, covering procedures such as PCNL, TURP, and RIRS</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Minimally Invasive/Laparoscopic Surgery</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Management of Urinary Tract Stone Diseases</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Prostate Biopsy</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Pediatric Urology</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Reconstructive Urology</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Female Urology</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">VVF Repair</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Andrology, with a focus on Male Infertility</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Urethral Problems</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Chronic Pelvic Pain</span></span></span></p>\r\n</li>\r\n<li>\r\n<p><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Uro-Oncology (Cancer ) Surgery in Cancers of the Kidney, Ureter, Urinary Bladder, Testis, and Penis.</span></span></span></p>\r\n</li>\r\n</ol>\r\n<p><strong><span style="color: rgb(55, 65, 81); --darkreader-inline-color: #d3c8b5;" data-darkreader-inline-color=""><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">At NCH, we are dedicated to providing you with advanced and compassionate care, aiming to restore your health and quality of life.</span></span></span></strong></p>	At National city, we are committed to kidney and genito-urinary health in an effort to improve the quality of life for all of our patients with the help of our highly specialized doctors along with th	{}	\N	\N	\N	/media/uploads/services/1689782733772.jpeg	HHH	\N	\N	\N	\N	\N	blog	publish	\N	6	2023-08-20 17:54:51.174087+05:45
16	Department-of-Medical-Oncology	Department of Medical Oncology	<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">The <strong>Medical Oncology</strong> department at NCH comprises a compassionate and dedicated team of specialists who practice evidence-based medicine. We offer medical expertise for the prevention, diagnosis, and treatment of solid and hematological malignancies in adults. Our patient care services span a wide spectrum of oncological divisions, including Breast, Gastrointestinal, Head &amp; Neck, Lung, Bone, Soft Tissue Sarcomas, Gynecological Oncology, Urological Oncology, Leukemia, and Lymphoma. Within our department, we provide chemotherapy services to both inpatients and daycare patients.</span></span></span></p>\r\n<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">&nbsp;Our approach involves specialized methods of administering chemotherapy, including the use of indwelling catheters and chemo ports, intravesical chemotherapy, and intra-thecal chemotherapy. Rest assured, our team is committed to delivering the highest standards of care, ensuring your well-being</span></span></span></p>	The Medical Oncology department at NCH comprises a compassionate and dedicated team of specialists who practice evidence-based medicine. We offer medical expertise for the prevention, diagnosis, and t	{}	\N	\N	\N	/media/uploads/services/1692537514312.jpeg	\N	\N	\N	\N	\N	\N	blog	publish	\N	15	2023-08-22 14:05:52.420465+05:45
17	Department-of-Anaesthesiology	Department of Anaesthesiology	<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Welcome to our Anesthesiology Department, where safety, consistency, and continuous peri-operative care are our top priorities. Our team supports patients undergoing a wide range of surgeries, from emergency and routine general procedures to gastrointestinal, gynecological, orthopedic, trauma, endoscopic, ENT, dental, maxilla-facial, thoracic, vascular, burn, and plastic surgeries. Our state-of-the-art facility boasts four modular operation theatres, ensuring a conducive environment for successful outcomes.</span></span></span></p>\r\n<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Our scope extends beyond the operation theatre (OT). We provide expert anesthesia services in the Gastroenterology suite, aiding endoscopic and colonoscopic procedures. Our involvement also extends to the radiology department, where we provide sedation for MRI, CT scans, and image-guided biopsies. Additionally, we promptly respond to emergency calls for help and Cardio Pulmonary Resuscitation (CPR) from different wards and units. Services encompass difficult venous access, jugular catheter insertion, permanent catheter (perma-cath) placement, as well as pain intervention procedures like epidural analgesia and regional blocks.</span></span></span></p>\r\n<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Embracing advanced technology and contemporary pain management techniques (such as short-acting anesthetics, regional blocks, and specialized methods), we conduct numerous surgical procedures in the ambulatory or outpatient setting. This approach allows patients to undergo their procedure on the same day they arrive at the hospital, ensuring a safe, convenient, and cost-effective experience.</span></span></span></p>\r\n<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">Our commitment to patient care knows no bounds. Our anesthesia services are available round the clock, seven days a week. With the utilization of cutting-edge technology and proven techniques, we prioritize patient comfort and safety throughout the peri-procedural period. Our dedication to maintaining the highest standards within our specialty remains unwavering.</span></span></span></p>\r\n<p class="western"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;"><span style="font-size: medium;">For your convenience, we offer a Pre-Anesthesia Checkup (PAC) Clinic, an essential step for all patients requiring anesthesia services. Outpatients can avail themselves of PAC at our clinic, conveniently located within the operation theatre premises. For inpatients, we conduct PAC at the bedside, ensuring a seamless experience.</span></span></span></p>	Welcome to our Anesthesiology Department, where safety, consistency, and continuous peri-operative care are our top priorities. Our team supports patients undergoing a wide range of surgeries, from em	{}	\N	\N	\N	/media/uploads/services/1692537514312.jpeg	\N	\N	\N	\N	\N	\N	blog	publish	\N	10	2023-08-22 14:07:31.25717+05:45
18	Department-of-Pathology-Laboratory-Medicine	Department of Pathology & Laboratory Medicine	<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><strong>The Department of Pathology &amp; Laboratory Medicine</strong> is a prime resource for clinical laboratory services required for innovative patient care, research and educational programs. We combine the sophisticated testing and informatics with capabilities of automated laboratories for delivery of clinical laboratory and pathology services. In an era of evidence based medicine more than 60% of clinical decisions are performed based on the laboratory findings. </span></span></p>\r\n<p class="western" align="justify"><span class="sd-abs-pos"><img src="/media/uploads/services/1692693156387.png" width="801" height="372" name="Picture 1" border="0"> </span><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Correct diagnosis is the root of appropriate treatment for which our department is fully dedicated for precise and accurate lab reports. We are equipped with world renowned brand Beckman Coulter Diagnostics, a giant in diagnostics and life sciences from USA. The target of high sensitivity and specificity is achieved with regular internal quality control as well as external ones.</span></span></p>\r\n<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">We are providing service in an area of around 2000 sq. feet with expert human resources including pathologist, microbiologist, lab technologist and phlebotomist.</span></span></p>\r\n<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Good phlebotomist, friendly and caring hands from the lab staffs are our asset which won&rsquo;t let you disappoint. </span></span></p>\r\n<ul>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #833c0b;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Ideal lab reports are the reflection of your body status</span></span></span><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"> -</span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" align="justify"><span style="color: #1f4e79;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Services :</span></span></span></p>\r\n<ul>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Surgical &nbsp;Pathology: Histopathology </span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Cytopathology (Exfoliative and FNA)</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Clinical Pathology: Routine blood tests, Tumor markers, Organ specific tests.</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Microbiology &amp; Immunology: Urine/blood/pus/fluid culture</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Hemato pathology: Peripheral blood smear / Bone marrow aspiration/Biopsy</span></span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" align="justify">&nbsp;</p>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Services going to establish in near time:</span></span></span></p>\r\n<ul>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Transfusion Medicine/Apheresis</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Electrophoresis</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Flowcytometry</span></span></span></p>\r\n</li>\r\n<li>\r\n<p class="western" align="justify"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">TB-Polymerase Chain Reaction</span></span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western" align="justify"><span style="color: #1f4e79;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Human resources:</span></span></span></p>\r\n<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Dr Rejina Shahi, MD ( Pathology) MBBS </span></span></p>\r\n<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Mr. Yubraj &hellip; BSc MLT</span></span></p>\r\n<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Mr Saurav BSc MLT </span></span></p>\r\n<p class="western" align="justify"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Ms. Melina Ale CMLT</span></span></p>	The Department of Pathology & Laboratory Medicine is a prime resource for clinical laboratory services required for innovative patient care, research and educational programs. We combine the sophistic	{}	\N	\N	\N	/media/uploads/services/1692693156387.png	\N	\N	\N	\N	\N	\N	blog	publish	\N	16	2023-08-22 14:19:05.375867+05:45
19	Department-of-Emergency	Department of Emergency	<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Emergency medicine is an accelerated medicine and here we are with an professional team to take care and intervene for survival of the seriously ill patient.</span></span></p>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Our staffs are being trained for basic life support, advanced life support and PALS as well which will provide standard of care while treating the patient. 24x7 availability of medical doctors and paramedics with an experienced hand and team lead by the Emergency medicine consultant with well-equipped emergency ward with 12 beds, triage area and one resuscitation room.</span></span></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><img src="/media/uploads/services/1692693456706.png" width="750" height="425" name="Picture 4" align="left" hspace="12"> <br clear="left"><br><br></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><span style="color: #002060;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Services:</span></span></span></p>\r\n<ul>\r\n<li>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Emergency services with any health issues. </span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Management of Road traffic Accident cases </span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Point of care imaging services (eg: FAST)</span></span></p>\r\n</li>\r\n<li>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Medical /Surgical Procedures</span></span></p>\r\n</li>\r\n</ul>\r\n<p class="western"><br><br></p>\r\n<p class="western"><span style="color: #002060;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Experts:</span></span></span></p>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Care is delivered by team of doctors under the guidance of MDs </span></span></p>\r\n<p class="western"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Paramedics </span></span></p>	Emergency medicine is an accelerated medicine and here we are with an professional team to take care and intervene for survival of the seriously ill patient.\r\n\r\nOur staffs are being trained for basic li	{}	\N	\N	\N	/media/uploads/services/1692693456706.png	\N	\N	\N	\N	\N	\N	blog	publish	\N	22	2023-08-22 14:22:57.266879+05:45
24	General-Medicine-Service	General Medicine Service	<p><strong>General medicine</strong> is a medical specialty that deals with the prevention, diagnosis, and treatment of adult diseases1. It is also known as internal medicine in some countries2. General medicine covers a wide range of topics, such as cardiology, endocrinology, gastroenterology, hematology, infectious diseases, nephrology, neurology, and more3.</p>\r\n<p><br>In Our Hospital, dedicated group of General Medicine experts work in team to care for the patients.</p>\r\n<p><strong>General Preventive health check ups</strong><br><strong>Diabetes care</strong><br><strong>Hypertension care</strong></p>	General medicine is a medical specialty that deals with the prevention, diagnosis, and treatment of adult diseases1. It is also known as internal medicine in some countries2. General medicine covers a	{}	\N	\N	\N	/media/uploads/services/1689783158924.jpeg	\N	\N	\N	\N	\N	\N	blog	publish	\N	12	2023-08-22 20:15:37.79109+05:45
\.


--
-- Data for Name: department; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.department (pk, department_name, "publishedOn") FROM stdin;
2	Neurology	\N
3	Gastroenterology, Hepatology and Endoscopy	\N
4	Obstetrics And Gynaecology	\N
5	Orthopaedic Surgery	\N
6	Urology	\N
7	ENT-Head And Neck Surgery	\N
8	Hematology	\N
10	Anesthesiology	\N
11	General Surgery and Urology	\N
12	Medicine	\N
13	Maxiofacial  Surgery	\N
14	ICU	\N
15	Medical Oncology	\N
16	Pathology	\N
17	Clinical laboratory	\N
18	Radiology and medical imaging	\N
19	Dermatology	\N
20	Endoscopy	\N
21	Nephrology	\N
22	Emergency	\N
23	Admin	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.employees (pk, name, email, slug, mobile, landline, designation, cover, stages, display_order, content, tags, department_id, "publishedOn", type, edit) FROM stdin;
5	Dr. Nirmal Lamichhane	\N	Dr-Nirmal-Lamichhane	\N	\N	Doctor	/media/uploads/employees/1689784364756.png	publish	1	<p>Dr. Nirmal is a doctor who specializes in diagnosing and treating diseases of the urinary system. This system keeps the body clean by filtering out wastes and toxins and taking them out of the body. The urinary tract includes:</p>\r\n<ul>\r\n<li>Bladder.</li>\r\n<li>Kidneys.</li>\r\n<li>Ureters.</li>\r\n<li>Urethra.</li>\r\n</ul>\r\n<p>He also treats conditions involving the reproductive organs and the adrenal glands. The adrenal glands are located on top of the kidneys. The reproductive systems of males&nbsp;and&nbsp;females&nbsp;are linked closely to their urinary systems</p>	{#urology}	6	2023-08-20 17:58:13.795765+05:45	\N	\N
11	Dr Rajiv Shah	\N	Dr-Rajiv-Shah	\N	\N	Doctor	\N	publish	2	<p>Dr Rajiv Shah is a doctor who specializes in diagnosing and treating diseases of the urinary system. This system keeps the body clean by filtering out wastes and toxins and taking them out of the body. The urinary tract includes:</p>\r\n<ul>\r\n<li>Bladder.</li>\r\n<li>Kidneys.</li>\r\n<li>Ureters.</li>\r\n<li>Urethra.</li>\r\n</ul>\r\n<p>He also treats conditions involving the reproductive organs and the adrenal glands. The adrenal glands are located on top of the kidneys. The reproductive systems of males&nbsp;and&nbsp;females&nbsp;are linked closely to their urinary systems</p>	{#urology}	6	2023-08-20 17:58:22.159527+05:45	\N	\N
12	Dr Sudip raj KC	\N	Dr-Sudip-raj-KC	\N	\N	Doctor	\N	publish	3	<p>Dr Sudip raj KC is a doctor who specializes in diagnosing and treating diseases of the urinary system. This system keeps the body clean by filtering out wastes and toxins and taking them out of the body. The urinary tract includes:</p>\r\n<ul>\r\n<li>Bladder.</li>\r\n<li>Kidneys.</li>\r\n<li>Ureters.</li>\r\n<li>Urethra.</li>\r\n</ul>\r\n<p>He also treats conditions involving the reproductive organs and the adrenal glands. The adrenal glands are located on top of the kidneys. The reproductive systems of males&nbsp;and&nbsp;females&nbsp;are linked closely to their urinary systems</p>	{#urology}	6	2023-08-20 18:02:03.329901+05:45	\N	\N
13	Dr Sagar Khatiwada	\N	Dr-Sagar-Khatiwada	\N	\N	Doctor	\N	publish	4	<p>Dr Rajiv Shah is a doctor who specializes in diagnosing and treating diseases of the urinary system. This system keeps the body clean by filtering out wastes and toxins and taking them out of the body. The urinary tract includes:</p>\r\n<ul>\r\n<li>Bladder.</li>\r\n<li>Kidneys.</li>\r\n<li>Ureters.</li>\r\n<li>Urethra.</li>\r\n</ul>\r\n<p>He also treats conditions involving the reproductive organs and the adrenal glands. The adrenal glands are located on top of the kidneys. The reproductive systems of males&nbsp;and&nbsp;females&nbsp;are linked closely to their urinary systems</p>	{#urology}	6	2023-08-20 18:09:11.193052+05:45	\N	\N
14	\N	\N	\N	\N	\N	\N	\N	draft	\N	\N	{}	\N	2023-08-22 12:51:48.186692+05:45	\N	\N
6	Dr. Sudeep Man Vaidhya	\N	Dr-Sudeep-Man-Vaidhya	\N	\N	Doctor	/media/uploads/employees/1689784516922.png	publish	1	<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Step into the realm of exceptional orthopedic care at National City Hospital, where expertise and compassion converge to redefine the healthcare experience. It is our privilege to introduce the distinguished Dr. Sudeep Man Vaidya, a Senior Consultant Orthopedic Surgeon specializing in Trauma, Arthroscopy, and Sports injuries.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">With a remarkable journey spanning decades, Dr. Vaidya's illustrious career is a testament to his unwavering dedication and exemplary skills. He graduated from Karnatak University in 1990 and subsequently completed his post-graduation in Orthopaedics from Mumbai in 1995. Dr. Vaidya's thirst for knowledge led him to diverse experiences that shaped his expertise. He spent six significant years at Birendra Police Hospital, adeptly managing extensive injuries during the Maoist insurgency, followed by another five years at Patan Hospital, where he laid the foundation for the orthopedic department.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Drawing from over 11 years of extensive practice in Kathmandu, Dr. Vaidya embarked on a transformative journey to Bharatpur, Chitwan. Here, he established operative orthopedics, catering to Chitwan and the surrounding districts, instilling confidence and trust among patients. His prowess was further affirmed through prestigious accolades, including the Fellow of the Royal College of Orthopaedic Surgeons of Thailand in 2003, MCh. Orthopaedics in 2012 from USAIM, and fellowships in joint replacement from Mumbai in 2000 and Fellowship in Sports Injuries from Sports Injury Centre, New Delhi in 2015.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Dr. Vaidya's leadership extends beyond surgical excellence. As a founding member of the Nepal Orthopaedic Association (NOA) and a driving force behind the Chitwan branch of NOA since 2012, serving as president from 2019 to 2021, he has actively shaped the field of orthopedics. Notably, his role as President of the Arthroscopy Society of Nepal underscores his commitment to advancing specialized care. He also had the honor of representing Nepal as a National delegate in the Asia Pacific Trauma Society from 2020 to 2022.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Since joining National City Hospital in 2019, Dr. Vaidya envisions transforming the institution into a premier orthopedic center. With a comprehensive approach encompassing trauma care, arthroscopy, sports injuries, orthopedic oncology, spine, and joint replacements, his presence augments the hospital's mission to redefine orthopedic healthcare.</span></span></span></span></p>\r\n<p><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><span style="color: #374151;"><span style="font-family: Segoe UI, serif;">Experience the synergy of innovation, expertise, and patient-centered care under the guidance of Dr. Sudeep Man Vaidya. Join us in witnessing the evolution of orthopedics at National City Hospital, where he aspires to establish a pioneering orthopedic department, setting new standards of excellence in the region.</span></span></span></span></p>\r\n<p class="western"><br><br></p>	{#trauma,#orthopaedic,#sportsInjury,#arthroscoy}	5	2023-08-22 13:55:23.617965+05:45	\N	\N
8	Dr. Barun Shrestha	\N	Dr-Barun-Shrestha	\N	\N	Doctor	/media/uploads/employees/1689785009508.png	publish	1	<p class="western" lang="en-GB"><span style="font-family: Times New Roman, serif;"><span lang="en-US">Associate.Prof.Dr.Barun Shrestha, the Department of Gastroenterology, Hepatology and Endoscopy features state-of-the-art facilities for the management of a wide variety of gastrointestinal-related diseases and their complications, liver disorders, pancreatic and biliary tract diseases and many other digestive problems. </span></span></p>	{#endoscopy,#hepatology,#gastoenterolog}	3	2023-08-22 14:45:46.957426+05:45	\N	\N
7	Dr. Nirmala Laxmi Shrestha Singh 	\N	Dr-Nirmala-Laxmi-Shrestha-Singh	\N	\N	Chief Consultant and Head of Department	/media/uploads/employees/1689784756923.jpeg	publish	1	<p lang="en-GB"><span style="font-size: 14pt;"><strong>Education</strong></span></p>\r\n<ul>\r\n<li>\r\n<p lang="en-GB">MBBS from Darbhanga Medical Collage</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB">DGO from IOM &ndash; TUTH</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB">MD from National Academy for Medical Science (NAMS)</p>\r\n</li>\r\n</ul>\r\n<p lang="en-GB"><strong><span style="font-size: 14pt;">Training and trainer</span></strong></p>\r\n<ul>\r\n<li>\r\n<p lang="en-GB">Advanced Skill Birth Attendant (ASBA)</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB">Skill Birth Attendant (SBA)</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB">Comprehensive Abortion Care (CAC)</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB">Female Sterilization (Minilap and laparoscopy)</p>\r\n</li>\r\n</ul>\r\n<p lang="en-GB"><strong><span style="font-size: 14pt;">Membership</span></strong></p>\r\n<ul>\r\n<li>\r\n<p lang="en-GB">Nepal Medical Association (NMA)</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB" align="left">Life time membership of Nepal Cancer society</p>\r\n</li>\r\n<li>\r\n<p lang="en-GB" align="left">Nepal Society of Obstetricians and Gynaecologist (NESOG)</p>\r\n</li>\r\n</ul>	{#obstetrics,#gynaecology}	4	2023-08-22 14:50:18.712665+05:45	\N	\N
4	Dr. Dilip Karmacharya	\N	Dr-Dilip-Karmacharya	\N	\N	Doctor	/media/uploads/employees/1689784010827.png	publish	1	<p>Dilip Karmacharya is a surgeon who specialises in managing patients with diseases affecting the senses such as hearing, balance, smell and taste, as well as problems with breathing, swallowing, and voice. He also treats head and neck tumours, including skull base and interface with the brain</p>\r\n<p class="western">Dr Dilip have 15 more years of work experience in the field of Head and neck oncology. He also works at B P Koirala Memorial Cancer Hospital.</p>	{#ent-head-and-n,#head-surgery,#neck-surgery}	7	2023-08-22 14:53:23.109807+05:45	\N	\N
15	Dr Sushil Adhikari	\N	Dr-Sushil-Adhikari	\N	\N	Doctor	\N	publish	2	<p class="western" align="justify"><span style="color: #222222;"><span style="font-family: Times New Roman, serif;"><span style="font-size: large;">Dr Sushil Adhikari is a Consultant Orthopedic Surgeon practicing in General trauma, Replacement surgery with special interest in orthopedic Onco-surgery. He is dedicated to offer quality health care service to patients. He has graduated from B.P. Koirala Institute of Health sciences Dharan and completed his Masters degree from NAMS; Bir Hospital. He has also received Orthopedic Oncological training from Forth Tumor Hospital of Hebei, China</span></span></span><span style="color: #222222;"><span style="font-family: Times New Roman, serif;"><span style="font-size: large;"><em>.</em></span></span></span><span style="color: #222222;"><span style="font-family: Times New Roman, serif;"><span style="font-size: large;"> He is currently practicing as specialist orthopedic surgeon in a government based tertiary care cancer hospital in Chitwan for the last 12 years. He is expertise in bone and soft tissue tumors of different parts of body and successfully does replacement surgery of Knee, Hip, Shoulder and Elbow of such cases. He is passionate to offer quality health care service to patients in a holistic way. Comprehensive care of tumor and cancer of bone and soft tissue is possible with thorough clinical evaluation, early relevant imaging modality, timely surgery with adjuvant care after surgery. Minimal invasive procedures like core biopsy, image intensifier guided spine core biopsy, mini incision salvage surgery for Osteosarcoma, Ewings sarcoma, advance bone tumors and soft tissue sarcoma and endoscopic guided spine surgery procedure makes early recovery with less morbidity to patients.&nbsp; </span></span></span></p>\r\n<p class="western" align="justify"><span style="color: #222222;"><span style="font-family: Times New Roman, serif;"><span style="font-size: large;">Early effective quality service to offer disease free mobility of patient with bone and soft tissue tumor is his motto of treatment. </span></span></span></p>\r\n<p class="western"><br><br></p>	{#orthopaedic}	5	2023-08-22 13:58:02.974114+05:45	\N	\N
16	Dr. Bhola Rauniyar	\N	Dr-Bhola-Rauniyar	\N	\N	Doctor	\N	publish	1	\N	{#oncology}	15	2023-08-22 14:08:56.053822+05:45	\N	\N
17	Dr. Sushil Thapa	\N	Dr-Sushil-Thapa	\N	\N	Doctor	\N	publish	3	\N	{#orthopaedic}	5	2023-08-22 14:10:00.334339+05:45	\N	\N
18	Dr. Yugesh Raj Panta	\N	Dr-Yugesh-Raj-Panta	\N	\N	Doctor	\N	publish	4	\N	{#orthopaedic}	5	2023-08-22 14:10:32.359124+05:45	\N	\N
19	Dr. Sudhir Kumar Shrestha	\N	Dr-Sudhir-Kumar-Shrestha	\N	\N	Doctor	\N	publish	1	\N	{#anesthesiology}	10	2023-08-22 14:12:32.845726+05:45	\N	\N
20	Dr. Surendra Neupane	\N	Dr-Surendra-Neupane	\N	\N	Doctor	\N	publish	2	\N	{#anesthesiology}	10	2023-08-22 14:13:17.730545+05:45	\N	\N
21	Dr. Gul Vaidya	\N	Dr-Gul-Vaidya	\N	\N	Doctor	\N	publish	3	<p class="western"><span style="color: #000000;"><span style="font-family: Segoe UI, serif;"><span style="font-size: large;"><strong>Meet Dr. Gul Vaidya</strong>, a distinguished Senior Consultant Anaesthetist at National City Hospital. Graduating from Government Medical College Nagpur in 1989, she further pursued her post-graduation at the same esteemed institute in 1997. With a wealth of experience, Dr. Vaidya has spent years delivering anesthesia and managing ICUs at TU Teaching Hospital, Kathmandu for five years post-graduation. In 2005, she extended her services to Bharatpur, Chitwan, where she served at Asha Hospital until 2019 before joining the esteemed team at National City Hospital.</span></span></span></p>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Segoe UI, serif;"><span style="font-size: large;">A dedicated and passionate professional, Dr. Vaidya's commitment to her field is evident through her meticulous attention to patient safety during anesthesia procedures. Her enthusiasm also extends to teaching the next generation of medical practitioners. With her profound knowledge and years of experience, Dr. Vaidya continues to leave an indelible mark on the field of anesthesiology.</span></span></span></p>	{#anesthesiology}	10	2023-08-22 14:14:11.921666+05:45	\N	\N
22	Dr. Rajina Sahi	\N	Dr-Rajina-Sahi	\N	\N	Doctor	\N	publish	1	<p><span style="font-family: Helvetica Neue, serif;">Dr. Rajina Sahi is an experienced Pathologist working in this field for 11 years till now. She is a highly skilled professional in Surgical Pathology and Clinical Pathology. She had working experience as Consultant Pathologist in various renowned hospitals of Nepal like B. P Koirala Memorial Cancer Hospital, Bhaktapur Cancer Hospital and College of Medical Sciences- Teaching Hospital. </span></p>\r\n<p>&nbsp;</p>\r\n<p><span style="font-family: Helvetica Neue, serif;"><u>Education</u></span></p>\r\n<p>&nbsp;</p>\r\n<p><span style="font-family: Helvetica Neue, serif;">MBBS: Xianjiaotong University, China</span></p>\r\n<p><span style="font-family: Helvetica Neue, serif;">MD: Kathmandu University</span></p>\r\n<p><span style="font-family: Helvetica Neue, serif;">COT: TATA Memorial Cancer Hospital, Mumbai </span></p>\r\n<p>&nbsp;</p>\r\n<p><span style="font-family: Helvetica Neue, serif;"><u>Special</u> <u>Interest</u></span></p>\r\n<p>&nbsp;</p>\r\n<p><span style="font-family: Helvetica Neue, serif;">Surgical Pathology, Clinical Pathology</span></p>	{#pathology}	16	2023-08-22 14:20:46.254642+05:45	\N	\N
3	Dr. Shankhar Bastakoti	\N	Dr-Shankhar-Bastakoti	\N	\N	Doctor	/media/uploads/employees/1689783933861.jpeg	publish	1	<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Dr. Bastakoti is an adept medical doctor and is dedicated to exemplary patient outcomes. He has strong focus on listening to and addressing patient concerns and answering all questions in terms patients can easily understand.&nbsp;He is specialized as the Hematologist who was educated and trained from Christian Medical College Vellore in field of clinical hematology and bone marrow transplantation. Beside patient care he is involved in research and already published quite a few articles in national and international journals. </span></span></span></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><span style="color: #1f4e79;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Education:</span></span></span></p>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">MBBS: </span></span></span><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><em>College of medical sciences &ndash;Chitwan, Kathmandu University </em></span></span></span></p>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">MD: </span></span></span><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><em>BP Koirala Institute of Health Sciences- Dharan </em></span></span></span></p>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Post-Doctoral Fellowship: </span></span></span><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;"><em>Christian Medical College, Vellore , India</em></span></span></span></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><span style="color: #1f4e79;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Special Interests: </span></span></span></p>\r\n<p class="western"><span style="color: #000000;"><span style="font-family: Times New Roman, serif;"><span style="font-size: medium;">Aplastic anemia, Hemoglobinopathies, bleeding disorders, myeloma, ITP, Leukemia /lymphoma and consultative Hematology. </span></span></span></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><img style="display: block; margin-left: auto; margin-right: auto;" src="/media/uploads/employees/1692693962442.png" width="512" height="300" name="Picture 10" align="bottom" border="0"></p>\r\n<p class="western"><br><br></p>\r\n<p class="western"><img style="display: block; margin-left: auto; margin-right: auto;" src="/media/uploads/employees/1692693988171.png" width="713" height="186" name="Picture 11" align="bottom" border="0"></p>\r\n<p class="western"><br><br></p>	{#ITP,#myeloma,#leukemia-lymph,#aplastic-anemi,#consultative-h,#hematology,#bleeding-disor,#hemoglobinopat}	8	2023-08-22 14:33:15.476813+05:45	\N	\N
24	Dr Bhola Pd Raunier	\N	Dr-Bhola-Pd-Raunier	\N	\N	Doctor	\N	publish	2	\N	{#medicine}	12	2023-08-22 14:42:12.540619+05:45	\N	\N
23	Dr Gauri Ram Mahato	\N	Dr-Gauri-Ram-Mahato	\N	\N	Doctor	\N	publish	1	\N	{#medicine}	12	2023-08-22 14:42:53.223658+05:45	\N	\N
25	Dr Binuma Shrestha	\N	Dr-Binuma-Shrestha	\N	\N	Doctor	\N	publish	2	<p class="western">MD with many years of experience in care of women&rsquo;s health. She is senior consultant gynecologist at BP Koirala Memorial Cancer Hospital in Bharatpur. She in trained from China , India, USA and UK. SShe has a special interest in early detection of cancer of cervix, its treatment. Surgical Treatment of cancer of uterine cervix, multimodality treatment of cancer of ovaries, and miscellaneous tumors.</p>	{#obstetrics,#gynaecology}	4	2023-08-22 14:50:41.571695+05:45	\N	\N
26	demo	\N	demo	\N	\N	md	/media/uploads/employees/1692722287616.jpeg	publish	1	<p>this is the demo employee</p>	{#admin}	23	2023-08-22 22:23:18.613757+05:45	\N	\N
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.feedback (pk, feedback_by, date, message, phone, email, "publishedOn") FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.files (pk, name, size, mime, path, md5sum, via, inode, route, tags, description, "publishedOn") FROM stdin;
1	1689354230882.png	8551	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689574299366.png	91279bf2-da3e-76b0-7241-efd7ad6346c7	\N	3465097	/media/uploads/services/1689574299366.png	{}	\N	2023-07-17 11:56:40.153238+05:45
2	a022d24416454043a08d02d2c220181e.jpeg	103648	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689575383344.jpeg	1f51b9a9-6e18-9734-58fd-8dd801635d79	\N	3283133	/media/uploads/employees/1689575383344.jpeg	{}	\N	2023-07-17 12:14:44.956039+05:45
3	23372e56e07a4cebaedbd049267ac6a0.jpeg	21300	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689575408687.jpeg	f2ad59d7-7197-4cac-884e-e1a90555573d	\N	3334524	/media/uploads/employees/1689575408687.jpeg	{}	\N	2023-07-17 12:15:09.236643+05:45
25	neuroscience-news-week.webp	108058	image/webp	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1690219336522.webp	27bf7c8f-8385-dd6d-afb6-3257d18a924d	\N	3449257	/media/uploads/services/1690219336522.webp	{}	\N	2023-07-24 23:07:17.105948+05:45
9	Gastroenterology.jpg	233799	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782080248.jpeg	75a156aa-3923-72d8-c305-5a3d8fb9f10e	\N	3449651	/media/uploads/services/1689782080248.jpeg	{}	\N	2023-07-19 21:39:40.957891+05:45
10	Obstetrics-Gynaecology.png	58749	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782282379.png	1db5b1d9-1578-912a-9dee-af475c90ffa8	\N	3449652	/media/uploads/services/1689782282379.png	{}	\N	2023-07-19 21:43:02.939911+05:45
11	ortho_knee-pain-xray-skeleton-iStock638414922.jpg	591045	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782572372.jpeg	b0ad28b4-f2e5-41e6-c4af-d3a4fdf7b729	\N	3449700	/media/uploads/services/1689782572372.jpeg	{}	\N	2023-07-19 21:47:52.960641+05:45
12	image2-1024x709.jpg	65566	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782733772.jpeg	87a4663c-26de-80f4-9fdd-baa74feaaf14	\N	3449804	/media/uploads/services/1689782733772.jpeg	{}	\N	2023-07-19 21:50:34.955271+05:45
13	Ears-Nose-Throat.jpg	26028	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782937354.jpeg	5350eb10-9e33-0140-22e8-959ba9d40ac0	\N	3451566	/media/uploads/services/1689782937354.jpeg	{}	\N	2023-07-19 21:53:57.892815+05:45
14	1529126668_2018_06_16.jpg	153746	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689783158924.jpeg	0749e066-557b-09af-f22e-6d7b2fadea90	\N	3451820	/media/uploads/services/1689783158924.jpeg	{}	\N	2023-07-19 21:57:39.476933+05:45
15	shankar.jpg	67780	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689783933861.jpeg	755093be-931d-1c90-90da-445b1d653e21	\N	3329795	/media/uploads/employees/1689783933861.jpeg	{}	\N	2023-07-19 22:10:34.90482+05:45
16	dilip.png	393172	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689784010827.png	fbc49914-7817-6b87-5bca-f3ca2bdeefd3	\N	3333062	/media/uploads/employees/1689784010827.png	{}	\N	2023-07-19 22:11:51.556874+05:45
17	nirmal.png	660335	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689784364756.png	d85d3124-ca1c-06ee-d0cc-13014a81d39f	\N	3333063	/media/uploads/employees/1689784364756.png	{}	\N	2023-07-19 22:17:45.408969+05:45
18	sudeep.png	386382	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689784516922.png	dddef3f5-8fd2-5c2f-edd6-9d2064b4ef57	\N	3333064	/media/uploads/employees/1689784516922.png	{}	\N	2023-07-19 22:20:17.975501+05:45
19	nirmala.jpg	155903	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689784756923.jpeg	bb910112-56d5-7eef-f602-eb134a60e9e0	\N	3333065	/media/uploads/employees/1689784756923.jpeg	{}	\N	2023-07-19 22:24:18.392178+05:45
22	barun.png	277608	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689785009508.png	abe13d1e-da50-8d69-20a1-14c9668d6606	\N	3333066	/media/uploads/employees/1689785009508.png	{}	\N	2023-07-19 22:28:30.216405+05:45
24	nirmala.jpg	155903	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/0a98154b09b04782b4219e49dc68b835.jpeg	\N	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689784756923.jpeg	3333065	/media/uploads/employees/0a98154b09b04782b4219e49dc68b835.jpeg	{}	\N	2023-07-24 15:03:18.733239+05:45
27	Ears-Nose-Throat.jpg	26028	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/305378d95a744bbdaf23abea8b8778bc.jpeg	\N	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782937354.jpeg	3451566	/media/uploads/services/305378d95a744bbdaf23abea8b8778bc.jpeg	{}	\N	2023-07-24 23:07:53.276868+05:45
29	sudeep.png	386382	image/png	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/ff3ee3d43fb14c48beb3e41e3a6f3d09.png	\N	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/employees/1689784516922.png	3333064	/media/uploads/employees/ff3ee3d43fb14c48beb3e41e3a6f3d09.png	{}	\N	2023-07-25 01:10:27.357448+05:45
31	Ears-Nose-Throat.jpg	26028	image/jpeg	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/59a1ca27a2244981a9a44453fc2972cd.jpeg	\N	/home/azezal/Documents/creative/hospital/hospital-app/media/uploads/services/1689782937354.jpeg	3451566	/media/uploads/services/59a1ca27a2244981a9a44453fc2972cd.jpeg	{}	\N	2023-07-29 17:07:25.942163+05:45
32	experience.png	41652	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537307235.png	81961cf1-dbe1-5324-65e5-e2281d6fc829	\N	1650017	/media/uploads/services/1692537307235.png	{}	\N	2023-08-20 19:00:07.990596+05:45
33	ksnip_20230818-141838.png	237309	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537346235.png	83fedbe1-2946-c19a-e34d-bbf3ee44d947	\N	1650036	/media/uploads/services/1692537346235.png	{}	\N	2023-08-20 19:00:46.95801+05:45
35	ksnip_20230818-141838.png	237309	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/792976433d6d42c991a1221184d03c32.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537346235.png	1650036	/media/uploads/services/792976433d6d42c991a1221184d03c32.png	{}	\N	2023-08-20 19:01:31.812429+05:45
36	surgery.jpg	17795917	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537514312.jpeg	5e833d54-e8eb-69b1-3f1e-f8dcd7250f0a	\N	1650031	/media/uploads/services/1692537514312.jpeg	{}	\N	2023-08-20 19:03:36.242077+05:45
38	1692537514312.jpeg	17795917	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1b18d3018240497c8d96f653a826fd26.jpeg	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537514312.jpeg	1650031	/media/uploads/services/1b18d3018240497c8d96f653a826fd26.jpeg	{}	\N	2023-08-20 19:04:51.822257+05:45
40	1689782733772.jpeg	65566	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/707b2627585a4186a204b9703659ee75.jpeg	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1689782733772.jpeg	1576660	/media/uploads/services/707b2627585a4186a204b9703659ee75.jpeg	{}	\N	2023-08-20 19:05:28.98137+05:45
42	1692537514312.jpeg	17795917	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/eb2aa5392e9449e4ac4ffa605fcbee01.jpeg	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537514312.jpeg	1650031	/media/uploads/services/eb2aa5392e9449e4ac4ffa605fcbee01.jpeg	{}	\N	2023-08-22 14:05:28.730665+05:45
44	1b18d3018240497c8d96f653a826fd26.jpeg	17795917	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/11d816f2b4404571bd6182441cfcb038.jpeg	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692537514312.jpeg	1650031	/media/uploads/services/11d816f2b4404571bd6182441cfcb038.jpeg	{}	\N	2023-08-22 14:07:18.181612+05:45
45	lab.png	309330	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692693156387.png	e2c19d79-213c-8c4b-f137-2b88f716783f	\N	1576630	/media/uploads/services/1692693156387.png	{}	\N	2023-08-22 14:17:37.109338+05:45
47	lab.png	309330	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/12836dfec40944fc9a57488d66899457.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692693156387.png	1576630	/media/uploads/services/12836dfec40944fc9a57488d66899457.png	{}	\N	2023-08-22 14:17:44.983613+05:45
48	emergency.png	508110	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692693456706.png	35abd4ca-0436-67ad-b1ed-a53cabd60028	\N	1650034	/media/uploads/services/1692693456706.png	{}	\N	2023-08-22 14:22:37.221631+05:45
50	emergency.png	508110	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/d63333e3deba477a956bd6f024b072cf.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692693456706.png	1650034	/media/uploads/services/d63333e3deba477a956bd6f024b072cf.png	{}	\N	2023-08-22 14:22:44.77032+05:45
51	DEN.png	245182	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692693578948.png	c83e846e-67ab-dd08-267d-e4d57b6b15b5	\N	1650392	/media/uploads/services/1692693578948.png	{}	\N	2023-08-22 14:24:39.367129+05:45
52	bloo.png	333008	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692693791195.png	69ac97fd-a88f-5900-5dde-f2319c2f7535	\N	1650395	/media/uploads/services/1692693791195.png	{}	\N	2023-08-22 14:28:11.563856+05:45
53	1.png	177843	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/employees/1692693962442.png	54a81957-c460-a09b-2ce5-36741c57190e	\N	1650396	/media/uploads/employees/1692693962442.png	{}	\N	2023-08-22 14:31:02.836477+05:45
54	2.png	279973	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/employees/1692693988171.png	50665360-2398-4d92-89c8-ece15bdb8128	\N	1650397	/media/uploads/employees/1692693988171.png	{}	\N	2023-08-22 14:31:28.533691+05:45
55	nep.png	457251	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692694236871.png	2eaea924-5294-7250-94cc-cb70b378f9a7	\N	1650398	/media/uploads/services/1692694236871.png	{}	\N	2023-08-22 14:35:37.191065+05:45
56	clinic.png	238041	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692694370830.png	39226c74-afc3-c255-6167-71a718e3e772	\N	1650399	/media/uploads/services/1692694370830.png	{}	\N	2023-08-22 14:37:51.155138+05:45
58	1689783158924.jpeg	153746	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/14f06b1e5afe4586a339d14de8c0a032.jpeg	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1689783158924.jpeg	1576662	/media/uploads/services/14f06b1e5afe4586a339d14de8c0a032.jpeg	{}	\N	2023-08-22 14:40:31.043703+05:45
59	service1.png	7117	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692696589582.png	f7b51311-a9bd-8410-80ca-6d935064df82	\N	1650008	/media/uploads/services/1692696589582.png	{}	\N	2023-08-22 15:14:50.310678+05:45
61	service1.png	7117	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/188d4a2d951b457c91dbba727c95d7ba.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692696589582.png	1650008	/media/uploads/services/188d4a2d951b457c91dbba727c95d7ba.png	{}	\N	2023-08-22 20:11:58.896547+05:45
63	service1.png	7117	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/e3a52672124d4d4e88743cef1d83e17c.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692696589582.png	1650008	/media/uploads/services/e3a52672124d4d4e88743cef1d83e17c.png	{}	\N	2023-08-22 20:12:10.752124+05:45
65	service1.png	7117	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/e41d93d907da4540aa032064acc560f5.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692696589582.png	1650008	/media/uploads/services/e41d93d907da4540aa032064acc560f5.png	{}	\N	2023-08-22 20:12:22.511333+05:45
67	service1.png	7117	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/70e82803aa8a426a91f310ef56233b9c.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692696589582.png	1650008	/media/uploads/services/70e82803aa8a426a91f310ef56233b9c.png	{}	\N	2023-08-22 20:12:31.442951+05:45
69	service1.png	7117	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/66ced863b4a54718b803ec1b4af240d3.png	\N	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692696589582.png	1650008	/media/uploads/services/66ced863b4a54718b803ec1b4af240d3.png	{}	\N	2023-08-22 20:12:38.825977+05:45
70	comment-author-3.jpg	10862	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692714783210.jpeg	8878428f-99ab-16d4-b06e-da31beca8ac7	\N	1650400	/media/uploads/services/1692714783210.jpeg	{}	\N	2023-08-22 20:18:03.981845+05:45
71	blog-author.png	36381	image/png	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/services/1692714788002.png	4b9410f8-0bcf-ebe2-932a-db965a0edbd2	\N	1650402	/media/uploads/services/1692714788002.png	{}	\N	2023-08-22 20:18:09.322977+05:45
72	comment-author-2.jpg	6551	image/jpeg	/home/sanjay/Documents/Working/Coding/NCH/hospital-app/hospital-app/media/uploads/employees/1692722287616.jpeg	d8d6d329-e406-d464-bdaf-ee064c342c57	\N	1573467	/media/uploads/employees/1692722287616.jpeg	{}	\N	2023-08-22 22:23:08.245701+05:45
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.packages (pk, slug, title, content, prices, cover, edit, action, stages, "publishedOn", category) FROM stdin;
3	Womens-Health-Package	Womens Health Package	<p>A women's health package specifically designed to cater to the unique needs of women. It typically includes a range of medical services and screenings that are essential for maintaining optimal health and preventing certain health conditions that are more common in women.</p>	\N	/media/uploads/services/1692696589582.png	\N	\N	publish	2023-08-22 20:13:16.870894+05:45	popular
1	BasicStandard-Health-Package	Basic/Standard Health Package	<p>The Basic/Standard Health Package is designed to provide essential healthcare services at an affordable cost. This package includes a range of medical services such as routine check-ups, preventive screenings, vaccinations, and basic diagnostic tests.</p>	\N	/media/uploads/services/1692696589582.png	\N	\N	publish	2023-08-22 20:13:23.336081+05:45	popular
2	Comprehensive-health-package	Comprehensive health package	<p>A comprehensive health package is a bundled offering of various healthcare services and benefits designed to provide comprehensive coverage for individuals and families. This package typically includes a range of preventive, diagnostic, and treatment services for various medical conditions.</p>	\N	/media/uploads/services/1692696589582.png	\N	\N	publish	2023-08-22 20:13:32.286952+05:45	plan
6	Bronze-Package	Bronze Package	<p class="western">The Bronze Health Package is a comprehensive healthcare plan offering essential coverage for individuals and families. This package includes essential benefits such as doctor's visits, hospital stays, and prescription medications. It is designed to provide affordable healthcare options while still ensuring access to necessary medical services. With the Bronze Health Package, you can have peace of mind knowing that you are covered for basic healthcare needs. Whether it's a routine check-up or an unexpected illness or injury, this plan has you covered. It also includes preventative services to help maintain your overall health and wellbeing.</p>	\N	/media/uploads/services/1692696589582.png	\N	\N	publish	2023-08-22 20:13:44.186111+05:45	popular
4	Hypertensive-health-package	Hypertensive health package	<p>The hypertensive health package is designed to address the specific needs of individuals with hypertension. This package aims to provide comprehensive care and support for managing high blood pressure.<br>The package typically includes regular check-ups and screening to monitor blood pressure levels and detect any complications. It may also involve lifestyle interventions such as dietary changes, exercise programs, and stress management techniques to help individuals effectively manage their hypertension.</p>	\N	/media/uploads/services/1692696589582.png	\N	\N	publish	2023-08-22 20:13:52.505003+05:45	plan
5	Diabetes-Health-Package	Diabetes Health Package	<p>A diabetes health package typically consists of a comprehensive set of screenings, tests, and consultations designed to manage and monitor diabetes. The package might include a variety of services such as blood sugar level checks, HbA1c tests, lipid profile tests, kidney function tests, and eye examinations. These tests are essential in tracking the progression of diabetes, identifying any complications, and guiding the treatment plan. Additionally, a diabetes health package may include consultations with a diabetologist or endocrinologist, who can provide personalized advice on managing diabetes, including lifestyle modifications, medication adjustments, and meal planning.</p>	\N	/media/uploads/services/1692696589582.png	\N	\N	publish	2023-08-22 20:13:59.239097+05:45	plan
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.posts (pk, slug, title, content, summary, cover, "isSticky", "publishedOn", tags, category, stages, "subCategory") FROM stdin;
2	चितवनमा डेंगुबाट २ हजार ३ सय भन्दा बढी संक्रमित	चितवनमा डेंगुबाट २ हजार ३ सय भन्दा बढी संक्रमित	<p>चितवनमा डेंगुबाट दुई हजार ३०६ जना सङ्क्रमित भएका छन्। आर्थिक वर्ष २०७९/८० मा जिल्लामा डेंगुबाट चार जनाको मृत्यु भएको छ।</p>\r\n<p>गत आर्थिक वर्षमा जिल्लाका विभिन्न अस्पतालमा १४ हजार ७२८ जनाको परीक्षण गरिएकामा तीन हजार तीन सय २४ जनामा डेंगुको सङ्क्रमण देखिएको<br>जिल्ला स्वास्थ्य कार्यालयका सूचना अधिकारी राम केसीले जानकारी दिनुभयो।</p>\r\n<p>चितवन बाहिरका छ सय ९५ जना र ठेगाना नखुलेका तीन सय २३ जना डेंगुबाट सङ्क्रमित भएका थिए।</p>\r\n<p>जिल्लामा सबैभन्दा धेरै भरतपुर महानगरपालिकामा डेंगुको सङ्क्रमण देखिएको केसीले बताए। भरतपुरमा एक हजार छ सय ४६ जना, रत्ननगर नगरपालिकाका दुई पाँच ६५ र खैरहनी नगरपालिकामा एक सय ८४ जना सङ्क्रमित भएका थिए।</p>\r\n<p>यस्तै राप्ती नगरपालिकामा एक सय जना, कालिका नगरपालिकामा ५५, माडी नगरपालिकामा ४० र इच्छाकमना गाउँपालिकामा १६ जनामा डेंगुको सङ्क्रमण देखिएको केसीले बताए।</p>\r\n<p>डेंगु एडिस एजेप्टाइ र एडिस एल्वौपेक्टस नामक लामखुट्टेले टोकेर हुने तीव्र भाइरल सङ्क्रमण हो। यो रोगको सङ्क्रमण देखिएका बिरामीमा टाउको दुख्ने, आँखाको गेडी तथा आँखाको पछिल्लो भाग दुख्ने, ढाड, जोर्नी तथा माँसपेशी दुख्ने, शरीरमा बिमिरा आउने, वाकवाकी लाग्ने, पेट दुख्ने, नाक वा गिजाबाट रगत बग्ने, रक्तश्राव हुने वा शरीरमा रगत जमेको दाग देखापर्ने, बेहोस हुने आदि लक्षण देखा पर्ने चिकित्सक बताउँछन्।</p>\r\n<p>डेंगुबाट बच्ने मुख्य उपाय लामखुट्टेबाट बच्नु हो। लामखुट्टे पानीमा बस्ने भएकाले घरको वरपर वा पानी जम्ने ठाउँजस्तैः गमला, फूलदान, खाली बट्टा, अलकत्रा वा मट्टितेलका खाली ड्रम, गाडीका काम नलाग्ने टायर आदिमा पानी जम्न नदिनु, बाहिर वा लामखुट्टेले तोक्ने ठाउँमा निस्कदा शरीर ढाकिने लुगा लगाउनुपर्ने र सुत्दा अनिवार्य झुलको प्रयोग गर्नुपर्छ, साथै साना केटाकेटीलाई जुनसुकै समयमा पनि झुलभित्र सुताउनुपर्ने उनको भनाइ छ।</p>	\N	/media/uploads/blog/1689861269723.webp	f	2023-07-20 19:39:55.214331+05:45	{}	blog	publish	\N
3	अंग प्रत्यारोपण समितिको अध्यक्षमा डा. पुकारचन्द्र श्रेष्ठ नियुक्त	अंग प्रत्यारोपण समितिको अध्यक्षमा डा. पुकारचन्द्र श्रेष्ठ नियुक्त	<p>सरकारले अंग प्रत्यारोपण समितिको अध्यक्षमा सहिद धर्मभक्त राष्टिय प्रत्यरोपण केन्द्र भक्तपुरका कार्यकारी निर्देशक समेत रहेका अंग प्रत्यारोपण विज्ञ डा. पुकारचन्द्र श्रेष्ठलाई नियुक्त गरेको छ ।</p>\r\n<p>मन्त्रिपरिषदको बैठकले समितिको अध्यक्षमा डा. श्रेष्ठसहित तीन जना सदस्य नियुक्त गरेको हो। समितिको सदस्यहरुमा डा. महेश सिग्देल, डा. प्रवीणविक्रम थापा र डा. महेश अधिकारीलाई नियुक्त गरेको छ ।</p>\r\n<p>स्वास्थ्य तथा जनसंख्या मन्त्री मोहनबहादुर बस्नेतको सिफारिसमा अध्यक्ष र सदस्यहरुलाई नियुक्त गरिएको हो । समिति गठन नहुदा लामो समयदेखि अंग प्रत्यारोपणसँग सम्बन्धित धेरै काम रोकिएका थिए ।</p>\r\n<p>समितिमा ८ महिनादेखि अध्यक्ष र सदस्यहरु रिक्त थिए। स्वास्थ्य मन्त्री बस्नेतले स्वास्थ्यमा लामो समयदेखि अड्किएका काम छिटो छरितो ढंगले गरिरहेका छन् ।</p>	\N	/media/uploads/blog/1689861327732.webp	f	2023-07-20 19:40:47.719229+05:45	{}	blog	publish	\N
4	स्वास्थ्य सेवामा सूचना प्रविधिको प्रयोग बढाउनु आवश्यक भइसक्यो	स्वास्थ्य सेवामा सूचना प्रविधिको प्रयोग बढाउनु आवश्यक भइसक्यो : स्वास्थ्यमन्त्री बस्नेत	<p>स्वास्थ्य तथा जनसंख्या मन्त्री मोहनबहादुर बस्नेतले स्वास्थ्य सेवामा सबैको पहूँच पुर्याउन सूचना प्रविधिको प्रयोग बढाउनु आवश्यक भइसकेको बताएका छन् ।</p>\r\n<p>राष्ट्रिय डिजिटल स्वास्थ्य&nbsp;<a href="https://healthnewsnepal.com/news/world-health-day/">दिवसको</a>&nbsp;अवसरमा स्वास्थ्य तथा जनसंख्या मन्त्रालयले विश्व स्वास्थ्य संगठन (डब्लूएचओ) को सहकार्यमा बिहीबार राजधानीमा आयोजना गरेको कार्यक्रमलाई बेलायतबाट भिडियो सन्देश मार्फत सम्बोधन गर्दै मन्त्री बस्नेतले ७३ प्रतिसत परिवारमा मोवाइल सेवा र ३८ प्रतिशत परिवारमा इन्टरनेट पुगिसकेको अवस्थामा सूचना प्रविधिको प्रयोग गरेर स्वास्थ्य सेवामा सबैको सहज पहूँच पुर्याउन दत्त चित्त भएर लाग्नु पर्ने बेला आएको बताए । ५५ प्रतिसत स्वास्थ्य संस्थामा मात्र सूचना प्रविधिको पहूँच पुगेको तथ्यांक प्रस्तुत गर्दै सबै स्वास्थ्य संस्थामा सूचना प्रविधिको पहूँच नपुगन्जेलसम्म जनताले छिटो छरितो सेवा पाउन नसक्ने मन्त्री बस्नेतले बताए । सूचना प्रविधिको विश्वव्यापी प्रतिस्पर्धामा स्वास्थ्यकर्मीको क्षमता अभिवृदि गर्न पनि उत्तिकै जरुरी भएकाले स्वास्थ्य मन्त्रालयले स्वास्थ्यकर्मीको क्षमता अभिवृदिलाई पनि साथसाथै अगाडि बढाउने मन्त्री बस्नेतले जानकारी दिए ।<img class="alignnone size-full wp-image-13630" title="Received 583541473721321 - स्वास्थ्य सेवामा सूचना प्रविधिको प्रयोग बढाउनु आवश्यक भइसक्यो : स्वास्थ्यमन्त्री बस्नेत" src="https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?resize=1080%2C757&amp;ssl=1" sizes="(max-width: 1000px) 100vw, 1000px" srcset="https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?w=1080&amp;ssl=1 1080w, https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?resize=768%2C538&amp;ssl=1 768w, https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?resize=750%2C526&amp;ssl=1 750w" alt="Received 583541473721321" width="660" height="463" loading="lazy" data-attachment-id="13630" data-permalink="https://healthnewsnepal.com/news/digital-health-day/attachment/received_583541473721321/" data-orig-file="https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?fit=1080%2C757&amp;ssl=1" data-orig-size="1080,757" data-comments-opened="1" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;}" data-image-title="received_583541473721321" data-image-description="" data-image-caption="" data-medium-file="https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?fit=1080%2C757&amp;ssl=1" data-large-file="https://i0.wp.com/healthnewsnepal.com/static/received_583541473721321.jpeg?fit=1080%2C757&amp;ssl=1" data-pin-no-hover="true"></p>\r\n<p><a href="https://healthnewsnepal.com/news/punarbash-municiplity/">कार्यक्रममा</a>&nbsp;स्वास्थ्य तथा जनसंख्या मन्त्रीका जनस्वास्थ्य सल्लाहकार विश्वरुप खड्काले सूचना प्रविधिको प्रयोग एकद्वार प्रणाली मार्फत हुनु पर्नेमा जोड दिदै एकद्वार प्रणाली पूर्ण रुपमा लागु भइनसेकाले मन्त्रालयका महासाखा पिच्छे फरक फरक तथ्यांक आउने समस्या रहेको बताए । सल्लाहकार खड्काले सूचना प्रविधिको प्रयोगले जनतालाई दुख दिने काम भन्दा कसरी सहज र सरल रुपमा स्वास्थ्य सेवा दिन सकिन्छ भन्ने तर्फ ध्यान दिन स्वास्थ्य मन्त्रालयका अधिकारीलाई सल्लाह दिए । स्वास्थ्य सेवामा सूचना प्रविधिको पहूँच बढाउन स्वास्थ्य मन्त्रालयले आवश्यकता अनुसार नीति, नियम र निर्देशिका बनाइसकेको जानकारी दिदै खड्काले ती नीति नियमलाई परिमार्जन गरि कार्यन्वयनमा लौजानु पर्ने आवश्यकतामा जोड दिए ।</p>\r\n<p>स्वास्थ्य तथा जनसंख्या मन्त्रालयका अतिरिक्त सचिव डा. विकाश देवकोटाले अहिलेको युग नै सूचना प्रविधिको युग भएको बताउदै टेलिमेडिसिनदेखि पेपरलेस सेवा दिनका लागि स्वास्थ्यमा सूचना प्रविधिको विकास र विस्तार आवश्यक रहेको बताए ।</p>\r\n<p>स्वास्थ्य सेवा विभागका महानिर्देशक डा. दीपेन्द्ररमण सिंहले स्वास्थ्य सेवाको सर्वव्यापी पहूँच स्थापना गर्न सूचना प्रविधिलाई स्वास्थ्य सेवासँग जोड्दै लैजानु पर्ने आवश्यकता रहेको बताए ।</p>\r\n<p>कार्यक्रममा विश्व स्वास्थ्य संगठनका नेपाल प्रतिनिधि डा. राजेश एस. पाण्डवले स्वास्थ्यमा सूचना प्रविधिको प्रयोगले मात्र अहिलेको अवस्थामा स्वास्थ्य क्षेत्रका चुनौतिको सामना गर्न सकिने दावी गर्दै स्वास्थ्य मन्त्रालयले यसका विषयमा आवश्यक पहल गरिरहेकोमा खुशी व्यक्त गरे ।</p>\r\n<p>स्वास्थ्य तथा जनसंख्या मन्त्रालय अनुगमन महासाखाका प्रमुख डा. मदन उपाध्यायले स्वास्थ्य सेवा छिटो र छरितो रुपमा प्रवाह गर्न सूचना प्रविधिले ठूलो भूमिका खेल्ने भएकाले एक दिन मात्र नभएर बर्षै भरि डिजिटल स्वास्थ्य दिवस मनाउनु पर्ने आवश्यकता रहेको बताए । कार्यक्रममा स्वास्थ्य तथा जनसंख्या मन्त्रालयका अधिकारी, सूचना तथा प्रविधि मन्त्रालयका अधिकारी, प्रदेश सरकारका स्वास्थ्य मन्त्रालय र क्षेत्रिय स्वास्थ्य निर्देशनालयका अधिकारीको सहभागिता रहेको छ । कार्यक्रममा विभिन्न विज्ञहरुले सूचना प्रविधि र स्वास्थ्य सेवाका बिषयमा प्रस्तुतिकरण गर्ने छन् । कार्यक्रमको अन्तमा डिजिटल हेल्थ घोषणापत्र जारी गरिने छ ।</p>	\N	/media/uploads/blog/1689861394555.webp	f	2023-07-20 19:41:39.593262+05:45	{}	blog	publish	\N
5	मनाङमा पनि देखियो लम्पी स्किन रोग, १५ सय भन्दा बढी गाइगोरु बिरामी	मनाङमा पनि देखियो लम्पी स्किन रोग, १५ सय भन्दा बढी गाइगोरु बिरामी	<p>नेपालका गाईभैँसीमा देखिएको लम्पी स्किन (छालामा हुने गिर्खे रोग) को महामारी अहिले तीव्र रूपमा फैलिरहेको छ ।</p>\r\n<p>७६ जिल्लामा देखीएको यस रोगको संक्रमण हिमाली जिल्ला मनाङमा समेत देखा परेपछि अहिले यो रोग हिमाली जिल्ला मनाङमा पुगेको छ।&zwnj;</p>\r\n<p>मनाङका गोरुमा समेत लम्पी स्किन रोग देखा परेको हो । मनाङको चामे गाउँपालिका&ndash;२, थानचोकमा पालिएका गोरुहरुमा लम्पी स्किनको लक्षण देखिएको भेटेरिनरी अस्पताल तथा पशु सेवा विज्ञ केन्द्र मनाङले जनाएको छ ।</p>\r\n<p>केन्द्रका अनुसार गोरुमा १ सय ४ डिग्रीको ज्वरो आउने र छालामा स&ndash;सानादेखि ठूलासम्म पूरै गिर्खा देखिएको छ । बिरामी गोरुले घाँस खान समेत समस्या हुने गरेको पशु चिकित्सकहरु बताउँछन् ।</p>\r\n<p>किसानले गोरु बिरामी भएको खबर गरेपछि उपचार गर्न जाँदा गोरुहरुमा लम्पी स्किन रोगको लक्षण देखिएको केन्द्रका पशु चिकित्सक नारायण कुसुमले बताए । उनका अनुसार गोरुमा लम्पी स्किन रोगको उपचार सुरु गरिएको छ । यसअघि मनाङ जिल्लामा लम्पी स्किन रोग देखा परेको थिएन ।</p>\r\n<p>मनाङमा २ हजार डोज लम्पी स्किन रोग विरुद्धको खोप ल्याएको भेटेरिनरी अस्पताल तथा पशु सेवा विज्ञ केन्द्र मनाङले जनाएको छ । लक्षण देखा परेसँगै गाई गोरुमा लम्पी स्किन रोग विरुद्धको खोप लगाउन सुरु गरिएको छ । बिशेष गरी चामे गाउँपालिका र नासोँ गाउँपालिकामा लम्पी स्किन रोग विरुद्धको खोप लगाउने काम भैरहेको भेटेरिनरी अस्पताल तथा पशु सेवा विज्ञ केन्द्र मनाङले जनाएको छ । केन्द्रका तथ्याङ्क अनुसार मनाङमा गाईगोरु मात्रै १ हजार ५ सय बढी छन् ।</p>\r\n<p>गण्डकीले छुट्यायो १६ करोड बजेट</p>\r\n<p>गण्डकी प्रदेश सरकारले पशुमा देखिएको लम्पी स्किन डिजिज रोगको खोपको लागि बजेट विनियोजन गरेको छ । शुक्रबार प्रदेशसभामा प्रस्तुत गरेको बजेटमा उक्त रोगको पुर्ण खोप कार्यक्रमको लागि १६ करोड ३५ लाख बजेट विनियोजना गरेको प्रदेशको आर्थिक मामिलामन्त्री जितप्रकाश आलेले बताए ।</p>\r\n<p>&lsquo;लम्पी स्किन डिजिज लगायत विभिन्न समयमा पशुमा आउन सक्ने महामारीजन्य रोगको रोकथामका लागि प्रदेशका सबै स्थानीय तहमा पशुको पूर्णखोप कार्यक्रम सञ्चालनका लागि १६ करोड ३५ लाख बजेट विनियोजन गरेको छु,&rsquo; आर्थिक मामिलामन्त्री आलेले भने ।</p>\r\n<p>यो महामारी नै हो त ?</p>\r\n<p>पशु सेवा विभागका वरिष्ठ पशु विकास अधिकृत डा. चन्द्र ढकालले अनुसार प्रभावित हुनेमा हिमाल, पहाड र तराई सबैतिरका जिल्ला रहेका छन् । &lsquo;थोरै समयमा यति ठूलो क्षेत्रमा फैलिनु भनेको यो महामारी नै हो,&rsquo; विभागका सूचना अधिकारी समेत रहेका ढकालले थपे ।</p>\r\n<p>लम्पी स्किन रोगका कारण मर्नेमा प्रायः गोरु, भर्खरै जन्मेका बाच्छाबाच्छी, पाडापाडी, गर्भवती र हालै ब्याएका गाईभैँसी छन् । उनले लम्पी स्किन रोगले अहिले पारेको असरलाई कम ठान्न नहुने भन्दै सचेत रहन समेत भने ।</p>\r\n<p>उनले कृषि तथा पशुपन्छी विकास मन्त्रालयले यसलाई गम्भीर रूपमै लिनुपर्ने बताए ।</p>	\N	/media/uploads/blog/1689861428189.webp	f	2023-07-20 19:42:18.301887+05:45	{}	blog	publish	\N
6	WOMENS-HEALTH-CONFERENCE-EXPLORING-TRENDS-IN-WOMENS-HEALTH	WOMEN’S HEALTH CONFERENCE | EXPLORING TRENDS IN WOMEN’S HEALTH	<p>Women&rsquo;s Health Conference 2023 is the first conference in Nepal looking broadly at women&rsquo;s health. Disparities, discrimination and development challenges put so many women at extreme risk. In order to address this, we need to consider the multifaceted nature of women&rsquo;s health conditions and explore trends in this sector for a well informed and evidence guided future course of action.</p>\r\n<p>Hence, in the Leadership of Family Welfare Division, Department of Health Services, Ministry of Health and Population, organizations working in the sectors of Women&rsquo;s Health have taken up this endeavor to organize a Women&rsquo;s Health Conference in Nepal, seeking to explore trends in this area.</p>\r\n<p>The Conference aims to promote and strengthen the interconnectedness of research, training, policy making, practice and advocacy evidence to expand women&rsquo;s health agenda in Nepal. To that end, it will provide a platform for participants to discuss and disseminate evidence on what works and what doesn&rsquo;t work and how successful programs can be expanded to reach different groups in society.</p>	\N	/media/uploads/blog/1689861617365.jpeg	f	2023-07-20 19:45:23.057906+05:45	{}	event	publish	\N
8	61st-Nepal-Nursing-Day	61st Nepal Nursing Day	<p>61st Nepal Nursing Day: Every year on 15th Magh, the Nepalese Nursing Day is observed. Nursing Day is celebrated to acknowledge the nursing profession&rsquo;s bravery, kindness, and dedication to service.Nurses play an important role in ensuring the world&rsquo;s health. Their advocacy allows them to change things for the better by creating change that benefits everyone. Nurses advocate for quality health care and universal health coverage to make a difference in their communities. Providing nursing care ensures that everyone has access to a healthy lifestyle.Historically, as well as today, nurses are at the forefront of fighting epidemics and pandemics &ndash; &nbsp;providing high quality and respectful treatment and care. They are often the first and sometimes the only health professional that people see and the quality of their initial assessment, care and treatment is vital. Outside, the fires of World War II were raging, people were being killed and injured every day, and Florence Nightingale, a small lamp, was always at the service of the wounded.</p>	\N	/media/uploads/blog/1689861704877.png	f	2023-07-20 19:46:50.030372+05:45	{}	event	publish	\N
7	National-Eye-Health-Strategy-MoHP-Nepal	National Eye Health Strategy | MoHP Nepal	<p>National Eye Health Strategy | MoHP Nepal:National Health Policy 2076 and the Fifteenth Plan have given priority to the basic health care established by the Constitution of Nepal as a fundamental right of citizens, while eye health care is included in Schedule 1 of the Public Health Service Regulations, 2077.In the field of eye health, eye health services are developing and expanding through public private partnership and multi-sectoral coordination. As a result, significant progress has been made in preventing trachoma and reducing blindness. Similarly, production and export of intraocular lenses has started in the country.</p>\r\n<p>Although there has been significant progress in the expansion of high and medium level eye care services, there has still been relatively little progress in the field of primary eye care services. It is necessary to mainstream eye health services by increasing government investment. In addition to blindness caused by non-communicable diseases like diabetes, blood pressure, cataracts and retinal problems, it seems that a special strategy should be adopted. Development and universal access to eye health care helps to achieve the goals of sustainable development.</p>\r\n<p>&ldquo;National Eye Health Strategy&rdquo; has been implemented to address the current problems and challenges while maintaining the achievements achieved so far by utilizing the available efforts and resources in accordance with the concept of public-private partnership, keeping in view the mentioned constitutional and policy provisions as well as the provisions of the International Convention on Disability.</p>	\N	/media/uploads/blog/1689861657008.png	f	2023-07-20 19:46:10.975513+05:45	{}	event	publish	\N
1	\N	New Post	\N	\N	\N	f	2023-08-22 12:51:40.219529+05:45	{}	blog	draft	\N
\.


--
-- Data for Name: testinmonials; Type: TABLE DATA; Schema: cms; Owner: postgres
--

COPY cms.testinmonials (pk, name, title, date, message, phone, email, "publishedOn", cover) FROM stdin;
4	Testimonial1	CEO	\N	\N	\N	\N	2023-08-22 22:24:27.91201+05:45	/media/uploads/services/1692714788002.png
\.


--
-- Name: content_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.content_pk_seq', 24, true);


--
-- Name: department_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.department_pk_seq', 23, true);


--
-- Name: employees_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.employees_pk_seq', 26, true);


--
-- Name: feedback_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.feedback_pk_seq', 1, false);


--
-- Name: files_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.files_pk_seq', 72, true);


--
-- Name: packages_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.packages_pk_seq', 12, true);


--
-- Name: posts_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.posts_pk_seq', 1, true);


--
-- Name: testinmonials_pk_seq; Type: SEQUENCE SET; Schema: cms; Owner: postgres
--

SELECT pg_catalog.setval('cms.testinmonials_pk_seq', 4, true);


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (pk);


--
-- Name: content content_slug_key; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.content
    ADD CONSTRAINT content_slug_key UNIQUE (slug);


--
-- Name: department department_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (pk);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (pk);


--
-- Name: employees employees_slug_key; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.employees
    ADD CONSTRAINT employees_slug_key UNIQUE (slug);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (pk);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (pk);


--
-- Name: files files_route_key; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.files
    ADD CONSTRAINT files_route_key UNIQUE (route);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (pk);


--
-- Name: packages packages_slug_key; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.packages
    ADD CONSTRAINT packages_slug_key UNIQUE (slug);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (pk);


--
-- Name: posts posts_slug_key; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.posts
    ADD CONSTRAINT posts_slug_key UNIQUE (slug);


--
-- Name: testinmonials testinmonials_pkey; Type: CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.testinmonials
    ADD CONSTRAINT testinmonials_pkey PRIMARY KEY (pk);


--
-- Name: ix_cms_files_md5sum; Type: INDEX; Schema: cms; Owner: postgres
--

CREATE UNIQUE INDEX ix_cms_files_md5sum ON cms.files USING btree (md5sum);


--
-- Name: content content_department_id_fkey; Type: FK CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.content
    ADD CONSTRAINT content_department_id_fkey FOREIGN KEY (department_id) REFERENCES cms.department(pk) ON DELETE CASCADE;


--
-- Name: employees employees_department_id_fkey; Type: FK CONSTRAINT; Schema: cms; Owner: postgres
--

ALTER TABLE ONLY cms.employees
    ADD CONSTRAINT employees_department_id_fkey FOREIGN KEY (department_id) REFERENCES cms.department(pk);


--
-- PostgreSQL database dump complete
--

