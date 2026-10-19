
USE dab_geek_store;

INSERT INTO categorias (id, nome, slug) VALUES
  (1, 'Colecionáveis & Action Figures', 'colecionaveis'),
  (2, 'Periféricos & Hardware Gamer', 'perifericos'),
  (3, 'Moda & Vestuário Geek', 'vestuario'),
  (4, 'Decoração & Setup Gamer', 'decoracao'),
  (5, 'Mangás & Cultura Pop', 'mangas')
ON DUPLICATE KEY UPDATE nome = VALUES(nome);

INSERT INTO usuarios (id, nome_completo, nome_usuario, email, senha_hash, nivel_acesso) VALUES
  (1, 'Daniel Bonilla', 'daniel_bonilla', 'daniel@dabgeek.com.br', '$2y$10$pi.KY.JvcHCEugDgyobgLu0I4s5fpcWvsT9j/1IKI9UlRLbc8CWJO', 'admin'),
  (2, 'Clara Rocha', 'clara_cyber', 'clara.cyber@email.com', '$2y$10$pi.KY.JvcHCEugDgyobgLu0I4s5fpcWvsT9j/1IKI9UlRLbc8CWJO', 'cliente'),
  (3, 'Marcos Silveira', 'marcos_gamer', 'marcos.silveira@email.com', '$2y$10$pi.KY.JvcHCEugDgyobgLu0I4s5fpcWvsT9j/1IKI9UlRLbc8CWJO', 'cliente')
ON DUPLICATE KEY UPDATE nome_completo = VALUES(nome_completo);

INSERT INTO produtos (id, categoria_id, codigo_slug, nome, descricao, preco, estoque, imagem_url, ativo) VALUES
  (1, 1, 'action-figure-samurai', 'Action Figure Samurai Cyberpunk 2077', 'Edição de colecionador pintada à mão, rica em detalhes e luz neon.', 349.90, 15, 'assets/img/img2.jpg', 1),
  (2, 2, 'teclado-mecanico-rgb', 'Teclado Mecânico RGB Hot-Swap Switch Red', 'Switches lineares lubrificados de fábrica e iluminação por tecla personalizável.', 429.90, 28, 'assets/img/img3.jpg', 1),
  (3, 3, 'moletom-cyberpunk', 'Moletom Streetwear Cyberpunk Edição Noturna', 'Tecido premium com capuz amplo, costura reforçada e estampa fosforescente.', 219.90, 40, 'assets/img/img4.jpg', 1),
  (4, 2, 'deskmat-extra-grande', 'Deskmat Gamer Extra Grande 900x400mm', 'Superfície Speed de alta precisão com bordas costuradas e base emborrachada.', 119.90, 50, 'assets/img/img5.jpg', 1),
  (5, 4, 'luminaria-pixel-art', 'Luminária Pixel Art 16-Bit USB', 'Iluminação retrô com modos estáticos e pulsantes para completar seu setup.', 149.90, 22, 'assets/img/img6.jpg', 1),
  (6, 2, 'mouse-gamer-wireless', 'Mouse Gamer Sem Fio Ultraleve 26K DPI', 'Sensor óptico topo de linha, conexão 2.4GHz sem lag e peso de apenas 55g.', 289.90, 35, 'assets/img/img7.jpg', 1),
  (7, 2, 'headset-gamer-71', 'Headset Gamer 7.1 Surround Som Espacial', 'Drivers de 50mm, isolamento acústico passivo e microfone removível cristalino.', 389.90, 18, 'assets/img/img8.jpg', 1),
  (8, 4, 'caneca-termica-pixel', 'Caneca Térmica Pixel Poção de Vida 500ml', 'Inox com parede dupla que mantém bebidas geladas ou quentes por até 8 horas.', 89.90, 60, 'assets/img/img9.jpg', 1),
  (9, 4, 'fita-led-rgb-smart', 'Fita LED RGB Smart Wi-Fi 5 Metros', 'Controle por aplicativo e sincronização com áudio e jogos do seu quarto gamer.', 139.90, 45, 'assets/img/img10.jpg', 1),
  (10, 5, 'box-mangas-colecionador', 'Box de Mangás Edição de Colecionador', 'Caixa rígida exclusiva contendo os 5 primeiros volumes e pôster comemorativo.', 279.90, 20, 'assets/img/img11.jpg', 1),
  (11, 3, 'mochila-gamer-antifurto', 'Mochila Gamer Antifurto Impermeável', 'Compartimento estofado para notebook de até 17 polegadas e saída USB externa.', 249.90, 30, 'assets/img/img12.jpg', 1),
  (12, 2, 'cadeira-gamer-pro', 'Cadeira Gamer Pro Ergonômica 4D', 'Estrutura em aço, almofadas lombar/cervical e reclinação total até 180 graus.', 1299.90, 10, 'assets/img/img13.jpg', 1)
ON DUPLICATE KEY UPDATE nome = VALUES(nome);

INSERT INTO pedidos (id, usuario_id, data_pedido, status, valor_total) VALUES
  (1, 1, '2026-10-14 10:15:00', 'entregue', 1729.80),
  (2, 2, '2026-10-15 14:30:00', 'pago', 799.60),
  (3, 3, '2026-10-16 19:45:00', 'enviado', 919.60)
ON DUPLICATE KEY UPDATE status = VALUES(status);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
  (1, 12, 1, 1299.90),
  (1, 2, 1, 429.90);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
  (2, 10, 2, 279.90),
  (2, 5, 1, 149.90),
  (2, 8, 1, 89.90);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
  (3, 6, 1, 289.90),
  (3, 4, 2, 119.90),
  (3, 7, 1, 389.90);
