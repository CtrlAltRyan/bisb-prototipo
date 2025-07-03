document.addEventListener('DOMContentLoaded', function () {
    const selectAll = document.getElementById('select-all');
    const checkboxes = document.querySelectorAll('.row-checkbox');

    if (selectAll) {
        selectAll.addEventListener('change', function () {
            checkboxes.forEach(cb => cb.checked = this.checked);
        });
    }
});

document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.popover-trigger').forEach(el => {
        el.addEventListener('mouseenter', () => {
            const tooltip = document.createElement('div');
            tooltip.className = 'custom-tooltip';
            tooltip.innerText = el.dataset.popover;
            document.body.appendChild(tooltip);

            const rect = el.getBoundingClientRect();
            tooltip.style.left = rect.left + 'px';
            tooltip.style.top = (rect.top - tooltip.offsetHeight - 10) + 'px';
        });

        el.addEventListener('mouseleave', () => {
            const tooltip = document.querySelector('.custom-tooltip');
            if (tooltip) tooltip.remove();
        });
    });
});

 function formatarParaBR(dataISO) {
      if (!dataISO || typeof dataISO !== 'string') { return "Entrada inválida"; }
      const partes = dataISO.split('-');
      if (partes.length !== 3) { return "Formato inválido"; }
      const [ano, mes, dia] = partes;
      const dataObj = new Date(ano, mes - 1, dia);
      if (dataObj.getFullYear() != ano || dataObj.getMonth() + 1 != mes || dataObj.getDate() != dia) { return "Data inválida"; }
      return `${dia}/${mes}/${ano}`;
    }

    function formatarParaISO(dataBR) {
      if (!dataBR || typeof dataBR !== 'string') { return "Entrada inválida"; }
      const partes = dataBR.split('/');
      if (partes.length !== 3) { return "Formato inválido"; }
      const [dia, mes, ano] = partes;
      const dataObj = new Date(ano, mes - 1, dia);
      if (dataObj.getFullYear() != ano || dataObj.getMonth() + 1 != mes || dataObj.getDate() != dia) { return "Data inválida"; }
      const diaFormatado = String(dia).padStart(2, '0');
      const mesFormatado = String(mes).padStart(2, '0');
      return `${ano}-${mesFormatado}-${diaFormatado}`;
    }

    document.addEventListener('DOMContentLoaded', function() {
  // Este código vai procurar pela classe '.data-a-formatar'
  const celulasDeData = document.querySelectorAll('.data-a-formatar');

  celulasDeData.forEach(function(celula) {
    const dataISO = celula.textContent.trim();
    const dataFormatada = formatarParaBR(dataISO);
    if (dataFormatada && dataFormatada.includes('/')) {
        celula.textContent = dataFormatada;
    }
  });

});

// Espera a página carregar completamente
document.addEventListener('DOMContentLoaded', function() {

  // Pega os elementos do HTML
  const modal = document.getElementById("modal-adicionar");
  const btnAdicionar = document.getElementById("btn-adicionar");
  const spanFechar = document.querySelector(".fechar-modal");

  // Quando o usuário clicar no botão "Adicionar", abre o modal
  btnAdicionar.onclick = function() {
    // Muda o display de 'none' para 'flex' para exibir e centralizar o modal
    modal.style.display = "flex"; 
  }

  // Quando o usuário clicar no (X) para fechar
  spanFechar.onclick = function() {
    modal.style.display = "none";
  }

  // Quando o usuário clicar fora do conteúdo do modal, também fecha
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
  
  // Opcional: Fechar com a tecla 'Esc'
  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' && modal.style.display === "flex") {
        modal.style.display = 'none';
    }
  });

});

// Arquivo: layout_painel.html (ou seu .js externo)

document.addEventListener('DOMContentLoaded', function() {
  
  // O botão de adicionar continua o mesmo
  const btnAdicionar = document.getElementById("btn-adicionar");
  
  // AGORA PROCURAMOS PELA CLASSE '.modal-alvo'
  const modal = document.querySelector(".modal-alvo"); 

  // Se não existir um botão ou um modal na página, o código não quebra
  if (!modal || !btnAdicionar) {
    return;
  }

  // O seletor do botão de fechar também deve ser genérico
  const spanFechar = modal.querySelector(".fechar-modal");

  // O resto do código funciona exatamente igual!
  btnAdicionar.onclick = function() {
    modal.style.display = "flex"; 
  }

  spanFechar.onclick = function() {
    modal.style.display = "none";
  }

  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
  
  document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' && modal.style.display === "flex") {
        modal.style.display = 'none';
    }
  });

});

const formAdicionarCliente = document.getElementById("form-adicionar-cliente");

