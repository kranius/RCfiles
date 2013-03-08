<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright &#169; 2012 Accenture - Prepared by Digiplug
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns2="http://ddex.net/xml/2011/ern-main/33">
  <xsl:output method="html" encoding="utf-8" indent="yes" />

<!-- Root template, first to be applied -->
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="ns2:NewReleaseMessage">
        <xsl:apply-templates select="ns2:NewReleaseMessage" />
      </xsl:when>
      <xsl:otherwise><div id="error">This XML doesn't match DDEX format.</div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<!--  This template aims to get the path of the exposed xslt  -->
  <xsl:template match="processing-instruction('xml-stylesheet')">
    <xsl:copy-of select="substring-before(substring-after(substring-after(., 'href'), '&quot;'), 'parse.xsl')"/>
  </xsl:template>

  <xsl:template match="ns2:NewReleaseMessage">
	<div style="text-align:left; display:none;">
        <img src="logo.jpg" alt="logo" />
        <div class="top">
          <xsl:value-of select="MessageHeader/MessageFileName" />
        </div>
	</div>
        <xsl:apply-templates select="MessageHeader" />

<!-- musical work are not in the scope for now -->
<!-- <H2>Musical Work</H2> -->
<!-- <xsl:apply-templates select="WorkList/MusicalWork" /><br/> -->
<!-- <hr/> -->

    <div id="summary" class="mid">
      <xsl:call-template name="summary" />
    </div>

    <div class="colmask threecol">
      <div class="colmid">
        <div class="colleft" style="text-align: center;">
          <div class="col1">
            <span style="font-size: 20px; cursor: pointer;" name="release" blocks="rel" terr="relter" onclick="collapse(this);">Releases</span>
            <div class="col">
              <xsl:apply-templates select="ReleaseList" />
            </div>
          </div>

          <div class="col2">
            <span style="font-size: 20px; cursor: pointer;" name="resource" blocks="sound,img,vid,txt" terr="ster,vter,iter,tter" onclick="collapse(this);">Resources</span>
            <div class="col">
              <xsl:apply-templates select="ResourceList" /><br/>
            </div>
          </div>

          <div class="col3">
            <span style="font-size: 20px; cursor: pointer;" name="deal" terr="dealter" onclick="collapse(this);">Deals</span>
            <div class="col">
              <xsl:apply-templates select="DealList" />
            </div>
          </div>
        </div>
      </div>
    </div>
</xsl:template>

<!--
  MESSAGE HEADER
-->
<xsl:template match="MessageHeader">
  <div class="header">
    <div class="headmain">
      <b>Header</b><br />
      <div class="block">
        ThreadId : <xsl:value-of select="MessageThreadId" /><br/>
        MessageId : <xsl:value-of select="MessageId" /><br/>
        FileName : <xsl:value-of select="MessageFileName" /><br/>
        CreationDate : <xsl:value-of select="MessageCreatedDateTime" /><br/>
        Status : <xsl:value-of select="../UpdateIndicator" /><br />
        ControlType : <xsl:value-of select="MessageControlType" /><br/>
      </div>
    </div>
    <div class="headerdetails">
      <b>Content Distributor</b><br/>
      <div class="block">
        PartyId : <xsl:value-of select="MessageSender/PartyId" /><br/>
        PartyName : <xsl:value-of select="MessageSender/PartyName/FullName" /><br/>
      </div>

      <b>Content Owner</b><br/>
      <div class="block">
        PartyId : <xsl:value-of select="SentOnBehalfOf/PartyId" /><br/>
        PartyName : <xsl:value-of select="SentOnBehalfOf/PartyName/FullName" /><br/>
      </div>

      <b>DSP</b><br/>
      <div class="block">
        PartyId : <xsl:value-of select="MessageRecipient/PartyId" /><br/>
        PartyName : <xsl:value-of select="MessageRecipient/PartyName/FullName" /><br/>
      </div>
    </div>
  </div>
</xsl:template>

<!--
  MUSICAL WORK
-->
<xsl:template match="MusicalWork">
  WorkId : <xsl:value-of select="MusicalWorkId/ProprietaryId"/><br/>
  WorkReference : <xsl:value-of select="MusicalWorkReference" /><br/>
  WorkTitle : <xsl:value-of select="ReferenceTitle/TitleText" /><br/>
  <xsl:apply-templates select="MusicalWorkContributor" />
  <br/>
</xsl:template>

<xsl:template match="MusicalWorkContributor">
  Name : <xsl:value-of select="PartyName/FullName" /><br/>
  Role : <xsl:value-of select="MusicalWorkContributorRole" /><br/>
</xsl:template>

<!--
  RESOURCES
-->
<xsl:template match="ResourceList">
  <a name="restop" />
    <xsl:apply-templates select="SoundRecording" />
    <xsl:apply-templates select="Video" />
    <xsl:apply-templates select="Image" />
    <xsl:apply-templates select="Text" />
</xsl:template>

<xsl:template name="title">
  Title : <xsl:value-of select="TitleText" />
  <xsl:if test="self::node()[@TitleType = 'TranslatedTitle']">
    &#160; (<xsl:value-of select="self::node()/@LanguageAndScriptCode" />)
  </xsl:if>
  <br />
  <xsl:if test="SubTitle">
    Sub Title : <xsl:value-of select="SubTitle" /><br />
  </xsl:if>
</xsl:template>

