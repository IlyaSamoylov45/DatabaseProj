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
			String reciever = request.getParameter("reciever");
			String subject = request.getParameter("subject");
			String content = request.getParameter("content");
			String sender = (String)session.getAttribute("userName");
			
			reciever.trim();
			subject.trim();
			content.trim();
			sender.trim();
			
			boolean badInput = false;
			
			// makes sure that no entries are null
			if(reciever.equals("") || subject.equals("") || content.equals("")){
				%>
				<script>
					alert("Every Field is Mandatory. Try again.");
					window.location.href = "CustRepEmailSendMessage.jsp"
				</script>
				<%
				badInput = true;
			}
			
			// makes sure that no entries go over the 50 character alloted by the program
			if(reciever.length() > 50 || subject.length() > 50){
				%>
				<script>
					alert("Subject or reciver can't be greater than 50 characters.");
					window.location.href = "CustRepEmailSendMessage.jsp"
				</script>
				<%
				badInput = true;
			}
			if(reciever.equals("admin")){
			%>
			<script>
				alert("Can't send to the admin.");
				window.location.href = "CustRepEmailSendMessage.jsp"
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
				String temp = "SELECT * FROM Account WHERE BINARY username = BINARY '" + reciever + "'";		
				ResultSet result = stmt.executeQuery(temp);
				if(result.next()){
					java.sql.Date sqlDate = new java.sql.Date(new java.util.Date().getTime());
					
					//get the current max id
					String maxID = "SELECT MAX(`messageID`) FROM `Email`";
					ResultSet check_maxID = stmt.executeQuery(maxID);
					int new_ID;
					
				    if(check_maxID.next()){
				    	new_ID = check_maxID.getInt(1)+1;
				    }
				    else{
				    	new_ID = 1;
				    }
				    
				    String send_Email="INSERT INTO `Email`(`messageID`, `from`, `to`, `dateTime`, `content`, `subject`) VALUES (?, ?, ?, ?, ?, ?)";			
				    
					PreparedStatement send_email_ps = con.prepareStatement(send_Email);
					
					send_email_ps.setInt(1, new_ID);
					send_email_ps.setString(2, sender);
					send_email_ps.setString(3, reciever);
					send_email_ps.setDate(4, sqlDate);
					send_email_ps.setString(5, content);
					send_email_ps.setString(6, subject);
					
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
						alert("Username does not exist.");
						window.location.href = "CustRepEmailSendMessage.jsp"
					</script>
					<%
				}
			}
			%>		

			<script>
			
				alert("Message Sent" );
	
				window.location.href = "CustRepEmailSendMessage.jsp"
			</script>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong sending the message");
			out.print(ex);
			
		}
		%>
		<br>
		<a href=CustRepEmailSendMessage.jsp>Back writing message</a>
	</body>
</html>