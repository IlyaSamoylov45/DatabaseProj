<%--Author: Ilya Samoylov --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


<%
	session.setAttribute("firstName", null);
	session.setAttribute("lastName", null);
	session.setAttribute("email", null);
	session.setAttribute("userName", null);
	session.setAttribute("address", null);

	session.invalidate();
	response.sendRedirect("Login.jsp");
%>
