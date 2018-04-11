<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<style>
		body {
			background-color: #97a08d;
		}
	</style>
	<body>
	<%
		try{
			java.util.Date startDate = new java.util.Date();
		    java.sql.Timestamp sqlDate = new java.sql.Timestamp(startDate.getTime());
		    
		    java.util.Date endDate = startDate;
		    Calendar endTime_cal = Calendar.getInstance(); 
		    endTime_cal.setTime(endDate); 
		    endTime_cal.add(Calendar.DATE, 14);
		    
		    endDate = endTime_cal.getTime();
		    java.sql.Timestamp sqlDateEnd = new java.sql.Timestamp(endDate.getTime());
		    
		    out.print("startTime: " + sqlDate);
		    out.print("endTime: " + sqlDateEnd);
		    
			String game_name = request.getParameter("gameName");
			String genre = request.getParameter("genre");
			String platform = request.getParameter("platform");
			String condition = request.getParameter("condition");
			String total_players = request.getParameter("totalPlayers");
			String information = request.getParameter("information");
			int mild_violence =	Integer.parseInt(request.getParameter("mildViolence"));
			int mild_language =	Integer.parseInt(request.getParameter("mildLanguage"));
			float initial_price = Float.parseFloat(request.getParameter("startPrice"));
			float minimum_increase = Float.parseFloat(request.getParameter("minimumIncrement"));
			float minimum_sell = Float.parseFloat(request.getParameter("sellPrice"));
			String username = (String)session.getAttribute("userName");
			
			boolean badInput = false;
			if(game_name.equals("")){
				%>
					<script>
						alert("game name cannot be null!");
						window.location.href = "UserMenuAuctionsSell.jsp"
					</script>
				<%
				badInput = true;
			}
			if(minimum_sell < 0){
				%>
				<script>
					alert("minimum price cannot be less than zero");
					window.location.href = "UserMenuAuctionsSell.jsp"
				</script>
				<%
			badInput = true;
			}
			if(minimum_increase < 0){
				%>
				<script>
					alert("minimum increase cannot be less than zero");
					window.location.href = "UserMenuAuctionsSell.jsp"
				</script>
				<%
			badInput = true;
			}
			if(initial_price < 0){
				%>
				<script>
					alert("minimum sell price cannot be less than zero");
					window.location.href = "UserMenuAuctionsSell.jsp"
				</script>
				<%
			badInput = true;
			}
			if(game_name.length() > 50){
				%>
				<script>
					alert("game name cant be more that 50");
					window.location.href = "UserMenuAuctionsSell.jsp"
				</script>
				<%
			badInput = true;
			}
			
			if(!badInput){
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();

				//Create a SQL statement
				Statement stmt = con.createStatement();		
				
				//Check for item in database
				String temp1 = "SELECT V.* " +
				"FROM `VideoGame` V, `Everyone` E WHERE BINARY V.game_name = BINARY '" + game_name + "' AND " +
				"V.`genre` = '" + genre + "'  AND V.`platform` = '" + platform + "' AND V.`condition` = '" + condition + 
				"' AND V.`total_players` = '" + total_players + "' AND E.`mild_language` = '" + mild_language + "' AND E.`mild_violence` = '" + mild_violence +
				"' AND V.`gameID` = E.`gameID`";		
				
				ResultSet gameSearch = stmt.executeQuery(temp1);
				if(!gameSearch.next()){
					
					String maxID = "SELECT MAX(`gameID`) FROM `VideoGame`";
					ResultSet check_maxID = stmt.executeQuery(maxID);
					int new_gameID;
				    
					if(check_maxID.next()){
				    	new_gameID = check_maxID.getInt(1)+1;
				    }
				    else{
				    	new_gameID = 1;
				    }
					//insert into item
					String item_insert = "INSERT INTO `VideoGame`(`gameID`, `game_name`, `genre`, `platform`, `condition`, `total_players`)"
							+ " VALUES(?, ?, ?, ?, ?, ?)";
					PreparedStatement create_item = con.prepareStatement(item_insert);
					create_item.setInt(1, new_gameID);
					create_item.setString(2, game_name);
					create_item.setString(3, genre);
					create_item.setString(4, platform);
					create_item.setString(5, condition);
					create_item.setString(6, total_players);

					
					//insert into everybody
					String everybody_insert = "INSERT INTO `Everyone`(`gameID`, `mild_language`, `mild_violence`)"
							+ " VALUES(?, ?, ?)";
					PreparedStatement create_everybody = con.prepareStatement(everybody_insert);
					create_everybody.setInt(1, new_gameID);
					create_everybody.setInt(2, mild_language);
					create_everybody.setInt(3, mild_violence);
					
					
					//innsert into auction
					String auction_insert = "INSERT INTO `Auction`(`auctionID`, `gameID`, `dateCreated`, `dateClosing`, `initial_price`, `minimum_increase`, `buyer`, `seller`, `minimum_sell`, `sell_time`, `information`)"
							+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					PreparedStatement create_auction = con.prepareStatement(auction_insert);
					
					create_auction.setInt(1, 0);
					create_auction.setInt(2, new_gameID);
					create_auction.setTimestamp(3, sqlDate);
					create_auction.setTimestamp(4, sqlDateEnd);
					create_auction.setFloat(5, initial_price);
					create_auction.setFloat(6, minimum_increase);
					create_auction.setString(7, null);
					create_auction.setString(8, username);
					create_auction.setFloat(9, minimum_sell);
					create_auction.setTimestamp(10, null);
					create_auction.setString(11, information);
					
					create_item.executeUpdate();
					create_item.close();
					create_everybody.executeUpdate();
					create_everybody.close();
					create_auction.executeUpdate();
					create_auction.close();
				}else{
					int gameID = gameSearch.getInt("gameID");
					
					String temp_insert = "INSERT INTO `Auction`(`auctionID`, `gameID`, `dateCreated`, `dateClosing`, `initial_price`, `minimum_increase`, `buyer`, `seller`, `minimum_sell`, `sell_time`, `information`)"
							+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					
					PreparedStatement create_auction = con.prepareStatement(temp_insert);
					
					create_auction.setInt(1, 0);
					create_auction.setInt(2, gameID);
					create_auction.setTimestamp(3, sqlDate);
					create_auction.setTimestamp(4, sqlDateEnd);
					create_auction.setFloat(5, initial_price);
					create_auction.setFloat(6, minimum_increase);
					create_auction.setString(7, null);
					create_auction.setString(8, username);
					create_auction.setFloat(9, minimum_sell);
					create_auction.setTimestamp(10, null);
					create_auction.setString(11, information);
					create_auction.executeUpdate();
					create_auction.close();
				}
				stmt.close();
				con.close();
				%>		

				<script>
					alert("Auction successfully placed, returning to Auctions menu");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				
				<%
			}
		}catch(Exception ex){
			out.print("Error. Something went wrong in Everybody go back to selling");
			out.print(ex);
		}
	%>
	<br>
		<a href=UserMenuAuctionsSell.jsp>Back to the main site</a>
	</body>
</html>