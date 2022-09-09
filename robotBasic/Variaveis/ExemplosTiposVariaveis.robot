*** Settings ***
Documentation    Exemplos de tipos de variaveis: Simples, Listas e Dicionarios

*** Variables ***

#Simples
${GLOBAL_SIMPLES}=    Esse é um tipo de variavel simples

#Listas
@{FRUTAS}=            uva    morango     banana    maçã

#Dicionario
&{PESSOA}=            nome=Marcelo    email=teste@test.com    idade=25    sexo=masculino


*** Test Cases ***
Caso de Teste Exemplo 01
    Uma keyword qualquer 01

*** Keywords ***

Uma keyword qualquer 01
    #Simples
    Log    ${GLOBAL_SIMPLES}
    #Lista
    Log    Tem que ser morango: ${FRUTAS[1]} e essa tem que ser maçã: ${FRUTAS[3]}
    #Dicionario
    Log    Nome: ${PESSOA.nome} e email: ${PESSOA.email}
    





