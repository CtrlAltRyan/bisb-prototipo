# 💇‍♀️ BISB – Business Intelligence para Salões de Beleza

Sistema protótipo desenvolvido pela equipe BISB Consultoria como parte do projeto de Interfaces de Programação de Aplicação. O sistema contempla autenticação, dashboard com indicadores de vendas e fluxo de caixa, e gestão de clientes, serviços e vendas.

## 📁 Estrutura do Projeto

```
/bisb-prototipo
├── backend/              # Código da API (Flask)
├── frontend/             # Interface do usuário (HTML/CSS/JS)
├── database/             # Scripts SQL e documentação do banco
├── design/               # Logotipo, layout visual e identidade
├── docs/                 # Cronograma, Kanban, instruções gerais
└── README.md             # Este arquivo
```

---

## 🚀 Como executar o projeto (modo local)

### 🔧 Pré-requisitos

- Python 3.10+ 
- PostgreSQL
- Git
- (Opcional) VSCode com extensão Live Server ou algum gerenciador de ambiente virtual

---

### 📦 Passos para rodar o sistema

```bash
# Clone o repositório
git clone https://github.com/usuario/bisb-prototipo.git
cd bisb-prototipo

# Instale as dependências do backend (exemplo com Python)
cd backend
pip install -r requirements.txt
python main.py

# Em outro terminal, rode o frontend (exemplo com HTML estático)
cd ../frontend
# Abrir index.html no navegador OU usar Live Server

# O banco pode ser restaurado com:
psql -U postgres -d salon_db -f database/projeto_banco_salao.sql
```

---

## 👥 Equipe BISB

| Nome        | Responsabilidade principal         |
|-------------|------------------------------------|
| Rodrigo     | Banco de Dados, Dashboard e BI     |
| Lemuel      | Autenticação (login)               |
| Ryan        | Frontend geral, Dashboard e BI     |
| Clara       | Coordenação, identidade visual     |

---

## 🗂️ Organização por branches

Cada membro deve trabalhar em sua própria branch e enviar pull requests para a `main` após revisão.

---

## 📅 Entrega final

🗓️ **Apresentação do protótipo funcionando:** 11/07/2025  
📍 **Status atual:** [Apresentado]

---
