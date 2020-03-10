<html>
<head>
<title>Update Theater Record</title>
<cfquery name="update" datasource="TheatreDatabase" dbtype="ODBC">
update Theater set name='#name#', street='#street#', max_seats='#max_seats#' 
where name='#name#'
</cfquery>
<Body>
<h1> Theater Record has been updated</h1><br>
<P align=center></p>

<P align=center><A href="http://localhost:8500/CSC434WebDB/SampleWebSite.htm">Back to Home</A></P>


</Body>
</html>
