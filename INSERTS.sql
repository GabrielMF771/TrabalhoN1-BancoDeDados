-- PADARIA
INSERT INTO Padaria (nome, cnpj, logradouro, numero, complemento, bairro, cidade, estado, cep, telefones) VALUES
('Padaria Pão Nosso', '12131415161718', 'Rua das Amendoeiras', '245', 'Loja 02', 'Jardim do Sol', 'Cidade Esperança', 'SP', '12345678', '(11) 99876-5432');


-- PESSOAS
INSERT INTO Pessoa (cpf, nome, logradouro, numero, complemento, bairro, cidade, estado, cep, telefones) VALUES
('12345678901','Maria da Silveira Neto','Rua das Hortas','245','Casa 02','Jardim da Lua','Cidade Esperança','SP','12345678','(11) 99876-5432, (11) 3344-5566'),
('98765432100','Henrique Dantas','Avenida das Palmeiras','102','Apto 301','Asa Norte','Brasília','DF','70000001','(61) 99123-4567'),
('45612378955','Gabriel Martins','Rua de Tiradentes','58','Casa 12','Lago Sul','Brasília','DF','70000002','(61) 99888-1122'),
('32165498777','João Lucas','Quadra 210 Bloco B','25','Sala 08','Asa Sul','Brasília','DF','70000003','(61) 99321-4455, (61) 3555-6677'),
('74185296344','Gustavo Henrique','Setor Comercial Sul','145','Loja 05','Plano Piloto','Brasília','DF','70000004','(61) 99777-8899'),
('15935748620','Guilherme Vieira','Rua das Laranjeiras','320','Cobertura','Águas Claras','Brasília','DF','70000005','(61) 99666-2244');


-- FUNCIONARIOS
INSERT INTO Funcionario (cpf, matricula, cargo, salario, data_admissao, padaria_id) VALUES
('98765432100',1001,'Atendente',1800.00,'2023-05-10',1),   -- HENRIQUE
('45612378955',1002,'Padeiro',2500.00,'2022-11-20',1),     -- GABRIEL
('74185296344',1003,'Gerente',4000.00,'2023-03-15',1);     -- GUSTAVO


-- GERENTE
INSERT INTO Gerente (cpf, bonus_gerencia, nivel_acesso, data_inicio_gestao, padaria_id ) VALUES -- GUSTAVO
('74185296344',  1200.00,5,'2023-03-15',1);

-- PRODUTOS
INSERT INTO Produto (nome, preco_venda, estoque_atual, peso) VALUES
('Pão Francês', 0.50, 1000, 0.050),
('Bolo de Chocolate', 25.00, 20, 1.200),
('Croissant', 4.50, 50, 0.100),
('Pão de Queijo', 1.20, 200, 0.070),
('Torta de Frango', 35.00, 8, 1.500),
('Sonho de Creme', 3.80, 25, 0.120),
('Pão Integral', 6.50, 30, 0.400),
('Biscoito Caseiro', 12.00, 50, 0.300),
('Fatia de Pizza', 7.00, 60, 0.250),
('Café Expresso', 5.00, 100, 0.080);

-- VENDAS
INSERT INTO Venda (data_venda, padaria_id, cliente_nome, valor_total, forma_pagamento, atendente) VALUES
('2025-09-01',1,'Carlos Mendes',35.50,'Dinheiro','98765432100'),
('2025-09-01',1,'Fernanda Souza',12.00,'Cartão de Crédito','98765432100'),
('2025-09-02',1,'João Almeida',7.50,'Pix','98765432100'),
('2025-09-02',1,'Mariana Lima',25.00,'Cartão de Débito','98765432100'),
('2025-09-03',1,'Rafael Torres',15.20,'Dinheiro','98765432100'),
('2025-09-03',1,'Beatriz Nogueira',42.80,'Pix','98765432100'),
('2025-09-04',1,'Lucas Fernandes',9.00,'Cartão de Crédito','98765432100'),
('2025-09-04',1,'Patrícia Gomes',18.75,'Dinheiro','98765432100'),
('2025-09-05',1,'Eduardo Ribeiro',28.90,'Pix','98765432100'),
('2025-09-05',1,'Ana Clara',11.40,'Cartão de Débito','98765432100');

