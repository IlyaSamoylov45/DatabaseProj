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
       			<td>Total Earnings </td>
       		
       			
   			</tr>
   <%
                 try{
             		
             		
             		//Get the database connection
             		ApplicationDB db = new ApplicationDB();	
             		Connection con = db.getConnection();

             		//Create a SQL statement
             		Statement stmt = con.createStatement();		 
              		out.println("Point 1");
                     String sqlStrE = "SELECT Auction.auctionID, Bid.amount FROM Auction, Bid WHERE Bid.auctionID = Auction.auctionID HAVING MAX(Bid.amount)";
                    
                   // for debugging
                     System.out.println("Query statement is " + sqlStrE);
                     out.println("Point 2");
               
                     ResultSet rset = stmt.executeQuery(sqlStrE);
                     out.println("Point 3");

                     float total = 0;
                     while(rset.next()){
                         total += rset.getFloat("amount");
                     }
                     out.println("Point 4");
                    %>
                     <tr>
					<td><%=total%></td>
				
				
				</tr>
				</table>
                    
                    <%
                     
                    rset.close();
                  
           			stmt.close();
        			con.close(); 
             	}catch(Exception ex){
             		out.println("Error. Something went wrong placing bid");
             		out.println(ex);
             	}
  
               %>
</body>
</html>