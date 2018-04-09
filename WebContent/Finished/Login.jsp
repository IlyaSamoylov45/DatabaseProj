<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>BuyNOW</title>
	</head>
	
		<body>

			<center>
				<font size = "13" color = "0e5938" >Welcome to BuyNOW The Auction House!</font>
			</center>
			<br>
			<center>
				<font size = "5" color = "0e5938" >User Login</font>
				<form method="post" action="LoginQuery.jsp">
					<table>
						<tr>    
							<td>User name: </td><td><input type="text" name="Username"></td>
						</tr>
						<tr>
							<td>Password: </td><td><input type="password" name="Password"></td>
						</tr>
					</table>
					<input type="submit" value="Login">
					<input type="reset" value="Reset" />
					</form>
			</center>
			<center>
				<br>
					<font size = "5" color = "0e5938" >New User? Click Here!</font>
					<form method="post" action="newUser.jsp">
						<input type="submit" value="Create">
					</form>
			</center>
		</body>
</html>