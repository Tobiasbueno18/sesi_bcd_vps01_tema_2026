# 🏭 Tema 04 — Manutenção de Equipamentos

## 📌 Descrição do Projeto

Este projeto consiste no desenvolvimento de um banco de dados para o gerenciamento da manutenção de equipamentos de uma fábrica.

O sistema tem como objetivo controlar os equipamentos, registrar ordens de manutenção, identificar os técnicos responsáveis pelos serviços, armazenar o histórico das manutenções e controlar as peças utilizadas.

O banco de dados foi desenvolvido utilizando conceitos de modelagem de dados, normalização, relacionamentos entre tabelas e comandos SQL.

---

## 🎯 Objetivos

- Cadastrar e consultar equipamentos da fábrica.
- Registrar ordens de manutenção preventiva e corretiva.
- Controlar o status e a prioridade das ordens de manutenção.
- Cadastrar os técnicos responsáveis pelos serviços.
- Armazenar o histórico de manutenções realizadas.
- Controlar as peças utilizadas em cada manutenção.
- Gerenciar o estoque e os preços das peças.
- Organizar os dados de forma estruturada e normalizada.

---

## 🛠️ Tecnologias e Ferramentas

| Tecnologia | Utilização |
|---|---|
| MySQL | Criação e gerenciamento do banco de dados |
| SQL | Criação das tabelas e inserção de dados |
| Draw.io | Desenvolvimento dos diagramas MER e DER |
| CSV | Armazenamento dos dados de teste |
| Markdown | Documentação do projeto no GitHub |

---

# 🗂️ Estrutura do Projeto

```text
Tema04_Manutencao_Equipamentos/
│
├── README.md
├── Dicionario_de_Dados.md
│
├── diagramas/
│   ├── MER_Conceitual.png
│   └── DER_Logico.png
│
├── csv/
│   ├── equipamento.csv
│   ├── ordem_manutencao.csv
│   ├── tecnico.csv
│   ├── peca.csv
│   ├── manutencao.csv
│   └── peca_manutencao.csv
│
└── sql/
    ├── ddl.sql
    └── dml.sql
```

---

# 📊 Modelo Entidade-Relacionamento (MER)

O modelo conceitual representa as entidades principais do sistema e seus relacionamentos.

As entidades identificadas são:

- Equipamento
- Ordem de Manutenção
- Técnico
- Manutenção
- Peça
- Peça da Manutenção

## 🖼️ Diagrama MER Conceitual

