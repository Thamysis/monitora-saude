import psycopg2
from psycopg2 import Error
from config import *

class Database:
    def __init__(self):
        self.connection = None
        self.cursor = None
    
    def conectar(self):
        try:
            self.connection = psycopg2.connect(
                host = DB_HOST,
                database = DB_DATABASE,
                user = DB_USER,
                password = DB_PASSWORD,
                port = DB_PORT
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
            print(MESSAGE_CONNECTION_CLOSED)
    
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
