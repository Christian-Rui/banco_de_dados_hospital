create database IF NOT EXISTS hospital_database;
use hospital_database;

DROP TABLE IF EXISTS internacao_enfermeiro;
DROP TABLE IF EXISTS medico_especialidade;
DROP TABLE IF EXISTS consulta;
DROP TABLE IF EXISTS internacoes;
DROP TABLE IF EXISTS quarto;
DROP TABLE IF EXISTS tipo_de_quarto;
DROP TABLE IF EXISTS receita;
DROP TABLE IF EXISTS medicamentos;
DROP TABLE IF EXISTS pacientes;
DROP TABLE IF EXISTS enfermeiro;
DROP TABLE IF EXISTS medicos;
DROP TABLE IF EXISTS dados_pessoais;
DROP TABLE IF EXISTS convenio;
DROP TABLE IF EXISTS crm;
DROP TABLE IF EXISTS documentos;
DROP TABLE IF EXISTS especialidade;
DROP TABLE IF EXISTS nome;
DROP TABLE IF EXISTS telefones;
DROP TABLE IF EXISTS endereço;


CREATE TABLE IF NOT EXISTS `dados_pessoais` (
	`id_dados_pessoais` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_nome` int NOT NULL,
	`data_de_nascimento` date NOT NULL,
	`id_telefone` int NOT NULL,
	`id_endereco` int NOT NULL,
	`email` varchar(255) UNIQUE,
	PRIMARY KEY (`id_dados_pessoais`)
);

CREATE TABLE IF NOT EXISTS `medicos` (
	`id_medico` int AUTO_INCREMENT NOT NULL UNIQUE,
	`cargo` varchar(255) NOT NULL,
	`id_dados_pessoais` int NOT NULL,
	`id_documentos` int NOT NULL UNIQUE,
	`id_crm` int NOT NULL UNIQUE,
    `id_convenio` int,
	PRIMARY KEY (`id_medico`)
);

CREATE TABLE IF NOT EXISTS `crm` (
	`id_crm` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_especialidade` int NOT NULL,
	`id_nome` int NOT NULL,
	PRIMARY KEY (`id_crm`)
);

CREATE TABLE IF NOT EXISTS `documentos` (
	`id_documentos` int AUTO_INCREMENT NOT NULL UNIQUE,
	`rg` varchar(255) NOT NULL UNIQUE,
	`cpf` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`id_documentos`)
);

CREATE TABLE IF NOT EXISTS `especialidade` (
	`id_especialidade` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome_da_especialidade` varchar(255) NOT NULL,
	PRIMARY KEY (`id_especialidade`)
);

CREATE TABLE `medico_especialidade` (
    `id_medico` int,
	`id_especialidade` int,
    PRIMARY KEY (`id_medico`,`id_especialidade` ),
    FOREIGN KEY (`id_medico`) REFERENCES `medicos`(`id_medico`),
    FOREIGN KEY (`id_especialidade`) REFERENCES `especialidade`(`id_especialidade`)
);

CREATE TABLE IF NOT EXISTS `nome` (
	`id_nome` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(255) NOT NULL,
	`nome_social` varchar(255),
	PRIMARY KEY (`id_nome`)
);

CREATE TABLE IF NOT EXISTS `telefones` (
	`id_telefone` int AUTO_INCREMENT NOT NULL UNIQUE,
	`ddd` varchar(255) NOT NULL,
	`telefone` varchar(255) NOT NULL,
	PRIMARY KEY (`id_telefone`)
);

CREATE TABLE IF NOT EXISTS `endereço` (
	`id_endereco` int AUTO_INCREMENT NOT NULL UNIQUE,
	`numero_endereco` varchar(255) NOT NULL,
	`cep` varchar(255) NOT NULL,
	`rua` varchar(255) NOT NULL,
	`bairro` varchar(255) NOT NULL,
	`cidade` varchar(255) NOT NULL,
	`estado` varchar(255) NOT NULL,
	PRIMARY KEY (`id_endereco`)
);

CREATE TABLE IF NOT EXISTS `pacientes` (
	`id_paciente` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_dados_pessoais` int NOT NULL,
	`id_documentos` int NOT NULL,
	`id_convenio` int,
	PRIMARY KEY (`id_paciente`)
);

