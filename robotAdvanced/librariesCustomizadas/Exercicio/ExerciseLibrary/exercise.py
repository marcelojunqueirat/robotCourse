def saudacao(nome):
    mensagem = "Olá " + nome + " seja bem vindo(a)"

    return mensagem

def validar_CNH(idade):
    if (int(idade) < 18):
        mensagem = "Você não está apto para entrar na auto escola."
    elif(int(idade) >= 18):
        mensagem = "Você está apto para entrar na auto escola."
    else:
        mensagem ="Valor Inválido!"

    return mensagem