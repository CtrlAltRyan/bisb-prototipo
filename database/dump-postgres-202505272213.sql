--
-- PostgreSQL database dump
--

-- Dumped from database version 17.1
-- Dumped by pg_dump version 17.1

-- Started on 2025-05-27 22:13:11

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
-- TOC entry 7 (class 2615 OID 24775)
-- Name: salao; Type: SCHEMA; Schema: -; Owner: rodrigo
--

CREATE SCHEMA salao;


ALTER SCHEMA salao OWNER TO rodrigo;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 232 (class 1259 OID 24786)
-- Name: clientes; Type: TABLE; Schema: salao; Owner: rodrigo
--

CREATE TABLE salao.clientes (
    id integer NOT NULL,
    nome text NOT NULL,
    telefone character varying(15),
    email text,
    data_nascimento date,
    bairro text NOT NULL
);


ALTER TABLE salao.clientes OWNER TO rodrigo;

--
-- TOC entry 231 (class 1259 OID 24785)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: salao; Owner: rodrigo
--

CREATE SEQUENCE salao.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE salao.clientes_id_seq OWNER TO rodrigo;

--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 231
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: salao; Owner: rodrigo
--

ALTER SEQUENCE salao.clientes_id_seq OWNED BY salao.clientes.id;


--
-- TOC entry 230 (class 1259 OID 24777)
-- Name: servicos; Type: TABLE; Schema: salao; Owner: rodrigo
--

CREATE TABLE salao.servicos (
    id integer NOT NULL,
    nome_servico text NOT NULL,
    preco numeric(10,2) NOT NULL
);


ALTER TABLE salao.servicos OWNER TO rodrigo;

--
-- TOC entry 229 (class 1259 OID 24776)
-- Name: servicos_id_seq; Type: SEQUENCE; Schema: salao; Owner: rodrigo
--

CREATE SEQUENCE salao.servicos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE salao.servicos_id_seq OWNER TO rodrigo;

--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 229
-- Name: servicos_id_seq; Type: SEQUENCE OWNED BY; Schema: salao; Owner: rodrigo
--

ALTER SEQUENCE salao.servicos_id_seq OWNED BY salao.servicos.id;


--
-- TOC entry 234 (class 1259 OID 24797)
-- Name: usuarios; Type: TABLE; Schema: salao; Owner: rodrigo
--

CREATE TABLE salao.usuarios (
    id integer NOT NULL,
    usuario text NOT NULL,
    senha_hash text NOT NULL,
    is_adm boolean
);


ALTER TABLE salao.usuarios OWNER TO rodrigo;

--
-- TOC entry 233 (class 1259 OID 24796)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: salao; Owner: rodrigo
--

CREATE SEQUENCE salao.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE salao.usuarios_id_seq OWNER TO rodrigo;

--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 233
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: salao; Owner: rodrigo
--

ALTER SEQUENCE salao.usuarios_id_seq OWNED BY salao.usuarios.id;


--
-- TOC entry 236 (class 1259 OID 24808)
-- Name: vendas; Type: TABLE; Schema: salao; Owner: rodrigo
--

CREATE TABLE salao.vendas (
    id integer NOT NULL,
    id_cliente integer,
    id_servico integer,
    valor numeric(10,2),
    forma_pagamento character varying(10),
    data_venda date
);


ALTER TABLE salao.vendas OWNER TO rodrigo;

--
-- TOC entry 235 (class 1259 OID 24807)
-- Name: vendas_id_seq; Type: SEQUENCE; Schema: salao; Owner: rodrigo
--

CREATE SEQUENCE salao.vendas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE salao.vendas_id_seq OWNER TO rodrigo;

--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 235
-- Name: vendas_id_seq; Type: SEQUENCE OWNED BY; Schema: salao; Owner: rodrigo
--

ALTER SEQUENCE salao.vendas_id_seq OWNED BY salao.vendas.id;


--
-- TOC entry 4743 (class 2604 OID 24789)
-- Name: clientes id; Type: DEFAULT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.clientes ALTER COLUMN id SET DEFAULT nextval('salao.clientes_id_seq'::regclass);


--
-- TOC entry 4742 (class 2604 OID 24780)
-- Name: servicos id; Type: DEFAULT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.servicos ALTER COLUMN id SET DEFAULT nextval('salao.servicos_id_seq'::regclass);


--
-- TOC entry 4744 (class 2604 OID 24800)
-- Name: usuarios id; Type: DEFAULT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.usuarios ALTER COLUMN id SET DEFAULT nextval('salao.usuarios_id_seq'::regclass);


--
-- TOC entry 4745 (class 2604 OID 24811)
-- Name: vendas id; Type: DEFAULT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.vendas ALTER COLUMN id SET DEFAULT nextval('salao.vendas_id_seq'::regclass);


--
-- TOC entry 4908 (class 0 OID 24786)
-- Dependencies: 232
-- Data for Name: clientes; Type: TABLE DATA; Schema: salao; Owner: rodrigo
--

COPY salao.clientes (id, nome, telefone, email, data_nascimento, bairro) FROM stdin;
1	Bárbara Nascimento	(85) 93638-9347	barbara.nascimento@gmail.com	1978-06-16	Serrinha
2	Isabela Cavalcante	(85) 99661-6784	isabela.cavalcante@gmail.com	1967-10-05	Cidade dos Funcionários
3	Lorena Mendes	(85) 98919-6979	lorena.mendes@gmail.com	1979-02-01	Messejana
4	Lucas da Rosa	(85) 94804-2619	lucas.darosa@gmail.com	1955-08-26	Maraponga
5	Dante Carvalho	(85) 97176-4322	dante.carvalho@gmail.com	1942-09-26	Cidade dos Funcionários
6	Sabrina Carvalho	(85) 99465-5218	sabrina.carvalho@gmail.com	1999-02-17	Bom Jardim
7	Jade Cardoso	(85) 94014-3196	jade.cardoso@gmail.com	1995-01-17	Pici
8	Josué Rios	(85) 95754-8507	josue.rios@gmail.com	2004-01-21	Cocó
9	Raquel Borges	(85) 91226-9088	raquel.borges@gmail.com	1954-12-10	Meireles
10	Thales Novaes	(85) 95355-9720	thales.novaes@gmail.com	1936-09-02	Dionísio Torres
11	Sophie Oliveira	(85) 94081-6655	sophie.oliveira@gmail.com	1955-06-08	Mondubim
12	Caio da Cunha	(85) 97660-6432	caio.dacunha@gmail.com	1985-03-04	Papicu
13	Maria Helena Rezende	(85) 92824-2836	mariahelena.rezende@gmail.com	1955-10-09	Mondubim
14	Vinicius Mendes	(85) 95816-9796	vinicius.mendes@gmail.com	1964-03-13	Bom Jardim
15	João Guilherme das Neves	(85) 99767-1945	joaoguilherme.dasneves@gmail.com	1943-04-15	Dionísio Torres
16	Lara Fonseca	(85) 97747-4671	lara.fonseca@gmail.com	1958-12-25	Montese
17	Pedro Miguel da Rocha	(85) 99990-2182	pedromiguel.darocha@gmail.com	1991-06-12	Praia de Iracema
18	Leandro Dias	(85) 96949-3154	leandro.dias@gmail.com	1994-04-24	Parquelândia
19	Vicente Monteiro	(85) 99816-9098	vicente.monteiro@gmail.com	1953-11-15	Serrinha
20	Mateus Nogueira	(85) 98451-3588	mateus.nogueira@gmail.com	1971-08-09	Damas
21	Alexia Rocha	(85) 95871-5343	alexia.rocha@gmail.com	1974-05-10	Meireles
22	Maria Laura Vieira	(85) 92427-6317	marialaura.vieira@gmail.com	1951-02-08	Maraponga
23	José Miguel Novais	(85) 92068-5048	josemiguel.novais@gmail.com	1959-12-13	Praia de Iracema
24	Mirella Aragão	(85) 99744-4676	mirella.aragao@gmail.com	2003-06-03	Benfica
25	Mariana Rios	(85) 96003-2804	mariana.rios@gmail.com	1957-05-22	Joaquim Távora
26	Raquel Brito	(85) 97336-6670	raquel.brito@gmail.com	1983-08-12	Conjunto Ceará
27	Stephany da Rocha	(85) 94207-6578	stephany.darocha@gmail.com	1978-07-13	Serrinha
28	João Lucas Aparecida	(85) 91744-5478	joaolucas.aparecida@gmail.com	1954-03-01	Joaquim Távora
29	João Gabriel Novaes	(85) 91462-8151	joaogabriel.novaes@gmail.com	1977-10-01	Praia de Iracema
30	Isis Araújo	(85) 92128-7198	isis.araujo@gmail.com	1983-07-03	Varjota
31	Arthur Miguel Caldeira	(85) 99942-2323	arthurmiguel.caldeira@gmail.com	1956-07-21	Pici
32	Maria Alice Oliveira	(85) 97632-6449	mariaalice.oliveira@gmail.com	1995-08-19	Bom Jardim
33	Benício Correia	(85) 91893-3219	benicio.correia@gmail.com	1980-12-01	Aldeota
34	Benício Borges	(85) 99321-1082	benicio.borges@gmail.com	1978-05-31	Serrinha
35	Thomas da Cunha	(85) 99900-6720	thomas.dacunha@gmail.com	1955-03-17	Montese
36	Bruno Rodrigues	(85) 95183-4186	bruno.rodrigues@gmail.com	1961-04-25	Messejana
37	Henry Cassiano	(85) 93033-8657	henry.cassiano@gmail.com	1999-09-01	Joaquim Távora
38	Rafael da Rosa	(85) 92453-7038	rafael.darosa@gmail.com	1978-09-01	Pici
39	Ana Lívia Moraes	(85) 96129-6668	analivia.moraes@gmail.com	1945-01-25	Cidade dos Funcionários
40	Arthur Silva	(85) 95116-3099	arthur.silva@gmail.com	1982-07-10	Praia de Iracema
41	Evelyn Fogaça	(85) 97176-3166	evelyn.fogaca@gmail.com	1943-07-03	Papicu
42	João Vitor Almeida	(85) 94481-8429	joaovitor.almeida@gmail.com	1966-07-08	Jóquei Clube
43	Natália da Rosa	(85) 98620-9068	natalia.darosa@gmail.com	1964-04-17	Papicu
44	Sara Azevedo	(85) 98532-1945	sara.azevedo@gmail.com	1996-10-07	Parangaba
45	Murilo Barros	(85) 94455-3999	murilo.barros@gmail.com	1974-06-04	Conjunto Ceará
46	Eloah Duarte	(85) 99838-6833	eloah.duarte@gmail.com	1963-01-20	Meireles
47	Ana Sophia Santos	(85) 91390-6453	anasophia.santos@gmail.com	1966-10-23	Cidade dos Funcionários
48	Dante Nunes	(85) 98220-9272	dante.nunes@gmail.com	1940-05-03	Pici
49	Rafaela Sampaio	(85) 99440-8853	rafaela.sampaio@gmail.com	2001-02-10	Damas
50	Gael Cardoso	(85) 99331-9380	gael.cardoso@gmail.com	1974-10-18	Mondubim
51	Léo Pimenta	(85) 98763-3644	leo.pimenta@gmail.com	1992-03-23	Fátima
52	Ana Sophia Melo	(85) 98441-1748	anasophia.melo@gmail.com	1985-04-09	Conjunto Ceará
53	Isadora Ferreira	(85) 98970-1815	isadora.ferreira@gmail.com	1958-10-01	Benfica
54	Thiago Alves	(85) 97979-9829	thiago.alves@gmail.com	1939-08-18	Conjunto Ceará
55	Alexia Fonseca	(85) 99156-4595	alexia.fonseca@gmail.com	1996-10-16	Parangaba
56	Luana Pacheco	(85) 92371-4317	luana.pacheco@gmail.com	1997-06-04	Cidade dos Funcionários
57	Maria Helena Novais	(85) 91610-3900	mariahelena.novais@gmail.com	1958-01-02	Meireles
58	Luana Siqueira	(85) 95418-5046	luana.siqueira@gmail.com	1947-06-22	Bom Jardim
59	Lucca Fernandes	(85) 99153-8676	lucca.fernandes@gmail.com	1969-04-04	Cidade dos Funcionários
60	José Pedro Cavalcanti	(85) 91719-7451	josepedro.cavalcanti@gmail.com	1968-02-11	Fátima
\.


