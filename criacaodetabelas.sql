CREATE DATABASE IF NOT EXISTS FinanceiroPadaria;
USE FinanceiroPadaria;

-- Criação das Tabelas

-- CATEGORIA (Tipo de Produto)
CREATE TABLE Categoria (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255)
);

-- FORNECEDOR
CREATE TABLE Fornecedor (
    fornecedor_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    cnpj CHAR(14) UNIQUE,
    valor_pedido DECIMAL(10,2) NULL
);

-- PRODUTO
CREATE TABLE Produto (
    produto_id INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(150) NOT NULL,
    preco_custo DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    peso DECIMAL(10,3),
    categoria_id INT,
    fornecedor_id INT,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

-- LOTE
CREATE TABLE Lote (
    lote_id INT PRIMARY KEY AUTO_INCREMENT,
    data_entrada DATE,
    data_validade DATE,
    produto_id INT NOT NULL,
    fornecedor_id INT,
    CONSTRAINT fk_lote_produto FOREIGN KEY (produto_id) REFERENCES Produto(produto_id),
    CONSTRAINT fk_lote_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

-- ESTOQUE
CREATE TABLE Estoque (
    estoque_id INT PRIMARY KEY AUTO_INCREMENT,
    quantidade INT NOT NULL DEFAULT 0,
    produto_id INT NOT NULL,
    lote_id INT,
    CONSTRAINT fk_estoque_produto FOREIGN KEY (produto_id) REFERENCES Produto(produto_id),
    CONSTRAINT fk_estoque_lote FOREIGN KEY (lote_id) REFERENCES Lote(lote_id)
);

-- PESSOA (SUPERCLASSE)
CREATE TABLE Pessoa (
    cpf CHAR(11) PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    telefones VARCHAR(255),
    endereco VARCHAR(255),
    cep CHAR(8)
);

-- FUNCIONARIO (ESPECIALIZAÇÃO DE PESSOA)
CREATE TABLE Funcionario (
    cpf CHAR(11) PRIMARY KEY,
    matricula INT UNIQUE,
    cargo VARCHAR(80),
    data_admissao DATE,
    salario DECIMAL(12,2),
    CONSTRAINT fk_funcionario_pessoa FOREIGN KEY (cpf) REFERENCES Pessoa(cpf)
);

-- GERENTE (ESPECIALIZAÇÃO DE PESSOA)
CREATE TABLE Gerente (
    cpf CHAR(11) PRIMARY KEY,
    bonus_gerencia DECIMAL(10,2),
    salario DECIMAL(12,2), 
    nivel_acesso INT,
    data_inicio_gestao DATE,
    CONSTRAINT fk_gerente_funcionario FOREIGN KEY (cpf) REFERENCES Funcionario(cpf)
);

-- CLIENTE
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    telefones VARCHAR(255)
);

-- PEDIDO
CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    valor_final DECIMAL(12,2),
    cliente_id INT,
    funcionario_id CHAR(11),
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    CONSTRAINT fk_pedido_funcionario FOREIGN KEY (funcionario_id) REFERENCES Funcionario(cpf)
);

-- FORMA DE PAGAMENTO
CREATE TABLE Forma_Pagamento (
    forma_pag_id INT PRIMARY KEY AUTO_INCREMENT,
    forma VARCHAR(100) NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    pedido_id INT UNIQUE, -- 1:1
    CONSTRAINT fk_formapag_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id) ON DELETE CASCADE
);

-- PEDIDO_ITEM (ASSOCIATIVA = PRODUTO X PEDIDO)
CREATE TABLE Pedido_Item (
    pedido_item_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2),
    subtotal DECIMAL(12,2),
    CONSTRAINT fk_item_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id) ON DELETE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);

-- MOVIMENTACAO DE ESTOQUE (Historico)
CREATE TABLE Movimentacao_Estoque (
    mov_estoque_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM('ENTRADA','SAIDA') NOT NULL,
    data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    quantidade INT NOT NULL,
    pedido_id INT,
    funcionario_id CHAR(11),
    CONSTRAINT fk_mov_estoque_pedido FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id),
    CONSTRAINT fk_mov_estoque_funcionario FOREIGN KEY (funcionario_id) REFERENCES Funcionario(cpf)
);