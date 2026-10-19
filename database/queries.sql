-- ========================================================
-- DAB GEEK STORE — Consultas SQL do Projeto
-- Disciplina: Programação em Novas Tecnologias II / Programação Web
-- ========================================================

USE dab_geek_store;

-- --------------------------------------------------------
-- CONSULTA 1 (PRINCIPAL SOLICITADA):
-- Consulta de nome_usuario + produto + quantidade
-- --------------------------------------------------------
SELECT 
    u.nome_usuario,
    p.nome AS produto,
    ip.quantidade
FROM itens_pedido ip
INNER JOIN pedidos ped ON ip.pedido_id = ped.id
INNER JOIN usuarios u ON ped.usuario_id = u.id
INNER JOIN produtos p ON ip.produto_id = p.id
ORDER BY u.nome_usuario ASC, p.nome ASC;

-- --------------------------------------------------------
-- CONSULTA 1B (DETALHADA / FORMATO FINANCEIRO):
-- nome_usuario + produto + quantidade + valores e datas
-- --------------------------------------------------------
SELECT 
    u.nome_usuario,
    u.nome_completo,
    p.nome AS produto,
    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS subtotal,
    ped.id AS pedido_id,
    ped.status AS status_pedido,
    DATE_FORMAT(ped.data_pedido, '%d/%m/%Y %H:%i') AS data_formatada
FROM itens_pedido ip
INNER JOIN pedidos ped ON ip.pedido_id = ped.id
INNER JOIN usuarios u ON ped.usuario_id = u.id
INNER JOIN produtos p ON ip.produto_id = p.id
ORDER BY u.nome_usuario ASC, ped.data_pedido DESC, p.nome ASC;

-- --------------------------------------------------------
-- CONSULTA 2 (RESUMO POR USUÁRIO):
-- Total de itens adquiridos e valor total por cliente
-- --------------------------------------------------------
SELECT 
    u.nome_usuario,
    u.nome_completo,
    COUNT(DISTINCT ped.id) AS total_pedidos,
    SUM(ip.quantidade) AS total_itens_comprados,
    SUM(ip.quantidade * ip.preco_unitario) AS total_gasto
FROM usuarios u
LEFT JOIN pedidos ped ON u.id = ped.usuario_id
LEFT JOIN itens_pedido ip ON ped.id = ip.pedido_id
GROUP BY u.id, u.nome_usuario, u.nome_completo
ORDER BY total_gasto DESC;

-- --------------------------------------------------------
-- CONSULTA 3 (PRODUTOS MAIS VENDIDOS NO INVENTÁRIO):
-- --------------------------------------------------------
SELECT 
    p.codigo_slug,
    p.nome AS produto,
    c.nome AS categoria,
    p.preco,
    p.estoque AS estoque_atual,
    COALESCE(SUM(ip.quantidade), 0) AS unidades_vendidas
FROM produtos p
INNER JOIN categorias c ON p.categoria_id = c.id
LEFT JOIN itens_pedido ip ON p.id = ip.produto_id
GROUP BY p.id, p.codigo_slug, p.nome, c.nome, p.preco, p.estoque
ORDER BY unidades_vendidas DESC, p.nome ASC;
