<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:msxsl="urn:schemas-microsoft-com:xslt">
  <xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" omit-xml-declaration="yes" indent="yes"/>
  <xsl:variable name= "maxquotesize">10000</xsl:variable>
  <xsl:variable name= "description" select="document('')//atlasDescription" />
  <xsl:include href="_shared_fapesp.xsl.inc"/>
  <xsl:include href="_index_main_fapesp.xsl.inc"/>
  <atlas:data 
    xmlns:atlas="urn:www.atlasti.com/xml/001">
    <atlasDescription version = "2.1">
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
      <sourceType type = "HU" version = "5.0"/>
      <!-- XML type acccepted as input -->
      <targetDocType>HTML</targetDocType>
    </atlasDescription>
  </atlas:data>
  <xsl:template match="/">
    <!--<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>-->
    <html 
      xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <xsl:call-template name="htmlhead"/>
      </head>
      <body class="centered">
        <xsl:call-template name="pagehead_report"/>
        <div id="wrap" class="centered_report">
          <div class="tablecontainer">
            <xsl:choose>
              <!-- warning message -->
              <xsl:when test="not(msxsl:node-set($uniquelist_codes)//content)">
                <p>
                  <xsl:value-of select="$outputOption"/>
                </p>
              </xsl:when>
              <!-- FIM - warning message -->
              <xsl:otherwise>
                <!--Nomes e Comentários dos PDs-->
                <table border="0" class="printabletable-nobreak">
                  <tbody>
                    <tr>
                      <th class="rowstyle{position() mod 2}">
                        <p>Informações:</p>
                      </th>
                    </tr>
                    <xsl:for-each select="storedHU/primDocs/primDoc">
                      <xsl:sort select="@name"/>
                      <xsl:if test="comment!=''">
                        <tr>
                          <td class="rowstyle{position() mod 2}">
                            <xsl:value-of select="comment"/>
                          </td>
                        </tr>
                      </xsl:if>
                    </xsl:for-each>
                  </tbody>
                </table>
                <!--FIM-Nomes e Comentários dos PDs-->
                <!--Legenda-->
                <div class="legenda">
                  <h2>Legenda:</h2>
                  <ul class="legenda">
                    <li>O que você MENOS gosta na escola está precedido por (-).</li>
                    <li>O que você MAIS gosta na escola NÃO está precedido por (-).</li>
                  </ul>
                </div>
                <!--FIM-Legenda-->
                <div class="separador"></div>
                <!-- Lógica principal -->
                <xsl:for-each select="msxsl:node-set($uniquelist_codes)//item[@name!='']">
                  <xsl:sort select="@count" data-type="number" order="descending" />
                  <xsl:variable name="id" select="generate-id()"/>
                  <xsl:variable name="obj" select="@obj"/>
                  <xsl:variable name="name" select="@name"/>
                  <xsl:variable name="counter" select="position() + 1"/>
                  <xsl:variable name="count" select="@count"/>
                  <xsl:variable name="codeID" select="@codeID"/>
                  <xsl:variable name="hasCodeComment">
                    <xsl:choose>
                      <xsl:when test="codecomment and codecomment!=''">yes</xsl:when>
                      <xsl:otherwise>no</xsl:otherwise>
                    </xsl:choose>
                  </xsl:variable>
                  <!--Tabelas com mais de 30 elementos terão quebras obrigatórias antes delas ao serem impressas-->
                  <xsl:choose>
                    <xsl:when test="$count &gt; 40">
                      <!--Conjunto de informações-->
                      <table border="0" class="printabletable-break">
                        <tbody>
                          <tr>
                            <!-- code name -->
                            <th class="rowstyle{position() mod 2}">
                              <p>
                                <xsl:value-of select="@name"/>:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                <xsl:value-of select="@count"/> item(ns)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                              </p>
                            </th>
                          </tr>
                          <xsl:for-each select="quote">
                            <xsl:variable name="outputsize" select="content/@outputsize"/>
                            <xsl:variable name="hasComment">
                              <xsl:choose>
                                <xsl:when test="comment">yes</xsl:when>
                                <xsl:otherwise>no</xsl:otherwise>
                              </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="numberOfParagraphs">
                              <xsl:value-of select="count(descendant::p)" />
                            </xsl:variable>
                            <tr>
                              <td class="rowstyle{position() mod 2}" align="left">
                                <xsl:copy-of select="content/* "/>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                      <div class="separador"></div>
                      <!--END-Conjunto de Informações-->
                    </xsl:when>
                    <xsl:otherwise>
                      <!--Conjunto de informações-->
                      <table border="0" class="printabletable-nobreak">
                        <tbody>
                          <tr>
                            <!-- code name -->
                            <th class="rowstyle{position() mod 2}">
                              <p>
                                <xsl:value-of select="@name"/>:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
                                <xsl:value-of select="@count"/> item(ns)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                              </p>
                            </th>
                          </tr>
                          <xsl:for-each select="quote">
                            <xsl:variable name="outputsize" select="content/@outputsize"/>
                            <xsl:variable name="hasComment">
                              <xsl:choose>
                                <xsl:when test="comment">yes</xsl:when>
                                <xsl:otherwise>no</xsl:otherwise>
                              </xsl:choose>
                            </xsl:variable>
                            <xsl:variable name="numberOfParagraphs">
                              <xsl:value-of select="count(descendant::p)" />
                            </xsl:variable>
                            <tr>
                              <td class="rowstyle{position() mod 2}" align="left">
                                <xsl:copy-of select="content/* "/>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                      <div class="separador"></div>
                      <!--END-Conjunto de Informações-->
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>