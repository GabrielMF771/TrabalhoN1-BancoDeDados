SET @pct_reajuste := 0.05;   -- 5% reajuste de preços
SET @fornecedor   := 1;      -- fornecedor alvo para reajuste específico
SET @pedido_id    := 1;      -- pedido a encerrar (exemplo)

SET SQL_SAFE_UPDATES = 0;

/* ---------------------------------------------------------------
   1) NORMALIZAÇÕES
   --------------------------------------------------------------- */

UPDATE Forma_Pagamento
SET forma = UPPER(forma)
WHERE forma IS NOT NULL;

UPDATE Movimentacao_Estoque
SET tipo = UPPER(tipo)
WHERE tipo IS NOT NULL;

/* ---------------------------------------------------------------
   2) PEDIDOS E ITENS
   --------------------------------------------------------------- */

UPDATE Pedido_Item
SET subtotal = ROUND(quantidade * preco_unitario, 2);

UPDATE Pedido p
SET p.valor_final = (
  SELECT ROUND(COALESCE(SUM(pi.subtotal),0), 2)
  FROM Pedido_Item pi
  WHERE pi.pedido_id = p.pedido_id
);

/* ---------------------------------------------------------------
   3) PREÇOS E ENCERRAMENTO DE PEDIDO
   --------------------------------------------------------------- */

UPDATE Produto
SET preco_venda = ROUND(preco_venda * (1 + @pct_reajuste), 2);

UPDATE Produto p
SET p.preco_venda = ROUND(p.preco_venda * (1 + @pct_reajuste), 2)
WHERE p.fornecedor_id = @fornecedor;

-- 3.3) Encerrar um pedido (adiciona data_fim se não existir)
ALTER TABLE Pedido ADD COLUMN data_fim DATE NULL;

UPDATE Pedido
SET data_fim = CURDATE()
WHERE pedido_id = @pedido_id AND data_fim IS NULL;

SET SQL_SAFE_UPDATES = 1;
