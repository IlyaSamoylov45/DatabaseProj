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
		<title>BuyNOW Search for User</title>
	</head>
	
	<body>
		<center>
			<font size = "13" color = "0e5938" >Search For User!</font>
		</center>
	
		<br>
		<center>
			<font size = "5" color = "0e5938" >User Login</font>
			<form method="post" action="CustRepUserInfoChangeOneQuery.jsp">
				<table>
					<tr>    
						<td>User name: </td><td><input type="text" name="Username"></td>
					</tr>
				</table>
				<input type="submit" value="Search">
				<input type="reset" value="Reset" />
			</form>
		</center>
		<center>
		<form method="post" action="CustRepUserInfo.jsp">
			<input type="submit" value="Back">
		</form>
		<form method="post" action="CustRepMenu.jsp">
			<input type="submit" value="Main Menu">
		</form>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Logout">
		</form>
		</center>>
	</body>
</html>