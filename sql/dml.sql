-- Tema 04 - Dados de teste
USE manutencao_equipamentos;

INSERT INTO equipamento
(id,nome,tipo,marca,modelo,numero_serie,data_aquisicao,status,setor,valor_aquisicao) VALUES
(1,'Torno CNC','Máquina','Romi','GL-200','TRN-2024-001','2024-02-15','Ativo','Usinagem',85000.00),
(2,'Compressor de Ar','Equipamento','Schulz','SRP air','CMP-2023-014','2023-08-10','Ativo','Manutenção',12500.00),
(3,'Esteira Transportadora','Máquina','Mercúrio','ET-500','EST-2022-008','2022-11-03','Em manutenção','Montagem',32000.00);

INSERT INTO tecnico (id,nome,especialidade,telefone,email) VALUES
(1,'Carlos Mendes','Mecânica','(19) 98811-2233','carlos.mendes@fabrica.com'),
(2,'Ana Ribeiro','Elétrica','(19) 97722-3344','ana.ribeiro@fabrica.com'),
(3,'João Ferreira','Automação','(19) 96633-4455','joao.ferreira@fabrica.com');

INSERT INTO peca (id_peca,nome,descricao,quantidade_estoque,estoque_minimo,preco) VALUES
(1,'Rolamento 6204','Rolamento blindado',25,5,38.90),
(2,'Correia A-42','Correia industrial',12,4,54.50),
(3,'Filtro de ar','Filtro para compressor',8,3,79.90);

INSERT INTO ordem_manutencao
(id_ordem,id_equipamento,tipo,descricao,data_abertura,data_inicio,data_fim,status,prioridade) VALUES
(1,1,'Preventiva','Lubrificação e inspeção geral','2026-09-01','2026-09-02',NULL,'Em andamento','Média'),
(2,2,'Corretiva','Vibração excessiva no compressor','2026-09-03','2026-09-03','2026-09-04','Concluída','Alta'),
(3,3,'Corretiva','Falha no motor da esteira','2026-09-05','2026-09-06',NULL,'Aberta','Alta');

INSERT INTO manutencao
(id_manutencao,id_ordem,id_tecnico,descricao_servico,data_execucao,horas_trabalhadas,observacoes) VALUES
(1,1,1,'Inspeção e lubrificação dos componentes','2026-09-02',2.50,'Sem anomalias críticas.'),
(2,2,2,'Diagnóstico elétrico e troca de componente','2026-09-03',3.00,'Equipamento liberado após teste.'),
(3,3,3,'Análise do acionamento e testes iniciais','2026-09-06',1.50,'Aguardando chegada de peça.');

INSERT INTO peca_manutencao (id_manutencao,id_peca,quantidade) VALUES
(1,1,2),
(2,3,1),
(3,2,1),
(3,1,1);
