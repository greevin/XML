#!/bin/bash

JAVA=$(/usr/libexec/java_home)/bin/java
SAXONLIB=$(pwd)/saxon9he.jar
XSL_HTML=$(pwd)/CEAP_HTML.xsl
file=$1

if [[ -n "$file" ]]; then
    echo "Gerando os relatórios em HTML."
    "$JAVA" -jar "$SAXONLIB" -s:"$file" -xsl:"$XSL_HTML"
    ./gerarPDFs.sh
else
    echo "Digite o caminho para o XML exportado do ATLAS.Ti como parâmetro para o script."
fi
