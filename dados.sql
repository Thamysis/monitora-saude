-- ============================================================================
-- Sistema de Monitoramento de Saúde Pública
-- Dados de Exemplo para PostgreSQL
-- Grupo 8 - SSC0540 Bases de Dados
-- ============================================================================

-- Limpar dados existentes (se houver)
TRUNCATE TABLE FILA_ESPERA, OCUPACAO_LEITO, ATENDIMENTO, MATERIAL_POR_UNIDADE,
               INSUMO, MEDICAMENTO, MATERIAL, LEITO, PROFISSIONAL_POR_UNIDADE,
               ESPECIALIDADES, PROFISSIONAL, COMORBIDADE_PACIENTE, PACIENTE,
               UNIDADE_SAUDE RESTART IDENTITY CASCADE;

-- ============================================================================
-- INSERÇÃO DE DADOS - UNIDADES DE SAÚDE
-- ============================================================================

INSERT INTO UNIDADE_SAUDE (CNPJ, Nome, Tipo, Rua, Numero, Bairro, Cidade, Estado, CEP) VALUES
('12.345.678/0001-90', 'Hospital Central São Carlos', 'Hospital Geral', 'Av. São Carlos', '1500', 'Centro', 'São Carlos', 'SP', '13560-000'),
('23.456.789/0001-01', 'UPA Santa Felícia', 'UPA', 'Rua das Flores', '850', 'Santa Felícia', 'São Carlos', 'SP', '13564-200'),
('34.567.890/0001-12', 'Posto de Saúde Vila Prado', 'Posto de Saúde', 'Rua XV de Novembro', '320', 'Vila Prado', 'São Carlos', 'SP', '13574-000'),
('45.678.901/0001-23', 'Hospital Especializado Coração', 'Hospital Especializado', 'Av. Trabalhador São-carlense', '2100', 'Centro', 'São Carlos', 'SP', '13566-590'),
('56.789.012/0001-34', 'Clínica Pediátrica Infantil', 'Clínica', 'Rua Episcopal', '1450', 'Centro', 'São Carlos', 'SP', '13560-000');

-- ============================================================================
-- INSERÇÃO DE DADOS - PACIENTES
-- ============================================================================

INSERT INTO PACIENTE (CPF, Nome_Completo, Data_Nascimento, Sexo, Rua, Numero, Bairro, Cidade, Estado, CEP) VALUES
('123.456.789-01', 'Maria Silva Santos', '1985-03-15', 'F', 'Rua Sete de Setembro', '123', 'Centro', 'São Carlos', 'SP', '13560-180'),
('234.567.890-12', 'João Pedro Oliveira', '1992-07-22', 'M', 'Av. Francisco Pereira Lopes', '456', 'Jardim Paulista', 'São Carlos', 'SP', '13563-000'),
('345.678.901-23', 'Ana Carolina Costa', '2015-11-10', 'F', 'Rua Major José Inácio', '789', 'Centro', 'São Carlos', 'SP', '13560-161'),
('456.789.012-34', 'Carlos Eduardo Mendes', '1978-05-30', 'M', 'Rua Nove de Julho', '234', 'Vila Prado', 'São Carlos', 'SP', '13574-000'),
('567.890.123-45', 'Juliana Ferreira Lima', '1990-12-05', 'F', 'Av. São Carlos', '567', 'Centro', 'São Carlos', 'SP', '13560-002'),
('678.901.234-56', 'Roberto Alves Souza', '1965-08-18', 'M', 'Rua Episcopal', '890', 'Centro', 'São Carlos', 'SP', '13560-000'),
('789.012.345-67', 'Fernanda Rodrigues', '2008-02-25', 'F', 'Rua São Joaquim', '345', 'Vila Prado', 'São Carlos', 'SP', '13574-120'),
('890.123.456-78', 'Pedro Henrique Santos', '1982-09-12', 'M', 'Rua Conde do Pinhal', '678', 'Centro', 'São Carlos', 'SP', '13560-140'),
('901.234.567-89', 'Beatriz Almeida Costa', '1995-04-08', 'F', 'Av. Trabalhador São-carlense', '901', 'Centro', 'São Carlos', 'SP', '13566-590'),
('012.345.678-90', 'Lucas Martins Pereira', '2010-06-20', 'M', 'Rua Major José Inácio', '123', 'Centro', 'São Carlos', 'SP', '13560-161');

