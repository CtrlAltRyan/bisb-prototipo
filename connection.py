from dotenv import load_dotenv
import psycopg2
import os

load_dotenv()
# Configuração da conexão com PostgreSQL usando variáveis de ambiente
def get_db_connection():
    return psycopg2.connect(
        dbname="bisbdb",
        user="postgres",
        password="senha",
        host="localhost"
    )
