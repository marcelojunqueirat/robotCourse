*** Settings ***
Documentation    Exercicio de If's e Loop's 

*** Variables ***

@{numbers}    0    1    2    3    4    5    6    7    8    9    10    11    12

*** Test Cases ***
Exibindo numerais
    [Documentation]  Faz um loop percorrendo a lista que você passar
    Listando numeros

*** Keywords ***
Listando numeros
    FOR    ${number}    IN    @{numbers}
        IF    ${number} == 5 or ${number} == 10
                Log To Console   Eu sou o número ${number}
        ELSE
                Log To Console  Eu não sou o número 5 e nem o 10!
        END
    END
