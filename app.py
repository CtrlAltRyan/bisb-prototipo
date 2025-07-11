from flask import Flask, render_template, url_for, request, jsonify
from routes.user import user_bp
from routes.auth import auth_bp
from routes.dashboard import dashboard_bp
from database.update_table import *
import traceback


app = Flask(__name__)
app.secret_key  = '123'

app.register_blueprint(user_bp, url_prefix='/user')
app.register_blueprint(auth_bp, url_prefix='/auth')
app.register_blueprint(dashboard_bp, url_prefix='/dashboard')

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
    
@app.route('/servicos/adicionar', methods=['POST'])
def adicionar_servico():
    # Recebe o "pacote" JSON
    dados = request.get_json()

    # Extrai cada informação
    nome_servico = dados.get('nome_servico')
    preco = dados.get('preco')
    
    # Validação simples
    if not nome_servico:
        return jsonify({'success': False, 'message': 'Nome é obrigatório'}), 400

    try:
        # Entrega os dados para a sua função salvar (ver Passo 5)
        salvar_servico_no_banco(nome_servico, preco)
        
        # Envia uma resposta de sucesso de volta (ver Passo 6)
        return jsonify({'success': True})

    except Exception as e:
        print(e) # Para depuração no seu terminal
        print("Erro completo:")
        traceback.print_exc()
        return jsonify({'success': False, 'message': 'Erro no servidor'}), 500
    
@app.route('/vendas/adicionar', methods=['POST'])
def adicionar_venda():
    # Recebe o "pacote" JSON
    dados = request.get_json()

    # Extrai cada informação
    id_cliente = dados.get('id_cliente')
    id_servico = dados.get('id_servico')
    valor = dados.get('valor')
    forma_pagamento = dados.get('forma_pagamento') 
    data_venda = dados.get('data_venda')
    
    # Validação simples
    if not id_cliente:
        return jsonify({'success': False, 'message': 'ID é obrigatório'}), 400

    try:
        # Entrega os dados para a sua função salvar (ver Passo 5)
        salvar_vendas_no_banco(id_cliente, id_servico, valor, forma_pagamento, data_venda)
        
        # Envia uma resposta de sucesso de volta (ver Passo 6)
        return jsonify({'success': True})

    except Exception as e:
        print(e) # Para depuração no seu terminal
        print("Erro completo:")
        traceback.print_exc()
        return jsonify({'success': False, 'message': 'Erro no servidor'}), 500
    
 
@app.route('/clientes/excluir', methods=['POST'])
def excluir_cliente():
    dados = request.get_json()
    ids_para_excluir_str = dados.get('ids') # Recebemos uma lista de strings, ex: ['68', '70']

    if not ids_para_excluir_str or not isinstance(ids_para_excluir_str, list):
        return jsonify({'success': False, 'message': 'Nenhum ID foi fornecido para exclusão.'}), 400

    try:
        ids_para_excluir_int = [int(id_str) for id_str in ids_para_excluir_str]
        excluir_clientes_no_banco(ids_para_excluir_int)
        
        return jsonify({'success': True, 'message': 'Clientes excluídos com sucesso!'})

    except ValueError:
        # Este erro acontece se um dos IDs não for um número válido
        return jsonify({'success': False, 'message': 'Um ou mais IDs fornecidos são inválidos.'}), 400
    except Exception as e:
        print(f"Erro ao excluir no banco de dados: {e}")
        return jsonify({'success': False, 'message': 'Erro interno no servidor.'}), 500

@app.route('/servicos/excluir', methods=['POST'])
def excluir_servico():

    dados = request.get_json()
    ids_para_excluir = dados.get('ids')
    ids_para_excluir= [int(id_str) for id_str in ids_para_excluir]
    
    try:
        excluir_servicos_no_banco(ids_para_excluir) 
        return jsonify({'success': True})
    except Exception as e:
        print("Erro completo:")
        traceback.print_exc()
        return jsonify({'success': False, 'message': 'Erro no servidor.'}), 500
    

