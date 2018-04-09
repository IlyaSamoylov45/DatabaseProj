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
		<title>Customer Representative Main Menu</title>
	</head>
	
	<body>

			<%		
				String firstname = (String)session.getAttribute("firstName");
				String lastname = (String)session.getAttribute("lastName");
			%>
		<center>
			<font size = "13" color = "0e5938" >Welcome to BuyNOW Customer Representative Home page, <%= firstname %> <%= lastname %> !</font>
		</center>
		
		<br>
		<center>
			<font size = "5" color = "0e5938" >Check your email!</font>
			<form method="post" action="CustRepEmail.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<center>
			<font size = "5" color = "0e5938" >Change your Information!</font>
			<form method="post" action="CustRepUpdate.jsp">
				<input type="submit" value="Update">
				</form>
		</center>
	
		<center>
			<font size = "5" color = "0e5938" >Look at User Information!</font>
			<form method="post" action="CustRepUserInfo.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<center>
			<font size = "5" color = "0e5938" >View Questions!</font>
			<form method="post" action="CustRepQuestions.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<center>
			<font size = "5" color = "0e5938" >Delete an Auction or Bids!</font>
			<form method="post" action="CustRepDeleteMenu.jsp">
				<input type="submit" value="View">
			</form>
		</center>
		<br>
		<center>
			<form method="post" action="LogOutCustRep.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>

	</body>
</html>