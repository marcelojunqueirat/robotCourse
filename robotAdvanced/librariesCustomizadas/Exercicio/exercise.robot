*** Settings ***
Library    ./ExerciseLibrary/exercise.py

*** Test Cases ***
Saudar Usuario
    Saudação para "Marcelo"

Posso tirar carteira de motorista?
    Minha idade é 19

*** Keywords ***
Saudação para "${NOME}"
    ${CONTEUDO}    Saudacao    ${NOME}
    Log To Console    ${CONTEUDO}

Minha idade é ${IDADE}
    ${CONTEUDO}    Validar CNH    ${IDADE}
    Log To Console    ${CONTEUDO}  

