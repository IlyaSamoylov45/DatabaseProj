<%--Author: Ilya Samoylov --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
		<style>
			body {
				background-color: #97a08d;
			}
		</style>
	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>User Auction Questions</title>
	</head>

	<body>
		<center>
			<font size = "10" color = "0e5938" >Ask A question about the auction, A Customer Representative will respond to you soon. </font>
		</center>
		<%
			String auctionIDswitch  = request.getParameter("auctionIDswitch");
			String rating =  request.getParameter("rating");
		 %>
		<br>
		<center>
			<font size = "5" color = "0e5938" >Ask about auction number "<%=auctionIDswitch %>"</font>
			<form method="post" action="UserMenuAuctionsQuestionsQuery.jsp">
				<table>
					<tr>
						<td>Subject: </td><td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>Content: </td><td><textarea name="content" rows="10" cols="30"></textarea></td>
					</tr>
				</table>
				<input type="submit" value="Send">
				<input type="hidden" name="auctionIDswitch" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input type="reset" value="Reset" />
			</form>
		</center>
		
		<br>
		<center>
			<font size = "3" color = red >
				Note all fields are required!! 
			</font>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Want to Cancel?
			</font>
			<br>
			<form method="post" action="UserMenuBuyAuctionBackQuery.jsp">
				<input type="hidden" name="auctionIDswitch" value="<%= auctionIDswitch %>" />
				<input type="hidden" name="rating" value="<%= rating %>" />
				<input id="button" type="submit" value="Back" >
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