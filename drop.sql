-- ============================================================================
-- Sistema de Monitoramento de Saúde Pública
-- Apagar Todas as Tabelas do Sistema - PostgreSQL
-- Grupo 8 - SSC0540 Bases de Dados
-- ============================================================================

-- Apagar todas as tabelas na ordem correta (CASCADE remove dependências)
DROP TABLE IF EXISTS FILA_ESPERA CASCADE;
DROP TABLE IF EXISTS OCUPACAO_LEITO CASCADE;
DROP TABLE IF EXISTS ATENDIMENTO CASCADE;
DROP TABLE IF EXISTS MATERIAL_POR_UNIDADE CASCADE;
DROP TABLE IF EXISTS INSUMO CASCADE;
DROP TABLE IF EXISTS MEDICAMENTO CASCADE;
DROP TABLE IF EXISTS MATERIAL CASCADE;
DROP TABLE IF EXISTS LEITO CASCADE;
DROP TABLE IF EXISTS PROFISSIONAL_POR_UNIDADE CASCADE;
DROP TABLE IF EXISTS ESPECIALIDADES CASCADE;
DROP TABLE IF EXISTS PROFISSIONAL CASCADE;
DROP TABLE IF EXISTS COMORBIDADE_PACIENTE CASCADE;
DROP TABLE IF EXISTS PACIENTE CASCADE;
DROP TABLE IF EXISTS UNIDADE_SAUDE CASCADE;

-- Mensagem de confirmação
DO $$ 
BEGIN
    RAISE NOTICE '============================================';
    RAISE NOTICE '  Todas as tabelas foram removidas!';
    RAISE NOTICE '============================================';
END $$;