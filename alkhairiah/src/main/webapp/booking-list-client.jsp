<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Senarai Tempahan | Al-Khairiah</title>
	</head>
	<body>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		int counter = 0;
		String query = "";
		
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
		
		if(request.getParameter("query") != null)
			query = request.getParameter("query");
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
		
		<%-- SQL QUERY: BOOKING LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultBooking">
			SELECT *
			FROM payment
			JOIN booking
			USING (bookingid)
			WHERE clientid = <%= client_ID %>
			AND (CAST(bookingdate AS VARCHAR) LIKE '%<%=query%>%' OR CAST(paymenttotal AS VARCHAR) LIKE '%<%=query%>%')
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
		
		<%-- # START: BOOKING LIST # --%>
		<br><br><h2>SENARAI TEMPAHAN KORBAN</h2>
		
		<%--SEARCH BAR--%>
		<form method="get">
			<input type="text" name="query" placeholder="Carian">
			<button type="submit" formaction="booking-list-client.jsp">CARI</button>
			
			<input type="hidden" name="query" value="">
			<button type="submit" formaction="booking-list-client.jsp">KEMBALI</button>
		</form>
		<br>
		
		<%-- Booking List --%>
		<form method="post">
		<table>
			<tr>
				<td>No.</td>
				<td>Tarikh Tempahan</td>
				<td>Harga Tempahan (RM)</td>
				<td></td>
			</tr>
			<c:forEach var="booking" items="${resultBooking.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${booking.bookingdate}"/></td>
				<td><fmt:formatNumber type="number" maxFractionDigits="2" value="${booking.paymentTotal}"/></td>
				<td>
					<input type="hidden" name="bookingID" value="${booking.bookingid}">
					<button name="view" formaction="BookingHandler?action=viewBooking&bookingID=${booking.bookingid}">LIHAT</button>
				</td>
			</tr>
			</c:forEach>
		</table>
		</form>
		<%-- # END: BOOKING LIST # --%>
		
	</body>
</html>