<xsl:template name="artist">
  <xsl:if test="KeyName">
    Key Name : <xsl:value-of select="KeyName" /><br />
  </xsl:if>
  <xsl:if test="NamesAfterKeyName">
    Names after : <xsl:value-of select="NamesAfterKeyName" /><br />
  </xsl:if>
  <xsl:choose>
    <xsl:when test="self::node()/@LanguageAndScriptCode">
      Name : <xsl:value-of select="FullName"/>&#160;
      (<xsl:value-of select="self::node()/@LanguageAndScriptCode" />)<br />
    </xsl:when>
    <xsl:otherwise>
      Full Name : <xsl:value-of select="FullName"/><br />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--
     Add for DDEX 3.5
     RESOURCES/MIDI
-->
<xsl:template match="Midi">
</xsl:template>

<xsl:template match="MidiDetailsByTerritory">
</xsl:template>

<xsl:template match="TechnicalMidiDetails">
</xsl:template>

<!--
  RESOURCES/VIDEO
-->
<xsl:template match="Video">
  <xsl:variable name="nb">
    <xsl:number />
  </xsl:variable>
  <div id="video-{$nb}" class="release">
    <div id="vidtog-{$nb}" class="clickme">
      <a class="ref"><xsl:attribute name="name"><xsl:value-of select="ResourceReference" /></xsl:attribute></a>
      <H2>Video</H2>
      Reference : <xsl:value-of select="ResourceReference" /><br/>
      ISRC : <xsl:value-of select="VideoId/ISRC" /><br/>
    </div>
    <a class="gotorel"><xsl:attribute name="href"><xsl:value-of select="concat('#release', ResourceReference)" /></xsl:attribute>See the release</a>
    <div id="vid-{$nb}" class="resource">
      Title : <xsl:value-of select="ReferenceTitle/TitleText" /><br/>
      <xsl:if test="ReferenceTitle/SubTitle">
        SubTitle : <xsl:value-of select="ReferenceTitle/SubTitle" /><br/>
      </xsl:if>
      Bonus : <xsl:value-of select="IsBonusResource" /><br/>
      Duration : <xsl:apply-templates select="Duration" /><br/>
      <H3>Details by territory</H3>
      <xsl:apply-templates select="VideoDetailsByTerritory">
        <xsl:with-param name="n" select="$nb" />
        <xsl:sort select="TerritoryCode" />
      </xsl:apply-templates>
    </div>
  </div>
</xsl:template>

<xsl:template match="VideoDetailsByTerritory">
  <xsl:param name="n" />
  <xsl:variable name="count">
    <xsl:number />
  </xsl:variable>
  <div style="display: none">
    <xsl:attribute name="class">
      <xsl:value-of select="TerritoryCode" />
    </xsl:attribute>
    <h4 id="vtertog-{$n}-{$count}" class="clickme">+ TerritoryCode : <xsl:value-of select="TerritoryCode" /></h4>
    <div id="vter-{$n}-{$count}" class="terr">
      <xsl:for-each select="Title">
        <xsl:call-template name="title" />
      </xsl:for-each>
      <b>Display Artists</b><br/>
      <xsl:apply-templates select="DisplayArtist" /><br/>
      <b>Contributors</b><br/>
      <xsl:apply-templates select="IndirectResourceContributor" /><br/>
      Label : <xsl:value-of select="LabelName" /><br/>
      PLine : <xsl:value-of select="PLine/PLineText" /><br/>
      Genre : <xsl:value-of select="Genre/GenreText" /><br/>
      ParentalWarning : <xsl:value-of select="ParentalWarningType" /><br/>
      CLine : <xsl:value-of select="CLine/CLineText" /><br/>
      <br />
      <b>Technical Details</b><br/>
      <xsl:apply-templates select="TechnicalVideoDetails" />
    </div>
  </div>
</xsl:template>

<xsl:template match="TechnicalVideoDetails">
  Reference : <xsl:value-of select="TechnicalResourceDetailsReference" /><br/>
  File Name : <xsl:value-of select="File/FileName" /><br/>
  Hash Sum : <xsl:value-of select="File/HashSum/HashSum" /><br/>
  Hash Algorithm : <xsl:value-of select="File/HashSum/HashSumAlgorithmType" /><br/>
  Bitrate : <xsl:value-of select="VideoBitRate" /><br/>
  Framerate : <xsl:value-of select="FrameRate" /><br/>
  Image height : <xsl:value-of select="ImageHeight" /><br/>
  ImageWidth : <xsl:value-of select="ImageWidth" /><br/>
  Aspect Ratio : <xsl:value-of select="AspectRation" /><br/>
  Audio codec : <xsl:value-of select="AudioCodecType" /><br/>
  Audio bitrate : <xsl:value-of select="AudioBitRate" /><br/>
  Audio channels : <xsl:value-of select="NumberOfAudioChannels" /><br/>
  Audio sampling rate : <xsl:value-of select="AudioSamplingRate" /><br/>
  Preview : <xsl:value-of select="IsPreview" /><br/>
  <br />
</xsl:template>

<!--
  RESOURCES/SOUNDRECORDING
