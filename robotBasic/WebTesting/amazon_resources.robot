*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                     chrome
${URL}                         https://www.amazon.com.br/
${MENU_ELETRONICOS}            //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}          //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=${BROWSER}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains    text=${FRASE}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//img[contains(@alt,'${NOME_CATEGORIA}')]

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox   text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Verificar resultado da pesquisa, listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=(//span[contains(.,'${PRODUTO}')])[2]
    
Adicionar o produto "${PRODUTO}" no carrinho
    Click Element    locator=(//span[contains(.,'${PRODUTO}')])[2]
    Wait Until Element Is Visible    locator=add-to-cart-button
    Click Element    locator=add-to-cart-button
    Wait Until Page Contains     text=Adicionado ao carrinho
    Element Should Be Visible    locator=//span[@class='a-size-medium-plus a-color-base sw-atc-text a-text-bold'][contains(.,'Adicionado ao carrinho')]

Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    Element Should Contain    locator=nav-cart-count   expected=1
    Click Element    locator=//a[contains(.,'Ir para o carrinho')]
    Wait Until Element Is Visible    locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]
    Element Text Should Be    locator=//span[@class='a-truncate-cut'][contains(.,'${PRODUTO}')]    expected=${PRODUTO}

Remover o produto "${PRODUTO}" do carrinho
    Click Element    locator=//input[contains(@aria-label,'Excluir ${PRODUTO}')]

Verificar se o carrinho fica vazio
    Page Should Contain    text=foi removido de Carrinho de compras.
    Element Should Contain    locator=nav-cart-count   expected=0
