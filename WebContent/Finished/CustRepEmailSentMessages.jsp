<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	<%
	String firstname = (String)session.getAttribute("firstName");
	String lastname = (String)session.getAttribute("lastName");
	String username = (String)session.getAttribute("userName");
	%>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title><%=firstname %>, <%=lastname %>'s Sent Inbox></title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >The Emails you have sent: <%=username %>! </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Information</font>
			<table border="2">
   			<tr>
       			<td>Receiver</td>
        		<td>Date Sent</td>
        		<td>Subject</td>
        		<td>Content</td>
   			</tr>
   			<%
   				try{
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT * FROM Email WHERE BINARY Email.from = BINARY '"+ username +"'";		
					ResultSet All_emails = stmt.executeQuery(temp);
				
       				while(All_emails.next()){
    	  				 String reciever = All_emails.getString("to");
    	   				 String dateTime = All_emails.getString("dateTime");
    	   				 String content = All_emails.getString("content");
    	  				 String subject = All_emails.getString("subject");
			
   			%>
           			 <tr>
            			<td><%=reciever%></td>
						<td><%=dateTime %></td>
						<td><%=subject %></td>
						<td><textarea name="content" rows="10" cols="30" readonly><%=content %></textarea></td>						   
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			All_emails.close();
   			stmt.close();
			con.close();
   }catch(Exception e){
		e.printStackTrace();
	}
    %>
	</center>

	<br>
	<center>
		<br>
		<form method="post" action="CustRepEmail.jsp">
			<input type="submit" value="Back">
		</form>
		
		<br>
		<form method="post" action="CustRepMenu.jsp">
			<input type="submit" value="Main Menu">
		</form>
		
		<br>
		<form method="post" action="LogOutCustRep.jsp">
			<input type="submit" value="Log Out">
		</form>
	</center>
	</body>
</html>