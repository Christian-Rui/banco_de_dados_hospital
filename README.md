# Banco de dados - Hospital

## Parte 1
- Criando o DER do banco

Um pequeno hospital local busca desenvolver um novo sistema que atenda melhor às suas necessidades. Atualmente, parte da operação ainda se apoia em planilhas e arquivos antigos, mas espera-se que esses dados sejam transferidos para o novo sistema assim que ele estiver funcional. Neste momento, é necessário analisar com cuidado as necessidades desse cliente e sugerir uma estrutura de banco de dados adequada por meio de um Diagrama Entidade-Relacionamento.

**Mãos a Obra**
Analise a seguinte descrição e extraia dela os requisitos para o banco de dados:
O hospital necessita de um sistema para sua área clínica que ajude a controlar consultas realizadas. Os médicos podem ser generalistas, especialistas ou residentes e têm seus dados pessoais cadastrados em planilhas digitais. Cada médico pode ter uma ou mais especialidades, que podem ser pediatria, clínica geral, gastroenterologia e dermatologia. Alguns registros antigos ainda estão em formulário de papel, mas será necessário incluir esses dados no novo sistema.

Os pacientes também precisam de cadastro, contendo dados pessoais (nome, data de nascimento, endereço, telefone e e-mail), documentos (CPF e RG) e convênio. Para cada convênio, são registrados nome, CNPJ e tempo de carência.

As consultas também têm sido registradas em planilhas, com data e hora de realização, médico responsável, paciente, valor da consulta ou nome do convênio, com o número da carteira. Também é necessário indicar na consulta qual a especialidade buscada pelo paciente.

Deseja-se ainda informatizar a receita do médico, de maneira que, no encerramento da consulta, ele possa registrar os medicamentos receitados, a quantidade e as instruções de uso. A partir disso, espera-se que o sistema imprima um relatório da receita ao paciente ou permita sua visualização via internet.

