from connection import get_db_connection
from flask import session
import pandas as pd

def get_topservice():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT
    s.nome_servico,
    COUNT(v.id) AS quantidade_vendida
FROM
    salao.vendas AS v
JOIN
    salao.servicos AS s ON v.id_servico = s.id
GROUP BY
    s.nome_servico
ORDER BY
    quantidade_vendida DESC
LIMIT 1;
    """)
    servico_mais_vendido = cur.fetchone()
    servico_mais_vendido = servico_mais_vendido[0] if servico_mais_vendido else "Nenhum"

    cur.close()
    conn.close()

    return servico_mais_vendido

def formatar_decimal_br(numero):
    return f"{numero:,.2f}".replace(",", "X").replace(".", ",").replace("X", ".")

def get_amount():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT SUM(valor) AS faturamento_total FROM salao.vendas;
    """)
    montante = cur.fetchone()
    montante = montante[0] 
    if montante is None:
        montante = 0

    cur.close()
    conn.close()
    montante =  formatar_decimal_br(montante)
    montante = str(montante)

    return montante

def get_customersnum():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT COUNT(nome) FROM salao.clientes;
    """)
    clientesnum = cur.fetchone()
    clientesnum = clientesnum[0] 
    if clientesnum is None:
        clientesnum = 0

    cur.close()
    conn.close()

    return clientesnum


def get_saleschange():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
         SELECT SUM(valor) 
         FROM salao.vendas
         WHERE DATE_TRUNC('month', data_venda) = DATE_TRUNC('month', CURRENT_DATE);   
    """)
    salesChange = cur.fetchone()
    salesChange = salesChange[0] 
    if salesChange is None:
        salesChange = 0

    cur.close()
    conn.close()
    salesChange = formatar_decimal_br(salesChange)
    salesChange = str(salesChange)
    return salesChange

def adm_check():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT is_adm FROM salao.usuarios WHERE usuario = (%s);
    """,(session['user'],))

    permission = cur.fetchone()
    cur.close()
    conn.close()

    return permission[0] if permission else False

def get_vendas_por_bairro():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
    SELECT c.bairro, COUNT(*) AS n_vendas
    FROM salao.vendas AS v
    JOIN salao.clientes AS c ON v.id_cliente = c.id
    GROUP BY c.bairro
    ORDER BY n_vendas DESC;
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    return pd.DataFrame(rows, columns=['bairro', 'n_vendas'])

