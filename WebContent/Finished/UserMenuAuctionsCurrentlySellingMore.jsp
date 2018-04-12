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
		<% 
		String username = (String)session.getAttribute("userName");
		String auctionID = request.getParameter("auctionID");
		String gameID = request.getParameter("gameID");
		String dateCreated = request.getParameter("dateCreated");
		String dateClosing = request.getParameter("dateClosing");
		
		String initial_price = request.getParameter("initial_price");
		String minimum_increase = request.getParameter("minimum_increase");
		String buyer = request.getParameter("buyer");
		
		String minimum_sell = request.getParameter("minimum_sell");
		String sell_time = request.getParameter("sell_time");
		String information = request.getParameter("information");
		String game_name = request.getParameter("game_name");
		
		%>
		<title>More information for <%=username %>'s Auction. Number of Auction is: <%=auctionID %></title>
	</head>
	
	<body>
		<center>
			<font size = "13" color = "0e5938" >Information </font>
		</center>

		<br>
	<%
	try{	
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
	      	   		
	      	   		<td>Minimum sell Price</td>
	      	   		<td>Sell Time</td>
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
					
					<td><%=minimum_sell%></td>
					<td><%=sell_time%></td>
					<td><textarea name="content" rows="5" cols="20" readonly><%=information %></textarea></td>
					
				</tr>
			</table>
		</center>
			
		<%
	}catch (Exception ex) {
			out.print("Error. Something went wrong checking this auction");
			out.print(ex);
			%>
				<br>
				<a href=UserMenuAuctionsCurrentlySelling.jsp>Back to Auction's where you are currently seller</a>
			<%
		}
		%>

		<center>
		<br>
			<form method="post" action="UserMenuAuctionsCurrentlySelling.jsp">
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