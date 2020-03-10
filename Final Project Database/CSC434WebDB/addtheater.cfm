<cfquery name="addtheater" datasource="TheatreDatabase" dbtype="ODBC" username="root" password="LusherCharter2016">

insert into Theater values('#name#','#street#','#max_seats#')
</cfquery>


<Head>
	<title> Add Theater </title>
</Head>
<Body>
<h1> Theater has been added</h1><br>
<P align=center></p>

<P align=center><A href="http://localhost:8500/CSC434WebDB/SampleWebSite.htm">Back to Home</A></P>


</Body>
</html>


