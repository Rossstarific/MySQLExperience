<cfquery name="findtheater" datasource="TheatreDatabase" dbtype="ODBC">

select * from Theater where name='#name#'

</cfquery>



<Head>
	<title> Theatre Database </title>
</Head>
<Body>

<font size="+8">Find Theater Record:</font> <br> <br>




<cfif findtheater.RecordCount gt 0>

<Cfoutput query="findtheater">




Theater Name:

<input name=name type=text value="#name#">


Theater Street:

<input name=street type=text value="#street#">


Theater Max Capacity:

<input name=max_seats type=text value="#max_seats#">

<br><br>


</cfoutput>

<cfelse>


<font size="+6"> Theater Does not Exist </font>

</cfif>





<P align=center></p>

<P align=center><A href="http://localhost:8500/CSC434WebDB/SampleWebSite.htm">Back to Home</A></P>



</Body>
</html>

