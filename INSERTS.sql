USE FinanceiroPadaria;

-- CATEGORIAS
INSERT INTO Categoria (nome, descricao) VALUES 
('Pães', 'Produtos de panificação variados como francês, integral e de forma'),
('Bolos', 'Bolos caseiros, recheados e decorados'),
('Salgados', 'Salgados assados e fritos, como coxinha, empada e pastel'),
('Doces', 'Doces diversos como brigadeiro, doce de leite e tortas'),
('Bebidas', 'Bebidas quentes e frias, incluindo café, sucos e refrigerantes'),
('Lanches', 'Sanduíches e lanches rápidos para consumo imediato'),
('Outros', 'Produtos que não se enquadram nas categorias anteriores');

-- FORNECEDORES
INSERT INTO Fornecedor (nome, cnpj, valor_pedido) VALUES
('Padaria Central Fornecimentos','12345678000199', NULL),
('Distribuidora Pães e Doces','98765432000155', NULL);

-- PRODUTOS
INSERT INTO Produto (nome, preco_custo, preco_venda, peso, categoria_id, fornecedor_id) VALUES
('Pão Francês', 0.30, 0.50, 0.050, 1, 1),
('Bolo de Chocolate', 18.00, 25.00, 1.200, 2, 1),
('Croissant', 3.00, 4.50, 0.100, 3, 2),
('Pão de Queijo', 0.80, 1.20, 0.070, 3, 2),
('Torta de Frango', 22.00, 35.00, 1.500, 3, NULL),
('Sonho de Creme', 2.50, 3.80, 0.120, 4, NULL),
('Pão Integral', 4.50, 6.50, 0.400, 1, NULL),
('Biscoito Caseiro', 8.00, 12.00, 0.300, 7, NULL),
('Fatia de Pizza', 4.50, 7.00, 0.250, 7, NULL),
('Café Expresso', 2.50, 5.00, 0.080, 5, NULL);

-- LOTES
INSERT INTO Lote (produto_id, fornecedor_id, data_entrada, data_validade) VALUES
(1, 1, '2025-09-01', '2025-09-15'),  -- Pão Francês (NF12345)
(2, 1, '2025-09-01', '2025-09-20'),  -- Bolo de Chocolate (NF12346)
(3, 2, '2025-09-02', '2025-09-10'),  -- Croissant (NF22345)
(4, 2, '2025-09-02', '2025-09-12');  -- Pão de Queijo (NF22346)

-- ESTOQUE
INSERT INTO Estoque (produto_id, lote_id, quantidade) VALUES
(1, 1, 1000),  -- Pão Francês
(2, 2, 20),    -- Bolo de Chocolate
(3, 3, 50),    -- Croissant
(4, 4, 200);   -- Pão de Queijo

-- PESSOAS
INSERT INTO Pessoa (cpf, nome, telefones, endereco, cep) VALUES
('12345678901','Maria da Silveira Neto','(11) 99876-5432, (11) 3344-5566','Rua das Hortas, 245, Casa 02','12345678'),
('98765432100','Henrique Dantas','(61) 99123-4567','Avenida das Palmeiras, 102, Apto 301','70000001'),
('45612378955','Gabriel Martins','(61) 99888-1122','Rua de Tiradentes, 58, Casa 12','70000002'),
('32165498777','João Lucas','(61) 99321-4455, (61) 3555-6677','Quadra 210 Bloco B, 25, Sala 08','70000003'),
('74185296344','Gustavo Henrique','(61) 99777-8899','Setor Comercial Sul, 145, Loja 05','70000004'),
('15935748620','Guilherme Vieira','(61) 99666-2244','Rua das Laranjeiras, 320, Cobertura','70000005');

-- FUNCIONÁRIOS
INSERT INTO Funcionario (cpf, matricula, cargo, data_admissao, salario) VALUES
('98765432100',1001,'Atendente','2023-05-10',1800.00), -- HENRIQUE
('45612378955',1002,'Padeiro','2022-11-20',2500.00),   -- GABRIEL
('74185296344',1003,'Gerente','2023-03-15',4000.00);   -- GUSTAVO

