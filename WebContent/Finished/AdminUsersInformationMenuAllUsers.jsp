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
	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>All BuyNOW users!</title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >All BuyNOW Users and their Information! </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Information</font>
			<table border="2">
   			<tr>
       			<td>User name</td>
        		<td>Password</td>
       			<td>First Name</td>
        		<td>Last Name</td>
        		<td>Address</td>
       	 		<td>Email</td>
   			</tr>
   			<%
   				try{
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT Account.username, Account.password, EndUser.firstname, EndUser.lastname, EndUser.address, EndUser.email FROM Account INNER JOIN EndUser ON Account.username = EndUser.username";		
					ResultSet All_Users = stmt.executeQuery(temp);
				
       				while(All_Users.next()){
    	  				 String username = All_Users.getString("username");
    	  				 String password = All_Users.getString("password");
    	   				 String firstname = All_Users.getString("firstname");
    	   				 String lastname = All_Users.getString("lastname");
    	   				 String email = All_Users.getString("email");
    	   				 String address = All_Users.getString("address");
			
   			%>
           			 <tr>
            			<td><%=username%></td>
						<td><%=password %></td>
						<td><%=firstname %></td>
						<td><%=lastname%></td>
						<td><%=email %></td>
						<td><%=address %></td>
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			All_Users.close();
   			stmt.close();
			con.close();
   }catch(Exception ex){
		ex.printStackTrace();
	}
    %>
	</center>

	<br>
	<center>
		<form method="post" action="AdminUsersInformationMenu.jsp">
			<input type="submit" value="Back">
		</form>
	</center>
	
	<br>
	<center>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Log Out">
		</form>
	</center>
	</body>
</html>