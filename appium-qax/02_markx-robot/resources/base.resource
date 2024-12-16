*** Settings ***
Documentation    Tudo deve começar nesse arquivo

Library    AppiumLibrary

*** Keywords ***

Start session
    Open Application  remote_url=http://localhost:4723    
    ...                   automationName=UIAutomator2
    ...                   platformName=Android
    ...                   deviceName=Emulator
    ...                   udid=emulator-5554
    ...                   autoGrantPermissions=true
    ...                   app=${EXECDIR}/../apps/markx.apk

    Wait Until Page Contains    Endereço IP da Api    10

Finish session
    Capture Page Screenshot
    Close Application