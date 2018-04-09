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
		<title>User Change Information</title>
	</head>

	<body>
		<center>
			<font size = "10" color = "0e5938" >Ask to Change Information, A Customer Representative will respond to you soon. </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >User Information to change</font>
			<form method="post" action="UserMenuInfoChangeQuery.jsp">
				<table>
					<tr>
						<td>Subject: </td><td><input type="text" name="subject"></td>
					</tr>
					<tr>
						<td>Content: </td><td><textarea name="content" rows="10" cols="30"></textarea></td>
					</tr>
				</table>
				<input type="submit" value="Send">
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
			<form method="post" action="UserMenuInfo.jsp">
				<input type="submit" value="Back">
			</form>
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			<br>
			<form method="post" action="LogOutEndUser.jsp">
				<input type="submit" value="Log Out">
			</form>
		</center>
	</body>
</html>