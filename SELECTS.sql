-- Consulta simples de produtos
SELECT Produto.produto_id, Produto.nome, Produto.preco_venda
FROM Produto;

-- Consulta detalhada de pedidos mostrando o nome do cliente
SELECT Pedido.pedido_id, Pedido.valor_final, Cliente.nome AS nome_do_cliente, Pedido.data_pedido
FROM Pedido
JOIN Cliente ON Pedido.cliente_id = Cliente.cliente_id;

-- Consulta detalhada de itens de um pedido específico
SELECT Pedido_Item.pedido_item_id, Produto.nome AS nome_do_produto, Pedido_Item.quantidade, Pedido_Item.preco_unitario, Pedido_Item.subtotal
FROM Pedido_Item
JOIN Produto ON Pedido_Item.produto_id = Produto.produto_id
WHERE Pedido_Item.pedido_id = 1;

-- Consulta listando produtos, categorias e preço de venda
SELECT Produto.nome AS nome_do_produto, Categoria.nome AS nome_da_categoria, Produto.preco_venda
FROM Produto
JOIN Categoria ON Produto.categoria_id = Categoria.categoria_id;

-- Consulta mostrando quantidade em estoque de cada produto
SELECT Produto.nome AS nome_do_produto, Estoque.quantidade
FROM Estoque
JOIN Produto ON Estoque.produto_id = Produto.produto_id;

-- Consulta detalhada de pedidos feitos por um funcionário específico
SELECT Pedido.pedido_id, Pedido.valor_final, Pedido.data_pedido, Pessoa.nome AS nome_do_funcionario
FROM Pedido
JOIN Funcionario ON Pedido.funcionario_id = Funcionario.cpf
JOIN Pessoa ON Funcionario.cpf = Pessoa.cpf
WHERE Pessoa.nome = 'Henrique Dantas';

-- Consulta agrupada mostrando valor total vendido por forma de pagamento
SELECT Forma_Pagamento.forma, SUM(Forma_Pagamento.valor) AS valor_total_vendido
FROM Forma_Pagamento
GROUP BY Forma_Pagamento.forma;