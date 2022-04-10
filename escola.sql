-- APAGA SE EXISTIR A DATABASE escola

DROP DATABASE IF EXISTS escola;

-- CRIA DATABASE escola VAZIA

CREATE DATABASE escola
    WITH OWNER = postgres
    ENCODING = 'UTF8';

-- CONECTA NA DATABASE escola

\c escola;

-- CRIA TABELA DA ENTIDADE ALUNO

CREATE TABLE ALUNO (
    CPF character(11) NOT NULL,
    Nome character varying(50) NOT NULL,
    Endereco character varying(100),
    Telefone character(14),
    Data_Nasc date,

    CONSTRAINT ALUNO_pk PRIMARY KEY (CPF)
);

-- CRIA TABELA DA ENTIDADE DEPARTAMENTO

CREATE TABLE DEPARTAMENTO (
    ID character(3) NOT NULL,
    Nome character varying(50) NOT NULL,

    CONSTRAINT DEPARTAMENTO_pk PRIMARY KEY (ID)
);

-- CRIA TABELA DA ENTIDADE CURSO

CREATE TABLE CURSO (
    ID character(3) NOT NULL,
    Nome character varying(50) NOT NULL,
    Descricao character varying(100),
    ID_Dpto character(3) NOT NULL,

    CONSTRAINT CURSO_pk PRIMARY KEY (ID),
    CONSTRAINT DEPARTAMENTO_fk FOREIGN KEY (ID_Dpto) REFERENCES DEPARTAMENTO(ID)
);

-- CRIA TABELA DA ENTIDADE PROFESSOR

CREATE TABLE PROFESSOR (
    Matricula integer NOT NULL,
    Nome character varying(50) NOT NULL,
    Endereço character varying(100),
    Telefone character(14),
    Data_Nasc date,
    ID_Dpto character(3),
    Data_Contratacao date,

    CONSTRAINT PROFESSOR_pk PRIMARY KEY (Matricula),
    CONSTRAINT DEPARTAMENTO_fk FOREIGN KEY (ID_Dpto) REFERENCES DEPARTAMENTO(ID)
);

-- CRIA TABELA DA ENTIDADE DISCIPLINA

CREATE TABLE DISCIPLINA (
    ID character(3) NOT NULL,
    Nome character varying(50) NOT NULL,
    Qtde_Creditos bigint,
    Matricula_Prof integer,

    CONSTRAINT DISCIPLINA_pk PRIMARY KEY (ID),
    CONSTRAINT PROFESSOR_fk FOREIGN KEY (Matricula_Prof) REFERENCES PROFESSOR(Matricula)
);

-- CRIA TABELA CURSA DA RELACAO ALUNO x DISCIPLINA

CREATE TABLE CURSA (
    CPF_Aluno character(11) NOT NULL,
    ID_Disc character(3) NOT NULL,

    CONSTRAINT CURSA_pk PRIMARY KEY (CPF_Aluno,ID_Disc),
    CONSTRAINT ALUNO_fk FOREIGN KEY (CPF_Aluno) REFERENCES ALUNO(CPF),
    CONSTRAINT DISCIPLINA_fk FOREIGN KEY (ID_Disc) REFERENCES DISCIPLINA(ID)
);

-- CRIA TABELA COMPOE DA RELACAO CURSO x DISCIPLINA

CREATE TABLE COMPOE (
    ID_Curso character(3) NOT NULL,
    ID_Disc character(3) NOT NULL,

    CONSTRAINT COMPOE_pk PRIMARY KEY (ID_Curso, ID_Disc),
    CONSTRAINT CURSO_fk FOREIGN KEY (ID_Curso) REFERENCES CURSO(ID),
    CONSTRAINT DISCIPLINA_fk FOREIGN KEY (ID_Disc) REFERENCES DISCIPLINA(ID)
);

-- CRIA TABELA MATRICULA DA RELACAO CURSO x ALUNO

CREATE TABLE MATRICULA (
    ID_Curso character(3) NOT NULL,
    CPF_Aluno character(11) NOT NULL,
    Data_Matricula date NOT NULL,

    CONSTRAINT MATRICULA_pk PRIMARY KEY (ID_Curso, CPF_Aluno),
    CONSTRAINT CURSO_fk FOREIGN KEY (ID_Curso) REFERENCES CURSO(ID),
    CONSTRAINT ALUNO_fk FOREIGN KEY (CPF_Aluno) REFERENCES ALUNO(CPF)
);

-- CRIA TABELA PRE_REQ DA RELACAO DISCIPLINA x DISCIPLINA

