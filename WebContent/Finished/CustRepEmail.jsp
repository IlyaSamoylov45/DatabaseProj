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
		<title>Your Email Information</title>
	</head>
	
	<body>
		<center>
			<font size = "13" color = "0e5938" >BuyNOW Email Information! </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Check your Inbox</font>
			<form method="post" action="CustRepEmailInbox.jsp">
				<input type="submit" value="Check">
			</form>
		</center>
		
		<br>
		<center>
			<font size = "5" color = "0e5938" >Send an Email</font>
			<form method="post" action="CustRepEmailSendMessage.jsp">
				<input type="submit" value="View">
			</form>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >View Sent Emails</font>
			<form method="post" action="CustRepEmailSentMessages.jsp">
				<input type="submit" value="Check">
			</form>
		</center>

		<center>
		
			<br>
			<form method="post" action="CustRepMenu.jsp">
				<input type="submit" value="Back">
			</form>
			
			<br>
			<form method="post" action="LogOutCustRep.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
	</body>
		
	</body>
</html>