CREATE TABLE IF NOT EXISTS `enfermeiro` (
	`id_enfermeiro` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_dados_pessoais` int NOT NULL,
	`cpf_enfermeiro` varchar(255) NOT NULL,
	`cre` varchar(255) NOT NULL,
	PRIMARY KEY (`id_enfermeiro`)
);

CREATE TABLE IF NOT EXISTS `convenio` (
	`id_convenio` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome_convenio` varchar(255) NOT NULL,
	`cnpj` varchar(255) NOT NULL UNIQUE,
	`tempo_de_carencia` time NOT NULL,
	PRIMARY KEY (`id_convenio`)
);

CREATE TABLE IF NOT EXISTS `consulta` (
	`id_consulta` int AUTO_INCREMENT NOT NULL UNIQUE,
	`data_hora_consulta` datetime NOT NULL,
	`id_medico` int NOT NULL,
	`id_paciente` int NOT NULL,
	`valor_consulta` double NOT NULL,
	`id_convenio` int,
	`numero_da_carteira` varchar(255) NOT NULL UNIQUE,
	`id_receita` int,
	PRIMARY KEY (`id_consulta`)
);

CREATE TABLE IF NOT EXISTS `receita` (
	`id_receita` int AUTO_INCREMENT NOT NULL UNIQUE,
	`id_medicamentos` int NOT NULL,
	PRIMARY KEY (`id_receita`)
);

CREATE TABLE IF NOT EXISTS `medicamentos` (
	`id_medicamentos` int AUTO_INCREMENT NOT NULL UNIQUE,
	`quantidade` int NOT NULL,
	`instrucoes` varchar(255) NOT NULL,
	PRIMARY KEY (`id_medicamentos`)
);

CREATE TABLE IF NOT EXISTS `internacoes` (
	`id_internacoes` int AUTO_INCREMENT NOT NULL UNIQUE,
	`data_entrada` date NOT NULL,
	`data_prevista_alta` date NOT NULL,
	`data_efetiva_alta` date NOT NULL,
	`descricao_procedimentos` varchar(255) NOT NULL,
	`id_quarto` int NOT NULL,
	`id_enfermeiro` int NOT NULL,
	`id_paciente` int NOT NULL,
	`id_medico` int NOT NULL,
	PRIMARY KEY (`id_internacoes`)
);

CREATE TABLE `internacao_enfermeiro` (
    `id_internacao` int,
    `id_enfermeiro` int,
    PRIMARY KEY (`id_internacao`, `id_enfermeiro`),
    FOREIGN KEY (`id_internacao`) REFERENCES `internacoes`(`id_internacoes`),
    FOREIGN KEY (`id_enfermeiro`) REFERENCES `enfermeiro`(`id_enfermeiro`)
);

CREATE TABLE IF NOT EXISTS `quarto` (
	`id_quarto` int AUTO_INCREMENT NOT NULL UNIQUE,
	`numeracao` varchar(255) NOT NULL,
	`id_tipo_de_quarto` int NOT NULL,
	PRIMARY KEY (`id_quarto`)
);

CREATE TABLE IF NOT EXISTS `tipo_de_quarto` (
	`id_tipo_de_quarto` int AUTO_INCREMENT NOT NULL UNIQUE,
	`descricao` varchar(255) NOT NULL,
	`valor_diaria` double NOT NULL,
	PRIMARY KEY (`id_tipo_de_quarto`)
);

ALTER TABLE `dados_pessoais` ADD CONSTRAINT `dados_pessoais_fk1` FOREIGN KEY (`id_nome`) REFERENCES `nome`(`id_nome`);
ALTER TABLE `dados_pessoais` ADD CONSTRAINT `dados_pessoais_fk3` FOREIGN KEY (`id_telefone`) REFERENCES `telefones`(`id_telefone`);
ALTER TABLE `dados_pessoais` ADD CONSTRAINT `dados_pessoais_fk4` FOREIGN KEY (`id_endereco`) REFERENCES `endereço`(`id_endereco`);

ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk2` FOREIGN KEY (`id_dados_pessoais`) REFERENCES `dados_pessoais`(`id_dados_pessoais`);
ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk3` FOREIGN KEY (`id_documentos`) REFERENCES `documentos`(`id_documentos`);
ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk4` FOREIGN KEY (`id_crm`) REFERENCES `crm`(`id_crm`);

ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk_convenio` FOREIGN KEY (`id_convenio`) REFERENCES `convenio`(`id_convenio`);

