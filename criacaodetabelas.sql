CREATE DATABASE FinanceiroPadaria;
USE FinanceiroPadaria;

-- CREATE

-- Criação das Tabelas

-- PADARIA
CREATE TABLE Padaria (
	padaria_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    logradouro VARCHAR(150) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8),
    telefones VARCHAR(255)
);

-- PESSOAS
CREATE TABLE Pessoa (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    logradouro VARCHAR(150),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2),
    cep CHAR(8),
    telefones VARCHAR(255)
);

CREATE TABLE Funcionario (
    cpf CHAR(11) PRIMARY KEY,
    matricula INT NOT NULL UNIQUE,
    cargo VARCHAR(50),
    salario DECIMAL(10,2),
    data_admissao DATE,
    padaria_id INT,
    FOREIGN KEY (cpf) REFERENCES Pessoa(cpf),
    FOREIGN KEY (padaria_id) REFERENCES Padaria(padaria_id)
);

CREATE TABLE Gerente (
    cpf CHAR(11) PRIMARY KEY,
    bonus_gerencia DECIMAL(10,2),
    nivel_acesso INT,
    data_inicio_gestao DATE,
    padaria_id INT,
    FOREIGN KEY (cpf) REFERENCES Funcionario(cpf),
    FOREIGN KEY (padaria_id) REFERENCES Padaria(padaria_id)
);

-- PADARIA

CREATE TABLE Produto (
	codigo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    estoque_atual INT NOT NULL DEFAULT 0,
    peso DECIMAL(10,3)
);

CREATE TABLE Venda (
    venda_id INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    padaria_id INT NOT NULL,
    cliente_nome VARCHAR(100),
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(50),
    atendente CHAR(11),
    FOREIGN KEY (padaria_id) REFERENCES Padaria(padaria_id),
    FOREIGN KEY (atendente) REFERENCES Funcionario(cpf)
);

-- (Associativa)
CREATE TABLE Venda_Item (
    venda_item_id INT PRIMARY KEY AUTO_INCREMENT,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2),
    desconto DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (venda_id) REFERENCES Venda(venda_id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES Produto(codigo)
);

-- FORNECEDOR
CREATE TABLE Fornecedor (
    fornecedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj_cpf VARCHAR(14) NOT NULL UNIQUE,
    telefones VARCHAR(255)
);

-- (Associativa)
CREATE TABLE Fornecimento (
    fornecimento_id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    fornecedor_id INT NOT NULL,
    preco_fornecedor DECIMAL(10,2),
    prazo_entrega INT,
    FOREIGN KEY (produto_id) REFERENCES Produto(codigo),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

CREATE TABLE Pedido_Negociado (
    pedido_negociado_id INT PRIMARY KEY AUTO_INCREMENT,
    padaria_id INT NOT NULL,
    fornecedor_id INT NOT NULL,
    preco_negociado DECIMAL(10,2),
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (padaria_id) REFERENCES Padaria(padaria_id),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

CREATE TABLE Compra_Estoque (
    compra_id INT PRIMARY KEY AUTO_INCREMENT,
    data_compra DATE NOT NULL,
    fornecedor_id INT NOT NULL,
    padaria_id INT NOT NULL,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id),
    FOREIGN KEY (padaria_id) REFERENCES Padaria(padaria_id)
);

CREATE TABLE Lote (
    lote_id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    compra_id INT NOT NULL,
    quantidade INT NOT NULL,
    data_validade DATE,
    custo_unitario DECIMAL(10,2),
    numero_nota VARCHAR(50),
    FOREIGN KEY (produto_id) REFERENCES Produto(codigo),
    FOREIGN KEY (compra_id) REFERENCES Compra_Estoque(compra_id)
);

-- MOVIMENTAÇÕES FINANCEIRAS
CREATE TABLE Movimentacao (
    mov_id INT PRIMARY KEY AUTO_INCREMENT,
    data_mov DATE NOT NULL,
    tipo_mov VARCHAR(20), -- entrada / saída
    valor DECIMAL(10,2),
    descricao VARCHAR(255),
    padaria_id INT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (padaria_id) REFERENCES Padaria(padaria_id)
);

CREATE TABLE Transacao_Historico (
    trans_id INT PRIMARY KEY AUTO_INCREMENT,
    mov_id INT NOT NULL,
    data_trans TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    saldo_apos DECIMAL(10,2),
    usuario_responsavel VARCHAR(100),
    comentario VARCHAR(255),
    FOREIGN KEY (mov_id) REFERENCES Movimentacao(mov_id)
);