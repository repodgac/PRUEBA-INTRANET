--
-- PostgreSQL database dump
--

\restrict oqKt1oS0AMtmq9RLDtsFbvo105F3Xrf7TqqmHSBifwPRpMRdrvupIXTtUScqSfJ

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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
-- Name: set_updated_at(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_activity (
    id bigint NOT NULL,
    admin_user_id integer NOT NULL,
    action character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: admin_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_activity_id_seq OWNED BY public.admin_activity.id;


--
-- Name: admin_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_sessions (
    id bigint NOT NULL,
    admin_user_id integer NOT NULL,
    token_hash text NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    revoked boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: admin_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_sessions_id_seq OWNED BY public.admin_sessions.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    username character varying(120),
    login_name character varying(120) NOT NULL,
    email character varying(200),
    display_name character varying(200),
    role character varying(20) DEFAULT 'admin'::character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    password_hash text,
    last_login_at timestamp without time zone,
    created_by integer,
    updated_by integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    must_change_password boolean DEFAULT false NOT NULL,
    password_changed_at timestamp without time zone,
    CONSTRAINT chk_admin_users_role CHECK (((role)::text = ANY ((ARRAY['super_admin'::character varying, 'admin'::character varying, 'hr_admin'::character varying])::text[])))
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: document_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_categories (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: document_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_categories_id_seq OWNED BY public.document_categories.id;


--
-- Name: document_downloads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.document_downloads (
    id bigint NOT NULL,
    visitor_id bigint NOT NULL,
    document_id integer NOT NULL,
    ip_address character varying(50),
    user_agent text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: document_downloads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.document_downloads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: document_downloads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.document_downloads_id_seq OWNED BY public.document_downloads.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id integer NOT NULL,
    category_id integer,
    code character varying(100),
    title character varying(200) NOT NULL,
    description text,
    document_type character varying(30) NOT NULL,
    file_name character varying(255) NOT NULL,
    file_path text NOT NULL,
    mime_type character varying(100),
    area character varying(100),
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_documents_type CHECK (((document_type)::text = ANY ((ARRAY['form'::character varying, 'pdf'::character varying, 'docx'::character varying, 'xlsx'::character varying, 'other'::character varying])::text[])))
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: link_clicks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.link_clicks (
    id bigint NOT NULL,
    visitor_id bigint,
    link_id integer NOT NULL,
    ip_address character varying(50),
    user_agent text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: link_clicks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.link_clicks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: link_clicks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.link_clicks_id_seq OWNED BY public.link_clicks.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.links (
    id integer NOT NULL,
    title character varying(200) NOT NULL,
    description text,
    url text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.links_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.links_id_seq OWNED BY public.links.id;


--
-- Name: site_visits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_visits (
    id bigint NOT NULL,
    visitor_id bigint NOT NULL,
    path character varying(500) NOT NULL,
    referrer text,
    ip_address character varying(50),
    user_agent text,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: site_visits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_visits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_visits_id_seq OWNED BY public.site_visits.id;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visitors (
    id bigint NOT NULL,
    visitor_key character varying(120) NOT NULL,
    first_seen_at timestamp without time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: visitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.visitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: visitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.visitors_id_seq OWNED BY public.visitors.id;


--
-- Name: vw_dashboard_summary; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_dashboard_summary AS
 SELECT ( SELECT count(*) AS count
           FROM public.site_visits) AS total_visits,
    ( SELECT count(*) AS count
           FROM public.visitors) AS total_visitors,
    ( SELECT count(*) AS count
           FROM public.document_downloads) AS total_downloads,
    ( SELECT count(*) AS count
           FROM public.link_clicks) AS total_link_clicks,
    ( SELECT count(*) AS count
           FROM public.documents
          WHERE (documents.active = true)) AS active_documents,
    ( SELECT count(*) AS count
           FROM public.links
          WHERE (links.active = true)) AS active_links,
    ( SELECT max(site_visits.created_at) AS max
           FROM public.site_visits) AS last_visit_at,
    ( SELECT max(document_downloads.created_at) AS max
           FROM public.document_downloads) AS last_download_at,
    ( SELECT max(link_clicks.created_at) AS max
           FROM public.link_clicks) AS last_link_click_at;


--
-- Name: vw_downloads_by_day; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_downloads_by_day AS
 SELECT date(created_at) AS download_date,
    count(*) AS total_downloads
   FROM public.document_downloads
  GROUP BY (date(created_at))
  ORDER BY (date(created_at)) DESC;


--
-- Name: vw_recent_downloads; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_recent_downloads AS
 SELECT dd.id,
    dd.created_at,
    d.id AS document_id,
    d.title,
    d.document_type,
    d.area,
    v.visitor_key
   FROM ((public.document_downloads dd
     JOIN public.documents d ON ((d.id = dd.document_id)))
     JOIN public.visitors v ON ((v.id = dd.visitor_id)))
  ORDER BY dd.created_at DESC;


--
-- Name: vw_top_clicked_links; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_top_clicked_links AS
 SELECT l.id AS link_id,
    l.title,
    l.url,
    count(lc.id) AS total_clicks,
    max(lc.created_at) AS last_click_at
   FROM (public.links l
     JOIN public.link_clicks lc ON ((lc.link_id = l.id)))
  GROUP BY l.id, l.title, l.url
  ORDER BY (count(lc.id)) DESC, (max(lc.created_at)) DESC;


--
-- Name: vw_top_downloaded_documents; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_top_downloaded_documents AS
 SELECT d.id AS document_id,
    d.title,
    d.document_type,
    d.file_path,
    count(dd.id) AS total_downloads,
    max(dd.created_at) AS last_download_at
   FROM (public.documents d
     JOIN public.document_downloads dd ON ((dd.document_id = d.id)))
  GROUP BY d.id, d.title, d.document_type, d.file_path
  ORDER BY (count(dd.id)) DESC, (max(dd.created_at)) DESC;


--
-- Name: vw_visits_by_day; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.vw_visits_by_day AS
 SELECT date(created_at) AS visit_date,
    count(*) AS total_visits
   FROM public.site_visits
  GROUP BY (date(created_at))
  ORDER BY (date(created_at)) DESC;


--
-- Name: admin_activity id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_activity ALTER COLUMN id SET DEFAULT nextval('public.admin_activity_id_seq'::regclass);


--
-- Name: admin_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions ALTER COLUMN id SET DEFAULT nextval('public.admin_sessions_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: document_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_categories ALTER COLUMN id SET DEFAULT nextval('public.document_categories_id_seq'::regclass);


--
-- Name: document_downloads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_downloads ALTER COLUMN id SET DEFAULT nextval('public.document_downloads_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: link_clicks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_clicks ALTER COLUMN id SET DEFAULT nextval('public.link_clicks_id_seq'::regclass);


--
-- Name: links id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links ALTER COLUMN id SET DEFAULT nextval('public.links_id_seq'::regclass);


--
-- Name: site_visits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_visits ALTER COLUMN id SET DEFAULT nextval('public.site_visits_id_seq'::regclass);


--
-- Name: visitors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visitors ALTER COLUMN id SET DEFAULT nextval('public.visitors_id_seq'::regclass);


--
-- Name: admin_activity admin_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_activity
    ADD CONSTRAINT admin_activity_pkey PRIMARY KEY (id);


--
-- Name: admin_sessions admin_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_login_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_login_name_key UNIQUE (login_name);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_username_key UNIQUE (username);


--
-- Name: document_categories document_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT document_categories_name_key UNIQUE (name);


--
-- Name: document_categories document_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_categories
    ADD CONSTRAINT document_categories_pkey PRIMARY KEY (id);


--
-- Name: document_downloads document_downloads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_downloads
    ADD CONSTRAINT document_downloads_pkey PRIMARY KEY (id);


--
-- Name: documents documents_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_code_key UNIQUE (code);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: link_clicks link_clicks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_clicks
    ADD CONSTRAINT link_clicks_pkey PRIMARY KEY (id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: site_visits site_visits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_visits
    ADD CONSTRAINT site_visits_pkey PRIMARY KEY (id);


--
-- Name: visitors visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: visitors visitors_visitor_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_visitor_key_key UNIQUE (visitor_key);


--
-- Name: idx_admin_activity_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_activity_action ON public.admin_activity USING btree (action);


--
-- Name: idx_admin_activity_admin_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_activity_admin_user_id ON public.admin_activity USING btree (admin_user_id);


--
-- Name: idx_admin_activity_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_activity_created_at ON public.admin_activity USING btree (created_at);


--
-- Name: idx_admin_sessions_admin_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_admin_user_id ON public.admin_sessions USING btree (admin_user_id);


--
-- Name: idx_admin_sessions_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_expires_at ON public.admin_sessions USING btree (expires_at);


--
-- Name: idx_admin_sessions_revoked; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_sessions_revoked ON public.admin_sessions USING btree (revoked);


--
-- Name: idx_admin_users_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_users_active ON public.admin_users USING btree (active);


--
-- Name: idx_admin_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_users_email ON public.admin_users USING btree (email);


--
-- Name: idx_admin_users_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_users_role ON public.admin_users USING btree (role);


--
-- Name: idx_document_categories_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_categories_active ON public.document_categories USING btree (active);


--
-- Name: idx_document_downloads_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_downloads_created_at ON public.document_downloads USING btree (created_at);


--
-- Name: idx_document_downloads_document_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_downloads_document_id ON public.document_downloads USING btree (document_id);


--
-- Name: idx_document_downloads_visitor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_document_downloads_visitor_id ON public.document_downloads USING btree (visitor_id);


--
-- Name: idx_documents_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_active ON public.documents USING btree (active);


--
-- Name: idx_documents_area; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_area ON public.documents USING btree (area);


--
-- Name: idx_documents_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_category_id ON public.documents USING btree (category_id);


--
-- Name: idx_documents_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_documents_type ON public.documents USING btree (document_type);


--
-- Name: idx_link_clicks_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_link_clicks_created_at ON public.link_clicks USING btree (created_at);


--
-- Name: idx_link_clicks_link_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_link_clicks_link_id ON public.link_clicks USING btree (link_id);


--
-- Name: idx_link_clicks_visitor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_link_clicks_visitor_id ON public.link_clicks USING btree (visitor_id);


--
-- Name: idx_links_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_links_active ON public.links USING btree (active);


--
-- Name: idx_site_visits_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_site_visits_created_at ON public.site_visits USING btree (created_at);


--
-- Name: idx_site_visits_path; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_site_visits_path ON public.site_visits USING btree (path);


--
-- Name: idx_site_visits_visitor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_site_visits_visitor_id ON public.site_visits USING btree (visitor_id);


--
-- Name: idx_visitors_last_seen_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_visitors_last_seen_at ON public.visitors USING btree (last_seen_at);


--
-- Name: admin_users trg_admin_users_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_admin_users_updated_at BEFORE UPDATE ON public.admin_users FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: document_categories trg_document_categories_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_document_categories_updated_at BEFORE UPDATE ON public.document_categories FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: documents trg_documents_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_documents_updated_at BEFORE UPDATE ON public.documents FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: links trg_links_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trg_links_updated_at BEFORE UPDATE ON public.links FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();


--
-- Name: admin_activity fk_admin_activity_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_activity
    ADD CONSTRAINT fk_admin_activity_user FOREIGN KEY (admin_user_id) REFERENCES public.admin_users(id) ON DELETE RESTRICT;


--
-- Name: admin_sessions fk_admin_sessions_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT fk_admin_sessions_user FOREIGN KEY (admin_user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users fk_admin_users_created_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT fk_admin_users_created_by FOREIGN KEY (created_by) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users fk_admin_users_updated_by; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT fk_admin_users_updated_by FOREIGN KEY (updated_by) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: document_downloads fk_document_downloads_document; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_downloads
    ADD CONSTRAINT fk_document_downloads_document FOREIGN KEY (document_id) REFERENCES public.documents(id) ON DELETE RESTRICT;


--
-- Name: document_downloads fk_document_downloads_visitor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.document_downloads
    ADD CONSTRAINT fk_document_downloads_visitor FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) ON DELETE CASCADE;


--
-- Name: documents fk_documents_category; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_documents_category FOREIGN KEY (category_id) REFERENCES public.document_categories(id) ON DELETE SET NULL;


--
-- Name: link_clicks fk_link_clicks_link; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_clicks
    ADD CONSTRAINT fk_link_clicks_link FOREIGN KEY (link_id) REFERENCES public.links(id) ON DELETE RESTRICT;


--
-- Name: link_clicks fk_link_clicks_visitor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.link_clicks
    ADD CONSTRAINT fk_link_clicks_visitor FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) ON DELETE SET NULL;


--
-- Name: site_visits fk_site_visits_visitor; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_visits
    ADD CONSTRAINT fk_site_visits_visitor FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict oqKt1oS0AMtmq9RLDtsFbvo105F3Xrf7TqqmHSBifwPRpMRdrvupIXTtUScqSfJ

