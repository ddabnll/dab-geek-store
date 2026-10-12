// DAB GEEK STORE — Interações e Lógica de E-commerce

// 1. Menu Mobile
document.addEventListener("DOMContentLoaded", function () {
  var botao = document.querySelector(".nav-toggle");
  var links = document.querySelector(".nav-links");

  if (!botao || !links) return;

  function fecharMenu() {
    links.classList.remove("aberto");
    botao.setAttribute("aria-expanded", "false");
    botao.setAttribute("aria-label", "Abrir menu");
  }

  function abrirMenu() {
    links.classList.add("aberto");
    botao.setAttribute("aria-expanded", "true");
    botao.setAttribute("aria-label", "Fechar menu");
  }

  botao.addEventListener("click", function () {
    if (links.classList.contains("aberto")) fecharMenu(); else abrirMenu();
  });

  links.querySelectorAll("a").forEach(function (link) {
    link.addEventListener("click", fecharMenu);
  });

  document.addEventListener("keydown", function (evento) {
    if (evento.key === "Escape" && links.classList.contains("aberto")) {
      fecharMenu();
      botao.focus();
    }
  });
});

// 2. Abas de Login e Cadastro (conta.html)
document.addEventListener("DOMContentLoaded", function () {
  var botoesAba = document.querySelectorAll(".aba-botao, .trocar-aba");
  var paineis = {
    entrar: document.getElementById("painel-entrar"),
    cadastro: document.getElementById("painel-cadastro")
  };

  if (!paineis.entrar || !paineis.cadastro) return;

  function ativarAba(nome) {
    Object.keys(paineis).forEach(function (chave) {
      paineis[chave].classList.toggle("oculto", chave !== nome);
    });

    document.querySelectorAll(".aba-botao").forEach(function (botao) {
      var ativo = botao.getAttribute("data-aba") === nome;
      botao.classList.toggle("ativo", ativo);
      botao.setAttribute("aria-selected", ativo ? "true" : "false");
    });
  }

  botoesAba.forEach(function (elemento) {
    elemento.addEventListener("click", function (evento) {
      if (elemento.classList.contains("trocar-aba")) evento.preventDefault();
      ativarAba(elemento.getAttribute("data-aba"));
    });
  });

  if (window.location.hash === "#cadastro") ativarAba("cadastro");
});

// 3. Validação de Formulários
document.addEventListener("DOMContentLoaded", function () {
  var formularios = document.querySelectorAll("form[novalidate]");

  formularios.forEach(function (form) {
    form.addEventListener("submit", function (evento) {
      evento.preventDefault();
      validarFormulario(form);
    });
  });

  function validarFormulario(form) {
    var valido = true;
    var primeiroInvalido = null;

    form.querySelectorAll("[required]").forEach(function (campo) {
      limparErro(campo);

      if (!campo.checkValidity()) {
        valido = false;
        mostrarErro(campo, mensagemErro(campo));
        primeiroInvalido = primeiroInvalido || campo;
      }
    });

    var senha = form.querySelector('input[id$="senha"]:not([id*="confirma"])');
    var confirmacao = form.querySelector('input[id*="confirma-senha"]');

    if (senha && confirmacao && senha.value && confirmacao.value && senha.value !== confirmacao.value) {
      valido = false;
      limparErro(confirmacao);
      mostrarErro(confirmacao, "As senhas não coincidem. Digite novamente.");
      primeiroInvalido = primeiroInvalido || confirmacao;
    }

    if (!valido) {
      primeiroInvalido.focus();
      return;
    }

    mostrarSucesso(form);
    form.reset();
  }

  function mensagemErro(campo) {
    if (campo.validity.valueMissing) return "Preencha este campo antes de continuar.";
    if (campo.validity.typeMismatch && campo.type === "email") return "Digite um endereço de e-mail válido.";
    if (campo.validity.typeMismatch) return "Valor inválido.";
    if (campo.validity.tooShort) {
      var faltam = campo.minLength - campo.value.length;
      return "Faltam " + faltam + (faltam === 1 ? " caractere." : " caracteres.");
    }
    return "Verifique os dados informados.";
  }

  function mostrarErro(campo, texto) {
    var grupo = campo.closest(".campo");
    if (!grupo) return;

    var idErro = (campo.id || "campo") + "-erro";
    grupo.classList.add("campo-invalido");
    campo.setAttribute("aria-invalid", "true");
    campo.setAttribute("aria-describedby", idErro);

    var erro = document.createElement("p");
    erro.className = "erro-campo";
    erro.id = idErro;
    erro.textContent = texto;
    grupo.appendChild(erro);
  }

  function limparErro(campo) {
    var grupo = campo.closest(".campo");
    if (!grupo) return;

    grupo.classList.remove("campo-invalido");
    campo.removeAttribute("aria-invalid");
    campo.removeAttribute("aria-describedby");

    var existente = grupo.querySelector(".erro-campo");
    if (existente) existente.remove();
  }

  function mostrarSucesso(form) {
    var existente = form.querySelector(".aviso-sucesso");
    if (existente) existente.remove();
    var aviso = document.createElement("p");
    aviso.className = "aviso-sucesso";
    aviso.setAttribute("role", "status");
    aviso.textContent = "✓ Ação processada com sucesso! (Protótipo do projeto DAB GEEK STORE).";
    form.insertBefore(aviso, form.firstChild);
  }
});

