algoritmo "certidao de nascimento"
// Função :
// Autor :
// Data : 09/03/2015
// Seção de Declarações 
var
nome: caractere
numero_do_livro: caractere
numero_da_folha, numero_do_termo: real

nome_do_suboficial, nome_da_pessoa_registrada, sexo: caractere
cargo: caractere
endereco_do_local_de_nascimento: caractere
data_do_nascimento: caractere
hora_do_nascimento: caractere
nome_do_pai, naturalidade_do_pai, nome_da_mae, naturalidade_da_mae: caractere
nome_do_avo_paterno, nome_da_avo_paterna, nome_do_avo_materno, nome_da_avo_materna: caractere
declarante_das_informacoes: caractere
data_de_registro: caractere
local_do_registro: caractere
data_do_registro: caractere

inicio
// Seção de Comandos

escreval ("Digite cada informação solicitada e em seguida aperte enter")
escreval ("Digite o número do Livro: ")
leia (numero_do_livro)
escreval ("Digite o número da Folha: ")
leia (numero_da_folha)
escreval ("Digite o número do Termo: ")
leia (numero_do_termo)
escreval ("Digite o nome do responsável pela emissão da certidão")
leia (nome_do_suboficial)
escreval ("Digitel o cargo do responsável pela emissão da certidão")
leia (cargo)
escreval ("Digite o nome da pessoa a ser registrada")
leia (nome_da_pessoa_registrada)
escreval ("Digite o sexo")
leia (sexo)
escreval ("Digite o Endereço do local de Nascimento, nome da rua, número, cidade/estado")
leia (endereco_do_local_de_nascimento)
escreval ("Digite a data de nascimento por extenso com dia, mês e ano")
leia (data_do_nascimento)
escreval ("Digite a hora do nascimento")
leia (hora_do_nascimento)
escreval ("Digite o nome do Pai")
leia (nome_do_pai)
escreval ("Digite a naturalidade do Pai")
leia (naturalidade_do_pai)
escreval ("Digite o nome da Mãe")
leia (nome_da_mae)
escreval ("Digite a naturalidade da Mãe")
leia (naturalidade_da_mae)
escreval ("Digite o nome do Avô Paterno")
leia (nome_do_avo_paterno)
escreval ("Digite o nome da Avó Paterna")
leia (nome_da_avo_paterna)
escreval ("Digite o nome do Avô Materno")
leia (nome_do_avo_materno)
escreval ("Digite o nome da Avó Materna")
leia (nome_da_avo_materna)
escreval ("Digite o nome do(a) declarante das informações")
leia (declarante_das_informacoes)
escreval ("Digite a data do registro")
leia (data_de_registro)
escreval ("Digite o local do local do registro")
leia (local_do_registro)
escreval ("Digite novamente a data do registro")
leia (data_do_registro)

limpatela

escreval ("                                                                    LIVRO:", numero_do_livro)
escreval ("                                                                    FOLHA:", numero_da_folha)
escreval ("                                                                    TERMO:", numero_do_termo)
escreval ("                        PODER JUDICIARIO                            ")
escreval ("                        ESTADO DA BAHIA                             ")
escreval ("        CARTÓRIO DE REGISTRO CÍVIL DAS PESSOAS NATURAIS             ")
escreval ("+------------------------------------------------------------------+")
escreval ("|        CARTÓRIO DE REGISTRO CIVIL DO 1º OFÍCIL                   |")
escreval ("|          DISTRITO SEDE COMARCA DE JEQUIÉ                         |")
escreval ("|                       SAC/SAJ                                    |")
escreval ("|                RUA DA ITÁLIA, No - CENTRO                        |")
escreval ("|               CEP: 45200-000  JEQUIÉ                             |")
escreval ("|              CÉLIA GABRIEL MEIRA - OFICIALA                      |")
escreval ("+------------------------------------------------------------------+")
escreval
escreval
escreval ("                 CERTIDÃO DE NASCIMENTO                             ")
escreval ("Eu, ",nome_do_suboficial, ", " , cargo, "do Registro Civil do 1º Ofício - Distrito Sede, Comarca")
escreval ("de Jequié, CERTIFICO que, no livro de registro de nascimento nº ",numero_do_livro, " ,às fls.",numero_da_folha)
escreval ("registro de nascimento de: ")
escreval
escreval ("          (",nome_da_pessoa_registrada, ")                         ")
escreval ("Do sexo " ,sexo, ", ocorrido no(a) " ,endereco_do_local_de_nascimento)
escreval (data_do_nascimento,", às",hora_do_nascimento," horas.")
escreval
escreval ("O(a) registrando(a) é filho(a)")
escreval ("De:  (",nome_do_pai,")")
escreval ("natural de",naturalidade_do_pai)
escreval ("e de",nome_da_mae)
escreval ("natural de  ",naturalidade_da_mae)
escreval
escreval ("sendo avós")
escreval ("paternos:  (",nome_do_avo_paterno, ")")
escreval ("e ",nome_da_avo_paterna)
escreval ("e maternos: ",nome_do_avo_materno)
escreval ("e ",nome_da_avo_materna)
escreval
escreval ("Foi declarante ",declarante_das_informacoes)
escreval ("OBSERVAÇÕES: Registro feito em ",data_do_registro)
escreval
escreval ("               O referido é verdade e dou fé               ")
escreval (local_do_registro,", ",data_do_registro,".")
escreval
escreval
escreval
escreval
escreval ("___________________________________________")



fimalgoritmo
