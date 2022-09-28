*** Settings ***
Documentation    Implementando DiffLibrary
Library    DiffLibrary

*** Test Cases ***
Executando DiffLibrary
    Comparando se arquivos são iguais    text1.txt    text2.txt

*** Keywords ***
Comparando se arquivos são iguais
    [Arguments]         ${ARQUIVO1}    ${ARQUIVO2}
    Diff Files    ${CURDIR}/my_files/${ARQUIVO1}    ${CURDIR}/my_files/${ARQUIVO2}

# Obs: criei um diretorio my_files na mesma pasta do teste e criei dois arquivos de texto com nome text1.txt text2.txt e conteudo de 1 a 6 em ambos para forçar teste a passar

