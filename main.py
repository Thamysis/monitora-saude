import os
import sys
from config import *

def limpar_tela():
    os.system('cls' if os.name == 'nt' else 'clear')

def pausar():
    input(MESSAGE_ENTER_TO_CONTINUE)

def menu_principal():
    print("\n")
    print("="*60)
    print(SYSTEM_NAME)
    print("="*60)
    print(MENU_OPTION_1)
    print(MENU_OPTION_2)
    print(MENU_OPTION_3)
    print(MENU_OPTION_4)
    print(MENU_OPTION_5)
    print(MENU_OPTION_6)
    print(MENU_OPTION_7)
    print(MENU_OPTION_0)
    print("="*60)
    return input(SELECT_OPTION).strip()

def main():
    from database import Database
    from paciente import Paciente
    from atendimento import Atendimento
    
    db = Database()
    if not db.conectar():
        print(MESSAGE_ERROR_CONNECT)
        print(VERIFY_SETTINGS)
        sys.exit(1)
    
    paciente = Paciente(db)
    atendimento = Atendimento(db)
    
    while True:
        limpar_tela()
        opcao = menu_principal()
        
        if opcao == '1':
            paciente.cadastrar()
            pausar()
        
        elif opcao == '2':
            paciente.listar_todos()
            pausar()
        
        elif opcao == '3':
            paciente.consultar_por_cpf()
            pausar()
        
        elif opcao == '4':
            atendimento.registrar()
            pausar()
        
        elif opcao == '5':
            atendimento.consultar_historico()
            pausar()
        
        elif opcao == '6':
            atendimento.consultar_taxa_ocupacao()
            pausar()
        
        elif opcao == '7':
            atendimento.consultar_fila_espera()
            pausar()
        
        elif opcao == '0':
            print(CLOSING_SYSTEM)
            db.desconectar()
            break
        
        else:
            print(INVALID_OPTION)
            pausar()

if __name__ == "__main__":
    main()