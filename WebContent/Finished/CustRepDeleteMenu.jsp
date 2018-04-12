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
		<title>Delete an Auction or Bid or Checked Reported Items</title>
	</head>
	<body>
		<center>
				<font size = "13" color = "0e5938" >Delete Auctions, bids, and View Reported Auctions</font>
		</center>
		<br>
		<center>
			<font size = "5" color = "0e5938" >Delete Auctions</font>
			<form method="post" action="CustRepDeleteMenuAuctions.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<center>
			<font size = "5" color = "0e5938" >Delete Bids!</font>
			<form method="post" action="CustRepDeleteMenuBids.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<center>
			<br>
			<form method="post" action="CustRepMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
</html>