﻿<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat" omit-xml-declaration="yes"
        indent="yes"/>

    <atlas:data xmlns:atlas="urn:www.atlasti.com/xml/001">
        <atlasDescription version="2.1">
            <!-- Version of this description syntax -->
            <version number="2.1"/>
            <!-- version of this stylesheet -->
            <friendlyName>Relatório do Projeto CEAP</friendlyName>
            <!-- To be displayed in ATLAS.ti -->
            <shortDescription>Relatório com os Codes ordenados pela frequência no PD.</shortDescription>
            <comment/>
            <category>Report</category>
            <subcat>Table</subcat>
            <requiredData>
                <required>codes</required>
                <required>pds</required>
                <required>quotations_full</required>
            </requiredData>
            <complexity>high</complexity>
            <!-- Computational complexity -->
            <iconPath/>
            <!-- To be displayed in ATLAS.ti -->
            <author name="Tel Amiel" email="tel@amiel.info" url="http://ceap.nied.unicamp.br"/>
            <creationDate>2016-07-01</creationDate>
            <modificationDate>2016-10-01</modificationDate>
            <sourceType type="HU" version="5.0"/>
            <!-- XML type acccepted as input -->
            <targetDocType>HTML</targetDocType>
        </atlasDescription>
    </atlas:data>

    <!-- Variables -->
    <xsl:variable name="maxquotesize">10000</xsl:variable>
    <xsl:variable name="description" select="document('')//atlasDescription"/>
    <xsl:variable name="imagedir">images/</xsl:variable>
    <xsl:variable name="stylesdir">css/</xsl:variable>
    <!-- empty for images in the same directory;do not forget end slash for other dirs! -->
    <xsl:variable name="outputOption">Para este relatório funcionar corretamente, você deve
        selecionar a opção "Include Primary Documents and Quotations (meta info
        only).</xsl:variable>
    <xsl:variable name="warnmessage">
        <div>
            <p style="style: italic; font-weight: bold; ">O conteúdo completo da citação não pode
                ser exibido por uma das seguitnes possibildiades: (a) a fonte de informação não é um
                arquivo de texto; ou (b) o tamanho é muito grande.</p>
        </div>
    </xsl:variable>
    <!-- Variables -->

    <xsl:include href="_ceap_template.xsl"/>

    <xsl:template match="/">
        <xsl:choose>
            <!-- warning message -->
            <xsl:when test="not($PDFamiliesWithCodes/PDFamily)">
                <html lang="pt-BR" xml:lang="pt-BR" xmlns="http://www.w3.org/1999/xhtml">
                    <head>
                        <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>
                        <title>
                            <xsl:value-of select="$description/friendlyName"/>
                        </title>
                        <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet"/>
                        <link rel="stylesheet" href="{$stylesdir}ceap.css" type="text/css"
                        />
                    </head>
                    <body>
                        <div class="container">
                            <div class="logo">
                                <div id="logo-img">
                                    <img src="{$imagedir}/logo_escolas.png"
                                        alt="Projeto FAPESP Escolas" class="logo"/>
                                </div>
                                <div id="logo-text">
                                    <h1 class="title">
                                        <xsl:value-of select="$description/friendlyName"/>
                                    </h1>
                                </div>
                            </div>

                            <div id="wrap" class="centered_report">
                                <p>
                                    <xsl:value-of select="$outputOption"/>
                                </p>
                            </div>

                        </div>
                        <script src="js/index.js">//</script>
                    </body>
                </html>
            </xsl:when>
            <!-- FIM - warning message -->
            <!-- Geração de relatórios -->
            <xsl:otherwise>
                <xsl:for-each select="$PDFamiliesWithCodes/PDFamily">
                    <xsl:sort select="@name" data-type="text" order="ascending"/>

                    <xsl:variable name="name" select="@name"/>
                    <xsl:variable name="title">
                        <xsl:for-each select="title/p">
                            <xsl:text> - </xsl:text>
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </xsl:variable>

                    <xsl:result-document method="xml" href="relatorio_CEAP_{@name}.html">
                        <html lang="pt-BR" xml:lang="pt-BR" xmlns="http://www.w3.org/1999/xhtml">
                            <head>
                                <meta charset="utf-8"/>
                                <title>
                                    <xsl:value-of select="$description/friendlyName"/>
                                    <xsl:value-of select="$title"/>
                                </title>
                                <link href="https://fonts.googleapis.com/css?family=Dosis"
                                    rel="stylesheet"/>
                                <link rel="stylesheet" href="{$stylesdir}ceap.css"
                                    type="text/css"/>
                            </head>
                            <body>
                                <div class="container">
                                    <div class="logo">
                                        <div id="logo-img">
                                            <img src="{$imagedir}/logo_escolas.png"
                                                alt="Logo do Projeto CEAP" class="logo"/>
                                        </div>
                                        <div id="logo-text">
                                            <h1 class="title">
                                                <xsl:value-of select="$description/friendlyName"/>
                                            </h1>
                                            <br/>
                                            <xsl:for-each select="title/p">
                                                <h2 class="title">
                                                  <xsl:value-of select="."/>
                                                </h2>
                                            </xsl:for-each>
                                        </div>
                                    </div>

                                    <div class="divisor">
                                        <h1 class="heading-primary">Resumo</h1>
                                        <xsl:for-each select="title/p">
                                            <h2 class="print-only">
                                                <xsl:value-of select="."/>
                                            </h2>
                                        </xsl:for-each>
                                    </div>

                                    <div class="accordion resumo">
                                        <dl class="resumo">
                                            <!-- Geração de resumo de itens do PD -->
                                            <xsl:for-each select="pd">
                                                <xsl:sort select="@name" data-type="text"
                                                  order="ascending"/>
                                                <xsl:variable name="pd_id" select="@id"/>
                                                <xsl:variable name="pd_name">
                                                  <xsl:choose>
                                                  <xsl:when test="comment != ''">
                                                  <xsl:value-of select="comment"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="@name"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:variable>

                                                <dt class="resumo">
                                                  <a
                                                  class="accordion-title accordionTitle js-accordionTrigger"
                                                  aria-expanded="false"
                                                  aria-controls="accordionResumo{position()}"
                                                  href="#accordionResumo{position()}">
                                                  <xsl:value-of select="$pd_name"/>
                                                  </a>
                                                </dt>
                                                <dd
                                                  class="accordion-content accordionItem is-collapsed resumo"
                                                  id="accordionResumo{position()}"
                                                  aria-hidden="true">
                                                  <!-- Conjunto de Informações por PD-->
                                                  <table class="printableTable resumo">
                                                  <tbody>
                                                  <xsl:for-each select="code">
                                                  <xsl:sort select="@quotes" data-type="number"
                                                  order="descending"/>
                                                  <tr>
                                                  <th>
                                                  <p>
                                                  <xsl:value-of select="@name"/>
                                                  </p>
                                                  </th>
                                                  <th>
                                                  <p>
                                                  <xsl:value-of select="@quotes"/>
                                                  <xsl:choose>
                                                  <xsl:when test="@quotes &gt; 1"> itens </xsl:when>
                                                  <xsl:otherwise> item </xsl:otherwise>
                                                  </xsl:choose>
                                                  </p>
                                                  </th>
                                                  </tr>
                                                  </xsl:for-each>
                                                  </tbody>
                                                  </table>
                                                  <!--END-Conjunto de Informações por PD -->
                                                </dd>
                                            </xsl:for-each>
                                            <!-- FIM - Geração de resumo de itens do PD -->
                                        </dl>
                                    </div>

                                    <div class="divisor">
                                        <h1 class="heading-primary">Relatório</h1>
                                        <xsl:for-each select="title/p">
                                            <h2 class="print-only">
                                                <xsl:value-of select="."/>
                                            </h2>
                                        </xsl:for-each>
                                    </div>

                                    <div class="accordion relatorio">
                                        <dl class="relatorio">
                                            <!-- Geração de dados para cada PD -->
                                            <xsl:for-each select="pd">
                                                <xsl:sort select="@name" data-type="text"
                                                  order="ascending"/>
                                                <xsl:variable name="pd_id" select="@id"/>
                                                <xsl:variable name="pd_name">
                                                  <xsl:choose>
                                                  <xsl:when test="comment != ''">
                                                  <xsl:value-of select="comment"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="@name"/>
                                                  </xsl:otherwise>
                                                  </xsl:choose>
                                                </xsl:variable>

                                                <dt class="relatorio">
                                                  <a
                                                  class="accordion-title accordionTitle js-accordionTrigger"
                                                  aria-expanded="false"
                                                  aria-controls="accordion{position()}"
                                                  href="#accordion{position()}">
                                                  <xsl:value-of select="$pd_name"/>
                                                  </a>
                                                </dt>
                                                <dd
                                                  class="accordion-content accordionItem is-collapsed relatorio"
                                                  id="accordion{position()}" aria-hidden="true">
                                                  <!-- Conjunto de Informações por PD-->
                                                  <xsl:for-each select="code">
                                                  <xsl:sort select="@quotes" data-type="number"
                                                  order="descending"/>
                                                  <table class="printableTable">
                                                  <thead>
                                                  <tr>
                                                  <th>
                                                  <p>
                                                  <xsl:value-of select="@name"/>: <xsl:value-of
                                                  select="@quotes"/>
                                                  <xsl:choose>
                                                  <xsl:when test="@quotes &gt; 1"> itens </xsl:when>
                                                  <xsl:otherwise> item </xsl:otherwise>
                                                  </xsl:choose>
                                                  </p>
                                                  </th>
                                                  </tr>
                                                  </thead>
                                                  <tbody>
                                                  <xsl:for-each select="p">
                                                  <tr>
                                                  <td class="rowStyle{position() mod 2}">
                                                  <p>- <xsl:value-of select="."/></p>
                                                  </td>
                                                  </tr>
                                                  </xsl:for-each>
                                                  </tbody>
                                                  </table>
                                                  </xsl:for-each>
                                                  <!--END-Conjunto de Informações por PD -->
                                                  <table class="printabletable">
                                                  <tr>
                                                  <td class="linhaBotao">
                                                  <a class="botao" href="#accordion{position()}"
                                                  >Voltar ao título</a>
                                                  </td>
                                                  </tr>
                                                  </table>
                                                </dd>
                                            </xsl:for-each>
                                            <!-- Geração de dados para cada PD -->
                                        </dl>
                                    </div>
                                </div>
                                <script src="js/index.js">//</script>
                            </body>
                        </html>
                    </xsl:result-document>
                </xsl:for-each>
            </xsl:otherwise>
            <!-- FIM - Geração de relatórios -->
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
