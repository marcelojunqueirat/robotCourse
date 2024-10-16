*** Settings ***
Library    AppiumLibrary

*** Variables ***
${START}      QAX
${TIMEOUT}    10s

*** Keywords ***
    
Start session
    Open Application    http://localhost:4723    
    ...                 platformName=Android
    ...                 deviceName=Android Emulator
    ...                 automationName=UIAutomator2
    ...                 app=${EXECDIR}/app/yodapp-beta.apk
    ...                 udid=emulator-5554
    ...                 autoGrantPermissions=true

Get started
    Wait Until Page Contains  ${START}  ${TIMEOUT}
    Click Text                ${START}

Navigate to
    [Arguments]   ${item_text}
    ${hamburger}=  Set Variable  xpath=//android.widget.ImageButton[@content-desc="Open navigation drawer"]
    Wait Until Element Is Visible  ${hamburger}  ${TIMEOUT}
    Click Element                  ${hamburger}

    ${menu_item}=  Set Variable  xpath=//*[@resource-id="com.qaxperience.yodapp:id/navView"]//*[@text="${item_text}"]
    Wait Until Element Is Visible  ${menu_item}  ${TIMEOUT}
    Click Element                  ${menu_item}

Go to item
    [Arguments]  ${item}   ${checkpoint}
    Wait Until Page Contains  ${item}  ${TIMEOUT}
    Click Text                ${item}
    Wait Until Page Contains  ${checkpoint}  ${TIMEOUT}

Close session
    Close Application

