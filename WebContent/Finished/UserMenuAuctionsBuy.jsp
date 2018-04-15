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
		<title>Search for an Item</title>
	</head>
	<body>
		<center>
			<font size = "13" color = "0e5938" >Search For an Item Based on rating</font>
				<form method="post" action="UserMenuAuctionsBuySearch.jsp">			  
					<br><br>
						Genre:
						<select name="Rating" >      
							<option>Everyone</option>      
							<option>Teen</option>      
							<option>Mature</option>  
						</select>   
					<input type="submit" value="Search">
				</form>
		</center>
		
		<center>
			<font size = "5" color = "0e5938" >Want to Cancel?
			</font>
			
		<center>
			<font size = "5" color = "0e5938" >Search Using AuctionID Number</font>
			<form method="post" action="UserMenuAuctionsHistory.jsp">
				<input type="submit" value="View">
			</form>
		</center>
			
			
			<br>
			<form method="post" action="UserMenuAuctions.jsp">
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