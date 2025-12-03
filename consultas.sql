-- ============================================================================
-- Sistema de Monitoramento de Saúde Pública
-- Consultas SQL - PostgreSQL
-- Grupo 8 - SSC0540 Bases de Dados
-- ============================================================================

-- Consulta 1: Consultar dados de Pacientes
SELECT 
    CPF,
    Nome_Completo,
    Data_Nascimento,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, Data_Nascimento)) AS Idade,
    Sexo,
    Rua,
    Numero,
    Bairro,
    Cidade,
    Estado,
    CEP
FROM PACIENTE
ORDER BY Nome_Completo;

-- Consulta 2: Consultar dados de Profissionais de Saúde
SELECT 
    PR.CPF,
    PR.Nome_Completo,
    PR.Registro_Profissional,
    STRING_AGG(E.Especialidades, ', ' ORDER BY E.Especialidades) AS Especialidades
FROM PROFISSIONAL PR
LEFT JOIN ESPECIALIDADES E ON PR.CPF = E.CPF_Profissional
GROUP BY PR.CPF, PR.Nome_Completo, PR.Registro_Profissional
ORDER BY PR.Nome_Completo;

-- Consulta 3: Consultar status de Leitos
SELECT 
    U.Nome AS Unidade,
    L.CNPJ_Unidade,
    L.Codigo_Interno,
    L.Tipo,
    L.Status
FROM LEITO L
JOIN UNIDADE_SAUDE U ON L.CNPJ_Unidade = U.CNPJ
ORDER BY U.Nome, L.Codigo_Interno;

-- Consulta 4: Consultar quantidade de materiais em estoque
SELECT 
    M.Codigo,
    M.Nome,
    M.Descricao,
    M.Qtd_Estoque,
    M.Data_Validade,
    CASE 
        WHEN EXISTS (SELECT 1 FROM MEDICAMENTO WHERE Codigo_Material = M.Codigo) THEN 'Medicamento'
        WHEN EXISTS (SELECT 1 FROM INSUMO WHERE Codigo_Material = M.Codigo) THEN 'Insumo'
        ELSE 'Outro'
    END AS Tipo_Material
FROM MATERIAL M
ORDER BY M.Nome;

-- Consulta 5: Trajetória completa de um paciente (histórico de atendimentos)
SELECT 
    P.Nome_Completo AS Paciente,
    A.Data_Hora,
    A.Tipo AS Tipo_Atendimento,
    PR.Nome_Completo AS Profissional_Responsavel,
    U.Nome AS Unidade,
    U.Tipo AS Tipo_Unidade
FROM ATENDIMENTO A
JOIN PACIENTE P ON A.CPF_Paciente = P.CPF
JOIN PROFISSIONAL PR ON A.CPF_Profissional = PR.CPF
JOIN UNIDADE_SAUDE U ON A.CNPJ_Unidade = U.CNPJ
WHERE P.CPF = '123.456.789-01'  -- Trocar pelo CPF desejado
ORDER BY A.Data_Hora DESC;

-- Consulta 6: Demanda por especialidades médicas em cada região
SELECT 
    U.Cidade,
    U.Estado,
    E.Especialidades,
    COUNT(DISTINCT A.ID_Atendimento) AS Total_Atendimentos,
    COUNT(DISTINCT A.CPF_Paciente) AS Pacientes_Unicos
FROM ATENDIMENTO A
JOIN PROFISSIONAL PR ON A.CPF_Profissional = PR.CPF
JOIN ESPECIALIDADES E ON PR.CPF = E.CPF_Profissional
JOIN UNIDADE_SAUDE U ON A.CNPJ_Unidade = U.CNPJ
GROUP BY U.Cidade, U.Estado, E.Especialidades
ORDER BY U.Cidade, Total_Atendimentos DESC;

