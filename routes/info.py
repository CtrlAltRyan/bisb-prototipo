from connection import get_db_connection
from flask import session

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

def get_amount():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT SUM(valor) AS faturamento_total FROM salao.vendas;
    """)
    montante = cur.fetchone()
    montante = montante[0] if montante else "0"

    cur.close()
    conn.close()

    return montante

def get_customersnum():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT COUNT(nome) FROM salao.clientes;
    """)
    clientesnum = cur.fetchone()
    clientesnum = clientesnum[0] if clientesnum else "0"

    cur.close()
    conn.close()

    return clientesnum

def get_customerschange():
    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
         SELECT COUNT(nome) FROM salao.clientes;
    """)
    clientesChange = cur.fetchone()
    clientesChange = clientesChange[0] if clientesChange else "0"

    cur.close()
    conn.close()

    return clientesChange

def adm_check():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT is_adm FROM salao.usuarios WHERE usuario = (%s);
    """,(session['user'],))

    permission = cur.fetchone()
    cur.close()

    return permission[0] if permission else False

def get_pfp():
    pfp = session['user']