ALTER TABLE `crm` ADD CONSTRAINT `crm_fk1` FOREIGN KEY (`id_especialidade`) REFERENCES `especialidade`(`id_especialidade`);
ALTER TABLE `crm` ADD CONSTRAINT `crm_fk2` FOREIGN KEY (`id_nome`) REFERENCES `nome`(`id_nome`);

ALTER TABLE `pacientes` ADD CONSTRAINT `pacientes_fk1` FOREIGN KEY (`id_dados_pessoais`) REFERENCES `dados_pessoais`(`id_dados_pessoais`);
ALTER TABLE `pacientes` ADD CONSTRAINT `pacientes_fk2` FOREIGN KEY (`id_documentos`) REFERENCES `documentos`(`id_documentos`);
ALTER TABLE `pacientes` ADD CONSTRAINT `pacientes_fk3` FOREIGN KEY (`id_convenio`) REFERENCES `convenio`(`id_convenio`);

ALTER TABLE `enfermeiro` ADD CONSTRAINT `enfermeiro_fk1` FOREIGN KEY (`id_dados_pessoais`) REFERENCES `dados_pessoais`(`id_dados_pessoais`);

ALTER TABLE `consulta` ADD CONSTRAINT `consulta_fk2` FOREIGN KEY (`id_medico`) REFERENCES `medicos`(`id_medico`);
ALTER TABLE `consulta` ADD CONSTRAINT `consulta_fk3` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes`(`id_paciente`);
ALTER TABLE `consulta` ADD CONSTRAINT `consulta_fk5` FOREIGN KEY (`id_convenio`) REFERENCES `convenio`(`id_convenio`);
ALTER TABLE `consulta` ADD CONSTRAINT `consulta_fk7` FOREIGN KEY (`id_receita`) REFERENCES `receita`(`id_receita`);

ALTER TABLE `receita` ADD CONSTRAINT `receita_fk1` FOREIGN KEY (`id_medicamentos`) REFERENCES `medicamentos`(`id_medicamentos`);

ALTER TABLE `internacoes` ADD CONSTRAINT `internacoes_fk5` FOREIGN KEY (`id_quarto`) REFERENCES `quarto`(`id_quarto`);
ALTER TABLE `internacoes` ADD CONSTRAINT `internacoes_fk6` FOREIGN KEY (`id_enfermeiro`) REFERENCES `Enfermeiro`(`id_enfermeiro`);
ALTER TABLE `internacoes` ADD CONSTRAINT `internacoes_fk7` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes`(`id_paciente`);
ALTER TABLE `internacoes` ADD CONSTRAINT `internacoes_fk8` FOREIGN KEY (`id_medico`) REFERENCES `medicos`(`id_medico`);

ALTER TABLE `quarto` ADD CONSTRAINT `quarto_fk2` FOREIGN KEY (`id_tipo_de_quarto`) REFERENCES `tipo_de_quarto`(`id_tipo_de_quarto`);



INSERT INTO nome (nome, nome_social) VALUES
('João Silva', NULL),
('Rogério Roger', NULL),
('Erik Paulino', NULL),
('Ana Lima', NULL),
('Carlos Almeida', NULL),
('Beatriz Santos', 'Soul'),
('Fernando Costa', NULL),
('Luiza Pereira', NULL),
('Ingrid Damaceno', NULL),
('Machine Learning', NULL)
;

INSERT INTO nome (nome, nome_social) VALUES
('Lívia Silva', NULL),
('Helena Santos', NULL),
('Maitê Costa', NULL),
('Mariana Rodrigues', NULL),
('Alice Souza', NULL),
('Aurora Ferreira', NULL),
('Maya Lima', NULL),
('Isis Pereira', 'Isaque'),
('Charlie Silva', 'Lidia'),
('Eva Santos', 'Evandro'),
('Leticia Almeida', NULL), 
('Katchau Gret', NULL), 
('Hector Bonilia', NULL), 
('Gabriel Lindo', NULL), 
('Bosak Talaric', NULL)
;

