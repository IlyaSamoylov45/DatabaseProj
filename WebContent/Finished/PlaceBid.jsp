<%--Author: Ilya Samoylov --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Everyone rated Game!</title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >Everyone rated game!</font>
		</center>
	<%	
			String auctionIDswitch  = request.getParameter("auctionID");
			String game_name  = request.getParameter("game_name");
			String rating = request.getParameter("rating");
			String username = (String)session.getAttribute("userName");
			String minimum_increase = request.getParameter("minimum_increase");
	%>
		<br>
		<center>
		<font size = "5" color = "0e5938" >Place A bid <%=username %> for auction number <%=auctionIDswitch %> game <%=game_name %></font>
			<form method="post" action="PlaceBidQuery.jsp">
				Amount:<input type="number" name="amount" step="0.01" value = "0.00"/>
				<br>
				<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input type="hidden" name="minimum_increase" value="<%= minimum_increase %>" />
				<input type="submit" value="Create">
				<input type="reset" value="Reset" />
			</form>
		</center>
		<center>
		<font size = "5" color = "0e5938" >Place An Auto-bid <%=username %> for auction number <%=auctionIDswitch %> game <%=game_name %></font>
			<form method="post" action="PlaceAutoBidQuery.jsp">
				Amount:<input type="number" name="amount" step="0.01" value = "0.00"/>
				<br>
				<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input type="hidden" name="minimum_increase" value="<%= minimum_increase %>" />
				<input type="submit" value="Create">
				<input type="reset" value="Reset" />
			</form>
		</center>
		<br>
		<center>
			<font size = "3" color = red >
				Note all fields are required!! 
			</font>
		</center>
		
		<br>
		<center>
			<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
				<input type="hidden" name="auctionIDswitch" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input id="button" type="submit" value="Back" >
			</form>
		</center>
		
		<br>
		<center>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
		</center>
		
		<br>
		<center>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="LogOut">
			</form>
		</center>
	</body>
</html>