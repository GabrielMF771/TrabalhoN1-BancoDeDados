SET @pct_reajuste := 0.05;   -- 5% reajuste de preços
SET @fornecedor   := 1;      -- fornecedor alvo para reajuste específico
SET @pedido_id    := 1;      -- pedido_negociado a encerrar (exemplo)

/* Permitir updates amplos com subconsultas correlacionadas */
SET SQL_SAFE_UPDATES = 0;

/* ---------------------------------------------------------------
   1) NORMALIZAÇÕES
   --------------------------------------------------------------- */

-- 1.1) Padronizar forma de pagamento
UPDATE Venda
SET forma_pagamento = UPPER(forma_pagamento)
WHERE forma_pagamento IS NOT NULL;

-- 1.2) Padronizar tipo_mov para UPPERCASE
UPDATE Movimentacao
SET tipo_mov = UPPER(tipo_mov)
WHERE tipo_mov IS NOT NULL;

-- 1.3) Corrigir sinal de Movimentacao.valor
UPDATE Movimentacao SET valor = ABS(valor)   WHERE tipo_mov = 'ENTRADA' AND valor < 0;
UPDATE Movimentacao SET valor = -ABS(valor)  WHERE tipo_mov = 'SAIDA'   AND valor > 0;

-- 1.4) Limpar lixo em comentarios
UPDATE Transacao_Historico
SET comentario = NULLIF(TRIM(REPLACE(REPLACE(comentario, '''NULO',''), 'NULO','')), '')
WHERE comentario IS NOT NULL;

/* ---------------------------------------------------------------
   2) VENDAS E ITENS
   --------------------------------------------------------------- */

-- 2.1) Recalcular subtotal (quantidade * preco_unitario - desconto)
UPDATE Venda_Item
SET subtotal = ROUND(quantidade * preco_unitario - COALESCE(desconto,0), 2);

-- 2.2) Recalcular valor_total da venda a partir dos subtotais
UPDATE Venda v
SET v.valor_total = (
  SELECT ROUND(COALESCE(SUM(vi.subtotal),0), 2)
  FROM Venda_Item vi
  WHERE vi.venda_id = v.venda_id
);

/* ---------------------------------------------------------------
   3) COMPRAS / LOTES
   --------------------------------------------------------------- */

-- 3.1) Atualizar valor_total da compra somando seus lotes
UPDATE Compra_Estoque c
SET c.valor_total = (
  SELECT ROUND(COALESCE(SUM(l.quantidade * l.custo_unitario),0), 2)
  FROM Lote l
  WHERE l.compra_id = c.compra_id
);

-- 3.2) Recalcular estoque_atual do Produto como (compras - vendas)
UPDATE Produto p
SET p.estoque_atual = GREATEST(
  0,
  COALESCE((SELECT SUM(l.quantidade) FROM Lote l WHERE l.produto_id = p.codigo), 0)
  -
  COALESCE((SELECT SUM(vi.quantidade) FROM Venda_Item vi WHERE vi.produto_id = p.codigo), 0)
);

/* ---------------------------------------------------------------
   4) PREÇOS
   --------------------------------------------------------------- */

-- 4.1) Reajuste percentual geral de preço de venda
UPDATE Produto
SET preco_venda = ROUND(preco_venda * (1 + @pct_reajuste), 2);

-- 4.2) Reajuste apenas de produtos fornecidos por @fornecedor
UPDATE Produto p
JOIN Fornecimento fr ON fr.produto_id = p.codigo AND fr.fornecedor_id = @fornecedor
SET p.preco_venda = ROUND(p.preco_venda * (1 + @pct_reajuste), 2);

-- 4.3) Aplicar preço negociado vigente ao Fornecimento
UPDATE Fornecimento fr
JOIN Pedido_Negociado pn
  ON pn.fornecedor_id = fr.fornecedor_id
SET fr.preco_fornecedor = pn.preco_negociado
WHERE pn.data_inicio <= CURDATE()
  AND (pn.data_fim IS NULL OR pn.data_fim >= CURDATE());

-- 4.4) Encerrar um pedido negociado (definir data_fim = hoje)
UPDATE Pedido_Negociado
SET data_fim = CURDATE()
WHERE pedido_negociado_id = @pedido_id AND data_fim IS NULL;

SET SQL_SAFE_UPDATES = 1;