INSERT INTO nome ( nome, nome_social) VALUES
('João da Silva', NULL),
('Maria Oliveira', 'Mari'),
('Carlos Souza', 'Carlão'),
('Ana Beatriz', NULL),
('Pedro Santos', NULL),
('Juliana Lima', 'Ju'),
('Marcos Pereira', NULL),
('Fernanda Costa', NULL),
('Rafael Almeida', 'Rafa'),
('Camila Mendes', NULL);

INSERT INTO telefones (ddd, telefone) VALUES
('11', '987654321'),
('21', '987654322'),
('31', '987654323'),
('41', '987654324'),
('51', '987654325'),
('61', '987654326'),
('71', '987654327'),
('81', '987654328'),
('91', '987654329'),
('19', '987654330')
;

INSERT INTO telefones (ddd, telefone) VALUES
('11', '999999999'),
('21', '988888888'),
('31', '977777777'),
('41', '966666666'), 
('51', '955555555'),
('61', '944444444'),
('71', '933333333'),
('81', '922222222'), 
('91', '911111111'), 
('12', '900000000'), 
('22', '899999999'), 
('32', '888888888'), 
('42', '877777777'), 
('52', '866666666'),
('11', '8666806666');

INSERT INTO telefones (ddd, telefone) VALUES
('11', '1111-1111'),
('22', '2222-2222'),
('33', '3333-3333'),
('44', '4444-4444'),
('55', '5555-5555'),
('66', '6666-6666'),
('77', '7777-7777'),
('88', '8888-8888'),
('99', '9999-9999'),
('21', '2121-2121');

INSERT INTO endereço (numero_endereco, cep, rua, bairro, cidade, estado) VALUES
('100', '01000-000', 'Rua Alameda do Santos', 'Jardim Im', 'São Paulo', 'SP'),
('200', '02000-000', 'Rua dos Bobos', 'Centro', 'Rio de Janeiro', 'RJ'),
('300', '03000-000', 'Rua das Flores', 'Bela Vista', 'Curitiba', 'PR'),
('400', '04000-000', 'Avenida Brasil', 'Centro', 'Belo Horizonte', 'MG'),
('500', '05000-000', 'Rua das Palmeiras', 'Zona Sul', 'Porto Alegre', 'RS'),
('600', '06000-000', 'Rua do Sol', 'Centro', 'Recife', 'PE'),
('700', '07000-000', 'Rua do Carmo', 'Centro', 'Salvador', 'BA'),
('800', '08000-000', 'Rua das Acácias', 'Zona Norte', 'Fortaleza', 'CE'),
('900', '09000-000', 'Rua Inácio', 'Jardim Primavera', 'Brasília', 'DF'),
('1000', '10000-000', 'Rua Jorge Amado', 'Centro', 'Manaus', 'AM');

INSERT INTO endereço (numero_endereco, cep, rua, bairro, cidade, estado) VALUES
('123', '01001-000', 'Rua das Laranjeiras', 'Vila Madalena', 'São Paulo', 'SP'),
('456', '02002-000', 'Rua do Comércio', 'Centro', 'Rio de Janeiro', 'RJ'),
('789', '03003-000', 'Rua dos Bandeirantes', 'Jardim Botânico', 'Curitiba', 'PR'),
('101', '04004-000', 'Rua Tiradentes', 'Lourdes', 'Belo Horizonte', 'MG'),
('112', '05005-000', 'Rua das Palmeiras', 'Moinhos de Vento', 'Porto Alegre', 'RS'),
('131', '06006-000', 'Rua dos Navegantes', 'Boa Viagem', 'Recife', 'PE'),
('415', '07007-000', 'Rua do Pelourinho', 'Pelourinho', 'Salvador', 'BA'),
('161', '08008-000', 'Rua Beira Mar', 'Meireles', 'Fortaleza', 'CE'),
('718', '09009-000', 'Rua das Embaixadas', 'Asa Sul', 'Brasília', 'DF'),
('192', '10010-000', 'Rua Eduardo Ribeiro', 'Centro', 'Manaus', 'AM'),
('212', '11011-000', 'Rua Sete de Setembro', 'Jardim Paulista', 'São Paulo', 'SP'),
('223', '12012-000', 'Avenida Rio Branco', 'Centro', 'Rio de Janeiro', 'RJ'),
('242', '13013-000', 'Rua Quinze de Novembro', 'Centro Cívico', 'Curitiba', 'PR'),
('252', '14014-000', 'Avenida Afonso Pena', 'Centro', 'Belo Horizonte', 'MG'),
('262', '15015-000', 'Rua dos Andradas', 'Centro Histórico', 'Porto Alegre', 'RS');


