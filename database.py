import psycopg2
from psycopg2 import Error

HOST = "localhost"
DATABASE = "saude_publica"
USER = "postgres"
PASSWORD = "password"  # ALTERAR AQUI PARA A SENHA DO SEU DATABASE
PORT = "5432"

MESSAGE_SUCCESS_CONNECT = "✓ Conexão estabelecida com sucesso!"
MESSAGE_ERROR_CONNECT = "✗ Erro ao conectar ao banco de dados: "
MESSAGE_CONNECTION_FINISHED = "✓ Conexão encerrada."
MESSAGE_ERROR_QUERY = "✗ Erro ao executar query: "

class Database:
    def __init__(self):
        self.connection = None
        self.cursor = None
    
    def conectar(self):
        try:
            self.connection = psycopg2.connect(
                host = HOST,
                database = DATABASE,
                user = USER,
                password = PASSWORD,
                port = PORT
            )
            self.cursor = self.connection.cursor()
            print(MESSAGE_SUCCESS_CONNECT)
            return True
        except Error as e:
            print(MESSAGE_ERROR_CONNECT + e)
            return False
    
    def desconectar(self):
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
            print(MESSAGE_CONNECTION_FINISHED)
    
    def executar_query(self, query, params=None):
        try:
            if params:
                self.cursor.execute(query, params)
            else:
                self.cursor.execute(query)
            self.connection.commit()
            return True
        except Error as e:
            print(MESSAGE_ERROR_QUERY + e)
            self.connection.rollback()
            return False
    
    def executar_consulta(self, query, params=None):
        try:
            if params:
                self.cursor.execute(query, params)
            else:
                self.cursor.execute(query)
            return self.cursor.fetchall()
        except Error as e:
            print(MESSAGE_ERROR_QUERY + e)
            return []
