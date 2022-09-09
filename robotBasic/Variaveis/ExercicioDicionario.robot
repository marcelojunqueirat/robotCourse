*** Settings ***
Documentation    Exercicio Dicionario com todos os meses do ano

*** Variables ***

&{MES}     um=janeiro          umDias=30
...        dois=fevereiro      doisDias=28
...        tres=março          tresDias=31
...        quatro=abril        quatroDias=30
...        cinco=maio          cincoDias=31
...        seis=junho          seisDias=30
...        sete=julho          seteDias=30
...        oito=agosto         oitoDias=31
...        nove=setembro       noveDias=30
...        dez=outubro         dezDias=31
...        onze=novembro       onzeDias=30
...        doze=dezembro       dozeDias=31


*** Test Cases ***
Imprimindo os meses no console
    Meses do Ano


*** Keywords ***
Meses do Ano
    Log To Console    ${MES.um} -> ${MES.umDias} dias
    Log To Console    ${MES.dois} -> ${MES.doisDias} dias
    Log To Console    ${MES.tres} -> ${MES.tresDias} dias
    Log To Console    ${MES.quatro} -> ${MES.quatroDias} dias
    Log To Console    ${MES.cinco} -> ${MES.cincoDias} dias
    Log To Console    ${MES.seis} -> ${MES.seisDias} dias
    Log To Console    ${MES.sete} -> ${MES.seteDias} dias
    Log To Console    ${MES.oito} -> ${MES.oitoDias} dias
    Log To Console    ${MES.nove} -> ${MES.noveDias} dias
    Log To Console    ${MES.dez} -> ${MES.dezDias} dias
    Log To Console    ${MES.onze} -> ${MES.onzeDias} dias
    Log To Console    ${MES.doze} -> ${MES.dozeDias} dias






