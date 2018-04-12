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
		<title>Auction Information</title>
	</head>
	
	<body>
		<center>
			<font size = "13" color = "0e5938" >Delete Auction? </font>
		</center>

		<br>
	<%
	try{
		
		String auctionID = request.getParameter("auctionID");
		String gameID = request.getParameter("gameID");
		String dateCreated = request.getParameter("dateCreated");
		String dateClosing = request.getParameter("dateClosing");
		
		String initial_price = request.getParameter("initial_price");
		String minimum_increase = request.getParameter("minimum_increase");
		String buyer = request.getParameter("buyer");
		String seller = request.getParameter("seller");
		
		String minimum_sell = request.getParameter("minimum_sell");
		String sell_time = request.getParameter("sell_time");
		String information = request.getParameter("information");
		String game_name = request.getParameter("game_name");
		
		
	%>
		<center>
		
			<table border="2">
	   			<tr>
	     	   		<td>auctionID</td>
	      	   		<td>gameID</td>
	      	   		<td>Game Name</td>
	      	   		<td>Date Created</td>
	      	   		
	      	   		<td>Date Closing</td>
	     	   		<td>Initial Price</td>
	     	   		<td>Minimum Increase</td>
	      	   		<td>Buyer </td>
	      	   		<td>Seller</td>
	      	   		
	      	   		<td>Minimum sell Price</td>
	      	   		<td>Sell Time</td>
	      	   		<td>Information</td>
	      	   		<td>Delete</td>
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
					<td><%=minimum_sell%></td>
					<td><%=sell_time%></td>
					<td><textarea name="content" rows="5" cols="20" readonly><%=information %></textarea></td>
					<td><form method="post" action="CustRepDeleteMenuAuctionsViewQuery.jsp">
						<input type="hidden" name="auctionID" value="<%= auctionID %>" />
				   		<input id="button" type="submit" value="Delete" >
				   	</form>		
				   	</td>
					
				</tr>
			</table>
		<%
	}catch (Exception ex) {
			out.print("Error. Something went wrong checking this auction");
			out.print(ex);
			%>
				<br>
				<a href=CustRepDeleteMenuAuctions.jsp>Back to all deleting Auctions</a>
			<%
		}
		%>

		<center>
		<br>
			<form method="post" action="CustRepDeleteMenuAuctions.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="CustRepMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			
			<br>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
	</body>
</html>