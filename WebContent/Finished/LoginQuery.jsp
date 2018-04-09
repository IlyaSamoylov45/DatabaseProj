<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<html>
	<style>
		body {
		background-color: #97a08d;
	}
	</style>
<%
	try {
		//Get parameters from the HTML form at the Login.jsp
		String username = request.getParameter("Username");
		String password = request.getParameter("Password");
		
		if(username.equals("") || password.equals("")){
			%>
			<script>
				alert("Login and Password fields are mandatory!");
				window.location.href = "Login.jsp"
			</script>
			<%
		}
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();		
		
		//Check for username
		String temp1 = "SELECT * FROM Account WHERE BINARY username = BINARY '" + username + "' AND BINARY password = BINARY '" + password + "'";		
		ResultSet Account_search = stmt.executeQuery(temp1);
		if(!Account_search.next()){
			Account_search.close();
			stmt.close();
			con.close();
			%>
			<script>
				alert("Username either does not exist, or the password is wrong");
				window.location.href = "Login.jsp"
			</script>
			<%
					
		}
		String temp2 = "SELECT * FROM Administrator WHERE BINARY username = '" + username + "'";
		//Run the query against the database.
		ResultSet Admin_result = stmt.executeQuery(temp2);
		if(Admin_result.next()){
			String userName = Admin_result.getString("username");
			session.setAttribute("userName", userName);
			
			Account_search.close();
			Admin_result.close();
			stmt.close();
			con.close();
			
			response.sendRedirect("AdminMenu.jsp");		
		}
		String temp3 = "SELECT * FROM EndUser WHERE BINARY username = BINARY '" + username + "'";
		//Run the query against the database.
		ResultSet EndUser_result = stmt.executeQuery(temp3);
		if(EndUser_result.next()){
			String firstName = EndUser_result.getString("firstname");
			String lastName = EndUser_result.getString("lastname");
			String email = EndUser_result.getString("email");
			String userName = EndUser_result.getString("username");
			String address = EndUser_result.getString("address");
			
			session.setAttribute("firstName", firstName);
			session.setAttribute("lastName", lastName);
			session.setAttribute("email", email);
			session.setAttribute("userName", userName);
			session.setAttribute("address", address);
			
			Account_search.close();
			Admin_result.close();
			EndUser_result.close();
			stmt.close();
			con.close();
			
			response.sendRedirect("UserMenu.jsp");	
		}
		String temp4 = "SELECT * FROM Cust_Representative WHERE BINARY username = BINARY '"  + username + "'";
		//Run the query against the database.
		ResultSet CustRep_result = stmt.executeQuery(temp4);
		if(CustRep_result.next()){
			String firstName = CustRep_result.getString("firstname");
			String lastName = CustRep_result.getString("lastname");
			String email = CustRep_result.getString("email");
			String userName = CustRep_result.getString("username");
			
			session.setAttribute("firstName", firstName);
			session.setAttribute("lastName", lastName);
			session.setAttribute("email", email);
			session.setAttribute("userName", userName);
			
			Account_search.close();
			Admin_result.close();
			EndUser_result.close();
			CustRep_result.close();
			stmt.close();
			con.close();
			
			response.sendRedirect("CustRepMenu.jsp");	
		}
			%>
			<script>
				alert("Something went wrong!");
			</script>
			<%
			Account_search.close();
			Admin_result.close();
			EndUser_result.close();
			CustRep_result.close();
			stmt.close();
			con.close();
			response.sendRedirect("Login.jsp");	
	} catch (Exception ex) {
		out.print("Error. Something went Wrong");
		out.print(ex);
	}
	%>
	<a href="Login.jsp">Login Page</a>
</html>