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
		<title>Place Bid!</title>
	</head>

	<body>

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
		   
		    
		    String auctionID = request.getParameter("auctionID");
			String rating = request.getParameter("rating");
			float amount = Float.parseFloat(request.getParameter("amount"));
			float minimum_increase = Float.parseFloat(request.getParameter("minimum_increase"));
			String username = (String)session.getAttribute("userName");
			
			boolean badInput = false;
			float old_amount = -1;
			String temp = "SELECT B.*, A.dateClosing, A.minimum_increase FROM Auction A, Bid B WHERE B.auctionID = A.auctionID";
			ResultSet check_bid = stmt.executeQuery(temp);
			if(check_bid.next()){
				old_amount = check_bid.getFloat("amount");
				String time = check_bid.getString("dateClosing");
			}
			if(old_amount >= amount){
				%>
				<script>
					alert("old bid value greater");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				<%
				badInput = true;
			}
			
			if(amount < minimum_increase){
				%>
				<script>
					alert("minimum increase cannot be less than zero");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				<%
			badInput = true;
			}
			String insert_auction = "UPDATE `Auction` SET `buyer` = '" + username + "' WHERE auctionID = '" + auctionID + "'";
			
			if(!badInput){
				//Check for item in database
				String temp1 = "INSERT INTO `Bid`(`amount`, `bidder`, `time_of_bid`, `auctionID`)" + " VALUES(?, ?, ?, ?)";
				out.print("amount: "+amount + " ");
				out.print("username: "+username+ " ");
				out.print("sqldate: " +sqlDate+ " ");

				out.print(auctionID);

				PreparedStatement insert_bid = con.prepareStatement(temp1);
				insert_bid.setFloat(1, amount);
				insert_bid.setString(2, username);
				insert_bid.setTimestamp(3, sqlDate);
				insert_bid.setString(4, auctionID);
				int insert_auctions = stmt.executeUpdate(insert_auction);
				%>		

				<script>
					alert("Bid successfully placed, returning to Auctions menu");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				
				<%
				insert_bid.executeUpdate();
				insert_bid.close();
			}
			check_bid.close();
			stmt.close();
			con.close();
		}catch(Exception ex){
			out.print("Error. Something went wrong placing bid");
			out.print(ex);
		}
	%>
	<br>
		<a href=UserMenu.jsp>Back to user menu</a>
	</body>
</html>