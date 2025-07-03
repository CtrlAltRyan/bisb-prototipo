import psycopg2

# Configuração da conexão com PostgreSQL
def get_db_connection():
    return psycopg2.connect(
        dbname="bisbdb",
        user="postgres",
        password="ryanboy2",
        host="localhost"
    )
