#!/bin/bash

PRINCE=/usr/local/bin/prince
if [ -e "$PRINCE" ]; then
    for file in *.html; do
        if [ -e "$file" ]; then
            echo "Gerando os relatórios em PDF."
            "$PRINCE" -i html5 --media=print --page-size=US-Letter "$file"
        else
            echo "Você precisa executar o comando ./gerarRelatorios.sh"
            echo "Os PDFs serão gerados automaticamente com os relatórios."
        fi
    done
else
    echo "Instale a ferramenta PRINCE (www.princexml.com)."
    echo "Verifique se o programa foi instalado em: $PRINCE"
    echo "Caso contrário, altere o caminho do executável no script."
fi
