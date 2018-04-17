<%--Author: Mahim Gupta --%><%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need --><%@ page import="java.io.*,java.util.*,java.sql.*"%><%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<title>Best Selling Items</title>
		</head>
		<body>
		<center>
		<p style="font-size:50px;">Best-Selling Items Report</p>
		
		<%
              	try{
              		//Get the database connection
                        ApplicationDB db = new ApplicationDB();	
                        
                        Connection con = db.getConnection();
                      
                        //Create a SQL statement
                        Statement stmt = con.createStatement();
                        
                        
                    
             
                  //  String sqlStr = "SELECT A.gameID, COUNT(A.gameID), A.auctionID, B.auctionID, MAX(B.amount) FROM Bid B, Auction A WHERE A.buyer <> NULL AND A.auctionID = B.auctionID GROUP BY A.gameID ORDER BY 1 DESC";
                     String sqlStr = "SELECT Auction.gameID, Auction.auctionID FROM Auction WHERE Auction.buyer IS NOT NULL";
                  // for debugging
                  // System.out.println("Query statement is " + sqlStr);
                 
                    ResultSet rset = stmt.executeQuery(sqlStr);
                    
                    float total = 0;
                    String[] gameIDs = new String[10];
                    int[] sold = new int[10];
                    int x = 0;
                    ResultSet rsetcpy = stmt.executeQuery(sqlStr);
                  
                   
                    rsetcpy.next();
                    
                    
                    String temp =rsetcpy.getString("gameID"); 
                
                    gameIDs[0] = temp;
                    sold[0]++;

                    	while(rsetcpy.next() && x < 10){
                    		String temp1 =rsetcpy.getString("gameID"); 
                    		
	                    		if(temp1.equals(gameIDs[x])) {
		                        	sold[x]++;
	                    		}
	                    		else{
	                    			x++;
	                            	gameIDs[x] = temp1;
	                            	sold[x]++;
	                    		}
                    			
                    		}
							for(int i = 0; i <= 9; i++){
                    		
	   							if(gameIDs[i] == null) {
	   							
			   						gameIDs[i] = "NoItem";
			   						sold[i] = 0;
	   							}
   							}
                    	 %>
			<table border="2">
				<tr>
					<td><%=gameIDs[0]%>
					</td>
					<td><%=gameIDs[1]%>
					</td>
					<td><%=gameIDs[2]%>
					</td>
					<td><%=gameIDs[3]%>
					</td>
					<td><%=gameIDs[4]%>
					</td>
					<td><%=gameIDs[5]%>
					</td>
					<td><%=gameIDs[6]%>
					</td>
					<td><%=gameIDs[7]%>
					</td>
					<td><%=gameIDs[8]%>
					</td>
					<td><%=gameIDs[9]%>
					</td>
				</tr>
				<tr>
					<td><%=sold[0]%>
					</td>
					<td><%=sold[1]%>
					</td>
					<td><%=sold[2]%>
					</td>
					<td><%=sold[3]%>
					</td>
					<td><%=sold[4]%>
					</td>
					<td><%=sold[5]%>
					</td>
					<td><%=sold[6]%>
					</td>
					<td><%=sold[7]%>
					</td>
					<td><%=sold[8]%>
					</td>
					<td><%=sold[9]%>
					</td>
				</tr>
			</table>
			</center>
			
			<br>
				<form method="post" action="SummaryReports.jsp">
					<input type="submit" value="Back">
					</form><% 
                        rset.close();
                        rsetcpy.close();
               			stmt.close();
            			con.close();
                    
                    }catch(Exception ex){
        			out.print("Error. Something went wrong placing bid");
        			out.print(ex);
        		}
                    
  				%>
		</body>
	</html>