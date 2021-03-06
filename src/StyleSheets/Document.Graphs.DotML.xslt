﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
				xmlns:dotml="http://www.martin-loetzsch.de/DOTML" 
				xmlns:exsl="http://exslt.org/common"
        extension-element-prefixes="exsl"				
				>

	<xsl:output method="xml" indent="yes"/>

	<xsl:include href='Include.Graphs.Defaults.xslt'/>
	<xsl:include href="Common.Graphs.DotML.xslt"/>
	
	<!-- specific templates for graphs -->
	<xsl:include href='Include.Graphs.File2Ampla.xslt'/>	
	
	<!--
	<xsl:include href='Include.Graphs.Plant2Business.xslt'/>	 
	-->
	<xsl:include href='Include.Graphs.Database2Ampla.xslt'/>
	<xsl:include href='Include.Graphs.ReportingPoint.xslt'/>		
	<xsl:include href='Include.Graphs.Metrics.xslt'/>	
	<xsl:include href='Include.Graphs.Project.xslt'/>	

	<xsl:template match="/">
		<xsl:element name="Graphs">
			<xsl:for-each select="//Item[@id]">
				<xsl:variable name='include'>
					<xsl:apply-templates select='.' mode='include'/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$include = 'Yes'">
						<xsl:comment><xsl:value-of select='@fullName'/> is a match</xsl:comment>
						<xsl:variable name='filename'>
							<xsl:apply-templates select='.' mode='get-dotml-filename'/>
						</xsl:variable>
						<exsl:document href="{concat('Graphs\', $filename)}" method="xml" indent="yes">
							<xsl:apply-templates select='.' mode='graph'>
								<xsl:with-param name='filename' select='$filename'/>
							</xsl:apply-templates>
						</exsl:document>
						<xsl:call-template name='output-cmd'/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
			
</xsl:stylesheet>
