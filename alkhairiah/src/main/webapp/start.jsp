<%-- JUST REDIRECT, NO NEED CSS --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title></title>
	</head>
	<body>
		<% 
		RequestDispatcher toPage;
		//toPage = request.getRequestDispatcher("PaymentHandler?action=getApplicationPath");
		toPage = request.getRequestDispatcher("login.jsp");
		toPage.forward(request, response);
		%>
	</body>
</html>