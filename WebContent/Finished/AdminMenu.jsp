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
		<title>Administrator Main Menu</title>
	</head>
	
	<body>
		<center>
				<font size = "13" color = "0e5938" >Welcome to BuyNOW Administrator !</font>
		</center>
		<br>
		<center>
			<font size = "5" color = "0e5938" >Look at User Information!</font>
			<form method="post" action="AdminUsersInformationMenu.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Look At Email's and Questions!</font>
			<form method="post" action="AdminMiscellaneous.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
			<br>
			<form method="post" action="LogOutAdmin.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>