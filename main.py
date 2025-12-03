import os
import sys

def limpar_tela():
    """Limpa a tela do terminal"""
    os.system('cls' if os.name == 'nt' else 'clear')

def pausar():
    """Pausa a execução aguardando Enter"""
    input("\nPressione Enter para continuar...")

def menu_principal():
    """Exibe o menu principal"""
    print("\n")
    print("="*60)
    print("   SISTEMA DE SAÚDE PÚBLICA - SÃO CARLOS")
    print("="*60)
    print("1. Cadastrar Paciente")
    print("2. Consultar Todos os Pacientes")
    print("3. Consultar Paciente por CPF")
    print("4. Registrar Atendimento")
    print("5. Consultar Histórico de Paciente")
    print("6. Consultar Taxa de Ocupação de Leitos")
    print("7. Consultar Fila de Espera")
    print("0. Sair")
    print("="*60)
    return input("Escolha uma opção: ").strip()

def main():
    """Função principal do sistema"""
    # Importar módulos
    from database import Database
    from paciente import Paciente
    from atendimento import Atendimento
    
    # Conectar ao banco de dados
    db = Database()
    if not db.conectar():
        print("\n✗ Erro: Não foi possível conectar ao banco de dados.")
        print("Verifique as configurações em database.py")
        sys.exit(1)
    
    # Instanciar módulos
    paciente = Paciente(db)
    atendimento = Atendimento(db)
    
    # Loop principal
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
            print("\n✓ Encerrando sistema...")
            db.desconectar()
            break
        
        else:
            print("\n✗ Opção inválida!")
            pausar()

if __name__ == "__main__":
    main()