--
-- TOC entry 4906 (class 0 OID 24777)
-- Dependencies: 230
-- Data for Name: servicos; Type: TABLE DATA; Schema: salao; Owner: rodrigo
--

COPY salao.servicos (id, nome_servico, preco) FROM stdin;
1	Corte Feminino	60.00
2	Corte Masculino	40.00
3	Escova	50.00
4	Coloração	120.00
5	Luzes	150.00
6	Progressiva	250.00
7	Hidratação Capilar	80.00
8	Manicure	30.00
9	Pedicure	35.00
10	Design de Sobrancelha	25.00
11	Maquiagem	90.00
12	Penteado para Festa	100.00
13	Depilação Buço	15.00
14	Depilação Pernas	50.00
15	Massagem Relaxante	100.00
\.


--
-- TOC entry 4910 (class 0 OID 24797)
-- Dependencies: 234
-- Data for Name: usuarios; Type: TABLE DATA; Schema: salao; Owner: rodrigo
--

COPY salao.usuarios (id, usuario, senha_hash, is_adm) FROM stdin;
1	admin	$2b$12$kFVt.oQuECFnqxHwqE5wquq0FbPHlFqjC1UEw40It9iP5Qc4zurEa	t
2	user	$2b$12$wUtQVyVaiRau7IJCXAWYsuwO26wx8pjNUJ/CzCcjf0e1oz3meqAle	f
\.


--
-- TOC entry 4912 (class 0 OID 24808)
-- Dependencies: 236
-- Data for Name: vendas; Type: TABLE DATA; Schema: salao; Owner: rodrigo
--

