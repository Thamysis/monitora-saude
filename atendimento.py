from datetime import datetime
from config import *

class Atendimento:
    def __init__(self, db):
        self.db = db
    
    def registrar(self):
        """Registra um novo atendimento"""
        print("\n" + "="*60)
        print("   REGISTRAR ATENDIMENTO")
        print("="*60)
        
        cpf_paciente = input("CPF do Paciente: ").strip()
        cpf_profissional = input("CPF do Profissional: ").strip()
        cnpj_unidade = input("CNPJ da Unidade: ").strip()
        tipo = input("Tipo (Consulta/Emergência/Internação): ").strip()
        
        data_hora = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        params = (data_hora, tipo, cpf_paciente, cpf_profissional, cnpj_unidade)
        
        if self.db.executar_query(QUERY_INSERT_ATENDIMENTO, params):
            print(f"\n✓ Atendimento registrado com sucesso! ({data_hora})")
        else:
            print("\n✗ Erro ao registrar atendimento.")
    
    def consultar_historico(self):
        """Consulta o histórico de atendimentos de um paciente"""
        cpf = input("\nDigite o CPF do paciente: ").strip()
        
        resultados = self.db.executar_consulta(QUERY_SELECT_ATENDIMENTO, (cpf,))
        
        if not resultados:
            print("\n✗ Nenhum atendimento encontrado para este paciente.")
            return
        
        print("\n" + "="*60)
        print(f"   HISTÓRICO DE ATENDIMENTOS")
        print("="*60)
        print(f"Paciente: {resultados[0][0]}\n")
        print(f"{'Data/Hora':<20} {'Tipo':<15} {'Profissional':<25} {'Unidade':<25}")
        print("-"*90)
        
        for row in resultados:
            data_hora = row[1].strftime("%Y-%m-%d %H:%M:%S") if hasattr(row[1], 'strftime') else str(row[1])
            print(f"{data_hora:<20} {row[2]:<15} {row[3]:<25} {row[4]:<25}")
        
        print(f"\nTotal: {len(resultados)} atendimento(s)")
    
    def consultar_taxa_ocupacao(self):
        """Consulta a taxa de ocupação de leitos"""
                
        resultados = self.db.executar_consulta(QUERY_SELECT_OCUPATION_RATE)
        
        print("\n" + "="*60)
        print("   TAXA DE OCUPAÇÃO DE LEITOS")
        print("="*60)
        print(f"{'Unidade':<35} {'Tipo Leito':<15} {'Total':<8} {'Ocupados':<10} {'Taxa (%)':<10}")
        print("-"*90)
        
        for row in resultados:
            print(f"{row[0]:<35} {row[1]:<15} {row[2]:<8} {row[3]:<10} {row[4]:<10}")
    
    def consultar_fila_espera(self):
        """Consulta a fila de espera com posição calculada"""
        
        resultados = self.db.executar_consulta(QUERY_WAIT_QUEUE)
        
        print("\n" + "="*60)
        print("   FILA DE ESPERA")
        print("="*60)
        print(f"{'Pos':<5} {'Paciente':<30} {'Tipo Atendimento':<20} {'Prior':<6} {'Unidade':<25}")
        print("-"*90)
        
        for row in resultados:
            print(f"{row[4]:<5} {row[0]:<30} {row[1]:<20} {row[2]:<6} {row[3]:<25}")
        
        print(f"\nTotal: {len(resultados)} paciente(s) na fila")