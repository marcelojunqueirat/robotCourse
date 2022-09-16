*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Resource         resourceAPI.robot
Suite Setup      Conectar a minha API

*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna uma lista com 200 livros

Buscar um livro especifico (GET em um livro especifico)
    Requesitar o livro 15
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna todos os dados corretos do livro 15

Cadastrar um novo livro (POST)
    Cadastrar um novo livro
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna todos os dados cadastrados para do livro 302

Alterar um livro (PUT)
    Alterar o livro 160
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna todos os dados alterados do livro 160

Deletar um livro (DELETE)
    Deletar o livro 220
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se deleta o livro 220




