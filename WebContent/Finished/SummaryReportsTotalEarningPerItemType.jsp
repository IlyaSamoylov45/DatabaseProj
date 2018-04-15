<%--Author: Mahim Gupta --%><%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need --><%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>Insert title here</title>
		</head>
		<body>
			<center>
				<p style="font-size:50px;">Rating Earnings Report</p>
			<table border="2">
				<tr>
					<td>Rated Everyone: </td>
					<td>Rated Teen: </td>
					<td>Rated Mature: </td>
				</tr><%
	try{
		
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();		
		
            
 
        String sqlStrE = "SELECT Everyone.gameID, Auction.auctionID, Bid.auctionID, Bid.amount FROM Bid, Auction, Everyone WHERE Everyone.gameID = Auction.gameID  AND Auction.auctionID = Bid.auctionID AND Auction.buyer IS NOT NULL GROUP BY Auction.auctionID HAVING MAX(Bid.amount);";
        String sqlStrM = "SELECT Mature.gameID, Auction.auctionID, Bid.auctionID, Bid.amount FROM Bid, Auction, Mature WHERE Mature.gameID = Auction.gameID  AND Auction.auctionID = Bid.auctionID AND Auction.buyer IS NOT NULL GROUP BY Auction.auctionID HAVING MAX(Bid.amount)";
        String sqlStrT = "SELECT Teen.gameID, Auction.auctionID, Bid.auctionID, Bid.amount FROM Bid, Auction, Teen WHERE Teen.gameID = Auction.gameID  AND Auction.auctionID = Bid.auctionID AND Auction.buyer IS NOT NULL GROUP BY Auction.auctionID HAVING MAX(Bid.amount)";

       // for debugging
       // System.out.println("Query statement is " + sqlStrE);
       //  System.out.println("Query statement is " + sqlStrM);
       // System.out.println("Query statement is " + sqlStrT);
        ResultSet rsetE = stmt.executeQuery(sqlStrE);
        
        float totalE = 0;
        float totalM = 0;
        float totalT = 0;
        
    	
    	//out.print("point1");
        while(rsetE.next()){
        	 
            totalE += rsetE.getFloat("amount");
           
       }
            rsetE.close();
            ResultSet rsetM = stmt.executeQuery(sqlStrM);
           
       
        while(rsetM.next()){
            totalM += rsetM.getFloat("amount");
        }
        
        rsetM.close();
        ResultSet rsetT = stmt.executeQuery(sqlStrT);
        while(rsetT.next()){
            totalT += rsetT.getFloat("amount");
        }
        if(totalE < 0 || totalT < 0 || totalM < 0 ){
			%>
				<script>
				alert("Error calculating earnings");
				window.location.href = "SummaryReports.jsp"
			</script><%
			
		}
		
    
        %>
				<tr>
					<td><%=totalE%>
					</td>
					<td><%=totalT %>
					</td>
					<td><%=totalM %>
					</td>
				</tr>
			</table>
			</center>
			<form method="post" action="SummaryReports.jsp">
					<input type="submit" value="Back">
					</form><% 
        
       
      
       rsetT.close();
			stmt.close();
		con.close();
	}catch(Exception ex){
		out.print("Error. Something went wrong placing bid");
		out.print(ex);
	}
  %>
		</body>
	</html>