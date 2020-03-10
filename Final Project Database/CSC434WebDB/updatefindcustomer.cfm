<cfquery name="findtheaterquery" datasource="TheatreDatabase" dbtype="ODBC">

select * from Theater where name='#name#'

</cfquery>



<Head>
	<title> Theatre Database </title>
</Head>
<Body>

<font size="+8">Updating Theater Record:</font> <br> <br>




<cfif findtheaterquery.RecordCount gt 0>

<Cfoutput query="findtheaterquery">

<FORM action=http://localhost:8500/CSC434WebDB/updateupdatetheater.cfm method=post> 



Theater Name:

<input name=theater_name type=text value=#name#>


Theater Street:

<input name=theater_street type=text value=#street#>


Theater Max Capacity:

<input name=theater_max_seats type=text value=#max_seats#>

<br><br>
<input name=submit type=submit value="Update Theater Record">


</form>


</cfoutput>

<cfelse>


<font size="+6"> Theater Does not Exist </font>

</cfif>





</Body>
</html>

