*** Settings ***
Documentation    Testes de Login

Resource         ${CURDIR}/../resources/base.resource

Test Setup       Start session
Test Teardown    Finish session

*** Test Cases ***
Deve logar com sucesso
    Input Text       xpath=//*[@resource-id="apiIp"]        192.168.127.11
    Click Element    xpath=//*[@resource-id="signInButton"]

    Wait Until Page Contains    Minhas tarefas    10



