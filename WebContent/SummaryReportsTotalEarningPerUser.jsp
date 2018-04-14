<%--Author: Mahim Gupta --%>
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
		<title>User Earnings</title>
	</head>

	<body>
	<center>
			<font size = "5" color = "0e5938" >Information</font>
			<table border="2">
   			<tr>
       			<td>User name</td>
        		<td>Earning</td>
       			
   			</tr>

	<%	
		try{
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			
			//this will be compared with the auction time to check to make sure the bid isnt over
			java.util.Date startDate = new java.util.Date();
		    java.sql.Timestamp sqlDate = new java.sql.Timestamp(startDate.getTime());
		   
		    
		    String userID = request.getParameter("input_user");
			
			String username = (String)session.getAttribute("userName");
			
			boolean badInput = false;
			float total = 0;
			String temp = "SELECT Auction.auctionID, Auction.seller, Bid.auctionID, Bid.amount FROM Auction, Bid WHERE Auction.buyer IS NOT NULL AND '" + userID + "' LIKE Auction.seller AND Auction.auctionID = Bid.auctionID HAVING MAX(Bid.amount)";
			ResultSet userEarning = stmt.executeQuery(temp);
			while(userEarning.next()){
				total += userEarning.getFloat("amount");
			}
			
			%>
			
			 <tr>
            			<td><%=userID%></td>
						<td><%=total %></td>
					</tr>
			</table>
			<%
			if(total < 0){
				%>
				<script>
					alert("Error calculating earnings");
					window.location.href = "SummaryReports.jsp"
				</script>
				<%
				badInput = true;
			}
			
			
			
			if(!badInput){
				}
			userEarning.close();
			stmt.close();
			con.close();
		}catch(Exception ex){
			out.print("Error. Something went wrong placing bid");
			out.print(ex);
		}
	%>
	</body>
</html>