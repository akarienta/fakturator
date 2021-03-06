<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>
    <xsl:param name="versionParam" select="'1.0'"/> 
    <!-- ========================= -->
    <!-- root element: invoice     -->
    <!-- ========================= -->
    <xsl:template match="invoice">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="Calibri">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="simpleA4" page-height="29.7cm" page-width="21cm" margin-top="1.5cm" margin-bottom="1.5cm" margin-left="1.5cm" margin-right="1.5cm">
                    <fo:region-body region-name="xsl-region-body" margin-top="3cm" margin-bottom="2cm"/>
                    <fo:region-before region-name="xsl-region-before" extent="2cm"/>
                    <fo:region-after region-name="xsl-region-after" extent="1cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="simpleA4" id="seq">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block-container font-size="10px" padding="2mm" margin="0" color="white" text-align="right" background-color="black">
                        <fo:block>
                            <xsl:value-of select="contractor/phone"/>
                        </fo:block>
                        <fo:block margin-top="1mm">
                            <xsl:value-of select="contractor/mail"/>
                        </fo:block>
                        <xsl:if test="contractor/web != ''">
                            <fo:block margin-top="1mm">
                                <xsl:value-of select="contractor/web"/>
                            </fo:block>
                        </xsl:if>
                    </fo:block-container>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block-container font-size="10px" padding="2mm" margin-left="0" margin-right="0" color="white" text-align="center" background-color="black">
                        <fo:block>
                            Stránka <fo:page-number ref-id="seq"/> z <fo:page-number-citation-last ref-id="seq"/>
                        </fo:block>
                    </fo:block-container>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">>
                    <fo:block>
                        <fo:inline font-size="22px">Faktura</fo:inline>
                        <fo:inline font-size="28px" padding-left="2mm">
                            <xsl:value-of select="details/invoiceNumber"/>
                        </fo:inline>
                    </fo:block>
                    <fo:table width="100%" table-layout="fixed" border-collapse="collapse">
                        <fo:table-column column-width="proportional-column-width(86)" />
                        <fo:table-column column-width="proportional-column-width(14)" />
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell text-align="right" margin-right="2mm">
                                    <fo:block>Vystaveno dne</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of select="details/issueDate"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell text-align="right" margin-right="2mm">
                                    <fo:block margin-top="1mm">Datum splatnosti</fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block margin-top="1mm">
                                        <xsl:value-of select="details/paymentDue"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <xsl:if test="details/taxDate != ''">
                                <fo:table-row>
                                    <fo:table-cell text-align="right" margin-right="2mm">
                                        <fo:block margin-top="1mm">Datum zdanitelného plnění</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                         <fo:block margin-top="1mm">
                                            <xsl:value-of select="details/taxDate"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:if>
                        </fo:table-body>    
                    </fo:table>
                    <fo:block margin-top="1cm">
                        <fo:table width="100%" table-layout="fixed" border-collapse="collapse">
                            <fo:table-column column-width="50%" />
                            <fo:table-column column-width="50%" />
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block-container width="8.75cm">
                                            <fo:block margin-right="0.75cm" background-color="black" color="white" padding="2mm" font-size="16px">
                                                Dodavatel
                                            </fo:block>
                                            <fo:block-container margin-top="2mm" margin-bottom="2mm" margin-left="2mm">
                                                <fo:block margin-top="3mm">
                                                    <xsl:value-of select="contractor/name"/>
                                                </fo:block>
                                                <fo:block margin-top="3mm">
                                                    <xsl:value-of select="contractor/address"/>
                                                </fo:block>
                                                <fo:block margin-top="1mm">
                                                    <xsl:value-of select="contractor/city"/>
                                                </fo:block>
                                                <fo:block margin-top="1mm">
                                                    <xsl:value-of select="contractor/postalCode"/>
                                                </fo:block>
                                                <fo:block margin-top="3mm">IČ: <xsl:value-of select="contractor/ico"/></fo:block>
                                                <fo:block margin-top="3mm">Není plátcem DPH.</fo:block>
                                            </fo:block-container>
                                        </fo:block-container>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block-container width="8.75cm">
                                            <fo:block margin-left="0.75cm" background-color="black" color="white" padding="2mm" font-size="16px">
                                                Odběratel
                                            </fo:block>
                                            <fo:block-container margin-top="2mm" margin-bottom="2mm" margin-left="0.73cm">
                                                <fo:block margin-top="3mm">
                                                    <xsl:value-of select="customer/name"/>
                                                </fo:block>
                                                <fo:block margin-top="3mm">
                                                    <xsl:value-of select="customer/address"/>
                                                </fo:block>
                                                <fo:block margin-top="1mm">
                                                    <xsl:value-of select="customer/city"/>
                                                </fo:block>
                                                <fo:block margin-top="1mm">
                                                    <xsl:value-of select="customer/postalCode"/>
                                                </fo:block>
                                                <xsl:if test="customer/ico != ''">
                                                    <fo:block margin-top="3mm">IČ: <xsl:value-of select="customer/ico"/></fo:block>
                                                </xsl:if>
                                                <xsl:if test="customer/ico = ''">
                                                    <fo:block margin-top="3mm">Fyzická osoba - nepodnikatel</fo:block>
                                                </xsl:if>
                                                <xsl:if test="customer/ico != '' and customer/dic != '' and customer/dic != '-1'">
                                                    <fo:block margin-top="1mm">DIČ: <xsl:value-of select="customer/dic"/></fo:block>
                                                </xsl:if>
                                                <xsl:if test="customer/ico != '' and customer/dic = '-1'">
                                                    <fo:block margin-top="3mm">Není plátcem DPH.</fo:block>
                                                </xsl:if>
                                            </fo:block-container>
                                        </fo:block-container>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                    <fo:block background-color="black" color="white" padding="2mm" margin="0" margin-top="0.5cm">
                        Informace o platbě
                    </fo:block>
                    <fo:block>
                        <fo:table width="100%" table-layout="fixed" border-collapse="collapse">
                            <fo:table-column column-width="70%" />
                            <fo:table-column column-width="30%" />
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell>
                                        <fo:block-container margin="2mm">
                                            <fo:block margin-top="3mm">Uhraďte, prosím, převodem na níže uvedený účet.</fo:block>
                                            <fo:block margin-top="3mm">
                                                <xsl:value-of select="contractor/bank"/>
                                            </fo:block>
                                            <fo:block margin-top="1mm">
                                                <xsl:value-of select="contractor/accountNumber"/>
                                            </fo:block>    
                                        </fo:block-container>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block border-style="double" border="2px" margin-right="0" margin-top="5mm" padding="3mm" font-size="22px" text-align="center">
                                            <xsl:value-of select="details/totalSum"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>                    
                    <fo:block margin-top="1cm">
                        <fo:table table-layout="fixed" width="100%" border-collapse="collapse" border-after-style="solid" border-after-width.conditionality="retain">
                            <fo:table-column column-width="80%"/>
                            <fo:table-column column-width="20%"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell background-color="black" color="white" padding="2mm">
                                        <fo:block>
                                            Položka
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell background-color="black" color="white" padding="2mm">
                                        <fo:block text-align="right">
                                            Cena
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:apply-templates select="items/item"/>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                    <xsl:if test="(/invoice/contractor/signaturePath) and (/invoice/contractor/signaturePath != '')">-->
                        <fo:block text-align="right" margin-top="1cm">
                            <fo:external-graphic src="{contractor/signaturePath}" content-width="scale-to-fit" height="2cm" scaling="uniform"/>
                        </fo:block>
                    </xsl:if>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
    <!-- ========================= -->
    <!-- child element: item       -->
    <!-- ========================= -->
    <xsl:template match="items/item">
        <fo:table-row>
            <fo:table-cell padding-left="4mm" padding="2mm" border-right-style="dotted" border-color="gray" border-after-style="dotted">
                <xsl:if test="position() mod 2 != 1">
                    <xsl:attribute name="background-color">#E6E6E6</xsl:attribute>
                </xsl:if>
                <fo:block>
                    <xsl:value-of select="name"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-left="4mm" padding="2mm" border-color="gray" border-after-style="dotted">
                <xsl:if test="position() mod 2 != 1">
                    <xsl:attribute name="background-color">#E6E6E6</xsl:attribute>
                </xsl:if>
                <fo:block text-align="right">
                    <xsl:value-of select="price"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
</xsl:stylesheet>
