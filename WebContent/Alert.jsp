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
		<title>Place Alert!</title>
	</head>

	<body>

	<%	
		try{
			
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();		
   
		    String game_name = request.getParameter("game_name");
		    String auctionID = request.getParameter("auctionID");
			String username = (String)session.getAttribute("userName");
			
			boolean badInput = false;
			if(auctionID.equals("")){
				String temp1 = "SELECT * FROM VideoGame V WHERE BINARY game_name = BINARY'" + game_name + "'";
				ResultSet exists = stmt.executeQuery(temp1); 
				if(!exists.next()){
					%>	
					<script>
						alert("This game does not exist in our database");
						window.location.href = "UserMenuAuctionsBuy.jsp"
					</script>
					<%
				}
				else{
					java.util.Date startDate = new java.util.Date();
				    java.sql.Timestamp sqlDate = new java.sql.Timestamp(startDate.getTime());
					int gameID = exists.getInt("gameID");
					String temp2 = "INSERT INTO `Alert`(`username`, `auctionID`, `gameID`, `alertTime`) VALUES (?,?,?,?) ";
					String temp3 = "SELECT * FROM VideoGame V WHERE BINARY username = BINARY'" + username + "' AND gameID = '" + gameID + "'";
					ResultSet alreadyIn = stmt.executeQuery(temp3); 
					if(!alreadyIn.next()){
						PreparedStatement insert_alert = con.prepareStatement(temp2);
						insert_alert.setString(1, username);
						insert_alert.setString(2, "null");
						insert_alert.setInt(3, gameID);
						insert_alert.setTimestamp(4, sqlDate);
						insert_alert.executeUpdate();
						insert_alert.close();
						%>	
						<script>
							alert("Alert successfully placed, returning to Auctions menu");
							window.location.href = "UserMenuAuctionsBuy.jsp"
						</script>
						<%
					}
					else{%>
						<script>
							alert("Alert successfully placed, returning to Auctions menu");
							window.location.href = "UserMenuAuctionsBuy.jsp"
						</script>
					<%}
					alreadyIn.close();
				}
				badInput = true;
				exists.close();
			}
			String temp1 = "SELECT * FROM VideoGame V WHERE BINARY game_name = BINARY'" + game_name + "'";
			if(!badInput){
				java.util.Date startDate = new java.util.Date();
			    java.sql.Timestamp sqlDate = new java.sql.Timestamp(startDate.getTime());
				 temp1 = "SELECT * FROM VideoGame V WHERE BINARY game_name = BINARY'" + game_name + "'";
				ResultSet exists = stmt.executeQuery(temp1); 
				exists.next();
				int gameID = exists.getInt("gameID");
				//Check for item in database
				String temp2 = "INSERT INTO `Alert`(`username`, `auctionID`, `gameID`, `alertTime`) VALUES(?,?,?,?)";
				String temp3 = "SELECT * FROM Alert A WHERE BINARY A.`username` = BINARY '" + username + "' AND A.`gameID` = '" + gameID + "'";
				ResultSet alreadyIn = stmt.executeQuery(temp3); 
				if(!alreadyIn.next()){
					PreparedStatement insert_alert = con.prepareStatement(temp2);
					insert_alert.setString(1, username);
					insert_alert.setString(2, auctionID);
					insert_alert.setInt(3, gameID);
					insert_alert.setTimestamp(4, sqlDate);
					insert_alert.executeUpdate();
					insert_alert.close();
					%>		
						<script>
							alert("Alert successfully placed, returning to Auctions menu");
							window.location.href = "UserMenuAuctionsBuy.jsp"
						</script>
					<%
				}
				else{%>
				<script>
					alert("Alert already exists");
					window.location.href = "UserMenuAuctionsBuy.jsp"
				</script>
				<%}
				alreadyIn.close();
				        
			}
			stmt.close();
			con.close();
		}catch(Exception ex){
			out.print("Error. Something went wrong placing alert");
			out.print(ex);
		}
	%>
	<br>
		<a href=UserMenuAuctionsBuy.jsp>Back to user menu</a>
	</body>
</html>