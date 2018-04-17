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
			<font size = "13" color = "0e5938" >All Auctions! </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Click to view more information and to delete</font>
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
					String temp = "SELECT A.*, V.game_name FROM Auction A, VideoGame V WHERE A.gameID = V.gameID";		
					ResultSet All_auctions = stmt.executeQuery(temp);
				
       				while(All_auctions.next()){
    	  				String auctionID = All_auctions.getString("auctionID");
    	  				String gameID = All_auctions.getString("gameID");
    	  				String dateCreated = All_auctions.getString("dateCreated");
    	   				String dateClosing = All_auctions.getString("dateClosing");
    	   				String initial_price = All_auctions.getString("initial_price");
    	   				String minimum_increase = All_auctions.getString("minimum_increase");
    	   				String buyer = All_auctions.getString("buyer");
    	   				String seller = All_auctions.getString("seller");
    	   				String minimum_sell = All_auctions.getString("minimum_sell");
    	   				String sell_time = All_auctions.getString("sell_time");
    	   				String information = All_auctions.getString("information");
    	   				String game_name = All_auctions.getString("game_name");
    	   				
    	   				
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
							<form method="post" action="CustRepDeleteMenuAuctionsView.jsp">
								<input type="hidden" name="auctionID" value="<%= auctionID %>" />
								<input type="hidden" name="gameID" value="<%= gameID %>" />
								<input type="hidden" name="dateCreated" value="<%= dateCreated %>" />
								<input type="hidden" name="dateClosing" value="<%= dateClosing %>" />
								
								<input type="hidden" name="initial_price" value="<%= initial_price %>" />
								<input type="hidden" name="minimum_increase" value="<%= minimum_increase %>" />
								<input type="hidden" name="buyer" value="<%= buyer %>" />
								<input type="hidden" name="seller" value="<%= seller %>" />
								
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
   			All_auctions.close();
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
		<form method="post" action="CustRepDeleteMenu.jsp">
			<input type="submit" value="Back">
		</form>
		
		<br>
		<form method="post" action="CustRepMenu.jsp">
			<input type="submit" value="Main Menu">
		</form>
		
		<br>
		<form method="post" action="LogOut.jsp">
			<input type="submit" value="Log Out">
		</form>
	</center>
	</body>
</html>