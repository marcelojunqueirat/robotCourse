*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections

*** Variables ***
${url}=              https://serverest.dev
${msg_sucesso}=      Cadastro realizado com sucesso
${msg_email_usado}=  Este email já está sendo usado

*** Keywords ***
Criar sessão na ServeRest
    ${headers}=     Create Dictionary  accept=application/json  Content-Type=application/json
    Create Session  alias=ServeRest  url=${url}  headers=${headers}

Criar um usuário novo
    ${palavra_aleatoria}=  Generate Random String  length=4  chars=[LETTERS]
    ${palavra_aleatoria}=  Convert To Lower Case   ${palavra_aleatoria}
    Set Test Variable      ${email_teste}          ${palavra_aleatoria}@emailteste.com

Cadastrar o usuário criado na ServeRest
    [Arguments]  ${email_teste}  ${status_code}
    ${body}=  Create Dictionary  
    ...  nome=Marcelo Teste  
    ...  email=${email_teste}  
    ...  password=1234  
    ...  administrador=true
    Criar sessão na ServeRest
    ${resp}=  POST On Session  
    ...  alias=ServeRest  
    ...  url=/usuarios  
    ...  json=${body}
    ...  expected_status=${status_code}
    Log  ${resp.json()}
    IF  ${resp.status_code} == 201
        Set Test Variable  ${id_usuario}  ${resp.json()["_id"]}
    END
    Set Test Variable  ${resposta}    ${resp.json()}

Conferir se o usuário foi cadastrado corretamente
    Dictionary Should Contain Item  ${resposta}  message  ${msg_sucesso}
    Dictionary Should Contain Key   ${resposta}  _id

Vou repetir o cadastro do usuario
    Cadastrar o usuário criado na ServeRest  ${email_teste}  400

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item  ${resposta}  message  ${msg_email_usado}

Consultar os dados do novo usuário
    ${resp_consulta}=  GET On Session  alias=ServeRest  url=/usuarios/${id_usuario}  expected_status=200
    Set Test Variable  ${resposta_consulta}  ${resp_consulta.json()}

Conferir os dados retornados
    Log  ${resposta_consulta}
    Dictionary Should Contain Item  ${resposta_consulta}  nome           Marcelo Teste
    Dictionary Should Contain Item  ${resposta_consulta}  email          ${email_teste}
    Dictionary Should Contain Item  ${resposta_consulta}  password       1234
    Dictionary Should Contain Item  ${resposta_consulta}  administrador  true
    Dictionary Should Contain Item  ${resposta_consulta}  _id            ${id_usuario}

