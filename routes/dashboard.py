from connection import get_db_connection
from flask import Blueprint, jsonify
import pandas as pd
from .info import *


dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/api/vendasservico') 
def sales_chart():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(""" SELECT s.nome_servico,  
    COUNT(v.id_servico) AS n_vendas,
	SUM(v.valor) as v_vendas FROM salao.vendas AS v JOIN                         
    salao.servicos AS s ON v.id_servico = s.id GROUP BY
    s.nome_servico ORDER BY n_vendas DESC, v_vendas DESC LIMIT 5; """)

    rows2 = cur.fetchall()
    df2 = pd.DataFrame(rows2, columns=['servico', 'qtd', 'valor'])
    cur.close()
    conn.close()

    chart_data = {
        'vendas_por_servico': {
            'labels': df2['servico'].tolist(),
            'data': df2[['qtd', 'valor']].to_dict(orient='records')}}
    
    return jsonify(chart_data)

@dashboard_bp.route('/api/vendasmes') 
def vendasmes():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(""" SELECT 
    TO_CHAR(DATE_TRUNC('month', data_venda), 'TMMonth/YYYY') AS mes_nome,
    COUNT(*) AS total_vendas, SUM(valor) AS valor_total FROM  salao.vendas
    GROUP BY mes_nome, DATE_TRUNC('month', data_venda) ORDER BY 
    DATE_TRUNC('month', data_venda);""")
    
    rows2 = cur.fetchall()
    df2 = pd.DataFrame(rows2, columns=['mes', 'qtd', 'valor'])
    cur.close()
    conn.close()

    chart_data = {
        'fluxo_por_mes': {
            'labels': df2['mes'].tolist(),
            'data': df2[['qtd', 'valor']].to_dict(orient='records')}}
    
    return jsonify(chart_data)

@dashboard_bp.route('/api/topClientes') 
def topclientes():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute(""" SELECT c.nome AS cliente, COUNT(v.id) AS qtd_vendas,
    SUM(v.valor) AS valor_total FROM salao.vendas AS v JOIN salao.clientes AS c ON v.id_cliente = c.id
    GROUP BY c.nome ORDER BY valor_total DESC, qtd_vendas DESC LIMIT 5; """)
    
    rows2 = cur.fetchall()
    df2 = pd.DataFrame(rows2, columns=['cliente', 'qtd', 'valor'])
    cur.close()
    conn.close()

    chart_data = {
        'top_clientes': {
            'labels': df2['cliente'].tolist(),
            'data': df2[['qtd', 'valor']].to_dict(orient='records')}}
    
    return jsonify(chart_data)

@dashboard_bp.route('/api/heatmap-vendas')
def heatmap_vendas():
    df = get_vendas_por_bairro()  # função que retorna DataFrame com 'bairro' e 'n_vendas'

    bairros_coords = {
        "Meireles": [-3.7184, -38.5000],
        "Aldeota": [-3.7306, -38.5215],
        "Parquelândia": [-3.7492, -38.5637],
        "Centro": [-3.7300, -38.5200],
        "Fátima": [-3.7490, -38.5250],
        "Cidade dos Funcionários": [-3.7769, -38.5013],
        "Pici": [-3.7475, -38.5728],
        "Praia de Iracema": [-3.7181, -38.5433],
        "Serrinha": [-3.7655, -38.5523]
        # Adicione mais bairros conforme necessário
    }

    heat_data = []
    for _, row in df.iterrows():
        bairro = row['bairro']
        if bairro in bairros_coords:
            lat, lon = bairros_coords[bairro]
            intensity = row['n_vendas']
            heat_data.append([lat, lon, intensity])  # formato ideal para HeatMap

    return jsonify({"heatmap": heat_data})