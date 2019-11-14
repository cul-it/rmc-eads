<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:HTML="http://www.w3.org/Profiles/XHTML-transitional"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xpath-default-namespace="urn:isbn:1-931666-22-9">

	<!--<xsl:output method="html" version="5.0" use-character-maps="no-control-characters"/>-->
	<xsl:character-map name="no-control-characters">
		<xsl:output-character character="&#127;" string=" "/>
		<xsl:output-character character="&#128;" string=" "/>
		<xsl:output-character character="&#129;" string=" "/>
		<xsl:output-character character="&#130;" string=" "/>
		<xsl:output-character character="&#131;" string=" "/>
		<xsl:output-character character="&#132;" string=" "/>
		<xsl:output-character character="&#133;" string=" "/>
		<xsl:output-character character="&#134;" string=" "/>
		<xsl:output-character character="&#135;" string=" "/>
		<xsl:output-character character="&#136;" string=" "/>
		<xsl:output-character character="&#137;" string=" "/>
		<xsl:output-character character="&#138;" string=" "/>
		<xsl:output-character character="&#139;" string=" "/>
		<xsl:output-character character="&#140;" string=" "/>
		<xsl:output-character character="&#141;" string=" "/>
		<xsl:output-character character="&#142;" string=" "/>
		<xsl:output-character character="&#143;" string=" "/>
		<xsl:output-character character="&#144;" string=" "/>
		<xsl:output-character character="&#145;" string=" "/>
		<xsl:output-character character="&#146;" string=" "/>
		<xsl:output-character character="&#147;" string=" "/>
		<xsl:output-character character="&#148;" string=" "/>
		<xsl:output-character character="&#149;" string=" "/>
		<xsl:output-character character="&#150;" string=" "/>
		<xsl:output-character character="&#151;" string=" "/>
		<xsl:output-character character="&#152;" string=" "/>
		<xsl:output-character character="&#153;" string=" "/>
		<xsl:output-character character="&#154;" string=" "/>
		<xsl:output-character character="&#155;" string=" "/>
		<xsl:output-character character="&#156;" string=" "/>
		<xsl:output-character character="&#157;" string=" "/>
		<xsl:output-character character="&#158;" string=" "/>
		<xsl:output-character character="&#159;" string=" "/>
	</xsl:character-map>
	
    <xsl:template match="/">

        <html>    
            <head>
                <title>
                    <xsl:apply-templates select="//titleproper" mode="pagetitle" />
                </title>
                <link rel="stylesheet" type="text/css" name="RMCstyle" href="../styles/rmc.css" />
                <link rel="stylesheet" href="../styles/rmcprint.css" type="text/css" media="print" />
                <script type="text/javascript" src="/scripts/ga.js" />
            </head>
            <body>
                <div id="sidebar">
                    <div id="titleproper">
                        <xsl:apply-templates select="//titleproper" />
                    </div>
                    <h2>
                        Contents
                    </h2>
                    <ul>
                    	<!-- this is a bit of a mess now with aspace EADs, many of these TOC entries
                    	     don't have a head element to make this work -->
                    	<li><a href="#a1">DESCRIPTIVE SUMMARY</a></li>
                        <xsl:apply-templates select="//head" mode="toc" />
                    	<xsl:if test="//prefercite">
	                    	<li><a href="#info_for_users">INFORMATION FOR USERS</a></li>
                    	</xsl:if>
                    	<li><a href="#subjects">SUBJECTS</a></li>
                    	<li><a href="#a10">CONTAINER LIST</a></li>
                    </ul>
                	
                    <!-- <xsl:apply-templates select="//archdesc/arrangement[last()]" mode="toc" /> -->
                	<div id="serieslist">
						<div class="h4" align="center"> Series List </div>
                		<xsl:call-template name="generate_series_list" />
                	</div>
                	
                    <p id="sidebarlinks">
                        CTRL+F to search this guide | 
                        <a href="javascript:window.print()">
                            Print this guide
                        </a>
                    </p>
                    <xsl:variable name="publisher" select="//publisher" />
                    <xsl:choose>
                        <xsl:when test="contains($publisher, 'Division')">
                            <p id="sidebarlinks">
                                <a href="https://rare.library.cornell.edu/about/contact">
                                    Contact Rare &amp; Manuscript Collections
                                </a>
                            </p>
                        </xsl:when>
                        <xsl:otherwise>
                            <p id="sidebarlinks">
                                <a href="https://catherwood.library.cornell.edu/kheel">
                                    Contact the Kheel Center
                                </a>
                            </p>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
                
                <div id="mainbody">
                    <xsl:apply-templates select="ead" /> 
                </div>
            </body>
        
        </html>

    </xsl:template>
    
    <!-- the root and some immediate children -->
    
    <xsl:template match="ead">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="eadheader">
        <xsl:apply-templates select="filedesc" />
    </xsl:template>
    
    <xsl:template match="filedesc">
        <xsl:apply-templates select="titlestmt | publicationstmt" mode="heading" />
    </xsl:template>
    
    <xsl:template match="publicationstmt" mode="heading">
        <xsl:apply-templates select="./publisher" mode="heading" />
    </xsl:template>
    
    <xsl:template match="titlestmt" mode="heading">
        <xsl:apply-templates select="titleproper" mode="heading" />
    </xsl:template>
    
    <!-- "titleproper" is the main title of the finding aid and is used in the page title, the sidebar heading,
         the main page heading, and then even in the "descriptive summary" -->
    
    <xsl:template match="titleproper" mode="heading">
        <h1>
            <xsl:apply-templates select="." />
        </h1>
    </xsl:template>
    
    <xsl:template match="titleproper">
        <xsl:call-template name="remove-collection-number-from-title">
            <xsl:with-param name="titleproper" select="." />
            <xsl:with-param name="num" select="./num" />
        </xsl:call-template>, <xsl:apply-templates select="/ead/archdesc/did/unitdate" mode="toc" /> <br />
        <xsl:apply-templates select="./num" />
    </xsl:template>
    
    <xsl:template match="titleproper" mode="pagetitle">
        Guide to the <xsl:call-template name="remove-collection-number-from-title">
            <xsl:with-param name="titleproper" select="." />
            <xsl:with-param name="num" select="./num" />
        </xsl:call-template>, <xsl:value-of select="/ead/archdesc/did/unitdate" />
    </xsl:template>
    
    <!-- this is needed because the collection number is a child of the title -->   
    <xsl:template name="remove-collection-number-from-title">
        <xsl:param name="titleproper" />
        <xsl:param name="num" />
        <xsl:variable name="titlelen" select="string-length($titleproper) - string-length($num)" />
        <xsl:value-of select="normalize-space(substring($titleproper, 1, $titlelen))" />
    </xsl:template>
    
    <!-- "num" is the collection number -->
    
    <xsl:template match="num" mode="heading">
        <h2>
            <span id="collnum">
                Collection Number: <xsl:value-of select="." />
            </span>
        </h2>
    </xsl:template>
    
    <xsl:template match="num">
        <span id="collnum">
            Collection Number: <xsl:value-of select="." />
        </span>
    </xsl:template> 
    
    <!-- The CUL text doesn't seem to appear anywhere in the aspace EAD, so it's appended statically for now -->
    
    <xsl:template match="publisher" mode="heading">
        <h4>
            <xsl:apply-templates /> <br />
            Cornell University Library
        </h4>
    </xsl:template>
    
    <!-- "DID" child nodes appear to have had "label" attributes in the past, but not with aspace, 
         so they'll need to be handled a bit more explicitly :( -->
    
    <xsl:template match="ead/archdesc/did">
        <hr />
        <a name="a1">
            <div class="H4">DESCRIPTIVE SUMMARY</div>
        </a>
        <p />
    	<xsl:apply-templates select="unittitle" />
    	<xsl:apply-templates select="repository" />
    	<xsl:apply-templates select="unitid" />
    	<xsl:apply-templates select="abstract" />  		
    	<div class="heading">Creator:</div>
    	<xsl:for-each select="origination">
    		<div class="item"><xsl:apply-templates /></div>
    	</xsl:for-each>
    	<div class="heading">Quanitities:</div>
    	<xsl:for-each select="physdesc/extent[@altrender='materialtype spaceoccupied']">
    		<div class="item"><xsl:apply-templates /></div>
    	</xsl:for-each>   	
 		<xsl:apply-templates select="langmaterial"/>
    </xsl:template>
 
 	<!-- we don't need this stuff in the DID section showing up -->
 	<xsl:template match="ead/archdesc/did/container" priority="2"/>
	
    <!-- I've seen two "langmaterial" nodes; the one with an "id" seems to match the desired output
         so I'm choosing that one -->
    <xsl:template match="ead/archdesc/did/langmaterial[@id]" priority="2">
        <div class="heading">Language:</div>
        <div class="item"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="ead/archdesc/did/langmaterial"/>
    
    <xsl:template match="ead/archdesc/did/repository">
        <div class="heading">Repository:</div>
        <div class="item"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="ead/archdesc/did/unittitle">
        <div class="heading">Title:</div>
        <div class="item"><xsl:apply-templates/>, <xsl:value-of select="../unitdate"/></div>
    </xsl:template>  
    
    <!-- included in title, don't show again -->
    <xsl:template match="ead/archdesc/did/unitdate" priority="2"/>
   
    
    <xsl:template match="ead/archdesc/did/unitid">
        <xsl:choose>
            <xsl:when test='@type="bibid"'>
                <!-- BIB ID wasn't being shown before -->
            </xsl:when>
            <xsl:otherwise>
		        <div class="heading">Collection Number:</div>
		        <div class="item"><xsl:apply-templates/></div>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template> 
	
	<xsl:template match="ead/archdesc/unitid[@type='bibid']" />
    
    <!-- TODO: what is the "correct" extent(s) to use for this? 
    <xsl:template match="ead/archdesc/did/physdesc/extent[@altrender='carrier']" priority="2">
        <div class="heading">Quantity:</div>
        <div class="item"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="ead/archdesc/did/physdesc/extent"/> 
    
    <xsl:template match="ead/archdesc/did/physdesc[@id]">
        <div class="heading">Forms of Material:</div>
        <div class="item"><xsl:apply-templates/></div>
    </xsl:template> -->

    <xsl:template match="ead/archdesc/did/abstract">
        <div class="heading">Abstract:</div>
        <div class="item"><xsl:apply-templates/></div>
    </xsl:template>
    
    <!-- some of this stuff shouldn't be displayed but general notes should -->
    <xsl:template match="ead/archdesc/odd">
    	<xsl:if test="./head = 'NOTES'">
	    	<xsl:apply-templates select="./head" />
	    	<xsl:apply-templates select="./p" />
	    	<hr />
    	</xsl:if>
    </xsl:template>
    
    <!-- I'm not sure where the "information for users" heading came from before, but it no longer
    	 exists in the aspace export; there does however seem to be one prefercite element
    	 in each to stand in for it -->
	<xsl:template match="prefercite">
		<hr/><a name="info_for_users">
		<div class="H4">INFORMATION FOR USERS</div> <p />
		</a>
			
		<xsl:apply-templates />
		
	</xsl:template> 
	
	<xsl:template match="accessrestrict">
		<xsl:if test="count(preceding-sibling::accessrestrict) = 0">
			<xsl:apply-templates select="head" />
		</xsl:if>
		<xsl:apply-templates select="p" />
	</xsl:template>
	
	<!-- this is a special case hack to stop the sidebar series list from stealing the href -->
	<xsl:template match="head" mode="sidebar_series">
		<div class="H4">
			<xsl:apply-templates /> 
		</div>
		<p />
	</xsl:template>
	
	<xsl:template name="generate_series_list">
		<xsl:for-each select="/ead/archdesc/dsc/c01[@level='series']">
			<xsl:variable name="series_level" select="concat('s', string(count(preceding-sibling::c01[@level = 'series']) + 1))" />
			<p> 
				<a href="#{$series_level}">
					<xsl:apply-templates select="./did/unittitle" /> 
				</a>
				<xsl:for-each select="./c02[@level='subseries']">
					<xsl:variable name="subseries_level" select="concat('ss', string(count(preceding-sibling::c02[@level = 'subseries']) + 1))" />
					<p style="margin-left: +1em;">
						<a href="#{concat($series_level, $subseries_level)}">
							<xsl:apply-templates select="./did/unittitle" />
						</a>
						<xsl:for-each select="./c03[@level='subseries']">
							<xsl:variable name="subsubseries_level" select="concat('sss', string(count(preceding-sibling::c03[@level = 'subseries']) + 1))"/>
							<p style="margin-left: +2em;">
								<a href="#{concat($series_level, $subseries_level, $subsubseries_level)}">
									<xsl:apply-templates select="./did/unittitle" />
								</a>
							</p>
						</xsl:for-each>
					</p>
				</xsl:for-each>
			</p>
		</xsl:for-each>
	</xsl:template>
	
	<!-- NOTE: stuff from here copied/pasted straight out of old sytlesheet and then possibly modified -->
	
	<!-- HEAD -->
	
	<!-- unfortunately we need some special cases for heads to clean things up and match the current EADs, 
		 maybe not the right solution -->
	<xsl:template match="head">
		<xsl:choose>
			<xsl:when test="lower-case(.) = 'scope and contents'
				or lower-case(.) = 'processing information'
				or lower-case(.) = 'arrangement'
				or lower-case(.) = 'existence and location of copies'
				or lower-case(.) = 'conditions governing access'
				or lower-case(.) = 'general'" >
			</xsl:when>
			<xsl:otherwise>
				<div class="H4">
					<a name="{generate-id()}"><xsl:apply-templates /></a>  <!-- +++++ generate links for headings - kaw5 -->
				</div>
				<p />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- this is probably the more correct way to handle the stuff we don't want in the TOC sidebar -->
	<xsl:template match="separatedmaterial/list/head" mode="toc"/>
	<xsl:template match="head" mode="toc"> 
		<xsl:choose>
			<xsl:when test="lower-case(.) = 'general' 
				or lower-case(.) = 'cite as:' 
				or lower-case(.) = 'scope and contents' 
				or lower-case(.) = 'processing information' 
				or lower-case(.) = 'arrangement' 
				or lower-case(.) = 'existence and location of copies' 
				or lower-case(.) = 'conditions governing access'
				or lower-case(.) = 'general note' 
				or lower-case(.) = 'preferred citation' 
				or lower-case(.) = 'biographical / historical'
				or lower-case(.) = 'scope and content' 
				or lower-case(.) = 'conditions governing use' 
				or lower-case(.) = 'restrictions on use:'
				or lower-case(.) = 'access restrictions:'
				" >
				<!-- this stuff doesn't seem to show up in current EADs so we probably don't want a link -->
			</xsl:when>
			<xsl:otherwise>
				<li><a href="#{generate-id()}"><xsl:apply-templates /></a></li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++ -->
	
	
    <xsl:template match="archdesc/bioghist">
        <hr />
        <a name="a2">
            <xsl:apply-templates />
        </a>
    </xsl:template>
  
  
	<!--This template rule formats a chronlist element.-->

	<xsl:template match="chronlist">
		<table width="100%" style="margin-left:25pt">
			<tr>
				<td width="5%"> </td>
				<td width="15%"> </td>
				<td width="80%"> </td>
			</tr>
			<xsl:apply-templates />
		</table>
	</xsl:template>

	<xsl:template match="chronlist/head">
		<tr>
			<td colspan="3">
				<h4>
					<xsl:apply-templates />
				</h4>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="chronlist/listhead">
		<tr>
			<td> </td>
			<td>
				<b>
					<xsl:apply-templates select="head01" />
				</b>
			</td>
			<td>
				<b>
					<xsl:apply-templates select="head02" />
				</b>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="chronitem">
		<!--Determine if there are event groups.-->

		<xsl:choose>
			<xsl:when test="eventgrp">
				<!--Put the date and first event on the first line.-->

				<tr>
					<td> </td>
					<td valign="top">
						<xsl:apply-templates select="date" />
					</td>
					<td valign="top">
						<xsl:apply-templates select="eventgrp/event[position() = 1]" />
					</td>
				</tr>
				<!--Put each successive event on another line.-->

				<xsl:for-each select="eventgrp/event[not(position() = 1)]">
					<tr>
						<td> </td>
						<td> </td>
						<td valign="top">
							<xsl:apply-templates select="." />
						</td>
					</tr>
				</xsl:for-each>
			</xsl:when>
			<!--Put the date and event on a single line.-->

			<xsl:otherwise>
				<tr>
					<td> </td>
					<td valign="top">
						<xsl:apply-templates select="date" />
					</td>
					<td valign="top">
						<xsl:apply-templates select="event" />
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- SCOPECONTENT/COLLECTION DESCRIPTION -->

	<xsl:template match="archdesc/scopecontent">
		<hr />
		<a name="a3">
			<xsl:apply-templates />
		</a>



		<!-- CUSTODHIST, ACQIINFO / HISTORY OF OWNERSHIP, PROVENANCE  (appear after SCOPECONTENT) -->

		<xsl:choose>
			<xsl:when test="//custodhist">
				<hr />
				<a name="a4">
					<div class="H4">
						<xsl:value-of select="//custodhist/head" />
					</div>
				</a>
				<p />
				<xsl:apply-templates select="//custodhist/p" />

			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="//acqinfo">
				<hr />
				<a name="a5">
					<div class="H4">
						<xsl:value-of select="//acqinfo/head" />
					</div>
				</a>
				<p />
				<xsl:apply-templates select="//acqinfo/p" />

			</xsl:when>
		</xsl:choose>
	</xsl:template>


	<!-- CONTROLACCESS/SUBJECTS -->
	
	<!-- override the old stuff that isn't working -->
	<xsl:template match="archdesc/controlaccess" priority="2">
		<div class="H4"><hr/>
			<a name="subjects">SUBJECTS</a>
		</div> <p/>
		<xsl:if test="corpname | persname | famname">
			<div class="heading">Names:</div>
		</xsl:if>
		<xsl:for-each select="corpname | persname | famname">
			<div class="item"><xsl:value-of select="."/></div>
		</xsl:for-each>
		<xsl:if test="geogname">
			<div class="heading">Places:</div>
		</xsl:if>
		<xsl:for-each select="geogname">
			<div class="item"><xsl:value-of select="."/></div>
		</xsl:for-each>
		<xsl:if test="subject">
			<div class="heading">Subjects:</div>
		</xsl:if>
		<xsl:for-each select="subject">
			<div class="item"><xsl:value-of select="."/></div>
		</xsl:for-each>
		<xsl:if test="genreform">
			<div class="heading">Form and Genre Terms:</div>
		</xsl:if>
		<xsl:for-each select="genreform">
			<div class="item"><xsl:value-of select="."/></div>
		</xsl:for-each>
	</xsl:template>
	
	<!--
	<xsl:template match="controlaccess">   
		<hr />
		<a name="a6">
			<xsl:apply-templates />
		</a>

	</xsl:template>

	<xsl:template match="controlaccess/controlaccess">
		<div class="heading">
			<xsl:value-of select="head" />
		</div>
		<xsl:apply-templates select="subject | persname | corpname | geogname | genreform | occupation | title" />
		<p />
	</xsl:template>

	<xsl:template match="controlaccess/subject | controlaccess/persname | controlaccess/corpname | controlaccess/geogname | controlaccess/genreform | controlaccess/occupation">
		<div class="item">
			<xsl:value-of select="." />
		</div>
	</xsl:template>

	<xsl:template match="controlaccess/title">
		<div class="item">
			<i>
				<xsl:value-of select="." />
			</i>
		</div>
	</xsl:template>