-->
<xsl:template match="SoundRecording">
  <xsl:variable name="nb">
    <xsl:number />
  </xsl:variable>
  <div id="soundrecording-{$nb}" class="release">
    <div id="soundtog-{$nb}" class="clickme">
      <a class="ref"><xsl:attribute name="name"><xsl:value-of select="ResourceReference" /></xsl:attribute></a>
      <H2>Sound Recording</H2>
      <b>Reference</b> : <xsl:value-of select="ResourceReference" /><br/>
      Type : <xsl:value-of select="SoundRecordingType" /><br/>
      ISRC :
      <xsl:choose>
        <xsl:when test="SoundRecordingId/ProprietaryId">
          <xsl:value-of select="SoundRecordingId/ProprietaryId" /><br/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="SoundRecordingId/ISRC" /><br/>
        </xsl:otherwise>
      </xsl:choose>
    </div>
    <a class="gotorel"><xsl:attribute name="href"><xsl:value-of select="concat('#release', ResourceReference)" /></xsl:attribute>See the release</a>
    <div id="sound-{$nb}" class="resource">
      Title : <xsl:value-of select="ReferenceTitle/TitleText" /><br/>
      <xsl:if test="ReferenceTitle/SubTitle">
        SubTitle : <xsl:value-of select="ReferenceTitle/SubTitle" /><br/>
      </xsl:if>
      Bonus : <xsl:value-of select="IsBonusResource" /><br/>
      Duration : <xsl:apply-templates select="Duration" />
      <H3>Details by territory</H3>
      <xsl:apply-templates select="SoundRecordingDetailsByTerritory">
        <xsl:with-param name="n" select="$nb"/>
        <xsl:sort select="TerritoryCode" />
      </xsl:apply-templates>
    </div>
  </div>
</xsl:template>

<xsl:template match="SoundRecordingDetailsByTerritory">
  <xsl:param name="n" />
  <xsl:variable name="count">
    <xsl:number />
  </xsl:variable>
  <div style="display: none">
    <xsl:attribute name="class">
      <xsl:value-of select="TerritoryCode" />
    </xsl:attribute>
    <h4 id="stertog-{$n}-{$count}" class="clickme">+ TerritoryCode : <xsl:value-of select="TerritoryCode" /></h4>
    <div id="ster-{$n}-{$count}" class="terr">
      <xsl:for-each select="Title">
        <xsl:call-template name="title" />
      </xsl:for-each>
      <br/>
      <b>Display Artists</b><br/>
      <xsl:apply-templates select="DisplayArtist" />
      <b>Contributors</b><br/>
      <xsl:apply-templates select="IndirectResourceContributor" />
      Label : <xsl:value-of select="LabelName" /><br/>
      PLine : <xsl:value-of select="PLine/PLineText" /><br/>
      Genre : <xsl:value-of select="Genre/GenreText" /><br/>
      Parental Advisory : <xsl:value-of select="ParentalWarningType" /><br/>
      <br />
      <b>Technical Details</b><br/>
      <xsl:apply-templates select="TechnicalSoundRecordingDetails" />
    </div>
  </div>
</xsl:template>

<xsl:template match="TechnicalSoundRecordingDetails">
  File Name : <xsl:value-of select="File/FileName" /><br/>
  Hash Sum : <xsl:value-of select="File/HashSum/HashSum" /><br/>
  Hash Algorithm : <xsl:value-of select="File/HashSum/HashSumAlgorithmType" /><br/>
  Reference : <xsl:value-of select="TechnicalResourceDetailsReference" /><br/>
  Audio Codec : <xsl:value-of select="AudioCodecType" /><br/>
  Bitrate : <xsl:value-of select="BitRate" /><br/>
  Channels : <xsl:value-of select="NumberOfChannels" /><br/>
  Sampling Rate : <xsl:value-of select="SamplingRate" /><br/>
  Bits Per Sample : <xsl:value-of select="BitsPerSample" /><br/>
  Duration : <xsl:apply-templates select="Duration" /><br/>
  Preview : <xsl:value-of select="IsPreview" />
  <br />
</xsl:template>

<xsl:template match="DisplayArtist">
  <xsl:for-each select="PartyName">
    <xsl:call-template name="artist" />
  </xsl:for-each>
  <xsl:apply-templates select="ArtistRole" />
  <br />
</xsl:template>

<xsl:template match="ArtistRole">
  Role :
  <xsl:choose>
    <xsl:when test="self::node()[text()='UserDefined']">
      <xsl:value-of select="@UserDefinedValue" /><br/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="." /><br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="IndirectResourceContributorRole">
  Role :
  <xsl:choose>
    <xsl:when test="self::node()[text()='UserDefined']">
      <xsl:value-of select="@UserDefinedValue" /><br/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="." /><br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="IndirectResourceContributor">
  Full Name: <xsl:value-of select="PartyName/FullName" /><br/>
  <xsl:apply-templates select="IndirectResourceContributorRole" />
  <br/>
</xsl:template>

<!--
  RESOURCES/IMAGE
-->
<xsl:template match="Image">
  <xsl:variable name="nb">
    <xsl:number />
  </xsl:variable>
  <div id="image-{$nb}" class="release">
    <div id="imgtog-{$nb}" class="clickme">
      <a class="ref"><xsl:attribute name="name"><xsl:value-of select="ResourceReference" /></xsl:attribute></a>
      <H2>Image</H2>
      <b>Reference</b> : <xsl:value-of select="ResourceReference" /><br/>
      ProprietaryId : <xsl:value-of select="ImageId/ProprietaryId" /><br/>
      Title : <xsl:value-of select="Title/TitleText" /><br/>
      <xsl:if test="Title/SubTitle">
        SubTitle : <xsl:value-of select="Title/SubTitle" /><br/>
      </xsl:if>
    </div>
    <div id="img-{$nb}" class="resource">
      <xsl:apply-templates select="ImageDetailsByTerritory">
        <xsl:with-param name="n" select="$nb" />
        <xsl:sort select="TerritoryCode" />
      </xsl:apply-templates>
    </div>
  </div>
