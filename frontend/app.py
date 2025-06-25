from flask import Flask, render_template, request, redirect, url_for, flash, send_file
import matplotlib.pyplot as plt
import os

app = Flask(__name__)

# IMPORTANTE: Para usar o 'flash', o Flask precisa de uma 'chave secreta'.
app.secret_key = 'sua-chave-secreta-muito-segura-e-aleatoria'

# --- Lógica de Verificação (Placeholder) ---
def check_credentials(username, password):
    """Verifica se o usuário e a senha estão corretos."""
    if username == 'francisca' and password == 'francisca':
        return True
    if username == ' ' and password == ' ':
        return True
    return False

def check_user_exists(nome, usuario):
    """Verifica se o usuário existe para recuperação de senha."""
    # Aqui você colocaria a lógica real de verificação no banco de dados
    # Por enquanto, vamos simular alguns usuários válidos
    usuarios_validos = {
        'francisca': 'francisca',
        'admin': 'admin',
        'usuario': 'usuario teste'
    }
    
    # Verifica se o usuário existe e se o nome corresponde
    if usuario in usuarios_validos:
        # Aqui você faria uma verificação mais robusta
        # Por exemplo, verificar se o nome corresponde ao usuário
        return True
    return False

def send_recovery_email(nome, usuario):
    """Simula o envio de email de recuperação."""
    # Aqui você implementaria a lógica real de envio de email
    # Por enquanto, apenas simula o envio
    print(f"Email de recuperação enviado para {nome} ({usuario})")
    return True


@app.route('/', methods=['GET', 'POST'])
def login_page():
    if request.method == 'POST':
        username_form = request.form['user']
        password_form = request.form['password']

        if check_credentials(username_form, password_form):
            # Passa o nome do usuário para a rota home
            return redirect(url_for('home_page', username=username_form))
        else:
            flash('Usuário ou senha inválidos. Tente novamente.')
            return redirect(url_for('login_page'))
    
    return render_template('login.html') 


@app.route('/home')
def home_page():
    """Renderiza a página 'home' (painel) para usuários autenticados."""
    # Pega o nome de usuário passado como parâmetro na URL
    # Define um valor padrão 'Visitante' caso não seja fornecido
    username = request.args.get('username', 'Visitante')

    # Dados de exemplo para os cards (em um app real, viriam do banco de dados)
    dashboard_data = {
        'vendas_mensais': 'R$ 2.870,00',
        'clientes_atuais': 60,
        'clientes_ativos_perc': '78,33%',
        'servico_mais_vendido': 'Escova'
    }

    # Renderiza o template do painel e passa as variáveis para ele
    return render_template('home.html', user=username.capitalize(), data=dashboard_data)



@app.route('/register')
def register_page():
    """Apenas renderiza (mostra) a página de cadastro."""
    return render_template('register.html')

# ROTA ATUALIZADA: Página de Recuperação de Senha com lógica
@app.route('/reset-password', methods=['GET', 'POST'])
def reset_password_page():
    """Renderiza a página de recuperação de senha e processa o formulário."""
    if request.method == 'POST':
        nome = request.form.get('nome', '').strip()
        usuario = request.form.get('usuario', '').strip()
        
        # Validações básicas
        if not nome or not usuario:
            flash('Todos os campos são obrigatórios.', 'error')
            return redirect(url_for('reset_password_page'))
        
        if len(nome) < 2:
            flash('Nome deve ter pelo menos 2 caracteres.', 'error')
            return redirect(url_for('reset_password_page'))
        
        if len(usuario) < 3:
            flash('Usuário deve ter pelo menos 3 caracteres.', 'error')
            return redirect(url_for('reset_password_page'))
        
        # Verifica se o usuário existe
        if check_user_exists(nome, usuario):
            # Tenta enviar o email de recuperação
            if send_recovery_email(nome, usuario):
                flash('Email de recuperação enviado com sucesso! Verifique sua caixa de entrada.', 'success')
                return redirect(url_for('reset_password_page'))
            else:
                flash('Erro ao enviar email de recuperação. Tente novamente mais tarde.', 'error')
                return redirect(url_for('reset_password_page'))
        else:
            flash('Usuário não encontrado. Verifique os dados informados.', 'error')
            return redirect(url_for('reset_password_page'))
    
    return render_template('reset_password.html')





# Permite que você rode o arquivo diretamente com 'python app.py'
if __name__ == '__main__':
    app.run(debug=True)
