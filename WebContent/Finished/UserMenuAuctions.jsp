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
		<title>Auction List</title>
	</head>
	
	<body>
			<center>
				<font size = "13" color = "0e5938" >Auction Information</font>
			</center>
	
		<br>
		<center>
			<font size = "5" color = "0e5938" >Sell Item!</font>
			<form method="post" action="UserMenuAuctionsSell.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<center>
			<font size = "5" color = "0e5938" >Buy Item!</font>
			<form method="post" action="UserMenuAuctionsBuy.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<center>
			<font size = "5" color = "0e5938" >Check Currently Selling Items!</font>
			<form method="post" action="UserMenuAuctionsCurrentlySelling.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<center>
			<font size = "5" color = "0e5938" >Check your history</font>
			<form method="post" action="UserMenuAuctionsHistory.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<center>
		
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOutEndUser.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>