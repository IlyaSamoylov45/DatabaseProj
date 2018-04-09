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
		<title>Customer Representative Update Query!</title>
	</head>

	<%
		try {
			
			String prev_username = request.getParameter("prev_username");
			String prev_password = request.getParameter("prev_password");
			String prev_firstname = request.getParameter("prev_firstname");
			String prev_lastname = request.getParameter("prev_lastname");
			String prev_address = request.getParameter("prev_address");
			String prev_email = request.getParameter("prev_email");
			
			String password = request.getParameter("Password");
			String firstName = request.getParameter("First_Name");
			String lastName = request.getParameter("Last_Name");
			String email = request.getParameter("Email");
			String address = request.getParameter("Address");
			
			password.trim();
			firstName.trim();
			lastName.trim();
			email.trim();
			address.trim();
			
			boolean badInput = false;
			
			if(firstName.equals("")){
				firstName = prev_firstname;
			}
			if(lastName.equals("")){
				email = prev_lastname;
			}
			if(email.equals("")){
				email = prev_email;
			}
			if(address.equals("")){
				address = prev_address;
			}
			if(password.equals("")){
				password = prev_password;
			}
			// makes sure that no entries go over the 50 character alloted by the program
			if(password.length() > 50 || firstName.length() > 50 || lastName.length() > 50 ||
					email.length() > 50){
				%>
				<script>
					alert("Fields can't be greater than 50 characters. ");
					window.location.href = "CustRepUserInfoChange.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Makes sure that the password is at least 6 characters
			if(password.length() < 6){
				%>
				<script>
					alert("Passwords can't be less than 6 characters.");
					window.location.href = "CustRepUserInfoChange.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Make sure first name is only characters
			if(!firstName.matches("[a-zA-Z]*")){
				%>
				<script>
					alert("First name has to be English");
					window.location.href = "CustRepUserInfoChange.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Make sure last name is only characters
			if(!lastName.matches("[a-zA-Z]*")){
				%>
				<script>
					alert("Last name has to be English");
					window.location.href = "CustRepUserInfoChange.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			//Check for username
			String Update_Temp_Account = "UPDATE Account SET password = ? WHERE username = ?";		
			
			PreparedStatement account_update = con.prepareStatement(Update_Temp_Account);
			account_update.setString(1, password);
			account_update.setString(2, prev_username);
			account_update.executeUpdate();
			
			String Update_Temp_Customer = "UPDATE EndUser SET firstname = ?, lastname = ?, address = ?, email = ? WHERE username = ?";
			
			PreparedStatement EndUser_insert = con.prepareStatement(Update_Temp_Customer);
			EndUser_insert.setString(1, firstName);
			EndUser_insert.setString(2, lastName);
			EndUser_insert.setString(3, address);
			EndUser_insert.setString(4, email);
			EndUser_insert.setString(5, prev_username);
			EndUser_insert.executeUpdate();
			
			account_update.close();
			EndUser_insert.close();
			stmt.close();
			con.close();
			%>
			
			<script>
				alert("End User Updated, Back to Main Menu");
				window.location.href = "CustRepMenu.jsp"			
			</script>
			
			<%
		
		} catch (Exception ex) {
			out.print(ex);
			out.print("Error. Something went wrong going back to updating the End User");
	}
	%>
	<br>
	<a href=CustRepMenu.jsp>Back to the main menu of Customer Representative</a>
</html>