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

    // --- Lógica para Controle de Todos os Modais (Adicionar/Editar) ---
function setupModal(modal) {
    if (!modal) return;

    // Fecha ao clicar no "X"
    const closeBtn = modal.querySelector(".fechar-modal");
    if (closeBtn) {
        closeBtn.onclick = () => (modal.style.display = "none");
    }

    // Fecha ao clicar fora do modal
    modal.addEventListener("click", (event) => {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
}

// Configura o modal de adicionar
const modalAdicionar = document.querySelector(".modal-alvo");
const btnAdicionar = document.getElementById("btn-adicionar");
if (modalAdicionar && btnAdicionar) {
    btnAdicionar.onclick = () => (modalAdicionar.style.display = "flex");
    setupModal(modalAdicionar); // Aplica as regras de fechamento
}

// Configura os modais de edição (adicione todos os IDs usados)
const modalsEditar = [
    "#modal-editar-venda",
    "#modal-editar-cliente",
    "#modal-editar-servico"
];
modalsEditar.forEach(id => {
    const modal = document.querySelector(id);
    if (modal) setupModal(modal);
});

// Fecha qualquer modal aberto ao pressionar ESC
document.addEventListener("keydown", (event) => {
    if (event.key === "Escape") {
        document.querySelectorAll(".modal-alvo, #modal-editar-venda, #modal-editar-cliente, #modal-editar-servico")
            .forEach(modal => {
                if (modal.style.display === "flex") {
                    modal.style.display = "none";
                }
            });
    }
});

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
    btnExcluir.addEventListener('click', function () {
        const idsParaExcluir = [];
        document.querySelectorAll('.row-checkbox:checked').forEach(checkbox => {
            idsParaExcluir.push(checkbox.dataset.id);
        });

        if (idsParaExcluir.length === 0) {
            alert("Selecione pelo menos um item para excluir.");
            return;
        }

        if (!confirm(`Tem certeza que deseja excluir ${idsParaExcluir.length} item(s)?`)) return;

        // Detecta a URL de exclusão automaticamente com base no caminho atual
        let urlExcluir;
        if (window.location.pathname.includes("/customers")) {
            urlExcluir = "/clientes/excluir";
        } else if (window.location.pathname.includes("/sales")) {
            urlExcluir = "/vendas/excluir";
        } else if (window.location.pathname.includes("/services")) {
            urlExcluir = "/servicos/excluir";
        } else {
            alert("Página desconhecida: não foi possível determinar a URL de exclusão.");
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
// DENTRO DO SEU 'DOMContentLoaded' EM main.js

// Este código deve estar DENTRO do seu listener principal 'DOMContentLoaded'

const btnEditar = document.getElementById('btn-editar');
if (btnEditar) {
    btnEditar.addEventListener('click', () => {
        const selecionados = document.querySelectorAll('.row-checkbox:checked');

        if (selecionados.length !== 1) {
            alert('Selecione exatamente um item para editar.');
            return;
        }

        const checkbox = selecionados[0];
        const idItem = checkbox.dataset.id;
        const linha = checkbox.closest('tr');
        const path = window.location.pathname;

        // Variáveis que serão definidas dinamicamente
        let modalId = '';
        let formId = '';
        let urlEditar = '';

        // --- Lógica para definir as variáveis baseado na página atual ---

        if (path.includes('/sales')) {
            modalId = 'modal-editar-venda';
            formId = 'editSaleForm';
            urlEditar = '/vendas/editar';
            
            // Preenche o formulário de vendas
            document.getElementById('edit-id-venda').value = idItem;
            document.getElementById('edit-id-cliente').value = linha.dataset.idCliente || '';
            document.getElementById('edit-id-servico').value = linha.dataset.idServico || '';
            document.getElementById('edit-valor').value = linha.dataset.valor || '';
            document.getElementById('edit-forma-pagamento').value = linha.dataset.formaPagamento || '';
            document.getElementById('edit-data-venda').value = formatarParaISO(linha.dataset.dataVenda || '');

        } else if (path.includes('/customers')) {
            modalId = 'modal-editar-cliente'; // OK
            formId = 'editCustomerForm';      // OK
            urlEditar = '/clientes/editar';   // OK

            // Preenche o formulário usando os IDs que definimos
            document.getElementById('edit-id-cliente').value = idItem;
            document.getElementById('edit-nome-cliente').value = linha.dataset.nome || '';
            document.getElementById('edit-email-cliente').value = linha.dataset.email || '';
            document.getElementById('edit-telefone-cliente').value = linha.dataset.telefone || '';
            document.getElementById('edit-dob-cliente').value = formatarParaISO(linha.dataset.dob || '');
            document.getElementById('edit-bairro-cliente').value = linha.dataset.bairro || '';

        } else if (path.includes('/services')) {
            modalId = 'modal-editar-servico';
            formId = 'editServiceForm';        // <-- CORRIGIDO: formId definido
            urlEditar = '/servicos/editar';

            // Preenche o modal de serviço (usando os nomes que padronizamos)
            document.getElementById('edit-id-servico').value = idItem;
            document.getElementById('edit-nome-servico').value = linha.dataset.nome || '';
            document.getElementById('edit-valor-servico').value = linha.dataset.valor || ''; // <-- CORRIGIDO: 'valor' ao invés de 'preco'
        
        } else {
            alert('Página desconhecida para editar.');
            return;
        }
        
        // --- Lógica comum que usa as variáveis definidas acima ---

        const modal = document.getElementById(modalId);
        if (!modal) {
            alert(`Erro: Modal com ID #${modalId} não encontrado no HTML.`);
            return;
        }

        const formEditar = document.getElementById(formId);
        if (!formEditar) {
            alert(`Erro: Formulário com ID #${formId} não encontrado no modal.`);
            return;
        }

        // Remove listener antigo para evitar múltiplos envios
        const novoForm = formEditar.cloneNode(true);
        formEditar.parentNode.replaceChild(novoForm, formEditar);
        
        // Exibe o modal
        modal.style.display = 'flex';
        
        // Adiciona o listener de submit ao novo formulário
        novoForm.addEventListener('submit', (e) => {
            e.preventDefault();

            const formData = new FormData(novoForm);
            const dadosParaEnviar = Object.fromEntries(formData.entries());

            // CORRIGIDO: Usa a variável urlEditar, que muda dependendo da página
            fetch(urlEditar, { 
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(dadosParaEnviar),
            })
            .then(res => {
                if (!res.ok) throw new Error(`Erro na resposta do servidor: ${res.status}`);
                return res.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Item atualizado com sucesso!');
                    location.reload();
                } else {
                    alert('Erro ao atualizar: ' + (data.message || 'Erro desconhecido.'));
                }
            })
            .catch(err => {
                console.error(`Erro no fetch para ${urlEditar}:`, err);
                alert('Ocorreu um erro na requisição de edição. Veja o console.');
            });
        });
    });
}
}); // Fim do listener principal 'DOMContentLoaded'



fetch('/dashboard/api/vendasservico')  // grafico 
.then(response => response.json())
.then(data => {
    const labels = data.vendas_por_servico.labels;
    const servicos = data.vendas_por_servico.data;

    const qtdVendas = servicos.map(item => item.qtd);
    const valores = servicos.map(item => parseFloat(item.valor));

    const ctx = document.getElementById('graficoVendasPorServico').getContext('2d');

    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                label: 'Vendas por Serviço',
                data: qtdVendas,
                backgroundColor: 'rgba(75, 192, 192, 0.7)', // Cor das barras
                borderColor: 'rgba(75, 192, 192, 1)',       // Cor da borda
                borderWidth: 1,                             // Espessura da borda
                borderRadius: 0                           // Arredondamento das barras
            }]
        },
        options: {
            responsive: true, // Ajusta ao tamanho do container, mas respeita o width/height do <canvas> se fixado
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const index = context.dataIndex;
                            const qtd = qtdVendas[index];
                            const valor = valores[index];
                            return [
                                `Vendas: ${qtd}`,
                                `Valor total: R$ ${valor.toLocaleString('pt-BR', {
                                    minimumFractionDigits: 2,
                                    maximumFractionDigits: 2
                                })}`
                            ];
                        }
                    }
                },
                title: {
                    display: true,
                    text: 'Top 5 Serviços Vendidos',
                    font: {
                        size: 18 // AQUI você altera o tamanho do título do gráfico
                    }
                },
                legend: {
                    display: false // Você pode colocar true se quiser mostrar a legenda
                }
            },
            scales: {
                
                x: {
                    grid: {
        display: false 
      },
                    title: {
                        display: true,
                        text: 'Serviços',
                        font: {
                            size: 14 // Tamanho do texto no eixo X
                        }
                    },
                    ticks: {
                        font: {
                            size: 12 // Tamanho dos rótulos das categorias
                        }
                    }
                },
                y: {
                    grid: {
        display: false 
      },
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Quantidade de Vendas',
                        font: {
                            size: 14 // Tamanho do texto do eixo Y
                        }
                    },
                    ticks: {
                        font: {
                            size: 12 // Tamanho dos valores numéricos no eixo Y
                        }
                    }
                }
            }
        }
    });
})
.catch(error => {
    console.error('Erro ao carregar os dados dos gráficos:', error);
});


