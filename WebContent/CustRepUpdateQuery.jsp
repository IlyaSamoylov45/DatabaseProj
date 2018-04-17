<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	try {
		String firstName_prev = (String)session.getAttribute("firstName");
		String lastName_prev = (String)session.getAttribute("lastName");
		String email_prev = (String)session.getAttribute("email");
		String username = (String)session.getAttribute("userName");
			
		String password = request.getParameter("Password");
		String firstName = request.getParameter("First_Name");
		String lastName = request.getParameter("Last_Name");
		String email = request.getParameter("Email");
			
		password.trim();
		firstName.trim();
		lastName.trim();
		email.trim();
		
		if(firstName.equals("")){
			firstName = firstName_prev;
		}
		if(lastName.equals("")){
			email = lastName_prev;
		}
		if(email.equals("")){
			email = email_prev;
		}

		// makes sure that no entries go over the 50 character alloted by the program
		if(password.length() > 50 || firstName.length() > 50 || lastName.length() > 50 || email.length() > 50){
			%>
			<script>
				alert("Fields can't be greater than 50 characters. ");
				window.location.href = "CustRepUpdate.jsp"
			</script>
			<%
			}
			
			//Makes sure that the password is at least 6 characters
			if(password.length() < 6){
				%>
				<script>
					alert("Passwords can't be less than 6 characters.");
					window.location.href = "CustRepUpdate.jsp"
				</script>
				<%
			}
			
			//Make sure first name is only characters
			if(!firstName.matches("[a-zA-Z]*")){
				%>
				<script>
					alert("First name has to be English");
					window.location.href = "CustRepUpdate.jsp"
				</script>
				<%
			}
			
			//Make sure last name is only characters
			if(!lastName.matches("[a-zA-Z]*")){
				%>
				<script>
					alert("Last name has to be English");
					window.location.href = "CustRepUpdate.jsp"
				</script>
				<%
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
			account_update.setString(2, username);
			account_update.executeUpdate();
			
			String Update_Temp_Customer = "UPDATE Cust_Representative SET firstname = ?, lastname = ?, email = ? WHERE username = ?";
			
			PreparedStatement CustRep_insert = con.prepareStatement(Update_Temp_Customer);
			CustRep_insert.setString(1, firstName);
			CustRep_insert.setString(2, lastName);
			CustRep_insert.setString(3, email);
			CustRep_insert.setString(4, username);
			CustRep_insert.executeUpdate();
			
			account_update.close();
			CustRep_insert.close();
			stmt.close();
			con.close();
			%>
			
			<script>
				alert("Customer Representative Updated, Back to Main Menu");
				<%
					session.setAttribute("firstName", firstName);
					session.setAttribute("lastName", lastName);
					session.setAttribute("email", email);
				%>
				window.location.href = "CustRepMenu.jsp"	
			</script>
			
		<%	
		} catch (Exception ex) {
			out.print(ex);
			out.print("Error. Something went wrong going back to updating the customer representative");
		}
		%>
		
	<br>
	<a href=CustRepMenu.jsp>Back to the main menu of Customer Representative</a>
</html>