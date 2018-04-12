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
		<title>Administrator Summary Reports</title>
	</head>
	
	<body>
		<center>
				<font size = "13" color = "0e5938" >Generate Summary Reports</font>
		</center>
		<br>
		<center>
			<font size = "5" color = "0e5938" >Total Earning Per Item</font>
			<form method="post" action="SummaryReportsTotalEarningPerItem.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<br>
		<center>
			<font size = "5" color = "0e5938" >Total Earning Per Item Type</font>
			<form method="post" action="SummaryReportsTotalEarningPerItemType.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<br>
		<center>
			<font size = "5" color = "0e5938" >Total Earning Per User</font>
			<form method="post" action="SummaryReportsTotalEarningPerUser.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<br>
		<center>
			<font size = "5" color = "0e5938" >Best Selling Items</font>
			<form method="post" action="SummaryReportsBestSellingItems.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<br>
		<center>
			<font size = "5" color = "0e5938" >Best Selling User</font>
			<form method="post" action="SummaryReportsBestSellingUsers.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		
		<center>
		
			<br>
			<form method="post" action="AdminMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOut.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
</html>