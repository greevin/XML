<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <atlas:data 
        xmlns:atlas="urn:www.atlasti.com/xml/001">
        <atlasDescription version="2.1">
            <!-- Version of this description syntax -->
            <version number="2.1"/>
            <!-- version of this stylesheet -->
            <friendlyName>XSLT stylesheet library</friendlyName>
            <!-- To be displayed in ATLAS.ti -->
            <shortDescription>contains templates/elements shared by all ATLAS.ti stylesheets</shortDescription>
            <category>library</category>
            <complexity></complexity>
            <!-- Computational complexity -->
            <iconPath></iconPath>
            <!-- To be displayed in ATLAS.ti -->
            <author name="Thomas Ringmayr" email="xml@support.atlasti.com" url="www.atlasti.com/xml.html"/>
            <creationDate>2003-06-30</creationDate>
            <modificationDate>2010-12-09</modificationDate>
            <!-- Now uses utf-8 in htmlhead -->
            <sourceType type="" version=""/>
            <!-- XML type acccepted as input -->
            <targetDocType></targetDocType>
        </atlasDescription>
    </atlas:data>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:variable name="imagedir">images/</xsl:variable>
    <xsl:variable name="stylesdir">styles/</xsl:variable>
    <!-- empty for images in the same directory;do not forget end slash for other dirs! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:variable name="outputOption">Para este relatório funcionar corretamente, você deve selecionar a opção "Include        Primary Documents and Quotations (meta info only).    </xsl:variable>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:variable name="warnmessage">
        <div>
            <p style="style: italic; font-weight: bold; ">O conteúdo completo da citação não pode ser exibido por uma                das seguitnes possibildiades: (a) a fonte de informação não é um arquivo de texto; ou (b) o tamanho é                muito grande.            </p>
        </div>
    </xsl:variable>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="htmlhead">
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type"></meta>
        <title>
            <xsl:value-of select="$description/friendlyName"/>
        </title>
        <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet"/>
        <link rel="stylesheet" href="{$stylesdir}styles_escolas.css" type="text/css"/>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="pagehead_report">
        <div class="logo">
            <div id="logo-img">
                <img src="{$imagedir}/logo_escolas.png" alt="Projeto FAPESP Escolas" class="logo"/>
            </div>
            <div id="logo-text">
                <h1 class="title">
                    <xsl:value-of select="$description/friendlyName"/>
                </h1>
            </div>
        </div>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="properIDformat">
        <xsl:param name="thisID"/>
        <xsl:value-of select="translate($thisID,'_',':')"/>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="properLOCformat">
        <xsl:param name="thisloc"/>
        <xsl:param name="docmimetype"/>
        <xsl:variable name="rtf_part1">
            <xsl:value-of select="substring-after(substring-before($thisloc,','), '@')"/>
        </xsl:variable>
        <xsl:variable name="rtf_part2">
            <xsl:value-of select="substring-before(substring-after(substring-after($thisloc,','),'@'), '!')"/>
        </xsl:variable>
        <xsl:variable name="pdf_innerval" select="substring-before(substring-after($thisloc, 'text:v02:'), ':!')"/>
        <!-- this prefix may change with different pdf versions -->
        <xsl:variable name="pdf_part2">
            <xsl:value-of select="substring-after(substring-after($pdf_innerval, ':'),':')"/>
        </xsl:variable>
        <xsl:variable name="pdf_part1">
            <xsl:value-of select="substring-before($pdf_innerval, $pdf_part2)"/>
        </xsl:variable>
        <xsl:variable name="len">
            <xsl:value-of select="string-length($pdf_part1) -1"/>
        </xsl:variable>
        <xsl:variable name="pdf_part1_proper">
            <xsl:value-of select="substring($pdf_part1, 1, $len)"/>
        </xsl:variable>
        <!--(((FULL LOC: <xsl:value-of select="$thisloc" />)))   show full loc info for testing/comparison -->
        <xsl:choose>
            <xsl:when test="$docmimetype = 'text/pdf'">
                <xsl:value-of select="$pdf_part1_proper"/>
                <xsl:text>-</xsl:text>
                <xsl:value-of select="$pdf_part2"/>
            </xsl:when>
            <xsl:when test="$docmimetype = 'text/rtf'">
                <xsl:value-of select="$rtf_part1"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="$rtf_part2"/>
            </xsl:when>
            <xsl:when test="$docmimetype = 'bmp'">
                <!--MimeType is Bitmap; same format as RTF -->
                <xsl:value-of select="$rtf_part1"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="$rtf_part2"/>
            </xsl:when>
            <xsl:when test="$docmimetype = 'snd'">
                <!-- MimeType is AUDIO; only stores rudimentary data to XML -->
                <xsl:value-of select="substring-before($thisloc, ',')"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="substring-after($thisloc, ',')"/>
            </xsl:when>
            <xsl:when test="$docmimetype = 'vid'">
                <!-- MimeType is VIDEO -->
                <xsl:value-of select="substring-before($thisloc, ',')"/>
                <xsl:text>: </xsl:text>
                <xsl:value-of select="translate(substring-after($thisloc, ','), '!', '')"/>
                <!-- removes exclamation point -->
            </xsl:when>
            <xsl:when test="contains($docmimetype, 'geo')">
                <!-- MimeType is GEODATA -->
                <!-- do nothing - XML geodata format too complex -->
            </xsl:when>
            <xsl:otherwise>
                <!-- do nothing // mime type not understood or supported by this stylesheet -->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="properCDate">
        <xsl:choose>
            <xsl:when test="not(@cDate)">[no date]</xsl:when>
            <xsl:when test="@cDate=''">[date empty]</xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="substring(@cDate, 6,2)"/>-                
                <xsl:value-of select="substring(@cDate, 9,2)"/>-                
                <xsl:value-of select="substring(@cDate, 1,4)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_exporttable">
        <!--  CENTRALLY DISABLED

    <script type="text/javascript">
        <![CDATA[
    function exportToExcel()
    {
    var oExcel = new ActiveXObject("Excel.Application");
    var oBook = oExcel.Workbooks.Add;
    var oSheet = oBook.Worksheets(1);
    for (var y=0;y<detailsTable.rows.length;y++)   // <<< "detailsTable" is the table to be exported
    {
    for (var x=0;x<detailsTable.rows(y).cells.length;x++)
    {
    oSheet.Cells(y+1,x+1) =
    detailsTable.rows(y).cells(x).innerText;
    }
    }
    oExcel.Visible = true;
    oExcel.UserControl = true;
    }
    </script>
    >]]></script>		-->
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="button_exportToExcel">
        <!--  CENTRALLY DISABLED
