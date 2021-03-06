<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
		<title>All Alerts</title>
	</head>
	
	<body>
		<center>
				<font size = "13" color = "0e5938" >Alerts!</font>
		</center>
		<center>
		<%
		try{
			%>
			<font size = "5" color = "0e5938" >New Items you might want</font>
			<%
			String username = (String)session.getAttribute("userName");
			
		    ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();		

			String temp1 = "SELECT B.*, G.game_name FROM Alert A, Auction B, VideoGame G WHERE A.`gameID` = B.`gameID` AND A.`auctionID` < B.`auctionID`AND A.`alertTime` <= B.`dateCreated` AND A.gameID = G.gameID AND BINARY A.username = BINARY '" + username + "' ";		
			
			ResultSet alertSearch = stmt.executeQuery(temp1);
			
			if(alertSearch.next()){	
			%>
			<table border="2">
	   			<tr>
	     	   		<td>Game Name</td>
	      	   		<td>AuctionID</td>
	      	   		<td>Delete Alert</td>

	      	   		   			</tr>
	   			<tr>
	   		<%
	   			String auctionID = alertSearch.getString("auctionID");
				String gameID = alertSearch.getString("gameID");
				String dateCreated = alertSearch.getString("dateCreated");
				String dateClosing = alertSearch.getString("dateClosing");
				String initial_price = alertSearch.getString("initial_price");
				String minimum_increase = alertSearch.getString("minimum_increase");
				String buyer = alertSearch.getString("buyer");
				String seller = alertSearch.getString("seller");
				String minimum_sell = alertSearch.getString("minimum_sell");
				String sell_time = alertSearch.getString("sell_time");
				String information = alertSearch.getString("information");	
				String game_name = alertSearch.getString("game_name");
	   		%>
					<td><%=game_name%></td>
					<td><%=auctionID%></td>	
					<td><form method="post" action="DeleteAlert.jsp">
							<input type="hidden" name="username" value="<%= username %>" />
							<input type="hidden" name="gameID" value="<%= gameID %>" />
					   		<input id="button" type="submit" value="Delete" >
					   	</form>		
					</td>	
				</tr>
				<%
				while(alertSearch.next()){
					 auctionID = alertSearch.getString("auctionID");
					 gameID = alertSearch.getString("gameID");
					 dateCreated = alertSearch.getString("dateCreated");
					 dateClosing = alertSearch.getString("dateClosing");
					 initial_price = alertSearch.getString("initial_price");
					 minimum_increase = alertSearch.getString("minimum_increase");
					 buyer = alertSearch.getString("buyer");
					 seller = alertSearch.getString("seller");
					 minimum_sell = alertSearch.getString("minimum_sell");
					 sell_time = alertSearch.getString("sell_time");
					 information = alertSearch.getString("information");	
					 game_name = alertSearch.getString("game_name");
	   		%><tr>
					<td><%=game_name%></td>
					<td><%=auctionID%></td>	
					<td><form method="post" action="AlertDelete.jsp">
							<input type="hidden" name="username" value="<%= username %>" />
							<input type="hidden" name="" value="<%= gameID %>" />
					   		<input id="button" type="submit" value="Delete" >
					   	</form>		
					</td>	
				</tr>
				<%
				}
				%>
			</table>
			<%
			}else{
				%>
					<center>
						<font size = "5" color = "red" >No Alerts found for items you want!</font>
					</center>
				<%
			}%>
			<font size = "5" color = "0e5938" >Passed your upper limit!</font>
			<%
			String temp2 = "SELECT A.*, G.game_name FROM Auction A, VideoGame G, Bid B WHERE A.`gameID` = G.`gameID` AND BINARY A.seller = BINARY '" + username + "' AND B.auctionID = A.auctionID AND B.amount > A.minimum_sell";		
			
			ResultSet alertUpper = stmt.executeQuery(temp2);
			
			if(alertUpper.next()){	
				%>
				<table border="2">
		   			<tr>
		     	   		<td>Game Name</td>
		      	   		<td>AuctionID</td>
		      	    </tr>
		   			<tr>
		   		<%
		   			String auctionID = alertUpper.getString("auctionID");
					String gameID = alertUpper.getString("gameID");
					String dateCreated = alertUpper.getString("dateCreated");
					String dateClosing = alertUpper.getString("dateClosing");
					String initial_price = alertUpper.getString("initial_price");
					String minimum_increase = alertUpper.getString("minimum_increase");
					String buyer = alertUpper.getString("buyer");
					String seller = alertUpper.getString("seller");
					String minimum_sell = alertUpper.getString("minimum_sell");
					String sell_time = alertUpper.getString("sell_time");
					String information = alertUpper.getString("information");	
					String game_name = alertUpper.getString("game_name");
		   		%>
						<td><%=game_name%></td>
						<td><%=auctionID%></td>						
					</tr>
					<%
					while(alertUpper.next()){
						 auctionID = alertUpper.getString("auctionID");
						 gameID = alertUpper.getString("gameID");
						 dateCreated = alertUpper.getString("dateCreated");
						 dateClosing = alertUpper.getString("dateClosing");
						 initial_price = alertUpper.getString("initial_price");
						 minimum_increase = alertUpper.getString("minimum_increase");
						 buyer = alertUpper.getString("buyer");
						 seller = alertUpper.getString("seller");
						 minimum_sell = alertUpper.getString("minimum_sell");
						 sell_time = alertUpper.getString("sell_time");
						 information = alertUpper.getString("information");	
						 game_name = alertUpper.getString("game_name");
		   		%><tr>
						<td><%=game_name%></td>
						<td><%=auctionID%></td>
					</tr>
					<%
					}
					%>
				</table>
				<%
				}
			alertSearch.close();
			alertUpper.close();
			stmt.close();
			con.close();
			
			
		}catch (Exception ex) {
			out.print("Error. Something went wrong checking this auction and bids");
			out.print(ex);
			%>
				<br>
				<a href=UserMenu.jsp>Back to the User Menu</a>
			<%
		}
		%>
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
	</body>
</html>