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
		<title>Place Bid!</title>
	</head>

	<body>

	<%	
		try{
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
			
			
			//this will be compared with the auction time to check to make sure the bid isnt over
			java.util.Date startDate = new java.util.Date();
		    java.sql.Timestamp sqlDate = new java.sql.Timestamp(startDate.getTime());
		   
		    
		    String aucID = "7";
		    		String aucTemp = request.getParameter("auctionID");
			//String rating = request.getParameter("rating");
			float amount = 200;
			//float amounttemp = Float.parseFloat(request.getParameter("amount"));
			float minimum_increase = 5;
					//Float.parseFloat(request.getParameter("minimum_increase"));
			String username = "testingone"; //(String)session.getAttribute("userName");
			
			boolean badInput = false;
			float old_amount = -1;
			float old_auto = -1;
			String old_bidder = "";
			out.println("point 1");
			String temp = "SELECT Bid.amount, Bid.bidder, Auction.minimum_increase, Auction.dateClosing, AutoBid.auctionID, AutoBid.max_amount FROM project.Bid, project.Auction, project.AutoBid WHERE Bid.auctionID =" + aucID + " AND Auction.auctionID = " + aucID + " AND AutoBid.auctionID = " + aucID + " GROUP BY Bid.amount ORDER BY 1 DESC";	
			ResultSet check_bid = stmt.executeQuery(temp);
			out.println("point 2");
			if(check_bid.next()){
				old_amount = check_bid.getFloat("amount");
				old_bidder = check_bid.getString("bidder");
				old_auto = check_bid.getFloat("max_amount");
				String time = check_bid.getString("dateClosing");
				out.println("point 3: "+ old_amount);
			
			if(old_amount >= amount){
				out.println("Error 1");
				%>
				<script>
					alert("old bid value greater");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				<%
				badInput = true;
			}
			
			if(amount <= minimum_increase + old_auto){
				out.println("Error 2");
				%>
				<script>
					alert("This bid is under the minimum amount.");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				<%
			badInput = true;
			}
			if((time).compareTo(sqlDate.toString()) < 0) {
				out.println("Error 3");
				%>
				<script>
					alert("This auction is already closed.");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				<%
				badInput = true;
			}
			

			
			}
			if(!badInput){
				out.println("point 4");
				//Check for item in database
				String temp1 = "";
				String temp2 = "";
				if(old_amount == -1) {
					out.println("point 5");
					 temp1 = "INSERT INTO `AutoBid` (`max_amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES('" + amount + "', '" + username + "',  '" + sqlDate + "','" + aucID + "')";
					 temp2 = "INSERT INTO `Bid` (`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES('" + (minimum_increase + old_auto) + "', '" + username + "',  '" + sqlDate + "','" + aucID + "')";	
					 
				}else{
					out.println("point 6");
				//	UPDATE AutoBid SET max_amount, bidder = " + username + ", time_of_bid = " + sqlDate + ", auctionID = " + aucID + " WHERE auctionID = " + aucID + " and max_amount = " + old_amount + " END	ELSE	BEGIN		END";
				
					 temp1 = "UPDATE `AutoBid` SET `max_amount`= '" + amount + "', `bidder`= '" + username + "', `time_of_bid`='" + sqlDate + "', `auctionID`='" + aucID + "' WHERE `auctionID`='" + aucID + "' and`max_amount`='" + old_auto+ "' and`bidder`='"+ old_bidder +"'";
					 temp2 = "INSERT INTO `Bid` (`amount`, `bidder`, `time_of_bid`, `auctionID`) VALUES('" + (minimum_increase + old_auto) + "', '" + username + "',  '" + sqlDate + "','" + aucID + "')";	
				}
				stmt.executeUpdate(temp2);
				
				out.print("amount: "+amount + " ");
				out.print("username: "+username+ " ");
				out.print("sqldate: " +sqlDate+ " ");

				out.print(aucID);

				stmt.executeUpdate(temp1);
				%>		

				<script>
					alert("Bid successfully placed, returning to Auctions menu");
					window.location.href = "UserMenuAuctions.jsp"
				</script>
				
				<%
				
			}
			else {
				out.println("bad INPUT");
			}
			check_bid.close();
			stmt.close();
			con.close();
		}catch(Exception ex){
			out.print("Error. Something went wrong placing bid");
			out.print(ex);
		}
	%>
	<br>
		<a href=UserMenu.jsp>Back to user menu</a>
	</body>
</html>