-->

	<!-- ADMININFO/INFORMATION FOR USERS -->
	<!-- NOTE: "descgrp" doesn't show up in aspace export -->
	<xsl:template match="descgrp">
		<xsl:choose>
			<xsl:when test="accessrestrict | userestrict | altformavail | processinfo | prefercite | otherfindaid">
				<hr />
				<a name="a7">
					<xsl:apply-templates />
				</a>

			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="descgrp/custodhist | descgrp/acqinfo" />

	<xsl:template match="descgrp/accessrestrict | descgrp/userestrict | descgrp/altformavail | descgrp/processinfo | descgrp/prefercite | descgrp/otherfindaid">
		<div class="heading">
			<xsl:choose>
				<xsl:when test="@id">
					<a>
						<xsl:attribute name="name">#<xsl:value-of select="@id" /></xsl:attribute>
						<xsl:value-of select="head" />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="head" />
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<div class="item">
			<xsl:apply-templates select="p" />
		</div>

	</xsl:template>


	<!-- RELATED MATERIAL -->

	<xsl:template match="archdesc/relatedmaterial | archdesc/*/relatedmaterial">
		<hr />
		<a name="a8">
			<xsl:apply-templates />
		</a>

	</xsl:template>

	<!-- NOTES -->

<!--	<xsl:template match="archdesc/odd | archdesc/*/odd">
		<hr />
		<a name="a8">
			<xsl:apply-templates />
		</a>

	</xsl:template>
