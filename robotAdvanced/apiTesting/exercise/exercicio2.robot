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
Exercício 02: Consultar comentários
    Conectar na API do GitHub sem autenticação
    Consultar comentários das issues ordenados por "updated" e "desc"

*** Keywords ***
Conectar na API do GitHub sem autenticação
    Create Session      alias=mygithub        url=${GITHUB_HOST}     disable_warnings=True

Consultar comentários das issues ordenados por "${SORT}" e "${DIRECTION}"
    &{PARAMS}           Create Dictionary    sort=${SORT}      direction=${DIRECTION}
    ${MY_ISSUES}        GET On Session       alias=mygithub    url=${ISSUES_URI}    params=${PARAMS}
    Log To Console      Lista de Comentários de Issues: ${MY_ISSUES.json()}
    Confere sucesso na requisição   ${MY_ISSUES}

Confere sucesso na requisição
    [Arguments]      ${RESPONSE}
    Should Be True   '${RESPONSE.status_code}'=='200' or '${RESPONSE.status_code}'=='201'
    ...  msg=Erro na requisição! Verifique: ${RESPONSE}