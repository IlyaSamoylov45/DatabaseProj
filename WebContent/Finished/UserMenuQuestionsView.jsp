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
		<title>Check your Questions more closely</title>
	</head>
	
		<body>
	<%
	try{
		String questionID = request.getParameter("questionID");
		String question = request.getParameter("question");
		String content = request.getParameter("content");
	%>
		<center>
			<table border="2">
	   			<tr>
	     	   		<td>Question Number</td>
	      	   		<td>Question</td>
	     	   		<td>More Information</td>
	      	   		
	   			</tr>
	   			<tr>
					<td><%=questionID%></td>
					<td><%=question %></td>
					<td><%=content%></td>
				</tr>
			</table>
		
		<%
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();		

		//Check for username
		String answer_check = "SELECT * FROM Answer, Question WHERE Answer.answerID = '" +  questionID + "' AND Question.questionID = '" +  questionID + "'";		
		ResultSet HasAnswer = stmt.executeQuery(answer_check);
	
				 if(HasAnswer.next()){
				 	String answer = HasAnswer.getString("answer");
					String responder = HasAnswer.getString("responder");
	%>
						<font size = "5" color = "0e5938" >Response</font>
						<table border="2">
				   			<tr>
				   				<td>Responder</td>
				      	   		<td>Answer</td>
				   			</tr>	
				   			<tr>
				   				<td><input type="text" value="<%= responder %>" readonly/></td>
								<td><textarea name="content" rows="10" cols="30" readonly><%=answer %></textarea></td>						   
							</tr>
						</table>
   	<%
				 }
				 else{
					 %>
					 
					 <br>
					 <font size = "3" color = red >
						NO ONE HAS ANSWERED THIS YET!
					</font>
				<%
				 }
				 %>
	</center>
	<%
	}catch (Exception ex) {
			out.print("Error. Something went wrong go back to creating a user");
			out.print(ex);
			%>
				<br>
				<a href=UserMenuQuestions.jsp>Back to the Questions</a>
			<%
		}
		%>



		<center>
			
			<br>
			<form method="post" action="UserMenuQuestions.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			
			<br>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Log Out">
			</form>
			
		</center>
	</body>
</html>