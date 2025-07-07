from connection import get_db_connection
import psycopg2
from flask import Flask, render_template, request, jsonify

def salvar_cliente_no_banco(nome, telefone, email, dob, bairro):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Usar '%s' como placeholders para evitar SQL Injection!
        query = ("""
            INSERT INTO salao.clientes (nome, telefone, email, data_nascimento, bairro)
            VALUES (%s, %s, %s, %s, %s)
        """)
        
        # Executa a query passando os valores de forma segura como uma tupla
        cur.execute(query, (nome, telefone, email, dob, bairro))
        conn.commit()
        
    finally:
        # Garante que a conexão seja fechada, mesmo se ocorrer um erro
        if conn is not None:
            conn.close()

def salvar_servico_no_banco(nome_servico, preco):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Usar '%s' como placeholders para evitar SQL Injection!
        query = ("""
            INSERT INTO salao.servicos (nome_servico, preco)
            VALUES (%s, %s)
        """)
        
        # Executa a query passando os valores de forma segura como uma tupla
        cur.execute(query, (nome_servico, preco))
        conn.commit()
        
    finally:
        # Garante que a conexão seja fechada, mesmo se ocorrer um erro
        if conn is not None:
            conn.close()

def salvar_vendas_no_banco(id_cliente, id_servico, valor, forma_pagamento, data_venda):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Usar '%s' como placeholders para evitar SQL Injection!
        query = ("""
            INSERT INTO salao.vendas (id_cliente, id_servico, valor, forma_pagamento, data_venda)
            VALUES (%s, %s, %s, %s, %s)
        """)
        
        # Executa a query passando os valores de forma segura como uma tupla
        cur.execute(query, (id_cliente, id_servico, valor, forma_pagamento, data_venda))
        conn.commit()
        
    finally:
        # Garante que a conexão seja fechada, mesmo se ocorrer um erro
        if conn is not None:
            conn.close()


def excluir_clientes_no_banco(lista_de_ids):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()

        # Comando SQL para deletar múltiplos registros
        # O operador 'ANY' permite comparar uma coluna com uma lista de valores
        query = ("DELETE FROM salao.clientes WHERE id = ANY(%s)")
        
        # Executa a query passando a lista de IDs como um único parâmetro
        # A vírgula após 'lista_de_ids' é importante para que o psycopg2 a entenda como uma tupla de um elemento
        cur.execute(query, (lista_de_ids,))
        
        conn.commit()
    finally:
        if conn is not None:
            cur.close()
            conn.close()

def excluir_servicos_no_banco(lista_de_ids):
    conn = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()


        query = ("DELETE FROM salao.servicos WHERE id = ANY(%s)")       
        cur.execute(query, (lista_de_ids,))
        
        conn.commit()
    finally:
        if conn is not None:
            cur.close()
            conn.close()

def excluir_vendas_no_banco(lista_de_ids):
    conn = None
    cur = None
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        query = "DELETE FROM salao.vendas WHERE id = ANY(%s)"
     
        cur.execute(query, (lista_de_ids,))
        
        conn.commit()
    finally:
        if cur is not None:
            cur.close()
        if conn is not None:
            conn.close()
    

def editar_vendas_no_banco(id_cliente, id_servico, valor, forma, data, id_venda):
    conn = get_db_connection()
    try:
        cur = conn.cursor()
        cur.execute("""
            UPDATE salao.vendas
            SET id_cliente = %s, 
                id_servico = %s, 
                valor = %s, 
                forma_pagamento = %s, 
                data_venda = %s
            WHERE id = %s
        """, (id_cliente, id_servico, valor, forma, data, id_venda))
        conn.commit()
    finally:
        cur.close()
        conn.close()

def editar_servico_no_banco(id_servico, nome_servico, preco):
    conn = get_db_connection()
    try:
        cur = conn.cursor()
        cur.execute("""
            UPDATE salao.servicos
            SET nome_servico = %s, 
                preco = %s
            WHERE id = %s
        """, (nome_servico, preco, id_servico))
        conn.commit()
    finally:
        cur.close()
        conn.close()

def editar_cliente_no_banco(id_cliente, nome, telefone, email, dob, bairro):
    conn = get_db_connection()
    try:
        cur = conn.cursor()
        cur.execute("""
            UPDATE salao.clientes
            SET nome = %s, 
                telefone = %s, 
                email = %s, 
                data_nascimento = %s, 
                bairro = %s
            WHERE id = %s
        """, (nome, telefone, email, dob, bairro, id_cliente))
        conn.commit()
    finally:
        cur.close()
        conn.close()