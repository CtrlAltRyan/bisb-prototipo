from connection import get_db_connection
from flask import Blueprint, jsonify
import pandas as pd
import plotly.express as px

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/api/sales-chart') # Podemos manter a mesma rota
def sales_chart():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT bairro, COUNT(*) as n_clientes
        FROM salao.clientes
        GROUP BY bairro
        ORDER BY n_clientes DESC
        LIMIT 5;""")
    rows = cur.fetchall()

    cur.close()
    conn.close()

    if not rows:
        # Retorna um objeto vazio se não houver dados
        return jsonify({'labels': [], 'data': []})
    
    df = pd.DataFrame(rows, columns=['bairro', 'clientes'])

    # Crie um dicionário simples com os dados para o gráfico
    chart_data = {
        'labels': df['bairro'].tolist(),
        'data': df['clientes'].tolist()
    }

    return jsonify(chart_data)