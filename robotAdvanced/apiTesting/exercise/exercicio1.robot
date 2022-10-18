*** Settings ***
Documentation       Exemplos da própria Library: https://github.com/bulkan/robotframework-requests/blob/master/tests/testcase.robot
...                 Doc da API do GitHub: https://developer.github.com/v3/
Library             RequestsLibrary
Library             Collections
Resource            ./variables/my_user_and_passwords.robot

*** Variables ***
${GITHUB_HOST}      https://api.github.com
${ISSUES_URI}       /repos/mayribeirofernandes/myudemyrobotframeworkcourse/issues

*** Test Cases ***
Exercício 01: Cadastrar comentário
    Conectar com autenticação básica na API do GitHub
    Cadastrar comentário na issue "12"

*** Keywords ***
Conectar com autenticação básica na API do GitHub
    ${AUTH}             Create List           ${MY_GITHUB_USER}      ${MY_GITHUB_PASS}
    Create Session      alias=mygithubAuth    url=${GITHUB_HOST}     auth=${AUTH}     disable_warnings=True

Cadastrar comentário na issue "${ISSUE}"
    ${MY_USER_DATA}     POST On Session          alias=mygithubAuth   url=${ISSUES_URI}/${ISSUE}/comments
    ...                 data={"body": "Comentário cadastrado via Robot Framework!"}
    Confere sucesso na requisição   ${MY_USER_DATA}

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}