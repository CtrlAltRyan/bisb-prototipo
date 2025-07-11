import os
import psycopg2
from urllib.parse import urlparse

def get_db_connection():
    db_url = os.getenv("DATABASE_URL")
    if not db_url:
        raise RuntimeError("DATABASE_URL não está definido!")

    # psycopg2 aceita a URL inteira e sslmode é recomendado em prod
    return psycopg2.connect(db_url, sslmode="require")

