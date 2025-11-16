--
-- PostgreSQL database dump
--

\restrict gClLf4agr1AbxQNDquHfVq6GoYDPELNPcClnVroiOmZ49xPpJeb51YcgF8Y02y7

-- Dumped from database version 18.0 (Debian 18.0-1.pgdg13+3)
-- Dumped by pg_dump version 18.0 (Debian 18.0-1.pgdg13+3)

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
-- Name: answers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.answers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    answer_id integer,
    question_id integer,
    body text NOT NULL,
    CONSTRAINT reference CHECK ((((answer_id IS NOT NULL) AND (question_id IS NULL)) OR ((answer_id IS NULL) AND (question_id IS NOT NULL))))
);


ALTER TABLE public.answers OWNER TO admin;

--
-- Name: answers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.answers_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.answers_id_seq OWNER TO admin;

--
-- Name: answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.answers_id_seq OWNED BY public.answers.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    body character varying(1024) NOT NULL
);


ALTER TABLE public.questions OWNER TO admin;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.questions_id_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.questions_id_seq OWNER TO admin;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    type "char" DEFAULT 'u'::"char" NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: answers id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answers ALTER COLUMN id SET DEFAULT nextval('public.answers_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.answers (id, user_id, answer_id, question_id, body) FROM stdin;
0	0	\N	0	World!
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.questions (id, user_id, body) FROM stdin;
0	1	Hello?
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, email, type, password) FROM stdin;
0	Hallah	hallah@example.com	r	$2a$11$47LZuVOIRu2I9.w1Xo2N.OsLE7n9wJtNmPIHIJCB8sgy2aLpZ4Ieq
3	Hallah2	example1@gmail.com	u	$2a$11$xU8IZLmqZ2ucV0Vy4SiWKO9ULPitBqq7n6zDy1a/pNUJR7cFS/7MC
4		example2@gmail.com	u	$2a$11$WmEq3QjpX7iPWcNugecehuSDwa5lXT9P4JQ2Ne/I6npct/4w4eq9a
5	a	example3@gmail.com	u	$2a$11$QO9dLdiTKb9yUbl7By96..m.AAiUrpNMWz76lQZA1gESHATLgtJJ.
6	Hallah1	example4@gmail.com	u	$2a$11$CB4986ay0B3q0AgfrTroBu9gsbl2/MF23UGSQeKyiqEcjNU4AHZTe
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.answers_id_seq', 0, false);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.questions_id_seq', 0, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: answers answersid; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answersid PRIMARY KEY (id);


--
-- Name: questions id; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT id PRIMARY KEY (id);


--
-- Name: answers one answer; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT "one answer" UNIQUE (answer_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: answers answerid; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answerid FOREIGN KEY (answer_id) REFERENCES public.answers(id) NOT VALID;


--
-- Name: answers question; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT question FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: answers user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT "user" FOREIGN KEY (user_id) REFERENCES public.users(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

\unrestrict gClLf4agr1AbxQNDquHfVq6GoYDPELNPcClnVroiOmZ49xPpJeb51YcgF8Y02y7

