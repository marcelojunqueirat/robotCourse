*** Settings ***
Library     app.py

*** Test Cases ***
Deve retornar mensagem de boas vindas
    ${result}=          Welcome     Marcelo
    Should Be Equal     ${result}   Olá Marcelo, Bem vindo ao Curso Básico de Robot Framework