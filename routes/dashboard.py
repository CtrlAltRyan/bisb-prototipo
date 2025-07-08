from connection import get_db_connection
from flask import Blueprint, jsonify
import pandas as pd
import plotly.express as px

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/api/sales-chart')
def sales_chart():
    conn = get_db_connection()
    cur = conn.cursor()

    # Top 5 bairros
    cur.execute("""
        SELECT bairro, COUNT(*) as n_clientes
        FROM salao.clientes
        GROUP BY bairro
        ORDER BY n_clientes DESC
        LIMIT 5;""")
    rows = cur.fetchall()

    cur.close()
    conn.close()

    df = pd.DataFrame(rows, columns=['Bairro', "Clientes"])
#     df = pd.DataFrame({
#     'Bairro': ['Bairro A', 'Bairro B', 'Bairro C', 'Bairro D', 'Bairro E'],
#     'Clientes': [6, 4, 4, 4, 4]
# })

    fig = px.bar(df, x="Clientes", y="Bairro", title="Top 5 Bairros por Número de Clientes", orientation='h')
    fig.update_layout(
        width=500,  # Define a largura do gráfico
        height=300,  # Define a altura do gráfico
        title=dict(
            x=0.5,  # Centraliza o título
            font=dict(size=20)  # Ajusta o tamanho da fonte do título
        )   
    )
    json_data = fig.to_json()
    #print(json_data)
    return jsonify(json_data)
