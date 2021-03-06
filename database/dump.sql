--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)

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

ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.history DROP CONSTRAINT history_pkey;
ALTER TABLE ONLY public.coupons DROP CONSTRAINT coupons_pkey;
ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE public.history ALTER COLUMN history_id DROP DEFAULT;
ALTER TABLE public.coupons ALTER COLUMN coupon_id DROP DEFAULT;
ALTER TABLE public.categories ALTER COLUMN category_id DROP DEFAULT;
DROP SEQUENCE public.users_user_id_seq;
DROP TABLE public.users;
DROP SEQUENCE public.history_history_id_seq;
DROP TABLE public.history;
DROP SEQUENCE public.coupons_coupon_id_seq;
DROP TABLE public.coupons;
DROP SEQUENCE public.categories_category_id_seq;
DROP TABLE public.categories;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    category character varying(255) NOT NULL
);


--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: coupons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupons (
    coupon_id integer NOT NULL,
    user_id integer NOT NULL,
    merchant character varying(255) NOT NULL,
    discount character varying(255) NOT NULL,
    category_id integer NOT NULL,
    expiration_date character varying(255),
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    used boolean DEFAULT false NOT NULL,
    update_at timestamp without time zone
);


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupons_coupon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupons_coupon_id_seq OWNED BY public.coupons.coupon_id;


--
-- Name: history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.history (
    history_id integer NOT NULL,
    coupon_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    used_at timestamp with time zone,
    used boolean DEFAULT false
);


--
-- Name: history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.history_history_id_seq OWNED BY public.history.history_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp(6) with time zone DEFAULT now() NOT NULL,
    avatar_url character varying(255),
    profile_image character varying(255)
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: coupons coupon_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons ALTER COLUMN coupon_id SET DEFAULT nextval('public.coupons_coupon_id_seq'::regclass);