-- GERENTE
INSERT INTO Gerente (cpf, bonus_gerencia, salario, nivel_acesso, data_inicio_gestao) VALUES
('74185296344', 1200.00, 4000.00, 5, '2023-03-15'); -- GUSTAVO

-- CLIENTES
INSERT INTO Cliente (nome, telefones) VALUES
('Carlos Mendes', NULL),
('Fernanda Souza', NULL),
('João Almeida', NULL),
('Mariana Lima', NULL),
('Rafael Torres', NULL),
('Beatriz Nogueira', NULL),
('Lucas Fernandes', NULL),
('Patrícia Gomes', NULL),
('Eduardo Ribeiro', NULL),
('Ana Clara', NULL);

-- PEDIDOS
INSERT INTO Pedido (valor_final, cliente_id, funcionario_id, data_pedido) VALUES
(35.50, 1, '98765432100', '2025-09-01'),  -- pedido 1 por Carlos Mendes
(12.00, 2, '98765432100', '2025-09-01'),  -- pedido 2 por Fernanda Souza
(7.50, 3, '98765432100', '2025-09-02'),   -- pedido 3 por João Almeida
(25.00, 4, '98765432100', '2025-09-02'),  -- pedido 4 por Mariana Lima
(15.20, 5, '98765432100', '2025-09-03'),  -- pedido 5 por Rafael Torres
(42.80, 6, '98765432100', '2025-09-03'),  -- pedido 6 por Beatriz Nogueira
(9.00, 7, '98765432100', '2025-09-04'),   -- pedido 7 por Lucas Fernandes
(18.75, 8, '98765432100', '2025-09-04'),  -- pedido 8 por Patrícia Gomes
(28.90, 9, '98765432100', '2025-09-05'),  -- pedido 9 por Eduardo Ribeiro
(11.40, 10, '98765432100', '2025-09-05'); -- pedido 10 por Ana Clara

-- FORMA_DE_PAGAMENTO
INSERT INTO Forma_Pagamento (forma, valor, pedido_id) VALUES
('Dinheiro', 35.50, 1),
('Cartão de Crédito', 12.00, 2),
('Pix', 7.50, 3),
('Cartão de Débito', 25.00, 4),
('Dinheiro', 15.20, 5),
('Pix', 42.80, 6),
('Cartão de Crédito', 9.00, 7),
('Dinheiro', 18.75, 8),
('Pix', 28.90, 9),
('Cartão de Débito', 11.40, 10);

-- ITENS DOS PEDIDOS
INSERT INTO Pedido_Item (pedido_id, produto_id, quantidade, preco_unitario, subtotal) VALUES
(1, 1, 20, 0.50, 10.00),   -- pedido 1: 20 x Pão Francês
(1, 2, 1, 25.00, 25.00),   -- pedido 1: 1 x Bolo de Chocolate
(2, 4, 10, 1.20, 12.00),   -- pedido 2: 10 x Pão de Queijo
(2, 3, 5, 4.50, 22.50),    -- pedido 2: 5 x Croissant
(3, 5, 1, 35.00, 30.00),   -- pedido 3: 1 x Torta de Frango
(4, 6, 2, 3.80, 7.60),     -- pedido 4: 2 x Sonho de Creme
(5, 7, 3, 6.50, 19.50),    -- pedido 5: 3 x Pão Integral
(6, 8, 4, 12.00, 48.00),   -- pedido 6: 4 x Biscoito Caseiro
(7, 9, 2, 7.00, 14.00),    -- pedido 7: 2 x Fatia de Pizza
(8, 10, 5, 5.00, 25.00);   -- pedido 8: 5 x Café Expresso

-- MOVIMENTAÇÃO DE ESTOQUE
INSERT INTO Movimentacao_Estoque (tipo, data_movimentacao, quantidade, pedido_id, funcionario_id) VALUES
('ENTRADA', '2025-09-01 09:00:00', 1000, NULL, NULL),
('ENTRADA', '2025-09-01 09:15:00', 20, NULL, NULL),
('ENTRADA', '2025-09-02 10:00:00', 50, NULL, NULL),
('ENTRADA', '2025-09-02 10:15:00', 200, NULL, NULL);