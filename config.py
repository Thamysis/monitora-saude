# Configurações do banco de dados
DB_HOST = "localhost"
DB_DATABASE = "saude_publica"
DB_USER = "postgres"
DB_PASSWORD = "password"  # ALTERAR AQUI PARA A SENHA DO SEU DATABASE
DB_PORT = "5432"

SYSTEM_NAME = "   SISTEMA DE SAÚDE PÚBLICA - SÃO CARLOS"
CLOSING_SYSTEM = "\n✓ Encerrando sistema..."

# Mensagens
MESSAGE_SUCCESS_CONNECT = "✓ Conexão estabelecida com sucesso!"
MESSAGE_CONNECTION_CLOSED = "✓ Conexão encerrada."
MESSAGE_ERROR_CONNECT = "\n✗ Erro ao conectar ao banco de dados "
MESSAGE_ERROR_QUERY = "\n✗ Erro ao rodar query: "

MESSAGE_ENTER_TO_CONTINUE = "\nPressione Enter para continuar..."
VERIFY_SETTINGS = "Verifique as configurações em database.py"

# Menu
MENU_OPTION_1 = "1. Cadastrar Paciente"
MENU_OPTION_2 = "2. Consultar Todos os Pacientes"
MENU_OPTION_3 = "3. Consultar Paciente por CPF"
MENU_OPTION_4 = "4. Registrar Atendimento"
MENU_OPTION_5 = "5. Consultar Histórico de Paciente"
MENU_OPTION_6 = "6. Consultar Taxa de Ocupação de Leitos"
MENU_OPTION_7 = "7. Consultar Fila de Espera"
MENU_OPTION_0 = "0. Sair"

SELECT_OPTION = "Escolha uma opção: "
INVALID_OPTION = "\n✗ Opção inválida!"

# Atendimento
REGISTER_SERVICE = "   REGISTRAR ATENDIMENTO"
SERVICE_HISTORY = "   HISTÓRICO DE ATENDIMENTOS"
        
QUERY_INSERT_ATENDIMENTO = """
            INSERT INTO ATENDIMENTO 
            (Data_Hora, Tipo, CPF_Paciente, CPF_Profissional, CNPJ_Unidade)
            VALUES (%s, %s, %s, %s, %s)
        """
       
QUERY_SELECT_ATENDIMENTO = """
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
        
QUERY_SELECT_OCUPATION_RATE = """
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
        
QUERY_WAIT_QUEUE = """
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
# Paciente
QUERY_INSERT_PATIENT = """
            INSERT INTO PACIENTE 
            (CPF, Nome_Completo, Data_Nascimento, Sexo, Rua, Numero, Bairro, Cidade, Estado, CEP)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

QUERY_SELECT_PATIENT_BY_AGE = """
            SELECT 
                CPF,
                Nome_Completo,
                EXTRACT(YEAR FROM AGE(CURRENT_DATE, Data_Nascimento)) AS Idade,
                Sexo,
                Cidade,
                Estado
            FROM PACIENTE
            ORDER BY Nome_Completo
        """
        
QUERY_SELECT_PATIENT_BY_CPF = """
            SELECT 
                P.CPF, P.Nome_Completo, P.Data_Nascimento,
                EXTRACT(YEAR FROM AGE(CURRENT_DATE, P.Data_Nascimento)) AS Idade,
                P.Sexo, P.Rua, P.Numero, P.Bairro, P.Cidade, P.Estado, P.CEP
            FROM PACIENTE P
            WHERE P.CPF = %s
        """