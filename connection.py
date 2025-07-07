import psycopg2
import os


# Configuração da conexão com PostgreSQL usando variáveis de ambiente
def get_db_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host="localhost"
    )
