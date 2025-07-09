from connection import get_db_connection
from flask import Blueprint, jsonify
import pandas as pd
import plotly.express as px

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/api/sales-chart') # Podemos manter a mesma rota
def sales_chart():
    conn = get_db_connection()
    cur = conn.cursor()

    # Consulta 1
    cur.execute("SELECT bairro, COUNT(*) as n_clientes FROM salao.clientes GROUP BY bairro ORDER BY n_clientes DESC LIMIT 5;")
    rows1 = cur.fetchall()
    df1 = pd.DataFrame(rows1, columns=['bairro', 'clientes'])

    # Consulta 2
    cur.execute("SELECT servico, COUNT(*) as n_vendas FROM salao.vendas GROUP BY servico ORDER BY n_vendas DESC LIMIT 5;")
    rows2 = cur.fetchall()
    df2 = pd.DataFrame(rows2, columns=['servico', 'vendas'])

    cur.execute("SELECT DATE_TRUNC('month', data_venda) AS mes, SUM(valor) AS total_vendas FROM salao.vendas GROUP BY mes ORDER BY mes;")
    rows3 = cur.fetchall()
    df3 = pd.DataFrame(rows3, columns=['mes', 'total_vendas'])

    cur.close()
    conn.close()

    # Monta o JSON de resposta
    chart_data = {
        'clientes_por_bairro': {
            'labels': df1['bairro'].tolist(),
            'data': df1['clientes'].tolist()
        },
        'vendas_por_servico': {
            'labels': df2['servico'].tolist(),
            'data': df2['vendas'].tolist()
        },
        'vendas_por_mes': {
            'labels': df3['mes'].tolist(),
            'data': df2['total_vendas'].to_list()
        }
    }

    return jsonify(chart_data)