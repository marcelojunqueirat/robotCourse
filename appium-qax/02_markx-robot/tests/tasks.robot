*** Settings ***
Documentation    Suite de teste do cadastro de tarefas

Resource         ${CURDIR}/../resources/base.resource

Test Setup       Start session
Test Teardown    Finish session

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    ${task}    Set Variable    Estudar Python
    Remove task from database  ${task}
    
    Do Login

    Create a new task    ${task}
    Should have task     ${task}

Deve poder remover uma tarefa indesejada
    [Tags]  remove

    # Dado que eu tenha uma tarefa indesejada
    ${task}    Set Variable    Comprar refri
    Remove task from database  ${task}

    # E essa foi cadastrada no sistema
    Do Login
    Create a new task    ${task}
    Should have task     ${task}

    # Quando faço a exclusão dessa tarefa
    Remove task by name                 ${task}

    # Então essa tarefa some da tela
    Wait Until Page Does Not Contain    ${task}
    
Deve poder concluir uma tarefa
    [Tags]  done

    # Dado que eu tenha uma tarefa a ser concluida
    ${task}    Set Variable    Estudar XPath
    Remove task from database  ${task}

    # E essa foi cadastrada no sistema
    Do Login
    Create a new task    ${task}
    Should have task     ${task}

    # Quando faço a marcação de conclusão dessa tarefa
    Finish task          ${task}

    # Então essa tarefa será marcada como concluida
    Task should be done  ${task}