COPY salao.vendas (id, id_cliente, id_servico, valor, forma_pagamento, data_venda) FROM stdin;
1	9	15	100.00	Crédito	2025-05-01
2	55	13	15.00	Débito	2025-05-01
3	28	6	250.00	Crédito	2025-05-01
4	17	15	100.00	Dinheiro	2025-05-01
5	19	2	40.00	Débito	2025-05-01
6	54	12	100.00	Crédito	2025-05-01
7	16	8	30.00	Crédito	2025-05-01
8	48	12	100.00	Débito	2025-05-01
9	6	2	40.00	Crédito	2025-05-01
10	30	7	80.00	Pix	2025-05-01
11	45	15	100.00	Dinheiro	2025-05-01
12	58	6	250.00	Débito	2025-05-01
13	26	9	35.00	Crédito	2025-05-01
14	50	11	90.00	Débito	2025-05-01
15	3	4	120.00	Débito	2025-05-01
16	35	1	60.00	Dinheiro	2025-05-01
17	25	8	30.00	Crédito	2025-05-01
18	13	12	100.00	Crédito	2025-05-01
19	39	2	40.00	Débito	2025-05-01
20	41	8	30.00	Pix	2025-05-01
21	31	6	250.00	Crédito	2025-05-01
22	56	14	50.00	Débito	2025-05-01
23	18	9	35.00	Dinheiro	2025-05-01
24	53	10	25.00	Débito	2025-05-01
25	12	6	250.00	Débito	2025-05-01
26	51	14	50.00	Dinheiro	2025-05-01
27	20	10	25.00	Crédito	2025-05-01
28	23	9	35.00	Crédito	2025-05-01
29	27	12	100.00	Dinheiro	2025-05-01
30	5	12	100.00	Pix	2025-05-01
31	49	7	80.00	Pix	2025-05-01
32	11	13	15.00	Dinheiro	2025-05-01
33	44	9	35.00	Crédito	2025-05-01
34	24	7	80.00	Dinheiro	2025-05-01
35	37	11	90.00	Dinheiro	2025-05-01
36	21	5	150.00	Crédito	2025-05-01
37	4	2	40.00	Débito	2025-05-01
38	8	6	250.00	Débito	2025-05-01
39	43	8	30.00	Dinheiro	2025-05-01
40	57	7	80.00	Pix	2025-05-01
41	10	10	25.00	Débito	2025-05-02
42	7	10	25.00	Débito	2025-05-02
43	53	5	150.00	Dinheiro	2025-05-02
44	17	4	120.00	Dinheiro	2025-05-02
45	23	4	120.00	Dinheiro	2025-05-02
46	1	6	250.00	Débito	2025-05-02
47	32	8	30.00	Crédito	2025-05-02
48	30	11	90.00	Crédito	2025-05-02
49	41	12	100.00	Débito	2025-05-02
50	57	8	30.00	Crédito	2025-05-02
51	55	7	80.00	Pix	2025-05-02
52	8	8	30.00	Crédito	2025-05-02
53	5	4	120.00	Débito	2025-05-02
54	51	9	35.00	Dinheiro	2025-05-02
55	2	1	60.00	Dinheiro	2025-05-02
56	47	12	100.00	Débito	2025-05-02
57	36	2	40.00	Pix	2025-05-02
58	3	10	25.00	Crédito	2025-05-02
59	16	1	60.00	Crédito	2025-05-02
60	26	2	40.00	Débito	2025-05-02
61	45	14	50.00	Crédito	2025-05-02
62	40	4	120.00	Dinheiro	2025-05-02
63	35	14	50.00	Pix	2025-05-02
64	46	8	30.00	Débito	2025-05-02
65	38	4	120.00	Débito	2025-05-02
66	52	14	50.00	Pix	2025-05-02
67	58	12	100.00	Débito	2025-05-02
68	9	2	40.00	Dinheiro	2025-05-02
69	44	3	50.00	Dinheiro	2025-05-02
70	42	12	100.00	Pix	2025-05-02
71	49	7	80.00	Débito	2025-05-02
72	54	1	60.00	Dinheiro	2025-05-02
73	15	2	40.00	Débito	2025-05-02
74	12	14	50.00	Dinheiro	2025-05-02
75	25	15	100.00	Pix	2025-05-02
76	6	8	30.00	Pix	2025-05-02
77	14	7	80.00	Pix	2025-05-02
78	2	7	80.00	Crédito	2025-05-03
79	22	7	80.00	Débito	2025-05-03
80	53	12	100.00	Crédito	2025-05-03
81	4	8	30.00	Pix	2025-05-03
82	48	10	25.00	Débito	2025-05-03
83	12	10	25.00	Dinheiro	2025-05-03
84	50	11	90.00	Pix	2025-05-03
85	40	3	50.00	Dinheiro	2025-05-03
86	14	10	25.00	Pix	2025-05-03
87	49	7	80.00	Crédito	2025-05-03
88	8	7	80.00	Débito	2025-05-03
89	59	10	25.00	Pix	2025-05-03
90	1	4	120.00	Dinheiro	2025-05-03
91	56	3	50.00	Débito	2025-05-03
92	18	8	30.00	Pix	2025-05-03
93	42	10	25.00	Dinheiro	2025-05-03
94	11	11	90.00	Débito	2025-05-03
95	58	1	60.00	Débito	2025-05-03
96	9	6	250.00	Crédito	2025-05-03
97	21	5	150.00	Débito	2025-05-03
98	52	13	15.00	Débito	2025-05-03
99	17	1	60.00	Crédito	2025-05-03
100	38	4	120.00	Crédito	2025-05-03
101	31	9	35.00	Crédito	2025-05-03
102	24	15	100.00	Crédito	2025-05-03
103	54	4	120.00	Débito	2025-05-03
104	15	6	250.00	Dinheiro	2025-05-03
105	28	9	35.00	Débito	2025-05-03
106	45	4	120.00	Crédito	2025-05-03
107	3	5	150.00	Crédito	2025-05-03
108	7	13	15.00	Dinheiro	2025-05-03
109	29	8	30.00	Crédito	2025-05-03
110	10	9	35.00	Dinheiro	2025-05-03
111	37	14	50.00	Crédito	2025-05-03
112	23	9	35.00	Dinheiro	2025-05-03
113	18	7	80.00	Pix	2025-05-04
114	24	13	15.00	Dinheiro	2025-05-04
115	5	15	100.00	Dinheiro	2025-05-04
116	33	13	15.00	Débito	2025-05-04
117	37	2	40.00	Dinheiro	2025-05-04
118	29	11	90.00	Pix	2025-05-04
119	48	5	150.00	Débito	2025-05-04
120	22	9	35.00	Dinheiro	2025-05-04
121	34	5	150.00	Crédito	2025-05-04
122	32	7	80.00	Pix	2025-05-04
123	36	8	30.00	Dinheiro	2025-05-04
124	4	9	35.00	Débito	2025-05-04
125	16	3	50.00	Pix	2025-05-04
126	57	3	50.00	Pix	2025-05-04
127	52	9	35.00	Dinheiro	2025-05-04
128	43	10	25.00	Débito	2025-05-04
129	20	14	50.00	Dinheiro	2025-05-04
130	50	10	25.00	Dinheiro	2025-05-04
131	6	9	35.00	Crédito	2025-05-04
132	51	2	40.00	Crédito	2025-05-04
133	49	9	35.00	Crédito	2025-05-04
134	54	7	80.00	Pix	2025-05-04
135	14	11	90.00	Crédito	2025-05-04
136	17	15	100.00	Débito	2025-05-04
137	45	7	80.00	Pix	2025-05-04
138	1	12	100.00	Pix	2025-05-04
139	15	1	60.00	Débito	2025-05-04
140	28	8	30.00	Crédito	2025-05-04
141	40	13	15.00	Pix	2025-05-04
142	12	7	80.00	Crédito	2025-05-04
143	31	9	35.00	Débito	2025-05-04
144	26	14	50.00	Dinheiro	2025-05-04
145	56	12	100.00	Crédito	2025-05-04
146	11	8	30.00	Débito	2025-05-04
147	52	12	100.00	Débito	2025-05-05
148	23	13	15.00	Dinheiro	2025-05-05
149	13	2	40.00	Crédito	2025-05-05
150	35	10	25.00	Dinheiro	2025-05-05
151	27	13	15.00	Dinheiro	2025-05-05
152	2	5	150.00	Pix	2025-05-05
153	8	13	15.00	Dinheiro	2025-05-05
154	21	13	15.00	Dinheiro	2025-05-05
155	38	10	25.00	Crédito	2025-05-05
156	26	3	50.00	Dinheiro	2025-05-05
157	32	12	100.00	Débito	2025-05-05
158	54	13	15.00	Débito	2025-05-05
159	18	13	15.00	Pix	2025-05-05
160	34	5	150.00	Dinheiro	2025-05-05
161	12	14	50.00	Dinheiro	2025-05-05
162	31	9	35.00	Pix	2025-05-05
163	43	3	50.00	Dinheiro	2025-05-05
164	39	10	25.00	Crédito	2025-05-05
165	20	1	60.00	Dinheiro	2025-05-05
166	15	13	15.00	Crédito	2025-05-05
167	60	2	40.00	Débito	2025-05-05
168	53	9	35.00	Débito	2025-05-05
169	44	9	35.00	Crédito	2025-05-05
170	11	6	250.00	Débito	2025-05-05
171	6	13	15.00	Dinheiro	2025-05-05
172	3	11	90.00	Débito	2025-05-05
173	56	2	40.00	Dinheiro	2025-05-05
174	51	13	15.00	Dinheiro	2025-05-05
175	7	4	120.00	Dinheiro	2025-05-05
176	57	6	250.00	Pix	2025-05-05
177	24	2	40.00	Pix	2025-05-05
178	22	9	35.00	Pix	2025-05-05
179	48	14	50.00	Crédito	2025-05-05
180	50	4	120.00	Pix	2025-05-05
181	14	11	90.00	Crédito	2025-05-05
182	36	12	100.00	Pix	2025-05-05
183	49	11	90.00	Dinheiro	2025-05-05
184	28	4	120.00	Débito	2025-05-05
185	39	10	25.00	Dinheiro	2025-05-06
186	5	11	90.00	Dinheiro	2025-05-06
187	22	8	30.00	Dinheiro	2025-05-06
188	31	7	80.00	Pix	2025-05-06
189	34	8	30.00	Dinheiro	2025-05-06
190	56	12	100.00	Dinheiro	2025-05-06
191	36	6	250.00	Pix	2025-05-06
192	6	1	60.00	Dinheiro	2025-05-06
193	32	12	100.00	Débito	2025-05-06
194	24	8	30.00	Dinheiro	2025-05-06
195	40	5	150.00	Pix	2025-05-06
196	7	9	35.00	Pix	2025-05-06
197	47	1	60.00	Débito	2025-05-06
198	10	13	15.00	Crédito	2025-05-06
199	45	11	90.00	Débito	2025-05-06
200	37	10	25.00	Pix	2025-05-06
201	20	11	90.00	Crédito	2025-05-06
202	38	7	80.00	Débito	2025-05-06
203	42	5	150.00	Pix	2025-05-06
204	44	1	60.00	Pix	2025-05-06
205	52	9	35.00	Débito	2025-05-06
206	15	12	100.00	Pix	2025-05-06
207	8	5	150.00	Crédito	2025-05-06
208	18	9	35.00	Dinheiro	2025-05-06
209	2	7	80.00	Crédito	2025-05-06
210	50	11	90.00	Dinheiro	2025-05-06
211	11	15	100.00	Pix	2025-05-06
212	17	15	100.00	Crédito	2025-05-06
213	55	13	15.00	Pix	2025-05-06
214	51	13	15.00	Pix	2025-05-06
215	54	2	40.00	Crédito	2025-05-06
216	46	1	60.00	Crédito	2025-05-06
217	3	3	50.00	Débito	2025-05-07
218	31	8	30.00	Crédito	2025-05-07
219	18	10	25.00	Pix	2025-05-07
220	16	14	50.00	Dinheiro	2025-05-07
221	50	6	250.00	Dinheiro	2025-05-07
222	42	5	150.00	Crédito	2025-05-07
223	27	4	120.00	Crédito	2025-05-07
224	41	10	25.00	Dinheiro	2025-05-07
225	58	14	50.00	Crédito	2025-05-07
226	6	3	50.00	Dinheiro	2025-05-07
227	46	12	100.00	Crédito	2025-05-07
228	15	15	100.00	Débito	2025-05-07
229	35	2	40.00	Dinheiro	2025-05-07
230	17	2	40.00	Pix	2025-05-07
231	14	15	100.00	Débito	2025-05-07
232	30	14	50.00	Dinheiro	2025-05-07
233	33	12	100.00	Crédito	2025-05-07
234	57	4	120.00	Dinheiro	2025-05-07
235	37	5	150.00	Débito	2025-05-07
236	21	9	35.00	Crédito	2025-05-07
237	43	3	50.00	Débito	2025-05-07
238	24	6	250.00	Crédito	2025-05-07
239	8	10	25.00	Crédito	2025-05-07
240	47	12	100.00	Pix	2025-05-07
241	12	1	60.00	Crédito	2025-05-07
242	9	7	80.00	Débito	2025-05-07
243	44	4	120.00	Crédito	2025-05-07
244	59	15	100.00	Pix	2025-05-07
245	49	8	30.00	Dinheiro	2025-05-07
246	39	7	80.00	Débito	2025-05-07
247	10	10	25.00	Dinheiro	2025-05-07
248	60	9	35.00	Dinheiro	2025-05-07
249	2	1	60.00	Crédito	2025-05-07
250	4	4	120.00	Dinheiro	2025-05-07
251	7	5	150.00	Crédito	2025-05-07
252	52	1	60.00	Dinheiro	2025-05-07
253	1	14	50.00	Débito	2025-05-07
254	31	1	60.00	Dinheiro	2025-05-08
255	50	10	25.00	Crédito	2025-05-08
256	29	6	250.00	Débito	2025-05-08
257	38	11	90.00	Débito	2025-05-08
258	14	9	35.00	Crédito	2025-05-08
259	51	7	80.00	Dinheiro	2025-05-08
260	25	12	100.00	Crédito	2025-05-08
261	40	4	120.00	Crédito	2025-05-08
262	3	8	30.00	Crédito	2025-05-08
263	24	10	25.00	Dinheiro	2025-05-08
264	1	11	90.00	Crédito	2025-05-08
265	49	14	50.00	Pix	2025-05-08
266	42	6	250.00	Crédito	2025-05-08
267	41	15	100.00	Dinheiro	2025-05-08
268	47	4	120.00	Débito	2025-05-08
269	15	9	35.00	Pix	2025-05-08
270	57	1	60.00	Dinheiro	2025-05-08
271	52	4	120.00	Débito	2025-05-08
272	35	9	35.00	Crédito	2025-05-08
273	9	2	40.00	Débito	2025-05-08
274	8	7	80.00	Dinheiro	2025-05-08
275	10	8	30.00	Débito	2025-05-08
276	16	7	80.00	Dinheiro	2025-05-08
277	13	15	100.00	Débito	2025-05-08
278	12	3	50.00	Crédito	2025-05-08
279	36	8	30.00	Débito	2025-05-08
280	26	15	100.00	Pix	2025-05-08
281	21	10	25.00	Débito	2025-05-08
282	11	1	60.00	Débito	2025-05-08
283	55	4	120.00	Pix	2025-05-08
284	23	1	60.00	Dinheiro	2025-05-08
285	17	12	100.00	Pix	2025-05-08
286	28	4	120.00	Pix	2025-05-08
287	4	7	80.00	Crédito	2025-05-08
288	39	8	30.00	Crédito	2025-05-08
289	7	15	100.00	Débito	2025-05-08
290	60	8	30.00	Débito	2025-05-08
291	44	13	15.00	Pix	2025-05-08
292	20	13	15.00	Pix	2025-05-08
293	22	7	80.00	Pix	2025-05-08
294	47	1	60.00	Dinheiro	2025-05-09
295	52	14	50.00	Dinheiro	2025-05-09
296	33	10	25.00	Dinheiro	2025-05-09
297	9	14	50.00	Pix	2025-05-09
298	20	6	250.00	Pix	2025-05-09
299	2	6	250.00	Débito	2025-05-09
300	44	2	40.00	Débito	2025-05-09
301	36	7	80.00	Crédito	2025-05-09
302	24	6	250.00	Débito	2025-05-09
303	21	12	100.00	Dinheiro	2025-05-09
304	56	3	50.00	Pix	2025-05-09
305	34	6	250.00	Dinheiro	2025-05-09
306	42	1	60.00	Débito	2025-05-09
307	41	3	50.00	Débito	2025-05-09
308	11	9	35.00	Pix	2025-05-09
309	5	12	100.00	Pix	2025-05-09
310	46	13	15.00	Dinheiro	2025-05-09
311	51	7	80.00	Crédito	2025-05-09
312	57	11	90.00	Crédito	2025-05-09
313	26	7	80.00	Pix	2025-05-09
314	23	5	150.00	Débito	2025-05-09
315	6	9	35.00	Dinheiro	2025-05-09
316	43	1	60.00	Pix	2025-05-09
317	31	2	40.00	Dinheiro	2025-05-09
318	25	10	25.00	Débito	2025-05-09
319	38	11	90.00	Crédito	2025-05-09
320	48	12	100.00	Pix	2025-05-09
321	53	5	150.00	Crédito	2025-05-09
322	13	12	100.00	Dinheiro	2025-05-09
323	27	6	250.00	Débito	2025-05-09
324	28	7	80.00	Dinheiro	2025-05-09
325	19	4	120.00	Crédito	2025-05-09
326	7	7	80.00	Débito	2025-05-10
327	17	10	25.00	Débito	2025-05-10
328	22	13	15.00	Débito	2025-05-10
329	2	4	120.00	Pix	2025-05-10
330	40	5	150.00	Pix	2025-05-10
331	55	8	30.00	Dinheiro	2025-05-10
332	44	10	25.00	Pix	2025-05-10
333	42	5	150.00	Dinheiro	2025-05-10
334	6	9	35.00	Débito	2025-05-10
335	30	5	150.00	Dinheiro	2025-05-10
336	15	5	150.00	Crédito	2025-05-10
337	45	4	120.00	Dinheiro	2025-05-10
338	46	14	50.00	Débito	2025-05-10
339	57	4	120.00	Crédito	2025-05-10
340	52	9	35.00	Débito	2025-05-10
341	50	12	100.00	Dinheiro	2025-05-10
342	34	15	100.00	Débito	2025-05-10
343	41	1	60.00	Dinheiro	2025-05-10
344	16	14	50.00	Débito	2025-05-10
345	21	9	35.00	Dinheiro	2025-05-10
346	27	8	30.00	Dinheiro	2025-05-10
347	12	10	25.00	Pix	2025-05-10
348	33	14	50.00	Pix	2025-05-10
349	56	10	25.00	Dinheiro	2025-05-10
350	31	2	40.00	Pix	2025-05-10
351	59	4	120.00	Débito	2025-05-10
352	20	11	90.00	Débito	2025-05-10
353	14	9	35.00	Dinheiro	2025-05-10
354	25	7	80.00	Dinheiro	2025-05-10
355	29	9	35.00	Crédito	2025-05-10
356	48	12	100.00	Crédito	2025-05-10
357	19	1	60.00	Débito	2025-05-10
358	49	2	40.00	Dinheiro	2025-05-10
359	22	12	100.00	Pix	2025-05-11
360	60	9	35.00	Débito	2025-05-11
361	25	4	120.00	Débito	2025-05-11
362	43	9	35.00	Débito	2025-05-11
363	34	7	80.00	Crédito	2025-05-11
364	4	6	250.00	Débito	2025-05-11
365	27	10	25.00	Crédito	2025-05-11
366	44	15	100.00	Dinheiro	2025-05-11
367	3	8	30.00	Crédito	2025-05-11
368	21	8	30.00	Crédito	2025-05-11
369	11	5	150.00	Pix	2025-05-11
370	48	14	50.00	Dinheiro	2025-05-11
371	29	10	25.00	Crédito	2025-05-11
372	55	13	15.00	Débito	2025-05-11
373	19	12	100.00	Dinheiro	2025-05-11
374	18	13	15.00	Débito	2025-05-11
375	31	10	25.00	Dinheiro	2025-05-11
376	10	7	80.00	Pix	2025-05-11
377	17	13	15.00	Dinheiro	2025-05-11
378	15	10	25.00	Dinheiro	2025-05-11
379	24	15	100.00	Dinheiro	2025-05-11
380	13	10	25.00	Crédito	2025-05-11
381	16	8	30.00	Crédito	2025-05-11
382	46	12	100.00	Débito	2025-05-11
383	35	2	40.00	Dinheiro	2025-05-11
384	12	10	25.00	Crédito	2025-05-11
385	9	1	60.00	Dinheiro	2025-05-11
386	51	11	90.00	Débito	2025-05-11
387	1	5	150.00	Dinheiro	2025-05-11
388	49	7	80.00	Pix	2025-05-11
389	26	5	150.00	Crédito	2025-05-11
390	57	15	100.00	Débito	2025-05-11
391	23	6	250.00	Débito	2025-05-11
392	5	11	90.00	Dinheiro	2025-05-11
393	59	15	100.00	Débito	2025-05-11
394	41	13	15.00	Crédito	2025-05-11
395	45	7	80.00	Débito	2025-05-11
396	7	12	100.00	Crédito	2025-05-11
397	33	1	60.00	Dinheiro	2025-05-11
398	32	2	40.00	Dinheiro	2025-05-11
399	44	15	100.00	Pix	2025-05-12
400	24	4	120.00	Crédito	2025-05-12
401	56	15	100.00	Dinheiro	2025-05-12
402	19	9	35.00	Pix	2025-05-12
403	27	9	35.00	Débito	2025-05-12
404	33	14	50.00	Débito	2025-05-12
405	39	8	30.00	Pix	2025-05-12
406	13	15	100.00	Crédito	2025-05-12
407	29	9	35.00	Crédito	2025-05-12
408	43	15	100.00	Crédito	2025-05-12
409	25	8	30.00	Dinheiro	2025-05-12
410	49	1	60.00	Crédito	2025-05-12
411	11	12	100.00	Pix	2025-05-12
412	59	13	15.00	Dinheiro	2025-05-12
413	16	3	50.00	Débito	2025-05-12
414	52	6	250.00	Pix	2025-05-12
415	58	14	50.00	Pix	2025-05-12
416	53	14	50.00	Pix	2025-05-12
417	5	15	100.00	Crédito	2025-05-12
418	7	2	40.00	Pix	2025-05-12
419	37	14	50.00	Crédito	2025-05-12
420	40	12	100.00	Débito	2025-05-12
421	31	1	60.00	Pix	2025-05-12
422	57	1	60.00	Crédito	2025-05-12
423	41	6	250.00	Débito	2025-05-12
424	14	9	35.00	Dinheiro	2025-05-12
425	9	5	150.00	Crédito	2025-05-12
426	10	4	120.00	Pix	2025-05-12
427	1	3	50.00	Pix	2025-05-12
428	32	3	50.00	Dinheiro	2025-05-12
429	42	7	80.00	Pix	2025-05-12
430	46	4	120.00	Dinheiro	2025-05-12
431	8	7	80.00	Crédito	2025-05-12
432	30	9	35.00	Crédito	2025-05-12
433	12	9	35.00	Crédito	2025-05-12
434	6	14	50.00	Débito	2025-05-12
435	57	13	15.00	Pix	2025-05-13
436	41	2	40.00	Débito	2025-05-13
437	42	8	30.00	Pix	2025-05-13
438	16	6	250.00	Pix	2025-05-13
439	6	11	90.00	Crédito	2025-05-13
440	55	15	100.00	Dinheiro	2025-05-13
441	17	5	150.00	Débito	2025-05-13
442	29	8	30.00	Pix	2025-05-13
443	37	8	30.00	Crédito	2025-05-13
444	50	10	25.00	Crédito	2025-05-13
445	5	6	250.00	Dinheiro	2025-05-13
446	22	10	25.00	Débito	2025-05-13
447	30	6	250.00	Crédito	2025-05-13
448	25	2	40.00	Pix	2025-05-13
449	51	14	50.00	Pix	2025-05-13
450	33	4	120.00	Débito	2025-05-13
451	43	1	60.00	Pix	2025-05-13
452	10	12	100.00	Débito	2025-05-13
453	53	2	40.00	Pix	2025-05-13
454	20	3	50.00	Débito	2025-05-13
455	8	10	25.00	Débito	2025-05-13
456	13	8	30.00	Débito	2025-05-13
457	58	1	60.00	Pix	2025-05-13
458	26	10	25.00	Débito	2025-05-13
459	19	13	15.00	Débito	2025-05-13
460	48	9	35.00	Pix	2025-05-13
461	56	10	25.00	Débito	2025-05-13
462	49	11	90.00	Crédito	2025-05-13
463	9	5	150.00	Crédito	2025-05-13
464	36	15	100.00	Dinheiro	2025-05-13
465	44	7	80.00	Crédito	2025-05-13
466	54	14	50.00	Crédito	2025-05-13
467	31	14	50.00	Crédito	2025-05-13
468	3	9	35.00	Débito	2025-05-13
469	15	10	25.00	Dinheiro	2025-05-13
470	24	2	40.00	Débito	2025-05-13
471	23	6	250.00	Débito	2025-05-13
472	9	10	25.00	Pix	2025-05-14
473	28	4	120.00	Crédito	2025-05-14
474	7	8	30.00	Dinheiro	2025-05-14
475	16	2	40.00	Pix	2025-05-14
476	38	8	30.00	Crédito	2025-05-14
477	24	11	90.00	Crédito	2025-05-14
478	44	12	100.00	Dinheiro	2025-05-14
479	43	11	90.00	Crédito	2025-05-14
480	34	3	50.00	Dinheiro	2025-05-14
481	13	15	100.00	Crédito	2025-05-14
482	42	6	250.00	Crédito	2025-05-14
483	18	6	250.00	Pix	2025-05-14
484	4	13	15.00	Crédito	2025-05-14
485	58	13	15.00	Crédito	2025-05-14
486	10	8	30.00	Dinheiro	2025-05-14
487	60	3	50.00	Débito	2025-05-14
488	15	12	100.00	Pix	2025-05-14
489	22	10	25.00	Dinheiro	2025-05-14
490	35	1	60.00	Débito	2025-05-14
491	50	14	50.00	Pix	2025-05-14
492	48	8	30.00	Crédito	2025-05-14
493	12	1	60.00	Dinheiro	2025-05-14
494	21	6	250.00	Dinheiro	2025-05-14
495	1	11	90.00	Dinheiro	2025-05-14
496	47	2	40.00	Dinheiro	2025-05-14
497	30	3	50.00	Pix	2025-05-14
498	54	15	100.00	Dinheiro	2025-05-14
499	6	5	150.00	Pix	2025-05-14
500	53	2	40.00	Crédito	2025-05-14
501	25	5	150.00	Débito	2025-05-14
502	56	4	120.00	Crédito	2025-05-14
503	2	11	90.00	Débito	2025-05-14
504	55	13	15.00	Pix	2025-05-14
505	49	4	120.00	Dinheiro	2025-05-14
506	39	15	100.00	Dinheiro	2025-05-14
507	39	15	100.00	Pix	2025-05-15
508	32	2	40.00	Dinheiro	2025-05-15
509	52	9	35.00	Crédito	2025-05-15
510	49	1	60.00	Dinheiro	2025-05-15
511	48	8	30.00	Crédito	2025-05-15
512	38	6	250.00	Pix	2025-05-15
513	18	5	150.00	Dinheiro	2025-05-15
514	35	12	100.00	Crédito	2025-05-15
515	3	3	50.00	Crédito	2025-05-15
516	31	11	90.00	Crédito	2025-05-15
517	53	6	250.00	Dinheiro	2025-05-15
518	54	15	100.00	Crédito	2025-05-15
519	11	14	50.00	Crédito	2025-05-15
520	36	8	30.00	Dinheiro	2025-05-15
521	6	15	100.00	Débito	2025-05-15
522	21	15	100.00	Dinheiro	2025-05-15
523	47	2	40.00	Dinheiro	2025-05-15
524	59	14	50.00	Débito	2025-05-15
525	19	10	25.00	Crédito	2025-05-15
526	45	4	120.00	Dinheiro	2025-05-15
527	7	10	25.00	Dinheiro	2025-05-15
528	50	8	30.00	Dinheiro	2025-05-15
529	15	11	90.00	Pix	2025-05-15
530	28	11	90.00	Débito	2025-05-15
531	51	5	150.00	Pix	2025-05-15
532	5	8	30.00	Crédito	2025-05-15
533	1	8	30.00	Débito	2025-05-15
534	2	5	150.00	Débito	2025-05-15
535	22	4	120.00	Dinheiro	2025-05-15
536	46	2	40.00	Débito	2025-05-15
537	29	14	50.00	Crédito	2025-05-15
538	57	5	150.00	Débito	2025-05-15
539	30	11	90.00	Dinheiro	2025-05-15
540	58	12	100.00	Pix	2025-05-15
541	9	4	120.00	Crédito	2025-05-15
542	27	5	150.00	Pix	2025-05-15
543	12	3	50.00	Débito	2025-05-15
544	4	5	150.00	Pix	2025-05-15
545	13	13	15.00	Dinheiro	2025-05-16
546	53	11	90.00	Pix	2025-05-16
547	3	7	80.00	Pix	2025-05-16
548	25	5	150.00	Crédito	2025-05-16
549	4	15	100.00	Débito	2025-05-16
550	29	15	100.00	Pix	2025-05-16
551	36	9	35.00	Crédito	2025-05-16
552	14	9	35.00	Dinheiro	2025-05-16
553	15	1	60.00	Crédito	2025-05-16
554	31	12	100.00	Crédito	2025-05-16
555	52	2	40.00	Débito	2025-05-16
556	43	3	50.00	Débito	2025-05-16
557	60	5	150.00	Pix	2025-05-16
558	11	4	120.00	Débito	2025-05-16
559	28	8	30.00	Crédito	2025-05-16
560	22	3	50.00	Crédito	2025-05-16
561	40	5	150.00	Crédito	2025-05-16
562	34	11	90.00	Débito	2025-05-16
563	16	15	100.00	Crédito	2025-05-16
564	12	4	120.00	Crédito	2025-05-16
565	56	15	100.00	Débito	2025-05-16
566	9	4	120.00	Débito	2025-05-16
567	39	15	100.00	Crédito	2025-05-16
568	47	1	60.00	Dinheiro	2025-05-16
569	46	6	250.00	Crédito	2025-05-16
570	1	5	150.00	Crédito	2025-05-16
571	33	3	50.00	Crédito	2025-05-16
572	23	12	100.00	Débito	2025-05-16
573	18	7	80.00	Crédito	2025-05-16
574	19	4	120.00	Pix	2025-05-16
575	20	8	30.00	Crédito	2025-05-16
576	58	8	30.00	Pix	2025-05-16
577	45	2	40.00	Dinheiro	2025-05-16
578	24	15	100.00	Crédito	2025-05-17
579	58	14	50.00	Dinheiro	2025-05-17
580	60	3	50.00	Dinheiro	2025-05-17
581	48	5	150.00	Crédito	2025-05-17
582	37	11	90.00	Crédito	2025-05-17
583	57	4	120.00	Dinheiro	2025-05-17
584	36	1	60.00	Pix	2025-05-17
585	29	7	80.00	Crédito	2025-05-17
586	1	5	150.00	Pix	2025-05-17
587	7	15	100.00	Pix	2025-05-17
588	17	9	35.00	Débito	2025-05-17
589	23	10	25.00	Débito	2025-05-17
590	28	7	80.00	Débito	2025-05-17
591	59	11	90.00	Débito	2025-05-17
592	6	8	30.00	Débito	2025-05-17
593	9	6	250.00	Débito	2025-05-17
594	32	8	30.00	Débito	2025-05-17
595	44	1	60.00	Pix	2025-05-17
596	10	11	90.00	Débito	2025-05-17
597	2	1	60.00	Crédito	2025-05-17
598	47	6	250.00	Pix	2025-05-17
599	4	15	100.00	Crédito	2025-05-17
600	49	2	40.00	Débito	2025-05-17
601	35	1	60.00	Dinheiro	2025-05-17
602	52	3	50.00	Dinheiro	2025-05-17
603	12	10	25.00	Pix	2025-05-17
604	19	2	40.00	Crédito	2025-05-17
605	25	4	120.00	Débito	2025-05-17
606	50	14	50.00	Pix	2025-05-17
607	55	8	30.00	Crédito	2025-05-17
608	46	1	60.00	Pix	2025-05-17
609	56	5	150.00	Débito	2025-05-17
610	29	14	50.00	Débito	2025-05-18
611	7	14	50.00	Pix	2025-05-18
612	38	1	60.00	Pix	2025-05-18
613	43	7	80.00	Crédito	2025-05-18
614	40	11	90.00	Débito	2025-05-18
615	53	12	100.00	Pix	2025-05-18
616	57	15	100.00	Crédito	2025-05-18
617	34	7	80.00	Crédito	2025-05-18
618	27	1	60.00	Débito	2025-05-18
619	21	11	90.00	Crédito	2025-05-18
620	26	14	50.00	Dinheiro	2025-05-18
621	2	8	30.00	Crédito	2025-05-18
622	5	3	50.00	Pix	2025-05-18
623	33	1	60.00	Dinheiro	2025-05-18
624	51	13	15.00	Crédito	2025-05-18
625	39	9	35.00	Pix	2025-05-18
626	19	11	90.00	Crédito	2025-05-18
627	28	15	100.00	Débito	2025-05-18
628	6	5	150.00	Crédito	2025-05-18
629	41	3	50.00	Dinheiro	2025-05-18
630	50	8	30.00	Crédito	2025-05-18
631	37	2	40.00	Débito	2025-05-18
632	49	13	15.00	Crédito	2025-05-18
633	13	7	80.00	Crédito	2025-05-18
634	1	7	80.00	Crédito	2025-05-18
635	30	14	50.00	Crédito	2025-05-18
636	54	14	50.00	Débito	2025-05-18
637	9	6	250.00	Débito	2025-05-18
638	46	12	100.00	Crédito	2025-05-18
639	12	7	80.00	Débito	2025-05-18
640	18	11	90.00	Crédito	2025-05-18
641	4	5	150.00	Pix	2025-05-18
642	10	10	25.00	Pix	2025-05-18
643	48	12	100.00	Crédito	2025-05-18
644	58	5	150.00	Pix	2025-05-18
645	45	7	80.00	Dinheiro	2025-05-18
646	31	8	30.00	Débito	2025-05-18
647	57	3	50.00	Pix	2025-05-19
648	29	15	100.00	Dinheiro	2025-05-19
649	23	2	40.00	Pix	2025-05-19
650	50	13	15.00	Crédito	2025-05-19
651	43	12	100.00	Dinheiro	2025-05-19
652	35	10	25.00	Crédito	2025-05-19
653	24	5	150.00	Débito	2025-05-19
654	30	15	100.00	Dinheiro	2025-05-19
655	49	13	15.00	Débito	2025-05-19
656	34	5	150.00	Débito	2025-05-19
657	16	12	100.00	Débito	2025-05-19
658	18	9	35.00	Pix	2025-05-19
659	40	13	15.00	Dinheiro	2025-05-19
660	25	3	50.00	Crédito	2025-05-19
661	47	13	15.00	Pix	2025-05-19
662	38	4	120.00	Dinheiro	2025-05-19
663	48	12	100.00	Débito	2025-05-19
664	17	3	50.00	Pix	2025-05-19
665	36	9	35.00	Dinheiro	2025-05-19
666	4	9	35.00	Débito	2025-05-19
667	1	10	25.00	Dinheiro	2025-05-19
668	12	14	50.00	Dinheiro	2025-05-19
669	7	2	40.00	Débito	2025-05-19
670	60	1	60.00	Crédito	2025-05-19
671	39	1	60.00	Dinheiro	2025-05-19
672	10	10	25.00	Débito	2025-05-19
673	53	7	80.00	Pix	2025-05-19
674	19	14	50.00	Débito	2025-05-19
675	9	3	50.00	Débito	2025-05-19
676	45	14	50.00	Dinheiro	2025-05-19
677	55	15	100.00	Débito	2025-05-19
678	22	11	90.00	Débito	2025-05-19
679	3	8	30.00	Crédito	2025-05-20
680	40	15	100.00	Débito	2025-05-20
681	10	12	100.00	Pix	2025-05-20
682	26	10	25.00	Dinheiro	2025-05-20
683	7	8	30.00	Pix	2025-05-20
684	8	5	150.00	Crédito	2025-05-20
685	42	2	40.00	Pix	2025-05-20
686	6	9	35.00	Crédito	2025-05-20
687	54	11	90.00	Débito	2025-05-20
688	38	4	120.00	Dinheiro	2025-05-20
689	53	10	25.00	Dinheiro	2025-05-20
690	31	15	100.00	Crédito	2025-05-20
691	14	5	150.00	Débito	2025-05-20
692	30	4	120.00	Pix	2025-05-20
693	11	4	120.00	Pix	2025-05-20
694	37	12	100.00	Dinheiro	2025-05-20
695	22	4	120.00	Dinheiro	2025-05-20
696	36	10	25.00	Crédito	2025-05-20
697	1	10	25.00	Débito	2025-05-20
698	57	7	80.00	Pix	2025-05-20
699	13	8	30.00	Dinheiro	2025-05-20
700	35	13	15.00	Dinheiro	2025-05-20
701	4	7	80.00	Pix	2025-05-20
702	58	8	30.00	Dinheiro	2025-05-20
703	16	3	50.00	Débito	2025-05-20
704	17	9	35.00	Dinheiro	2025-05-20
705	2	8	30.00	Crédito	2025-05-20
706	47	3	50.00	Pix	2025-05-20
707	5	6	250.00	Débito	2025-05-20
708	9	15	100.00	Dinheiro	2025-05-20
709	27	6	250.00	Débito	2025-05-20
710	32	6	250.00	Pix	2025-05-20
711	48	10	25.00	Pix	2025-05-20
712	41	5	150.00	Pix	2025-05-20
713	15	10	25.00	Débito	2025-05-20
714	25	14	50.00	Débito	2025-05-20
715	18	6	250.00	Dinheiro	2025-05-20
716	55	4	120.00	Débito	2025-05-20
717	56	10	25.00	Crédito	2025-05-20
718	32	10	25.00	Dinheiro	2025-05-21
719	36	15	100.00	Dinheiro	2025-05-21
720	23	4	120.00	Pix	2025-05-21
721	25	1	60.00	Dinheiro	2025-05-21
722	55	10	25.00	Pix	2025-05-21
723	29	8	30.00	Dinheiro	2025-05-21
724	47	11	90.00	Crédito	2025-05-21
725	33	11	90.00	Dinheiro	2025-05-21
726	46	14	50.00	Débito	2025-05-21
727	15	5	150.00	Dinheiro	2025-05-21
728	51	2	40.00	Pix	2025-05-21
729	27	12	100.00	Crédito	2025-05-21
730	59	15	100.00	Dinheiro	2025-05-21
731	10	1	60.00	Pix	2025-05-21
732	12	7	80.00	Crédito	2025-05-21
733	39	11	90.00	Crédito	2025-05-21
734	11	1	60.00	Débito	2025-05-21
735	42	5	150.00	Crédito	2025-05-21
736	21	14	50.00	Pix	2025-05-21
737	28	5	150.00	Pix	2025-05-21
738	24	15	100.00	Crédito	2025-05-21
739	16	10	25.00	Dinheiro	2025-05-21
740	35	1	60.00	Pix	2025-05-21
741	14	13	15.00	Débito	2025-05-21
742	13	4	120.00	Pix	2025-05-21
743	56	15	100.00	Crédito	2025-05-21
744	53	1	60.00	Pix	2025-05-21
745	44	8	30.00	Pix	2025-05-21
746	26	11	90.00	Pix	2025-05-21
747	8	9	35.00	Crédito	2025-05-21
748	34	1	60.00	Pix	2025-05-21
749	18	5	150.00	Dinheiro	2025-05-21
750	51	5	150.00	Débito	2025-05-22
751	59	8	30.00	Dinheiro	2025-05-22
752	17	7	80.00	Crédito	2025-05-22
753	60	10	25.00	Pix	2025-05-22
754	47	5	150.00	Crédito	2025-05-22
755	38	2	40.00	Dinheiro	2025-05-22
756	50	1	60.00	Pix	2025-05-22
757	32	10	25.00	Dinheiro	2025-05-22
758	21	15	100.00	Crédito	2025-05-22
759	44	6	250.00	Débito	2025-05-22
760	13	1	60.00	Dinheiro	2025-05-22
761	55	4	120.00	Pix	2025-05-22
762	39	1	60.00	Pix	2025-05-22
763	48	4	120.00	Pix	2025-05-22
764	26	12	100.00	Crédito	2025-05-22
765	43	12	100.00	Dinheiro	2025-05-22
766	49	8	30.00	Débito	2025-05-22
767	28	10	25.00	Dinheiro	2025-05-22
768	53	11	90.00	Débito	2025-05-22
769	4	10	25.00	Crédito	2025-05-22
770	9	7	80.00	Débito	2025-05-22
771	34	14	50.00	Débito	2025-05-22
772	2	13	15.00	Dinheiro	2025-05-22
773	24	2	40.00	Crédito	2025-05-22
774	25	4	120.00	Débito	2025-05-22
775	1	2	40.00	Pix	2025-05-22
776	15	10	25.00	Crédito	2025-05-22
777	23	15	100.00	Débito	2025-05-22
778	56	9	35.00	Crédito	2025-05-22
779	18	2	40.00	Pix	2025-05-22
780	19	6	250.00	Pix	2025-05-22
781	3	11	90.00	Débito	2025-05-22
782	58	8	30.00	Pix	2025-05-22
783	40	11	90.00	Pix	2025-05-22
784	55	11	90.00	Débito	2025-05-23
785	28	5	150.00	Dinheiro	2025-05-23
786	30	1	60.00	Débito	2025-05-23
787	1	13	15.00	Débito	2025-05-23
788	34	7	80.00	Dinheiro	2025-05-23
789	8	4	120.00	Dinheiro	2025-05-23
790	38	13	15.00	Pix	2025-05-23
791	39	8	30.00	Débito	2025-05-23
792	19	7	80.00	Crédito	2025-05-23
793	56	5	150.00	Crédito	2025-05-23
794	7	2	40.00	Crédito	2025-05-23
795	26	15	100.00	Pix	2025-05-23
796	42	12	100.00	Débito	2025-05-23
797	50	3	50.00	Débito	2025-05-23
798	6	14	50.00	Dinheiro	2025-05-23
799	53	5	150.00	Pix	2025-05-23
800	54	14	50.00	Pix	2025-05-23
801	31	13	15.00	Débito	2025-05-23
802	59	11	90.00	Dinheiro	2025-05-23
803	14	5	150.00	Débito	2025-05-23
804	60	5	150.00	Crédito	2025-05-23
805	47	11	90.00	Crédito	2025-05-23
806	23	6	250.00	Dinheiro	2025-05-23
807	36	11	90.00	Crédito	2025-05-23
808	10	1	60.00	Pix	2025-05-23
809	48	5	150.00	Débito	2025-05-23
810	25	9	35.00	Dinheiro	2025-05-23
811	33	5	150.00	Dinheiro	2025-05-23
812	32	8	30.00	Pix	2025-05-23
813	5	14	50.00	Crédito	2025-05-23
814	37	13	15.00	Crédito	2025-05-23
815	9	14	50.00	Dinheiro	2025-05-23
816	27	15	100.00	Crédito	2025-05-23
817	43	8	30.00	Crédito	2025-05-23
818	16	3	50.00	Pix	2025-05-23
819	12	4	120.00	Pix	2025-05-23
820	43	8	30.00	Débito	2025-05-24
821	11	14	50.00	Débito	2025-05-24
822	40	13	15.00	Dinheiro	2025-05-24
823	53	13	15.00	Pix	2025-05-24
824	33	14	50.00	Dinheiro	2025-05-24
825	46	15	100.00	Dinheiro	2025-05-24
826	36	1	60.00	Crédito	2025-05-24
827	30	5	150.00	Dinheiro	2025-05-24
828	56	14	50.00	Crédito	2025-05-24
829	17	5	150.00	Débito	2025-05-24
830	12	15	100.00	Crédito	2025-05-24
831	5	10	25.00	Crédito	2025-05-24
832	60	1	60.00	Débito	2025-05-24
833	9	12	100.00	Pix	2025-05-24
834	27	6	250.00	Dinheiro	2025-05-24
835	20	11	90.00	Pix	2025-05-24
836	21	12	100.00	Pix	2025-05-24
837	19	2	40.00	Débito	2025-05-24
838	2	12	100.00	Débito	2025-05-24
839	37	1	60.00	Débito	2025-05-24
840	18	9	35.00	Pix	2025-05-24
841	39	12	100.00	Pix	2025-05-24
842	6	3	50.00	Débito	2025-05-24
843	47	7	80.00	Débito	2025-05-24
844	49	4	120.00	Dinheiro	2025-05-24
845	51	9	35.00	Dinheiro	2025-05-24
846	3	8	30.00	Débito	2025-05-24
847	45	11	90.00	Dinheiro	2025-05-24
848	15	10	25.00	Dinheiro	2025-05-24
849	44	3	50.00	Débito	2025-05-24
850	35	10	25.00	Dinheiro	2025-05-24
851	7	5	150.00	Crédito	2025-05-24
852	22	2	40.00	Crédito	2025-05-24
853	52	15	100.00	Crédito	2025-05-24
854	41	7	80.00	Pix	2025-05-24
855	50	3	50.00	Pix	2025-05-24
856	34	13	15.00	Crédito	2025-05-24
857	29	14	50.00	Pix	2025-05-24
858	8	13	15.00	Débito	2025-05-24
859	25	9	35.00	Débito	2025-05-24
860	33	2	40.00	Crédito	2025-05-25
861	39	8	30.00	Crédito	2025-05-25
862	36	14	50.00	Pix	2025-05-25
863	43	4	120.00	Débito	2025-05-25
864	20	5	150.00	Dinheiro	2025-05-25
865	22	9	35.00	Crédito	2025-05-25
866	46	5	150.00	Dinheiro	2025-05-25
867	55	12	100.00	Pix	2025-05-25
868	28	13	15.00	Dinheiro	2025-05-25
869	17	15	100.00	Crédito	2025-05-25
870	6	11	90.00	Crédito	2025-05-25
871	49	8	30.00	Pix	2025-05-25
872	60	6	250.00	Pix	2025-05-25
873	37	8	30.00	Crédito	2025-05-25
874	1	15	100.00	Pix	2025-05-25
875	16	3	50.00	Pix	2025-05-25
876	24	2	40.00	Crédito	2025-05-25
877	11	13	15.00	Débito	2025-05-25
878	27	13	15.00	Débito	2025-05-25
879	54	7	80.00	Dinheiro	2025-05-25
880	35	13	15.00	Crédito	2025-05-25
881	52	15	100.00	Dinheiro	2025-05-25
882	19	13	15.00	Pix	2025-05-25
883	25	4	120.00	Crédito	2025-05-25
884	53	12	100.00	Débito	2025-05-25
885	48	6	250.00	Dinheiro	2025-05-25
886	57	14	50.00	Crédito	2025-05-25
887	34	6	250.00	Dinheiro	2025-05-25
888	47	4	120.00	Débito	2025-05-25
889	58	6	250.00	Dinheiro	2025-05-25
890	2	8	30.00	Dinheiro	2025-05-25
891	15	14	50.00	Dinheiro	2025-05-25
892	45	15	100.00	Crédito	2025-05-25
893	18	7	80.00	Dinheiro	2025-05-25
894	56	12	100.00	Pix	2025-05-25
895	7	13	15.00	Dinheiro	2025-05-25
896	51	6	250.00	Débito	2025-05-25
897	13	6	250.00	Pix	2025-05-25
898	5	2	40.00	Pix	2025-05-26
899	40	2	40.00	Débito	2025-05-26
900	8	1	60.00	Débito	2025-05-26
901	18	5	150.00	Crédito	2025-05-26
902	33	1	60.00	Crédito	2025-05-26
903	38	9	35.00	Dinheiro	2025-05-26
904	6	7	80.00	Pix	2025-05-26
905	39	12	100.00	Pix	2025-05-26
906	20	13	15.00	Débito	2025-05-26
907	22	9	35.00	Pix	2025-05-26
908	55	14	50.00	Dinheiro	2025-05-26
909	37	13	15.00	Crédito	2025-05-26
910	25	11	90.00	Dinheiro	2025-05-26
911	1	10	25.00	Dinheiro	2025-05-26
912	19	10	25.00	Crédito	2025-05-26
913	28	9	35.00	Pix	2025-05-26
914	14	8	30.00	Débito	2025-05-26
915	12	14	50.00	Débito	2025-05-26
916	36	4	120.00	Pix	2025-05-26
917	27	13	15.00	Pix	2025-05-26
918	9	15	100.00	Crédito	2025-05-26
919	31	11	90.00	Crédito	2025-05-26
920	49	15	100.00	Crédito	2025-05-26
921	29	1	60.00	Pix	2025-05-26
922	13	9	35.00	Débito	2025-05-26
923	44	5	150.00	Pix	2025-05-26
924	60	6	250.00	Crédito	2025-05-26
925	54	13	15.00	Pix	2025-05-26
926	10	5	150.00	Pix	2025-05-26
927	4	5	150.00	Dinheiro	2025-05-26
928	34	8	30.00	Débito	2025-05-26
929	23	4	120.00	Débito	2025-05-26
930	24	14	50.00	Crédito	2025-05-26
931	45	8	30.00	Crédito	2025-05-26
932	17	1	60.00	Pix	2025-05-26
933	46	15	100.00	Dinheiro	2025-05-26
934	5	6	250.00	Pix	2025-05-27
935	19	2	40.00	Crédito	2025-05-27
936	39	2	40.00	Pix	2025-05-27
937	43	1	60.00	Pix	2025-05-27
938	14	13	15.00	Débito	2025-05-27
939	26	7	80.00	Dinheiro	2025-05-27
940	36	6	250.00	Débito	2025-05-27
941	30	7	80.00	Dinheiro	2025-05-27
942	13	6	250.00	Crédito	2025-05-27
943	18	10	25.00	Pix	2025-05-27
944	8	14	50.00	Pix	2025-05-27
945	56	14	50.00	Pix	2025-05-27
946	1	11	90.00	Crédito	2025-05-27
947	52	11	90.00	Pix	2025-05-27
948	58	14	50.00	Pix	2025-05-27
949	29	2	40.00	Crédito	2025-05-27
950	16	14	50.00	Crédito	2025-05-27
951	33	7	80.00	Pix	2025-05-27
952	4	11	90.00	Dinheiro	2025-05-27
953	2	8	30.00	Dinheiro	2025-05-27
954	25	12	100.00	Crédito	2025-05-27
955	38	9	35.00	Crédito	2025-05-27
956	17	3	50.00	Crédito	2025-05-27
957	7	6	250.00	Pix	2025-05-27
958	47	3	50.00	Dinheiro	2025-05-27
959	28	1	60.00	Crédito	2025-05-27
960	46	14	50.00	Crédito	2025-05-27
961	34	5	150.00	Crédito	2025-05-27
962	37	5	150.00	Débito	2025-05-27
963	45	13	15.00	Pix	2025-05-27
964	35	8	30.00	Pix	2025-05-27
965	48	3	50.00	Débito	2025-05-27
966	20	13	15.00	Débito	2025-05-28
967	13	12	100.00	Pix	2025-05-28
968	38	8	30.00	Débito	2025-05-28
969	8	15	100.00	Dinheiro	2025-05-28
970	49	13	15.00	Crédito	2025-05-28
971	30	9	35.00	Débito	2025-05-28
972	48	11	90.00	Crédito	2025-05-28
973	46	13	15.00	Dinheiro	2025-05-28
974	15	11	90.00	Débito	2025-05-28
975	60	15	100.00	Dinheiro	2025-05-28
976	28	8	30.00	Débito	2025-05-28
977	36	15	100.00	Débito	2025-05-28
978	53	8	30.00	Dinheiro	2025-05-28
979	40	2	40.00	Dinheiro	2025-05-28
980	6	13	15.00	Débito	2025-05-28
981	22	6	250.00	Dinheiro	2025-05-28
982	17	9	35.00	Dinheiro	2025-05-28
983	50	15	100.00	Crédito	2025-05-28
984	42	3	50.00	Crédito	2025-05-28
985	19	8	30.00	Crédito	2025-05-28
986	14	12	100.00	Pix	2025-05-28
987	21	8	30.00	Pix	2025-05-28
988	23	7	80.00	Dinheiro	2025-05-28
989	33	11	90.00	Crédito	2025-05-28
990	1	1	60.00	Dinheiro	2025-05-28
991	29	9	35.00	Dinheiro	2025-05-28
992	39	8	30.00	Débito	2025-05-28
993	59	6	250.00	Dinheiro	2025-05-28
994	9	12	100.00	Crédito	2025-05-28
995	45	10	25.00	Débito	2025-05-28
996	55	6	250.00	Pix	2025-05-28
997	34	6	250.00	Débito	2025-05-28
998	16	7	80.00	Crédito	2025-05-28
999	10	14	50.00	Dinheiro	2025-05-28
1000	7	12	100.00	Débito	2025-05-28
1001	31	1	60.00	Débito	2025-05-28
1002	35	6	250.00	Dinheiro	2025-05-28
1003	12	7	80.00	Pix	2025-05-28
1004	56	12	100.00	Débito	2025-05-29
1005	4	4	120.00	Débito	2025-05-29
1006	6	6	250.00	Crédito	2025-05-29
1007	55	14	50.00	Pix	2025-05-29
1008	30	2	40.00	Débito	2025-05-29
1009	18	14	50.00	Dinheiro	2025-05-29
1010	20	4	120.00	Dinheiro	2025-05-29
1011	19	12	100.00	Crédito	2025-05-29
1012	52	15	100.00	Débito	2025-05-29
1013	34	4	120.00	Débito	2025-05-29
1014	8	15	100.00	Dinheiro	2025-05-29
1015	17	2	40.00	Pix	2025-05-29
1016	9	6	250.00	Pix	2025-05-29
1017	29	4	120.00	Pix	2025-05-29
1018	50	12	100.00	Débito	2025-05-29
1019	40	9	35.00	Débito	2025-05-29
1020	16	6	250.00	Dinheiro	2025-05-29
1021	35	14	50.00	Crédito	2025-05-29
1022	26	2	40.00	Dinheiro	2025-05-29
1023	23	4	120.00	Dinheiro	2025-05-29
1024	48	10	25.00	Crédito	2025-05-29
1025	12	7	80.00	Débito	2025-05-29
1026	49	9	35.00	Dinheiro	2025-05-29
1027	45	3	50.00	Crédito	2025-05-29
1028	33	1	60.00	Pix	2025-05-29
1029	54	6	250.00	Dinheiro	2025-05-29
1030	31	14	50.00	Crédito	2025-05-29
1031	60	7	80.00	Débito	2025-05-29
1032	13	13	15.00	Dinheiro	2025-05-29
1033	37	8	30.00	Débito	2025-05-29
1034	53	1	60.00	Pix	2025-05-29
1035	25	3	50.00	Dinheiro	2025-05-29
1036	36	8	30.00	Pix	2025-05-29
1037	32	14	50.00	Débito	2025-05-29
1038	43	11	90.00	Débito	2025-05-29
1039	5	8	30.00	Débito	2025-05-29
1040	15	14	50.00	Débito	2025-05-29
1041	58	9	35.00	Pix	2025-05-29
1042	10	14	50.00	Dinheiro	2025-05-29
1043	52	14	50.00	Pix	2025-05-30
1044	46	6	250.00	Dinheiro	2025-05-30
1045	32	11	90.00	Débito	2025-05-30
1046	26	10	25.00	Dinheiro	2025-05-30
1047	33	6	250.00	Débito	2025-05-30
1048	29	4	120.00	Crédito	2025-05-30
1049	55	1	60.00	Crédito	2025-05-30
1050	34	1	60.00	Pix	2025-05-30
1051	14	12	100.00	Pix	2025-05-30
1052	22	14	50.00	Débito	2025-05-30
1053	19	9	35.00	Crédito	2025-05-30
1054	58	1	60.00	Débito	2025-05-30
1055	13	8	30.00	Débito	2025-05-30
1056	9	9	35.00	Pix	2025-05-30
1057	36	7	80.00	Crédito	2025-05-30
1058	11	12	100.00	Débito	2025-05-30
1059	12	1	60.00	Débito	2025-05-30
1060	53	6	250.00	Débito	2025-05-30
1061	43	2	40.00	Pix	2025-05-30
1062	21	6	250.00	Pix	2025-05-30
1063	23	4	120.00	Débito	2025-05-30
1064	40	10	25.00	Dinheiro	2025-05-30
1065	28	9	35.00	Débito	2025-05-30
1066	38	4	120.00	Dinheiro	2025-05-30
1067	39	14	50.00	Dinheiro	2025-05-30
1068	59	14	50.00	Pix	2025-05-30
1069	15	14	50.00	Débito	2025-05-30
1070	16	6	250.00	Dinheiro	2025-05-30
1071	8	15	100.00	Dinheiro	2025-05-30
1072	25	3	50.00	Crédito	2025-05-30
1073	57	13	15.00	Crédito	2025-05-30
1074	12	15	100.00	Dinheiro	2025-05-31
1075	1	13	15.00	Dinheiro	2025-05-31
1076	16	1	60.00	Débito	2025-05-31
1077	37	7	80.00	Dinheiro	2025-05-31
1078	41	13	15.00	Débito	2025-05-31
1079	8	8	30.00	Dinheiro	2025-05-31
1080	55	11	90.00	Crédito	2025-05-31
1081	53	3	50.00	Crédito	2025-05-31
1082	56	14	50.00	Pix	2025-05-31
1083	31	2	40.00	Débito	2025-05-31
1084	29	13	15.00	Débito	2025-05-31
1085	22	1	60.00	Pix	2025-05-31
1086	39	12	100.00	Pix	2025-05-31
1087	58	14	50.00	Pix	2025-05-31
1088	17	6	250.00	Crédito	2025-05-31
1089	13	4	120.00	Crédito	2025-05-31
1090	60	4	120.00	Pix	2025-05-31
1091	23	5	150.00	Crédito	2025-05-31
1092	51	11	90.00	Débito	2025-05-31
1093	6	9	35.00	Pix	2025-05-31
1094	10	8	30.00	Débito	2025-05-31
1095	5	6	250.00	Débito	2025-05-31
1096	30	13	15.00	Crédito	2025-05-31
1097	40	6	250.00	Crédito	2025-05-31
1098	48	6	250.00	Pix	2025-05-31
1099	42	4	120.00	Crédito	2025-05-31
1100	27	8	30.00	Débito	2025-05-31
1101	26	10	25.00	Débito	2025-05-31
1102	3	8	30.00	Crédito	2025-05-31
1103	18	15	100.00	Crédito	2025-05-31
\.


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 231
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: salao; Owner: rodrigo
--

