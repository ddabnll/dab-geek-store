<?php
// ========================================================
// DAB GEEK STORE — Script de Inicialização Automática do Banco
// Executa o schema.sql e o seed.sql
// ========================================================

header('Content-Type: text/html; charset=utf-8');

require_once __DIR__ . '/config.php';

echo "<!DOCTYPE html><html lang='pt-BR'><head><meta charset='UTF-8'><title>Setup DAB GEEK STORE</title>";
echo "<style>body{font-family:monospace;background:#0d1117;color:#c9d1d9;padding:24px;line-height:1.6;}";
echo ".ok{color:#3fb950;}.err{color:#f85149;}.info{color:#58a6ff;}h1{color:#f0883e;}</style></head><body>";
echo "<h1>DAB GEEK STORE — Setup do Banco de Dados</h1>";

try {
    // 1. Conecta sem especificar banco para poder criá-lo
    $dsnServidor = sprintf('mysql:host=%s;port=%s;charset=%s', DB_HOST, DB_PORT, DB_CHARSET);
    $pdo = new PDO($dsnServidor, DB_USER, DB_PASS, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
    ]);

    echo "<p class='info'>[1/3] Conectado ao servidor MySQL com sucesso.</p>";

    // 2. Executa schema.sql
    $caminhoSchema = dirname(__DIR__) . '/database/schema.sql';
    if (!file_exists($caminhoSchema)) {
        throw new Exception("Arquivo schema.sql não encontrado em: $caminhoSchema");
    }

    $sqlSchema = file_get_contents($caminhoSchema);
    $pdo->exec($sqlSchema);
    echo "<p class='ok'>[2/3] Banco `dab_geek_store` e tabelas criadas com sucesso (schema.sql).</p>";

    // 3. Executa seed.sql
    $caminhoSeed = dirname(__DIR__) . '/database/seed.sql';
    if (!file_exists($caminhoSeed)) {
        throw new Exception("Arquivo seed.sql não encontrado em: $caminhoSeed");
    }

    $sqlSeed = file_get_contents($caminhoSeed);
    $pdo->exec($sqlSeed);
    echo "<p class='ok'>[3/3] Dados de povoamento inseridos com sucesso (seed.sql).</p>";

    echo "<hr><p class='ok'>✓ Banco de dados pronto para uso!</p>";
    echo "<p>Acesse a consulta de compras: <a style='color:#58a6ff;' href='consulta_compras.php'>consulta_compras.php</a></p>";

} catch (Exception $e) {
    echo "<p class='err'>[ERRO] " . htmlspecialchars($e->getMessage()) . "</p>";
}

echo "</body></html>";