if (formAdicionarCliente) {
  formAdicionarCliente.addEventListener('submit', function(event) {
    event.preventDefault(); // Impede o recarregamento

    console.log("Formulário enviado! O JavaScript está escutando.");

    // Pega os dados e cria o "pacote" JSON
    const dadosCliente = {
      nome: document.getElementById('nome-cliente').value,
      telefone: document.getElementById('telefone-cliente').value,
      email: document.getElementById('email-cliente').value,
      dob: document.getElementById('dob-cliente').value,
      bairro: document.getElementById('bairro-cliente').value
    };

    // Envia o pacote para o servidor (ver Passo 3)
    fetch('/clientes/adicionar', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(dadosCliente),
    })
    .then(response => response.json())
    .then(data => {
        // Processa a resposta do servidor (ver Passo 7)
        if (data.success) {
            alert('Cliente adicionado!');
            location.reload();
        } else {
            alert('Erro: ' + data.message);
        }
    });
  });
}

document.addEventListener('DOMContentLoaded', function() {

    // --- PONTOS DE CHECAGEM INICIAL (Para Depuração) ---
    // Use estes console.log para ter certeza que o JS está encontrando os elementos do HTML.
    // Se algum deles mostrar 'null' no console (F12), o 'id' no HTML está diferente do que está aqui.
    console.log("Formulário encontrado:", document.getElementById("form-adicionar-cliente"));
    console.log("Botão 'Adicionar' encontrado:", document.getElementById("btn-adicionar"));


    // --- SEÇÃO DE CONTROLE DO MODAL ---

    // Pega os elementos principais da página pelo seu ID ou classe
    const modal = document.querySelector(".modal-alvo");
    const btnAdicionar = document.getElementById("btn-adicionar");
    
    // Se não houver um modal ou um botão "Adicionar" nesta página, o script para aqui para não dar erro.
    if (!modal || !btnAdicionar) {
        return;
    }
    
    const spanFechar = modal.querySelector(".fechar-modal");
    const formAdicionarCliente = document.getElementById("form-adicionar-cliente");

    // Lógica para ABRIR o modal ao clicar em "Adicionar"
    btnAdicionar.onclick = function() {
        modal.style.display = "flex";
    }

    // Lógica para FECHAR o modal ao clicar no 'X'
    spanFechar.onclick = function() {
        modal.style.display = "none";
    }

    // Lógica para FECHAR o modal ao clicar fora da caixa de conteúdo
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // Lógica para FECHAR o modal com a tecla 'Esc'
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape' && modal.style.display === "flex") {
            modal.style.display = 'none';
        }
    });


    // --- SEÇÃO DE ENVIO DO FORMULÁRIO ---

    // Adiciona o "escutador" ao formulário de adicionar cliente
    if (formAdicionarCliente) {
        formAdicionarCliente.addEventListener('submit', function(event) {
            
            // 1. Linha CRUCIAL: Impede que o formulário recarregue a página.
            // Se a página recarrega e você vê os dados na URL, essa linha não está sendo executada.
            event.preventDefault();

            console.log("Formulário enviado! O JavaScript está interceptando o envio.");

            // 2. Coleta os dados dos inputs do formulário
            const dadosCliente = {
                nome: document.getElementById('nome-cliente').value,
                telefone: document.getElementById('telefone-cliente').value,
                email: document.getElementById('email-cliente').value,
                dob: document.getElementById('dob-cliente').value,
                bairro: document.getElementById('bairro-cliente').value
            };
            
            console.log("Dados que serão enviados para o servidor:", dadosCliente);

            // 3. Envia os dados para o backend usando a API Fetch
            fetch('/clientes/adicionar', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(dadosCliente),
            })
            .then(response => {
                // Se a resposta não for OK (ex: erro 500, 404), o .json() pode falhar.
                if (!response.ok) {
                    // Lança um erro para ser pego pelo .catch()
                    throw new Error(`Erro de rede: ${response.status} - ${response.statusText}`);
                }
                return response.json();
            })
            .then(data => {
                // 4. Processa a resposta de SUCESSO vinda do servidor
                if (data.success) {
                    alert('Cliente adicionado com sucesso!');
                    modal.style.display = 'none'; // Fecha o modal
                    location.reload(); // Recarrega a página para mostrar o novo cliente
                } else {
                    alert('Erro retornado pelo servidor: ' + data.message);
                }
            })
            .catch(error => {
                // 5. Processa erros de COMUNICAÇÃO (ex: servidor offline, erro de rede, erro 404/500)
                console.error('Erro na requisição fetch:', error);
                alert('Ocorreu um erro de comunicação com o servidor. Verifique o console (F12) e o terminal do Flask.');
            });
        });
    }
});