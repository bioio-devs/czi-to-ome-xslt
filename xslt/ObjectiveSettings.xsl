<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ome="http://www.openmicroscopy.org/Schemas/OME/2016-06">

    <xsl:template match="ObjectiveRef">
        <xsl:attribute name="ID">
            <xsl:value-of select="@Id"/>
        </xsl:attribute>
    </xsl:template>

    <!-- ZEN writes media that OME does not define (e.g. 'User Medium'); map those to Other -->
    <xsl:template match="Medium">
        <xsl:if test="string-length(.) &gt; 0">
            <xsl:attribute name="Medium">
                <xsl:choose>
                    <xsl:when test="contains(' Air Oil Water Glycerol Other ', concat(' ', ., ' '))">
                        <xsl:value-of select="."/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>Other</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <xsl:template match="RefractiveIndex">
        <xsl:attribute name="RefractiveIndex">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

<!--
    /Metadata/Information/Image/ObjectiveSettings
        =>
    /OME/Image/ObjectiveSettings
    -->
    <xsl:template match="ObjectiveSettings">
        <xsl:element name="ome:ObjectiveSettings">
            <xsl:apply-templates select="ObjectiveRef"/>
            <xsl:apply-templates select="Medium"/>
            <xsl:apply-templates select="RefractiveIndex"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>