CREATE TABLE PRE_REQ (
    ID_Disc character(3) NOT NULL,
    ID_Disc_Dependencia character(3) NOT NULL,

    CONSTRAINT PRE_REQ_pk PRIMARY KEY (ID_Disc, ID_Disc_Dependencia),
    CONSTRAINT DEPENDENCIA_fk FOREIGN KEY (ID_Disc_Dependencia) REFERENCES DISCIPLINA(ID),
    CONSTRAINT DISCIPLINA_fk FOREIGN KEY (ID_Disc) REFERENCES DISCIPLINA(ID)
);

-- INSERÇÕES NA TABELA DEPARTAMENTO

INSERT INTO DEPARTAMENTO VALUES ('BDA', 'Banco de Dados'),
                                ('PRO', 'Programação'),
                                ('MAT', 'Matemática');

-- INSERÇÕES NA TABELA PROFESSOR

INSERT INTO PROFESSOR VALUES (10, 'Octávio Loures Bellozi', 'São Paulo - SP', '11999062498   ', '1989-08-03', NULL, '2022-01-01'),
                             (30, 'Matheus Pavani', 'São Paulo - SP', '11932297847   ', '2005-07-01', NULL, NULL),
                             (40, 'Brian', 'São Paulo - SP', '11963913887   ', '1991-09-03', NULL, NULL),
                             (20, 'William Teixeira', NULL, NULL, '1987-07-24', NULL, NULL);

-- INSERÇÕES NA TABELA ALUNO

INSERT INTO ALUNO VALUES ('18520306586', 'Celso Boulhosa Romero Filho', 'Salvador - BA', '71992705000   ', '1981-06-03'),
                         ('01766988849', 'Edson Roberto Sega', 'Campinas - SP', '19997698800   ', '1980-01-01'),
                         ('78545111878', 'Pedro Guilherme Coutinho Jafet', 'São Paulo - SP', '11991374069   ', '1968-08-24'),
                         ('50017093422', 'Roberto Oliveira de Azevedo Maia Filho', 'Recife - PE', '81996744434   ', '1991-09-12'),
                         ('74719958826', 'Ariel Villa', 'Campinas - SP', '19981126712   ', '1972-05-14'),
                         ('78975824853', 'Adriano Salgado', 'Campinas - SP', '19992898586   ', '1975-09-14'),
                         ('19716782870', 'Sergio Narimatsu', 'São Paulo - SP', '11981964198   ', '1979-10-20'),
                         ('85622189870', 'Marcelo de Souza Moraes', 'Campinas - SP', '19997993483   ', '2000-03-03'),
                         ('99113720309', 'Jonab da Cruz Fernandes', 'Fortaleza - CE', '85992706976   ', '1964-08-12'),
                         ('49077722700', 'Ricardo Luz Alves', 'Rio de Janeiro - RJ', '21991566801   ', '1966-08-19'),
                         ('74542329496', 'Rodrigo Agra Coutelo', 'Recife - PE', '81996476300   ', '2003-08-12'),
                         ('58399329819', 'Juliana Trench Abumansur', 'Ribeirão Preto - SP', '16988081881   ', '1936-03-04'),
                         ('14088818881', 'Marcelo Batista de Oliveira', 'Ribeirão Branco - SP', '15991500484   ', '1954-05-10'),
                         ('78790352491', 'Hender Larry Prato Caballero', 'Recife - PE', '81996590802   ', '1997-12-31'),
                         ('82812529873', 'Roddy Elky Ramos Gonzáles', 'Campinas - SP', '19991748770   ', '1989-12-10'),
                         ('76175945697', 'Orlando Abreu Gomes', 'Belo Horizonte - MG', '31999499723   ', '1954-07-22'),
                         ('87845430005', 'Jeferson Barp', 'Porto Alegre - RS', '51992463346   ', '1964-01-21'),
                         ('32751921400', 'Ronaldo Gomes Bandim', 'Recife - PE', '81987886945   ', '1978-08-24'),
                         ('70714085804', 'Adriana Yamashita', 'São Paulo - SP', '11996081414   ', '2018-04-08'),
                         ('96526812708', 'Alecsandro Santos da Silva', 'Rio de Janeiro - RJ', '21987592970   ', '2017-03-30'),
                         ('45033085808', 'Giovani Zanim', 'São Paulo - SP', '11981777074   ', '1994-04-04'),
                         ('37764019585', 'Adriano Andrade Carvalho', 'Aracaju - SE', '79991538866   ', '2002-03-28'),
                         ('75217989882', 'Wagner Monticeli Ponciano', 'Taubate - SP', '12991529106   ', '1966-01-26'),
                         ('98940235843', 'Carolina Costa Gois', 'São Paulo - SP', '11996897727   ', '1986-06-15'),
                         ('08368665841', 'Flavio Sampaio Dantas', 'São Paulo - SP', '11976375466   ', '1943-10-06'),
                         ('45188222000', 'Eduardo Herrmann de Freitas', 'Porto Alegre - RS', '51982211441   ', '1999-09-29');

