# ⚡ DAB GEEK STORE — E-Commerce Full-Stack

[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/Web/HTML)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/Web/CSS)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript)
[![PHP](https://img.shields.io/badge/PHP-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net/)
[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Git](https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)

Projeto de interface e arquitetura de um **e-commerce temático de cultura pop, games e periféricos de alta performance**, integrando front-end dinâmico e camada de persistência com banco de dados relacional, desenvolvido para fins acadêmicos.

---

## 🎓 Contexto Acadêmico

* **Instituição:** ETE Porto Digital (Escola Técnica Estadual Porto Digital)
* **Curso:** Técnico em Desenvolvimento de Software
* **Disciplina:** Programação em Novas Tecnologias II
* **Aluno / Desenvolvedor:** Daniel de Andrade Bonilla
* **Localização:** Recife — PE
* **Ano:** 2026

---

## 🌌 Sobre o Projeto: DAB GEEK STORE

A **DAB GEEK STORE** é um e-commerce especializado na venda de action figures oficiais, periféricos gamer customizados (teclados mecânicos, mouses ultraleves), luminárias pixel art, deskmats e vestuário geek exclusivo.

O projeto foi construído priorizando:
1. **Semântica HTML5 estrita e acessibilidade WAI-ARIA**;
2. **Estética Cyberpunk / Dark Gamer de alto impacto visual**;
3. **Responsividade total (mobile-first a telas ultra-wide)**;
4. **Interatividade rica sem dependência de bibliotecas externas** (Vanilla JavaScript);
5. **Persistência de dados relacional em MySQL com camada de integração em PHP (PDO)**.

---

## 📁 Estrutura de Arquivos do Repositório

O projeto é estruturado de forma modular, separando recursos estáticos, páginas, rotinas de banco de dados e scripts de backend:

```text
dab-geek-store/
├── assets/
│   └── img/                 # Imagens locais dos 12 produtos e hero banner (img1.jpg a img13.jpg)
├── backend/
│   ├── config.php           # Credenciais e constantes de conexão do banco
│   ├── conexao.php          # Instância PDO segura com tratamento de exceções
│   ├── setup_banco.php      # Script de execução automática do schema e seed
│   └── consulta_compras.php # Interface web da consulta relacional de pedidos
├── database/
│   ├── schema.sql           # DDL de criação do banco e das 5 tabelas relacionais
│   ├── seed.sql             # DML de povoamento (categorias, produtos, usuários e pedidos)
│   └── queries.sql          # Consultas SQL (relatórios com INNER JOIN e agrupamentos)
├── index.html               # Vitrine principal da loja com hero e catálogo
├── sobre.html               # História da marca, missão e curadoria
├── contato.html             # Formulário de atendimento com validação e honeypot
├── conta.html               # Central de autenticação com abas de Login e Cadastro
├── dashboard.html           # Painel administrativo de métricas e pedidos
├── perfil.html              # Painel do cliente com dados e histórico de compras
├── style.css                # Folha de estilos unificada com variáveis CSS e tema escuro
├── script.js                # Lógica do carrinho (localStorage), abas e validações
├── favicon.svg              # Ícone vetorial da marca
├── .gitignore               # Arquivos e pastas ignoradas pelo Git
└── README.md                # Documentação do projeto
```

---

## 🛠️ Tecnologias e Boas Práticas Empregadas

### 1. HTML5 Semântico & Acessibilidade (a11y)
* **Estrutura Semântica:** Utilização de `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>` e `<footer>`.
* **Navegação Acessível:** Link utilitário `"Pular para o conteúdo"` para leitores de tela e usuários de teclado.
* **WAI-ARIA:** Atributos `aria-expanded`, `aria-controls`, `aria-label`, `aria-haspopup`, `aria-selected` e `role="dialog"` no carrinho/inventário e nas abas de login.
* **Formulários:** Elementos `<input>` e `<textarea>` com `<label>` devidamente vinculados por `for`/`id` e atributos de autocomplete (`autocomplete="name"`, `autocomplete="email"`).
* **Anti-Spam:** Campo honeypot (`.campo-armadilha`) oculto para mitigar submissões automatizadas sem comprometer a usabilidade.

### 2. CSS3 & Design System
* **CSS Custom Properties (`:root`):** Paleta centralizada com tons de grafite escuro (`#0B0E14`), slate, roxo neon (`#8B5CF6`), ciano (`#06B6D4`) e verde esmeralda (`#10B981`).
* **Flexbox & CSS Grid:** Grades responsivas para a vitrine de produtos, métricas do dashboard e tabelas de pedidos.
* **Imagens em Cards:** Enquadramento com `object-fit: contain` e alinhamento flexbox, evitando cortes e distorções nos produtos.
* **Acessibilidade Visual:** Suporte a `@media (prefers-reduced-motion: reduce)` e foco visível de alto contraste (`:focus-visible`).

### 3. JavaScript Vanilla
* **Carrinho / Inventário:**
  * Adição de itens via `data-attributes` (`data-produto-id`, `data-produto-nome`, `data-produto-preco`);
  * Persistência de estado local com `localStorage`;
  * Incremento, decremento e exclusão de itens com feedback visual dinâmico;
  * Atualização automática da quantidade total e valores em Reais (`R$`).
* **Abas de Autenticação:** Alternância entre Login e Cadastro na página `conta.html`.
* **Validação Client-Side:** Validação de formato de e-mail, preenchimento obrigatório e conferência de senhas em tempo real.
* **Menu Mobile:** Toggle acessível para dispositivos móveis com fechamento via tecla `Escape`.

### 4. Banco de Dados Relacional & Back-End (PHP / MySQL)
* **Modelagem Relacional (MySQL / MariaDB):**
  * Banco de dados `dab_geek_store` em `utf8mb4_unicode_ci`;
  * Estrutura normalizada com 5 tabelas: `usuarios`, `categorias`, `produtos`, `pedidos` e `itens_pedido`;
  * Integridade referencial com chaves primárias e estrangeiras (`FOREIGN KEY`, `ON DELETE RESTRICT` e `ON DELETE CASCADE`).
* **Segurança e Criptografia:**
  * Senhas de usuários armazenadas com hash gerado pelo algoritmo `BCRYPT`.
* **Camada de Conexão (PHP PDO):**
  * Conexão via classe `PDO` com tratamento de exceções ativado (`PDO::ERRMODE_EXCEPTION`) e emulação de prepared statements desativada, prevenindo injeções de SQL.
* **Consultas Relacionais com JOIN:**
  * Consultas parametrizadas relacionando `usuarios`, `pedidos`, `itens_pedido` e `produtos`, possibilitando relatórios detalhados de compras (usuário $\times$ produto $\times$ quantidade).

---

## 🚀 Como Executar o Projeto Localmente

### Opção 1: Executando com XAMPP (Front-End + Back-End completo)
1. Instale e abra o **XAMPP Control Panel**;
2. Inicie os módulos **Apache** e **MySQL**;
3. Mantenha os arquivos do projeto na pasta `htdocs` (ex.: `C:\xampp\htdocs\dab-geek-store`) ou crie uma junção simbólica;
4. Para criar o banco e inserir os dados de teste automaticamente, acesse pelo navegador:
   ```text
   http://localhost/dab-geek-store/backend/setup_banco.php
   ```
5. Acesse as páginas da aplicação:
   * **Vitrine da Loja:** `http://localhost/dab-geek-store/index.html`
   * **Consulta de Compras:** `http://localhost/dab-geek-store/backend/consulta_compras.php`
   * **Gerenciador phpMyAdmin:** `http://localhost/phpmyadmin` *(banco `dab_geek_store`)*

### Opção 2: Apenas Front-End (Sem Banco de Dados)
Se desejar apenas visualizar a interface visual e testar as interações de tela:
* **Pelo VS Code:** Abra a pasta no VS Code e utilize a extensão **Live Server** a partir do arquivo `index.html`.
* **Direto no Navegador:** Dê um duplo clique no arquivo `index.html`.

---

## 👨‍💻 Autor

**Daniel de Andrade Bonilla**
* GitHub: [@ddabnll](https://github.com/ddabnll)
* E-mail: [danielbonilla321@gmail.com](mailto:danielbonilla321@gmail.com)
* WhatsApp: (81) 99735-4423

---

*Projeto acadêmico sem fins comerciais. Desenvolvido para a avaliação prática de Programação em Novas Tecnologias II.*