SELECT pg_catalog.setval('salao.clientes_id_seq', 60, true);


--
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 229
-- Name: servicos_id_seq; Type: SEQUENCE SET; Schema: salao; Owner: rodrigo
--

SELECT pg_catalog.setval('salao.servicos_id_seq', 15, true);


--
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 233
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: salao; Owner: rodrigo
--

SELECT pg_catalog.setval('salao.usuarios_id_seq', 2, true);


--
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 235
-- Name: vendas_id_seq; Type: SEQUENCE SET; Schema: salao; Owner: rodrigo
--

SELECT pg_catalog.setval('salao.vendas_id_seq', 1103, true);


--
-- TOC entry 4749 (class 2606 OID 24795)
-- Name: clientes clientes_email_key; Type: CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.clientes
    ADD CONSTRAINT clientes_email_key UNIQUE (email);


--
-- TOC entry 4751 (class 2606 OID 24793)
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4747 (class 2606 OID 24784)
-- Name: servicos servicos_pkey; Type: CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.servicos
    ADD CONSTRAINT servicos_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 2606 OID 24804)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 24806)
-- Name: usuarios usuarios_usuario_key; Type: CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);


--
-- TOC entry 4757 (class 2606 OID 24813)
-- Name: vendas vendas_pkey; Type: CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id);


--
-- TOC entry 4758 (class 2606 OID 24814)
-- Name: vendas vendas_id_cliente_fkey; Type: FK CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.vendas
    ADD CONSTRAINT vendas_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES salao.clientes(id);


--
-- TOC entry 4759 (class 2606 OID 24819)
-- Name: vendas vendas_id_servico_fkey; Type: FK CONSTRAINT; Schema: salao; Owner: rodrigo
--

ALTER TABLE ONLY salao.vendas
    ADD CONSTRAINT vendas_id_servico_fkey FOREIGN KEY (id_servico) REFERENCES salao.servicos(id);


-- Completed on 2025-05-27 22:13:11

--
-- PostgreSQL database dump complete
--

