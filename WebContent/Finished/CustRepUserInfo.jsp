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
		<title>Customer Representative Check User Menu</title>
	</head>
	
	<body>
			<center>
				<font size = "13" color = "0e5938" >BuyNOW User Information! </font>
			</center>
	
		<br>
		<center>
			<font size = "5" color = "0e5938" >View All User Information and Change It!</font>
			<form method="post" action="CustRepUserInfoAll.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<center>
			<font size = "5" color = "0e5938" >Change User Password</font>
			<form method="post" action="CustRepUserInfoChangeOne.jsp">
				<input type="submit" value="Check">
			</form>
		</center>

		<center>
			<br>
			<form method="post" action="CustRepMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOutCustRep.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>