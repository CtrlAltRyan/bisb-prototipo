from flask import Flask, render_template, url_for, request, jsonify
from routes.user import user_bp
from routes.auth import auth_bp
from database.update_table import salvar_cliente_no_banco
import traceback


app = Flask(__name__)
app.secret_key  = '123'

app.register_blueprint(user_bp, url_prefix='/user')
app.register_blueprint(auth_bp, url_prefix='/auth')

@app.route('/')
def root():
    return render_template('login.html')

@app.route('/clientes/adicionar', methods=['POST'])
def adicionar_cliente():
    # Recebe o "pacote" JSON
    dados = request.get_json()

    # Extrai cada informação
    nome = dados.get('nome')
    telefone = dados.get('telefone')
    email = dados.get('email')
    dob = dados.get('dob')
    bairro = dados.get('bairro')
    
    # Validação simples
    if not nome:
        return jsonify({'success': False, 'message': 'Nome é obrigatório'}), 400

    try:
        # Entrega os dados para a sua função salvar (ver Passo 5)
        salvar_cliente_no_banco(nome, telefone, email, dob, bairro)
        
        # Envia uma resposta de sucesso de volta (ver Passo 6)
        return jsonify({'success': True})

    except Exception as e:
        print(e) # Para depuração no seu terminal
        print("Erro completo:")
        traceback.print_exc()
        return jsonify({'success': False, 'message': 'Erro no servidor'}), 500
    
if __name__ == '__main__':
    app.run(debug=True)