![DERHospitalPart1 drawio](https://github.com/Christian-Rui/banco_de_dados_hospital/assets/113655013/40513e15-d044-45c7-955b-0ffe4fe4ed94)

## Parte 2
- Adicionando mais entidades
  
Após a primeira versão do projeto de banco de dados para o sistema hospitalar, notou-se a necessidade de expansão das funcionalidades, incluindo alguns requisitos essenciais a essa versão do software. As funcionalidades em questão são para o controle na internação de pacientes. Será necessário expandir o Modelo ER desenvolvido e montar o banco de dados, criando as tabelas para o início dos testes.

Entender do assunto
Considere a seguinte descrição e o diagrama ER abaixo:

No hospital, as internações têm sido registradas por meio de formulários eletrônicos que gravam os dados em arquivos. 

Para cada internação, são anotadas a data de entrada, a data prevista de alta e a data efetiva de alta, além da descrição textual dos procedimentos a serem realizados. 

As internações precisam ser vinculadas a quartos, com a numeração e o tipo. 

Cada tipo de quarto tem sua descrição e o seu valor diário (a princípio, o hospital trabalha com apartamentos, quartos duplos e enfermaria).

Também é necessário controlar quais profissionais de enfermaria estarão responsáveis por acompanhar o paciente durante sua internação. Para cada enfermeiro(a), é necessário nome, CPF e registro no conselho de enfermagem (CRE).

A internação, obviamente, é vinculada a um paciente – que pode se internar mais de uma vez no hospital – e a um único médico responsável.
  
![DERHospitalParte2 drawio](https://github.com/Christian-Rui/banco_de_dados_hospital/assets/113655013/80a65af8-467b-4046-a30d-107c8c000dd3)

---

- Criando o arquivo SQL no dbdesigner

**Mãos a obra?**
Faça a ligação do diagrama acima ao diagrama desenvolvido na atividade antrior, construindo relacionamentos com entidades relacionadas. E eleve o seu diagrama para que já selecionando os tipos de dados que serão trabalhados e em quais situações. 

Por último, crie um script SQL para a geração do banco de dados e para instruções de montagem de cada uma das entidades/tabelas presentes no diagrama completo (considerando as entidades do diagrama da atividade anterior e as novas entidades propostas no diagrama acima). Também crie tabelas para relacionamentos quando necessário. Aplique colunas e chaves primárias e estrangeiras.


| ![hospital (1)](https://github.com/Christian-Rui/banco_de_dados_hospital/assets/113655013/59ae03f2-4e12-41ca-8f4e-97c1e0603d72) | ![hospital-clone-1](https://github.com/Christian-Rui/banco_de_dados_hospital/assets/113655013/23123cb4-b23e-45eb-aee0-522a2f22349c) |
|:---:|:---:|
| Relação das entidades pacientes, enfermeiros e medicos com os dados | Relação das entidades com as consultas, internações e suas relações |

## PARTE 3 - Alimentando o banco de dados
- Desenvolvendo o script para alimentar o banco

Com o banco de dados para o sistema hospitalar completamente montado, é necessário incluir dados para realizar os devidos testes e validar sua viabilidade quanto ao sistema. Nesta etapa, também é importante realizar a separação de alguns scripts iniciais para o banco, com os dados que serão necessários a um povoamento inicial do sistema.

**Jogando nas regras que você criou:**
Crie scripts de povoamento das tabelas desenvolvidas na atividade anterior
Observe as seguintes atividades: 
Inclua ao menos dez médicos de diferentes especialidades.

Ao menos sete especialidades (considere a afirmação de que “entre as especialidades há pediatria, clínica geral, gastrenterologia e dermatologia”).

Inclua ao menos 15 pacientes.

Registre 20 consultas de diferentes pacientes e diferentes médicos (alguns pacientes realizam mais que uma consulta). As consultas devem ter ocorrido entre 01/01/2015 e 01/01/2022. Ao menos dez consultas devem ter receituário com dois ou mais medicamentos.

Inclua ao menos quatro convênios médicos, associe ao menos cinco pacientes e cinco consultas.

Criar entidade de relacionamento entre médico e especialidade. 

Criar Entidade de Relacionamento entre internação e enfermeiro. 

Arrumar a chave estrangeira do relacionamento entre convênio e médico.

Criar entidade entre internação e enfermeiro.

Colocar chaves estrangeira dentro da internação (Chaves Médico e Paciente).

Registre ao menos sete internações. Pelo menos dois pacientes devem ter se internado mais de uma vez. Ao menos três quartos devem ser cadastrados. As internações devem ter ocorrido entre 01/01/2015 e 01/01/2022.

Considerando que “a princípio o hospital trabalha com apartamentos, quartos duplos e enfermaria”, inclua ao menos esses três tipos com valores diferentes.

Inclua dados de dez profissionais de enfermaria. Associe cada internação a ao menos dois enfermeiros.

Os dados de tipo de quarto, convênio e especialidade são essenciais para a operação do sistema e, portanto, devem ser povoados assim que o sistema for instalado.

### Exemplos de alimentação do banco
```MySQL
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
```

------

```MySQL
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
```

### Modificações e alterações feitas

```MySQL
CREATE TABLE `medico_especialidade` (
    `id_medico` int,
	`id_especialidade` int,
    PRIMARY KEY (`id_medico`,`id_especialidade` ),
    FOREIGN KEY (`id_medico`) REFERENCES `medicos`(`id_medico`),
    FOREIGN KEY (`id_especialidade`) REFERENCES `especialidade`(`id_especialidade`)
);

CREATE TABLE `internacao_enfermeiro` (
    `id_internacao` int,
    `id_enfermeiro` int,
    PRIMARY KEY (`id_internacao`, `id_enfermeiro`),
    FOREIGN KEY (`id_internacao`) REFERENCES `internacoes`(`id_internacoes`),
    FOREIGN KEY (`id_enfermeiro`) REFERENCES `enfermeiro`(`id_enfermeiro`)
);
```

---

```MySQL
ALTER TABLE `medicos` ADD CONSTRAINT `medicos_fk_convenio` FOREIGN KEY (`id_convenio`) REFERENCES `convenio`(`id_convenio`);
```

## PARTE 4 - Alterando o banco de dados
- Utilizando update para alterar dados

Um banco de dados pode sofrer alterações ao longo da sua concepção e do seu desenvolvimento. Nesse momento devemos nos preparar para atualizar nossas estratégias. 

**Mãos a Obra.**
Pensando no banco que já foi criado para o Projeto do Hospital, realize algumas alterações nas tabelas e nos dados usando comandos de atualização e exclusão:

Crie um script que adicione uma coluna “em_atividade” para os médicos, indicando se ele ainda está atuando no hospital ou não. 

Crie um script para atualizar ao menos dois médicos como inativos e os demais em atividade.

### scripts feitos

- Instrução SQL para criar uma coluna chamada "em_atividade" que recebe valores booleanos (true/verdadeiro ou false/false)
```MySQL
ALTER TABLE medicos ADD COLUMN em_atividade BOOLEAN DEFAULT TRUE;
```

---

-Instrução SQL para desativas e reativar a segurança que permite atualizar os dados
```MySQL
SET SQL_SAFE_UPDATES = 0;

/*outras instruções SQL*/

SET SQL_SAFE_UPDATES = 1;
```

---

- utilizando script com UPDATE para setar novos valores na coluna em_atividade
```MySQL
UPDATE medicos SET em_atividade = FALSE WHERE id_medico IN (1, 8);
UPDATE medicos SET em_atividade = TRUE WHERE id_medico NOT IN (1, 8);
```