-- ============================================================================
-- INSERÇÃO DE DADOS - COMORBIDADES DOS PACIENTES
-- ============================================================================

INSERT INTO COMORBIDADE_PACIENTE (CPF_Paciente, Comorbidade) VALUES
('123.456.789-01', 'Hipertensão'),
('123.456.789-01', 'Diabetes Tipo 2'),
('456.789.012-34', 'Hipertensão'),
('456.789.012-34', 'Colesterol Alto'),
('456.789.012-34', 'Obesidade'),
('567.890.123-45', 'Asma'),
('678.901.234-56', 'Diabetes Tipo 2'),
('678.901.234-56', 'Hipertensão'),
('678.901.234-56', 'Insuficiência Cardíaca'),
('890.123.456-78', 'Hipertensão');

-- ============================================================================
-- INSERÇÃO DE DADOS - PROFISSIONAIS DE SAÚDE
-- ============================================================================

INSERT INTO PROFISSIONAL (CPF, Nome_Completo, Registro_Profissional) VALUES
('111.222.333-44', 'Dra. Carla Mendes Silva', 'CRM-SP 123456'),
('222.333.444-55', 'Dr. Ricardo Alves Costa', 'CRM-SP 234567'),
('333.444.555-66', 'Enf. Juliana Santos Lima', 'COREN-SP 345678'),
('444.555.666-77', 'Dr. Fernando Oliveira Souza', 'CRM-SP 456789'),
('555.666.777-88', 'Dra. Patrícia Rodrigues Martins', 'CRM-SP 567890'),
('666.777.888-99', 'Enf. Marcos Paulo Santos', 'COREN-SP 678901'),
('777.888.999-00', 'Dr. André Luiz Pereira', 'CRM-SP 789012'),
('888.999.000-11', 'Dra. Camila Ferreira Costa', 'CRM-SP 890123'),
('999.000.111-22', 'Fisio. Bruno Henrique Silva', 'CREFITO-SP 901234'),
('000.111.222-33', 'Dra. Laura Beatriz Almeida', 'CRM-SP 012345');

-- ============================================================================
-- INSERÇÃO DE DADOS - ESPECIALIDADES DOS PROFISSIONAIS
-- ============================================================================

INSERT INTO ESPECIALIDADES (CPF_Profissional, Especialidades) VALUES
('111.222.333-44', 'Cardiologia'),
('111.222.333-44', 'Clínica Médica'),
('222.333.444-55', 'Pediatria'),
('333.444.555-66', 'Enfermagem Geral'),
('333.444.555-66', 'UTI'),
('444.555.666-77', 'Ortopedia'),
('444.555.666-77', 'Traumatologia'),
('555.666.777-88', 'Ginecologia'),
('555.666.777-88', 'Obstetrícia'),
('666.777.888-99', 'Enfermagem Pediátrica'),
('777.888.999-00', 'Clínica Médica'),
('888.999.000-11', 'Neurologia'),
('999.000.111-22', 'Fisioterapia Respiratória'),
('000.111.222-33', 'Pediatria'),
('000.111.222-33', 'Neonatologia');

-- ============================================================================
-- INSERÇÃO DE DADOS - PROFISSIONAIS POR UNIDADE
-- ============================================================================

