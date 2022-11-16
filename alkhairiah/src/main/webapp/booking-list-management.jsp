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
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int counter = 0;
		int committee_ID = 0;
		String query = "";
		boolean isManager = false;
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("committeeID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			committee_ID = (int)session.getAttribute("committeeID");
			isManager = (boolean)session.getAttribute("isManager");
		} 
		
		if(request.getParameter("query") != null)
			query = request.getParameter("query");
		
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		                   
		<%-- SQL QUERY: CURRENT COMMITTEE DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
	   		SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_ID %>
		</sql:query>
		
		<%-- SQL QUERY: BOOKING LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultBooking">
			SELECT COUNT(o.animalorderid) AS "totalparts", b.bookingid AS "bookingid", c.clientfullname AS "clientfullname", b.bookingdate AS "bookingdate", p.paymenttotal AS "paymenttotal"
			FROM client c
			JOIN booking b
			USING (clientid)
			JOIN payment p
			USING (bookingid)
			JOIN animalorder o
			USING (bookingid)
			JOIN animaldetails d
			USING (animaldetailsid)
			WHERE c.clientfullname LIKE '%<%=query%>%' OR CAST(b.bookingdate AS VARCHAR) LIKE '%<%=query%>%' OR CAST(p.paymenttotal AS VARCHAR) LIKE '%<%=query%>%'
			GROUP BY b.bookingid, c.clientfullname, b.bookingdate,  p.paymenttotal
			ORDER BY b.bookingid
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAVIGATION ELEMENTS # --%>
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
		<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
		<a href="client-list.jsp">Senarai Klien</a><br>
		<% if(isManager) { /* If committee is Manager */%>
			<a href="committee-list.jsp">Senarai AJK</a><br>
			
		<% } %>
		<a href="LoginHandler?action=logout">Log Keluar</a><br>
		<%-- # END: NAVIGATION ELEMENTS # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<br><br>
		<%-- Manager --%>
		<% if(isManager) {%>
			<c:forEach var="manager" items="${resultCommittee.rows}">
				<span>PENGURUSAN (PENGURUS)</span><br>
            	<span><c:out value="${manager.managementposition}"/></span><br>
            	<span><c:out value="${manager.committeefullname}"/></span><br>
			</c:forEach>
			
		<%-- Ordinary Management --%>
		<% } else { %>
			<c:forEach var="committee" items="${resultCommittee.rows}">
				<span>PENGURUSAN</span><br>
            	<span><c:out value="${committee.managementposition}"/></span><br>
            	<span><c:out value="${committee.committeefullname}"/></span><br>
			</c:forEach>
		<% } %>
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: BOOKING LIST # --%>
		<br><br><h2>SENARAI TEMPAHAN KORBAN</h2>
		
		<%--SEARCH BAR--%>
		<form method="get">
			<input type="text" name="query" placeholder="Carian">
			<button type="submit" formaction="booking-list-management.jsp">CARI</button>
			
			<input type="hidden" name="query" value="">
			<button type="submit" formaction="booking-list-management.jsp">KEMBALI</button>
		</form>
		<br>
		
		<%-- Booking List --%>
		<form method="post">
		<table>
			<tr>
				<td>No.</td>
				<td>Nama Klien</td>
				<td>Jumlah Bahagian Ditempah</td>
				<td>Tarikh Tempahan</td>
				<td>Harga Tempahan (RM)</td>
				<td></td>
			</tr>
			<c:forEach var="booking" items="${resultBooking.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${booking.clientfullname}"/></td>
				<td><c:out value="${booking.totalparts}"/></td>
				<td><c:out value="${booking.bookingdate}"/></td>
				<td><fmt:formatNumber type="number" maxFractionDigits="2" value="${booking.paymentTotal}"/></td>
				<td>
					<input type="hidden" name="nextPage" value="viewBookingManagement">
					<button name="view" formaction="BookingHandler?action=viewBookingCommittee&bookingID=${booking.bookingid}">LIHAT</button>
				</td>
			</tr>
			</c:forEach>
		</table>
		</form>
		<%-- # END: BOOKING LIST # --%>
		
	</body>
</html>