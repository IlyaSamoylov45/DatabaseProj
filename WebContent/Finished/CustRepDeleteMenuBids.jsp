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
		<title>All Bids</title>
	</head>

	<body>
		<center>
			<font size = "13" color = "0e5938" >All Bids! </font>
		</center>

		<br>
		<center>
			<font size = "5" color = "0e5938" >Click to delete Bid!</font>
			<table border="2">
   			<tr>
       			<td>AuctionID</td>
        		<td>Bidder</td>
        		<td>Time of Bid</td>
        		<td>Max Amount</td>
        		<td>Delete</td>
   			</tr>
   			<%
   				try{
	 				//Get the database connection
					ApplicationDB db = new ApplicationDB();	
					Connection con = db.getConnection();

					//Create a SQL statement
					Statement stmt = con.createStatement();		
			
					//Check for username
					String temp = "SELECT * FROM `Bid` ORDER BY `Bid`.`auctionID` ASC";		
					ResultSet All_bids = stmt.executeQuery(temp);
				
       				while(All_bids.next()){
    	  				String auctionID = All_bids.getString("auctionID");
    	  				String bidder = All_bids.getString("bidder");
    	  				String time_of_bid = All_bids.getString("time_of_bid");
    	  				String amount = All_bids.getString("amount");
   			%>
           			 <tr>
            			<td><%=auctionID%></td>
						<td><%=bidder %></td>
						<td><%=time_of_bid %></td>
						<td><%=amount %></td>
							
						<td>
							<form method="post" action="CustRepDeleteMenuBidsQuery.jsp">
								<input type="hidden" name="auctionID" value="<%= auctionID %>" />
								<input type="hidden" name="bidder" value="<%= bidder %>" />
								<input type="hidden" name="amount" value="<%= amount %>" />
								<input id="button" type="submit" value="Delete" >
				   			 </form>
				   		</td>
					</tr>
   			<%
      				}
   			%>
   		</table>
   			<%
   			All_bids.close();
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
		<form method="post" action="LogOutCustRep.jsp">
			<input type="submit" value="Log Out">
		</form>
	</center>
	</body>
</html>