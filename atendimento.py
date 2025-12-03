from datetime import datetime

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
        
        query = """
            INSERT INTO ATENDIMENTO 
            (Data_Hora, Tipo, CPF_Paciente, CPF_Profissional, CNPJ_Unidade)
            VALUES (%s, %s, %s, %s, %s)
        """
        
        params = (data_hora, tipo, cpf_paciente, cpf_profissional, cnpj_unidade)
        
        if self.db.executar_query(query, params):
            print(f"\n✓ Atendimento registrado com sucesso! ({data_hora})")
        else:
            print("\n✗ Erro ao registrar atendimento.")
    
    def consultar_historico(self):
        """Consulta o histórico de atendimentos de um paciente"""
        cpf = input("\nDigite o CPF do paciente: ").strip()
        
        query = """
            SELECT 
                P.Nome_Completo AS Paciente,
                A.Data_Hora,
                A.Tipo,
                PR.Nome_Completo AS Profissional,
                U.Nome AS Unidade
            FROM ATENDIMENTO A
            JOIN PACIENTE P ON A.CPF_Paciente = P.CPF
            JOIN PROFISSIONAL PR ON A.CPF_Profissional = PR.CPF
            JOIN UNIDADE_SAUDE U ON A.CNPJ_Unidade = U.CNPJ
            WHERE P.CPF = %s
            ORDER BY A.Data_Hora DESC
        """
        
        resultados = self.db.executar_consulta(query, (cpf,))
        
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
        query = """
            SELECT 
                U.Nome AS Unidade,
                L.Tipo AS Tipo_Leito,
                COUNT(*) AS Total_Leitos,
                SUM(CASE WHEN L.Status = 'Ocupado' THEN 1 ELSE 0 END) AS Leitos_Ocupados,
                ROUND((SUM(CASE WHEN L.Status = 'Ocupado' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 2) AS Taxa_Ocupacao
            FROM UNIDADE_SAUDE U
            JOIN LEITO L ON U.CNPJ = L.CNPJ_Unidade
            GROUP BY U.Nome, L.Tipo
            ORDER BY U.Nome, L.Tipo
        """
        
        resultados = self.db.executar_consulta(query)
        
        print("\n" + "="*60)
        print("   TAXA DE OCUPAÇÃO DE LEITOS")
        print("="*60)
        print(f"{'Unidade':<35} {'Tipo Leito':<15} {'Total':<8} {'Ocupados':<10} {'Taxa (%)':<10}")
        print("-"*90)
        
        for row in resultados:
            print(f"{row[0]:<35} {row[1]:<15} {row[2]:<8} {row[3]:<10} {row[4]:<10}")
    
    def consultar_fila_espera(self):
        """Consulta a fila de espera com posição calculada"""
        query = """
            SELECT 
                P.Nome_Completo AS Paciente,
                F.Tipo_Atendimento,
                F.Prioridade,
                U.Nome AS Unidade,
                ROW_NUMBER() OVER (
                    PARTITION BY F.CNPJ_Unidade, F.Tipo_Atendimento 
                    ORDER BY F.Prioridade DESC, F.Data_Entrada ASC
                ) AS Posicao
            FROM FILA_ESPERA F
            JOIN PACIENTE P ON F.CPF_Paciente = P.CPF
            JOIN UNIDADE_SAUDE U ON F.CNPJ_Unidade = U.CNPJ
            ORDER BY U.Nome, F.Tipo_Atendimento, Posicao
        """
        
        resultados = self.db.executar_consulta(query)
        
        print("\n" + "="*60)
        print("   FILA DE ESPERA")
        print("="*60)
        print(f"{'Pos':<5} {'Paciente':<30} {'Tipo Atendimento':<20} {'Prior':<6} {'Unidade':<25}")
        print("-"*90)
        
        for row in resultados:
            print(f"{row[4]:<5} {row[0]:<30} {row[1]:<20} {row[2]:<6} {row[3]:<25}")
        
        print(f"\nTotal: {len(resultados)} paciente(s) na fila")