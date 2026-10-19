<?php
require_once __DIR__ . '/config.php';

function obterConexao(): PDO {
    static $pdo = null;

    if ($pdo === null) {
        $dsn = sprintf(
            'mysql:host=%s;port=%s;dbname=%s;charset=%s',
            DB_HOST,
            DB_PORT,
            DB_NAME,
            DB_CHARSET
        );

        $opcoes = [
            PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES   => false,
        ];

        try {
            $pdo = new PDO($dsn, DB_USER, DB_PASS, $opcoes);
        } catch (PDOException $e) {
            die(json_encode([
                'sucesso'  => false,
                'mensagem' => 'Erro ao conectar ao banco de dados: ' . $e->getMessage()
            ], JSON_UNESCAPED_UNICODE));
        }
    }

    return $pdo;
}