</xsl:template>

<xsl:template match="ImageDetailsByTerritory">
  <xsl:param name="n" />
  <xsl:variable name="count">
    <xsl:number />
  </xsl:variable>
  <div style="display: none">
    <xsl:attribute name="class">
      <xsl:value-of select="TerritoryCode" />
    </xsl:attribute>
    <h4 id="itertog-{$n}-{$count}" class="clickme">+ TerritoryCode : <xsl:value-of select="TerritoryCode" /></h4>
    <div id="iter-{$n}-{$count}" class="terr">
      CLine : <xsl:value-of select="CLine/CLineText" /><br/>
      Parental Warning : <xsl:value-of select="ParentalWarningType" /><br/>
      <br />
      <b>Technical Details</b><br/>
      <xsl:apply-templates select="TechnicalImageDetails" />
    </div>
  </div>
</xsl:template>

<xsl:template match="TechnicalImageDetails">
  File Name : <xsl:value-of select="File/FileName" /><br/>
  Hash Sum : <xsl:value-of select="File/HashSum/HashSum" /><br/>
  Hash Algorithm : <xsl:value-of select="File/HashSum/HashSumAlgorithmType" /><br/>
  Reference : <xsl:value-of select="TechnicalResourceDetailsReference" /><br/>
  Codec : <xsl:value-of select="ImageCodecType" /><br/>
  Height : <xsl:value-of select="ImageHeight" /><br/>
  Width : <xsl:value-of select="ImageWidth" /><br/>
  Aspect Ratio : <xsl:value-of select="AspectRatio" /><br/>
  Color Depth : <xsl:value-of select="ColorDepth" /><br/>
  Resolution : <xsl:value-of select="ImageResolution" /><br/>
</xsl:template>

<!--
  RESOURCES/TEXT
-->
<xsl:template match="Text">
  <xsl:variable name="nb">
    <xsl:number />
  </xsl:variable>
  <div id="text-{$nb}" class="release">
    <div id="texttog-{$nb}" class="clickme">
      <a class="ref"><xsl:attribute name="name"><xsl:value-of select="ResourceReference" /></xsl:attribute></a>
      <H2>Text</H2>
      <b>Reference</b> : <xsl:value-of select="ResourceReference" /><br/>
      ProprietaryId : <xsl:value-of select="TextId/ProprietaryId" /><br/>
      Title : <xsl:value-of select="Title/TitleText" /><br/>
      <xsl:if test="Title/SubTitle">
        SubTitle : <xsl:value-of select="Title/SubTitle" /><br/>
      </xsl:if>
    </div>
    <div id="txt-{$nb}" class="resource">
      <xsl:apply-templates select="TextDetailsByTerritory">
        <xsl:with-param name="n" select="$nb" />
        <xsl:sort select="TerritoryCode" />
      </xsl:apply-templates>
    </div>
  </div>
</xsl:template>

<xsl:template match="TextDetailsByTerritory">
  <xsl:param name="n" />
  <xsl:variable name="count">
    <xsl:number />
  </xsl:variable>
  <div style="display: none">
    <xsl:attribute name="class">
      <xsl:value-of select="TerritoryCode" />
    </xsl:attribute>
    <h4 id="ttertog-{$n}-{$count}" class="clickme">+ TerritoryCode : <xsl:value-of select="TerritoryCode" /></h4>
    <div id="tter-{$n}-{$count}" class="terr">
      CLine : <xsl:value-of select="CLine/CLineText" /><br/>
      Parental Warning : <xsl:value-of select="ParentalWarningType" /><br/>
      <br />
      <b>Technical Details</b><br/>
      <xsl:apply-templates select="TechnicalTextDetails" />
    </div>
  </div>
</xsl:template>

<xsl:template match="TechnicalTextDetails">
  File Name : <xsl:value-of select="File/FileName" /><br/>
  Hash Sum : <xsl:value-of select="File/HashSum/HashSum" /><br/>
  Hash Algorithm : <xsl:value-of select="File/HashSum/HashSumAlgorithmType" /><br/>
  Reference : <xsl:value-of select="TechnicalResourceDetailsReference" /><br/>
</xsl:template>

<!--
  RELEASES
-->
<xsl:template match="ReleaseList">
    <xsl:apply-templates select="Release" />
</xsl:template>