<button onclick="exportToExcel();">Export to Excel File</button>
-->
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_expandsection">
        <script type="text/javascript" language="javascript">
            <xsl:comment>function doSection (secNum){ if (secNum.style.display=="none"){secNum.style.display=""} else{secNum.style.display="none"} } function noSection (secNum){ if (secNum.style.display==""){secNum.style.display="none"} }            </xsl:comment>
        </script>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_expandsection_multiple">
        <script type="text/javascript" language="javascript">
            <xsl:comment></xsl:comment>
        </script>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_switchCSS">
        <script type="text/javascript" language="javascript">
            <xsl:comment>function switchStyles(src)                {document.getElementsByTagName("link")[0].setAttribute('href',src)}            </xsl:comment>
        </script>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_drag">
        <script type="text/javascript" language="JavaScript1.2">
            <xsl:comment>var ie=document.allvar ns6=document.getElementById&amp;&amp;!document.allvar dragapproved=falsevar z,x,yfunction move(e){if (dragapproved){z.style.left=ns6? temp1+e.clientX-x: temp1+event.clientX-xz.style.top=ns6? temp2+e.clientY-y : temp2+event.clientY-yreturn false}}function                drags(e){if (!ie&amp;&amp;!ns6)returnvar firedobj=ns6? e.target : event.srcElementvar topelement=ns6?                "HTML" : "BODY"while (firedobj.tagName!=topelement&amp;&amp;firedobj.className!="drag"){firedobj=ns6?                firedobj.parentNode : firedobj.parentElement}if (firedobj.className=="drag"){dragapproved=truez=firedobjtemp1=parseInt(z.style.left+0)temp2=parseInt(z.style.top+0)x=ns6?                e.clientX: event.clientXy=ns6? e.clientY: event.clientYdocument.onmousemove=movereturn false}}document.onmousedown=dragsdocument.onmouseup=new Function("dragapproved=false")//            </xsl:comment>
        </script>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="CSS">
        <link rel="stylesheet" href="{$stylesdir}ATLASti.css" type="text/css"/>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_stickynote">
        <script type="text/javascript" language="javascript">
            <xsl:comment>
                <![CDATA[

/***********************************************
* Sticky Note script- � Dynamic Drive DHTML code library (www.dynamicdrive.com)
* Visit DynamicDrive.com for hundreds of DHTML scripts
* This notice must stay intact for legal use
* Go to http://www.dynamicdrive.com/ for full source code
***********************************************/

//Specify display mode. 3 possible values are:
//1) "always"- This makes the fade-in box load each time the page is displayed
//2) "oncepersession"- This uses cookies to display the fade-in box only once per browser session
//3) integer (ie: 5)- Finally, you can specify an integer to display the box randomly via a frequency of 1/integer...
// For example, 2 would display the box about (1/2) 50% of the time the page loads.

var displaymode="always"

var enablefade="yes" //("yes" to enable fade in effect, "no" to disable)
var autohidebox=["no", 0] //Automatically hide box after x seconds? [yes/no, if_yes_hide_after_seconds]
var showonscroll="yes" //Should box remain visible even when user scrolls page? ("yes"/"no)
var IEfadelength=1 //fade in duration for IE, in seconds
var Mozfadedegree=0.05 //fade in degree for NS6+ (number between 0 and 1. Recommended max: 0.2)

////////No need to edit beyond here///////////

if (parseInt(displaymode)!=NaN)
var random_num=Math.floor(Math.random()*displaymode)

function displayfadeinbox(){
var ie=document.all && !window.opera
var dom=document.getElementById iebody=(document.compatMode=="CSS1Compat")? document.documentElement : document.body objref=(dom)? document.getElementById("fadeinbox") : document.all.fadeinbox
var scroll_top=(ie)? iebody.scrollTop : window.pageYOffset
var docwidth=(ie)? iebody.clientWidth : window.innerWidth docheight=(ie)? iebody.clientHeight: window.innerHeight
var objwidth=objref.offsetWidth objheight=objref.offsetHeight objref.style.left=docwidth/2-objwidth/2+"px" objref.style.top=scroll_top+docheight/2-objheight/2+"px"

if (showonscroll=="yes") showonscrollvar=setInterval("staticfadebox()", 50)

if (enablefade=="yes" && objref.filters){ objref.filters[0].duration=IEfadelength objref.filters[0].Apply() objref.filters[0].Play() } objref.style.visibility="visible"
if (objref.style.MozOpacity){
if (enablefade=="yes") mozfadevar=setInterval("mozfadefx()", 90) else{ objref.style.MozOpacity=1
controlledhidebox()
}
}
else
controlledhidebox()
}

function mozfadefx(){
if (parseFloat(objref.style.MozOpacity)<1) objref.style.MozOpacity=parseFloat(objref.style.MozOpacity)+Mozfadedegree
else{
clearInterval(mozfadevar)
controlledhidebox()
}
}

function staticfadebox(){
var ie=document.all && !window.opera
var scroll_top=(ie)? iebody.scrollTop : window.pageYOffset objref.style.top=scroll_top+docheight/2-objheight/2+"px"
}

function hidefadebox(){ objref.style.visibility="hidden"
if (typeof showonscrollvar!="undefined")
clearInterval(showonscrollvar)
}

function controlledhidebox(){
if (autohidebox[0]=="yes"){
var delayvar=(enablefade=="yes" && objref.filters)? (autohidebox[1]+objref.filters[0].duration)*1000 : autohidebox[1]*1000
setTimeout("hidefadebox()", delayvar)
}
}

function initfunction(){
setTimeout("displayfadeinbox()", 100)
}

function get_cookie(Name) {
var search = Name + "="
var returnvalue = ""
if (document.cookie.length > 0) {
offset = document.cookie.indexOf(search)
if (offset != -1) {
offset += search.length
end = document.cookie.indexOf(";", offset)
if (end == -1)
end = document.cookie.length; returnvalue=unescape(document.cookie.substring(offset, end))
}
}
return returnvalue;
}


if (displaymode=="oncepersession" && get_cookie("fadedin")=="" || displaymode=="always" || parseInt(displaymode)!=NaN && random_num==0){
if (window.addEventListener)
window.addEventListener("load", initfunction, false)
else if (window.attachEvent)
window.attachEvent("onload", initfunction)
else if (document.getElementById) window.onload=initfunction document.cookie="fadedin=yes"
}

]]>
            </xsl:comment>
        </script>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="script_tabcontent">
        <script type="text/javascript" language="javascript">
            <xsl:comment>
                <![CDATA[

//** Tab Content script- � Dynamic Drive DHTML code library (http://www.dynamicdrive.com)
//** Last updated: June 29th, 06

var enabletabpersistence=1 //enable tab persistence via session only cookies, so selected tab is remembered?

////NO NEED TO EDIT BELOW////////////////////////
var tabcontentIDs=new Object()

function expandcontent(linkobj){
var ulid=linkobj.parentNode.parentNode.id //id of UL element
var ullist=document.getElementById(ulid).getElementsByTagName("li") //get list of LIs corresponding to the tab contents
for (var i=0; i<ullist.length; i++){ ullist[i].className=""  //deselect all tabs
if (typeof tabcontentIDs[ulid][i]!="undefined") //if tab content within this array index exists (exception: More tabs than there are tab contents) document.getElementById(tabcontentIDs[ulid][i]).style.display="none" //hide all tab contents } linkobj.parentNode.className="selected"  //highlight currently clicked on tab
document.getElementById(linkobj.getAttribute("rel")).style.display="block" //expand corresponding tab content
saveselectedtabcontentid(ulid, linkobj.getAttribute("rel"))
}

function savetabcontentids(ulid, relattribute){// save ids of tab content divs
if (typeof tabcontentIDs[ulid]=="undefined") //if this array doesn't exist yet tabcontentIDs[ulid]=new Array() tabcontentIDs[ulid][tabcontentIDs[ulid].length]=relattribute
}

function saveselectedtabcontentid(ulid, selectedtabid){ //set id of clicked on tab as selected tab id & enter into cookie
if (enabletabpersistence==1) //if persistence feature turned on
setCookie(ulid, selectedtabid)
}

function getullistlinkbyId(ulid, tabcontentid){ //returns a tab link based on the ID of the associated tab content
var ullist=document.getElementById(ulid).getElementsByTagName("li")
for (var i=0; i<ullist.length; i++){
if (ullist[i].getElementsByTagName("a")[0].getAttribute("rel")==tabcontentid){
return ullist[i].getElementsByTagName("a")[0]
break
}
}
}

function initializetabcontent(){
for (var i=0; i<arguments.length; i++){ //loop through passed UL ids
if (enabletabpersistence==0 && getCookie(arguments[i])!="") //clean up cookie if persist=off
setCookie(arguments[i], "")
var clickedontab=getCookie(arguments[i]) //retrieve ID of last clicked on tab from cookie, if any
var ulobj=document.getElementById(arguments[i])
var ulist=ulobj.getElementsByTagName("li") //array containing the LI elements within UL
for (var x=0; x<ulist.length; x++){ //loop through each LI element
var ulistlink=ulist[x].getElementsByTagName("a")[0]
if (ulistlink.getAttribute("rel")){
savetabcontentids(arguments[i], ulistlink.getAttribute("rel")) //save id of each tab content as loop runs ulistlink.onclick=function(){
expandcontent(this)
return false
}
if (ulist[x].className=="selected" && clickedontab=="") //if a tab is set to be selected by default
expandcontent(ulistlink) //auto load currenly selected tab content
}
} //end inner for loop
if (clickedontab!=""){ //if a tab has been previously clicked on per the cookie value
var culistlink=getullistlinkbyId(arguments[i], clickedontab)
if (typeof culistlink!="undefined") //if match found between tabcontent id and rel attribute value
expandcontent(culistlink) //auto load currenly selected tab content
else //else if no match found between tabcontent id and rel attribute value (cookie mis-association)
expandcontent(ulist[0].getElementsByTagName("a")[0]) //just auto load first tab instead
}
} //end outer for loop
}


function getCookie(Name){ 
var re=new RegExp(Name+"=[^;]+", "i"); //construct RE to search for target name/value pair
if (document.cookie.match(re)) //if cookie found
return document.cookie.match(re)[0].split("=")[1] //return its value
return ""
}

function setCookie(name, value){
document.cookie = name+"="+value //cookie value is domain wide (path=/)
}



]]>
            </xsl:comment>
        </script>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="closeButton">
        <xsl:param name="id"/>
        <xsl:param name="position"/>
        <!-- position close symbol individually in relation to div/td, e.g. above it -->
        <div class="close">
            <xsl:attribute name="style">
                <xsl:text>cursor: hand;</xsl:text>
                <xsl:if test="$position and $position!=''">
                    <xsl:value-of select="$position"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:attribute name="onclick">noSection(                
                <xsl:value-of select="$id"/>)            
            </xsl:attribute>
            <xsl:attribute name="onmousedown">noSection(                
                <xsl:value-of select="$id"/>)            
            </xsl:attribute>
            <img src="{$imagedir}close_w7_small.png" alt="close" border="0"/>
        </div>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="simplepagefooter">
        <p>
            <xsl:text>ATLAS</xsl:text>
            <span style="color:#f00">.</span>
            <xsl:text>ti XSL Stylesheet Demo</xsl:text>
            <xsl:text>: </xsl:text>
            <strong>
                <xsl:value-of select="$description/friendlyName"/>
            </strong>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="$description/shortDescription"/>
        </p>
        <xsl:if test="$description/author">
            <p>
                <xsl:text>Author: </xsl:text>
                <xsl:value-of select="$description/author/@name"/>
                <xsl:if test="$description/author/@company and $description/author/@company!=''">
                    <xsl:text>  | </xsl:text>
                    <xsl:value-of select="$description/author/@company"/>
                </xsl:if>
                <xsl:if test="$description/author/@email and $description/author/@email!=''">
                    <xsl:text>  | </xsl:text>
                    <a target="_blank" href="mailto:{$description/author/@email}">
                        <xsl:value-of select="$description/author/@email"/>
                    </a>
                </xsl:if>
                <xsl:if test="$description/author/@url and $description/author/@url!=''">
                    <xsl:text>  | </xsl:text>
                    <a target="_blank" href="{$description/author/@url}">
                        <xsl:value-of select="$description/author/@url"/>
                    </a>
                </xsl:if>
            </p>
        </xsl:if>
        <p>
            <xsl:text>HU: </xsl:text>
            <xsl:text>Title: </xsl:text>
            <strong>
                <xsl:value-of select="//hermUnit/@name"/>
            </strong>
            <xsl:text>  | </xsl:text>
            <xsl:text>HU Author: </xsl:text>
            <strong>
                <xsl:value-of select="//hermUnit/@au"/>
            </strong>
            <xsl:text>  | </xsl:text>
            <xsl:text>Creation Date: </xsl:text>
            <strong>
                <xsl:value-of select="//hermUnit/@cDate"/>
            </strong>
            <xsl:text>  | </xsl:text>
            <xsl:text>Last Modified: </xsl:text>
            <strong>
                <xsl:value-of select="//hermUnit/@mDate"/>
            </strong>
        </p>
        <xsl:if test="$description/howTo">
            <p>
                <xsl:text>Instructions: </xsl:text>
                <xsl:value-of select="$description/howTo"/>
            </p>
        </xsl:if>
        <xsl:if test="$description/comment">
            <p>
                <xsl:text>Info: </xsl:text>
                <xsl:value-of select="$description/comment"/>
            </p>
        </xsl:if>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
    <xsl:template name="atlasfooter">
        <xsl:param name="withimage"/>
        <div id="atlasfooter">
            <xsl:choose>
                <xsl:when test="$withimage!='yes'">
                    <p>ATLAS.ti XSL Stylesheet Demo</p>
                </xsl:when>
                <xsl:otherwise>
                    <p>
                        <img src="images/ATLAStiLogo2006_mini.gif" align="left" alt="ATLAS.ti XSL Stylesheet Demo" border="0"/>
                        <xsl:text>XSL Stylesheet Demo &#169; 2007</xsl:text>
                    </p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>
    <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
</xsl:stylesheet>