--
-- Name: history history_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.history ALTER COLUMN history_id SET DEFAULT nextval('public.history_history_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (category_id, category) FROM stdin;
1	restaurant
2	travel
4	entertainment
5	other
\.


--
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupons (coupon_id, user_id, merchant, discount, category_id, expiration_date, created_at, used, update_at) FROM stdin;
3	4	AMC	1 free large drink	4	\N	2020-06-17 04:48:10.211285+00	f	2020-06-17 04:48:10.211285
72	16	hi	hi	1	2020-08-09T02:41:30.637Z	2020-08-09 02:41:42.685644+00	t	2020-08-09 02:41:42.685644
73	16	jjj	jjj	1	2020-08-09T02:41:54.353Z	2020-08-09 02:42:01.441312+00	t	2020-08-09 02:42:01.441312
74	16	jjj	jjj	1	2020-08-09T02:42:06.045Z	2020-08-09 02:42:11.907882+00	f	2020-08-09 02:42:11.907882
75	16	kkk	kkk	1	2020-08-09T02:42:15.062Z	2020-08-09 02:42:21.115329+00	f	2020-08-09 02:42:21.115329
121	3	Panera Bread	$10 off coupon x2, redeem in app	1	2020-10-22T19:00:00.000Z	2020-10-06 23:40:54.224173+00	t	2020-10-06 23:40:54.224173
136	3	Yoshinoya	1 free regular bowl with drink purchase	1	2020-11-05T20:00:00.000Z	2020-10-21 21:54:47.880969+00	f	2020-10-21 21:54:47.880969
120	3	Target	$5 off paper coupon	5	2020-10-27T19:00:00.000Z	2020-10-06 23:38:47.463181+00	t	2020-10-06 23:38:47.463181
79	17	AMC	20% Family tickets to AMC on a weekday	4	2020-11-27T20:00:00.000Z	2020-08-26 22:09:33.817213+00	f	2020-08-26 22:09:33.817213
122	3	Starbucks Coffee	1 free beverage any size. Redeem in app	1	2020-10-06T23:41:54.383Z	2020-10-06 23:42:15.816677+00	t	2020-10-06 23:42:15.816677
137	3	Ding Tea - Irvine	25% off with Fivestar	1	2020-11-09T20:00:00.000Z	2020-11-08 02:37:38.99777+00	f	2020-11-08 02:37:38.996
138	3	Chick-fil-A	20% off, pay with CSR and Chase Freedom card.	1	2020-11-23T20:00:00.000Z	2020-11-08 02:40:25.152996+00	t	2020-11-08 02:40:25.151
130	20	Amazon	$10 off with order over $50. Pay with AMEX card	5	2020-11-22T20:00:00.000Z	2020-10-07 00:04:24.284561+00	t	2020-11-13 00:28:18.663
156	20	Mcdonalds	Get $10 off use this code: XY123	1	2020-11-18T20:00:00.000Z	2020-11-18 07:00:02.787+00	f	2020-11-18 07:00:02.787
147	3	Kura Sushi	$5 off with minimum $15 order	1	2020-11-21T20:00:00.000Z	2020-11-16 21:19:42.381+00	t	2020-11-16 21:19:42.382
148	3	Grubhub	$5 off $20 order. Use AMEX gold + GrubHub code	1	2020-11-25T20:00:00.000Z	2020-11-16 22:55:39.168+00	t	2020-11-21 22:53:55.693
139	3	DoorDash	$10 off with $30 order	1	2020-11-30T20:00:00.000Z	2020-11-08 02:43:57.057+00	t	2020-11-20 18:59:15.096
159	3	UberEats	$7 off $20	1	2020-11-30T20:00:00.000Z	2020-11-20 18:59:05.188+00	t	2020-11-20 18:59:05.188
114	3	Peet's Coffee	1 free beverage, any size	1	2020-12-31T20:00:00.000Z	2020-10-06 23:26:05.12088+00	t	2020-10-06 23:26:05.12088
162	3	Calvin Klein	20% off at checkout	5	2020-12-31T20:00:00.000Z	2020-12-02 00:52:44.501+00	t	2020-12-02 00:52:44.501
163	3	Calvin Klein	$20 reward dollar	5	2021-03-05T20:00:00.000Z	2020-12-05 01:16:15.576+00	f	2020-12-05 01:16:15.576
166	3	Starbucks	1 free beverage	1	2020-12-13T20:00:00.000Z	2020-12-07 20:24:14.479+00	t	2020-12-07 20:24:14.479
150	20	85C Cafe	1 free 85C coffee, size M	1	2020-12-15T20:00:00.000Z	2020-11-17 05:16:10.42+00	f	2020-11-17 05:16:10.42
167	20	Regal Theatre	1 free small popcorn, redeem in app	4	2021-07-31T19:00:00.000Z	2020-12-11 23:32:31.16+00	f	2020-12-11 23:32:31.16
169	20	Kura Sushi	$5 off with order over $15. Redeem with email coupon	1	2021-05-20T19:00:00.000Z	2020-12-11 23:34:42.44+00	f	2020-12-11 23:34:42.44
157	3	Chick-fil-A	1 free chicken sandwich, redeem in app	1	2020-12-19T20:00:00.000Z	2020-11-19 18:23:30.156+00	t	2020-11-19 18:23:30.156
133	20	Marriot Bonvoy	3 reward nights up to 50K points	2	2021-11-03T19:00:00.000Z	2020-10-07 00:10:21.180954+00	f	2020-11-13 00:05:04.589
123	20	Alaska Airline	Flight ticket buy one, get one with $99. Log in account to redeem	2	2021-09-30T19:00:00.000Z	2020-10-06 23:57:29.341895+00	f	2020-10-06 23:57:29.341895
180	3	Cheesecake Factory	2 free slice of cheesecakes, redeem coupon in email from 1/1/2021	1	2021-03-31T19:00:00.000Z	2020-12-24 20:46:40.872+00	f	2020-12-24 20:46:40.872
145	3	Amazon Fresh	$10 off $50 order, physical coupon	5	2020-12-20T20:00:00.000Z	2020-11-15 05:12:10.381+00	t	2020-12-14 04:40:46.847
183	3	IHG Ambassador Reward Night	1 free night with room points up to 40,000	2	2021-04-30T19:00:00.000Z	2021-01-05 18:31:17.986+00	f	2021-01-05 18:31:17.986
116	3	Ruth's Chris Steak House	$25 off with any entree purchase, paper coupon	1	2020-12-31T20:00:00.000Z	2020-10-06 23:29:46.795277+00	t	2020-10-06 23:29:46.795277
177	3	Target	$50 get $21 using registered card	5	2020-12-31T20:00:00.000Z	2020-12-17 22:29:15.665+00	t	2020-12-17 22:29:15.665
119	3	AMC	1 free large beverage and popcorn, use email coupon	4	2021-06-30T19:00:00.000Z	2020-10-06 23:37:21.243435+00	f	2020-12-24 20:45:24.316
160	3	Cherubic Tea	1 free drink	1	2020-12-28T20:00:00.000Z	2020-11-29 01:40:08.795+00	t	2020-11-29 01:40:08.795
175	3	DoorDash	$10 credit with Chase Freedom activation	1	2020-12-31T20:00:00.000Z	2020-12-15 19:42:01.537+00	t	2020-12-15 19:42:01.537
179	3	Amazon Fresh	$15 off with $60 order	5	2020-12-27T20:00:00.000Z	2020-12-21 22:17:47.134+00	t	2020-12-21 22:17:47.134
176	3	Peet's Coffee	1 free beverage redeem in app	1	2021-01-15T20:00:00.000Z	2020-12-16 18:44:22.476+00	t	2020-12-16 18:44:22.476
161	3	Panera Bread	Code: LUNCHBREAK $20 - $5	1	2020-12-31T20:00:00.000Z	2020-12-01 02:54:00.606+00	t	2020-12-01 02:54:00.606
181	3	Noah's Bagel	$5 off purchase in app	1	2021-01-11T20:00:00.000Z	2020-12-30 05:31:59.503+00	t	2020-12-30 05:31:59.504
117	3	Dunkin Dount	1 free beverage, any size. Redeem in app.	1	2021-01-22T20:00:00.000Z	2020-10-06 23:32:40.452494+00	t	2020-12-24 05:42:10.291
182	3	Panera Bread	1 free You Pick Two	1	2021-01-29T20:00:00.000Z	2020-12-30 22:15:09.894+00	t	2020-12-30 22:15:09.894
178	3	CPK	$5 off and 1 free small plate. 1 reward at a time. Do separate orders.	1	2021-01-17T20:00:00.000Z	2020-12-21 19:24:06.558+00	t	2021-01-11 19:30:02.887
170	20	Boiling Point	$10 off with pot order. Redeem in app	1	2021-04-30T19:00:00.000Z	2020-12-11 23:35:10.388+00	f	2020-12-11 23:35:10.388
168	20	Pusheen Shop	1 free Pusheen Box with email coupon	5	2021-10-31T19:00:00.000Z	2020-12-11 23:33:06.259+00	f	2020-12-11 23:33:06.259
171	20	AMC	1 free movie ticket with app coupon\nCODE: 12345	4	2021-12-31T20:00:00.000Z	2020-12-11 23:35:45.197+00	t	2021-01-26 04:37:14.175
172	20	Dave & Busters	$10 free game play. redeem with email coupon	4	2021-12-31T20:00:00.000Z	2020-12-11 23:37:18.397+00	f	2020-12-11 23:37:18.397
173	20	China Airline	Book flight ticket and get 1 free hotel night	2	2021-06-30T19:00:00.000Z	2020-12-11 23:39:48.05+00	f	2020-12-11 23:39:48.05
174	20	UberEats	$7 off with order $20	1	2021-05-31T19:00:00.000Z	2020-12-11 23:41:13.365+00	t	2020-12-11 23:41:13.365
\.


--
-- Data for Name: history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.history (history_id, coupon_id, user_id, created_at, used_at, used) FROM stdin;
30	138	3	2020-11-08 02:40:25.155206+00	2020-11-17 05:11:43.509+00	t
10	118	3	2020-10-06 23:35:00.398168+00	\N	f
7	115	3	2020-10-06 23:27:55.302336+00	\N	f
14	122	3	2020-10-06 23:42:15.818246+00	2020-10-06 23:47:58.653+00	t
18	126	20	2020-10-07 00:00:05.718127+00	\N	f
19	127	20	2020-10-07 00:01:06.858769+00	\N	f
20	128	20	2020-10-07 00:01:59.19764+00	\N	f
21	129	20	2020-10-07 00:02:46.625173+00	\N	f
23	131	20	2020-10-07 00:05:05.5609+00	\N	f
24	132	20	2020-10-07 00:07:56.070512+00	\N	f
13	121	3	2020-10-06 23:40:54.227678+00	2020-10-14 18:36:17.014+00	t
27	135	3	2020-10-21 21:24:35.928873+00	\N	f
28	136	3	2020-10-21 21:54:47.883094+00	\N	f
12	120	3	2020-10-06 23:38:47.466097+00	2020-10-26 23:14:48.505+00	t
46	154	20	2020-11-17 06:16:49.063478+00	\N	f
29	137	3	2020-11-08 02:37:39.006753+00	\N	f
32	140	20	2020-11-12 22:46:50.310997+00	\N	f
26	134	20	2020-10-07 00:12:00.420773+00	\N	f
33	141	20	2020-11-12 23:55:19.195848+00	\N	f
34	142	20	2020-11-13 00:04:36.685124+00	\N	f
35	143	20	2020-11-13 00:16:09.428122+00	\N	f
36	144	20	2020-11-13 00:28:02.823956+00	\N	f
17	125	20	2020-10-06 23:59:24.645181+00	2020-11-13 00:29:02.339+00	t
38	146	3	2020-11-15 05:38:28.407078+00	\N	f
44	152	20	2020-11-17 05:20:26.002624+00	2020-11-18 06:57:14.411+00	t
41	149	20	2020-11-17 05:14:44.20706+00	2020-11-18 06:57:16.734+00	t
22	130	20	2020-10-07 00:04:24.286946+00	2020-11-18 06:57:16.959+00	t
16	124	20	2020-10-06 23:58:32.732415+00	2020-11-18 06:57:18.247+00	t
47	155	20	2020-11-18 06:59:19.030069+00	2020-11-18 06:59:33.561+00	t
48	156	20	2020-11-18 07:00:02.789973+00	\N	f
39	147	3	2020-11-16 21:19:42.389887+00	2020-11-19 18:21:38.67+00	t
50	158	3	2020-11-19 19:46:04.308872+00	\N	f
40	148	3	2020-11-16 22:55:39.171674+00	2020-11-25 01:24:37.489+00	t
31	139	3	2020-11-08 02:43:57.061479+00	2020-11-25 22:35:29.869+00	t
51	159	3	2020-11-20 18:59:05.195058+00	2020-11-28 23:11:43.011+00	t
6	114	3	2020-10-06 23:26:05.126372+00	2020-11-28 23:11:50.817+00	t
56	164	3	2020-12-05 20:43:29.771287+00	2020-12-05 20:43:34.37+00	t
54	162	3	2020-12-02 00:52:44.507483+00	2020-12-05 21:55:47.314+00	t
55	163	3	2020-12-05 01:16:15.595274+00	\N	f
57	165	3	2020-12-05 20:43:53.756104+00	\N	f
58	166	3	2020-12-07 20:24:14.50271+00	2020-12-11 18:34:25.622+00	t
66	174	20	2020-12-11 23:41:13.36753+00	2021-01-26 04:39:56.43+00	t
45	153	20	2020-11-17 05:20:58.106272+00	\N	f
25	133	20	2020-10-07 00:10:21.183801+00	\N	f
15	123	20	2020-10-06 23:57:29.343661+00	\N	f
43	151	20	2020-11-17 05:18:59.899445+00	\N	f
42	150	20	2020-11-17 05:16:10.424521+00	\N	f
59	167	20	2020-12-11 23:32:31.163917+00	\N	f
61	169	20	2020-12-11 23:34:42.442265+00	\N	f
49	157	3	2020-11-19 18:23:30.15824+00	2020-12-19 21:06:55.973+00	t
37	145	3	2020-11-15 05:12:10.392995+00	2020-12-19 21:07:18.647+00	t
8	116	3	2020-10-06 23:29:46.79727+00	2020-12-24 20:44:18.497+00	t
69	177	3	2020-12-17 22:29:15.673869+00	2020-12-24 20:44:28.71+00	t
11	119	3	2020-10-06 23:37:21.245011+00	\N	f
72	180	3	2020-12-24 20:46:40.878662+00	\N	f
52	160	3	2020-11-29 01:40:08.799022+00	2020-12-25 00:04:26.737+00	t
67	175	3	2020-12-15 19:42:01.555645+00	2020-12-26 08:22:49.116+00	t
71	179	3	2020-12-21 22:17:47.136559+00	2020-12-28 05:51:37.789+00	t
68	176	3	2020-12-16 18:44:22.483977+00	2020-12-30 20:57:56.618+00	t
53	161	3	2020-12-01 02:54:00.614631+00	2020-12-30 20:57:59.863+00	t
73	181	3	2020-12-30 05:31:59.50993+00	2020-12-31 18:37:43.613+00	t
9	117	3	2020-10-06 23:32:40.456128+00	2021-01-04 18:12:27.187+00	t
75	183	3	2021-01-05 18:31:17.996713+00	\N	f
76	184	3	2021-01-14 00:36:59.607776+00	\N	f
70	178	3	2020-12-21 19:24:06.564327+00	2021-01-16 05:33:30.812+00	t
74	182	3	2020-12-30 22:15:09.896285+00	2021-01-23 23:02:05.266+00	t
64	172	20	2020-12-11 23:37:18.399944+00	\N	f
60	168	20	2020-12-11 23:33:06.261194+00	\N	f
65	173	20	2020-12-11 23:39:48.052375+00	\N	f
62	170	20	2020-12-11 23:35:10.39078+00	\N	f
63	171	20	2020-12-11 23:35:45.199636+00	2021-01-26 04:39:47.736+00	t
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, name, email, password, created_at, avatar_url, profile_image) FROM stdin;
14	Saul Goodman 	saul.goodman@gmail.com	$2a$10$NvJFgduLFK0XL3mgoZIlpeZjk2jDr0PCroaRm1G1vVcfSlPbFU.Ey	2020-07-11 19:53:17.200468+00	//www.gravatar.com/avatar/aac176fab8e73c7d64194e44ac671e75?s=200&r=pg&d=mm	\N
15	Debra	debrachiang1019@gmail.com	$2a$10$a4M9pKwCX/X09PAkWJkceu7lUGDU4OPwiKRaYMPT6qbxg9mwbXXoi	2020-07-25 00:09:13.743006+00	//www.gravatar.com/avatar/4fd86c5a36aa4fb6a5bbcbc13f685258?s=200&r=pg&d=mm	\N
20	John Doe	guest@demo.com	$2a$10$pZmzCljZAilxwtiyu5PbFuUhQM9HALumxQazq3SRkWhR/Z6hqI1cy	2020-09-07 23:50:27.372952+00	//www.gravatar.com/avatar/52f88efd0890e268fe8f4486c1a3e16a?s=200&r=pg&d=mm	\N
23	Good Guy	g.guy@gmail.com	$2a$10$URP1C5CeBfAry5BhA6y10.BrSTumIFuRvvl/Vr.KaWhMPcy3Qm3A.	2020-11-13 00:05:57.492211+00	//www.gravatar.com/avatar/a011a81a716a15dd9bde43e416a037b3?s=200&r=pg&d=mm	scp/images/userProfile/701d717f-1e57-4f0e-9e62-922326b8e171-peopleimages.com-46529-zoom.jpg
24	Good Guy	gg@gmail.com	$2a$10$SAyHHFv9COwFdr/Dl6hceuwiShq0KqZ6NfeRGxThucrM4VZcrZSae	2020-11-13 00:17:40.697183+00	//www.gravatar.com/avatar/1208cd4bab8dd8c03d1ba8f20fb891dd?s=200&r=pg&d=mm	scp/images/userProfile/08300603-cd21-4979-9b09-83784482a150-peopleimages.com-46529-zoom.jpg
25	Good Guy	ggg@gmail.com	$2a$10$BY2MXAZDJ0Ey7SOZ7AqYy.Csn1ERovLgFUuHJN4ZhtbMIkUmPFZti	2020-11-13 00:29:35.894837+00	//www.gravatar.com/avatar/09cb98c3f027fbc9f7041222c78dcc59?s=200&r=pg&d=mm	scp/images/userProfile/ab900738-8684-4fb6-b751-7d1782f18da9-borat.jpg
3	Elvis Lee	elvislee0725@gmail.com	$2a$10$PhfUE.rJdnFQeEDKQ8ELyOdTxqYsZCzX5YUdJJmCzIz7KRjiDMyM6	2020-06-14 21:44:45.123988+00	//www.gravatar.com/avatar/aaf2b27e19c09ec4a8173b0c0723e106?s=200&r=pg&d=mm	scp/images/userProfile/be24f799-67a3-4d0a-8ad0-874fbdfe2fae-profile1.jpg
22	Good Guy	1234@gmail.com	$2a$10$AX3hl1ddgp1ovVjCbkd6seo7eoA/MA8E/C4RPbWpd464ir/BOHO9C	2020-11-12 23:05:03.544726+00	//www.gravatar.com/avatar/4819d3a8c96a5e77aee4838660c8d26b?s=200&r=pg&d=mm	scp/images/userProfile/0ec8aa2f-f187-4dac-b0bf-c4a0e80bf457-peopleimages.com-46529-zoom.jpg
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 5, true);


--
-- Name: coupons_coupon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupons_coupon_id_seq', 184, true);


--
-- Name: history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.history_history_id_seq', 76, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 25, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: coupons coupons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupons
    ADD CONSTRAINT coupons_pkey PRIMARY KEY (coupon_id);


--
-- Name: history history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.history
    ADD CONSTRAINT history_pkey PRIMARY KEY (history_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

