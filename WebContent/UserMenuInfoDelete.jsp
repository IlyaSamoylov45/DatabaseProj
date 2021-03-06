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
			String username = (String)session.getAttribute("userName");

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
		
			//Check for username
			String temp = "DELETE FROM `Account` WHERE BINARY `username` = BINARY ?";		
			
			PreparedStatement ps = con.prepareStatement(temp);
			ps.setString(1, username);

			ps.executeUpdate();
			ps.close();
			stmt.close();
			con.close();
				%>
				
			<script>
				alert(" User: <%=username%> Deleted");
				window.location.href = "Login.jsp"
			</script>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong Deleting");
			out.print(ex);
		}
		%>
		<br>
		<a href=UserMenu.jsp>Back to the user menu</a>
	</body>
</html>