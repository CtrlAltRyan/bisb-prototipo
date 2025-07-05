// ==========================================================
// SEÇÃO 1: FUNÇÕES AUXILIARES
// Funções que podem ser usadas em vários lugares.
// ==========================================================

function formatarParaBR(dataISO) {
    if (!dataISO || typeof dataISO !== 'string' || !dataISO.includes('-')) { return dataISO; } // Retorna original se inválido
    const partes = dataISO.split('-');
    if (partes.length !== 3) { return dataISO; }
    const [ano, mes, dia] = partes;
    // Validação simples para evitar erros com datas malformadas
    if (isNaN(new Date(ano, mes - 1, dia))) { return "Data inválida"; }
    return `${dia}/${mes}/${ano}`;
}

function formatarParaISO(dataBR) {
    if (!dataBR || typeof dataBR !== 'string' || !dataBR.includes('/')) { return dataBR; }
    const partes = dataBR.split('/');
    if (partes.length !== 3) { return dataBR; }
    const [dia, mes, ano] = partes;
    if (isNaN(new Date(ano, mes - 1, dia))) { return "Data inválida"; }
    const diaFormatado = String(dia).padStart(2, '0');
    const mesFormatado = String(mes).padStart(2, '0');
    return `${ano}-${mesFormatado}-${diaFormatado}`;
}


// ==========================================================
// SEÇÃO 2: LÓGICA PRINCIPAL DA APLICAÇÃO
// Tudo dentro de um ÚNICO DOMContentLoaded para garantir que o HTML está pronto.
// ==========================================================

document.addEventListener('DOMContentLoaded', function() {

    // --- Lógica para o "Selecionar Todos" do Checkbox ---
    const selectAll = document.getElementById('select-all');
    if (selectAll) {
        const checkboxes = document.querySelectorAll('.row-checkbox');
        selectAll.addEventListener('change', function() {
            checkboxes.forEach(cb => cb.checked = this.checked);
        });
    }

    // --- Lógica para Formatar Datas na Tabela ---
    const celulasDeData = document.querySelectorAll('.data-a-formatar');
    celulasDeData.forEach(function(celula) {
        const dataISO = celula.textContent.trim();
        const dataFormatada = formatarParaBR(dataISO);
        celula.textContent = dataFormatada;
    });

    // --- Lógica para Controle do Modal de Adicionar ---
    const modalAdicionar = document.querySelector(".modal-alvo");
    const btnAdicionar = document.getElementById("btn-adicionar");
    if (modalAdicionar && btnAdicionar) {
        const spanFechar = modalAdicionar.querySelector(".fechar-modal");

        btnAdicionar.onclick = () => { modalAdicionar.style.display = "flex"; };
        if(spanFechar) spanFechar.onclick = () => { modalAdicionar.style.display = "none"; };
        
        window.onclick = (event) => {
            if (event.target == modalAdicionar) {
                modalAdicionar.style.display = "none";
            }
        };
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape' && modalAdicionar.style.display === "flex") {
                modalAdicionar.style.display = 'none';
            }
        });
    }

    // --- Lógica para Envio de Formulários (Adicionar) ---
    const formsParaEnviar = document.querySelectorAll('.form-ajax-submit');
    formsParaEnviar.forEach(form => {
        form.addEventListener('submit', function(event) {
            event.preventDefault();
            const url = form.dataset.url;
            const formData = new FormData(form);
            const dadosParaEnviar = Object.fromEntries(formData.entries());

            fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(dadosParaEnviar),
            })
            .then(response => {
                if (!response.ok) throw new Error(`Erro: ${response.status}`);
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Item adicionado com sucesso!');
                    location.reload();
                } else {
                    alert('Erro: ' + data.message);
                }
            })
            .catch(error => console.error('Erro no fetch de Adicionar:', error));
        });
    });

    // --- Lógica para Excluir Itens ---
    const btnExcluir = document.getElementById("btn-excluir");
    if (btnExcluir) {
        btnExcluir.addEventListener('click', function() {
            const idsParaExcluir = [];
            document.querySelectorAll('.row-checkbox:checked').forEach(checkbox => {
                idsParaExcluir.push(checkbox.dataset.id);
            });

            if (idsParaExcluir.length === 0) {
                alert("Selecione pelo menos um item para excluir.");
                return;
            }

            if (!confirm(`Tem certeza que deseja excluir ${idsParaExcluir.length} item(s)?`)) return;

            const urlExcluir = btnExcluir.dataset.url;
            if (!urlExcluir) {
                alert("Erro de configuração: URL de exclusão não encontrada.");
                return;
            }
            
            fetch(urlExcluir, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ ids: idsParaExcluir }),
            })
            .then(response => {
                if (!response.ok) throw new Error(`Erro: ${response.status}`);
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Item(ns) excluído(s) com sucesso!');
                    location.reload();
                } else {
                    alert('Erro ao excluir: ' + data.message);
                }
            })
            .catch(error => console.error('Erro no fetch de Excluir:', error));
        });
    }

    // --- Lógica para Popovers/Tooltips (deixei por último por ser menos crítico) ---
    document.querySelectorAll('.popover-trigger').forEach(el => {
        let tooltip; // Variável para guardar a referência do tooltip
        el.addEventListener('mouseenter', () => {
            tooltip = document.createElement('div');
            tooltip.className = 'custom-tooltip';
            tooltip.innerText = el.dataset.popover;
            document.body.appendChild(tooltip);

            const rect = el.getBoundingClientRect();
            tooltip.style.left = `${rect.left + window.scrollX}px`;
            tooltip.style.top = `${rect.top + window.scrollY - tooltip.offsetHeight - 10}px`;
        });

        el.addEventListener('mouseleave', () => {
            if (tooltip) tooltip.remove();
        });
    });

}); // Fim do listener principal 'DOMContentLoaded'