-- INSERÇÕES NA TABELA CURSO

INSERT INTO CURSO VALUES ('CDA', 'Python & Dados', NULL, 'PRO'),
                         ('DFE', 'Web Front End', NULL, 'PRO'),
                         ('DFS', 'Web Full Stack', NULL, 'PRO');

-- INSERÇÕES NA TABELA DISCIPLINA

INSERT INTO DISCIPLINA VALUES ('LPO', 'Lógica de Programação', NULL, 10),
                              ('POO', 'Programação Orientada a Objetos', NULL, 20),
                              ('ETD', 'Estrutura de Dados', NULL, 30),
                              ('BDA', 'Banco de Dados', NULL, 40),
                              ('WEB', 'Programação Web', NULL, 10),
                              ('EST', 'Estatísticas', NULL, 20),
                              ('MAL', 'Machine Learning', NULL, 30),
                              ('TAU', 'Testes Automatizados', NULL, 20),
                              ('TPR', 'Técnicas de Programação', NULL, 10);

-- INSERÇÕES NA TABELA COMPOE

INSERT INTO COMPOE VALUES ('CDA', 'LPO'),
                          ('CDA', 'POO'),
                          ('CDA', 'ETD'),
                          ('CDA', 'BDA'),
                          ('DFS', 'LPO'),
                          ('DFS', 'POO'),
                          ('DFS', 'TPR'),
                          ('DFS', 'WEB'),
                          ('DFS', 'TAU'),
                          ('DFS', 'BDA');

-- INSERÇÕES NA TABELA CURSA

INSERT INTO CURSA VALUES ('01766988849', 'BDA'),
                         ('08368665841', 'BDA'),
                         ('14088818881', 'BDA'),
                         ('18520306586', 'BDA'),
                         ('19716782870', 'BDA'),
                         ('32751921400', 'EST'),
                         ('37764019585', 'EST'),
                         ('45033085808', 'EST'),
                         ('45188222000', 'EST'),
                         ('49077722700', 'EST'),
                         ('50017093422', 'ETD'),
                         ('58399329819', 'ETD'),
                         ('70714085804', 'ETD'),
                         ('74542329496', 'ETD'),
                         ('74719958826', 'ETD'),
                         ('75217989882', 'LPO'),
                         ('76175945697', 'LPO'),
                         ('78545111878', 'LPO'),
                         ('78790352491', 'LPO'),
                         ('78975824853', 'LPO'),
                         ('82812529873', 'POO'),
                         ('85622189870', 'POO'),
                         ('87845430005', 'POO'),
                         ('96526812708', 'POO'),
                         ('98940235843', 'POO'),
                         ('99113720309', 'WEB');

-- INSERÇÕES NA TABELA MATRICULA

INSERT INTO MATRICULA VALUES ('CDA', '01766988849', '2022-01-01'),
                             ('DFE', '08368665841', '2022-02-01'),
                             ('DFS', '14088818881', '2022-03-01'),
                             ('CDA', '18520306586', '2021-07-01'),
                             ('DFE', '19716782870', '2021-08-01'),
                             ('DFS', '32751921400', '2021-09-01'),
                             ('CDA', '37764019585', '2021-10-01'),
                             ('DFE', '45033085808', '2021-11-01'),
                             ('DFS', '45188222000', '2021-12-01'),
                             ('CDA', '49077722700', '2021-07-01'),
                             ('DFE', '50017093422', '2021-07-01'),
                             ('DFS', '58399329819', '2021-07-01'),
                             ('CDA', '70714085804', '2021-07-01'),
                             ('DFE', '74542329496', '2021-07-01'),
                             ('DFS', '74719958826', '2021-07-01'),
                             ('CDA', '75217989882', '2021-07-01'),
                             ('DFE', '76175945697', '2021-07-01'),
                             ('DFS', '78545111878', '2021-07-01'),
                             ('CDA', '78790352491', '2021-07-01'),
                             ('DFE', '78975824853', '2021-07-01'),
                             ('DFS', '82812529873', '2021-07-01'),
                             ('CDA', '85622189870', '2021-07-01'),
                             ('DFE', '87845430005', '2021-07-01'),
                             ('DFS', '96526812708', '2021-07-01'),
                             ('CDA', '98940235843', '2021-07-01'),
                             ('DFE', '99113720309', '2021-07-01'),
                             ('DFS', '18520306586', '2021-07-01');

-- INSERÇÕES NA TABELA PRE_REQ

INSERT INTO PRE_REQ VALUES ('ETD', 'TPR'),
                           ('MAL', 'EST'),
                           ('MAL', 'LPO'),
                           ('MAL', 'POO'),
                           ('MAL', 'TPR'),
                           ('POO', 'LPO'),
                           ('WEB', 'LPO'),
                           ('WEB', 'POO'),
                           ('ETD', 'LPO');