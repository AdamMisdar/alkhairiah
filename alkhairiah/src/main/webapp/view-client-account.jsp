<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Akaun | Al-Khairiah</title>
	</head>
	<body>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		
		/* Current Date */
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("clientID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			client_ID = (int)session.getAttribute("clientID");
		} 
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		
		<%-- SQL QUERY: CLIENT DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
			SELECT * FROM client WHERE clientid = <%=client_ID%>
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
		<a href="index-client.jsp">Laman Utama</a><br>
		<a href="view-client-account.jsp">Akaun</a><br>
		<a href="BookingHandler?action=createBooking">Buat Tempahan</a><br>
		<a href="booking-list-client.jsp">Senarai Tempahan</a><br>
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br>
				
		<%-- CLIENT INFO DISPLAY --%>
		KLIEN <br><c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach><br>
		
		<%-- # START: CLIENT ACCOUNT DISPLAY # --%>
		<br><br><h2>MAKLUMAT AKAUN</h2>
		
		<%-- Client Account Details --%>
		<table>
			<c:forEach var="client" items="${resultClient.rows}">
			<tr>
				<td>Nama</td>
				<td><c:out value="${client.clientfullname}"/></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><c:out value="${client.clientphonenum}"/></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><c:out value="${client.clientemail}"/></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><c:out value="${client.clientbirthdate}"/></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><c:out value="${client.clientaddress}"/></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" value="${client.clientpassword}" readonly></td>
			</tr>
			</c:forEach>
		</table>
		<button name="edit" onclick="location.href='edit-client-account.jsp'">KEMASKINI AKAUN</button>
		<%-- # END: CLIENT ACCOUNT DISPLAY # --%>
		
	</body>
</html>