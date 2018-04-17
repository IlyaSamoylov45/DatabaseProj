<%--Author: Ilya Samoylov --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Administrator Look at Emails and Questions</title>
	</head>
	
	<body>
		<center>
				<font size = "13" color = "0e5938" >Email's and Questions</font>
		</center>
		<br>
		<center>
			<font size = "5" color = "0e5938" >Email's</font>
			<form method="post" action="AdminMiscellaneousEmails.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Questions!</font>
			<form method="post" action="AdminMiscellaneousQuestions.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
		
			<br>
			<form method="post" action="AdminMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>