fetch('/dashboard/api/vendasmes')  // grafico
.then(response => response.json())
.then(data => {
    const labels = data.fluxo_por_mes.labels;
    const servicos = data.fluxo_por_mes.data;

    const qtdVendas = servicos.map(item => item.qtd);
    const valores = servicos.map(item => parseFloat(item.valor));

    const ctx = document.getElementById('graficoVendasPorMes').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Vendas por Mês',
                data: qtdVendas,
                backgroundColor: 'rgba(75, 192, 192, 0.7)', // Cor das barras
                borderColor: 'rgba(75, 192, 192, 1)',       // Cor da borda
                borderWidth: 1,                             // Espessura da borda
                borderRadius: 5                             // Arredondamento das barras
            }]
        },
        options: {
            responsive: true, // Ajusta ao tamanho do container, mas respeita o width/height do <canvas> se fixado
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const index = context.dataIndex;
                            const qtd = qtdVendas[index];
                            const valor = valores[index];
                            return [
                                `Vendas: ${qtd}`,
                                `Valor total: R$ ${valor.toLocaleString('pt-BR', {
                                    minimumFractionDigits: 2,
                                    maximumFractionDigits: 2
                                })}`
                            ];
                        }
                    }
                },
                title: {
                    display: true,
                    text: 'Vendas por Mês',
                    font: {
                        size: 18 // AQUI você altera o tamanho do título do gráfico
                    }
                },
                legend: {
                    display: false // Você pode colocar true se quiser mostrar a legenda
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Mês',
                        font: {
                            size: 14 // Tamanho do texto no eixo X
                        }
                    },
                    ticks: {
                        font: {
                            size: 12 // Tamanho dos rótulos das categorias
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Quantidade de Vendas',
                        font: {
                            size: 14 // Tamanho do texto do eixo Y
                        }
                    },
                    ticks: {
                        font: {
                            size: 12 // Tamanho dos valores numéricos no eixo Y
                        }
                    }
                }
            }
        }
    });
})
.catch(error => {
    console.error('Erro ao carregar os dados dos gráficos:', error);
});


