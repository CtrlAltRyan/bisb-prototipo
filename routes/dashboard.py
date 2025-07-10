from connection import get_db_connection
from flask import Blueprint, jsonify, render_template
from .info import *
import pandas as pd



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

@dashboard_bp.route('/api/heatmap')
def heatmap():

    df = get_vendas_por_bairro()

    bairros_coords = {
        "Aldeota":            [-3.7306, -38.5215],
        "Meireles":           [-3.7184, -38.5000],
        "Papicu":             [-3.7285, -38.4934],
        "Cocó":               [-3.7231, -38.4885],
        "Centro":             [-3.7300, -38.5200],
        "Benfica":            [-3.7289, -38.5176],
        "Parquelândia":       [-3.7492, -38.5637],
        "Montese":            [-3.7584, -38.5051],
        "Fátima":             [-3.7490, -38.5250],
        "Messejana":          [-3.8549, -38.4828],
        "Dionísio Torres":    [-3.7437, -38.5206],
        "Praia de Iracema":   [-3.7181, -38.5433],
        "Varjota":            [-3.7250, -38.5093],
        "Joaquim Távora":     [-3.7173, -38.5438],
        "Maraponga":          [-3.8015, -38.5572],
        "Mondubim":           [-3.7712, -38.5967],
        "Cidade dos Funcionários": [-3.7769, -38.5013],
        "Sapiranga":          [-3.7240, -38.4487],
        "Serrinha":           [-3.7655, -38.5523],
        "Conjunto Ceará":     [-3.7625, -38.5525],
        "Pici":               [-3.7475, -38.5728],
        "Parangaba":          [-3.7665, -38.5843],
        "Bom Jardim":         [-3.7265, -38.5368],
        "Jóquei Clube":       [-3.7496, -38.5245],
        "Parque Dois Irmãos": [-3.7317, -38.5268],
        "Damas":              [-3.7323, -38.5453],
    }

    heatmap = []
    for _, row in df.iterrows():
        coords = bairros_coords.get(row['bairro'])
        if not coords:
            continue
        lat, lon = coords
        heatmap.append([lat, lon, float(row['n_vendas'])])
    return jsonify({"heatmap": heatmap})