INSERT INTO PROFISSIONAL_POR_UNIDADE (CPF_Profissional, CNPJ_Unidade) VALUES
('111.222.333-44', '12.345.678/0001-90'),
('111.222.333-44', '45.678.901/0001-23'),
('222.333.444-55', '12.345.678/0001-90'),
('222.333.444-55', '56.789.012/0001-34'),
('333.444.555-66', '12.345.678/0001-90'),
('333.444.555-66', '23.456.789/0001-01'),
('444.555.666-77', '12.345.678/0001-90'),
('555.666.777-88', '12.345.678/0001-90'),
('666.777.888-99', '56.789.012/0001-34'),
('777.888.999-00', '23.456.789/0001-01'),
('777.888.999-00', '34.567.890/0001-12'),
('888.999.000-11', '12.345.678/0001-90'),
('999.000.111-22', '12.345.678/0001-90'),
('000.111.222-33', '56.789.012/0001-34');

-- ============================================================================
-- INSERÇÃO DE DADOS - LEITOS
-- ============================================================================

INSERT INTO LEITO (CNPJ_Unidade, Codigo_Interno, Tipo, Status) VALUES
('12.345.678/0001-90', 'UTI-001', 'UTI', 'Disponível'),
('12.345.678/0001-90', 'UTI-002', 'UTI', 'Ocupado'),
('12.345.678/0001-90', 'UTI-003', 'UTI', 'Ocupado'),
('12.345.678/0001-90', 'ENF-101', 'Enfermaria', 'Disponível'),
('12.345.678/0001-90', 'ENF-102', 'Enfermaria', 'Ocupado'),
('12.345.678/0001-90', 'ENF-103', 'Enfermaria', 'Disponível'),
('12.345.678/0001-90', 'ISO-201', 'Isolamento', 'Manutenção'),
('12.345.678/0001-90', 'PED-301', 'Pediátrico', 'Disponível'),
('12.345.678/0001-90', 'PED-302', 'Pediátrico', 'Ocupado'),
('23.456.789/0001-01', 'OBS-001', 'Enfermaria', 'Disponível'),
('23.456.789/0001-01', 'OBS-002', 'Enfermaria', 'Ocupado'),
('23.456.789/0001-01', 'OBS-003', 'Enfermaria', 'Disponível'),
('45.678.901/0001-23', 'CAR-001', 'UTI', 'Disponível'),
('45.678.901/0001-23', 'CAR-002', 'UTI', 'Ocupado'),
('56.789.012/0001-34', 'PED-001', 'Pediátrico', 'Disponível');

-- ============================================================================
-- INSERÇÃO DE DADOS - MATERIAIS
-- ============================================================================

INSERT INTO MATERIAL (Codigo, Nome, Descricao, Data_Validade, Qtd_Estoque) VALUES
('MED-001', 'Paracetamol 500mg', 'Analgésico e antitérmico', '2026-12-31', 5000),
('MED-002', 'Ibuprofeno 600mg', 'Anti-inflamatório não esteroidal', '2026-08-15', 3000),
('MED-003', 'Amoxicilina 500mg', 'Antibiótico de amplo espectro', '2025-06-30', 2500),
('MED-004', 'Dipirona 500mg', 'Analgésico e antitérmico', '2026-10-20', 4500),
('MED-005', 'Losartana 50mg', 'Anti-hipertensivo', '2027-03-15', 3500),
('INS-001', 'Luvas Cirúrgicas', 'Luvas de látex esterilizadas tamanho M', '2025-12-31', 10000),
('INS-002', 'Máscaras N95', 'Máscara de proteção respiratória', '2026-06-30', 8000),
('INS-003', 'Seringas 5ml', 'Seringas descartáveis estéreis', '2027-01-31', 15000),
('INS-004', 'Gazes Estéreis', 'Compressas de gaze 7,5x7,5cm', '2026-09-30', 5000),
('INS-005', 'Álcool 70%', 'Álcool etílico para assepsia', '2025-11-30', 2000);

-- ============================================================================
-- INSERÇÃO DE DADOS - MEDICAMENTOS (Subclasse)
-- ============================================================================

INSERT INTO MEDICAMENTO (Codigo_Material, Principio_Ativo, Concentracao) VALUES
('MED-001', 'Paracetamol', '500mg'),
('MED-002', 'Ibuprofeno', '600mg'),
('MED-003', 'Amoxicilina', '500mg'),
('MED-004', 'Dipirona Sódica', '500mg'),
('MED-005', 'Losartana Potássica', '50mg');

