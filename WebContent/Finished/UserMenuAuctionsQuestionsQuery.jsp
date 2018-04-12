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
	String auctionIDswitch  = request.getParameter("auctionIDswitch");
	String rating =  request.getParameter("rating");
	String question = request.getParameter("subject");
	String content = request.getParameter("content");
	String username = (String)session.getAttribute("userName");

		try {

			content.trim();
			question.trim();

			boolean badInput = false;
			
			// makes sure that no entries are null
			if(content.equals("") || question.equals("")) {
				out.print("Every Field is Mandatory. Try again. "); 
				%>	
						<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
							<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
							<input type="hidden" name="rating" value="<%= rating %>" />
							<input id="button" type="submit" value="Back" >
						</form>
					<%
				badInput = true;
			}
			
			// makes sure that no entries go over the 50 character alloted by the program
			if(question.length() > 50){
				out.print("Question length too long"); 
				 %>	
					<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
						<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
						<input type="hidden" name="rating" value="<%= rating %>" />
						<input id="button" type="submit" value="Back" >
					</form>
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
				out.print("Question answered successfully "); 
				 %>
					
					<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
						<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
						<input type="hidden" name="rating" value="<%= rating %>" />
						<input id="button" type="submit" value="Back" >
					</form>
				<%
			}		

			
			out.print("Question answered successfully "); %>
			
			<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
				<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input id="button" type="submit" value="Back" >
			</form>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong sending the message");
			out.print(ex);
		}
		%>
		<br>		
		<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
				<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input id="button" type="submit" value="Back" >
			</form>
</html>