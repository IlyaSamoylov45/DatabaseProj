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
		<title>Sell Item</title>
	</head>
	<body>
		<center>
			<font size = "13" color = "0e5938" >Choose a rating Scale!</font>
		</center>
	<center>
			<font size = "3" color = red >
				Note, not checking will be seen as no!! 
			</font>
		</center>
		<br>
		<center>
			<form method="post" action="UserMenuAuctionsSellEveryone.jsp">
				<table>
					<tr>    
						<td><font size = "6" color = "black" >Everyone</font></td>
					</tr>
					<tr>
						<td>Mild Violence? </td>
							<td><input type="checkbox" name="mildViolence" value="1"/>
					</tr>
					<tr>
						<td>Mild Language? </td>
						<td><input type="checkbox" name="mildLanguage" value = "1"/>	
					</tr>
				</table>
				<input type="submit" value="Create"/>
				<input type="reset" value="Reset" />
			</form>
		</center>
		
		<center>
			<form method="post" action="UserMenuAuctionsSellTeen.jsp">
				<table>
					<tr>    
						<td><font size = "6" color = "black" >Teen</font></td>
					</tr>
					<tr>
						<td>Suggestive Themes? </td>
							<td><input type="checkbox" name="suggestiveThemes" value = "1"/>
					</tr>
					<tr>
						<td>Violence? </td>
						<td><input type="checkbox" name="mediumViolence" value = "1"/></td>
					</tr>
					<tr>
						<td>Crude Humor? </td>
						<td><input type="checkbox" name="crudeHumor" value = "1"/></td>
					</tr>
					<tr>
						<td>Blood? </td>
						<td><input type="checkbox" name="mediumBlood" value = "1"/></td>
					</tr>
					<tr>
						<td>Gambling? </td>
						<td><input type="checkbox" name="gambling" value = "1"/></td>
					</tr>
					<tr>
						<td>Language? </td>
						<td><input type="checkbox" name="mediumLanguage" value = "1"/></td>
					</tr>
				</table>
				<input type="submit" value="Create">
				<input type="reset" value="Reset" />
			</form>
		</center>
		
		<center>
			<form method="post" action="UserMenuAuctionsSellMature.jsp">
				<table>
					<tr>    
						<td><font size = "6" color = "black" >Mature</font></td>
					</tr>
					<tr>
						<td>Violence? </td>
							<td><input type="checkbox" name="strongViolence" value = "1"/></td>
					</tr>
					<tr>
						<td>Blood And Gore? </td>
						<td><input type="checkbox" name="bloodGore" value = "1"/></td>
					</tr>
					<tr>
						<td>Sexual Content? </td>
						<td><input type="checkbox" name="sexualContent" value = "1"/></td>
					</tr>
					<tr>
						<td>Strong Language? </td>
						<td><input type="checkbox" name="strongLanguage" value = "1"/></td>
					</tr>
					<tr>
						<td>Drug use? </td>
						<td><input type="checkbox" name="drugUse" value = "1"/></td>
					</tr>
				</table>
				<input type="submit" value="Create">
				<input type="reset" value="Reset" />
			</form>
		</center>
		<br>
		<center>
			<form method="post" action="UserMenuAuctions.jsp">
				<input type="submit" value="Back">
			</form>
		</center>
		
		<center>
			<br>
			<form method="post" action="UserMenu.jsp">
				<input type="submit" value="Main Menu">
			</form>
			
			<br>
			<form method="post" action="LogOutEndUser.jsp">
				<input type="submit" value="Logout">
			</form>
		</center>
</html>