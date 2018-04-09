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
			<font size = "5" color = "0e5938" >Create Customer Representative!</font>
			<form method="post" action="newCustRep.jsp">
				<input type="submit" value="Create">
			</form>
		</center>
		<center>
			<font size = "5" color = "0e5938" >See all Customer Representatives!</font>
			<form method="post" action="AdminUsersInformationMenuAllCustomerRepresentatives.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Create A New User!</font>
			<form method="post" action="AdminUsersInformationMenuNewUser.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
			<font size = "5" color = "0e5938" >See all Users!</font>
			<form method="post" action="AdminUsersInformationMenuAllUsers.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
		
			<br>
			<form method="post" action="AdminMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOutAdmin.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>