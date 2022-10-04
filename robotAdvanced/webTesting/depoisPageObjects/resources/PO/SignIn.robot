*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   ../Resource.robot

*** Variables ***
${SIGNIN_FIELD_EMAIL}           id=email_create
${SIGNIN_BTN_CREATE}            id=SubmitCreate
${SIGNIN_FORM_CREATION}         xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
${SIGNIN_OPTION_GENDER}         id=id_gender2
${SIGNIN_CUSTOMER_FIRSTNAME}    id=customer_firstname
${SIGNIN_CUSTOMER_LASTNAME}     id=customer_lastname
${SIGNIN_PASSWORD}              id=passwd
${SIGNIN_ADDRESS}               id=address1
${SIGNIN_CITY}                  id=city
${SIGNIN_STATE}                 id=id_state
${SIGNIN_POSTCODE}              id=postcode
${SIGNIN_PHONE_MOBILE}          id=phone_mobile
${SIGNIN_BTN_SUBMIT}            submitAccount
${SIGNIN_CENTER_COLUMN}         xpath=//*[@id="center_column"]/p
${SIGNIN_HEADER_CUSTOMER}       xpath=//*[@id="header"]/div[2]//div[1]/a/span

*** Keywords ***
Informar um e-mail válido
    Wait Until Element Is Visible   ${SIGNIN_FIELD_EMAIL}
    ${EMAIL}                        Generate Random String
    Input Text                      ${SIGNIN_FIELD_EMAIL}    ${EMAIL}@testerobot.com

Clicar em "Create an account"
    Click Button    ${SIGNIN_BTN_CREATE}

Preencher os dados obrigatórios
    Wait Until Element Is Visible   ${SIGNIN_FORM_CREATION}
    Click Element                   ${SIGNIN_OPTION_GENDER}
    Input Text                      ${SIGNIN_CUSTOMER_FIRSTNAME}    May
    Input Text                      ${SIGNIN_CUSTOMER_LASTNAME}     Fernandes
    Input Text                      ${SIGNIN_PASSWORD}              123456
    Input Text                      ${SIGNIN_ADDRESS}               Rua Framework, Bairro Robot
    Input Text                      ${SIGNIN_CITY}                  Floripa
    Set Focus To Element            ${SIGNIN_STATE}
    ### No firefox ocorreu problema ao achar o listbox State, então coloquei um if para esperar
    ### pelo elemento quando for firefox
    Run Keyword If    '${BROWSER}'=='firefox'  Wait Until Element Is Visible   ${SIGNIN_STATE}
    Select From List By Index       ${SIGNIN_STATE}          9
    Input Text                      ${SIGNIN_POSTCODE}       12345
    Input Text                      ${SIGNIN_PHONE_MOBILE}   99988877

Submeter cadastro
    Click Button    ${SIGNIN_BTN_SUBMIT}

#### Conferências
Conferir se o cadastro foi efetuado com sucesso
    Wait Until Element Is Visible    ${SIGNIN_CENTER_COLUMN}
    Element Text Should Be           ${SIGNIN_CENTER_COLUMN}
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           ${SIGNIN_HEADER_CUSTOMER}    May Fernandes