-- Consulta 7: Taxa de ocupação de leitos (geral e por tipo)
SELECT 
    U.Nome AS Unidade,
    L.Tipo AS Tipo_Leito,
    COUNT(*) AS Total_Leitos,
    SUM(CASE WHEN L.Status = 'Ocupado' THEN 1 ELSE 0 END) AS Leitos_Ocupados,
    ROUND(
        (SUM(CASE WHEN L.Status = 'Ocupado' THEN 1 ELSE 0 END)::NUMERIC / COUNT(*)) * 100, 
        2
    ) AS Taxa_Ocupacao_Percentual
FROM UNIDADE_SAUDE U
JOIN LEITO L ON U.CNPJ = L.CNPJ_Unidade
GROUP BY U.Nome, L.Tipo
ORDER BY U.Nome, L.Tipo;

-- Consulta 8: Materiais com estoque crítico ou próximos da validade
SELECT 
    M.Codigo,
    M.Nome,
    M.Qtd_Estoque,
    M.Data_Validade,
    CASE 
        WHEN EXISTS (SELECT 1 FROM MEDICAMENTO WHERE Codigo_Material = M.Codigo) THEN 'Medicamento'
        WHEN EXISTS (SELECT 1 FROM INSUMO WHERE Codigo_Material = M.Codigo) THEN 'Insumo'
    END AS Tipo,
    STRING_AGG(U.Nome, ', ') AS Unidades
FROM MATERIAL M
JOIN MATERIAL_POR_UNIDADE MPU ON M.Codigo = MPU.Codigo_Material
JOIN UNIDADE_SAUDE U ON MPU.CNPJ_Unidade = U.CNPJ
WHERE M.Qtd_Estoque < 2000 
   OR (M.Data_Validade IS NOT NULL 
       AND M.Data_Validade < CURRENT_DATE + INTERVAL '3 months')
GROUP BY M.Codigo, M.Nome, M.Qtd_Estoque, M.Data_Validade
ORDER BY M.Qtd_Estoque, M.Data_Validade;

-- Consulta 9: Relatório de filas de espera por unidade e tipo de atendimento
SELECT 
    U.Nome AS Unidade,
    F.Tipo_Atendimento,
    COUNT(*) AS Tamanho_Fila,
    ROUND(AVG(EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - F.Data_Entrada)) / 86400), 2) AS Tempo_Medio_Espera_Dias
FROM FILA_ESPERA F
JOIN UNIDADE_SAUDE U ON F.CNPJ_Unidade = U.CNPJ
GROUP BY U.Nome, F.Tipo_Atendimento
ORDER BY Tempo_Medio_Espera_Dias DESC;

-- Consulta 10: Detalhamento da fila de espera com posição de cada paciente
SELECT 
    P.Nome_Completo AS Paciente,
    F.Tipo_Atendimento,
    F.Prioridade,
    F.Data_Entrada,
    U.Nome AS Unidade,
    ROW_NUMBER() OVER (
        PARTITION BY F.CNPJ_Unidade, F.Tipo_Atendimento 
        ORDER BY F.Prioridade DESC, F.Data_Entrada ASC
    ) AS Posicao_Fila
FROM FILA_ESPERA F
JOIN PACIENTE P ON F.CPF_Paciente = P.CPF
JOIN UNIDADE_SAUDE U ON F.CNPJ_Unidade = U.CNPJ
ORDER BY U.Nome, F.Tipo_Atendimento, Posicao_Fila;

-- Consulta 11: Materiais disponíveis em todas unidades de saúde
SELECT 
    M.Codigo,
    M.Nome,
    M.Descricao
FROM MATERIAL M
JOIN MATERIAL_POR_UNIDADE MPU ON M.Codigo = MPU.Codigo_Material
GROUP BY M.Codigo, M.Nome, M.Descricao
HAVING COUNT(DISTINCT MPU.CNPJ_Unidade) = (
    SELECT COUNT(*) FROM UNIDADE_SAUDE
)
ORDER BY M.Nome;