<%--Author: Mahim Gupta --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<font size = "5" color = "0e5938" >Information</font>
			<table border="2">
   			<tr>
       			<td>Rated Everyone: </td>
       			<td>Rated Teen: </td>
       			<td>Rated Mature: </td>
       			
   			</tr>
 <%
	try{
		
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();		
		
            
 
        String sqlStrE = "SELECT E.gameID, A.auctionID, B.auctionID, MAX(B.amount), A.gameID* FROM Bid b, Auction A, Everyone E WHERE E.gameID = A.gameID  AND A.auctionID = B.auctionID GROUP BY A.auctionID";
        String sqlStrM = "SELECT M.gameID, A.auctionID, B.auctionID, MAX(B.amount), A.gameID* FROM Bid b, Auction A, Mature M WHERE M.gameID = A.gameID AND A.auctionID = B.auctionID GROUP BY A.auctionID";
        String sqlStrT = "SELECT T.gameID, A.auctionID, B.auctionID, MAX(B.amount), A.gameID* FROM Bid b, Auction A, Teen T WHERE T.gameID = A.gameID AND A.auctionID = B.auctionID GROUP BY A.auctionID";

      // for debugging
        System.out.println("Query statement is " + sqlStrE);
        System.out.println("Query statement is " + sqlStrM);
        System.out.println("Query statement is " + sqlStrT);
        ResultSet rsetE = stmt.executeQuery(sqlStrE);
        ResultSet rsetM = stmt.executeQuery(sqlStrM);
        ResultSet rsetT = stmt.executeQuery(sqlStrT);
        float totalE = 0;
        float totalM = 0;
        float totalT = 0;
        while(rsetE.next()){
            totalE += rsetE.getFloat("amount");
        }
        while(rsetM.next()){
            totalM += rsetM.getFloat("amount");
        }
        while(rsetT.next()){
            totalT += rsetT.getFloat("amount");
        }
        %>
        <tr>
           			<td><%=totalE%></td>
           			<td><%=totalT %></td>
						<td><%=totalM %></td>
						
					</tr>
					</table>
       <% 
        
       	System.out.println("TOTAL EVERYONE: " + totalE + ", TOTAL MATURE: " + totalM + ", TOTAL TEEN: " + totalT);
       rsetE.close();
       rsetM.close();
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