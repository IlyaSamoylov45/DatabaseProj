<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Representative Read Message</title>
	</head>

	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	<body>
	<%
	try{
		String sender = request.getParameter("sender");
		String receiver = request.getParameter("reciever");
		String dateTime = request.getParameter("dateTime");
		String content = request.getParameter("content");
		String subject = request.getParameter("subject");
	%>
		<center>
		<font size = "5" color = "0e5938" >Mail from: <%=sender %> to: <%= receiver %></font>
			<table border="2">
	   			<tr>
	     	   		<td>Sender</td>
	     	   		<td>Receiver</td>
	      	   		<td>Date and Time</td>
	      	   		<td>subject</td>
	     	   		<td>content</td>
	      	   		
	   			</tr>
	   			<tr>
					<td><%=sender%></td>
					<td><%=receiver%></td>
					<td><%=dateTime %></td>
					<td><%=subject %></td>
					<td><%=content%></td>
				</tr>
			</table>
		</center>
   	<%
	}catch(Exception e){
		out.print(e);
		%>		

		<script>
			alert("Something went wrong");
			window.location.href = "AdminMiscellaneousEmails.jsp"
		</script>
		
		<%
		
	}
	 %>
		<br>
		<center>
			<form method="post" action="AdminMiscellaneousEmails.jsp">
				<input type="submit" value="Back">
			</form>
			<form method="post" action="AdminMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
	</body>
</html>