<html>
<head>
<title>Delete Theater</title>
<cfquery name="delete" datasource="TheatreDatabase" dbtype="ODBC">
delete from Theater where name='#name#'
</cfquery>
<Body>
<h1> Theater has been deleted</h1><br>
<P align=center></p>

<P align=center><A href="http://localhost:8500/CSC434WebDB/SampleWebSite.htm">Back to Home</A></P>


</Body>
</html>
