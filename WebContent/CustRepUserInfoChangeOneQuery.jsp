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
   		String temp_username = request.getParameter("Username");
  		 try{
	 		//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
				
			//Check for username
			String temp = "SELECT Account.username, Account.password, EndUser.firstname, EndUser.lastname, EndUser.address, EndUser.email FROM Account INNER JOIN EndUser ON Account.username = EndUser.username AND EndUser.username = '" +  temp_username + "'";		
			ResultSet User_result = stmt.executeQuery(temp);
			
			if(!User_result.next()){
		%>
				<script>
				alert("User Does not Exist");		
				window.location.href = "CustRepUserInfoChangeOne.jsp"
				</script>
		<%
			}else{
		%>
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
		       	   		<td>View User</td>
		   			</tr>
	  		 <%
    	   	 	String username = User_result.getString("username");
    	    	String password = User_result.getString("password");
    	    	String firstname = User_result.getString("firstname");
    	    	String lastname = User_result.getString("lastname");
    	    	String email = User_result.getString("email");
    	    	String address = User_result.getString("address");
			%>
            		<tr>
            			<td><%=username%></td>
						<td><%=password %></td>
						<td><%=firstname %></td>
						<td><%=lastname%></td>
						<td><%=email %></td>
						<td><%=address %></td>
						<td>
							<form method="post" action="CustRepUserInfoChange.jsp">
								<input type="hidden" name="username" value="<%= username %>" />
								<input type="hidden" name="password" value="<%= password %>" />
								<input type="hidden" name="firstname" value="<%= firstname %>" />
								<input type="hidden" name="lastname" value="<%= lastname %>" />
								<input type="hidden" name="email" value="<%= email %>" />
								<input type="hidden" name="address" value="<%= address %>" />
					    		<input id="button" type="submit" value="View" >
					   		 </form>
					   	</td>
					</tr>
   				</table>
  		</center>
  		 <%
			}
   			User_result.close();
   			stmt.close();
			con.close();
   	}catch(Exception ex){
		out.print(ex);
   		ex.printStackTrace();
}   
   %>
   <center>
		<form method="post" action="CustRepUserInfoChangeOne.jsp">
			<input type="submit" value="Back">
		</form>
		<form method="post" action="CustRepMenu.jsp">
			<input type="submit" value="Main Menu">
		</form>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Logout">
		</form>
	</center>
</html>