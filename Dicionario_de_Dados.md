# Dicionário de Dados — Tema 04: Manutenção de Equipamentos

Banco de dados para controlar equipamentos industriais, ordens de manutenção, técnicos, peças e os serviços executados.

## 1. Modelo e normalização

O modelo está organizado até a **Terceira Forma Normal (3FN)**:
- **1FN:** cada campo contém um único valor; não há listas de peças ou técnicos dentro de uma coluna.
- **2FN:** atributos não-chave dependem da chave inteira. Na tabela `peca_manutencao`, `quantidade` depende da chave composta (`id_manutencao`, `id_peca`).
- **3FN:** dados de equipamentos, técnicos e peças ficam em suas próprias tabelas; não são repetidos nas ordens ou manutenções. As tabelas associativas representam relações N:N.

## 2. Relacionamentos

- `equipamento` 1:N `ordem_manutencao`
- `ordem_manutencao` 1:N `manutencao`
- `tecnico` 1:N `manutencao`
- `manutencao` N:N `peca`, resolvido por `peca_manutencao`

## 3. Dicionário por tabela

### equipamento
| Campo | Tipo | Chave/Regra | Descrição |
|---|---|---|---|
| id | INT | PK, auto incremento | Identificador do equipamento |
| nome | VARCHAR(100) | NOT NULL | Nome do equipamento |
| tipo | VARCHAR(60) | NOT NULL | Categoria/tipo |
| marca | VARCHAR(60) | Opcional | Fabricante |
| modelo | VARCHAR(60) | Opcional | Modelo |
| numero_serie | VARCHAR(80) | UNIQUE, NOT NULL | Número de série único |
| data_aquisicao | DATE | NOT NULL | Data de aquisição |
| status | VARCHAR(30) | NOT NULL | Situação atual |
| setor | VARCHAR(80) | NOT NULL | Setor onde está instalado |
| valor_aquisicao | DECIMAL(12,2) | >= 0 | Valor pago na aquisição |

### ordem_manutencao
| Campo | Tipo | Chave/Regra | Descrição |
|---|---|---|---|
| id_ordem | INT | PK, auto incremento | Identificador da ordem |
| id_equipamento | INT | FK → equipamento.id | Equipamento relacionado |
| tipo | VARCHAR(20) | Preventiva ou Corretiva | Tipo de manutenção |
| descricao | VARCHAR(255) | NOT NULL | Problema ou atividade solicitada |
| data_abertura | DATE | NOT NULL | Data de abertura |
| data_inicio | DATE | Opcional | Início do atendimento |
| data_fim | DATE | Opcional | Conclusão do atendimento |
| status | VARCHAR(30) | NOT NULL | Situação da ordem |
| prioridade | VARCHAR(20) | NOT NULL | Prioridade da ordem |

### tecnico
| Campo | Tipo | Chave/Regra | Descrição |
|---|---|---|---|
| id | INT | PK, auto incremento | Identificador do técnico |
| nome | VARCHAR(120) | NOT NULL | Nome completo |
| especialidade | VARCHAR(80) | NOT NULL | Área de atuação |
| telefone | VARCHAR(25) | Opcional | Telefone de contato |
| email | VARCHAR(120) | UNIQUE, NOT NULL | E-mail único do técnico |

### peca
| Campo | Tipo | Chave/Regra | Descrição |
|---|---|---|---|
| id_peca | INT | PK, auto incremento | Identificador da peça |
| nome | VARCHAR(100) | NOT NULL | Nome da peça |
| descricao | VARCHAR(255) | Opcional | Detalhes da peça |
| quantidade_estoque | INT | >= 0 | Quantidade disponível |
| estoque_minimo | INT | >= 0 | Limite mínimo de estoque |
| preco | DECIMAL(10,2) | >= 0 | Preço unitário |

### manutencao
| Campo | Tipo | Chave/Regra | Descrição |
|---|---|---|---|
| id_manutencao | INT | PK, auto incremento | Identificador do registro de manutenção |
| id_ordem | INT | FK → ordem_manutencao.id_ordem | Ordem atendida |
| id_tecnico | INT | FK → tecnico.id | Técnico responsável |
| descricao_servico | VARCHAR(255) | NOT NULL | Serviço realizado |
| data_execucao | DATE | NOT NULL | Data da execução |
| horas_trabalhadas | DECIMAL(6,2) | >= 0 | Horas empregadas |
| observacoes | TEXT | Opcional | Observações do serviço |

### peca_manutencao
| Campo | Tipo | Chave/Regra | Descrição |
|---|---|---|---|
| id_manutencao | INT | PK composta, FK | Manutenção que utilizou a peça |
| id_peca | INT | PK composta, FK | Peça utilizada |
| quantidade | INT | > 0 | Quantidade da peça utilizada |

## 4. Observações
- Os arquivos CSV estão separados por vírgula e possuem cabeçalho.
- `data_fim` pode ficar vazia enquanto a ordem não for concluída.
- A chave primária composta em `peca_manutencao` impede duplicar a mesma peça na mesma manutenção.
- Execute `sql/ddl.sql` antes de `sql/dml.sql`.