// 4. Sacola de Compras / Inventário (E-commerce)
document.addEventListener("DOMContentLoaded", function () {
  var CHAVE_CARRINHO = "dab-geek-carrinho";

  var botaoCarrinho = document.getElementById("botao-carrinho");
  var painelCarrinho = document.getElementById("painel-carrinho");
  var fundoCarrinho = document.getElementById("fundo-carrinho");
  var fecharCarrinhoBtn = document.getElementById("fechar-carrinho");
  var listaCarrinho = document.getElementById("lista-carrinho");
  var totalCarrinho = document.getElementById("total-carrinho");
  var contagemCarrinho = document.getElementById("contagem-carrinho");
  var finalizarCarrinho = document.getElementById("finalizar-carrinho");
  var carrinhoRodape = document.querySelector(".carrinho-rodape");

  if (!painelCarrinho) return;

  function mostrarAvisoCarrinhoVazio() {
    if (!carrinhoRodape) return;
    limparAvisoCarrinhoVazio();

    var aviso = document.createElement("p");
    aviso.className = "aviso-erro";
    aviso.style.display = "block";
    aviso.setAttribute("role", "alert");
    aviso.textContent = "Seu inventário está vazio. Escolha um item da loja!";
    carrinhoRodape.insertBefore(aviso, carrinhoRodape.firstChild);
  }

  function limparAvisoCarrinhoVazio() {
    if (!carrinhoRodape) return;
    var existente = carrinhoRodape.querySelector(".aviso-erro");
    if (existente) existente.remove();
  }

  function lerCarrinho() {
    try {
      var dados = localStorage.getItem(CHAVE_CARRINHO);
      return dados ? JSON.parse(dados) : [];
    } catch (erro) {
      return [];
    }
  }

  function salvarCarrinho(itens) {
    try {
      localStorage.setItem(CHAVE_CARRINHO, JSON.stringify(itens));
    } catch (erro) {
      // Ignora erro em caso de restrição de storage
    }
    limparAvisoCarrinhoVazio();
    renderizarCarrinho();
  }

  function formatarPreco(valor) {
    return valor.toLocaleString("pt-BR", { style: "currency", currency: "BRL" });
  }

  function adicionarItem(id, nome, preco) {
    var itens = lerCarrinho();
    var existente = itens.find(function (item) { return item.id === id; });

    if (existente) {
      existente.quantidade += 1;
    } else {
      itens.push({ id: id, nome: nome, preco: preco, quantidade: 1 });
    }

    salvarCarrinho(itens);
  }

  function alterarQuantidade(id, delta) {
    var itens = lerCarrinho();
    var item = itens.find(function (i) { return i.id === id; });
    if (!item) return;

    item.quantidade += delta;
    if (item.quantidade <= 0) {
      itens = itens.filter(function (i) { return i.id !== id; });
    }
    salvarCarrinho(itens);
  }

  function removerItem(id) {
    var itens = lerCarrinho().filter(function (i) { return i.id !== id; });
    salvarCarrinho(itens);
  }

  function renderizarCarrinho() {
    var itens = lerCarrinho();
    var totalItens = itens.reduce(function (soma, i) { return soma + i.quantidade; }, 0);
    var totalPreco = itens.reduce(function (soma, i) { return soma + i.quantidade * i.preco; }, 0);

    if (contagemCarrinho) {
      contagemCarrinho.textContent = totalItens;
      contagemCarrinho.hidden = totalItens === 0;
    }
    if (botaoCarrinho) {
      var rotulo = totalItens === 1 ? " item" : " itens";
      botaoCarrinho.setAttribute("aria-label", "Abrir inventário, " + totalItens + rotulo);
    }

    if (!listaCarrinho) return;

    if (itens.length === 0) {
      listaCarrinho.innerHTML = '<p class="carrinho-vazio">Seu inventário está vazio.<br><a href="index.html#vitrine">Explorar arsenal da loja</a></p>';
    } else {
      listaCarrinho.innerHTML = itens.map(function (item) {
        return (
          '<div class="carrinho-item" data-id="' + item.id + '">' +
            '<div class="carrinho-item-info">' +
              '<p class="carrinho-item-nome">' + item.nome + '</p>' +
              '<p class="carrinho-item-preco">' + formatarPreco(item.preco) + '</p>' +
            '</div>' +
            '<div class="carrinho-item-controles">' +
              '<button type="button" class="carrinho-qtd-btn" data-acao="diminuir" aria-label="Diminuir quantidade de ' + item.nome + '">&minus;</button>' +
              '<span class="carrinho-qtd-valor">' + item.quantidade + '</span>' +
              '<button type="button" class="carrinho-qtd-btn" data-acao="aumentar" aria-label="Aumentar quantidade de ' + item.nome + '">&plus;</button>' +
              '<button type="button" class="carrinho-remover" aria-label="Remover ' + item.nome + ' do inventário">Remover</button>' +
            '</div>' +
          '</div>'
        );
      }).join("");
    }

    if (totalCarrinho) totalCarrinho.textContent = formatarPreco(totalPreco);
  }

  // Efeito de feedback nos botões dos produtos
  document.querySelectorAll(".card-produto button").forEach(function (botao) {
    var textoOriginal = botao.textContent;
    var timer = null;

    botao.addEventListener("click", function () {
      clearTimeout(timer);
      botao.textContent = "Adicionado ✓";
      botao.classList.add("confirmado");
      timer = setTimeout(function () {
        botao.textContent = textoOriginal;
        botao.classList.remove("confirmado");
      }, 1600);
    });
  });

  document.querySelectorAll("[data-produto-id]").forEach(function (botao) {
    botao.addEventListener("click", function () {
      var id = botao.getAttribute("data-produto-id");
      var nome = botao.getAttribute("data-produto-nome");
      var preco = parseFloat(botao.getAttribute("data-produto-preco"));
      adicionarItem(id, nome, preco);
    });
  });

  if (listaCarrinho) {
    listaCarrinho.addEventListener("click", function (evento) {
      var botao = evento.target.closest("button");
      if (!botao) return;
      var linha = botao.closest(".carrinho-item");
      if (!linha) return;
      var id = linha.getAttribute("data-id");

      if (botao.classList.contains("carrinho-remover")) {
        removerItem(id);
      } else if (botao.dataset.acao === "aumentar") {
        alterarQuantidade(id, 1);
      } else if (botao.dataset.acao === "diminuir") {
        alterarQuantidade(id, -1);
      }
    });
  }

  function abrirCarrinho() {
    painelCarrinho.hidden = false;
    fundoCarrinho.hidden = false;
    botaoCarrinho.setAttribute("aria-expanded", "true");
    fecharCarrinhoBtn.focus();
  }

  function fecharCarrinho() {
    painelCarrinho.hidden = true;
    fundoCarrinho.hidden = true;
    botaoCarrinho.setAttribute("aria-expanded", "false");
    botaoCarrinho.focus();
    limparAvisoCarrinhoVazio();
  }

  if (botaoCarrinho) botaoCarrinho.addEventListener("click", abrirCarrinho);
  if (fecharCarrinhoBtn) fecharCarrinhoBtn.addEventListener("click", fecharCarrinho);
  if (fundoCarrinho) fundoCarrinho.addEventListener("click", fecharCarrinho);

  document.addEventListener("keydown", function (evento) {
    if (evento.key === "Escape" && !painelCarrinho.hidden) {
      fecharCarrinho();
    }
  });

  if (finalizarCarrinho) {
    finalizarCarrinho.addEventListener("click", function () {
      if (lerCarrinho().length === 0) {
        mostrarAvisoCarrinhoVazio();
        return;
      }
      alert("Pedido finalizado com sucesso! Obrigado por comprar na DAB GEEK STORE.");
      salvarCarrinho([]);
      fecharCarrinho();
    });
  }

  renderizarCarrinho();
});
