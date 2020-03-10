<Head>
	<title> View Theater Information </title>
</Head>
<font size="+8">THEATER TABLE:</font> <br> <br>

<cfquery name="viewtheater" datasource="TheatreDatabase" dbtype="ODBC">
select * from Theater
</cfquery>

<Cfoutput query="viewtheater">

Theater Name	: #name# 
Theater Street	: #street#
Theater Max Seats	: #max_seats# <br>
</CFOutput>

<P align=center></p>

<P align=center><A href="http://localhost:8500/CSC434WebDB/SampleWebSite.htm">Back to Home</A></P>






