# Sistema de Monitoramento de Saúde Pública 🏥
**Projeto - Bases de Dados - SSC0540**  
**Grupo 8 - 2025.2**

## 📋 Pré-requisitos

### 1. Python 3.8 ou superior
- Download: https://www.python.org/downloads/
- ⚠️ **IMPORTANTE:** Durante a instalação, marque "Add Python to PATH"

### 2. PostgreSQL
- Download: https://www.postgresql.org/download/windows/
- Anote a senha do usuário `postgres` durante a instalação

### 3. Biblioteca psycopg2
```bash
pip install psycopg2-binary
```

## 🔧 Configuração

### 1. Criar o banco de dados
```bash
# Abra o psql (PostgreSQL Command Line)
psql -U postgres

# Dentro do psql:
CREATE DATABASE saude_publica;
\c saude_publica
\q
```

### 2. Executar os scripts SQL
```bash
psql -U postgres -d saude_publica -f esquema.sql
psql -U postgres -d saude_publica -f dados.sql
```

### 3. Configurar a senha no código
Edite o arquivo `database.py` e altere a linha:
```python
password="sua_senha",  # ALTERE AQUI para a senha do PostgreSQL
```

## 📦 Estrutura de Arquivos

Crie os seguintes arquivos na mesma pasta:

```
sistema_saude/
├── database.py        # Módulo de conexão com banco
├── paciente.py        # Operações com pacientes
├── atendimento.py     # Operações com atendimentos
├── main.py            # Programa principal
├── esquema.sql        # Script de criação das tabelas
├── dados.sql          # Script de dados de exemplo
└── README.md          # Este arquivo
```

### Criar os arquivos Python:

**1. Copie o código marcado como `database.py`** para um arquivo chamado `database.py`

**2. Copie o código marcado como `paciente.py`** para um arquivo chamado `paciente.py`

**3. Copie o código marcado como `atendimento.py`** para um arquivo chamado `atendimento.py`

**4. Copie o código marcado como `main.py`** para um arquivo chamado `main.py`

## 🚀 Executar o Sistema

```bash
python main.py
```

## 💡 Funcionalidades Implementadas

### ✅ Cadastro
- Cadastrar novo paciente
- Registrar atendimento

### ✅ Consultas
- Listar todos os pacientes (com idade calculada - atributo derivado)
- Consultar paciente por CPF
- Histórico completo de atendimentos de um paciente
- Taxa de ocupação de leitos por unidade e tipo
- Fila de espera (com posição calculada - atributo derivado)

## 🔍 Troubleshooting

### Erro: "No module named 'psycopg2'"
```bash
pip install psycopg2-binary
```

### Erro: "could not connect to server"
- Verifique se o PostgreSQL está rodando
- No Windows: Serviços → PostgreSQL deve estar "Em execução"
- Teste a conexão: `psql -U postgres`

### Erro: "database does not exist"
```bash
psql -U postgres
CREATE DATABASE saude_publica;
```

### Erro: "relation does not exist"
- Execute os scripts SQL:
```bash
psql -U postgres -d saude_publica -f esquema.sql
psql -U postgres -d saude_publica -f dados.sql
```

### Caracteres acentuados não aparecem
- No CMD/PowerShell, execute antes de rodar:
```bash
chcp 65001
```

## 🎯 Como Usar

1. **Execute o programa:**
   ```bash
   python main.py
   ```

2. **Menu Principal:**
   - Escolha uma opção digitando o número (1-7, 0 para sair)

3. **Exemplos de uso:**
   - **Cadastrar Paciente:** Opção 1 → Preencha os dados
   - **Ver todos os pacientes:** Opção 2
   - **Histórico de paciente:** Opção 5 → Digite CPF: `123.456.789-01`
   - **Taxa de ocupação:** Opção 6
   - **Fila de espera:** Opção 7

## 📊 Dados de Exemplo

O sistema já vem com dados de exemplo após executar `dados.sql`:
- 10 Pacientes
- 10 Profissionais
- 5 Unidades de Saúde
- 15 Leitos
- 15 Atendimentos
- 8 Pacientes na fila de espera

Você pode testar com o CPF: `123.456.789-01` (Maria Silva Santos)

## 👥 Autores
- Diego Soares da Paz (8936415)
- Estefano Nascimento (7970044)
- Gabriel de Oliveira Merenciano (15746705)
- Pyerry Klyzlow Xavier (15484839)
- Thamyres Santos Silva (11819240)

## 📚 Tecnologias Utilizadas
- **Linguagem:** Python 3
- **Banco de Dados:** PostgreSQL 18
- **Biblioteca:** psycopg2-binary
- **Interface:** Terminal/Console