-- Consulta simples de produtos
SELECT Produto.produtoid, Produto.nome, Produto.precovenda
FROM Produto;

-- Consulta detalhada de pedidos mostrando o nome do cliente
SELECT Pedido.pedidoid, Pedido.valorfinal, Cliente.nome AS nome_do_cliente, Pedido.datapedido
FROM Pedido
JOIN Cliente ON Pedido.clienteid = Cliente.clienteid;

-- Consulta detalhada de itens de um pedido específico
SELECT PedidoItem.pedidoitemid, Produto.nome AS nome_do_produto, PedidoItem.quantidade, PedidoItem.precounitario, PedidoItem.subtotal
FROM PedidoItem
JOIN Produto ON PedidoItem.produtoid = Produto.produtoid
WHERE PedidoItem.pedidoid = 1;

-- Consulta listando produtos, categorias e preço de venda
SELECT Produto.nome AS nome_do_produto, Categoria.nome AS nome_da_categoria, Produto.precovenda
FROM Produto
JOIN Categoria ON Produto.categoriaid = Categoria.categoriaid;

-- Consulta mostrando quantidade em estoque de cada produto
SELECT Produto.nome AS nome_do_produto, Estoque.quantidade
FROM Estoque
JOIN Produto ON Estoque.produtoid = Produto.produtoid;

-- Consulta detalhada de pedidos feitos por um funcionário específico
SELECT Pedido.pedidoid, Pedido.valorfinal, Pedido.datapedido, Funcionario.nome AS nome_do_funcionario
FROM Pedido
JOIN Funcionario ON Pedido.funcionarioid = Funcionario.cpf
WHERE Funcionario.nome = 'NOME_DO_FUNCIONARIO';

-- Consulta agrupada mostrando valor total vendido por forma de pagamento
SELECT FormaPagamento.forma, SUM(FormaPagamento.valor) AS valor_total_vendido
FROM FormaPagamento
GROUP BY FormaPagamento.forma;
