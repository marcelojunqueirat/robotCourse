*** Settings ***
Documentation  Template robot main suite.
Library        Collections
Library        RPA.Browser.Selenium
Library        RPA.Excel.Files

*** Variables ***
${SELECT_MAKE}        xpath://div[@class=' css-6m7e85']
${BUTTON_SEARCH}      xpath:/html[1]/body[1]/div[1]/div[1]/main[1]/div[1]/div[2]/div[1]/div[1]/div[1]/form[1]/div[2]/div[1]/button[1]/span[1]
${TITLE_H5}           xpath://h5[@class='css-vgvf7v eazpo511']
${SORT_CARS}          xpath://div[contains(@class,'css-qcle71 ezortjz0')]
${SORT_LOWEST_PRICE}  xpath://span[contains(.,'Lowest price')]
${SLEEP}              500ms

*** Keywords ***

Create Excel Report
    Create Workbook  ${CURDIR}/excel/results.xlsx
    Save Workbook

Read Excel
    Open Workbook    ${CURDIR}/excel/robot_scrape_list.xlsx
    ${LIST}          Read Worksheet    header=true
    Log To Console   ${LIST}
    Close Workbook

    FOR  ${INDEX}  IN  @{LIST}
        Search Cars  ${INDEX}
    END

Search Cars
    [Arguments]  ${INDEX}
    Go To    %{URL}
    Maximize Browser Window
    Wait Until Element Is Visible  ${SELECT_MAKE}
    Click Element                  ${SELECT_MAKE}

    Press Keys                     NONE  ${INDEX}[make]
    Sleep                          ${SLEEP}
    Press Keys                     NONE  TAB
    Press Keys                     NONE  TAB
    Sleep                          ${SLEEP}

    Press Keys                     NONE  ${INDEX}[model]
    Sleep                          ${SLEEP}
    Press Keys                     NONE  TAB
    Press Keys                     NONE  TAB
    Sleep                          ${SLEEP}

    Press Keys                     NONE  ${INDEX}[max_km]
    Sleep                          ${SLEEP}
    Click Element                  ${TITLE_H5}
    Sleep                          ${SLEEP}

    Wait Until Element Is Visible  ${BUTTON_SEARCH}        
    Click Element                  ${BUTTON_SEARCH}
    Sleep                          3s

    #Click sort by button
    Wait Until Element Is Visible  ${SORT_CARS}
    Click Element                  ${SORT_CARS}
    Wait Until Element Is Visible  ${SORT_LOWEST_PRICE}
    Click Element                  ${SORT_LOWEST_PRICE}
    Sleep                          2s

    ${NOME}         Get Text  xpath:/html[1]/body[1]/div[1]/div[1]/main[1]/div[1]/div[3]/div[1]/div[2]/div[1]/div[1]/a[1]/div[1]/div[2]/div[1]/h4[1]
    Sleep           1s
    ${KM_TOTAL}     Get Text  xpath:/html[1]/body[1]/div[1]/div[1]/main[1]/div[1]/div[3]/div[1]/div[2]/div[1]/div[1]/a[1]/div[1]/div[2]/div[2]/div[2]/div[1]/div[1]/div[1]/p[1]
    Sleep           1s
    ${PAIS}         Get Text  xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[4]/div[1]/div/div[2]/div[1]/div/p      
    Sleep           1s
    ${COMBUSTIVEL}  Get Text  xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[2]/div[2]/div/div[5]/div/p
    Sleep           1s
    ${TRANSMISSAO}  Get Text  xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[2]/div[2]/div/div[4]/div/p
    Sleep           1s
    ${PRECO}        Get Text  xpath:/html/body/div[1]/div/main/div[1]/div[3]/div/div[2]/div[1]/div/a/div/div[2]/div[4]/div[3]/div/div/div/div[2]/div/h4
    Sleep           1s

    ${CAR_DICT}    Create Dictionary
    ...    nome=${NOME}
    ...    km_total=${KM_TOTAL}
    ...    pais=${PAIS}
    ...    combustivel=${COMBUSTIVEL}
    ...    transmissao=${TRANSMISSAO}
    ...    preco=${PRECO}
    Log To Console    ${CAR_DICT}

    Append to Excel   ${CAR_DICT}

Append to Excel
    [Arguments]               ${CAR_DICT}
    Open Workbook             ${CURDIR}/excel/results.xlsx
    Append Rows To Worksheet  ${CAR_DICT}  header=true
    Save Workbook

*** Tasks ***
Main
    Create Excel Report
    Open Available Browser
    Read Excel
    Close All Browsers
