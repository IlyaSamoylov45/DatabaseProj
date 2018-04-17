<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Send a message to specific user!</title>
	</head>
	<body>
	<%
		try {
			int questionID =  Integer.parseInt(request.getParameter("questionID"));
			String responder = request.getParameter("responder");
			String answer = request.getParameter("answer");
			
			responder.trim();
			answer.trim();
			
			boolean badInput = false;
			
			// makes sure that no entries are null
			if(responder.equals("") || answer.equals("")) {%>
				<script>
					alert("Every Field is Mandatory. Try again.");
					window.location.href = "CustRepQuestions.jsp"
				</script>
				<%
				badInput = true;
			}
			
			// makes sure that no entries go over the 50 character alloted by the program
			if(responder.length() > 50){
				%>
				<script>
					alert("responder can't be greater than 50 characters.");
					window.location.href = "CustRepQuestions.jsp"
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
				String temp = "SELECT * FROM Answer, Question WHERE Question.questionID = '" + questionID + "' AND Answer.answerID = '" + questionID + "'";		
				ResultSet result = stmt.executeQuery(temp);
					
				if(!result.next()){
					
				    String send_Email="INSERT INTO `Answer`(`answerID`, `responder`, `answer`) VALUES (?, ?, ?)";			
				    
					PreparedStatement send_email_ps = con.prepareStatement(send_Email);
					
					send_email_ps.setInt(1, questionID);
					send_email_ps.setString(2, responder);
					send_email_ps.setString(3, answer);
					
					send_email_ps.executeUpdate();
					//close connections
					send_email_ps.close();
					stmt.close();
					con.close();
				}
				else{
					result.close();
					stmt.close();
					con.close();
					%>
					<script>
						alert("Question was already answered.");
						window.location.href = "CustRepQuestions.jsp"
					</script>
					<%
				}
			}
			%>		

			<script>
				alert("Question answered successfully ");
				window.location.href = "CustRepQuestions.jsp"
			</script>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong sending the message");
			out.print(ex);
		}
		%>
		<br>
		<a href=CustRepQuestions.jsp>Back writing message</a>
	</body>
</html>