-- ============================================================================
-- INSERÇÃO DE DADOS - INSUMOS (Subclasse)
-- ============================================================================

INSERT INTO INSUMO (Codigo_Material, Tipo) VALUES
('INS-001', 'Material de proteção individual'),
('INS-002', 'Material de proteção individual'),
('INS-003', 'Material para administração de medicamentos'),
('INS-004', 'Material para curativos e feridas'),
('INS-005', 'Material de higiene e limpeza');

-- ============================================================================
-- INSERÇÃO DE DADOS - MATERIAL POR UNIDADE
-- ============================================================================

INSERT INTO MATERIAL_POR_UNIDADE (Codigo_Material, CNPJ_Unidade) VALUES
('MED-001', '12.345.678/0001-90'),
('MED-001', '23.456.789/0001-01'),
('MED-001', '34.567.890/0001-12'),
('MED-002', '12.345.678/0001-90'),
('MED-002', '23.456.789/0001-01'),
('MED-003', '12.345.678/0001-90'),
('MED-003', '34.567.890/0001-12'),
('MED-004', '12.345.678/0001-90'),
('MED-004', '23.456.789/0001-01'),
('MED-004', '56.789.012/0001-34'),
('MED-005', '12.345.678/0001-90'),
('MED-005', '45.678.901/0001-23'),
('INS-001', '12.345.678/0001-90'),
('INS-001', '23.456.789/0001-01'),
('INS-001', '45.678.901/0001-23'),
('INS-002', '12.345.678/0001-90'),
('INS-002', '23.456.789/0001-01'),
('INS-003', '12.345.678/0001-90'),
('INS-003', '23.456.789/0001-01'),
('INS-003', '34.567.890/0001-12'),
('INS-004', '12.345.678/0001-90'),
('INS-004', '23.456.789/0001-01'),
('INS-005', '12.345.678/0001-90'),
('INS-005', '23.456.789/0001-01'),
('INS-005', '34.567.890/0001-12');

-- ============================================================================
-- INSERÇÃO DE DADOS - ATENDIMENTOS
-- ============================================================================

INSERT INTO ATENDIMENTO (Data_Hora, Tipo, CPF_Paciente, CPF_Profissional, CNPJ_Unidade) VALUES
('2024-11-01 08:30:00', 'Consulta', '123.456.789-01', '111.222.333-44', '12.345.678/0001-90'),
('2024-11-02 10:15:00', 'Consulta', '234.567.890-12', '222.333.444-55', '56.789.012/0001-34'),
('2024-11-03 14:00:00', 'Emergência', '456.789.012-34', '111.222.333-44', '23.456.789/0001-01'),
('2024-11-03 16:45:00', 'Internação', '456.789.012-34', '111.222.333-44', '12.345.678/0001-90'),
('2024-11-05 09:00:00', 'Consulta', '345.678.901-23', '222.333.444-55', '56.789.012/0001-34'),
('2024-11-06 11:30:00', 'Emergência', '678.901.234-56', '111.222.333-44', '45.678.901/0001-23'),
('2024-11-06 13:00:00', 'Internação', '678.901.234-56', '111.222.333-44', '45.678.901/0001-23'),
('2024-11-08 15:20:00', 'Consulta', '567.890.123-45', '555.666.777-88', '12.345.678/0001-90'),
('2024-11-10 08:45:00', 'Internação', '789.012.345-67', '222.333.444-55', '12.345.678/0001-90'),
('2024-11-12 10:00:00', 'Consulta', '890.123.456-78', '777.888.999-00', '23.456.789/0001-01'),
('2024-11-14 14:30:00', 'Emergência', '901.234.567-89', '888.999.000-11', '12.345.678/0001-90'),
('2024-11-15 09:15:00', 'Consulta', '012.345.678-90', '000.111.222-33', '56.789.012/0001-34'),
('2024-11-18 11:00:00', 'Internação', '234.567.890-12', '333.444.555-66', '23.456.789/0001-01'),
('2024-11-20 16:00:00', 'Consulta', '123.456.789-01', '111.222.333-44', '45.678.901/0001-23'),
('2024-11-22 10:30:00', 'Emergência', '345.678.901-23', '222.333.444-55', '12.345.678/0001-90');