<xsl:template match="Release">
  <xsl:variable name="nb">
    <xsl:number />
  </xsl:variable>
  <div id="release-{$nb}" class="release">
    <div id="reltog-{$nb}" class="clickme">
      <xsl:if test="count(descendant::ReleaseResourceReferenceList/ReleaseResourceReference) = 1">
        <a><xsl:attribute name="name"><xsl:value-of select="concat('release', ReleaseResourceReferenceList/ReleaseResourceReference)" /></xsl:attribute><xsl:attribute name="id"><xsl:value-of select="concat('rref', $nb)" /></xsl:attribute></a>
      </xsl:if>
      <a class="ref"><xsl:attribute name="name"><xsl:value-of select="ReleaseReference" /></xsl:attribute></a>
      <h2>Reference : <xsl:value-of select="ReleaseReference"/></h2>
      <xsl:apply-templates select="ReleaseId" />
    </div>
    <br />
    <div class="togglebox">
      <xsl:attribute name="id"><xsl:value-of select="concat('relbox-', $nb)" /></xsl:attribute>
      <xsl:attribute name="name"><xsl:value-of select="ReleaseResourceReferenceList/ReleaseResourceReference" /></xsl:attribute>
      <a class="gotodeal">
        <xsl:attribute name="href"><xsl:value-of select="concat('#deal', ReleaseReference)" /></xsl:attribute>
        See the deal<br />
      </a>
      <xsl:apply-templates select="ReleaseResourceReferenceList/ReleaseResourceReference">
        <xsl:with-param name="ref" select="ReleaseReference" />
      </xsl:apply-templates>
      <div id="rel-{$nb}" class="resource">
        <xsl:apply-templates select="ReferenceTitle" />
        Type :
        <xsl:choose>
          <xsl:when test="//ReleaseList/Release/ReleaseType[text()='UserDefined']">
            <xsl:value-of select="//ReleaseList/Release/ReleaseType/@UserDefinedValue" /><br/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="//ReleaseList/Release/ReleaseType" /><br/>
          </xsl:otherwise>
        </xsl:choose>
        Duration : <xsl:apply-templates select="Duration" /><br/>
        Pline : <xsl:value-of select="PLine/PLineText" /><br/>
        <h3>Details by territory</h3>
        <xsl:apply-templates select="ReleaseDetailsByTerritory">
          <xsl:with-param name="n" select="$nb" />
          <xsl:sort select="TerritoryCode" />
        </xsl:apply-templates>
      </div>
    </div>
  </div>
</xsl:template>

<xsl:template match="ReferenceTitle">
  <xsl:apply-templates select="TitleText" />
  <xsl:apply-templates select="SubTitle" />
</xsl:template>

<xsl:template match="TitleText">
  Title :
  <xsl:choose>
    <xsl:when test="self::node()[text()='UserDefined']">
      <xsl:value-of select="@UserDefinedValue" /><br/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="." /><br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="SubTitle">
  <xsl:if test=".">
    Sub Title : <xsl:value-of select="." /><br />
  </xsl:if>
</xsl:template>

<xsl:template match="ReleaseId">
  <xsl:apply-templates select="ProprietaryId" />
  <xsl:apply-templates select="ICPN" />
</xsl:template>

<xsl:template match="ProprietaryId">
  ProprietaryId : <xsl:value-of select="." /><br/>
</xsl:template>

<xsl:template match="ICPN">
  <b>ICPN</b> : <xsl:value-of select="." /><br/>
</xsl:template>

<xsl:template match="ReleaseDetailsByTerritory">
  <xsl:param name="n" />
  <xsl:variable name="count">
    <xsl:number />
  </xsl:variable>
  <div style="display: none">
    <xsl:attribute name="class">
      <xsl:value-of select="TerritoryCode" />
    </xsl:attribute>
    <h4 id="reltertog-{$n}-{$count}" class="clickme">+ TerritoryCode : <xsl:value-of select="TerritoryCode" /></h4>
    <div id="relter-{$n}-{$count}" class="terr">
      Label : <xsl:value-of select="LabelName" /><br/>
      <xsl:apply-templates select="Title" />
      <br/>
      <xsl:apply-templates select="DisplayArtist" />
      Parental Warning : <xsl:value-of select="ParentalWarningType" /><br/>
      Comment : <xsl:value-of select="MarketingComment" /><br/>
      Genre : <xsl:value-of select="Genre/GenreText" /><br/>
      <br />
      <xsl:apply-templates select="ResourceGroup" />
    </div>
  </div>
</xsl:template>

<xsl:template match="ResourceGroup">
  <xsl:apply-templates select="ResourceGroup" />
  <xsl:apply-templates select="ResourceGroupContentItem" />
</xsl:template>

<xsl:template match="ResourceGroupContentItem">
  <xsl:variable name="level" select="count(ancestor::ResourceGroup)" />
  <xsl:if test="$level = 3">
    <b>Asset group resource</b><br />
    <xsl:call-template name="item" />
  </xsl:if>
  <xsl:if test="$level = 2">
    <b>Volume resource</b><br />
    <xsl:call-template name="item" />
  </xsl:if>
  <xsl:if test="$level = 1">
    <b>Resource</b><br />
    <xsl:call-template name="item" />
  </xsl:if>
</xsl:template>

<xsl:template name="item">
  <div class="track">
    <xsl:if test="child::*[self::SequenceNumber]">
      Sequence number : <xsl:value-of select="SequenceNumber" /><br />
    </xsl:if>
    ReleaseResourceReference : <xsl:value-of select="ReleaseResourceReference" /><br />
    Bonus release : <xsl:value-of select="IsBonusResource" /><br />
  </div>
  <br />
</xsl:template>

<xsl:template match="Title">
  <xsl:variable name="type">
    <xsl:choose>
      <xsl:when test="@TitleType">
        <xsl:value-of select="@TitleType" />
      </xsl:when>
      <xsl:otherwise>
        TitleText
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:for-each select="TitleText">
    <xsl:value-of select="$type" /> : <xsl:value-of select="." />
    <xsl:if test="$type = 'TranslatedTitle'">
      (<xsl:value-of select="../@LanguageAndScriptCode" />)
    </xsl:if>
    <br/>
  </xsl:for-each>

  <xsl:for-each select="SubTitle">
    <xsl:value-of select="$type" /> : <xsl:value-of select="." />
    <xsl:if test="$type = 'TranslatedTitle'">
      (<xsl:value-of select="../@LanguageAndScriptCode" />)
    </xsl:if>
    <br/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="ReleaseResourceReference">
  <a class="map">
    <xsl:attribute name="href"><xsl:value-of select="concat('#',.)" /></xsl:attribute>
    <xsl:attribute name="onclick">update($($('a[name="' + this.hash.substring(1) + '"]').parent().parent()).attr('id'));</xsl:attribute>
    Resource Reference : <xsl:value-of select="." /></a><br/>
