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
		<title>User History not yourself</title>
	</head>
		<%
		String auctionIDswitch  = request.getParameter("auctionID");
		String bidder = request.getParameter("bidder");
		String rating = request.getParameter("rating");
		%>
	<body>
		<center>
			<font size = "13" color = "0e5938" >Auction History Of User: <%=bidder %></font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Information about the auction: <%=bidder %> where you were seller</font>
			<table border="2">
   			<tr>
       			<td>AuctionID</td>
        		<td>GameID</td>
        		<td>Game Name</td>
        		<td>Date Created</td>
        		<td>Date Closing</td>
        		<td>Initial Price</td>
        		<td>Minimum Increase</td>
        		<td>Minimum Sell Price</td>
        		<td>Sell Time</td>
        		<td>Buyer </td>
        		<td>Genre</td>
        		<td>Platform</td>
        		<td>Condition</td>
        		<td>Total Players</td>
        		<td>Information</td>
   			</tr>
   			<%

   				try{
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT A.*, V.* FROM Auction A, VideoGame V WHERE A.gameID = V.gameID AND BINARY A.seller = BINARY '" + bidder +"'";		
					ResultSet participatingAuctions = stmt.executeQuery(temp);
				
       				while(participatingAuctions.next()){
    	  				String auctionID = participatingAuctions.getString("auctionID");
    	  				String gameID = participatingAuctions.getString("gameID");
    	  				String dateCreated = participatingAuctions.getString("dateCreated");
    	   				String dateClosing = participatingAuctions.getString("dateClosing");
    	   				String initial_price = participatingAuctions.getString("initial_price");
    	   				String minimum_increase = participatingAuctions.getString("minimum_increase");
    	   				String buyer = participatingAuctions.getString("buyer");

    	   				String minimum_sell = participatingAuctions.getString("minimum_sell");
    	   				String sell_time = participatingAuctions.getString("sell_time");
    	   				String information = participatingAuctions.getString("information");
    	   				String game_name = participatingAuctions.getString("game_name");
    	   				
    	   				String genre = participatingAuctions.getString("genre");
    	   				String platform = participatingAuctions.getString("platform");
    	   				String condition = participatingAuctions.getString("condition");
    	   				String total_players = participatingAuctions.getString("total_players");    	   				
    	   				
    	   				if(buyer == null){
    	   					buyer = "No buyer yet.";
    	   				}
    	   				
    	   				if(information == null){
    	   					information = "No information given.";
    	   				}
    	   				
    	   				if(sell_time == null){
    	   					sell_time = "Not sold yet.";
    	   				}
    	   				
   			%>
           			 <tr>
			       			<td><%= auctionID%></td>
			        		<td><%= gameID%></td>
			        		<td><%= game_name%></td>
			        		<td><%= dateCreated%></td>
			        		<td><%= dateClosing%></td>
			        		<td><%= initial_price%></td>
			        		<td><%= minimum_increase%></td>
			        		<td><%= minimum_sell%></td>
			        		<td><%= sell_time%></td>
			        		<td><%= buyer%></td>
			        		<td><%= genre%></td>
			        		<td><%= platform%></td>
			        		<td><%= condition%></td>
			        		<td><%= total_players%></td>
			        		<td><textarea name="content" rows="5" cols="20" readonly><%=information %></textarea></td>
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			participatingAuctions.close();
   			stmt.close();
			con.close();
   }catch(Exception e){
		e.printStackTrace();
		%>
		<script>
			alert("Something went wrong displaying all auctions you participated as seller back to User Menu: LOOKING AT SOMEONE ELSES AUCTION");
			window.location.href = "UserMenu.jsp"
		</script>
	<%
	}
    %>
	</center>
	
	<center>
			<font size = "5" color = "0e5938" >Information about All <%=bidder %>'s bids</font>
			<table border="2">
   			<tr>
       			<td>AuctionID</td>
       			<td>Game Name</td>
        		<td>Amount</td>
        		<td>Time of Bid</td>
   			</tr>
   			<%

   				try{
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT B.*, G.game_name FROM Bid B, Auction A, VideoGame G WHERE A.auctionID = B.auctionID AND G.gameID = A.gameID AND BINARY B.bidder = BINARY '" + bidder +"' ORDER BY B.`time_of_bid` ASC";
					ResultSet participatingBids = stmt.executeQuery(temp);
				
       				while(participatingBids.next()){
       					String auctionID = participatingBids.getString("auctionID");
       					String game_name = participatingBids.getString("game_name");
    	  				String amount = participatingBids.getString("amount");
    	  				String time_of_bid = participatingBids.getString("time_of_bid");  				
   			%>
           			<tr>
			       			<td><%= auctionID%></td>
			       			<td><%= game_name%></td>
			        		<td><%= amount%></td>
			        		<td><%= time_of_bid%></td>
			        </tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			participatingBids.close();
   			stmt.close();
			con.close();
   }catch(Exception e){
		e.printStackTrace();
		%>
		<script>
			alert("Something went wrong displaying all Bids Return to user menu");
			window.location.href = "UserMenu.jsp"
		</script>
	<%
	}
    %>
    </center>

	<br>
	<center>
	
		<br>
			<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
				<input type="hidden" name="auctionIDswitch" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input id="button" type="submit" value="Back" >
			</form>
		
		<br>
		<form method="post" action="UserMenu.jsp">
			<input type="submit" value="Main Menu"/>
		</form>
		
		<br>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Log Out"/>
		</form>
	</center>
	</body>
</html>