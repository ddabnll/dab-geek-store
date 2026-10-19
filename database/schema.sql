-- ========================================================
-- DAB GEEK STORE — Script DDL do Banco de Dados Relacional
-- Disciplina: Programação em Novas Tecnologias II / Programação Web
-- SGBD: MySQL / MariaDB (XAMPP)
-- ========================================================

CREATE DATABASE IF NOT EXISTS dab_geek_store
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE dab_geek_store;

-- --------------------------------------------------------
-- 1. TABELA DE CATEGORIAS
-- --------------------------------------------------------
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(80) NOT NULL,
  slug VARCHAR(80) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- 2. TABELA DE USUÁRIOS
-- --------------------------------------------------------
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome_completo VARCHAR(120) NOT NULL,
  nome_usuario VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(120) NOT NULL UNIQUE,
  senha_hash VARCHAR(255) NOT NULL,
  nivel_acesso ENUM('admin', 'cliente') NOT NULL DEFAULT 'cliente',
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- 3. TABELA DE PRODUTOS
-- --------------------------------------------------------
CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  categoria_id INT NOT NULL,
  codigo_slug VARCHAR(80) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL,
  estoque INT NOT NULL DEFAULT 0,
  imagem_url VARCHAR(255) NOT NULL,
  ativo TINYINT(1) NOT NULL DEFAULT 1,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_produtos_categoria
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- 4. TABELA DE PEDIDOS
-- --------------------------------------------------------
CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  usuario_id INT NOT NULL,
  data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('pendente', 'pago', 'enviado', 'entregue', 'cancelado') NOT NULL DEFAULT 'pago',
  valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  CONSTRAINT fk_pedidos_usuario
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- 5. TABELA DE ITENS DO PEDIDO (RELACIONAMENTO N:N)
-- --------------------------------------------------------
CREATE TABLE itens_pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT NOT NULL,
  produto_id INT NOT NULL,
  quantidade INT NOT NULL DEFAULT 1,
  preco_unitario DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_itens_pedido_pedido
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_itens_pedido_produto
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
