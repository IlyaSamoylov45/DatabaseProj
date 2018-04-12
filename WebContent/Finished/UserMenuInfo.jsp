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
		<title>User Information</title>
	</head>
	
	<body>
			<center>
				<font size = "13" color = "0e5938" >BuyNOW User Information! </font>
			</center>
	
		<br>
		<center>
			<font size = "5" color = "0e5938" >Delete your account!</font>
			<form method="post" action="UserMenuInfoDelete.jsp">
				<input type="submit" value="Delete">
			</form>
		</center>

		<center>
			<font size = "5" color = "0e5938" >Ask for your User Information to be changed</font>
			<form method="post" action="UserMenuInfoChange.jsp">
				<input type="submit" value="Ask">
			</form>
		</center>

		<center>
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Back">
			</form>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>