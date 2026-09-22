-- Tema 04 - Manutenção de Equipamentos
-- Banco: MySQL 8+ / MariaDB
CREATE DATABASE IF NOT EXISTS manutencao_equipamentos
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE manutencao_equipamentos;

CREATE TABLE equipamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(60) NOT NULL,
    marca VARCHAR(60),
    modelo VARCHAR(60),
    numero_serie VARCHAR(80) NOT NULL UNIQUE,
    data_aquisicao DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    setor VARCHAR(80) NOT NULL,
    valor_aquisicao DECIMAL(12,2) NOT NULL,
    CHECK (valor_aquisicao >= 0)
);

CREATE TABLE tecnico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    especialidade VARCHAR(80) NOT NULL,
    telefone VARCHAR(25),
    email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    quantidade_estoque INT NOT NULL DEFAULT 0,
    estoque_minimo INT NOT NULL DEFAULT 0,
    preco DECIMAL(10,2) NOT NULL,
    CHECK (quantidade_estoque >= 0),
    CHECK (estoque_minimo >= 0),
    CHECK (preco >= 0)
);

CREATE TABLE ordem_manutencao (
    id_ordem INT AUTO_INCREMENT PRIMARY KEY,
    id_equipamento INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    data_abertura DATE NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(30) NOT NULL,
    prioridade VARCHAR(20) NOT NULL,
    CONSTRAINT fk_ordem_equipamento
      FOREIGN KEY (id_equipamento) REFERENCES equipamento(id),
    CHECK (tipo IN ('Preventiva','Corretiva')),
    CHECK (data_fim IS NULL OR data_inicio IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE manutencao (
    id_manutencao INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem INT NOT NULL,
    id_tecnico INT NOT NULL,
    descricao_servico VARCHAR(255) NOT NULL,
    data_execucao DATE NOT NULL,
    horas_trabalhadas DECIMAL(6,2) NOT NULL,
    observacoes TEXT,
    CONSTRAINT fk_manutencao_ordem
      FOREIGN KEY (id_ordem) REFERENCES ordem_manutencao(id_ordem),
    CONSTRAINT fk_manutencao_tecnico
      FOREIGN KEY (id_tecnico) REFERENCES tecnico(id),
    CHECK (horas_trabalhadas >= 0)
);

CREATE TABLE peca_manutencao (
    id_manutencao INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_manutencao, id_peca),
    CONSTRAINT fk_pm_manutencao
      FOREIGN KEY (id_manutencao) REFERENCES manutencao(id_manutencao),
    CONSTRAINT fk_pm_peca
      FOREIGN KEY (id_peca) REFERENCES peca(id_peca),
    CHECK (quantidade > 0)
);
