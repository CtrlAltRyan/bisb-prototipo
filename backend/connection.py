import psycopg2

# Configuração da conexão com PostgreSQL
def get_db_connection():
    return psycopg2.connect(
        dbname="bisb",
        user="postgres",
        password="lemuel",
        host="localhost"
    )
