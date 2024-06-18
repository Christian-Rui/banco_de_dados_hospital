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

CREATE TABLE IF NOT EXISTS `nome` (
	`id_nome` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nome` varchar(255) NOT NULL,
	`nome_social` varchar(255),
	PRIMARY KEY (`id_nome`)
);

CREATE TABLE IF NOT EXISTS `telefone` (
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
	`cpf_enfermeiro` int NOT NULL,
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
	`id_medico` int NOT NULL UNIQUE,
	`id_paciente` int NOT NULL UNIQUE,
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

ALTER TABLE `dados_pessoais` ADD CONSTRAINT `dados_pessoais_fk3` FOREIGN KEY (`id_telefone`) REFERENCES `telefone`(`id_telefone`);

ALTER TABLE `dados_pessoais` ADD CONSTRAINT `dados_pessoais_fk4` FOREIGN KEY (`id_endereco`) REFERENCES `endereço`(`numero_endereco`);
ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk2` FOREIGN KEY (`id_dados_usuarios`) REFERENCES `dados_pessoais`(`id_dados_pessoais`);

ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk3` FOREIGN KEY (`id_documentos`) REFERENCES `documentos`(`id_documentos`);

ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk4` FOREIGN KEY (`id_crm`) REFERENCES `crm`(`id_crm`);
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