-->
	<!--	<xsl:template match="archdesc/relatedmaterial | archdesc/*/relatedmaterial">
		<xsl:choose>
			<xsl:when test="@id">
				<hr></hr>
				<a>
					<xsl:attribute name="name">#<xsl:value-of select="@id"/></xsl:attribute><xsl:apply-templates/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>-->


	<!-- relatedmaterial lists handled below under add at end -->
<!--<xsl:variable name="colnum" select="//unitid"/> put collection number in variable - kaw5 -->
	<!-- COLLECTION ARRANGEMENT/SERIES LIST -->
	
	<xsl:template match="archdesc/arrangement" mode="toc"> 
		<!-- ++++++++++++++++++++++++++  added series list and links to sidebar - kaw5 -->
		<!-- had to make this even more hacky to get it to work (see "ref" template later on) -->
		<div id="serieslist">
			<xsl:choose>
				<xsl:when test=".//ref">
					<xsl:apply-templates select="head" mode="sidebar_series"/>
					<xsl:apply-templates select=".//ref"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
		</div>
		<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-->
	</xsl:template>

	<xsl:template match="archdesc/arrangement/list | archdesc/arrangement/list/defitem/item | defitem/item/list | item/list/defitem/item | list/item/list">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="archdesc/arrangement/list/defitem">
		<xsl:choose>
			<xsl:when test="item/list/defitem">
				<tr>
					<td valign="top">
						<xsl:apply-templates select="label" />
					</td>
				</tr>
				<tr>
					<td>
						<xsl:apply-templates select="item" />
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td valign="top">
						<xsl:apply-templates select="label" />
					</td>
					<td align="RIGHT">
						<xsl:apply-templates select="item" />
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="defitem/item/list/defitem">
		<xsl:choose>
			<xsl:when test="item/list/defitem">
				<tr>
					<td>
						<div>
							<xsl:attribute name="STYLE"> margin-left: 2em; </xsl:attribute>
							<xsl:apply-templates select="label" />
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:apply-templates select="item" />
					</td>
				</tr>
			</xsl:when>
			<xsl:when test="item/list/item">
				<xsl:apply-templates />
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td>
						<div class="hlabel">
							<xsl:attribute name="STYLE"> margin-left: 2em; </xsl:attribute>
							<xsl:apply-templates select="label" />
						</div>
					</td>
					<td nowrap="1" align="RIGHT">
						<xsl:apply-templates select="item" />
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="item/list/item">
		<tr>
			<td>
				<div>
					<xsl:attribute name="STYLE"> margin-left: 2em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="item/list/defitem">
		<tr>
			<td>
				<div class="hlabel">
					<xsl:attribute name="STYLE"> margin-left: 2em; </xsl:attribute>
					<xsl:apply-templates select="label" />
				</div>
			</td>
			<td nowrap="1" align="RIGHT">
				<xsl:apply-templates select="item" />
			</td>
		</tr>
	</xsl:template>


	<!-- DSC/CONTAINER LIST -->

	<xsl:template match="dsc">
		<hr />
		<a name="a10">
			<xsl:apply-templates select="head" /> <!-- this head doesn't come out of aspace -->
			<div class="H4">CONTAINER LIST</div>
		</a>
		<xsl:choose>
			<xsl:when test="//did/unitdate">
				<table cellspacing="10">
					<tr><!-- switched date and container columns - kaw5 -->
						<td align="center" colspan="2" width="25%"><!-- added width - kaw5 -->
							<div class="heading">Container</div>
						</td>
						<td width="60%"><!-- added width - kaw5 -->
							<div class="heading">Description</div>
						</td>
						
						<td align="left" width="15%"><!-- added width - kaw5 -->
							<div class="heading">Date</div>
						</td>
					</tr>
					<xsl:apply-templates select="c01" />
				</table>
			</xsl:when>
			<xsl:otherwise>
				<table cellspacing="5">
					<tr><!-- switched description and container columns - kaw5 -->
						<td nowrap="1" align="center" colspan="2" width="30%"><!-- added width - kaw5 -->
							<div class="heading">Container</div>
						</td>
						<td width="70%"><!-- added width - kaw5 -->
							<div class="heading">Description</div>
						</td>
						
					</tr>
					<xsl:apply-templates select="c01" />
				</table>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="c01 | c02 | c03 | c04 | c05 | c06">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- surprisingly simple way to toss in an anchor row for the series list links to href to -
		 unfortunately this sort of approach only goes so far (what if one has a hyphen in the middle, etc)	
	<xsl:template name="ref_to_id_row">
		<xsl:param name="text"></xsl:param>
		<xsl:for-each select="/ead/archdesc/arrangement//ref">
			<xsl:variable name="stripped_text">
				<xsl:choose>
					<xsl:when test="starts-with(normalize-space(lower-case($text)), 'series')">
						<xsl:value-of select="normalize-space(substring-after($text, '.'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="normalize-space($text)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:if test="contains(., $stripped_text)">
				<xsl:element name="tr">
					<xsl:attribute name="id" select="@target" />
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	-->
	
	<xsl:template match="c01/did | c02/did | c03/did | c04/did | c05/did | c06/did">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
	
		<!-- first (inadequate) attempt at getting series links working
		<xsl:if test="../@level='series' or ../@level='subseries' or ../@level='subsubseries'">
			<xsl:call-template name="ref_to_id_row">
				<xsl:with-param name="text" select="unittitle" />
			</xsl:call-template>
		</xsl:if>
		-->
		
		<!--<tr>-->
			<xsl:choose>

				<xsl:when test="../../c01[@level = 'series']"><!-- switched date and container(Box, Mapcase, Folder, Volume) columns - kaw5 -->
					<xsl:element name="tr">
						<!-- construct id for series links:
							 this looks complicated, but it's apparently not possible to just do something like ../position() 
						-->
						<xsl:attribute name="id" select="concat('s', string(count(../preceding-sibling::*[@level = 'series']) + 1))" />
						
						<td nowrap="1" align="CENTER" valign="center">
							<xsl:choose>
								<xsl:when test="container[@type = 'box']"> Box <xsl:apply-templates select="container[@type = 'box']" />
								</xsl:when>
								<xsl:when test="container[@type = 'mapcase-folder']"> Mapcase Folder <!-- changed map-case to mapcase-folder at all levels - msf252 -->
										<xsl:apply-templates select="container[@type = 'mapcase-folder']" />
								</xsl:when>
								<xsl:when test="container[@type = 'mapcase folder']"> Mapcase Folder 
									<xsl:apply-templates select="container[@type = 'mapcase folder']" />
								</xsl:when>
							</xsl:choose>
						</td>
						<td nowrap="1" align="CENTER" valign="center">
							<xsl:choose>
								<xsl:when test="container[@type = 'folder']"> Folder
										<xsl:apply-templates select="container[@type = 'folder']" />
								</xsl:when>
								<xsl:when test="unitid">
									<xsl:value-of select="unitid/@label" />
									<xsl:apply-templates select="unitid" />
								</xsl:when>
								<xsl:when test="container[@type = 'volume']"> Volume
										<xsl:apply-templates select="container[@type = 'volume']" />
								</xsl:when>
							</xsl:choose>
						</td>
									
						<td>
							<div class="serieslabel">
								<xsl:apply-templates select="unittitle" />
							</div>
						</td>
									
						<xsl:if test="//did/unitdate">
							<td>
								<xsl:apply-templates select="unitdate" />
							</td>
						</xsl:if>
						
						<xsl:apply-templates select="abstract" />
					</xsl:element>
					
				</xsl:when>

				<xsl:when test="../../c02[@level = 'subseries']"><!-- switched date and container(Box, Mapcase, Folder, Volume) columns - kaw5 -->
					<!-- construct id for series links -->
					<xsl:element name="tr">
						<xsl:variable name="series_str" select="concat('s', string(count(../../preceding-sibling::*[@level = 'series']) + 1))"/>
						<xsl:attribute name="id" select="concat($series_str, 'ss', string(count(../preceding-sibling::*[@level = 'subseries']) + 1))" />
					
						<td nowrap="1" align="CENTER" valign="TOP">
							<xsl:choose>
								<xsl:when test="container[@type = 'box']"> Box <xsl:apply-templates select="container[@type = 'box']" />
								</xsl:when>
								<xsl:when test="container[@type = 'mapcase-folder']"> Mapcase Folder 
									<xsl:apply-templates select="container[@type = 'mapcase-folder']" />
								</xsl:when>
								<xsl:when test="container[@type = 'mapcase folder']"> Mapcase Folder 
									<xsl:apply-templates select="container[@type = 'mapcase folder']" />
								</xsl:when>
							</xsl:choose>
						</td>
						<td nowrap="1" align="CENTER" valign="TOP">
							<xsl:choose>
								<xsl:when test="container[@type = 'folder']"> Folder
										<xsl:apply-templates select="container[@type = 'folder']" />
								</xsl:when>
								<xsl:when test="unitid">
									<xsl:value-of select="unitid/@label" />
									<xsl:apply-templates select="unitid" />
								</xsl:when>
								<xsl:when test="container[@type = 'volume']"> Volume
										<xsl:apply-templates select="container[@type = 'volume']" />
								</xsl:when>
							</xsl:choose>
						</td>
						
						
						<td>
							<div class="subserieslabel">
								<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; text-indent: -2em;</xsl:attribute>
								<xsl:apply-templates select="unittitle" />
							</div>
						</td>
						
						
						<xsl:if test="//did/unitdate">
							<td>
								<xsl:apply-templates select="unitdate" />
							</td>
						</xsl:if>		
						
						<xsl:apply-templates select="abstract" />
					</xsl:element>
				</xsl:when>