@app.route('/vendas/excluir', methods=['POST'])
def excluir_venda():
    dados = request.get_json()
    ids_para_excluir_str = dados.get('ids') # Recebe uma lista de STRINGS, ex: ['1', '5']

    # Validação inicial
    if not ids_para_excluir_str or not isinstance(ids_para_excluir_str, list) or len(ids_para_excluir_str) == 0:
        return jsonify({'success': False, 'message': 'Nenhum ID foi fornecido para exclusão.'}), 400
    
    try:
        # --- LINHA FUNDAMENTAL: CONVERSÃO DE TIPO ---
        # Converte cada item da lista de strings para uma lista de inteiros.
        ids_para_excluir_int = [int(id_str) for id_str in ids_para_excluir_str]

        # Passa a lista de NÚMEROS para a função do banco
        excluir_vendas_no_banco(ids_para_excluir_int) 
        
        return jsonify({'success': True, 'message': 'Venda(s) excluída(s) com sucesso!'})

    except ValueError:
        # Este erro acontece se um dos IDs no array não for um número (ex: 'abc')
        return jsonify({'success': False, 'message': 'ID inválido na lista fornecida.'}), 400
    except Exception as e:
        print(f"Erro ao excluir no banco de dados: {e}")
        return jsonify({'success': False, 'message': 'Erro interno no servidor.'}), 500
    

@app.route('/vendas/editar', methods=['POST'])
def editar_venda():
    dados = request.get_json()
    try:
        # Capturando os dados do formulário
        id_venda = int(dados['id_venda'])
        id_cliente = int(dados['id_cliente']) 
        id_servico = int(dados['id_servico']) 
        valor = float(dados['valor'])
        forma = dados['forma_pagamento']
        data = dados['data_venda']
    

        # Passando TODOS os parâmetros para a função do banco
        editar_vendas_no_banco(id_cliente, id_servico, valor, forma, data, id_venda)

        return jsonify({'success': True})
    except Exception as e:
        # MELHORIA: Imprimir o erro real ajuda muito a debugar
        print(f"ERRO AO EDITAR VENDA: {e}") 
        return jsonify({'success': False, 'message': f'Erro interno ao atualizar a venda: {e}'}), 500
    

@app.route('/clientes/editar', methods=['POST'])
def editar_cliente():
    dados = request.get_json()
    try:
        # Capturando TODOS os dados do formulário
        id_cliente = int(dados['id_cliente'])
        nome = dados['nome']
        telefone = dados['telefone']
        email = dados['email']
        dob = dados['dob']
        bairro = dados['bairro']

        # Passando TODOS os parâmetros para a função do banco
        editar_cliente_no_banco(id_cliente, nome, telefone, email, dob, bairro)

        return jsonify({'success': True})
    except Exception as e:
        # MELHORIA: Imprimir o erro real ajuda muito a debugar
        print(f"ERRO AO EDITAR CLIENTE: {e}") 
        return jsonify({'success': False, 'message': f'Erro interno ao atualizar o cliente: {e}'}), 500

@app.route('/servicos/editar', methods=['POST'])
def editar_servico():
    dados = request.get_json()
    try:
        # Capturando TODOS os dados do formulário
        id_servico = int(dados['id_servico'])
        preco = float(dados['valor'])
        nome_servico = dados['nome_servico']

        # Passando TODOS os parâmetros para a função do banco
        editar_servico_no_banco(id_servico, nome_servico, preco)

        return jsonify({'success': True})
    except Exception as e:
        # MELHORIA: Imprimir o erro real ajuda muito a debugar
        print(f"ERRO AO EDITAR SERVIÇO: {e}") 
        traceback.print_exc()
        return jsonify({'success': False, 'message': f'Erro interno ao atualizar o serviço: {e}'}), 500
    
if __name__ == '__main__':
    app.run(debug=True)
    import os
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
