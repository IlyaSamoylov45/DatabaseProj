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
	<body>
	<%
		try {
			String username = request.getParameter("Username");
			String password = request.getParameter("Password");
			String firstName = request.getParameter("First_Name");
			String lastName = request.getParameter("Last_Name");
			String address = request.getParameter("Address");
			String email = request.getParameter("Email");
			
			username.trim();
			password.trim();
			firstName.trim();
			lastName.trim();
			address.trim();
			email.trim();
			
			boolean badInput = false;
			
			// makes sure that no entries are null
			if(username.equals("") || password.equals("") || firstName.equals("") || lastName.equals("") || address.equals("") ||
					email.equals("")){
				%>
				<script>
					alert("Every Field is Mandatory. Try again.");
					window.location.href = "AdminUsersInformationMenuNewUser.jsp"
				</script>
				<%
				badInput = true;
			}
			
			// makes sure that no entries go over the 50 character alloted by the program
			if(username.length() > 50 || password.length() > 50 || firstName.length() > 50 || lastName.length() > 50 || address.length() > 50 ||
					email.length() > 50){
				%>
				<script>
					alert("Fields can't be greater than 50 characters. ");
					window.location.href = "AdminUsersInformationMenuNewUser.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Makes sure that the password is at least 6 characters
			if(password.length() < 6){
				%>
				<script>
					alert("Passwords can't be less than 6 characters.");
					window.location.href = "AdminUsersInformationMenuNewUser.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Make sure first name is only characters
			if(!firstName.matches("[a-zA-Z]*")){
				%>
				<script>
					alert("First name has to be English");
					window.location.href = "AdminUsersInformationMenuNewUser.jsp"
				</script>
				<%
				badInput = true;
			}
			
			//Make sure last name is only characters
			if(!lastName.matches("[a-zA-Z]*")){
				%>
				<script>
					alert("Last name has to be English");
					window.location.href = "AdminUsersInformationMenuNewUser.jsp"
				</script>
				<%
				badInput = true;
			}
			if(!badInput){
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();

				//Create a SQL statement
				Statement stmt = con.createStatement();		
			
				//Check for username
				String temp = "SELECT * FROM Account WHERE BINARY username = BINARY'" + username + "'";		
				ResultSet result = stmt.executeQuery(temp);
					
				if(!result.next()){
					String insert_Account = "INSERT INTO Account(username, password)"
							+ " VALUES(?, ?)";
					String insert_EndUser = "INSERT INTO EndUser(username, firstname, lastname, address, email)"
							+ " VALUES(?, ?, ?, ?, ?)";
							
					PreparedStatement account_insert = con.prepareStatement(insert_Account);
					account_insert.setString(1, username);
					account_insert.setString(2, password);
				
					//Run the query against the DB
					account_insert.executeUpdate();
				
					PreparedStatement EndUser_insert = con.prepareStatement(insert_EndUser);
					EndUser_insert.setString(1, username);
					EndUser_insert.setString(2, firstName);
					EndUser_insert.setString(3, lastName);
					EndUser_insert.setString(4, address);
					EndUser_insert.setString(5, email);
				
					EndUser_insert.executeUpdate();
					//close connections
					account_insert.close();
					EndUser_insert.close();
				}
				else{
					result.close();
					stmt.close();
					con.close();
					%>
					<script>
						alert("Username already exists.");
						window.location.href = "AdminUsersInformationMenuNewUser.jsp"
					</script>
					<%
				
				}
			}
			%>		

			<script>
				alert("New User Created");
				window.location.href = "AdminUsersInformationMenu.jsp"
			</script>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong go back to creating a user");
			out.print(ex);
		}
		%>
		<br>
		<a href=AdminUsersInformationMenuNewUser.jsp>Back to the creating user</a>
	</body>
</html>