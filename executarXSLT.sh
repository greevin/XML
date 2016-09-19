#!/bin/bash

JAVA=$(/usr/libexec/java_home)/bin/java
SAXONLIB=$(pwd)/saxon9he.jar 
XSL=$(pwd)/escolas-FAPESP.xsl
file=$1

if [[ -n "$file" ]]; then
    "$JAVA" -jar "$SAXONLIB" -s:"$file" -xsl:"$XSL" 
else
    echo "Digite o caminho para o XML exportado do ATLASTi como parâmetro para o script."
fi
