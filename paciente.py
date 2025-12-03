import os
from datetime import datetime
from config import *

class Paciente:
    def __init__(self, db):
        self.db = db
    
    def cadastrar(self):
        """Cadastra um novo paciente"""
        print("\n" + "="*60)
        print("   CADASTRO DE PACIENTE")
        print("="*60)
        
        cpf = input("CPF (formato: 123.456.789-01): ").strip()
        nome = input("Nome Completo: ").strip()
        data_nasc = input("Data de Nascimento (AAAA-MM-DD): ").strip()
        sexo = input("Sexo (M/F/O): ").strip().upper()
        rua = input("Rua: ").strip()
        numero = input("Número: ").strip()
        bairro = input("Bairro: ").strip()
        cidade = input("Cidade: ").strip()
        estado = input("Estado (SP, RJ, etc): ").strip().upper()
        cep = input("CEP: ").strip()
        
        params = (cpf, nome, data_nasc, sexo, rua, numero, bairro, cidade, estado, cep)
        
        if self.db.executar_query(QUERY_INSERT_PATIENT, params):
            print("\n✓ Paciente cadastrado com sucesso!")
        else:
            print("\n✗ Erro ao cadastrar paciente.")
    
    def listar_todos(self):
        """Lista todos os pacientes com idade calculada"""
        
        resultados = self.db.executar_consulta(QUERY_SELECT_PATIENT_BY_AGE)
        
        print("\n" + "="*60)
        print("   LISTA DE PACIENTES")
        print("="*60)
        print(f"{'CPF':<18} {'Nome':<30} {'Idade':<6} {'Sexo':<5} {'Cidade/UF':<15}")
        print("-"*90)
        
        for row in resultados:
            cpf, nome, idade, sexo, cidade, estado = row
            idade_str = f"{int(idade)}" if idade else "N/A"
            print(f"{cpf:<18} {nome:<30} {idade_str:<6} {sexo:<5} {cidade}/{estado}")
        
        print(f"\nTotal: {len(resultados)} paciente(s)")
    
    def consultar_por_cpf(self):
        """Consulta um paciente específico por CPF"""
        cpf = input("\nDigite o CPF do paciente: ").strip()
        
        resultados = self.db.executar_consulta(QUERY_SELECT_PATIENT_BY_CPF, (cpf,))
        
        if not resultados:
            print("\n✗ Paciente não encontrado!")
            return
        
        row = resultados[0]
        print("\n" + "="*60)
        print("   DADOS DO PACIENTE")
        print("="*60)
        print(f"CPF: {row[0]}")
        print(f"Nome: {row[1]}")
        print(f"Data Nascimento: {row[2]}")
        print(f"Idade: {int(row[3])} anos" if row[3] else "Idade: N/A")
        print(f"Sexo: {row[4]}")
        print(f"Endereço: {row[5]}, {row[6]} - {row[7]}")
        print(f"Cidade/UF: {row[8]}/{row[9]}")
        print(f"CEP: {row[10]}")