![(MER)](https://github.com/Tobiasbueno18/sesi_bcd_vps01_tema_2026/blob/main/diagramas/mer.png?raw=true)

---

# 🗄️ Modelo Entidade-Relacionamento Lógico (DER)

O modelo lógico representa a estrutura do banco de dados, incluindo as tabelas, os atributos, as chaves primárias (PK) e as chaves estrangeiras (FK).

## 🖼️ Diagrama DER Lógico

![(DER)](https://github.com/Tobiasbueno18/sesi_bcd_vps01_tema_2026/blob/main/diagramas/der.png?raw=true)

---

# 🔗 Relacionamentos do Banco de Dados

| Relacionamento | Cardinalidade | Descrição |
|---|---|---|
| Equipamento → Ordem de Manutenção | 1:N | Um equipamento pode possuir várias ordens de manutenção. |
| Ordem de Manutenção → Manutenção | 1:N | Uma ordem pode possuir vários registros de manutenção. |
| Técnico → Manutenção | 1:N | Um técnico pode executar várias manutenções. |
| Manutenção → Peça | N:N | Uma manutenção pode utilizar várias peças, e uma peça pode ser utilizada em várias manutenções. |

O relacionamento N:N entre Manutenção e Peça é resolvido por meio da tabela associativa `peca_manutencao`.

---

# 📐 Normalização do Banco de Dados

O banco de dados foi organizado seguindo os princípios de normalização até a Terceira Forma Normal (3FN).

### 1ª Forma Normal (1FN)

Todos os atributos possuem valores atômicos, ou seja, cada campo armazena apenas um valor.

Não existem listas de peças, equipamentos ou técnicos dentro de uma mesma coluna.

### 2ª Forma Normal (2FN)

Todos os atributos não-chave dependem integralmente da chave primária.

Na tabela `peca_manutencao`, o atributo `quantidade` depende da chave primária composta, formada por `id_manutencao` e `id_peca`.

### 3ª Forma Normal (3FN)

Os atributos não-chave dependem diretamente da chave primária, sem dependências transitivas.

Os dados de equipamentos, técnicos e peças ficam armazenados em suas próprias tabelas, evitando repetições desnecessárias.

---

# 📖 Dicionário de Dados

O dicionário de dados descreve os campos, tipos, chaves e finalidades de cada tabela do banco de dados.

O documento completo está disponível em:

📄 [`Dicionario_de_Dados.md`](Dicionario_de_Dados.md)

## 1. Tabela: equipamento

Armazena os dados dos equipamentos da fábrica.

| Campo | Tipo | Descrição |
|---|---|---|
| id | INT | Identificador do equipamento (PK) |
| nome | VARCHAR(100) | Nome do equipamento |
| tipo | VARCHAR(60) | Tipo do equipamento |
| marca | VARCHAR(60) | Fabricante |
| modelo | VARCHAR(60) | Modelo |
| numero_serie | VARCHAR(80) | Número de série único |
| data_aquisicao | DATE | Data de aquisição |
| status | VARCHAR(30) | Situação atual |
| setor | VARCHAR(80) | Setor onde está localizado |
| valor_aquisicao | DECIMAL(12,2) | Valor de aquisição |

## 2. Tabela: ordem_manutencao

Registra as ordens de manutenção dos equipamentos.

| Campo | Tipo | Descrição |
|---|---|---|
| id_ordem | INT | Identificador da ordem (PK) |
| id_equipamento | INT | Equipamento relacionado (FK) |
| tipo | VARCHAR(20) | Tipo de manutenção |
| descricao | VARCHAR(255) | Descrição da manutenção |
| data_abertura | DATE | Data de abertura |
| data_inicio | DATE | Data de início |
| data_fim | DATE | Data de conclusão |
| status | VARCHAR(30) | Situação da ordem |
| prioridade | VARCHAR(20) | Prioridade da ordem |

## 3. Tabela: tecnico

Armazena os dados dos técnicos responsáveis pelas manutenções.

| Campo | Tipo | Descrição |
|---|---|---|
| id | INT | Identificador do técnico (PK) |
| nome | VARCHAR(120) | Nome do técnico |
| especialidade | VARCHAR(80) | Especialidade profissional |
| telefone | VARCHAR(25) | Telefone de contato |
| email | VARCHAR(120) | E-mail do técnico |

## 4. Tabela: peca

Armazena os dados das peças utilizadas nas manutenções.

| Campo | Tipo | Descrição |
|---|---|---|
| id_peca | INT | Identificador da peça (PK) |
| nome | VARCHAR(100) | Nome da peça |
| descricao | VARCHAR(255) | Descrição da peça |
| quantidade_estoque | INT | Quantidade disponível |
| estoque_minimo | INT | Quantidade mínima de estoque |
| preco | DECIMAL(10,2) | Preço unitário |

## 5. Tabela: manutencao

Armazena os registros dos serviços executados.

| Campo | Tipo | Descrição |
|---|---|---|
| id_manutencao | INT | Identificador da manutenção (PK) |
| id_ordem | INT | Ordem relacionada (FK) |
| id_tecnico | INT | Técnico responsável (FK) |
| descricao_servico | VARCHAR(255) | Descrição do serviço |
| data_execucao | DATE | Data da execução |
| horas_trabalhadas | DECIMAL(6,2) | Horas trabalhadas |
| observacoes | TEXT | Observações do serviço |

## 6. Tabela: peca_manutencao

Relaciona as peças utilizadas em cada manutenção.

| Campo | Tipo | Descrição |
|---|---|---|
| id_manutencao | INT | Manutenção relacionada (PK/FK) |
| id_peca | INT | Peça utilizada (PK/FK) |
| quantidade | INT | Quantidade utilizada |

A tabela utiliza uma chave primária composta por `id_manutencao` e `id_peca`.

---

# 📄 Dados de Teste (CSV)

Os arquivos CSV armazenam os dados de teste utilizados no projeto.

Cada arquivo possui cabeçalho e pelo menos três registros.

| Arquivo | Descrição |
|---|---|
| equipamento.csv | Dados dos equipamentos |
| ordem_manutencao.csv | Ordens de manutenção |
| tecnico.csv | Dados dos técnicos |
| peca.csv | Cadastro e estoque de peças |
| manutencao.csv | Histórico de manutenções |
| peca_manutencao.csv | Peças utilizadas em cada manutenção |

Os dados dos arquivos CSV correspondem aos registros inseridos pelo script `dml.sql`.

---

# 💻 Scripts SQL

O projeto possui dois scripts principais para a criação e população do banco de dados.

## DDL — Data Definition Language

Arquivo: `sql/ddl.sql`

Responsável pela criação do banco de dados e das tabelas.

O script define:

- Banco de dados `manutencao_equipamentos`.
- Estrutura das seis tabelas.
- Chaves primárias (PK).
- Chaves estrangeiras (FK).
- Restrições de integridade dos dados.

## DML — Data Manipulation Language

Arquivo: `sql/dml.sql`

Responsável pela inserção dos dados de teste nas tabelas.

O script contém registros de equipamentos, ordens de manutenção, técnicos, peças, manutenções e peças utilizadas.

---

# ▶️ Como Executar o Projeto

### 1. Abrir o MySQL Workbench

Abra o MySQL Workbench ou outro programa compatível com MySQL/MariaDB.

### 2. Executar o DDL

Abra o arquivo `sql/ddl.sql` e execute o script para criar o banco de dados e suas tabelas.

### 3. Executar o DML

Após a criação das tabelas, abra o arquivo `sql/dml.sql` e execute o script para inserir os dados de teste.

### 4. Consultar os dados

Utilize os comandos abaixo para consultar os registros:

```sql
USE manutencao_equipamentos;

SELECT * FROM equipamento;

SELECT * FROM ordem_manutencao;

SELECT * FROM tecnico;

SELECT * FROM peca;

SELECT * FROM manutencao;

SELECT * FROM peca_manutencao;
```

**Importante:** o arquivo `ddl.sql` deve ser executado antes do arquivo `dml.sql`.

---

# 📦 Entregáveis

| Entregável | Status |
|---|---|
| MER Conceitual em PNG | Concluído |
| DER Lógico em PNG | Concluído |
| Normalização do banco de dados | Concluído |
| Dicionário de Dados em Markdown | Concluído |
| Arquivos CSV com dados de teste | Concluído |
| Script DDL de criação do banco | Concluído |
| Script DML de população do banco | Concluído |
| README com documentação | Concluído |

---

