import psycopg2
from psycopg2 import Error

class Database:
    def __init__(self):
        self.connection = None
        self.cursor = None
    
    def conectar(self):
        """Estabelece conexão com o banco de dados PostgreSQL"""
        try:
            self.connection = psycopg2.connect(
                host="localhost",
                database="saude_publica",
                user="postgres",
                password="a11819240",  # ALTERE AQUI
                port="5432"
            )
            self.cursor = self.connection.cursor()
            print("✓ Conexão estabelecida com sucesso!")
            return True
        except Error as e:
            print(f"✗ Erro ao conectar ao banco de dados: {e}")
            return False
    
    def desconectar(self):
        """Fecha a conexão com o banco de dados"""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
            print("✓ Conexão encerrada.")
    
    def executar_query(self, query, params=None):
        """Executa uma query (INSERT, UPDATE, DELETE)"""
        try:
            if params:
                self.cursor.execute(query, params)
            else:
                self.cursor.execute(query)
            self.connection.commit()
            return True
        except Error as e:
            print(f"✗ Erro ao executar query: {e}")
            self.connection.rollback()
            return False
    
    def executar_consulta(self, query, params=None):
        """Executa uma consulta (SELECT) e retorna os resultados"""
        try:
            if params:
                self.cursor.execute(query, params)
            else:
                self.cursor.execute(query)
            return self.cursor.fetchall()
        except Error as e:
            print(f"✗ Erro ao executar consulta: {e}")
            return []
