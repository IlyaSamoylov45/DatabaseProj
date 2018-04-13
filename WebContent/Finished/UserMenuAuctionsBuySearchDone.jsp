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
		<title>List of Auctions for Item</title>
	</head>
	
	<body>
	<center>
			<font size = "13" color = "0e5938" >View Auction? </font>
	</center>

	<br>
	<%		
	String game_name = request.getParameter("gameName");

	try{
		
		String rating = request.getParameter("rating");
		String genre = request.getParameter("genre");
		String platform = request.getParameter("platform");
		String condition = request.getParameter("condition");		
		String total_players = request.getParameter("totalPlayers");
	   	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();		
				
				
		//check date to make sure that the item is still up for auction
		java.util.Date startDate = new java.util.Date();
	    java.sql.Timestamp sqlDate = new java.sql.Timestamp(startDate.getTime());
	    
		//Check for item in database
		String temp1 = "SELECT A.* FROM `VideoGame` V, Auction A, `" + rating + "` R WHERE BINARY V.game_name = BINARY '" + game_name + "' AND " +
		"V.`genre` = '" + genre + "'  AND V.`platform` = '" + platform + "' AND V.`condition` = '" + condition + 
		"' AND V.`total_players` = '" + total_players + "' AND R.`gameID` = V.`gameID` AND V.`gameID` = A.`gameID` AND A.dateClosing > '" + sqlDate + "'";		
		
		ResultSet gameSearch = stmt.executeQuery(temp1);
		if(gameSearch.next()){
			%>	
			<center>
					
					<table border="2">
			   			<tr>
			     	   		<td>AuctionID</td>
			      	   		<td>Game ID</td>
			      	   		<td>Game Name</td>
			      	   		<td>Platform</td>
			      	   		<td>Genre</td>
			      	   		
			      	   		<td>Condition</td>
			     	   		<td>Total Players</td>
			     	   		<td>Rating</td>
			     	   		<td>View</td>
			   			</tr>
			   			<%
			   			String auctionID = gameSearch.getString("auctionID");
		  				String gameID = gameSearch.getString("gameID");
		  				String dateCreated = gameSearch.getString("dateCreated");
		   				String dateClosing = gameSearch.getString("dateClosing");
		   				String initial_price = gameSearch.getString("initial_price");
		   				String minimum_increase = gameSearch.getString("minimum_increase");
		   				String buyer = gameSearch.getString("buyer");
		   				String seller = gameSearch.getString("seller");
		   				String minimum_sell = gameSearch.getString("minimum_sell");
		   				String sell_time = gameSearch.getString("sell_time");
		   				String information = gameSearch.getString("information");	
		   			if(buyer == null || buyer.trim().equals("")){
		   					buyer = "No buyer yet.";
		   			}
		   			if(information == null || information.trim().equals("")){
		   					information = "No information given.";
		   			}
		   				
		   			if(sell_time == null || sell_time.trim().equals("")){
		   				sell_time = "Not sold yet.";
		   			}	
		   				
		   				
		   				%>
						<tr>
								<td><%=auctionID%></td>
								<td><%=gameID %></td>
								<td><%=game_name %></td>
								<td><%=platform%></td>
								
								<td><%=genre%></td>
								<td><%=condition%></td>
								<td><%=total_players%></td>
								<td><%=rating%></td>
								<td><form method="post" action="UserMenuAuctionsBuySearchDoneView.jsp">
										<input type="hidden" name="auctionID" value="<%= auctionID %>" />
										<input type="hidden" name="gameID" value="<%= gameID %>" />
										<input type="hidden" name="dateCreated" value="<%= dateCreated %>" />
										<input type="hidden" name="dateClosing" value="<%= dateClosing %>" />
										
										<input type="hidden" name="initial_price" value="<%= initial_price %>" />
										<input type="hidden" name="minimum_increase" value="<%= minimum_increase %>" />
										<input type="hidden" name="buyer" value="<%= buyer %>" />
										<input type="hidden" name="seller" value="<%= seller %>" />
										
										<input type="hidden" name="minimum_sell" value="<%= minimum_sell %>" />
										<input type="hidden" name="sell_time" value="<%= sell_time %>" />
										<input type="hidden" name="information" value="<%= information %>" />
										<input type="hidden" name="game_name" value="<%= game_name %>" />
										<input type="hidden" name="rating" value="<%= rating %>" />
							   		<input id="button" type="submit" value="View" >
							   	</form>		
							   	</td>
								
							</tr>
						<%
						while(gameSearch.next()){
							auctionID = gameSearch.getString("auctionID");
			  				gameID = gameSearch.getString("gameID");
			  				dateCreated = gameSearch.getString("dateCreated");
			   				dateClosing = gameSearch.getString("dateClosing");
			   				initial_price = gameSearch.getString("initial_price");
			   				minimum_increase = gameSearch.getString("minimum_increase");
			   				buyer = gameSearch.getString("buyer");
			   				seller = gameSearch.getString("seller");
			   				minimum_sell = gameSearch.getString("minimum_sell");
			   				sell_time = gameSearch.getString("sell_time");
			   				information = gameSearch.getString("information");						
			   			if(buyer == null || buyer.trim().equals("")){
			   					buyer = "No buyer yet.";
			   			}
			   			if(information == null || information.trim().equals("")){
			   					information = "No information given.";
			   			}
			   				
			   			if(sell_time == null || sell_time.trim().equals("")){
			   				sell_time = "Not sold yet.";
			   			}	
			   			 %>
					   		<tr>
									<td><%=auctionID%></td>
									<td><%=gameID %></td>
									<td><%=game_name %></td>
									<td><%=platform%></td>
									
									<td><%=genre%></td>
									<td><%=condition%></td>
									<td><%=total_players%></td>
									<td><%=rating%></td>
									<td><form method="post" action="UserMenuAuctionsBuySearchDoneView.jsp">
										<input type="hidden" name="auctionID" value="<%= auctionID %>" />
										<input type="hidden" name="gameID" value="<%= gameID %>" />
										<input type="hidden" name="dateCreated" value="<%= dateCreated %>" />
										<input type="hidden" name="dateClosing" value="<%= dateClosing %>" />
										
										<input type="hidden" name="initial_price" value="<%= initial_price %>" />
										<input type="hidden" name="minimum_increase" value="<%= minimum_increase %>" />
										<input type="hidden" name="buyer" value="<%= buyer %>" />
										<input type="hidden" name="seller" value="<%= seller %>" />
										
										<input type="hidden" name="minimum_sell" value="<%= minimum_sell %>" />
										<input type="hidden" name="sell_time" value="<%= sell_time %>" />
										<input type="hidden" name="information" value="<%= information %>" />
										<input type="hidden" name="game_name" value="<%= game_name %>" />
										<input type="hidden" name="rating" value="<%= rating %>" />
								   		<input id="button" type="submit" value="View" >
								   	</form>		
								   	</td>
									
								</tr>
						<%}%>
						</table>
				   		</center>
					   	<%
				}
				else{
					
					%>
					<center>
						<font size = "3" color = red >
							No item like that Found!! Please note that searches are case sensitive Try to find similar?
						</font>
					</center>
					<center>
					   		<br>
							<form method="post" action="Similar.jsp">
								<input type="hidden" name="game_name" value="<%= game_name %>" />
						   		<input id="button" type="submit" value="Similar" >
						   	</form>	
					   	</center>
			   		<%	
				}
		gameSearch.close();
   		stmt.close();
   		con.close();
					
	}catch (Exception ex) {
			out.print("Error. Something went wrong checking this auction");
			out.print(ex);
			%>
				<br>
				<a href=UserMenuAuctionsBuy.jsp>Back to the User Auction's Menu</a>
			<%
		}
		%>
			<center>
		<br>
			<form method="post" action="UserMenuAuctionsBuy.jsp">
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