INSERT INTO endereço (numero_endereco, cep, rua, bairro, cidade, estado) VALUES
('100', '01000-000', 'Rua Alameda do Santos', 'Jardim Im', 'Cidade A', 'Estado A'),
('200', '02000-000', 'Avenida Brasil', 'Centro', 'Cidade B', 'Estado B'),
('300', '03000-000', 'Praça da Liberdade', 'Liberdade', 'Cidade C', 'Estado C'),
('400', '04000-000', 'Rua dos Andradas', 'Andradas', 'Cidade D', 'Estado D'),
('500', '05000-000', 'Avenida Paulista', 'Paulista', 'Cidade E', 'Estado E'),
('600', '06000-000', 'Rua das Palmeiras', 'Palmeiras', 'Cidade F', 'Estado F'),
('700', '07000-000', 'Avenida Atlântica', 'Atlântica', 'Cidade G', 'Estado G'),
('800', '08000-000', 'Rua do Sol', 'Sol', 'Cidade H', 'Estado H'),
('900', '09000-000', 'Praça do Carmo', 'Carmo', 'Cidade I', 'Estado I'),
('1000', '10000-000', 'Rua do Comércio', 'Comércio', 'Cidade J', 'Estado J');

INSERT INTO dados_pessoais (id_nome, data_de_nascimento, id_telefone, id_endereco, email) VALUES
(1, '1980-01-01', 1, 1, 'joao.silva@example.com'),
(2, '1985-02-02', 2, 2, 'rororo@example.com'),
(3, '1990-03-03', 3, 3, 'perikito@example.com'),
(4, '1975-04-04', 4, 4, 'ana.lima@example.com'),
(5, '1982-05-05', 5, 5, 'carlos.almeida@example.com'),
(6, '1987-06-06', 6, 6, 'beatriz.santos@example.com'),
(7, '1992-07-07', 7, 7, 'fernando.costa@example.com'),
(8, '1970-08-08', 8, 8, 'luiza.pereira@example.com'),
(9, '1983-09-09', 9, 9, 'ingrid@example.com'),
(10, '1988-10-10', 10, 10, 'machine@example.com');

INSERT INTO dados_pessoais (id_nome, data_de_nascimento, id_telefone, id_endereco, email) VALUES
(11, '1980-01-01', 11, 11, 'livia.silva@example.com'),
(12, '1982-03-15', 12, 12, 'helena.santos@example.com'),
(13, '1985-07-20', 13, 13, 'maite.costa@example.com'),
(14, '1988-09-10', 14, 14, 'mariana.rodrigues@example.com'),
(15, '1991-05-05', 15, 15, 'alice.souza@example.com'),
(16, '1994-12-18', 16, 16, 'aurora.ferreira@example.com'),
(17, '1997-06-30', 17, 17, 'maya.lima@example.com'),
(18, '2000-02-22', 18, 18, 'isis.pereira@example.com'),
(19, '2003-11-12', 19, 19, 'charlie.silva@example.com'),
(20, '2006-08-25', 20, 20, 'eva.santos@example.com'),
(21, '2009-04-17', 21, 21, 'leticia.almeida@example.com'),
(22, '2012-01-08', 22, 22, 'katchau.gret@example.com'),
(23, '2015-10-01', 23, 23, 'hector.bonilia@example.com'),
(24, '2018-04-23', 24, 24, 'gabriel.lindo@example.com'),
(25, '2021-12-15', 25, 25, 'bosak.talaric@example.com');

