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
		<title>Look At Auctions With Bids</title>
	</head>
	
	<body>
		<center>
				<font size = "13" color = "0e5938" >Auction Informations</font>
		</center>
		<center>
		<%
		try{
			String auctionID  = request.getParameter("auctionID");
			String gameID  = request.getParameter("gameID");
			String dateCreated = request.getParameter("dateCreated");
			String dateClosing = request.getParameter("dateClosing");
			String initial_price = request.getParameter("initial_price");
			String buyer = request.getParameter("buyer");		
			String seller = request.getParameter("seller");
			
			String minimum_sell  = request.getParameter("minimum_sell");
			String minimum_increase  = request.getParameter("minimum_increase");
			String sell_time  = request.getParameter("sell_time");
			String information = request.getParameter("information");
			String game_name = request.getParameter("game_name");
			String rating = request.getParameter("rating");
			
			%>
			<table border="2">
	   			<tr>
	     	   		<td>auctionID</td>
	      	   		<td>gameID</td>
	      	   		<td>Game Name</td>
	      	   		<td>Date Created</td>
	      	   		
	      	   		<td>Date Closing</td>
	     	   		<td>Initial Price</td>
	     	   		<td>Minimum Increase</td>
	      	   		<td>Current Buyer</td>
	      	   		<td>Seller</td>
	
	      	   		<td>Information</td>
	   			</tr>
	   			<tr>
					<td><%=auctionID%></td>
					<td><%=gameID %></td>
					<td><%=game_name %></td>
					<td><%=dateCreated%></td>
					
					<td><%=dateClosing%></td>
					<td><%=initial_price%></td>
					<td><%=minimum_increase%></td>
					<td><%=buyer%></td>
					
					<td><%=seller%></td>
					<td><textarea name="content" rows="5" cols="20" readonly><%=information %></textarea></td>
					
				</tr>
			</table>
			
			<br>
			<form method="post" action="PlaceBid.jsp">
				<input type="hidden" name="auctionID" value="<%= auctionID %>" />
		   		<input id="button" type="submit" value="Place Bid" >
		   	</form>		
			
			<center>
				<font size = "13" color = "0e5938" >Bidding History</font>
			</center>
			<%
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			//Check for item in database
			String temp1 = "SELECT B.* FROM Bid B WHERE B.auctionID = '" + auctionID + "' ORDER BY B.amount DESC";		
			
			ResultSet bidSearch = stmt.executeQuery(temp1);
			
			if(bidSearch.next()){	
   			%>	
			<center>
				<table border="2">
		   			<tr>
		     	   		<td>Bidder</td>
		      	   		<td>Time of Bid</td>
		      	   		<td>Bid Amount</td>
		      	   		<td>View Users Bid History?</td>
		   			</tr>
		   			<%
		  				String bidder = bidSearch.getString("bidder");
		  				String amount = bidSearch.getString("amount");
		   				String time_of_bid = bidSearch.getString("time_of_bid");	
	   				%>
					<tr>
						<td><%=bidder %></td>
						<td><%=time_of_bid %></td>
						<td><%=amount%></td>
						
						<td><form method="post" action="UserMenuAuctionsBuySearchDoneViewBidder.jsp">
								<input type="hidden" name="auctionID" value="<%= auctionID %>" />
								<input type="hidden" name="bidder" value="<%= bidder %>" />
								<input type="hidden" name="time_of_bid" value="<%= time_of_bid %>" />
								<input type="hidden" name="amount" value="<%= amount %>" />
					   		<input id="button" type="submit" value="View" >
					   	</form>		
					   	</td>	
					</tr>
					<%
					while(bidSearch.next()){
						bidder = bidSearch.getString("bidder");
		  				amount = bidSearch.getString("amount");
		   				time_of_bid = bidSearch.getString("time_of_bid");				
		   			 %>
				   		<tr>
						<td><%=bidder %></td>
						<td><%=time_of_bid %></td>
						<td><%=amount%></td>
						
						<td><form method="post" action="UserMenuAuctionsBuySearchDoneViewBidder.jsp">
								<input type="hidden" name="auctionID" value="<%= auctionID %>" />
								<input type="hidden" name="time_of_bid" value="<%= time_of_bid %>" />
								<input type="hidden" name="amount" value="<%= amount %>" />
					   		<input id="button" type="submit" value="View" >
					   	</form>		
					   	</td>	
					</tr>
					<%
					}
					%>
				</table>
			</center>
				   		<%
				   		
				}else{
				%>
				<center>
					<font size = "3" color = red >
						No Bids, The world is your oyster buddy.
					</font>
				</center>
		   		<%	
			}
			%>	
			
			
			
			<%
		}catch (Exception ex) {
			out.print("Error. Something went wrong checking this auction and bids");
			out.print(ex);
			%>
				<br>
				<a href=UserMenuAuctionsBuy.jsp>Back to the User Auction's Menu</a>
			<%
		}
		%>
			<br>
			<form method="post" action="UserMenuAuctionsBuy.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			
			<br>
			<form method="post" action="LogOutEndUser.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
	</body>
</html>