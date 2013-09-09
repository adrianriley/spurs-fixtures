<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes" doctype-public="-//w3c//dtd html 4.0 transitional//en" />
	
<xsl:template match="/">
<html>

<xsl:apply-templates select="fixtures"/>
</html>
</xsl:template>

<xsl:template match="fixtures">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
   <link rel="STYLESHEET" type="text/css" href="../style/spurs.css" title="Spurs"/>
   <title>Tottenham Hotspur Fixtures <xsl:value-of select="season"/></title>
</head>

<body>
<table border="0" width="800" >
<caption>TOTTENHAM HOTSPUR FIXTURES <xsl:value-of select="season"/></caption>

<colgroup>
<col class="ac" width="15"/>
<col class="ac" width="75"/>
<col class="ac" width="45"/>
<col class="opp"/>
<col class="ac" width="50"/>
<col class="ac" width="60"/>
<col class="al"/>
</colgroup>

<tbody>
<tr>
<th>At</th>
<th>Date</th>
<th>Time</th>
<th>Opposition</th>
<th>Comp</th>
<th>Score</th>
<th>Scorers</th>
</tr>

<xsl:apply-templates select="match"/>

</tbody>
</table>
</body>

</xsl:template>

<xsl:template match="match">
<tr>
	<td class="ac"><xsl:value-of select="venue"/></td>
	<td class="ac"><xsl:value-of select="day"/><xsl:text> </xsl:text><xsl:value-of select="date"/></td>
	<td class="ac"><xsl:value-of select="time"/></td>
	<td class="opp"><xsl:value-of select="opposition"/></td>
	<td class="ac" style="padding: 0;"><xsl:apply-templates select="competition"/></td>
	<td class="ac"><xsl:apply-templates select="result"/></td>
	<td class="al"><xsl:apply-templates select="goals"/></td>
</tr>
</xsl:template>

<xsl:template match="competition">
<xsl:choose>
	<xsl:when test=". = 'Premiership'">
	<img alt="Premiership"  src="../images/premiership_logo.gif"/>
	</xsl:when>
	<xsl:when test=". = 'FAC'">
	<img alt="FA Cup"  src="../images/fa_cup_logo.gif"/>
	</xsl:when>
	<xsl:when test=". = 'CLC'">
	<img alt="Carling Cup"  src="../images/carling_cup_logo.gif"/>
	</xsl:when>
	<xsl:when test=". = 'COLC'">
	<img alt="League Cup"  src="../images/capital_one_cup_logo.jpg"/>
	</xsl:when>
	<xsl:when test=". = 'UEFA'">
	<img alt="UEFA Cup"  src="../images/uefa_cup_logo.gif"/>
	</xsl:when>
	<xsl:when test=". = 'CL'">
	<img alt="Champions League"  src="../images/champions-league-21.gif"/>
	</xsl:when>
	<xsl:when test=". = 'EL'">
	<img alt="Europa League"  src="../images/europa_league_logo.jpg"/>
	</xsl:when>
	<xsl:otherwise>
	<xsl:value-of select="."/>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="result">
  <xsl:if test="for and string-length(for) > 0">
    <xsl:choose>
      <xsl:when test="report and string-length(report) > 0">
        <a class="report">
          <xsl:attribute name="href">
            <xsl:value-of select="report"/>
          </xsl:attribute>
          <xsl:attribute name="title">
            <xsl:value-of select="report/@source"/> report</xsl:attribute>
          <xsl:call-template name="score"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="score"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="penalties"/>
  </xsl:if>
</xsl:template>

<xsl:template name="score">
  <xsl:if test="for">
<xsl:value-of select="for"/><xsl:text> - </xsl:text><xsl:value-of select="against"/>
  </xsl:if>
</xsl:template>

<xsl:template match="goals">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="penalties">
<br/>P: <xsl:call-template name="score"/>
</xsl:template>

<xsl:template match="scorer">
<xsl:value-of select="."/>
<xsl:if test="@detail"><sup><xsl:value-of select="@detail"/></sup></xsl:if>
<xsl:if test="position() != last() - 1"><xsl:text>, </xsl:text></xsl:if>
</xsl:template>

</xsl:stylesheet>