fetch('/dashboard/api/topClientes')  // grafico
.then(response => response.json())
.then(data => {
    const labels = data.top_clientes.labels;
    const servicos = data.top_clientes.data;

    const qtdVendas = servicos.map(item => item.qtd);
    const valores = servicos.map(item => parseFloat(item.valor));

    const ctx = document.getElementById('graficoTopClientes').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Clientes',
                data: qtdVendas,
                backgroundColor: 'rgba(75, 192, 192, 0.7)', // Cor das barras
                borderColor: 'rgba(75, 192, 192, 1)',       // Cor da borda
                borderWidth: 1,                             // Espessura da borda
                borderRadius: 5                             // Arredondamento das barras
            }]
        },
        options: {
            responsive: true, // Ajusta ao tamanho do container, mas respeita o width/height do <canvas> se fixado
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const index = context.dataIndex;
                            const qtd = qtdVendas[index];
                            const valor = valores[index];
                            return [
                                `Vendas: ${qtd}`,
                                `Valor total: R$ ${valor.toLocaleString('pt-BR', {
                                    minimumFractionDigits: 2,
                                    maximumFractionDigits: 2
                                })}`
                            ];
                        }
                    }
                },
                title: {
                    display: true,
                    text: 'Vendas por Mês',
                    font: {
                        size: 18 // AQUI você altera o tamanho do título do gráfico
                    }
                },
                legend: {
                    display: false // Você pode colocar true se quiser mostrar a legenda
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Mês',
                        font: {
                            size: 14 // Tamanho do texto no eixo X
                        }
                    },
                    ticks: {
                        font: {
                            size: 12 // Tamanho dos rótulos das categorias
                        }
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Quantidade de Vendas',
                        font: {
                            size: 14 // Tamanho do texto do eixo Y
                        }
                    },
                    ticks: {
                        font: {
                            size: 12 // Tamanho dos valores numéricos no eixo Y
                        }
                    }
                }
            }
        }
    });
})
.catch(error => {
    console.error('Erro ao carregar os dados dos gráficos:', error);
});




