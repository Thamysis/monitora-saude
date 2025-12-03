CREATE TABLE PACIENTE (
    CPF              VARCHAR(14) PRIMARY KEY,
    Nome_Completo    VARCHAR(120) NOT NULL,
    Data_Nascimento  DATE NOT NULL,
    Sexo             CHAR(1),
    Rua              VARCHAR(120),
    Numero           VARCHAR(10),
    Bairro           VARCHAR(80),
    Cidade           VARCHAR(80),
    Estado           CHAR(2),
    CEP              VARCHAR(9)

);
CREATE TABLE COMORBIDADE_PACIENTE (
    CPF_Paciente VARCHAR(14),
    Comorbidade  VARCHAR(120),
    PRIMARY KEY (CPF_Paciente, Comorbidade),
    FOREIGN KEY (CPF_Paciente) REFERENCES PACIENTE(CPF)
);
CREATE TABLE PROFISSIONAL (
    CPF                 VARCHAR(14) PRIMARY KEY,
    Nome_Completo       VARCHAR(120) NOT NULL,
    Registro_Profissional VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE ESPECIALIDADES (
    CPF_Profissional VARCHAR(14),
    Especialidades   VARCHAR(120),
    PRIMARY KEY (CPF_Profissional, Especialidades),
    FOREIGN KEY (CPF_Profissional) REFERENCES PROFISSIONAL(CPF)
);

CREATE TABLE UNIDADE_SAUDE (
    CNPJ      VARCHAR(18) PRIMARY KEY,
    Nome      VARCHAR(120) NOT NULL,
    Tipo      VARCHAR(50),
    Rua       VARCHAR(120),
    Numero    VARCHAR(10),
    Bairro    VARCHAR(80),
    Cidade    VARCHAR(80),
    Estado    CHAR(2),
    CEP       VARCHAR(9)
);

CREATE TABLE PROFISSIONAL_POR_UNIDADE (
    CPF_Profissional VARCHAR(14),
    CNPJ_Unidade     VARCHAR(18),
    PRIMARY KEY (CPF_Profissional, CNPJ_Unidade),
    FOREIGN KEY (CPF_Profissional) REFERENCES PROFISSIONAL(CPF),
    FOREIGN KEY (CNPJ_Unidade) REFERENCES UNIDADE_SAUDE(CNPJ)
);

CREATE TABLE LEITO (
    CNPJ_Unidade   VARCHAR(18),
    Codigo_Interno VARCHAR(20),
    Tipo           VARCHAR(50),
    Status         VARCHAR(20),
    PRIMARY KEY (CNPJ_Unidade, Codigo_Interno),
    FOREIGN KEY (CNPJ_Unidade) REFERENCES UNIDADE_SAUDE(CNPJ)
);

CREATE TABLE MATERIAL (
    Codigo       VARCHAR(20) PRIMARY KEY,
    Nome         VARCHAR(120) NOT NULL,
    Descricao    TEXT,
    Data_Validade DATE,
    Qtd_Estoque  INTEGER CHECK (Qtd_Estoque >= 0)
);

CREATE TABLE MEDICAMENTO (
    Codigo_Material VARCHAR(20) PRIMARY KEY,
    Principio_Ativo VARCHAR(120),
    Concentracao    VARCHAR(60),
    FOREIGN KEY (Codigo_Material) REFERENCES MATERIAL(Codigo)
);

CREATE TABLE INSUMO (
    Codigo_Material VARCHAR(20) PRIMARY KEY,
    Tipo            VARCHAR(60),
    FOREIGN KEY (Codigo_Material) REFERENCES MATERIAL(Codigo)
);

CREATE TABLE MATERIAL_POR_UNIDADE (
    Codigo_Material VARCHAR(20),
    CNPJ_Unidade    VARCHAR(18),
    PRIMARY KEY (Codigo_Material, CNPJ_Unidade),
    FOREIGN KEY (Codigo_Material) REFERENCES MATERIAL(Codigo),
    FOREIGN KEY (CNPJ_Unidade) REFERENCES UNIDADE_SAUDE(CNPJ)
);

CREATE TABLE ATENDIMENTO (
    ID_Atendimento SERIAL PRIMARY KEY,
    Data_Hora      TIMESTAMP NOT NULL,
    Tipo           VARCHAR(50) NOT NULL,
    CPF_Paciente   VARCHAR(14) NOT NULL,
    CPF_Profissional VARCHAR(14) NOT NULL,
    CNPJ_Unidade     VARCHAR(18) NOT NULL,
    FOREIGN KEY (CPF_Paciente)     REFERENCES PACIENTE(CPF),
    FOREIGN KEY (CPF_Profissional) REFERENCES PROFISSIONAL(CPF),
    FOREIGN KEY (CNPJ_Unidade)     REFERENCES UNIDADE_SAUDE(CNPJ)
);

CREATE TABLE OCUPACAO_LEITO (
    CPF_Paciente       VARCHAR(14),
    CNPJ_Leito         VARCHAR(18),
    Codigo_Interno_Leito VARCHAR(20),
    Data_Hora_Inicio   TIMESTAMP NOT NULL,
    Data_Hora_Fim      TIMESTAMP,
    PRIMARY KEY (CPF_Paciente, CNPJ_Leito, Codigo_Interno_Leito, Data_Hora_Inicio),
    FOREIGN KEY (CPF_Paciente) REFERENCES PACIENTE(CPF),
    FOREIGN KEY (CNPJ_Leito, Codigo_Interno_Leito)
        REFERENCES LEITO(CNPJ_Unidade, Codigo_Interno)
);

CREATE TABLE FILA_ESPERA (
    ID_Fila         SERIAL PRIMARY KEY,
    Tipo_Atendimento VARCHAR(50),
    Prioridade       INTEGER,
    Data_Entrada     TIMESTAMP NOT NULL,
    CPF_Paciente     VARCHAR(14) NOT NULL,
    CNPJ_Unidade     VARCHAR(18) NOT NULL,
    FOREIGN KEY (CPF_Paciente) REFERENCES PACIENTE(CPF),
    FOREIGN KEY (CNPJ_Unidade) REFERENCES UNIDADE_SAUDE(CNPJ)
    -- Posição é derivada e não é armazenada
);