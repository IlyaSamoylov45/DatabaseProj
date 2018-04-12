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
				String email = request.getParameter("Email");
				
				username.trim();
				password.trim();
				firstName.trim();
				lastName.trim();
				email.trim();
				
				boolean badInput = false;
				
				// makes sure that no entries are null
				if(username.equals("") || password.equals("") || firstName.equals("") || lastName.equals("") ||
						email.equals("")){
					%>
					<script>
						alert("Every Field is Mandatory. Try again.");
						window.location.href = "newCustRep.jsp"
					</script>
					<%
					badInput = true;
				}
				
				// makes sure that no entries go over the 50 character alloted by the program
				if(username.length() > 50 || password.length() > 50 || firstName.length() > 50 || lastName.length() > 50 ||
						email.length() > 50){
					%>
					<script>
						alert("Fields can't be greater than 50 characters. ");
						window.location.href = "newCustRep.jsp"
					</script>
					<%
					badInput = true;
				}
				
				//Makes sure that the password is at least 6 characters
				if(password.length() < 6){
					%>
					<script>
						alert("Passwords can't be less than 6 characters.");
						window.location.href = "newCustRep.jsp"
					</script>
					<%
					badInput = true;
				}
				
				//Make sure first name is only characters
				if(!firstName.matches("[a-zA-Z]*")){
					%>
					<script>
						alert("First name has to be English");
						window.location.href = "newCustRep.jsp"
					</script>
					<%
					badInput = true;
				}
				
				//Make sure last name is only characters
				if(!lastName.matches("[a-zA-Z]*")){
					%>
					<script>
						alert("Last name has to be English");
						window.location.href = "newCustRep.jsp"
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
					String temp = "SELECT * FROM Account WHERE BINARY username = BINARY '" + username + "'";		
					ResultSet result = stmt.executeQuery(temp);
					if(!result.next()){
						String insert_Account = "INSERT INTO Account(username, password)"
								+ " VALUES(?, ?)";
						String insert_CustRep = "INSERT INTO Cust_Representative(username, firstname, lastname, email)"
								+ " VALUES(?, ?, ?, ?)";
									
						PreparedStatement account_insert = con.prepareStatement(insert_Account);
						account_insert.setString(1, username);
						account_insert.setString(2, password);
						
						//Run the query against the DB
						account_insert.executeUpdate();
						
						PreparedStatement CustRep_insert = con.prepareStatement(insert_CustRep);
						CustRep_insert.setString(1, username);
						CustRep_insert.setString(2, firstName);
						CustRep_insert.setString(3, lastName);
						CustRep_insert.setString(4, email);
						
						CustRep_insert.executeUpdate();
						
						result.close();
						stmt.close();
						con.close();
					}
					else{
						result.close();
						stmt.close();
						con.close();
						%>
						<script>
							alert("Username already exists. Either as a Representative or a Customer");
							window.location.href = "newCustRep.jsp"
						</script>
						<%
						
					}
				}
				
				%>
				<script>
					alert("New Customer Representative Created");
					window.location.href = "AdminMenu.jsp"
				</script>
				<%
			} catch (Exception ex) {
				out.print(ex);
				out.print("Error. Something went wrong go back to creating a Customer Rep");
			}
			%>
			<br>
			<a href=newCustRep.jsp>Back to the main site</a>
	</body>
</html>