</xsl:template>

<!--
  DEALS
-->
<xsl:template match="DealList">
    <xsl:apply-templates select="ReleaseDeal" />
</xsl:template>

<xsl:key name="countryRef" match="Deal" use="concat(../DealReleaseReference, DealTerms/TerritoryCode)" />
<xsl:key name="tou" match="Deal" use="concat(../DealReleaseReference, DealTerms/TerritoryCode, DealTerms/CommercialModelType, DealTerms/Usage/UseType,  DealTerms/Usage/DistributionChannelType/@UserDefinedValue)" />
<xsl:template match="ReleaseDeal">
  <xsl:variable name="count">
    <xsl:number />
  </xsl:variable>

  <xsl:variable name="currentReleaseDealRef"><xsl:value-of select="DealReleaseReference"/></xsl:variable>
  <div id="deal-{$count}" class="release">
    <a><xsl:attribute name="name"><xsl:value-of select="concat('deal', $currentReleaseDealRef)" /></xsl:attribute><xsl:attribute name="id"><xsl:value-of select="concat('dref', $count)" /></xsl:attribute></a>
    <h3><a class="map">
          <xsl:attribute name="href"><xsl:value-of select="concat('#', $currentReleaseDealRef)"/></xsl:attribute>
          <xsl:attribute name="onclick">update($($('a[name="' + this.hash.substring(1) + '"]').parent().parent()).attr('id'));</xsl:attribute>
          Release reference : <xsl:value-of select="$currentReleaseDealRef"/></a></h3>

    <div class="togglebox">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('dealbox-', $count)" />
      </xsl:attribute>
      <xsl:attribute name="name">
        <xsl:value-of select="$currentReleaseDealRef" />
      </xsl:attribute>
      <xsl:for-each select="Deal[count(. | key('countryRef', concat(../DealReleaseReference, DealTerms/TerritoryCode))[1]) = 1]">
        <xsl:sort select="child::DealTerms/TerritoryCode" />

        <xsl:variable name="currentCountry"><xsl:value-of select="DealTerms/TerritoryCode"/></xsl:variable>

        <div style="display: none">
          <xsl:attribute name="class">
            <xsl:value-of select="$currentCountry" />
          </xsl:attribute>
          <h4 id="dealtertog-{$count}-{position()}" class="clickme">+ TerritoryCode : <xsl:value-of select="$currentCountry" /></h4>
          <div id="dealter-{$count}-{position()}" class="resource">

            <xsl:for-each select="key('countryRef', concat(../DealReleaseReference, $currentCountry)) [generate-id() = generate-id(key('tou', concat($currentReleaseDealRef,  $currentCountry,  DealTerms/CommercialModelType,  DealTerms/Usage/UseType,  DealTerms/Usage/DistributionChannelType/@UserDefinedValue)))]">
              <xsl:variable name="currentTOUComType"><xsl:value-of select="DealTerms/CommercialModelType"/></xsl:variable>

              <xsl:variable name="currentTOUComUseType"><xsl:value-of select="DealTerms/Usage/UseType"/></xsl:variable>

              <xsl:variable name="currentTOUDistribType"><xsl:value-of select="DealTerms/Usage/DistributionChannelType/@UserDefinedValue"/></xsl:variable>

              <b>
                <xsl:choose>
                  <xsl:when test="DealTerms/AllDealsCancelled">
                    Deal cancelled<br />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="DealTerms/TakeDown">
                        Deal takedown<br />
                      </xsl:when>
                      <xsl:otherwise>
                        <span><xsl:value-of select="concat($currentTOUComUseType, ' - ',$currentTOUDistribType, ' - ', $currentTOUComType, ' ')" /></span><br/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </b>

              <xsl:for-each select="../Deal/DealTerms[../../DealReleaseReference=$currentReleaseDealRef and TerritoryCode=$currentCountry and CommercialModelType=$currentTOUComType and Usage/UseType=$currentTOUComUseType and Usage/DistributionChannelType/@UserDefinedValue=$currentTOUDistribType]">
                <xsl:sort select="ValidityPeriod/StartDate"/><br />
                Price type : <xsl:value-of select="PriceInformation/PriceType" /><br />
                <xsl:apply-templates select="ValidityPeriod" />
                <xsl:if test="PreOrderReleaseDate">
                  PreOrder Release Date : <xsl:value-of select="PreOrderReleaseDate" /><br />
                </xsl:if>
                <xsl:if test="PreOrderPreviewDate">
                  PreOrder Preview Date : <xsl:value-of select="PreOrderPreviewDate" /><br />
                </xsl:if>
              </xsl:for-each>
            </xsl:for-each>
          </div>
        </div>
      </xsl:for-each>
    </div>
  </div>
</xsl:template>