<!-- why no subsubseries? because it doesn't actually seem to exist in the container list -->
				<xsl:otherwise><!-- switched date and container(Box, Mapcase, Folder, Volume) columns - kaw5 -->
					<!-- since there's no subsubseries attribute and no distinction for c03 from lower levels, we need a special 
						 conditional anchor row -->
					<xsl:if test="../../c03[@level='subseries']">
						<xsl:variable name="s_str" select="concat('s', count(../../../preceding-sibling::c01[@level='series']) + 1)"/>
						<xsl:variable name="ss_str" select="concat('ss', count(../../preceding-sibling::c02[@level='subseries']) + 1)"/>
						<xsl:variable name="sss_str" select="concat('sss', count(../preceding-sibling::c03[@level='subseries']) + 1)"/>
						<tr id="{concat($s_str, $ss_str, $sss_str)}" />
					</xsl:if>
					<tr>
					<td nowrap="1" align="CENTER" valign="TOP">
						<xsl:choose>
							<xsl:when test="container[@type = 'box']"> Box <xsl:apply-templates select="container[@type = 'box']" />
							</xsl:when>
							<xsl:when test="container[@type = 'mapcase-folder']"> Mapcase Folder 
								<xsl:apply-templates select="container[@type = 'mapcase-folder']" />
							</xsl:when>
							<xsl:when test="container[@type = 'mapcase folder']"> Mapcase Folder 
								<xsl:apply-templates select="container[@type = 'mapcase folder']" />
							</xsl:when>
							<xsl:when test="container[@type = 'reel']"> Reel <xsl:apply-templates select="container[@type = 'reel']" />
							</xsl:when>
							<xsl:when test="container[@type = 'file-drawer']"> File Drawer
									<xsl:apply-templates select="container[@type = 'file-drawer']" />
							</xsl:when>
							<xsl:when test="container[@type = 'file cabinet']"> File Cabinet
								<xsl:apply-templates select="container[@type = 'file cabinet']" />
							</xsl:when>
							<xsl:when test="container[@type = 'cabinet']"> Cabinet
									<xsl:apply-templates select="container[@type = 'cabinet']" />
							</xsl:when>
							<xsl:when test="container[@type = 'manuscript box']"> 
								<xsl:variable name = "str" select = "container[@type = 'manuscript box']"/>
								<xsl:variable name = "boxnum" select = "substring-before($str, '-')" />
								Manuscript Box <xsl:value-of select = "$boxnum" />
							</xsl:when>
							<xsl:when test="container[@type = 'manuscript-box']"> 
								<xsl:variable name = "str" select = "container[@type = 'manuscript-box']"/>
								<xsl:variable name = "boxnum" select = "substring-before($str, '-')" />
								Manuscript Box <xsl:value-of select = "$boxnum" />
							</xsl:when>
							<xsl:when test="container[@type = 'tube']">
								Tube <xsl:apply-templates select="container[@type = 'tube']" />
							</xsl:when>
							<xsl:when test="container[@type = 'microfilm reel']">
								Microfilm Reel <xsl:apply-templates select="container[@type = 'microfilm reel']" />
							</xsl:when>
							<xsl:when test="container[@type = 'microfilm box']">
								Microfilm Box <xsl:apply-templates select="container[@type = 'microfilm box']" />
							</xsl:when>							
							<xsl:when test="container[@type = 'portfolio']">
								Portfolio <xsl:apply-templates select="container[@type = 'portfolio']" />
							</xsl:when>
							<xsl:when test="container[@type = 'audiocassette']">
								Audiocassette <xsl:apply-templates select="container[@type = 'audiocassette']" />
							</xsl:when>
							<xsl:when test="container[@type = 'video']">
								Video <xsl:apply-templates select="container[@type = 'video']" />
							</xsl:when>
							<xsl:when test="container[@type = 'unspecified']">
								(unspecified) <xsl:apply-templates select="container[@type = 'unspecified']" />
							</xsl:when>
							<xsl:when test="container[@type = 'item']">
								Item <xsl:apply-templates select="container[@type = 'item']" />
							</xsl:when>
							<xsl:when test="container[@type = 'transcript']">
								Transcript <xsl:apply-templates select="container[@type = 'transcript']" />
							</xsl:when>
							<xsl:when test="container[@type = 'transcript box']">
								Transcript Box <xsl:apply-templates select="container[@type = 'transcript box']" />
							</xsl:when>
							<xsl:when test="container[@type = 'huntington box']">
								Huntington Box <xsl:apply-templates select="container[@type = 'huntington box']" />
							</xsl:when>
							<xsl:when test="container[@type = 'tr']">
								Tape Recording <xsl:apply-templates select="container[@type = 'tr']" />
							</xsl:when>
							<xsl:when test="container[@type = 'mu']">
								MU <xsl:apply-templates select="container[@type = 'mu']" />
							</xsl:when>
							<xsl:when test="container[@type = 'cd']">
								CD <xsl:apply-templates select="container[@type = 'cd']" />
							</xsl:when>
							<xsl:when test="container[@type = 'dvd']">
								DVD <xsl:apply-templates select="container[@type = 'dvd']" />
							</xsl:when>
							<xsl:when test="container[@type = 'mapcase item']">
								Mapcase Item <xsl:apply-templates select="container[@type = 'mapcase item']" />
							</xsl:when>
							<xsl:when test="container[@type = 'v']">
								V <xsl:apply-templates select="container[@type = 'v']" />
							</xsl:when>
							<xsl:when test="container[@type = 'f']">
								F <xsl:apply-templates select="container[@type = 'f']" />
							</xsl:when>
							<xsl:when test="container[@type = 'sr']">
								Sound recording <xsl:apply-templates select="container[@type = 'sr']" />
							</xsl:when>
							<xsl:when test="container[@type = 'dvc']">
								DVC <xsl:apply-templates select="container[@type = 'dvc']" />
							</xsl:when>
							<xsl:when test="container[@type = 'museum item box']"> 
								Museum Item Box	<xsl:apply-templates select="container[@type = 'museum item box']" />
							</xsl:when>
							<xsl:when test="container[@type = 'cassette box']">
								Cassette Box <xsl:apply-templates select="container[@type = 'cassette box']" />
							</xsl:when>
							<xsl:when test="container[@type = 'goldsen box']">
								Goldsen Box <xsl:apply-templates select="container[@type = 'goldsen box']" />
							</xsl:when>
							<xsl:when test="container[@type = 'hard drive']">
								Hard Drive <xsl:apply-templates select="container[@type = 'hard drive']" />
							</xsl:when>							
						</xsl:choose>
					</td>
					<td nowrap="1" align="CENTER" valign="TOP">
						<xsl:choose>
							<xsl:when test="container[@type = 'folder']"> Folder
									<xsl:apply-templates select="container[@type = 'folder']" />
							</xsl:when>
							<xsl:when test="unitid">
								<xsl:value-of select="unitid/@label" />
								<xsl:apply-templates select="unitid" />
							</xsl:when>
							<xsl:when test="container[@type = 'volume']"> Volume
									<xsl:apply-templates select="container[@type = 'volume']" />
							</xsl:when>
							<xsl:when test="container[@type = 'frame']"> Frame <xsl:apply-templates select="container[@type = 'frame']" />
							</xsl:when>
							<xsl:when test="container[@type = 'drawer']"> Drawer
									<xsl:apply-templates select="container[@type = 'drawer']" />
							</xsl:when>
							<xsl:when test="container[@type = 'shelf']"> Shelf <xsl:apply-templates select="container[@type = 'shelf']" />
							</xsl:when>
							<xsl:when test="container[@type = 'page']"> Page <xsl:apply-templates select="container[@type = 'page']" />
							</xsl:when>
						</xsl:choose>
					</td>
									
					<td>
						<div>
							<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; text-indent: -2em;</xsl:attribute>
							<xsl:apply-templates select="unittitle" />
							<xsl:if test="unitid and container[@type = 'folder']">
								<br />
								<xsl:value-of select="unitid/@label" />
								<xsl:apply-templates select="unitid" />
							</xsl:if>
						</div>
					</td>
					
					<xsl:if test="//did/unitdate">
						<td nowrap="1" align="LEFT" valign="TOP">
							<xsl:value-of select="unitdate" separator=", " />
						</td>
					</xsl:if>
										
					<xsl:apply-templates select="abstract" />
					<xsl:apply-templates select="origination" />
					<xsl:apply-templates select="physdesc" />
					<xsl:apply-templates select="physloc" />
						
					</tr>
				</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- I don't understand why this was done in this fashion - it doesn't work right and seems to cause
		other nodes under scopecontent to end up being matched twice, at least with XSL 2.0
	<xsl:template match="c01/scopecontent/p | c02/scopecontent/p | c03/scopecontent/p | c04/scopecontent/p | c05/scopecontent/p | c06/scopecontent/p | c07/scopecontent/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr>
			
			<td />
			<td />
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template> -->

	<xsl:template match="c01/scopecontent | c02/scopecontent | c03/scopecontent | c04/scopecontent | c05/scopecontent | c06/scopecontent | c07/scopecontent">
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr>
			<td /> <td />
			<td>
				<div class="heading"><xsl:value-of select="head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<!-- this seems to have been done to fill in the row in case there is a date column -->
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>
	