-- VENDAS(ITEM)
INSERT INTO Venda_Item (venda_id, produto_id, quantidade, preco_unitario, desconto, subtotal) VALUES
(1, 1, 20, 0.50, 0.00, 10.00),   
(1, 2, 1, 25.00, 0.00, 25.00),   
(2, 4, 10, 1.20, 0.00, 12.00),  
(2, 3, 5, 4.50, 0.00, 22.50),    
(3, 5, 1, 35.00, 5.00, 30.00),  
(4, 6, 2, 3.80, 0.00, 7.60),    
(5, 7, 3, 6.50, 0.00, 19.50),    
(6, 8, 4, 12.00, 0.00, 48.00),   
(7, 9, 2, 7.00, 0.00, 14.00),    
(8, 10, 5, 5.00, 0.00, 25.00);  


-- FORNECEDORES 
INSERT INTO Fornecedor (nome, cnpj_cpf, telefones) VALUES
('Padaria Central Fornecimentos','12345678000199','(61) 99988-7766, (61) 3344-5566'),
('Distribuidora Pães e Doces','98765432000155','(61) 99877-6655, (61) 3322-4455');


-- FORNECIMENTO(ITENS)
INSERT INTO Fornecimento (produto_id, fornecedor_id, preco_fornecedor, prazo_entrega) VALUES
(1, 1, 0.30, 2),   -- Pão Francês fornecido pela Padaria Central
(2, 1, 18.00, 3),  -- Bolo de Chocolate
(3, 2, 3.00, 2),   -- Croissant fornecido pela Distribuidora
(4, 2, 0.80, 2);   -- Pão de Queijo

-- PEDIDO NEGOCIADO
INSERT INTO Pedido_Negociado (padaria_id, fornecedor_id, preco_negociado, data_inicio, data_fim) VALUES
(1, 1, 0.28, '2025-09-01', '2025-12-31'),
(1, 2, 0.75, '2025-09-01', '2025-12-31');

-- COMPRAS DE ESTOQUE 
INSERT INTO Compra_Estoque (data_compra, fornecedor_id, padaria_id, valor_total, forma_pagamento) VALUES
('2025-09-01', 1, 1, 500.00, 'Dinheiro'),
('2025-09-02', 2, 1, 300.00, 'Cartão de Crédito');


-- LOTE 
INSERT INTO Lote (produto_id, compra_id, quantidade, data_validade, custo_unitario, numero_nota) VALUES
(1, 1, 1000, '2025-09-15', 0.30, 'NF12345'),  -- Pão Francês
(2, 1, 20, '2025-09-20', 18.00, 'NF12346'),   -- Bolo de Chocolate
(3, 2, 50, '2025-09-10', 3.00, 'NF22345'),    -- Croissant
(4, 2, 200, '2025-09-12', 0.80, 'NF22346');   -- Pão de Queijo

-- MOVIMENTAÇAO 
INSERT INTO Movimentacao (data_mov, tipo_mov, valor, descricao, padaria_id) VALUES
('2025-09-01','entrada', 1000.00, 'Venda de produtos', 1),
('2025-09-01','saida', 500.00, 'Compra de produtos', 1),
('2025-09-02','entrada', 800.00, 'Venda de produtos', 1),
('2025-09-02','saida', 300.00, 'Compra de produtos', 1);


-- TRANSAÇÃO HISTÓRICP
INSERT INTO Transacao_Historico (mov_id, saldo_apos, usuario_responsavel, comentario) VALUES
(1, 1000.00, 'Henrique Dantas', 'Receita do dia inicial''NULO'),
(2, 500.00, 'Henrique Dantas', 'Pagamento fornecedor Padaria Central''NULO'),
(3, 1300.00, 'Henrique Dantas', 'Venda do dia seguinte''NULO'),
(4, 1000.00, 'Henrique Dantas', 'Pagamento fornecedor Distribuidora Pães''NULO');

