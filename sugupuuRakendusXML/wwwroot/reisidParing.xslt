<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="UTF-8"/>

	<xsl:template match="/">

		<!-- Iga reisi detailvaade h1 pealkirjaga ja loendiga -->
		<xsl:for-each select="reisid/reis">
			<h1>
				<xsl:value-of select="suund"/>
			</h1>
			<ul>
				<li style="background-color: yellow;">
					<strong>Riik: </strong>
					<xsl:value-of select="riik"/>
				</li>
				<li style="background-color: yellow;">
					<strong>Kestvus: </strong>
					<xsl:value-of select="kestvus"/> ööd
				</li>
				<li>
					<strong>Transport: </strong>
					<xsl:value-of select="transport/@tyyp"/>
					<xsl:if test="transport/lennufirma">
						&#160;- <xsl:value-of select="transport/lennufirma"/>
						&#160;<xsl:value-of select="transport/lennuNumber"/>
					</xsl:if>
					<xsl:if test="transport/ettevote">
						&#160;- <xsl:value-of select="transport/ettevote"/>
					</xsl:if>
				</li>
				<li>
					<strong>Majutus: </strong>
					<xsl:value-of select="majutus/nimi"/>
					&#160;(<xsl:value-of select="majutus/@tarnid"/>*)
				</li>
				<li>
					<strong>Ekskursioonid: </strong>
					<xsl:value-of select="ekskursioonid/tuur/nimi"/>
				</li>
				<li>
					<strong>Muud kulud: </strong>
					<xsl:value-of select="muudKulud/@hind"/> EUR
					- <xsl:value-of select="muudKulud/kirjeldus"/>
				</li>
				<li>
					<strong>Hinnang: </strong>
					<xsl:value-of select="hinnang"/>
				</li>
			</ul>

			<!-- Pikk reis tingimus -->
			<xsl:if test="kestvus > 7">
				<p style="background-color: orange; color: white; padding: 5px;">
					<strong>Pikk reis</strong>
				</p>
			</xsl:if>

			<!-- Kogukulud: reisi hind + muud kulud + ekskursioon -->
			<p>
				<strong>Kogukulud: </strong>
				<xsl:value-of select="@hind + muudKulud/@hind + ekskursioonid/tuur/@hind"/> EUR
			</p>
		</xsl:for-each>

		<br/>

		<!-- Ainult lennureisid -->
		<strong>Ainult need reisid, mille transpordiks on lennureis</strong>
		<br/>
		<xsl:for-each select="//reis">
			<xsl:if test="transport[@tyyp='lend']">
				<xsl:value-of select="concat(suund, ' - lend: ', transport/lennufirma, ' ', transport/lennuNumber)"/>
				<br/><br/>
			</xsl:if>
		</xsl:for-each>

		<br/>

		<!-- Reisid kestvuse järgi kahanevalt -->
		<strong>Reisid peavad olema kuvatud kestvuse alusel järjestatuna. Suurema kestvusega reis peab olema enne väikese kestvusega reisi.</strong>
		<xsl:for-each select="//reis">
			<xsl:sort select="kestvus" data-type="number" order="descending"/>
			<xsl:value-of select="suund"/>
			-
			<xsl:value-of select="kestvus"/> ööd
			<xsl:if test="kestvus > 7"> - Pikk reis</xsl:if>
			<br/>
		</xsl:for-each>

		<br/>

		<!-- Koondtabel kõigi reisidega, vahelduvad värvid -->
		<strong>Kõik reisid</strong>
		<table border="1" cellpadding="5">
			<tr>
				<th>Suund</th>
				<th>Riik</th>
				<th>Kestvus (ööd)</th>
				<th>Transport</th>
				<th>Majutus</th>
				<th>Ekskursioonid</th>
				<th>Muud kulud (EUR)</th>
				<th>Hinnang</th>
				<th>Kogukulud (EUR)</th>
			</tr>
			<xsl:for-each select="//reis">
				<xsl:sort select="kestvus" data-type="number" order="descending"/>
				<tr>
					<xsl:choose>
						<xsl:when test="position() mod 2 = 0">
							<xsl:attribute name="style">background-color: #d0e8ff;</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="style">background-color: #ffffff;</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<td><xsl:value-of select="suund"/></td>
					<td style="background-color: yellow;"><xsl:value-of select="riik"/></td>
					<td style="background-color: yellow;"><xsl:value-of select="kestvus"/></td>
					<td>
						<xsl:value-of select="transport/@tyyp"/>
						<xsl:if test="transport/lennufirma">
							&#160;(<xsl:value-of select="transport/lennufirma"/>)
						</xsl:if>
					</td>
					<td><xsl:value-of select="majutus/nimi"/></td>
					<td><xsl:value-of select="ekskursioonid/tuur/nimi"/></td>
					<td><xsl:value-of select="muudKulud/@hind"/></td>
					<td><xsl:value-of select="hinnang"/></td>
					<td><xsl:value-of select="@hind + muudKulud/@hind + ekskursioonid/tuur/@hind"/></td>
				</tr>
			</xsl:for-each>
		</table>

		<br/>

	</xsl:template>

</xsl:stylesheet>
