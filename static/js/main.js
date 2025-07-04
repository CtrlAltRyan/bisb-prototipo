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
// Adiciona UM ÚNICO "escutador" que espera a página carregar
document.addEventListener('DOMContentLoaded', function() {

    // ==========================================================
    // PARTE 1: LÓGICA PARA CONTROLAR O MODAL
    // (Esta parte cuida de abrir e fechar a janelinha)
    // ==========================================================

    // Pega os elementos principais da página
    const modal = document.querySelector(".modal-alvo");
    const btnAdicionar = document.getElementById("btn-adicionar");

    // Adiciona os eventos de clique apenas se o botão e o modal existirem na página atual
    if (modal && btnAdicionar) {
        const spanFechar = modal.querySelector(".fechar-modal");

        // Abrir o modal
        btnAdicionar.onclick = function() {
            modal.style.display = "flex";
        };

        // Fechar no 'X'
        spanFechar.onclick = function() {
            modal.style.display = "none";
        };

        // Fechar clicando fora
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        };

        // Fechar com a tecla 'Esc'
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape' && modal.style.display === "flex") {
                modal.style.display = 'none';
            }
        });
    } // Fim da lógica do modal


    // ==========================================================
    // PARTE 2: LÓGICA GENÉRICA PARA ENVIAR FORMULÁRIOS
    // (Esta parte funciona para Clientes, Serviços, Vendas, etc.)
    // ==========================================================

    // Encontra TODOS os formulários que marcamos com a classe '.form-ajax-submit'
    const formsParaEnviar = document.querySelectorAll('.form-ajax-submit');

    // Adiciona o mesmo "escutador" para cada um dos formulários encontrados
    formsParaEnviar.forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault(); // Impede que a página recarregue

            // Pega a URL do atributo 'data-url' do formulário específico que foi enviado
            const url = form.dataset.url;

            // Coleta TODOS os dados do formulário automaticamente
            const formData = new FormData(form);
            const dadosParaEnviar = Object.fromEntries(formData.entries());

            console.log(`Enviando dados para ${url}:`, dadosParaEnviar);

            // Envia os dados para a URL correta usando fetch
            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(dadosParaEnviar),
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Erro de rede: ${response.status} - ${response.statusText}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Item adicionado com sucesso!');
                    if (modal) { modal.style.display = 'none'; } // Fecha o modal se ele existir
                    location.reload(); // Recarrega a página para mostrar o novo item
                } else {
                    alert('Erro retornado pelo servidor: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Erro na requisição fetch:', error);
                alert('Ocorreu um erro de comunicação com o servidor.');
            });
        });
    }); // Fim da lógica dos formulários

}); // Fim do 'DOMContentLoaded'