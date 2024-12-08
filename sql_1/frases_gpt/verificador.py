import os
import re

def verificar_arquivos(diretorio):
    """
    Verifica se o código no final de cada linha de um arquivo corresponde ao código no nome do arquivo.

    Args:
        diretorio: O caminho do diretório onde os arquivos estão localizados.
    """

    for arquivo in os.listdir(diretorio):
        # Verifica se o nome do arquivo segue o padrão esperado e captura os grupos
        match = re.match(r'^frases_(\d+)_(\d+)\.txt$', arquivo)
        if match:
            codigo_esperado = f"{int(match.group(1))}.{int(match.group(2))}"

            with open(os.path.join(diretorio, arquivo), 'r') as f:
                for linha in f:
                    linha = linha.strip()
                    if not linha.endswith(codigo_esperado):
                        print(f"Arquivo {arquivo}, linha {linha}: Código inválido")

# Exemplo de uso:
verificar_arquivos('./')
