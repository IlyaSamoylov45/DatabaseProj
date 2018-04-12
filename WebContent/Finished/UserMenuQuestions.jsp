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
		<title>User Questions!</title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >All Questions You Have Asked! </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Information</font>
			<table border="2">
   			<tr>
       			<td>Question ID</td>
        		<td>Sender</td>
       			<td>Question</td>        		
   			</tr>
   			<%
   				try{
   					String username = (String)session.getAttribute("userName");
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT * FROM Question WHERE BINARY Question.sender = BINARY '" + username + "'";		
					ResultSet All_Questions = stmt.executeQuery(temp);
				
       				while(All_Questions.next()){
    	  				 String questionID = All_Questions.getString("questionID");
    	  				 String sender = All_Questions.getString("sender");
    	   				 String question = All_Questions.getString("question");
    	   				 String content = All_Questions.getString("content");
   			%>
           			 <tr>
            			<td><%=questionID%></td>
						<td><%=question %></td>
						<td>
							<form method="post" action="UserMenuQuestionsView.jsp">
								<input type="hidden" name="questionID" value="<%= questionID %>" />
								<input type="hidden" name="sender" value="<%= sender %>" />
								<input type="hidden" name="question" value="<%= question %>" />
								<input type="hidden" name="content" value="<%= content %>" />
				   				<input id="button" type="submit" value="View" >
				   			 </form>
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			All_Questions.close();
   			stmt.close();
			con.close();
   }catch(Exception e){
		e.printStackTrace();
	}
    %>
	</center>

	<br>
	<center>
		<form method="post" action="UserMenu.jsp">
			<input type="submit" value="Back">
		</form>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Log Out">
		</form>
		
	</center>
	</body>
</html>