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
			<font size = "13" color = "0e5938" >All BuyNOW Customer Representatives and their Information! </font>
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
					String temp = "SELECT Account.username, Account.password, Cust_Representative.firstname, Cust_Representative.lastname, Cust_Representative.email FROM Account INNER JOIN Cust_Representative ON Account.username = Cust_Representative.username";		
					ResultSet All_Cust_Representative = stmt.executeQuery(temp);
				
       				while(All_Cust_Representative.next()){
    	  				 String username = All_Cust_Representative.getString("username");
    	  				 String password = All_Cust_Representative.getString("password");
    	   				 String firstname = All_Cust_Representative.getString("firstname");
    	   				 String lastname = All_Cust_Representative.getString("lastname");
    	   				 String email = All_Cust_Representative.getString("email");
			
   			%>
           			 <tr>
            			<td><%=username%></td>
						<td><%=password %></td>
						<td><%=firstname %></td>
						<td><%=lastname%></td>
						<td><%=email %></td>
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			All_Cust_Representative.close();
   			stmt.close();
			con.close();
   }catch(Exception ex){
	   out.print(ex);
	   out.print("Error. Something went wrong going backtrying to view the customer representatives");
	
	}
    %>
	</center>

	<br>
	<center>
		<form method="post" action="AdminUsersInformationMenu.jsp">
			<input type="submit" value="Back">
		</form>
		<form method="post" action="AdminMenu.jsp">
			<input type="submit" value="Main Menu">
		</form>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Logout">
		</form>
	</center>
	</body>
</html>