<!-- THESE CONTROL ACCESS TAGS WERE ADDED SO THAT TERMS COULD BE ENTERED AND VIEWED BELOW THE COLLECTION LEVEL, OTHERWISE THEY WERE NOT SHOWING UP, OR BEING ADDED TO THE TOP OF THE GUIDE AND NOT WITH THEIR CORRESPONDING FILE -  ERIN AND MARCIE, FEB 2017 -->

	<xsl:template match="c01/controlaccess/geogname | c02/controlaccess/geogname | c03/controlaccess/geogname | c04/controlaccess/geogname | c05/controlaccess/geogname | c06/controlaccess/geogname | c07/controlaccess/geogname">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>
	<!-- THESE CONTROL ACCESS TAGS WERE ADDED SO THAT TERMS COULD BE ENTERED AND VIEWED BELOW THE COLLECTION LEVEL, OTHERWISE THEY WERE NOT SHOWING UP, OR BEING ADDED TO THE TOP OF THE GUIDE AND NOT WITH THEIR CORRESPONDING FILE -  Marcie 2017-11-08 -->
	
	<xsl:template match="c01/bioghist/p | c02/bioghist/p | c03/bioghist/p | c04/bioghist/p | c05/bioghist/p | c06/bioghist/p | c07/bioghist/p">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>

	</xsl:template>
	<xsl:template match="c01/otherfindaid| c02/otherfindaid | c03/otherfindaid | c04/otherfindaid | c05/otherfindaid | c06/otherfindaid | c07/otherfindaid">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
					
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
		
		
	</xsl:template>
	
	<xsl:template match="c01/controlaccess/persname | c02/controlaccess/persname | c03/controlaccess/persname | c04/controlaccess/persname | c05/controlaccess/persname | c06/controlaccess/persname | c07/controlaccess/persname">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
		
		
	</xsl:template>
	<xsl:template match="c01/controlaccess/corpname | c02/controlaccess/corpname | c03/controlaccess/corpname | c04/controlaccess/corpname | c05/controlaccess/corpname | c06/controlaccess/corpname | c07/controlaccess/corpname">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
		
		
	</xsl:template>
	<xsl:template match="c01/controlaccess/subject | c02/controlaccess/subject  | c03/controlaccess/subject  | c04/controlaccess/subject  | c05/controlaccess/subject  | c06/controlaccess/subject | c07/controlaccess/subject">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
		
		
	</xsl:template>
	<xsl:template match="c01/controlaccess/genreform | c02/controlaccess/genreform  | c03/controlaccess/genreform  | c04/controlaccess/genreform  | c05/controlaccess/genreform  | c06/controlaccess/genreform | c07/controlaccess/genreform">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />	
		
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
				<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
		
		
	</xsl:template>

	<xsl:template match="c01/originalsloc/p | c02/originalsloc/p | c03/originalsloc/p | c04/originalsloc/p | c05/originalsloc/p | c06/originalsloc/p | c07/originalsloc/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />	
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/accessrestrict/p | c02/accessrestrict/p | c03/accessrestrict/p | c04/accessrestrict/p | c05/accessrestrict/p | c06/accessrestrict/p | c07/accessrestrict">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td colspan="3"><!-- kaw5 added colspan="3" -->
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<!-- these were getting picked up somewhere else and generating invalid tags for a table, resulting in the browser just dropping it above -->
	<xsl:template match="c01/userestrict/head | c02/userestrict/head | c03/userestrict/head | c04/userestrict/head | c05/userestrict/head | c06/userestrict/head | c07/userestrict/head" />
		
	<xsl:template match="c01/userestrict/p | c02/userestrict/p | c03/userestrict/p | c04/userestrict/p | c05/userestrict/p | c06/userestrict/p | c07/userestrict/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
				
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/altformavail/p | c02/altformavail/p | c03/altformavail/p | c04/altformavail/p | c05/altformavail/p | c06/altformavail/p | c07/altformavail/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/relatedmaterial/p | c02/relatedmaterial/p | c03/relatedmaterial/p | c04/relatedmaterial/p | c05/relatedmaterial/p | c06/relatedmaterial/p | c07/relatedmaterial/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute> Related Materials:
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/separatedmaterial/p | c02/separatedmaterial/p | c03/separatedmaterial/p | c04/separatedmaterial/p | c05/separatedmaterial/p | c06/separatedmaterial/p | c07/separatedmaterial/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/arrangement/p | c02/arrangement/p | c03/arrangement/p | c04/arrangement/p | c05/arrangement/p | c06/arrangement/p | c07/arrangement/p">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td colspan="3"><!-- kaw5 added colspan="3" 7-10-17 -->
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>
	
	<!-- aspace seems to be exporting rogue prcessinfo elements with another one nested inside them;
		 this should grab that and stop if from messing other things up -->
	<xsl:template match="//processinfo/processinfo" />
	
	<xsl:template match="c01/processinfo/p | c02/processinfo/p | c03/processinfo/p | c04/processinfo/p | c05/processinfo/p | c06/processinfo/p | c07/processinfo/p">
		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div class="heading"><xsl:value-of select="../head"/></div>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>
	<xsl:template match="c01/odd/p | c02/odd/p | c03/odd/p | c04/odd/p | c05/odd/p | c06/odd/p | c07/odd/p">  <!-- ADDED ODD FOR NOTES WITH NO OTHER TAG - MARCIE MAY 2017 -->

		
		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>
		
		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; </xsl:attribute>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="container[@type = 'box'] | container[@type = 'map-case'] | container[@type = 'folder']">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="c01/did/unitid | c02/did/unitid | c03/did/unitid | c04/did/unitid | c05/did/unitid | c06/did/unitid">
		<xsl:choose>
			<xsl:when test="@audience='internal'">
				<!-- don't output these ones -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="did/unitdate">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="c01/did/unittitle | c02/did/unittitle | c03/did/unittitle | c04/did/unittitle | c05/did/unittitle | c06/did/unittitle">
		<xsl:choose>
			<xsl:when test="@id">
				<a>
					<xsl:attribute name="name">
						<xsl:value-of select="@id" />
					</xsl:attribute>
					<xsl:apply-templates />
				</a>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="c01/did/abstract | c02/did/abstract | c03/did/abstract | c04/did/abstract | c05/did/abstract | c06/did/abstract">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; text-indent: -1em;</xsl:attribute>
					<xsl:value-of select="@label" />
					<xsl:text> </xsl:text>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/did/origination | c02/did/origination | c03/did/origination | c04/did/origination | c05/did/origination | c06/did/origination">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; text-indent: -1em;</xsl:attribute>
					<xsl:value-of select="@label" />
					<xsl:text>: </xsl:text>  <!-- ADDED COLON SO IT WOULD APPEAR AFTER THE WORD "CREATOR" - MARCIE AND ERIN FEB. 2017 -->

					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>
	

	<xsl:template match="c01/did/physdesc | c02/did/physdesc | c03/did/physdesc | c04/did/physdesc | c05/did/physdesc | c06/did/physdesc">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td> <!--removed cospan 3 - kaw5-->
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; text-indent: -1em;</xsl:attribute>
					<xsl:value-of select="@label" />
					<xsl:text> </xsl:text>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>

	<xsl:template match="c01/did/physloc | c02/did/physloc | c03/did/physloc | c04/did/physloc | c05/did/physloc | c06/did/physloc">

		<xsl:variable name="indent-value">
			<xsl:call-template name="depth-of-node" />
		</xsl:variable>

		<tr><!-- switched date column to end, added two blank tds at front - kaw5-->
			
			<td />
			<td />
			
			<td>
				<div>
					<xsl:attribute name="STYLE">margin-left: <xsl:value-of select="$indent-value - 3" />em; text-indent: -1em;</xsl:attribute>
					<xsl:value-of select="@label" />
					<xsl:text> </xsl:text>
					<xsl:apply-templates />
				</div>
			</td>
			
			<xsl:choose>
				<xsl:when test="//did/unitdate">
					<td />
				</xsl:when>
			</xsl:choose>
		</tr>
	</xsl:template>
	<!--
 ADDITIONAL INFORMATION 
 this is for generic add elements (type='addinfo') 

	<xsl:template match="add[@type='addinfo']">
		<xsl:apply-templates />
		<HR/>
	</xsl:template>
	
	<xsl:template match="add/add">
		<DIV class="heading">
			<xsl:value-of select="head" />
		</DIV>
		<DIV class="item">
			<xsl:apply-templates select="list | p" />
		</DIV>
	</xsl:template>
		-->


	<!-- SEPARATED MATERIAL -->


	<xsl:template match="archdesc/descgrp/separatedmaterial">
		<xsl:apply-templates />
	</xsl:template>

	<xsl:template match="archdesc/separatedmaterial">
		<hr />
		<xsl:apply-templates />
	</xsl:template>

	<!--INDEX-->

	<xsl:template match="
			archdesc/index
			| archdesc/*/index">
		<table width="100%">
			<tr>
				<td width="5%"> </td>
				<td width="45%"> </td>
				<td width="50%"> </td>
			</tr>
			<tr>
				<td colspan="3">
					<h3>
						<a name="{generate-id(head)}">
							<b>
								<xsl:apply-templates select="head" />
							</b>
						</a>
					</h3>
				</td>
			</tr>
			<xsl:for-each select="p | note/p">
				<tr>
					<td />
					<td colspan="2">
						<xsl:apply-templates />
					</td>
				</tr>
			</xsl:for-each>

			<!--Processes each index entry.-->

			<xsl:for-each select="indexentry">

				<!--Sorts each entry term.-->

				<xsl:sort select="corpname | famname | function | genreform | geogname | name | occupation | persname | subject | title" />
				<tr>
					<td />
					<td>
						<xsl:apply-templates select="corpname | famname | function | genreform | geogname | name | occupation | persname | subject | title" />
					</td>
					<!--Supplies whitespace and punctuation if there is a pointer
						group with multiple entries.-->


					<xsl:choose>
						<xsl:when test="ptrgrp">
							<td>
								<xsl:for-each select="ptrgrp">
									<xsl:for-each select="ref | ptr">
										<xsl:apply-templates />
										<xsl:if test="preceding-sibling::ref or preceding-sibling::ptr">
											<xsl:text>, </xsl:text>
										</xsl:if>
									</xsl:for-each>
								</xsl:for-each>
							</td>
						</xsl:when>
						<!--If there is no pointer group, process each reference or pointer.-->

						<xsl:otherwise>
							<td>
								<xsl:for-each select="ref | ptr">
									<xsl:apply-templates />
								</xsl:for-each>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</tr>
				<!--Closes the indexentry.-->

			</xsl:for-each>
		</table>
		<p>
			<a href="#">Return to the Table of Contents</a>
		</p>
		<hr />
	</xsl:template>

	<!-- OTHER FINDING AIDS/GUIDES TO THIS MATERIAL -->

	<!-- if lists are needed here (outside of p tags, -->

	<!-- need to add otherfindaid to list templates below -->


	<!--	<xsl:template match="descgrp/otherfindaid">
		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="otherfindaid">
		<xsl:apply-templates />
		<HR/>
	</xsl:template>-->



	<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->


	<!-- CERTAIN LISTS -->
	
	<!-- TODO I don't know if this worked differently in XSL 1.0 or what,
		 but at least with the container scopecontents, these things are
		 being explicitly selected and then ending up matching and 
		 output again -->

	<xsl:template match="p/list | descgrp/list | arrangement/list | odd/list | separatedmaterial/list | relatedmaterial/list | scopecontent/list">
		<xsl:apply-templates select="head" />
		<xsl:choose>
			<xsl:when test="@type = 'marked'">
				<ul>
					<xsl:apply-templates select="item" />
				</ul>
			</xsl:when>
			<xsl:when test="@type = 'simple'">
				<ul class="simple">
					<xsl:apply-templates select="item" />
				</ul>
			</xsl:when>
			<xsl:when test="@type = 'ordered'">
				<xsl:choose>
					<xsl:when test="@numeration = 'arabic'">
						<ol>
							<xsl:apply-templates select="item" />
						</ol>
					</xsl:when>
					<xsl:when test="@numeration = 'upperalpha'">
						<ol class="upperalpha">
							<xsl:apply-templates select="item" />
						</ol>
					</xsl:when>
					<xsl:when test="@numeration = 'loweralpha'">
						<ol class="loweralpha">
							<xsl:apply-templates select="item" />
						</ol>
					</xsl:when>
					<xsl:when test="@numeration = 'upperroman'">
						<ol class="upperroman">
							<xsl:apply-templates select="item" />
						</ol>
					</xsl:when>
					<xsl:when test="@numeration = 'lowerroman'">
						<ol class="lowerroman">
							<xsl:apply-templates select="item" />
						</ol>
					</xsl:when>
					<xsl:otherwise>
						<ol>
							<xsl:apply-templates select="item" />
						</ol>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@type = 'deflist'">
				<table>
					<xsl:apply-templates select="defitem" />
				</table>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="p/list/head | descgrp/list/head | arrangement/list/head | odd/list/head | separatedmaterial/list/head | relatedmaterial/list/head | scopecontent/list/head">
		<u>
			<xsl:apply-templates />
		</u>
	</xsl:template>

	<xsl:template match="p/list/item | descgrp/list/item | arrangement/list/item | odd/list/item | separatedmaterial/list/item | relatedmaterial/list/item | scopecontent/list/item">
		<li>
			<xsl:apply-templates />
		</li>
	</xsl:template>

	<xsl:template match="p/list/defitem | descgrp/list/defitem | arrangement/list/defitem | odd/list/defitem | separatedmaterial/list/defitem | relatedmaterial/list/defitem | scopecontentl/list/defitem">
		<tr>
			<td>
				<xsl:apply-templates select="label" />
			</td>
			<td>
				<xsl:apply-templates select="item" />
			</td>
		</tr>
	</xsl:template>


	<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->


	<!-- LOW LEVEL ELEMENTS -->

	<xsl:template match="lb">
		<xsl:apply-templates />
		<br />
	</xsl:template>

	<xsl:template match="p">
		<div class="para">
			<xsl:apply-templates />
		</div>
	</xsl:template>

	<xsl:template match="note">
		<div class="note">
			<xsl:value-of select="." />
		</div>
	</xsl:template>

	<xsl:template match="title">
		<i>
			<xsl:apply-templates />
		</i>
	</xsl:template>

	<xsl:template match="emph[@render = 'bold']">
		<b>
			<xsl:apply-templates />
		</b>
	</xsl:template>
	<xsl:template match="emph[@render = 'italic']">
		<i>
			<xsl:apply-templates />
		</i>
	</xsl:template>
	<xsl:template match="emph[@render = 'underline']">
		<u>
			<xsl:apply-templates />
		</u>
	</xsl:template>
	<xsl:template match="emph[@render = 'super']">
		<sup>
			<xsl:apply-templates />
		</sup>
	</xsl:template>
	<xsl:template match="emph[@altrender = 'red']">
		<font color="red">
			<xsl:apply-templates />
		</font>
	</xsl:template>


	<!-- LINKS AND POINTERS -->


	<xsl:template match="extref">
		<xsl:choose>
			<xsl:when test="@show = 'new'">
				<a target="_blank">
					<xsl:attribute name="HREF">
						<xsl:value-of select="@href" />
					</xsl:attribute>
					<xsl:apply-templates />
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a target="_top">
					<xsl:attribute name="HREF">
						<xsl:value-of select="@href" />
					</xsl:attribute>
					<xsl:apply-templates />
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="ref">
		<a href="#{@target}">
			<xsl:apply-templates /> <p/>
		</a>
	</xsl:template>

	<xsl:template match="extptr">
		<div class="image">
			<img>
				<xsl:attribute name="SRC">
					<xsl:value-of select="@href" />
				</xsl:attribute>
				<xsl:attribute name="ALT">
					<xsl:value-of select="@title" />
				</xsl:attribute>
			</img>
		</div>
		<div class="caption">
			<xsl:value-of select="@title" />
		</div>
	</xsl:template>


	<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->


	<!-- functions -->


	<xsl:template name="depth-of-node">
		<xsl:value-of select="count(ancestor::node())" />
	</xsl:template>


	<!-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

  
  
  
  
  
  
  
  
  
    
</xsl:stylesheet>