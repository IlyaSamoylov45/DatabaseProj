<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>All Auctions</title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >Currently Selling</font>
		</center>

		<br>
		<center>
		<%
		String username = (String)session.getAttribute("userName");
		
		java.util.Date nowDate = new java.util.Date();
	    java.sql.Timestamp nowDatesql = new java.sql.Timestamp(nowDate.getTime());
		%>
			<font size = "5" color = "0e5938" >Click to view more information about the auction: <%=username %></font>
			<table border="2">
   			<tr>
       			<td>AuctionID</td>
        		<td>GameID</td>
        		<td>Game Name</td>
        		<td>Information</td>
   			</tr>
   			<%

   				try{
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT A.*, V.game_name FROM Auction A, VideoGame V WHERE A.gameID = V.gameID AND BINARY A.seller = BINARY '" + username +"' AND A.dateClosing > '" + nowDatesql +"'" ;		
					ResultSet UserSelling_auctions = stmt.executeQuery(temp);
				
       				while(UserSelling_auctions.next()){
    	  				String auctionID = UserSelling_auctions.getString("auctionID");
    	  				String gameID = UserSelling_auctions.getString("gameID");
    	  				String dateCreated = UserSelling_auctions.getString("dateCreated");
    	   				String dateClosing = UserSelling_auctions.getString("dateClosing");
    	   				String initial_price = UserSelling_auctions.getString("initial_price");
    	   				String minimum_increase = UserSelling_auctions.getString("minimum_increase");
    	   				String buyer = UserSelling_auctions.getString("buyer");

    	   				String minimum_sell = UserSelling_auctions.getString("minimum_sell");
    	   				String sell_time = UserSelling_auctions.getString("sell_time");
    	   				String information = UserSelling_auctions.getString("information");
    	   				String game_name = UserSelling_auctions.getString("game_name");
    	   				
    	   				
    	   				if(buyer == null){
    	   					buyer = "No buyer yet.";
    	   				}
    	   				
    	   				if(information == null){
    	   					information = "No information given.";
    	   				}
    	   				
    	   				if(sell_time == null){
    	   					sell_time = "Not sold yet.";
    	   				}
    	   				
   			%>
           			 <tr>
            			<td><%=auctionID%></td>
						<td><%=gameID %></td>
						<td><%=game_name %></td>
						<td><textarea name="content" rows="5" cols="20" readonly><%=information %></textarea></td>		
						<td>
							<form method="post" action="UserMenuAuctionsCurrentlySellingMore.jsp">
								<input type="hidden" name="auctionID" value="<%= auctionID %>" />
								<input type="hidden" name="gameID" value="<%= gameID %>" />
								<input type="hidden" name="dateCreated" value="<%= dateCreated %>" />
								<input type="hidden" name="dateClosing" value="<%= dateClosing %>" />
								
								<input type="hidden" name="initial_price" value="<%= initial_price %>" />
								<input type="hidden" name="minimum_increase" value="<%= minimum_increase %>" />
								<input type="hidden" name="buyer" value="<%= buyer %>" />
								
								<input type="hidden" name="minimum_sell" value="<%= minimum_sell %>" />
								<input type="hidden" name="sell_time" value="<%= sell_time %>" />
								<input type="hidden" name="information" value="<%= information %>" />
								<input type="hidden" name="game_name" value="<%= game_name %>" />
								
								
								
				   				<input id="button" type="submit" value="View" >
				   			 </form>
				   		</td>
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			UserSelling_auctions.close();
   			stmt.close();
			con.close();
   }catch(Exception e){
		e.printStackTrace();
	}
    %>
	</center>

	<br>
	<center>
	
		<br>
		<form method="post" action="UserMenuAuctions.jsp">
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