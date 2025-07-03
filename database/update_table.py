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

