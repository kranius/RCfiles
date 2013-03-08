<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema">


<xsl:variable name="canvasLineHeight" select="15"/>
<xsl:variable name="canvasWidth" select="240"/>
<xsl:variable name="canvasTextLegendHeight" select="25"/>
<xsl:variable name="canvasLineInfinityWidth" select="30"/>

<xsl:template name="createDate">
  <xsl:param name="date"/>
  <xsl:variable name="_year" select="substring-before($date,'-')"/>
  <xsl:variable name="_s" select="substring-after($date,'-')" />
  <xsl:variable name="_month" select="substring-before($_s,'-')"/>
  <xsl:variable name="_s1" select="substring-after($_s,'-')" />
  <xsl:variable name="_day" select="substring-before($_s1,'+')"/>
  <xsl:value-of select="concat($_year, ',', $_month, ',', $_day)"/>
</xsl:template>

<xsl:template match="/racine">
  <html>
  <head>
 <style type="text/css">
  canvas#myCanvas {
      border: 1px;
      border-style:solid;
      border-color:red;
      }
  </style>
  </head>
  <body>


  <canvas id="myCanvas">
      <xsl:attribute name="width"><xsl:value-of select="$canvasWidth"/></xsl:attribute>
      <xsl:attribute name="height"><xsl:value-of select="count(//periode) * $canvasLineHeight + $canvasTextLegendHeight"/></xsl:attribute>
  </canvas>

   <script type="text/javascript">


function getDaysForDate(year, month, day)
{
var minutes=1000*60;
var hours=minutes*60;
var days=hours*24;
var date = new Date();
date.setFullYear(year, month, day);
return date / days;
}

<!-- ************************** -->
<!-- Function to create a color -->
<!-- ************************** -->
function getAColor(itemNumber) {
  var modulo = 5;
  if (itemNumber % modulo == 0){
      return "#0000FF";}
  if (itemNumber % modulo == 1){
      return "#00FF00";}
  if (itemNumber % modulo == 2){
      return "#FF0000";}
  if (itemNumber % modulo == 3){
      return "#00FFFF";}
  if (itemNumber % modulo == 4){
      return "#FF00FF";}
  else{
      return "#FFFF00";}
}

function getPosition(obj) {
    var curleft = 0, curtop = 0;
    if (obj.offsetParent) {
        do {
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
        } while (obj = obj.offsetParent);
        return { x: curleft, y: curtop };
    }
    return undefined;
}

var firstPeriod = getDaysForDate(<xsl:call-template name="createDate">
  <xsl:with-param name="date" select="periode[1]"></xsl:with-param>
</xsl:call-template>);
var lastPeriod = getDaysForDate(<xsl:call-template name="createDate">
  <xsl:with-param name="date" select="periode[last()]"></xsl:with-param>
</xsl:call-template>);

var canvasLineHeight = <xsl:value-of select="$canvasLineHeight"/>;
var canvasWidth = <xsl:value-of select="$canvasWidth"/>;
var canvasTextLegendHeight = <xsl:value-of select="$canvasTextLegendHeight"/>;
var canvasLineInfinityWidth = <xsl:value-of select="$canvasLineInfinityWidth"/>;


var c=document.getElementById("myCanvas");
var ctx=c.getContext("2d");
var defaultFontSize=canvasTextLegendHeight/2;
ctx.font=defaultFontSize + "px Arial";
ctx.lineWidth=canvasLineHeight;
<!-- ctx.lineCap="round"; -->

function drawInterval(table, k, selected)
{
  var xEnd=canvasWidth;
  var yPos = (k - 0.5) * canvasLineHeight;
  ctx.beginPath();
  if(selected == 'true')
  {
  ctx.strokeStyle='yellow';
  }
  else
  {
  ctx.strokeStyle=getAColor(k);
  }
  ctx.moveTo(table[k][3], yPos);
  ctx.lineTo(xEnd, yPos);
  ctx.stroke();
  ctx.closePath();
}


function addIntervalInTable(table, index, name, price, dateInDays)
{
table[index]=[name, price, dateInDays, (canvasWidth - canvasLineInfinityWidth) * (dateInDays - firstPeriod) / (lastPeriod - firstPeriod)];
}

var table = new Array();

<xsl:for-each select="periode">
<!--   intermediate variables -->

addIntervalInTable(table,
  <xsl:value-of select="position()"/>,
  "<xsl:value-of select="@name"/>",
  "<xsl:value-of select="@price"/>",
  getDaysForDate(<xsl:call-template name="createDate">
    <xsl:with-param name="date" select="."></xsl:with-param>
  </xsl:call-template>));
</xsl:for-each>

var heightUsedByLines=(table.length - 1) * canvasLineHeight;

function drawAll()
{
  for (var i = 1; i &lt; table.length; i++)
  {
    drawInterval(table, i, 'false');
  }
}

drawAll();

c.addEventListener('mousemove', function(evt){
	var canvasPos = getPosition(c);
	var mouseX = evt.pageX - canvasPos.x;
	var mouseY = evt.pageY - canvasPos.y;

	var i = table.length - 1;

	while (i &gt; 0 &amp;&amp; mouseX &lt;= table[i][3])
        {
	  i--;
        }
        var text1 = text2 = '';

	drawAll();

        if (i &gt; 0 &amp;&amp; mouseY &gt;= (i -1) * canvasLineHeight &amp;&amp; mouseY &lt;= (i)*canvasLineHeight)
        {
	  var date = new Date(table[i][2]*1000*60*60*24);
         text1 = table[i][0] + ' ' + table[i][1];
         text2 = date.toLocaleDateString();
         drawInterval(table, i, 'true');
        }
        ctx.clearRect(0,heightUsedByLines,canvasWidth,canvasTextLegendHeight);
        ctx.fillText(text1,0,heightUsedByLines+defaultFontSize);
        ctx.fillText(text2,0,heightUsedByLines+ 2 *defaultFontSize);
    }, false);
 </script>

  </body>
  </html>
</xsl:template>




</xsl:stylesheet>
