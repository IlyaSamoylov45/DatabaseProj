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
				String auctionID = request.getParameter("auctionID");
				String bidder = request.getParameter("bidder");
				String amount = request.getParameter("amount");
				System.out.println(auctionID);
				System.out.println(bidder);
				System.out.println(amount);
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
		
			//Check for username
			String temp = "DELETE FROM `Bid` WHERE `bidder` = ? AND `auctionID` = ? AND `amount` = ?";		
			
			PreparedStatement ps = con.prepareStatement(temp);
			ps.setString(1, bidder);
			ps.setString(2, auctionID);
			ps.setString(3, amount);
			
			ps.executeUpdate();
			ps.close();
			
			String checknext = "Select B.bidder, B.auctionID ,MAX(B.amount) FROM Bid B WHERE BINARY auctionID = '" + auctionID + "'";
			
			ResultSet test = stmt.executeQuery(checknext);
			String insert_auction = "";
			if(test.next()){
				out.print("hello");
				
				String newBidder = test.getString("bidder");
				
				insert_auction = "UPDATE `Auction` SET `buyer` = '" + newBidder + "' WHERE auctionID = '" + auctionID + "'";
				int insert_auction_update = stmt.executeUpdate(insert_auction);
				%>
				<script>
					alert("  No other bid higher");
					window.location.href = "CustRepDeleteMenuBids.jsp"
				</script><%
			}else{
				String newBidder = test.getString("bidder");
				insert_auction = "UPDATE `Auction` SET `buyer` = '" + newBidder + "' WHERE auctionID = '" + auctionID + "'";
				int insert_auction_update = stmt.executeUpdate(insert_auction);
				
			}
			
			stmt.close();
			con.close();
				%>
				
			<script>
				alert(" Bid Deleted");
				window.location.href = "CustRepDeleteMenuBids.jsp"
			</script>
			
			<%
		} catch (Exception ex) {
			out.print("Error. Something went wrong Deleting");
			out.print(ex);
			%>
			<script>
				alert("Click to go back to deleting bids");
				window.location.href = "CustRepDeleteMenuBids.jsp"
		</script>
		<%}%>
	</body>
</html>