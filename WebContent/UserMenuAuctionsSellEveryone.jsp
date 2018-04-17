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
			String mildViolence = request.getParameter("mildViolence");
			String mildLanguage = request.getParameter("mildLanguage");
			if(mildViolence == null){
				mildViolence = "0";
			}
			if(mildLanguage == null){
				mildLanguage = "0";
			}
	%>
		<br>
		<center>
			<form method="post" action="UserMenuAuctionsSellEveryoneQuery.jsp">
			  	<br>
					Game Name:<input type="text" name="gameName"/>
				<br><br>
					Genre:
					<select name="genre" >      
						<option>Action</option>      
						<option>Horror</option>      
						<option>Strategy</option>  
						<option>FPS</option>
						<option>Adventure</option>
						<option>Sports</option>
						<option>Role-playing</option>
					</select>   
				<br><br>
					Platform:
					<select name="platform" >      
						<option>Xbox</option>      
						<option>PC</option>      
						<option>Nintendo</option>  
						<option>Playstation</option>
						<option>Cross-Platform</option>
					</select>   
				<br><br>
					Condition:
					<select name="condition" >      
						<option>Not Working</option>      
						<option>Used</option>      
						<option>Like-New</option>  
						<option>Brand New</option>
					</select>   
				 <br> <br> 
					Total Players:
					<select name="totalPlayers" >      
						<option>Single-Player</option>      
						<option>Co-op</option>      
						<option>Multiplayer</option>  
						<option>All</option>
					</select>  
					<br><br>    
					Additional information<br><textarea name="information" rows="10" cols="30"></textarea>					   
				<br><br> 
				Start Price:<input type="number" name="startPrice" step="0.01" value = "0.00"/>
				<br><br> 
				Minimum increment:<input type="number" name="minimumIncrement" step="0.01" value = "0.00"/>
				<br><br> 
				Minimum you will take:<input type="number" name="sellPrice" step="0.01" value = "0.00"/>
				<br>
				<input type="hidden" name="mildViolence" value="<%= mildViolence %>" />
				<input type="hidden" name="mildLanguage" value="<%= mildLanguage %>" />
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
			<form method="post" action="UserMenuAuctionsSell.jsp">
				<input type="submit" value="Back">
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