<xsl:template match="ValidityPeriod">
  <xsl:if test="StartDate">
    Start Date :  <xsl:value-of select="StartDate" /><br />
  </xsl:if>
  <xsl:if test="EndDate">
    End Date :  <xsl:value-of select="EndDate" /><br />
  </xsl:if>
</xsl:template>

<!--
  SUMMARY
-->
<xsl:template name="summary">
  <div class="sum">
    <div class="filters">
      <b>ICPN (UPC)</b> :
      <xsl:choose>
        <xsl:when test="/ns2:NewReleaseMessage/ReleaseList/Release[1]/ReleaseId/ICPN">
          <xsl:value-of select="/ns2:NewReleaseMessage/ReleaseList/Release[1]/ReleaseId/ICPN" /><br />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/ns2:NewReleaseMessage/ReleaseList/Release[1]/ReleaseId/ProprietaryId" /><br />
        </xsl:otherwise>
      </xsl:choose>
      <b>Main artist</b> : <xsl:value-of select="//ResourceList/SoundRecording/SoundRecordingDetailsByTerritory/DisplayArtist/PartyName/FullName[../../ArtistRole = 'MainArtist']" /><br />
      <b>Title : </b><xsl:value-of select="//ReleaseList/Release/ReferenceTitle/TitleText" /><br />
      <b>Genre : </b> <xsl:value-of select="//ResourceList/SoundRecording[1]/SoundRecordingDetailsByTerritory[1]/Genre/GenreText" /><br />
      <b>Type : </b>
        <xsl:choose>
          <xsl:when test="//ReleaseList/Release/ReleaseType[text()='UserDefined']">
            <xsl:value-of select="//ReleaseList/Release/ReleaseType/@UserDefinedValue" /><br/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="//ReleaseList/Release/ReleaseType" /><br/>
          </xsl:otherwise>
        </xsl:choose>
      <br />
      <button onclick="collapseAll();">
        Toggle Everything
      </button>
      <h3>Filter by territory :</h3>
      <div class="scrollable">
        <button onclick="countryToggle();">
          (Un)select all
        </button>
        <xsl:for-each select="//ResourceList/*[1]/*/TerritoryCode">
          <xsl:sort select="TerritoryCode" />
          <xsl:variable name="ter" select="." />
          <input type="checkbox" name="territories" onclick="filter(this);" checked="yes">
            <xsl:attribute name="value">
              <xsl:value-of select="$ter" />
            </xsl:attribute>
          </input>&#160;&#160;&#160;<xsl:value-of select="$ter" /><br />
        </xsl:for-each>
      </div>
    </div>
    <div class="structure">
      <span style="display: none;">
        <span style="font-size: 20px; font-weight: bold;">Summary&#160;</span> (aggreggated view of the xml)</span>
      <h2>Product structure (<a><xsl:attribute name="href"><xsl:value-of select="concat('#', //ReleaseList/Release[1]/ReleaseReference)" /></xsl:attribute>ID : <xsl:value-of select="//ReleaseList/Release[1]/ReleaseReference" /></a>)</h2>
      <div class="product">
        <xsl:call-template name="volumes" />
      </div>
    </div>
  </div>
</xsl:template>

<xsl:template name="volumes">
  <xsl:variable name="tree" select="//ReleaseList/Release[1]/ReleaseDetailsByTerritory[1]/ResourceGroup" />
  <xsl:for-each select="$tree">
    <xsl:for-each select="ResourceGroup">
      <b>Volume n° <xsl:value-of select="SequenceNumber" /></b> : <br />
      <xsl:for-each select="ResourceGroup">
        &#160;&#160;&#160;&#160;
        Work name : <xsl:value-of select="Title/TitleText" /><br />
        <xsl:for-each select="ResourceGroupContentItem">
          &#160;&#160;&#160;&#160;
          &#160;&#160;&#160;&#160;
          n° <xsl:if test="string-length(SequenceNumber) &lt; 2">0</xsl:if><xsl:value-of select="SequenceNumber" />
          <xsl:call-template name="content">
            <xsl:with-param name="node" select="." />
          </xsl:call-template>
        </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="ResourceGroupContentItem">
        &#160;&#160;&#160;&#160;
        n° <xsl:if test="string-length(SequenceNumber) &lt; 2">0</xsl:if><xsl:value-of select="SequenceNumber" />
        <xsl:call-template name="content">
          <xsl:with-param name="node" select="." />
        </xsl:call-template>
      </xsl:for-each>
      <br />
    </xsl:for-each>
    <b>Other Resources</b> : <br />
    <xsl:for-each select="ResourceGroupContentItem[child::ReleaseResourceReference[@ReleaseResourceType = 'SecondaryResource']]">
      <xsl:call-template name="content">
        <xsl:with-param name="node" select="." />
      </xsl:call-template>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>

<xsl:template match="volumesTable">
  <!--
       here template table row for each resource
  -->
</xsl:template>


