*** Settings ***
Resource  ../resources/api_testing_usuarios.resource

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServeRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  ${email_teste}  201
    Conferir se o usuário foi cadastrado corretamente

Cenário 02: Cadastrar um usuário já existente na ServeRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  ${email_teste}  201
    Vou repetir o cadastro do usuario
    Verificar se a API não permitiu o cadastro repetido

Cenário 03: Consultar os dados de um novo usuário
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  ${email_teste}  201
    Consultar os dados do novo usuário
    Conferir os dados retornados
