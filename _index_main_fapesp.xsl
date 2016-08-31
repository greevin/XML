<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:exslt="http://exslt.org/common" exclude-result-prefixes="exslt" version="1.0">
    <!--<xsl:output method="xml" indent="yes"/>-->
    <atlas:data 
        xmlns:atlas="urn:www.atlasti.com/xml/001">
        <atlasDescription version="2.1">
            <!-- Version of this description syntax -->
            <version number="2.1"/>
            <!-- version of this stylesheet -->
            <friendlyName>indexes</friendlyName>
            <!-- To be displayed in ATLAS.ti -->
            <shortDescription></shortDescription>
            <category>library</category>
            <complexity></complexity>
            <!-- Computational complexity -->
            <iconPath></iconPath>
            <!-- To be displayed in ATLAS.ti -->
            <author name="Thomas Ringmayr" email="xml@support.atlasti.com" url="www.atlasti.com/xml.html"/>
            <creationDate>2012-02-02</creationDate>
            <modificationDate>2012-02-02</modificationDate>
            <sourceType type="" version=""/>
            <!-- XML type acccepted as input -->
            <targetDocType></targetDocType>
        </atlasDescription>
    </atlas:data>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- UNIQUE list of CODES -->
    <xsl:variable name="uniquelist_codes">
        <xsl:for-each select="storedHU/links/objectSegmentLinks/codings/iLink">
            <xsl:sort select="@obj"/>
            <xsl:variable name="obj">
                <xsl:value-of select="@obj"/>
            </xsl:variable>
            <xsl:if test="not(following-sibling::iLink/@obj=$obj) ">
                <xsl:element name="item">
                    <xsl:attribute name="code">
                        <xsl:value-of select="@obj"/>
                    </xsl:attribute>
                    <xsl:attribute name="count">
                        <xsl:value-of select="count(//iLink[@obj = $obj])"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="//code[@id = $obj]/@name"/>
                    </xsl:attribute>
                    <xsl:attribute name="codeID">
                        <xsl:value-of select="//code[@id = $obj]/@id"/>
                    </xsl:attribute>
                    <xsl:attribute name="codeColor">
                        <xsl:value-of select="//code[@id = $obj]/@color"/>
                    </xsl:attribute>
                    <xsl:for-each select="//code[@id = $obj]">
                        <xsl:element name="codecomment">
                            <xsl:copy-of select="comment/*"/>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:for-each select="ancestor::codings/iLink[@obj=$obj]">
                        <xsl:variable name="qRef">
                            <xsl:value-of select="@qRef"/>
                        </xsl:variable>
                        <xsl:element name="quote">
                            <xsl:attribute name="qRef">
                                <xsl:value-of select="$qRef"/>
                            </xsl:attribute>
                            <xsl:for-each select="//q[@id=$qRef]">
                                <xsl:variable name="position">
                                    <xsl:number count="q" level="any"/>
                                </xsl:variable>
                                <!-- only TEXT docs have content, hence all others will be empty -->
                                <xsl:element name="content">
                                    <xsl:attribute name="source">
                                        <xsl:value-of select="ancestor::primDoc/@name"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="quoteid">
                                        <xsl:value-of select="@id"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="quotenr">
                                        <xsl:value-of select="substring-after(@id, '_')"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="author">
                                        <xsl:value-of select="@au"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="@name"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="position">
                                        <xsl:value-of select="$position"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="outputsize">
                                        <xsl:value-of select="@size"/>
                                    </xsl:attribute>
                                    <xsl:choose>
                                        <xsl:when test="content and content/@size &lt; $maxquotesize">
                                            <xsl:attribute name="content">available</xsl:attribute>
                                            <xsl:copy-of select="content"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="content">unavailable</xsl:attribute>
                                            <p>
                                                <xsl:value-of select="@name"/>
                                            </p>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="comment">
                                        <xsl:element name="comment">
                                            <xsl:for-each select="comment/p">
                                                <!-- seems redundant but MSXML seems to require this verbose procedure -->
                                                <xsl:element name="p">
                                                    <xsl:copy-of select="."/>
                                                </xsl:element>
                                            </xsl:for-each>
                                        </xsl:element>
                                    </xsl:if>
                                </xsl:element>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
                <!-- item ends -->
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:variable name="uniquelist_codes_fulldata">
        <xsl:for-each select="storedHU/links/objectSegmentLinks/codings/iLink">
            <xsl:sort select="@obj"/>
            <xsl:variable name="obj">
                <xsl:value-of select="@obj"/>
            </xsl:variable>
            <xsl:if test="not(following-sibling::iLink/@obj=$obj) ">
                <xsl:element name="item">
                    <xsl:attribute name="code">
                        <xsl:value-of select="@obj"/>
                    </xsl:attribute>
                    <xsl:attribute name="count">
                        <xsl:value-of select="count(//iLink[@obj = $obj])"/>
                    </xsl:attribute>
                    <xsl:attribute name="name">
                        <xsl:value-of select="//code[@id = $obj]/@name"/>
                    </xsl:attribute>
                    <xsl:attribute name="codecolor">
                        <xsl:value-of select="//code[@id = $obj]/@color"/>
                    </xsl:attribute>
                    <xsl:for-each select="ancestor::codings/iLink[@obj=$obj]">
                        <xsl:variable name="qRef">
                            <xsl:value-of select="@qRef"/>
                        </xsl:variable>
                        <xsl:element name="quote">
                            <xsl:attribute name="qRef">
                                <xsl:value-of select="$qRef"/>
                            </xsl:attribute>
                            <xsl:for-each select="//q[@id=$qRef]">
                                <xsl:variable name="position">
                                    <xsl:number count="q" level="any"/>
                                </xsl:variable>
                                <xsl:variable name="parentDocID">
                                    <xsl:value-of select="ancestor::primDoc/@loc"/>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="not(contains(ancestor::primDoc[@loc=$parentDocID]/@loc, 'me_')) and not(contains(//dataSource[@id = $parentDocID]/@mime,'text')) ">
                                        <xsl:if test="comment">
                                            <xsl:element name="comment">
                                                <xsl:copy-of select="comment/*"/>
                                            </xsl:element>
                                        </xsl:if>
                                        <xsl:element name="content">
                                            <xsl:attribute name="sourcename">
                                                <xsl:value-of select="ancestor::primDoc/@name"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="sourceid">
                                                <xsl:value-of select="ancestor::primDoc/@id"/>
                                            </xsl:attribute>
                                            <!-- following attributes used for error diagnosis -->
                                            <xsl:attribute name="dataSourceID">
                                                <xsl:value-of select="//dataSource[@id = $parentDocID]/@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="dataSourceMIME">
                                                <xsl:value-of select="//dataSource[@id = $parentDocID]/@mime"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="docmimetype">
                                                <!-- PD can also be a memo!!! -->
                                                <xsl:choose>
                                                    <xsl:when test="contains(ancestor::primDoc/@loc, 'me_')">text/rtf                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="//dataSource[@id=$parentDocID]/@mime"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                            <xsl:attribute name="quotenr_full">
                                                <xsl:value-of select="@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="quotenr">
                                                <xsl:value-of select="substring-after(@id, '_')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="position">
                                                <xsl:value-of select="$position"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="loc">
                                                <xsl:value-of select="@loc"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="isText">no</xsl:attribute>
                                            <xsl:value-of select="@name"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:when test="content and content/@size &lt; $maxquotesize">
                                        <xsl:if test="comment">
                                            <xsl:element name="comment">
                                                <xsl:copy-of select="comment/*"/>
                                            </xsl:element>
                                        </xsl:if>
                                        <xsl:element name="content">
                                            <xsl:attribute name="sourcename">
                                                <xsl:value-of select="ancestor::primDoc/@name"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="sourceid">
                                                <xsl:value-of select="ancestor::primDoc/@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="docmimetype">
                                                <!-- PD can also be a memo!!! -->
                                                <xsl:choose>
                                                    <xsl:when test="contains(ancestor::primDoc/@loc, 'me_')">text/rtf                                                    </xsl:when>
                                                    <xsl:when test="contains(ancestor::primDoc/@mime, 'indirect')">                                                        text/rtf                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="//dataSource[@id=$parentDocID]/@mime"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                            <xsl:attribute name="quotenr_full">
                                                <xsl:value-of select="@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="quotenr">
                                                <xsl:value-of select="substring-after(@id, '_')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="position">
                                                <xsl:value-of select="$position"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="loc">
                                                <xsl:value-of select="@loc"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="outputsize">
                                                <xsl:value-of select="@size"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="isText">yes</xsl:attribute>
                                            <xsl:copy-of select="content"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:if test="comment">
                                            <xsl:element name="comment">
                                                <xsl:copy-of select="comment/*"/>
                                            </xsl:element>
                                        </xsl:if>
                                        <xsl:element name="content">
                                            <xsl:attribute name="sourcename">
                                                <xsl:value-of select="ancestor::primDoc/@name"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="sourceid">
                                                <xsl:value-of select="ancestor::primDoc/@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="docmimetype">
                                                <!-- PD can also be a memo!!! -->
                                                <xsl:choose>
                                                    <xsl:when test="contains(ancestor::primDoc/@loc, 'me_')">text/rtf                                                    </xsl:when>
                                                    <xsl:when test="contains(ancestor::primDoc/@mime, 'indirect')">                                                        text/rtf                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="//dataSource[@id=$parentDocID]/@mime"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:attribute>
                                            <xsl:attribute name="quotenr_full">
                                                <xsl:value-of select="@id"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="quotenr">
                                                <xsl:value-of select="substring-after(@id, '_')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="position">
                                                <xsl:value-of select="$position"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="loc">
                                                <xsl:value-of select="@loc"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="outputsize">0</xsl:attribute>
                                            <xsl:attribute name="isText">yes</xsl:attribute>
                                            <xsl:value-of select="@name"/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
        </xsl:for-each>
    </xsl:variable>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- create fragment tree, grouping all codes used per quote per PD  -->
    <!-- the follwing code still located in NNN_pds_codes.xsl, removing from there creates error -->
    <xsl:variable name="indextree_quotes_per_codes">
        <xsl:for-each select="//primDocs/primDoc">
            <xsl:element name="pd">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
                <xsl:attribute name="author">
                    <xsl:value-of select="@au"/>
                </xsl:attribute>
                <xsl:attribute name="cDate">
                    <xsl:value-of select="@cDate"/>
                </xsl:attribute>
                <xsl:attribute name="mDate">
                    <xsl:value-of select="@mDate"/>
                </xsl:attribute>
                <xsl:if test="comment and comment!=''">
                    <xsl:copy-of select="comment"/>
                </xsl:if>
                <xsl:for-each select="quotations/q">
                    <xsl:variable name="qRef">
                        <xsl:value-of select="@id"/>
                    </xsl:variable>
                    <!--<xsl:element name="q">-->
                    <!--<xsl:attribute name="qRef">-->
                    <!--<xsl:value-of select="@id"/>-->
                    <!--</xsl:attribute>-->
                    <!--<xsl:attribute name="name">-->
                    <!--<xsl:value-of select="@name"/>-->
                    <!--</xsl:attribute>-->
                    <!--<xsl:attribute name="author">-->
                    <!--<xsl:value-of select="@au"/>-->
                    <!--</xsl:attribute>-->
                    <!--<xsl:attribute name="cDate">-->
                    <!--<xsl:value-of select="@cDate"/>-->
                    <!--</xsl:attribute>-->
                    <!--<xsl:attribute name="mDate">-->
                    <!--<xsl:value-of select="@mDate"/>-->
                    <!--</xsl:attribute>-->
                    <xsl:for-each select="//codings/iLink[@qRef = $qRef]">
                        <xsl:sort select="@obj"/>
                        <xsl:variable name="codeid">
                            <xsl:value-of select="@obj"/>
                        </xsl:variable>
                        <xsl:element name="code">
                            <xsl:attribute name="id">
                                <xsl:value-of select="@obj"/>
                            </xsl:attribute>
                            <xsl:attribute name="name">
                                <xsl:value-of select="//codes/code[@id = $codeid]/@name"/>
                            </xsl:attribute>
                            <xsl:attribute name="linkedToQuote">
                                <xsl:value-of select="$qRef"/>
                            </xsl:attribute>
                            <xsl:choose>
                                <xsl:when test="//q[@id=$qRef]/content and //q[@id=$qRef]/content/@size &lt; $maxquotesize">
                                    <xsl:attribute name="content">available</xsl:attribute>
                                    <xsl:copy-of select="//q[@id=$qRef]/content/*"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:attribute name="content">unavailable</xsl:attribute>
                                    <p>
                                        <xsl:value-of select="//q[@id=$qRef]/@name"/>
                                    </p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:element>
                    </xsl:for-each>
                    <!--</xsl:element>-->
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="pdsWithCodes">
        <xsl:for-each select="exslt:node-set($indextree_quotes_per_codes)//pd">
            <xsl:sort select="@id"/>
            <xsl:element name="pd">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id"/>
                </xsl:attribute>
                <xsl:attribute name="name">
                    <xsl:value-of select="@name"/>
                </xsl:attribute>
                <!--<xsl:attribute name="author">-->
                <!--<xsl:value-of select="@au"/>-->
                <!--</xsl:attribute>-->
                <!--<xsl:attribute name="cDate">-->
                <!--<xsl:value-of select="@cDate"/>-->
                <!--</xsl:attribute>-->
                <!--<xsl:attribute name="mDate">-->
                <!--<xsl:value-of select="@mDate"/>-->
                <!--</xsl:attribute>-->
                <xsl:copy-of select="comment"/>
                <xsl:for-each select="code[not(@id = ./following-sibling::code/@id)]">
                    <xsl:sort select="@id"/>
                    <xsl:variable name="codeID">
                        <xsl:value-of select="@id"/>
                    </xsl:variable>
                    <xsl:variable name="codeName">
                        <xsl:value-of select="@name"/>
                    </xsl:variable>
                    <xsl:element name="code">
                        <xsl:attribute name="id">
                            <xsl:value-of select="$codeID"/>
                        </xsl:attribute>
                        <xsl:attribute name="name">
                            <xsl:value-of select="$codeName"/>
                        </xsl:attribute>
                        <xsl:attribute name="quotes">
                            <xsl:value-of select="count(../code[@id=$codeID])"/>
                        </xsl:attribute>
                        <xsl:for-each select="../code[@id=$codeID]">
                            <xsl:copy-of select="p"/>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
    </xsl:variable>
    <!--<xsl:variable name="codeslist">-->
    <!--<xsl:for-each select="exslt:node-set($indextree_quotes_per_codes)//code">-->
    <!--<xsl:sort select="@id"/>-->
    <!--<xsl:copy-of select="."/>-->
    <!--</xsl:for-each>-->
    <!--</xsl:variable>-->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
</xsl:stylesheet>