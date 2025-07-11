import psycopg2 as pg
from faker import Faker
import random
import bcrypt 
import json
from datetime import date, timedelta
import unicodedata

faker = Faker('pt_BR')
class DbCreator:
    """Classe contendo as funções de criação das tabelas do banco de dados"""
    def __init__(self):
        self.conn = pg.connect(
        dbname='postgres', 
        user='rodrigo',
        password='senha',
        host='localhost',  
        port=5432          
    )
        self.cur = self.conn.cursor()
        self.schema_name = 'salao'
        self.bairros = [
    "Aldeota", "Meireles", "Papicu", "Cocó", "Centro",
    "Benfica", "Parquelândia", "Montese", "Fátima", "Messejana",
    "Dionísio Torres", "Praia de Iracema", "Varjota", "Joaquim Távora", "Maraponga",
    "Mondubim", "Cidade dos Funcionários", "Sapiranga", "Serrinha", "Conjunto Ceará",
    "Pici", "Parangaba", "Bom Jardim", "Jóquei Clube", "Parque Dois Irmãos", "Damas"    
    ]
    
    def create_schema(self):
        self.cur.execute(f"CREATE SCHEMA IF NOT EXISTS {self.schema_name};")
        self.conn.commit()

    def create_servicos(self):
        creation_query = f"""
    CREATE TABLE IF NOT EXISTS {self.schema_name}.servicos (
    id SERIAL PRIMARY KEY,
    nome_servico TEXT NOT NULL,
    preco NUMERIC(10,2) NOT NULL
);"""
        insertion_query = f"""
INSERT INTO {self.schema_name}.servicos (nome_servico, preco) VALUES
('Corte Feminino', 60.00),
('Corte Masculino', 40.00),
('Escova', 50.00),
('Coloração', 120.00),
('Luzes', 150.00),
('Progressiva', 250.00),
('Hidratação Capilar', 80.00),
('Manicure', 30.00),
('Pedicure', 35.00),
('Design de Sobrancelha', 25.00),
('Maquiagem', 90.00),
('Penteado para Festa', 100.00),
('Depilação Buço', 15.00),
('Depilação Pernas', 50.00),
('Massagem Relaxante', 100.00);
"""
        try:
            self.cur.execute(creation_query)
            self.cur.execute(insertion_query)
            self.conn.commit()
        except Exception as e:
            self.conn.rollback()
            print(f"Erro ao criar tabela (servicos) ou inserir dados: {e}")

    def create_clientes(self):
        creation_query = f"""
    CREATE TABLE IF NOT EXISTS {self.schema_name}.clientes (
    id SERIAL PRIMARY KEY,
    nome TEXT NOT NULL,
    telefone VARCHAR(15),
    email TEXT UNIQUE,
    data_nascimento DATE,
    bairro TEXT NOT NULL
);"""

        insertion_query = f"""
    INSERT INTO {self.schema_name}.clientes (nome, telefone, email, data_nascimento, bairro) VALUES
    """
        valores = []
        for i in range(60):
            nome = faker.first_name()
            sobrenome = faker.last_name()
            nome_completo = f'{nome} {sobrenome}'
            telefone = f'(85) 9{random.randint(1000, 9999)}-{random.randint(1000, 9999)}'
            email = f'{self.normalizar(nome)}.{self.normalizar(sobrenome)}@gmail.com'
            data_nascimento = faker.date_of_birth(minimum_age=18, maximum_age=90).strftime('%Y-%m-%d')
            bairro = random.choice(self.bairros)

            linha = f"('{nome_completo}', '{telefone}', '{email}', '{data_nascimento}', '{bairro}')"
            valores.append(linha)

        insertion_query += ",\n".join(valores) + ';'

        try:
            self.cur.execute(creation_query)
            self.cur.execute(insertion_query)
            self.conn.commit()
        except Exception as e:
            self.conn.rollback()
            print(f"Erro ao criar tabela (clientes) ou inserir dados: {e}")

    def create_usuarios(self):
        with open("users.json", "r") as file:
            users_dict = json.load(file)

        creation_query = f"""
    CREATE TABLE IF NOT EXISTS {self.schema_name}.usuarios (
        id SERIAL PRIMARY KEY,
        usuario TEXT UNIQUE NOT NULL,
        senha_hash TEXT NOT NULL,
        is_adm BOOL
    );"""


        insertion_query = f"""
    INSERT INTO {self.schema_name}.usuarios (usuario, senha_hash, is_adm) VALUES
    """
        valores = []
        for user, senha in users_dict.items():
            senha = senha.encode("utf-8")
            hash_senha = bcrypt.hashpw(senha, bcrypt.gensalt()).decode("utf-8")
            is_adm = False
            if user == 'admin':
                is_adm = True

            linha = f"('{user}', '{hash_senha}', {'TRUE' if is_adm else 'FALSE'})"
            valores.append(linha)

        insertion_query += ",\n".join(valores) + ';'

        try:
            self.cur.execute(creation_query)
            self.cur.execute(insertion_query)
            self.conn.commit()
        except Exception as e:
            self.conn.rollback()
            print(f"Erro ao criar tabela (usuarios) ou inserir dados: {e}")


    def create_vendas(self):

        creation_query = f"""
DROP TABLE IF EXISTS {self.schema_name}.vendas;
CREATE TABLE {self.schema_name}.vendas (
    id SERIAL PRIMARY KEY,
    id_cliente INTEGER REFERENCES {self.schema_name}.clientes(id),
    id_servico INTEGER REFERENCES {self.schema_name}.servicos(id),
    valor NUMERIC(10,2),
    forma_pagamento VARCHAR(10) CHECK (valor >= 0),
    data_venda DATE
);"""
        self.cur.execute(creation_query)
        self.conn.commit()

        # 1. Pega os IDs dos clientes e serviços existentes
        self.cur.execute(f"SELECT id FROM {self.schema_name}.clientes")
        clientes = [row[0] for row in self.cur.fetchall()]

        self.cur.execute(f"SELECT id, preco FROM {self.schema_name}.servicos")
        servicos = self.cur.fetchall()  # lista de tuplas (id, preco)

        # 2. Define as formas de pagamento
        formas_pagamento = ['Dinheiro', 'Crédito', 'Débito', 'Pix']

        # 3. Gera as vendas de março a julho
        for mes in range(3, 8):
            data_inicio = date(2025, mes, 1)
            dias = 30 if mes % 2 == 0 else 31

            for i in range(dias):
                data_venda = data_inicio + timedelta(days=i)
                vendas_do_dia = random.randint(30, 40)

                copia_clientes = clientes.copy()
                for _ in range(vendas_do_dia):
                    id_cliente = random.choice(copia_clientes)
                    copia_clientes.remove(id_cliente)
                    id_servico, valor = random.choice(servicos)
                    forma_pagamento = random.choice(formas_pagamento)

                    
                    self.cur.execute(f"""
                    INSERT INTO {self.schema_name}.vendas (id_cliente, id_servico, valor, forma_pagamento, data_venda)
                    VALUES (%s,%s,%s,%s,%s)
                    """, (id_cliente, id_servico, valor, forma_pagamento, data_venda))

        self.conn.commit()

    def fechar_conexao(self):
        self.cur.close()
        self.conn.close()

    def normalizar(self, nome):
        nome = nome.lower()
        nome = ''.join(nome.split())
        # Normaliza o texto para decompor os caracteres acentuados
        nome_normalizado = unicodedata.normalize('NFKD', nome)
        # Filtra apenas os caracteres que não são marcas de acento
        nome_sem_acento = ''.join(c for c in nome_normalizado if not unicodedata.combining(c))
        return nome_sem_acento
        

if __name__ == '__main__':
    creator = DbCreator()
    try:
        # creator.create_schema()
        # creator.create_servicos()
        # creator.create_clientes()
        # creator.create_usuarios()
        creator.create_vendas()
    finally:
        creator.fechar_conexao()