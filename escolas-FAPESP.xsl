<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exslt="http://exslt.org/common"
                exclude-result-prefixes="exslt"
                version="1.0">
    <xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" omit-xml-declaration="yes" indent="yes"/>
    <xsl:variable name="maxquotesize">10000</xsl:variable>
    <xsl:variable name="description" select="document('')//atlasDescription"/>
    <xsl:include href="_shared_fapesp.xsl"/>
    <xsl:include href="_index_main_fapesp.xsl"/>
    <atlas:data
            xmlns:atlas="urn:www.atlasti.com/xml/001">
        <atlasDescription version="2.1">
            <!-- Version of this description syntax -->
            <version number="2.1"/>
            <!-- version of this stylesheet -->
            <friendlyName>Relatório Projeto CEAP</friendlyName>
            <!-- To be displayed in ATLAS.ti -->
            <shortDescription>Relatório com os Codes ordenados pela frequência no PD.</shortDescription>
            <comment></comment>
            <category>Report</category>
            <requiredData>
                <required>codes</required>
                <required>pds</required>
            </requiredData>
            <complexity>medium</complexity>
            <!-- Computational complexity -->
            <iconPath></iconPath>
            <!-- To be displayed in ATLAS.ti -->
            <author name="Tel Amiel" email="tel@amiel.info" url="http://www.nied.unicamp.br"/>
            <creationDate>2016-07-01</creationDate>
            <modificationDate>2016-08-01</modificationDate>
            <sourceType type="HU" version="5.0"/>
            <!-- XML type acccepted as input -->
            <targetDocType>HTML</targetDocType>
        </atlasDescription>
    </atlas:data>
    <xsl:template match="/">
        <!--<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>-->
        <html>
            <head>
                <xsl:call-template name="htmlhead"/>
            </head>
            <body>
                <div class="container">
                    <!--<body class="centered">-->
                    <xsl:call-template name="pagehead_report"/>

                    <xsl:choose>
                        <!-- warning message -->
                        <xsl:when test="not(exslt:node-set($uniquelist_codes)//content)">
                            <div id="wrap" class="centered_report">
                                <p>
                                    <xsl:value-of select="$outputOption"/>
                                </p>
                            </div>
                        </xsl:when>
                        <!-- FIM - warning message -->
                        <xsl:otherwise>

                            <!--Legenda-->
                            <!--<div class="legenda">-->
                                <!--<h2>Legenda:</h2>-->
                                <!--<ul class="legenda">-->
                                    <!--<li>O que você gostaria de MUDAR na escola está precedido por (-).</li>-->
                                    <!--<li>O que você MAIS gosta na escola NÃO está precedido por (-).</li>-->
                                <!--</ul>-->
                            <!--</div>-->
                            <!--FIM-Legenda-->

                            <div class="accordion">
                                <dl>
                                    <!-- Lógica principal -->
                                    <xsl:for-each select="exslt:node-set($pdsWithCodes)/pd">
                                        <xsl:sort select="@name" data-type="text" order="ascending"/>
                                        <xsl:variable name="pd_id" select="@id"/>
                                        <xsl:variable name="name" select="@name"/>

                                            <dt class="accordionBreak">
                                                <a class="accordionTitle" href="#">
                                                    <!--Nomes e Comentários dos PDs-->
                                                    <xsl:if test="comment!=''">
                                                        <xsl:value-of select="comment"/>
                                                    </xsl:if>
                                                    <xsl:text>(</xsl:text>
                                                    <xsl:value-of select="$name"/>
                                                    <xsl:text>)</xsl:text>
                                                    <!--FIM-Nomes e Comentários dos PDs-->
                                                </a>
                                            </dt>
                                            <dd class="accordionItem accordionItemCollapsed">
                                                <!--Conjunto de Informações-->

                                                <xsl:for-each select="code">
                                                    <xsl:sort select="@quotes" data-type="number" order="descending"/>
                                                    <table class="printabletable">
                                                        <tbody>
                                                            <tr>
                                                                <!-- code name -->
                                                                <th>
                                                                    <p>
                                                                        <xsl:value-of select="@name"/>:
                                                                        <xsl:value-of select="@quotes"/> item(ns)
                                                                    </p>
                                                                </th>
                                                            </tr>
                                                            <xsl:for-each select="p">
                                                                <tr>
                                                                    <td class="rowstyle{position() mod 2}" align="left">
                                                                        <xsl:copy-of select="."/>
                                                                    </td>
                                                                </tr>
                                                            </xsl:for-each>
                                                        </tbody>
                                                    </table>
                                                </xsl:for-each>

                                                <!--END-Conjunto de Informações-->
                                            </dd>

                                    </xsl:for-each>
                                </dl>
                            </div>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>

                <script src="js/index.js">//</script>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>