-- ============================================================================
-- INSERÇÃO DE DADOS - OCUPAÇÃO DE LEITOS
-- ============================================================================

INSERT INTO OCUPACAO_LEITO (CPF_Paciente, CNPJ_Leito, Codigo_Interno_Leito, Data_Hora_Inicio, Data_Hora_Fim) VALUES
('456.789.012-34', '12.345.678/0001-90', 'UTI-002', '2024-11-03 17:00:00', NULL),
('678.901.234-56', '45.678.901/0001-23', 'CAR-002', '2024-11-06 13:30:00', NULL),
('789.012.345-67', '12.345.678/0001-90', 'PED-302', '2024-11-10 09:00:00', NULL),
('234.567.890-12', '23.456.789/0001-01', 'OBS-002', '2024-11-18 11:30:00', NULL),
('123.456.789-01', '12.345.678/0001-90', 'ENF-102', '2024-10-15 08:00:00', '2024-10-20 14:00:00'),
('567.890.123-45', '12.345.678/0001-90', 'UTI-003', '2024-10-25 10:00:00', NULL),
('890.123.456-78', '12.345.678/0001-90', 'ENF-101', '2024-09-10 12:00:00', '2024-09-18 10:00:00');

-- ============================================================================
-- INSERÇÃO DE DADOS - FILA DE ESPERA
-- ============================================================================

INSERT INTO FILA_ESPERA (Tipo_Atendimento, Prioridade, Data_Entrada, CPF_Paciente, CNPJ_Unidade) VALUES
('Consulta Cardiologia', 2, '2024-11-20 08:00:00', '123.456.789-01', '12.345.678/0001-90'),
('Consulta Pediatria', 1, '2024-11-21 09:00:00', '345.678.901-23', '56.789.012/0001-34'),
('Emergência', 5, '2024-11-22 14:30:00', '901.234.567-89', '23.456.789/0001-01'),
('Consulta Ortopedia', 2, '2024-11-23 10:00:00', '234.567.890-12', '12.345.678/0001-90'),
('Consulta Clínica Médica', 1, '2024-11-23 11:00:00', '890.123.456-78', '34.567.890/0001-12'),
('Emergência', 4, '2024-11-24 07:00:00', '012.345.678-90', '23.456.789/0001-01'),
('Consulta Neurologia', 2, '2024-11-24 13:00:00', '567.890.123-45', '12.345.678/0001-90'),
('Consulta Pediatria', 3, '2024-11-25 08:30:00', '789.012.345-67', '56.789.012/0001-34');

-- ============================================================================
-- VERIFICAÇÃO DOS DADOS INSERIDOS
-- ============================================================================

DO $$
BEGIN
    RAISE NOTICE '============================================';
    RAISE NOTICE '  Dados inseridos com sucesso!';
    RAISE NOTICE '============================================';
    RAISE NOTICE 'Unidades de Saúde: %', (SELECT COUNT(*) FROM UNIDADE_SAUDE);
    RAISE NOTICE 'Pacientes: %', (SELECT COUNT(*) FROM PACIENTE);
    RAISE NOTICE 'Profissionais: %', (SELECT COUNT(*) FROM PROFISSIONAL);
    RAISE NOTICE 'Leitos: %', (SELECT COUNT(*) FROM LEITO);
    RAISE NOTICE 'Materiais: %', (SELECT COUNT(*) FROM MATERIAL);
    RAISE NOTICE 'Atendimentos: %', (SELECT COUNT(*) FROM ATENDIMENTO);
    RAISE NOTICE 'Ocupações de Leito: %', (SELECT COUNT(*) FROM OCUPACAO_LEITO);
    RAISE NOTICE 'Filas de Espera: %', (SELECT COUNT(*) FROM FILA_ESPERA);
    RAISE NOTICE '============================================';
END $$;