<?php
// ========================================================
// DAB GEEK STORE — Consulta de Compras por Usuário
// Exibe a relação: nome_usuario + produto + quantidade
// ========================================================

require_once __DIR__ . '/conexao.php';

$pdo = obterConexao();

// Consulta SQL solicitada: nome_usuario + produto + quantidade (com preço e data para enriquecer)
$sql = "
    SELECT 
        u.nome_usuario,
        u.nome_completo,
        p.nome AS produto,
        p.codigo_slug,
        p.imagem_url,
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
    ORDER BY u.nome_usuario ASC, ped.data_pedido DESC, p.nome ASC
";

$stmt = $pdo->query($sql);
$compras = $stmt->fetchAll();

// Totais gerais para os cards de resumo
$totalItens = 0;
$valorTotalGeral = 0;
foreach ($compras as $item) {
    $totalItens += $item['quantidade'];
    $valorTotalGeral += $item['subtotal'];
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Consulta de Compras | DAB GEEK STORE</title>
  <link rel="stylesheet" href="../style.css">
  <link rel="icon" href="../favicon.svg" type="image/svg+xml">
  <style>
    .consulta-container {
      max-width: 1100px;
      margin: 40px auto;
      padding: 0 20px;
    }
    .consulta-header {
      margin-bottom: 30px;
    }
    .consulta-header h1 {
      font-size: 2rem;
      color: var(--neon-cyan, #00f0ff);
      margin-bottom: 8px;
    }
    .consulta-header p {
      color: var(--text-muted, #a0aec0);
    }
    .painel-metricas {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }
    .card-metrica {
      background: var(--paper-card, #161b22);
      border: 1px solid var(--border-color, #30363d);
      border-radius: 8px;
      padding: 20px;
    }
    .card-metrica span {
      display: block;
      font-size: 0.85rem;
      color: var(--text-muted, #8b949e);
      margin-bottom: 6px;
    }
    .card-metrica strong {
      font-size: 1.6rem;
      color: #fff;
    }
    .tabela-wrapper {
      background: var(--paper-card, #161b22);
      border: 1px solid var(--border-color, #30363d);
      border-radius: 8px;
      overflow-x: auto;
    }
    table.tabela-compras {
      width: 100%;
      border-collapse: collapse;
      text-align: left;
    }
    table.tabela-compras th {
      background: #0d1117;
      padding: 14px 18px;
      color: var(--neon-purple, #bf5af2);
      font-size: 0.9rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 1px solid var(--border-color, #30363d);
    }
    table.tabela-compras td {
      padding: 14px 18px;
      border-bottom: 1px solid #21262d;
      color: #e6edf3;
      font-size: 0.95rem;
    }
    table.tabela-compras tr:hover {
      background: rgba(255, 255, 255, 0.03);
    }
    .badge-usuario {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 12px;
      font-family: monospace;
      font-size: 0.85rem;
      background: rgba(0, 240, 255, 0.15);
      color: #00f0ff;
      border: 1px solid rgba(0, 240, 255, 0.3);
    }
    .badge-qtd {
      font-weight: bold;
      color: #f0883e;
      font-size: 1.1rem;
    }
    .badge-status {
      padding: 3px 8px;
      border-radius: 4px;
      font-size: 0.75rem;
      text-transform: uppercase;
    }
    .badge-status.pago { background: #238636; color: #fff; }
    .badge-status.entregue { background: #1f6feb; color: #fff; }
    .badge-status.enviado { background: #8957e5; color: #fff; }
    .nav-voltar {
      margin-top: 24px;
      display: inline-block;
      color: var(--neon-cyan, #00f0ff);
      text-decoration: none;
    }
    .nav-voltar:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="consulta-container">
    <div class="consulta-header">
      <h1>Relatório de Pedidos: Usuário &times; Produto &times; Quantidade</h1>
      <p>Consulta relacional integrada entre as tabelas <code>usuarios</code>, <code>pedidos</code>, <code>itens_pedido</code> e <code>produtos</code>.</p>
    </div>

    <div class="painel-metricas">
      <div class="card-metrica">
        <span>Total de Linhas / Itens</span>
        <strong><?= count($compras) ?> registros</strong>
      </div>
      <div class="card-metrica">
        <span>Volume Total de Itens</span>
        <strong><?= $totalItens ?> unidades</strong>
      </div>
      <div class="card-metrica">
        <span>Valor Acumulado</span>
        <strong>R$ <?= number_format($valorTotalGeral, 2, ',', '.') ?></strong>
      </div>
    </div>

    <div class="tabela-wrapper">
      <table class="tabela-compras">
        <thead>
          <tr>
            <th>Nome do Usuário</th>
            <th>Nome Completo</th>
            <th>Produto</th>
            <th>Qtd</th>
            <th>Preço Unit.</th>
            <th>Subtotal</th>
            <th>Data do Pedido</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <?php if (empty($compras)): ?>
            <tr>
              <td colspan="8" style="text-align:center; padding:30px;">Nenhum registro encontrado. Execute o povoamento do banco.</td>
            </tr>
          <?php else: ?>
            <?php foreach ($compras as $item): ?>
              <tr>
                <td><span class="badge-usuario">@<?= htmlspecialchars($item['nome_usuario']) ?></span></td>
                <td><?= htmlspecialchars($item['nome_completo']) ?></td>
                <td><strong><?= htmlspecialchars($item['produto']) ?></strong></td>
                <td><span class="badge-qtd"><?= (int)$item['quantidade'] ?></span></td>
                <td>R$ <?= number_format($item['preco_unitario'], 2, ',', '.') ?></td>
                <td><strong>R$ <?= number_format($item['subtotal'], 2, ',', '.') ?></strong></td>
                <td><?= htmlspecialchars($item['data_formatada']) ?></td>
                <td><span class="badge-status <?= htmlspecialchars($item['status_pedido']) ?>"><?= htmlspecialchars($item['status_pedido']) ?></span></td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>

    <a href="../index.html" class="nav-voltar">&larr; Voltar para a Loja DAB GEEK STORE</a>
  </div>
</body>
</html>
