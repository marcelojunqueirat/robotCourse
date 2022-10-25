*** Settings ***
Resource        base.robot

Test Setup      Nova Sessao
Test Teardown   Encerra Sessao

*** Test Cases ***
Should See Page Title
    Title Should Be     Training Wheels Protocol