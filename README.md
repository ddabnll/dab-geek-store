# ⚡ DAB GEEK STORE — E-Commerce Front-End

[![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/Web/HTML)
[![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/pt-BR/docs/Web/CSS)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/pt-BR/docs/Web/JavaScript)
[![Git](https://img.shields.io/badge/GIT-E44C30?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)

Projeto de interface e arquitetura front-end de uma plataforma de **e-commerce temático de cultura pop, games e periféricos de alta performance**, desenvolvido para fins acadêmicos.

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
3. **Responsividade total (mobile-first a ultra-wide)**;
4. **Interatividade rica sem dependência de frameworks externos** (Vanilla JavaScript).

---

## 📁 Estrutura de Arquivos do Repositório

O projeto mantém rigorosamente a estrutura esperada com todas as páginas e recursos modulares:

```text
dab-geek-store/
├── index.html          # Vitrine principal da loja com hero e arsenal de produtos
├── sobre.html          # História da marca, missão, curadoria e valores
├── contato.html        # Formulário de atendimento com honeypot e canais diretos
├── conta.html          # Central de autenticação com abas de Login e Cadastro
├── dashboard.html      # Painel administrativo de controle de vendas e pedidos
├── perfil.html         # Painel do cliente com XP acumulado, dados e histórico
├── style.css           # Folha de estilos unificada com CSS Variables & Dark Theme
├── script.js           # Lógica do carrinho (localStorage), abas e validações
├── favicon.svg         # Ícone vetorial da marca (gamepad neon)
├── .gitignore          # Arquivos e pastas ignoradas pelo versionamento Git
└── README.md           # Documentação completa do projeto
```

---

## 🛠️ Tecnologias e Boas Práticas Empregadas

### 1. HTML5 Semântico & Acessibilidade (a11y)
* **Estrutura Semântica:** Utilização sistemática de `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>` e `<footer>`.
* **Navegação Acessível:** Link utilitário `"Pular para o conteúdo"` para leitores de tela e usuários de teclado.
* **WAI-ARIA Completo:** Atributos `aria-expanded`, `aria-controls`, `aria-label`, `aria-haspopup`, `aria-selected` e `role="dialog"` na sacola/inventário e nas abas de login.
* **Formulários Acessíveis:** Todos os `<input>` e `<textarea>` possuem `<label>` vinculados via atributos `for`/`id` e atributos de autocomplete modernos (`autocomplete="name"`, `autocomplete="email"`).
* **Anti-Spam Nativo:** Campo honeypot (`.campo-armadilha`) oculto para mitigar bots sem afetar a usabilidade.

### 2. CSS3 Moderno & Design System
* **CSS Custom Properties (`:root`):** Paleta centralizada com tons de grafite profundo (`#0B0E14`), slate escuro, roxo neon (`#8B5CF6`), ciano (`#06B6D4`) e verde esmeralda (`#10B981`).
* **Layouts Flexbox & CSS Grid:** Grades fluidas e responsivas para a vitrine de produtos, métricas do dashboard e tabela de pedidos.
* **Acessibilidade Visual:** Suporte a `@media (prefers-reduced-motion: reduce)` para usuários sensíveis a animações.
* **Microinterações:** Efeitos de hover com elevação suave, sombras neon e foco visível de alto contraste (`:focus-visible`).

### 3. JavaScript Vanilla (Lógica de E-commerce)
* **Inventário / Carrinho Dinâmico:**
  * Adição de produtos via `data-attributes` (`data-produto-id`, `data-produto-nome`, `data-produto-preco`);
  * Persistência de estado local usando `localStorage`;
  * Incremento, decremento e remoção de itens em tempo real;
  * Contador numérico dinâmico no ícone da sacola;
  * Atualização automática do valor total formatado em Reais (`R$`).
* **Sistema de Abas de Autenticação:** Alternância instantânea e acessível entre Login e Cadastro na página `conta.html`.
* **Validação de Formulários Client-Side:** Validação com mensagens customizadas em português e verificação de confirmação de senha.
* **Menu Hambúrguer Responsivo:** Toggle com suporte a fechamento pela tecla `Escape`.

---

## 🚀 Como Executar o Projeto Localmente

Você não precisa de nenhum servidor complexo nem de instalações como Node.js para testar a loja:

### Opção 1: Via VS Code (Recomendado)
1. Abra o **Visual Studio Code**;
2. Vá em `File > Open Folder...` (ou `Arquivo > Abrir Pasta...`) e selecione a pasta `dab-geek-store`;
3. Se tiver a extensão **Live Server** instalada, clique com o botão direito em `index.html` e selecione **"Open with Live Server"**.

### Opção 2: Pelo Navegador
1. Dê um duplo clique diretamente no arquivo `index.html` para abri-lo em qualquer navegador (Chrome, Edge, Firefox, Brave, etc.).

---

## 👨‍💻 Autor

**Daniel de Andrade Bonilla**
* GitHub: [@ddabnll](https://github.com/ddabnll)
* E-mail: [danielbonilla321@gmail.com](mailto:danielbonilla321@gmail.com)
* WhatsApp: (81) 99735-4423

---

*Projeto acadêmico sem fins comerciais. Desenvolvido para a avaliação prática de Programação em Novas Tecnologias II.*