INSERT INTO dados_pessoais (id_dados_pessoais, id_nome, data_de_nascimento, id_telefone, id_endereco, email) VALUES
(26, 26, '1980-01-01', 26, 26, 'joao@example.com'),
(27, 27, '1981-02-02', 27, 27, 'maria.oliveira@example.com'),
(28, 28, '1982-03-03', 28, 28, 'carlos.souza@example.com'),
(29, 29, '1983-04-04', 29, 29, 'ana.beatriz@example.com'),
(30, 30, '1984-05-05', 30, 30, 'pedro.santos@example.com'),
(31, 31, '1985-06-06', 31, 31, 'juliana.lima@example.com'),
(32, 32, '1986-07-07', 32, 32, 'marcos.pereira@example.com'),
(33, 33, '1987-08-08', 33, 33, 'fernanda.costa@example.com'),
(34, 34, '1988-09-09', 34, 34, 'rafael.almeida@example.com'),
(35, 35, '1989-10-10', 35, 35, 'camila.mendes@example.com');


INSERT INTO documentos (rg, cpf) VALUES
('123456789', '123.456.789-00'),
('223456789', '223.456.789-00'),
('323456789', '323.456.789-00'),
('423456789', '423.456.789-00'),
('523456789', '523.456.789-00'),
('623456789', '623.456.789-00'),
('723456789', '723.456.789-00'),
('823456789', '823.456.789-00'),
('923456789', '923.456.789-00'),
('023456789', '023.456.789-00')
;
INSERT INTO documentos (rg, cpf) VALUES 
('12345678-13', '123.456.789-13'), 
('12345678-14', '123.456.789-14'), 
('12345678-15', '123.456.789-15'), 
('12345678-16', '123.456.789-16'), 
('12345678-17', '123.456.789-17'), 
('12345678-18', '123.456.789-18'), 
('12345678-19', '123.456.789-19'), 
('12345678-20', '123.456.789-20'), 
('12345678-21', '123.456.789-21'), 
('12345678-22', '123.456.789-22'), 
('12345678-23', '123.456.789-23'), 
('12345678-24', '123.456.789-24'), 
('12345678-25', '123.456.789-25'), 
('12345678-26', '123.456.789-26'), 
('12345678-27', '123.456.789-27');

INSERT INTO especialidade (nome_da_especialidade) VALUES
('Pediatria'),
('Clínica Geral'),
('Gastroenterologia'),
('Dermatologia'),
('Cardiologia'),
('Neurologia'),
('Ortopedia');

INSERT INTO crm (id_especialidade, id_nome) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(1, 9),
(2, 10);

INSERT INTO medicos (cargo, id_dados_pessoais, id_documentos, id_crm) VALUES
('generalista', 1, 1, 1),
('especialista', 2, 2, 2),
('especialista', 3, 3, 3),
('especialista', 4, 4, 4),
('especialista', 5, 5, 5),
('especialista', 6, 6, 6),
('especialista', 7, 7, 7),
('generalista', 8, 8, 8),
('especialista', 9, 9, 9),
('residente', 10, 10, 10);


INSERT INTO convenio (nome_convenio, cnpj, tempo_de_carencia) VALUES
('Amil', '01.234.567/0001-89', '00:03:00'),
('Unimed', '02.345.678/0001-67', '00:03:00'),
('Bradesco Saúde', '03.456.789/0001-45', '00:03:00'),
('SulAmérica', '04.567.890/0001-23', '00:03:00');

INSERT INTO pacientes (id_dados_pessoais, id_documentos, id_convenio) VALUES
(11, 11, 1),
(12, 12, 1),
(13, 13, 2),
(14, 14, 2),
(15, 15, 3),
(16, 16, 3),
(17,17, 4),
(18, 18, 4),
(19, 19, NULL),
(20, 20, NULL),
(21, 21, NULL),
(22, 22, NULL),
(23, 23, NULL),
(24, 24, NULL),
(25, 25, NULL);

INSERT INTO medicamentos (quantidade, instrucoes) VALUES
(10, 'Tomar 1 comprimido a cada 8 horas'),
(20, 'Tomar 2 comprimidos ao dia'),
(15, 'Aplicar pomada 3 vezes ao dia'),
(30, 'Tomar 1 comprimido ao dia'),
(25, 'Ingerir 2 cápsulas após refeições'),
(10, 'Usar spray nasal 2 vezes ao dia'),
(20, 'Aplicar 10 gotas sublingual 3 vezes ao dia'),
(15, 'Tomar 1 comprimido a cada 12 horas'),
(30, 'Usar 1 supositório ao dia'),
(25, 'Tomar 2 comprimidos antes de dormir');

