<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
		<style>
			body {
				background-color: #97a08d;
			}
		</style>
	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>User Send Mail</title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >Send an Email </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Email  Information</font>
			<form method="post" action="UserMenuEmailSendQuery.jsp">
				<table>
					<tr>    
						<td>To user: </td><td><input type="text" name="reciever"></td>
					</tr>
					<tr>
						<td>Subject: </td><td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>Content: </td><td><textarea name="content" rows="10" cols="30"></textarea></td>
					</tr>
				</table>
				<input type="submit" value="Send">
				<input type="reset" value="Reset" />
			</form>
		</center>
		
		<br>
		<center>
			<font size = "3" color = red >
				Note all fields are required!! 
			</font>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Want to Cancel?
			</font>
			<form method="post" action="UserMenuEmail.jsp">
				<input type="submit" value="Back">
			</form>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			<form method="post" action="LogOutEndUser.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
	</body>
</html>