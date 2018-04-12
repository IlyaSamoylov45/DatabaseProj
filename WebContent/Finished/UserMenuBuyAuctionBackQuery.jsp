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
	
		<%
		String auctionIDswitch  = request.getParameter("auctionIDswitch");
		String rating =  request.getParameter("rating");
		//out.print(auctionIDswitch);
		//out.print(rating);
		%>
	<body>
		<center>
		
   			<%
   				try{
   					ApplicationDB db = new ApplicationDB();	
   					Connection con = db.getConnection();
   					Statement stmt = con.createStatement();		
   				
   				    
   					//Check for item in database
   					String temp1 = "SELECT A.*, G.game_name FROM Auction A, VideoGame G WHERE A.auctionID = '" + auctionIDswitch + "' AND G.gameID = A.gameID";							
   					ResultSet gameSearch = stmt.executeQuery(temp1);
   							
   					if(gameSearch.next()){
   						String gameID  = gameSearch.getString("gameID");
   						String dateCreated = gameSearch.getString("dateCreated");
   						String dateClosing = gameSearch.getString("dateClosing");
   						String initial_price = gameSearch.getString("initial_price");
   						String buyer = gameSearch.getString("buyer");		
   						String seller =  gameSearch.getString("seller");
   						
   						String minimum_sell  =  gameSearch.getString("minimum_sell");
   						String minimum_increase  =  gameSearch.getString("minimum_increase");
   						String sell_time  =  gameSearch.getString("sell_time");
   						String information =  gameSearch.getString("information");
   						String game_name = gameSearch.getString("game_name");	
   						%>
   						<form id = "redirect" method="post" action="UserMenuAuctionsBuySearchDoneView.jsp">
							<input type="hidden" name="auctionID" value="<%= auctionIDswitch %>" />
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
							<input type="hidden" name="rating" value="<%= rating %>" />							
							
			  		 	</form>	
			  		 	<script>
   							 window.onload = function() {
        					 	document.getElementById("redirect").submit();
   							 }
						</script>	
			   	<%
   					}
   					else{
   						%>
	   					<script>
							alert("Something went wrong. The auction might have been deleted while you were looking at bidder. Returning to menu");
							window.location.href = "UserMenu.jsp"
						</script>
					<%
   					}

		   		}catch(Exception e){
					e.printStackTrace();
			%>
					<script>
						alert("Something went wrong Going back to auction UserMenuBuyAuctionBackQuery. Going back to Main page of user");
						window.location.href = "UserMenu.jsp"
					</script>
				<%
			}
		    %>
		</center>
	</body>
</html>