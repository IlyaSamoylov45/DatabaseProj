<%--Author: Ilya Samoylov --%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Change BuyNOW user information!</title>
	</head>
	
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	
	<body>
		<% 
			String prev_username = request.getParameter("username");
			String prev_password = request.getParameter("password");
			String prev_firstname = request.getParameter("firstname");
			String prev_lastname = request.getParameter("lastname");
			String prev_address = request.getParameter("address");
			String prev_email = request.getParameter("email");
		%>
		<center>
			<font size = "13" color = "0e5938" >Update User : <%= prev_username %>!</font>
		</center>
	
		<br>
		<center>
			<form method="post" action="CustRepUserInfoChangeQuery.jsp">
				<table>
				
					<tr>
						<td>Password</td><td><input type="password" name="Password"></td>
					</tr>
					
					<tr>
						<td>First Name</td><td><input type="text" name="First_Name"></td>
					</tr>
					
					<tr>
						<td>Last Name</td><td><input type="text" name="Last_Name"></td>
					</tr>
				
					<tr>    
						<td>Address</td><td><input type="text" name="Address"></td>
					</tr>
					
					<tr>    
						<td>Email</td><td><input type="text" name="Email"></td>
					</tr>
				
				</table>
			
				<input type="hidden" name="prev_username" value="<%= prev_username %>" />
				<input type="hidden" name="prev_password" value="<%= prev_password %>" />
				<input type="hidden" name="prev_firstname" value="<%= prev_firstname %>" />
				<input type="hidden" name="prev_lastname" value="<%= prev_lastname %>" />
				<input type="hidden" name="prev_email" value="<%= prev_email %>" />
				<input type="hidden" name="prev_address" value="<%= prev_address %>" />
				<input id="button" type="submit" value="Change" >
				<input type="reset" value="Reset" />
			</form>
		</center>
		<center>
			<font size = "3" color = red >
			Passwords must be greater than 5 characters.</font>
		</center>
		<br>
		<center>
			<form method="post" action="CustRepUserInfoAll.jsp">
				<input type="submit" value="Back">
			</form>
			<form method="post" action="CustRepMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			<form method="post" action="LogOutCustRep.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>>
	</body>
</html>