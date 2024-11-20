*** Settings ***
Documentation    Testes de Login

Resource    ../resources/base.resource


*** Test Cases ***
Deve logar com sucesso
        Open Application  remote_url=http://localhost:4723    
    ...                   platformName=Android
    ...                   deviceName=Emulator
    ...                   automationName=UIAutomator2
    ...                   udid=emulator-5554
    ...                   autoGrantPermissions=true
    ...                   app=${EXECDIR}/../apps/markx.apk

    Sleep  10s

