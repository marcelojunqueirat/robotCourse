*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${url}              https://training-wheels-protocol.herokuapp.com/

*** Keywords ***
Nova Sessao
    Open Browser    ${url}    chrome

Encerra Sessao
    Capture Page Screenshot
    Close Browser