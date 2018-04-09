<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.text.SimpleDateFormat" %>  

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	
	<body>
		<%
		
		String sender = request.getParameter("sender");
		String reciever = request.getParameter("reciever");
		String content = request.getParameter("content");
		String subject = request.getParameter("subject");
	    java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
		
		try{
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			String maxID = "SELECT MAX(messageID) FROM Email";
			ResultSet check_maxID = stmt.executeQuery(maxID);
			int new_ID;
			
		    if(check_maxID.next()){
		    	new_ID = check_maxID.getInt(1)+1;
		    }
		    else{
		    	new_ID = 1;
		    }
		    String send_Email="INSERT INTO `Email`(`messageID`, `from`, `to`, `dateTime`, `content`, `subject`) VALUES (?, ?, ?, ?, ?, ?)";			
		    
			PreparedStatement email_insert = con.prepareStatement(send_Email);
	
			email_insert.setInt(1, new_ID);
			email_insert.setString(2, sender);
			email_insert.setString(3, reciever);
			email_insert.setDate(4, sqlDate);
			email_insert.setString(5, content);
			email_insert.setString(6, subject);
			
			//Run the query against the DB
			email_insert.executeUpdate();
			
			
			%>
			<script>
				alert("Email sent to: <%=reciever%>, go back to Email Inbox");
				window.location.href = "UserMenuEmailInbox.jsp"
			</script>
			<%
		}catch(Exception ex){
			out.print(ex);
			out.print("Error. Something went wrong going back to updating the customer representative");
		}
		%>
		<br>
		<a href=EndUserMenu.jsp>Back to the main menu of Customer Representative</a>
	</body>
</html>