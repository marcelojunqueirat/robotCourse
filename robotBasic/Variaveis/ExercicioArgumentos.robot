*** Settings ***
Documentation    Exercicio Argumentos
Library          String

*** Variables ***
&{PESSOA}=    nome=Marcelo    sobrenome=Teste


*** Test Cases ***
Gerando um email aleatorio
    ${EMAIL}    Email Customizado    ${PESSOA.nome}    ${PESSOA.sobrenome}    
    Log to Console    ${EMAIL}

*** Keywords ***
Email Customizado
    [Arguments]    ${NOME}    ${SOBRENOME}
    ${STRING}      Generate Random String    length=8
    ${EMAIL}       Set Variable    ${NOME}${SOBRENOME}${STRING}@testerobot.com
    [Return]       ${EMAIL}   
    

