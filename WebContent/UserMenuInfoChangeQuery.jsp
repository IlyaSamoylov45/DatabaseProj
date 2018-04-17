<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<body>
	<%
		try {
			String question = request.getParameter("subject");
			String content = request.getParameter("content");
			String username = (String)session.getAttribute("userName");

			content.trim();
			question.trim();

			boolean badInput = false;
			
			// makes sure that no entries are null
			if(content.equals("") || question.equals("")) {%>
				<script>
					alert("Every Field is Mandatory. Try again.");
					window.location.href = "UserMenuInfoChange.jsp"
				</script>
				<%
				badInput = true;
			}
			
			// makes sure that no entries go over the 50 character alloted by the program
			if(question.length() > 50){
				%>
				<script>
					alert("Subject can't be greater than 50 characters.");
					window.location.href = "UserMenuInfoChange.jsp"
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
				
				String maxID = "SELECT MAX(questionID) FROM Question";
				ResultSet check_maxID = stmt.executeQuery(maxID);
				int questionID;
				
			    if(check_maxID.next()){
			    	questionID = check_maxID.getInt(1)+1;
			    }
			    else{
			    	questionID = 1;
			    }
			    
					
				    String send_Email="INSERT INTO `Question`(`questionID`, `sender`, `question`, `content`) VALUES (?, ?, ?, ?)";			
				    
					PreparedStatement send_email_ps = con.prepareStatement(send_Email);
					
					send_email_ps.setInt(1, questionID);
					send_email_ps.setString(2, username);
					send_email_ps.setString(3, question);
					send_email_ps.setString(4, content);
					
					send_email_ps.executeUpdate();
					//close connections
					send_email_ps.close();
					stmt.close();
					con.close();
				
			}else{
				%>
				<script>
					alert("Can't change your information for some reason.");
					window.location.href = "UserMenuInfoChange.jsp"
				</script>
				<%
			}

			%>		

			<script>
				alert("Question answered successfully ");
				window.location.href = "UserMenuInfoChange.jsp"
			</script>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong sending the message");
			out.print(ex);
		}
		%>
		<br>
		<a href=UserMenuInfoChange.jsp>Back to asking for support in changing your account information</a>
</html>