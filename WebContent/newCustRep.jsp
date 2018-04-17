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
		<title>Create Customer Representative!</title>
	</head>
	
	<body>
		<center>
			<font size = "13" color = "0e5938" >Create a new Customer Representative </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Create Customer Representative</font>
			<form method="post" action="newCustRepQuery.jsp">
				<table>
					<tr>    
						<td>User name: </td><td><input type="text" name="Username"></td>
					</tr>
					<tr>
						<td>Password: </td><td><input type="password" name="Password"></td>
					</tr>
					<tr>    
						<td>First Name: </td><td><input type="text" name="First_Name"></td>
					</tr>
					<tr>
						<td>Last Name: </td><td><input type="text" name=Last_Name></td>
					</tr>
					<tr>
						<td>Email: </td><td><input type="text" name="Email"></td>
					</tr>
				</table>
				<input type="submit" value="Create">
				<input type="reset" value="Reset" />
			</form>
		</center>
		
		<br>
		<center>
			<font size = "3" color = red >
				Note all fields are required!! 
				<br> 	
				Passwords must be greater than 5 characters.
			</font>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Want to Cancel?
			</font>
			<center>
			<form method="post" action="AdminUsersInformationMenu.jsp">
				<input type="submit" value="Back">
			</form>
			<form method="post" action="AdminMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
		</center>>
	</body>
</html>