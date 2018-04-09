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
		<title>End User Read Message</title>
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
		String reciever = request.getParameter("reciever");
		String dateTime = request.getParameter("dateTime");
		String content = request.getParameter("content");
		String subject = request.getParameter("subject");
	%>
		<center>
		<font size = "5" color = "0e5938" >Mail from: <%=sender %></font>
			<table border="2">
	   			<tr>
	     	   		<td>Sender</td>
	      	   		<td>Date and Time</td>
	      	   		<td>subject</td>
	     	   		<td>content</td>
	      	   		
	   			</tr>
	   			<tr>
					<td><%=sender%></td>
					<td><%=dateTime %></td>
					<td><%=subject %></td>
					<td><textarea name="content" rows="10" cols="30" readonly><%=content %></textarea></td>						   
				</tr>
			</table>
			
			<font size = "5" color = "0e5938" >Response</font>
			<table border="2">
	   			<tr>
	     	   		<td>Subject</td>
	      	   		<td>Content</td>
	   			</tr>
	   			<form method="post" action="UserMenuEmailInboxReadQuery.jsp">
		   			<tr>
							<td><%=subject %></td>
							<td><textarea name="content" rows="10" cols="30"></textarea></td>
		
							<td>
									<input type="hidden" name="reciever" value="<%= sender %>" />
									<input type="hidden" name="sender" value="<%= reciever %>" />
									<input type="hidden" name="subject" value="<%= subject %>" />
					    			<input id="button" type="submit" value="Respond" >	 	
					   		</td>
					   
				   	</tr>
				</form>	
			</table>
		</center>
   	<%
	}catch(Exception e){
		out.print(e);
		response.sendRedirect("LogOutEndUser.jsp");
		
	}
	 %>
		<br>
		<center>
			<form method="post" action="UserMenuEmailInbox.jsp">
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