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

			String temp1 = "SELECT B.*, G.game_name FROM Alert A, Auction B, VideoGame G WHERE A.`gameID` = B.`gameID` AND A.`auctionID` <> B.`auctionID`AND A.`alertTime` < B.`dateCreated` AND B.gameID = G.gameID AND BINARY A.username = BINARY '" + username + "' ";		
			
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
					<td><form method="post" action="DeleteAlert.jsp">
							<input type="hidden" name="username" value="<%= username %>" />
							<input type="hidden" name="gameID" value="<%= gameID %>" />
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
			}
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