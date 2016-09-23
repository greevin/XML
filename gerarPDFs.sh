#!/bin/bash

PRINCE=/usr/local/bin/prince
for i in $( ls impressao*.xhtml relatorio*.html); do
    "$PRINCE" $i
done