INSERT INTO receita (id_medicamentos) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10);



INSERT INTO consulta (data_hora_consulta, id_medico, id_paciente, valor_consulta, id_convenio, numero_da_carteira, id_receita) VALUES
('2015-01-01 10:00:00', 1, 1, 100.00, 1, '0001', 1),
('2015-02-01 10:00:00', 2, 2, 100.00, 1, '0002', 2),
('2015-03-01 10:00:00', 3, 3, 100.00, 2, '0003', 3),
('2015-04-01 10:00:00', 4, 4, 100.00, 2, '0004', 4),
('2015-05-01 10:00:00', 5, 5, 100.00, 3, '0005', 5),
('2015-06-01 10:00:00', 6, 6, 100.00, 3, '0006', 6),
('2015-07-01 10:00:00', 7, 7, 100.00, 4, '0007', 7),
('2015-08-01 10:00:00', 8, 8, 100.00, 4, '0008', 8),
('2015-09-01 10:00:00', 9, 9, 100.00, NULL, '0009', NULL),
('2015-10-01 10:00:00', 10, 10, 100.00, NULL, '0010', NULL),
('2016-01-01 10:00:00', 1, 11, 100.00, NULL, '0011', NULL),
('2016-02-01 10:00:00', 2, 12, 100.00, NULL, '0012', NULL),
('2016-03-01 10:00:00', 3, 13, 100.00, NULL, '0013', NULL),
('2016-04-01 10:00:00', 4, 14, 100.00, NULL, '0014', NULL),
('2016-05-01 10:00:00', 5, 15, 100.00, NULL, '0015', NULL),
('2016-06-01 10:00:00', 6, 1, 100.00, NULL, '0016', NULL),
('2016-07-01 10:00:00', 7, 2, 100.00, NULL, '0017', NULL),
('2016-08-01 10:00:00', 8, 3, 100.00, NULL, '0018', NULL),
('2016-09-01 10:00:00', 9, 4, 100.00, NULL, '0019', NULL),
('2016-10-01 10:00:00', 10, 5, 100.00, NULL, '0020', NULL);

INSERT INTO tipo_de_quarto (descricao, valor_diaria) VALUES
('Apartamento', 300.00),
('Quarto Duplo', 200.00),
('Enfermaria', 100.00);

INSERT INTO quarto (numeracao, id_tipo_de_quarto) VALUES
('101', 1),
('102', 2),
('103', 3);

INSERT INTO enfermeiro (id_dados_pessoais, cpf_enfermeiro, cre) VALUES
(26, '11111111111', 'CRE-101'),
(27, '22222222222', 'CRE-102'),
(28, '33333333333', 'CRE-103'),
(29, '44444444444', 'CRE-104'),
(30, '55555555555', 'CRE-105'),
(31, '66666666666', 'CRE-106'),
(32, '77777777777', 'CRE-107'),
(33, '88888888888', 'CRE-108'),
(34, '99999999999', 'CRE-109'),
(35, '00000000000', 'CRE-110');

INSERT INTO internacoes (data_entrada, data_prevista_alta, data_efetiva_alta, descricao_procedimentos, id_quarto, id_enfermeiro, id_paciente, id_medico) VALUES
('2015-01-01', '2015-01-10', '2015-01-09', 'Cirurgia A', 1, 1, 1, 1),
('2015-02-01', '2015-02-10', '2015-02-09', 'Cirurgia B', 2, 2, 2, 2),
('2015-03-01', '2015-03-10', '2015-03-09', 'Cirurgia C', 3, 3, 3, 3),
('2015-04-01', '2015-04-10', '2015-04-09', 'Cirurgia D', 1, 4, 4, 4),
('2015-05-01', '2015-05-10', '2015-05-09', 'Cirurgia E', 2, 5, 5, 5),
('2015-06-01', '2015-06-10', '2015-06-09', 'Cirurgia F', 3, 6, 6, 6),
('2015-07-01', '2015-07-10', '2015-07-09', 'Cirurgia G', 1, 7, 7, 7);
