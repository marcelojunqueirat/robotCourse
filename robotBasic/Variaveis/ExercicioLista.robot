*** Settings ***
Documentation    Exercicio Listas com todos os meses do ano

*** Variables ***

@{MESES}   janeiro
...        fevereiro
...        março
...        abril
...        maio
...        junho
...        julho
...        agosto
...        setembro
...        outubro
...        novembro
...        dezembro


*** Test Cases ***
Imprimindo os meses no console
    Meses do Ano


*** Keywords ***
Meses do Ano
    Log To Console    Mês: ${MESES[0]}
    Log To Console    Mês: ${MESES[1]}
    Log To Console    Mês: ${MESES[2]}
    Log To Console    Mês: ${MESES[3]}
    Log To Console    Mês: ${MESES[4]}
    Log To Console    Mês: ${MESES[5]}
    Log To Console    Mês: ${MESES[6]}
    Log To Console    Mês: ${MESES[7]}
    Log To Console    Mês: ${MESES[8]}
    Log To Console    Mês: ${MESES[9]}
    Log To Console    Mês: ${MESES[10]}
    Log To Console    Mês: ${MESES[11]}



