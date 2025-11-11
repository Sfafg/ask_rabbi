--
-- PostgreSQL database dump
--

\restrict VNeI2KOVpKngrhlgMZ7aLiDelKfdaAYtONuXfRGvih9r1h1Rb4cMcOLG3htbccN

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

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, email, type) FROM stdin;
1	alice	alice@example.com	u
2	bob	bob@example.com	u
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.questions (id, user_id, body) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- PostgreSQL database dump complete
--

\unrestrict VNeI2KOVpKngrhlgMZ7aLiDelKfdaAYtONuXfRGvih9r1h1Rb4cMcOLG3htbccN