<xsl:template name="content">
  <xsl:param name="node" />
  <xsl:variable name="resource" select="//ResourceList/*[child::ResourceReference = $node/ReleaseResourceReference]" />
  <xsl:for-each select="$resource">
    <xsl:if test="name(.) = 'SoundRecording'">
      <xsl:call-template name="sound" />
    </xsl:if>
    <xsl:if test="name(.) = 'Video'">
      <xsl:call-template name="video" />
    </xsl:if>
    <xsl:if test="name(.) = 'Image'">
      <xsl:call-template name="image" />
    </xsl:if>
    <xsl:if test="name(.) = 'Text'">
      <xsl:call-template name="text" />
    </xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template name="sound">
  <xsl:variable name="ref" select="ResourceReference" />
  <xsl:variable name="ref2" select="//ReleaseList/*/ReleaseReference[../ReleaseDetailsByTerritory/ResourceGroup/ResourceGroupContentItem/ReleaseResourceReference = $ref]" />
  <xsl:variable name="title" select="ReferenceTitle/TitleText" />
  <xsl:variable name="padding" select="50 - string-length($title)" />
  (Sound Recording) <a onclick="tripleLink(this);" ref="{$ref2}">
    <xsl:attribute name="href">
      <xsl:value-of select="concat('#', $ref)" />
    </xsl:attribute>
    <b>ISRC</b> :
      <xsl:choose>
        <xsl:when test="SoundRecordingId/ProprietaryId">
          <xsl:value-of select="SoundRecordingId/ProprietaryId" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="SoundRecordingId/ISRC" />
        </xsl:otherwise>
      </xsl:choose>
  </a>, &#160;
  <b>Title</b> : <xsl:value-of select="ReferenceTitle/TitleText" />,
  <xsl:for-each select="(//*)[position()&lt;$padding]">&#160;</xsl:for-each>
  <b>Artist</b> : <xsl:value-of select="SoundRecordingDetailsByTerritory/DisplayArtist/PartyName/FullName" />&#160;
  <br />
</xsl:template>

<xsl:template name="video">
  <xsl:variable name="ref" select="ResourceReference" />
  <xsl:variable name="ref2" select="//ReleaseList/*/ReleaseReference[../ReleaseDetailsByTerritory/ResourceGroup/ResourceGroupContentItem/ReleaseResourceReference = $ref]" />
  <xsl:variable name="title" select="ReferenceTitle/TitleText" />
  <xsl:variable name="padding" select="50 - string-length($title)" />
  (Video Recording) <a onclick="tripleLink(this);" ref="{$ref2}">
    <xsl:attribute name="href">
      <xsl:value-of select="concat('#', $ref)" />
    </xsl:attribute>
    <b>ISRC</b> : <xsl:value-of select="VideoId/ISRC" />
  </a>, &#160;
  <b>Title</b> : <xsl:value-of select="ReferenceTitle/TitleText" />,
  <xsl:for-each select="(//*)[position()&lt;$padding]">&#160;</xsl:for-each>
  <b>Artist</b> : <xsl:value-of select="VideoDetailsByTerritory/DisplayArtist/PartyName/FullName" />&#160;
  <br />
</xsl:template>

<xsl:template name="image">
  <xsl:variable name="ref" select="ResourceReference" />
  <xsl:variable name="ref2" select="//ReleaseList/*/ReleaseReference[../ReleaseDetailsByTerritory/ResourceGroup/ResourceGroupContentItem/ReleaseResourceReference = $ref]" />
  (Image) <a onclick="tripleLink(this);" ref="{$ref2}">
    <xsl:attribute name="href">
      <xsl:value-of select="concat('#', $ref)" />
    </xsl:attribute>
    <b>Id</b> : <xsl:value-of select="ImageId/ProprietaryId" />
  </a>, &#160;
  <b>Title</b> : <xsl:value-of select="Title/TitleText" />
  <br />
</xsl:template>

<xsl:template name="text">
  <xsl:variable name="ref" select="ResourceReference" />
  <xsl:variable name="ref2" select="//ReleaseList/*/ReleaseReference[../ReleaseDetailsByTerritory/ResourceGroup/ResourceGroupContentItem/ReleaseResourceReference = $ref]" />
  <xsl:variable name="title" select="Title/TitleText" />
  <xsl:variable name="padding" select="40 - string-length($title)" />
  (Text)  &#160;<a onclick="tripleLink(this);" ref="{$ref2}">
    <xsl:attribute name="href">
      <xsl:value-of select="concat('#', $ref)" />
    </xsl:attribute>
    <b>Id</b> : <xsl:value-of select="TextId/ProprietaryId" />
  </a>, &#160;
  <b>Title</b> : <xsl:value-of select="Title/TitleText" />,
  <xsl:for-each select="(//*)[position()&lt;$padding]">&#160;</xsl:for-each>
  <b>Artist</b> : <xsl:value-of select="TextDetailsByTerritory[1]/ResourceContributor/PartyName/FullName" />&#160;
  <br />
</xsl:template>

<xsl:template match="Duration">
  <xsl:variable name="stamp" select="substring-after(., 'PT')" />
  <xsl:choose>
    <xsl:when test="contains($stamp, 'H')">
      <xsl:call-template name="extractDuration">
        <xsl:with-param name="h" select="substring-before($stamp, 'H')" />
        <xsl:with-param name="tail" select="substring-after(substring-before($stamp, 'S'), 'H')" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="extractDuration">
        <xsl:with-param name="h" select="false()" />
        <xsl:with-param name="tail" select="substring-before($stamp, 'S')" />
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="extractDuration">
  <xsl:param name="h"/>
  <xsl:param name="tail"/>
  <xsl:variable name="m" select="substring-before($tail, 'M')" />
  <xsl:variable name="s" select="substring-after($tail, 'M')" />
  <xsl:if test="$h" >
    <xsl:value-of select="$h" />h&#160;
  </xsl:if>
  <xsl:value-of select="$m" />min&#160;
  <xsl:value-of select="$s" />s
</xsl:template>

</xsl:stylesheet>
