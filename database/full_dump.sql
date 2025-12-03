--
-- PostgreSQL database dump
--

\restrict KvfhGLeL1QmO94h3fG8JhWdv1ZNrWS71dYvgYL8Wa88D67TJ5qvaxym659e3b9U

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
-- Name: questions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    body character varying(1024) NOT NULL
);


ALTER TABLE public.questions OWNER TO admin;

--
-- Name: quary_phrase(character varying); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.quary_phrase(phrase character varying) RETURNS SETOF public.questions
    LANGUAGE sql
    AS $$SELECT *
FROM questions
WHERE questions.body ILIKE '%' || phrase || '%';$$;


ALTER FUNCTION public.quary_phrase(phrase character varying) OWNER TO admin;

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
121	21	\N	138	Try setting aside a consistent time each day, focusing on intention over speed.
122	22	\N	139	Study a small portion daily and discuss it with others to reinforce understanding.
123	23	\N	140	Observe Shabbat as fully as you can; even partial observance has value.
124	24	\N	141	Kosher dietary laws are about mindfulness, spirituality, and discipline.
125	25	\N	142	Engage your children with stories and hands-on mitzvot activities.
126	26	\N	143	Reflect, fast, and seek reconciliation with others in preparation for Yom Kippur.
127	27	\N	144	Tefillin remind us to dedicate mind and heart to God each day.
128	28	\N	145	Give according to means, with intention, and seek to help those most in need.
129	29	\N	146	Forgiveness starts with understanding, empathy, and letting go of resentment.
130	30	\N	147	Study groups allow you to learn collaboratively and gain diverse perspectives.
131	31	\N	148	Focus on meaningful rituals, daily prayer, and community involvement.
132	32	\N	149	Prioritize values, integrate traditions gradually, and seek balance in daily life.
133	33	\N	150	Yes, you can recite Psalms or personal prayers to calm the mind.
134	34	\N	151	Engage in prayer, reflection, and mitzvot even if attending remotely.
135	35	\N	152	Lighting candles brings awareness to peace, rest, and holiness of Shabbat.
136	36	\N	153	Study the weekly portion slowly, reflect, and discuss with others.
137	37	\N	154	Consider classic commentaries like Rashi, Rambam, and contemporary guides.
138	38	\N	155	Clean, organize, and prepare symbolic items to honor the sanctity of Shabbat.
139	39	\N	156	Kashrut laws guide what is permissible, emphasizing intentional eating.
140	40	\N	157	Bless food before eating to acknowledge sustenance and gratitude.
141	42	\N	158	Daily reflection and gratitude lists help cultivate mindful appreciation.
142	21	\N	159	Study the prophets with historical context and practical moral lessons.
143	22	\N	160	Begin with simple texts, vocabulary, and consistent daily practice.
144	23	\N	161	Yes, there are traditional prayers for healing and personal health.
145	24	\N	162	A mezuzah reminds us of God’s presence and our commitment to Torah.
146	25	\N	163	Volunteer with intention, help those in need, and act consistently.
147	26	\N	164	Follow the spirit of holidays through prayer, study, and family rituals.
148	27	\N	165	Daily blessings cultivate mindfulness and recognition of everyday gifts.
149	28	\N	166	Different traditions emphasize melody, intention, and communal engagement.
150	29	\N	167	Use stories, questions, and participation to teach children effectively.
151	30	\N	168	Reconnect through prayer, study, and community engagement.
152	31	\N	169	Maintain faith through reflection, support networks, and study.
153	32	\N	170	Act with honesty, fairness, and concern for the welfare of others.
154	33	\N	171	Break study into manageable sections and seek guidance from mentors.
155	34	\N	172	Meditation helps focus the mind, improve awareness, and deepen connection.
156	35	\N	173	Integrate small acts of kindness and ritual into daily routines.
157	36	\N	174	Learn the history, values, and meanings behind each holiday.
158	37	\N	175	Plan family rituals in advance and focus on shared moments.
159	38	\N	176	Torah study for adults fosters moral and spiritual growth.
160	39	\N	177	Seek quiet reflection and ask for clarity and guidance in your prayers.
161	40	\N	178	Start with simple texts and commentaries; ask questions often.
162	42	\N	179	Approach conflicts with honesty, empathy, and guidance from Torah principles.
163	21	\N	180	Symbols and rituals reinforce faith, memory, and ethical living.
164	22	\N	181	Contribute time, skills, and attention to synagogue activities.
165	23	\N	182	Music enhances prayer, emotion, and community connection.
166	24	\N	183	Reflect, repent, and engage in meaningful rituals at home if needed.
167	25	\N	184	Tikkun olam means repairing the world through ethical and compassionate acts.
168	26	\N	185	Short prayers, gratitude, and intention integrate faith into daily work.
169	27	\N	186	Live with honesty, compassion, and integrity in all actions.
170	28	\N	187	Study history, visit communities, and reflect on past teachings.
171	29	\N	188	Group study encourages discussion, accountability, and diverse perspectives.
172	30	\N	189	Celebrate traditions with respect, explanation, and inclusive activities.
173	31	\N	190	Apply Torah ethics to honesty, justice, and kindness in modern life.
174	32	\N	191	Routine, reflection, and mindfulness help sustain spiritual discipline.
175	33	\N	192	Prayers for strength include Psalms and personalized supplications.
176	34	\N	193	Perform mitzvot in small, deliberate ways when time is limited.
177	35	\N	194	Fasting days encourage reflection, humility, and empathy.
178	36	\N	195	Give charity thoughtfully and participate in community support.
179	37	\N	196	Guide family rituals with intention, explanation, and consistency.
180	38	\N	197	Engage children in discussion, storytelling, and hands-on mitzvot.
181	39	\N	198	Mindfulness can be enhanced through daily blessings and meditation.
182	40	\N	199	Honor Shabbat by creating small rituals even during work hours.
183	42	\N	200	Reflect on actions daily and seek to align them with Torah teachings.
184	21	\N	201	Recite prayers for peace, engage in kindness, and foster calm at home.
185	22	\N	202	Yes, bless each slice or consider it one continuous blessing.
186	23	\N	203	Yes, as long as your intention remains focused and playful.
187	24	\N	204	Even rabbis enjoy new questions; humor keeps learning lively.
188	25	\N	205	No, focus on intent rather than appearance.
189	26	\N	206	Creativity is welcome if it honors the holiday spirit.
190	27	\N	207	Meditation counts if it keeps your mind engaged with study.
191	28	\N	208	Only use devices that do not violate Shabbat restrictions.
192	29	\N	209	No formal blessing exists, but gratitude is always good.
193	30	\N	210	Elijah’s visit is symbolic; sincerity matters more than perfection.
194	31	\N	211	Yes, animals can be included if they do not disrupt prayer.
195	32	\N	212	Yes, playful shapes are fine as long as intent is respectful.
196	33	\N	213	Yes, blessings should be said, but mistakes are human and forgiven.
197	34	\N	214	Patterns are fine; respect and intention are what matter.
198	35	\N	215	Improvisation is acceptable in unusual circumstances.
199	36	\N	216	Pranks should be kind and never undermine sacred rituals.
200	37	\N	217	Accidents happen; view them with perspective and humor.
201	38	\N	218	Humor in a sermon is fine if it uplifts understanding.
202	39	\N	219	Creative gelt is fine; joy in tradition is encouraged.
203	42	\N	221	Costumes are fine for fun and educational purposes.
204	21	\N	222	Rising challah is a blessing of effort and patience.
205	22	\N	223	Singing creatively is allowed as long as intention remains prayerful.
206	23	\N	224	Only if it does not break the spirit of Passover observance.
207	24	\N	225	Friendly competition is part of tradition and fun.
208	25	\N	226	Yes, as long as it is respectful and does not distract others.
209	26	\N	227	Yes, playful celebration is encouraged within safety limits.
210	27	\N	228	Mistakes are forgiven; intention matters most.
211	28	\N	229	Only if it does not violate ritual rules, otherwise find alternatives.
212	29	\N	230	Puns are fine as long as they are respectful.
213	30	\N	231	Overindulgence is human, but moderation is a virtue.
214	31	\N	232	Fun dress events are acceptable with joy and respect.
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.questions (id, user_id, body) FROM stdin;
154	5	Are there recommended books for deeper Torah study?
155	6	How should I prepare my home for Shabbat?
157	28	What is the proper way to bless food?
138	25	How can I improve my daily prayer routine?
139	26	What is the best way to study Torah consistently?
140	27	How should I observe Shabbat if I work irregular hours?
141	28	Can you explain the significance of kosher dietary laws?
142	29	How do I deal with ethical dilemmas at work according to Jewish teachings?
143	30	What are some ways to involve my children in mitzvot?
144	31	How do I prepare for Yom Kippur spiritually?
145	32	What is the meaning behind wearing tefillin daily?
146	33	Can you guide me on proper tzedakah practices?
147	34	How should I approach forgiveness in difficult situations?
148	35	What is the role of study groups in spiritual growth?
149	36	How do I balance modern life with Jewish traditions?
150	37	Are there prayers for dealing with anxiety?
151	38	How should I observe the High Holidays if I cannot attend synagogue?
152	39	What is the significance of lighting Shabbat candles?
153	40	How can I improve my understanding of the weekly Torah portion?
156	27	Can you explain the laws of kashrut in detail?
158	29	How can I practice gratitude in daily life?
159	30	What are the key teachings of the prophets relevant today?
160	31	How should I approach learning Hebrew if I am a beginner?
161	32	Are there special prayers for health and healing?
162	33	What is the significance of the mezuzah on doorposts?
163	34	How can I engage in community service in a meaningful way?
164	35	How do I observe Jewish holidays outside of synagogue?
165	36	What is the importance of daily blessings?
166	37	Can you explain the different Jewish prayer styles?
167	38	How can I teach my children about the Torah effectively?
168	39	What should I do if I feel disconnected spiritually?
169	40	How can I maintain faith in challenging times?
170	25	Are there guidelines for ethical business practices?
171	26	How do I study Jewish law without feeling overwhelmed?
172	27	What is the role of meditation or contemplation in Judaism?
173	28	How can I make mitzvot part of my daily routine?
174	29	Can you explain the meaning of different Jewish holidays?
175	30	How do I celebrate Shabbat with family in a busy schedule?
176	31	What is the significance of Torah study for adults?
177	32	Are there prayers for seeking guidance in decision-making?
178	33	How should I approach learning the Hebrew Bible?
179	34	Can you give advice on resolving conflicts within a Jewish framework?
180	35	What is the significance of Jewish symbols and rituals?
181	36	How can I contribute to my synagogue community?
182	37	What is the role of music in Jewish worship?
183	38	How should I prepare for Rosh Hashanah and Yom Kippur?
184	39	Can you explain the concept of tikkun olam?
185	40	How do I integrate prayer into a busy workday?
186	25	What advice do you have for living a virtuous life according to Torah?
187	26	How can I connect more deeply to Jewish history?
188	27	What are effective ways to study Torah with a group?
189	28	How can I celebrate Jewish traditions in a multicultural environment?
190	29	What are the ethical teachings of Judaism relevant to modern issues?
191	30	How do I maintain spiritual discipline in daily life?
192	31	Can you recommend prayers for strength during hardship?
193	32	How do I observe mitzvot with limited time?
194	33	What is the significance of fasting days?
195	34	How should I approach charity within the community?
196	35	Can you provide guidance on family rituals and customs?
197	36	How can I foster a spiritual connection with my children?
198	37	Are there daily practices to enhance mindfulness in Judaism?
199	38	What are the ways to honor Shabbat even at work?
200	39	How can I reflect on my actions according to Torah teachings?
201	40	What are some prayers or rituals for peace in the home?
202	27	If I eat pizza on Shabbat, do I have to bless each slice separately?
203	30	Can I argue with my cat and still call it prayer time?
204	26	Do rabbis ever get tired of hearing the same question about kosher hot dogs?
205	29	If I accidentally wear mismatched socks to synagogue, is that a sin?
206	32	Can I make a Hanukkah menorah out of LEGO bricks?
207	25	If I nap during Torah study, does it count as meditation?
208	34	Can I use a smartphone flashlight for Shabbat candle lighting?
209	28	Is there a blessing for finding Wi-Fi in the desert?
210	31	If I mix up matzo and bread, will Elijah still visit my seder?
211	36	Can my dog attend Torah study if he is quiet enough?
212	35	Is it okay to make challah into funny shapes, like dinosaurs?
213	33	If I eat gefilte fish and hate it, can I skip the blessing?
214	38	Can I wear a kippah with a funny pattern or is that disrespectful?
215	40	If my menorah has missing candles, can I improvise with crayons?
216	25	Do rabbis ever play pranks with the shofar just for fun?
217	26	If I accidentally spill wine on my prayer book, is it a tragedy or blessing?
218	29	Can I tell a joke during the sermon if it’s Torah-related?
219	28	Is it okay to make Hanukkah gelt out of chocolate coins shaped like my face?
220	32	If I mix up my prayer times, do I get extra merit points or a timeout?
221	27	Can I pretend to be Moses for Halloween?
222	30	If my challah rises too much, is it considered a miracle?
223	34	Can I sing the prayers in a rap version for fun?
224	25	Is it allowed to have a “kosher pizza party” during Passover if no one notices?
225	36	Do rabbis ever secretly compete in dreidel tournaments?
226	33	If I use a laser pointer to point to the Torah, is that allowed?
227	40	Can I celebrate Purim in pajamas?
228	35	If I accidentally say the wrong blessing, can I blame it on autocorrect?
229	38	Can I use a menorah as a lamp if I run out of electricity?
230	26	Is it okay to make puns with Hebrew words in study groups?
231	29	If I eat too much kugel, does that count as a mitzvah of indulgence?
232	28	Can I host a “dress like a rabbi” costume contest?
233	32	If I replace water with soda for rituals, is it still kosher?
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, email, type, password) FROM stdin;
21	Rabbi Eli Cohen	eli.cohen@example.com	r	$2a$11$L/41GQQA.1xJqq636h4MBuqt9c9NLLWZVrLfjKR2VOZBgQqxrlK16
22	Rabbi David Rosen	david.rosen@example.com	r	$2a$11$kV0pqq90XEIqEqC70ws.2eYTMQncfMvamdjfmI1GGvdWH0MOiirBq
23	Rabbi Aaron Levi	aaron.levi@example.com	r	$2a$11$aZocVFA9ZwuTdFASD3kpz.FPmxwtN.70l.RoifKed0WXf3mpVQAcK
24	Rabbi Moshe Adler	moshe.adler@example.com	r	$2a$11$8HN8wAdy40ePW.P8tkMJleXE/Q0Gjgi8ttXn3i.KscitEyENDhpPO
25	John Smith	john.smith@example.com	u	$2a$11$obe7rqIVndjeI/paE491euxKSk68DeF6Iwoi2QXOFSFVAPCuxnHmC
26	Sarah Miller	sarah.miller@example.com	u	$2a$11$7KN78Wye/4sGx0lSuChIm.hpmFKmd.9TyDvRAY4.fdJ7pQQmNsBZW
27	Michael Brown	michael.brown@example.com	u	$2a$11$GXSatRQ7MQ3PVuXgqnrttuqlSnuQCv01ntgaTpS5cbAlDtgR3oHI2
28	Emily Clark	emily.clark@example.com	u	$2a$11$LxuaH8P6Ll6NjgkN.jtDqOM6aSUPcTua9BUuMb0JdvPg.mJ/eDShm
29	Daniel Harris	daniel.harris@example.com	u	$2a$11$CPvRRFYPbeodaBPCqNFa2.jseYZD2fpZcs83Cgm1heCWL.Gcxe6WK
30	Laura Scott	laura.scott@example.com	u	$2a$11$yoIufwTrVB4JBos9AMpyoeqme73127DmToN1ErHwNMDMHyv5oSyzi
31	Peter Adams	peter.adams@example.com	u	$2a$11$wN1A708JuzmkQuxCL7oxJemdvqZM5tKY2Wc5gFeUxuV08cwny1Er6
32	Anna Brooks	anna.brooks@example.com	u	$2a$11$GoBGp57v2AOQMkn0jCe5XONd43HJOqMOAru11HyuZtDx9lVm1UHO2
33	Robert Ward	robert.ward@example.com	u	$2a$11$AyYbd9xsPgrg2Ez9IUw3VOz/EH3LuQVNB9Mtwcn9GwhLv/6NOS9Oa
34	Olivia Turner	olivia.turner@example.com	u	$2a$11$gCf29YqNwqlZyu448qea/.g3MZycUkwiRBlcaCWRLK4Yfv8BTMDyW
35	Kevin Reed	kevin.reed@example.com	u	$2a$11$D.Gv12L3QqBBDyLrdbCoKetB.ib8QV/P0O/MsUMqE0Wamq3n3bWqu
36	Maria Evans	maria.evans@example.com	u	$2a$11$drbJFen83CkNh5OLel5u0escyd8pOSo44OXSr8haFipch38rMNLvW
37	Steven Hall	steven.hall@example.com	u	$2a$11$xG4.Y6HFyXcj9bFlTLGgeuLJbI8MOTU7TjhIxvcit63mJYrcsXbDG
38	Julia Price	julia.price@example.com	u	$2a$11$2eEBMqftjJ.eEUv1rR3HkubnLfBHozzSBWB84.t7zXZJev3QJuTjG
39	Thomas Gray	thomas.gray@example.com	u	$2a$11$FhVSfZOAtbMcxH5Q3XZebeFdf01I8nxQSWwgRGEzS1pqCWHelit0m
40	Natalie Long	natalie.long@example.com	u	$2a$11$h08Jfq2I9ovfiCeOoR7aX.h0zDJSAkISX/m2bDnlWP20gciSPMZIm
42	RabbiTheFirst	example823dad@gmail.coma	r	$2a$11$CHHcPI8DWr/FqfvjBY9owunKGSLCq5bpC3M7hgKMOkh4uHhq99SkW
\.


--
-- Name: answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.answers_id_seq', 214, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.questions_id_seq', 233, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 42, true);


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

\unrestrict KvfhGLeL1QmO94h3fG8JhWdv1ZNrWS71dYvgYL8Wa88D67TJ5qvaxym659e3b9U

