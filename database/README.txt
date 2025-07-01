Esta pasta deve conter os scripts .sql de criação e popularização do banco de dados, e instruções para restaurar localmente.

table_creation.py: Código utilizado na criação das tabelas do banco de dados com simulação de dados aleatórios.
# requirements.txt
psycopg2
faker
bcrypt

---
users.json: Json contendo os logins e senhas do sistema que foram inseridos na tabela usuarios.

---
dump-postgres-202505272213.sql: Código sql para recriar a base de dados.