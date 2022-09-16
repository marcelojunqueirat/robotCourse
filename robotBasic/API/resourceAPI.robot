*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library          RequestsLibrary
Library          Collections

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}    id=15
...           title=Book 15
...           pageCount=1500

&{BOOK_302}   id=302
...           title=teste
...           description=teste
...           pageCount=200
...           excerpt=teste
...           publishDate=2022-09-15T22:10:55.738Z

&{BOOK_160}   id=160
...           title=Marcelo
...           description=Marcelo Teste
...           pageCount=200
...           excerpt=teste
...           publishDate=2022-09-16T22:10:55.738Z



*** Keywords ***
### SETUP E TEARDOWNS
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}

### Ações
Requisitar todos os livros
    ${RESPOSTA}    GET On Session   fakeAPI   Books
    Log   ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requesitar o livro ${ID_LIVRO}
    ${RESPOSTA}    GET On Session   fakeAPI   Books/${ID_LIVRO}
    Log   ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Cadastrar um novo livro
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    POST On Session   fakeAPI   Books
    ...                              data={"id": ${BOOK_302.id},"title": "${BOOK_302.title}","description": "${BOOK_302.description}","pageCount": ${BOOK_302.pageCount},"excerpt": "${BOOK_302.excerpt}","publishDate": "${BOOK_302.publishDate}"}
    ...                              headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Alterar o livro ${ID_LIVRO}
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    PUT On Session    fakeAPI   Books/${ID_LIVRO}
    ...                              data={"id": ${BOOK_160.id},"title": "${BOOK_160.title}","description": "${BOOK_160.description}","pageCount": ${BOOK_160.pageCount},"excerpt": "${BOOK_160.excerpt}","publishDate": "${BOOK_160.publishDate}"}
    ...                              headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}


Deletar o livro ${ID_LIVRO}
    ${HEADERS}     Create Dictionary    content-type=application/json
    ${RESPOSTA}    DELETE On Session    fakeAPI   Books/${ID_LIVRO}
    ...                                 headers=${HEADERS}
    Log            ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

### Conferências

Conferir o status code
    [Arguments]        ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings     ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]        ${REASON_DESEJADO}
    Should Be Equal As Strings     ${RESPOSTA.reason}    ${REASON_DESEJADO}
    
Conferir se retorna uma lista com ${QTDE_LIVROS} livros
    Length Should Be    ${RESPOSTA.json()}    ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro ${ID_LIVRO}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${BOOK_15.pageCount}

    Should Not Be Empty    ${RESPOSTA.json()["description"]}
    Should Not Be Empty    ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]}

Conferir se retorna todos os dados cadastrados para do livro ${ID_LIVRO}
    Conferir livro    ${ID_LIVRO}


Conferir se retorna todos os dados alterados do livro ${ID_LIVRO}
    Conferir livro    ${ID_LIVRO}

Conferir livro
    [Arguments]    ${ID_LIVRO}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${BOOK_${ID_LIVRO}.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${BOOK_${ID_LIVRO}.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    description    ${BOOK_${ID_LIVRO}.description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${BOOK_${ID_LIVRO}.pageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    excerpt        ${BOOK_${ID_LIVRO}.excerpt}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    publishDate    ${BOOK_${ID_LIVRO}.publishDate}

    
Conferir se deleta o livro ${ID_LIVRO}
    Should Be Empty    ${RESPOSTA.text}
    Should Be Empty    ${RESPOSTA.content}
