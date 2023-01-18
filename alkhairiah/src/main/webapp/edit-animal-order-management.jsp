<%-- Pay attention to navigation elements --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Kemaskini Nama | Al-Khairiah</title>
	</head>
	<body>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int booking_ID = 0;
		int committee_ID = 0;
		int animalOrder_ID = 0;
		boolean isManager = false;
		String nextPage = "";
		
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
			booking_ID = (int)request.getAttribute("bookingID");
			animalOrder_ID = (int)request.getAttribute("animalOrderID");
			nextPage = (String)request.getAttribute("nextPage");
		}
		
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
		
		<%-- SQL QUERY: THIS SPECIFIC ANIMAL ORDER DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimalOrder">
			SELECT * from client
			JOIN booking
			USING (clientid)
			JOIN animalorder
			USING (bookingid)
			JOIN animaldetails
			USING (animaldetailsid)
			WHERE bookingid = <%= booking_ID %>
			AND animalorderid = <%= animalOrder_ID %>
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
		
		<%-- # START: ANIMAL ORDER UPDATE FORM # --%>
		<br><br><h2>KEMASKINI NAMA TEMPAHAN</h2>
		
		<p>ID Tempahan: <%= booking_ID %></p>
		
		<c:forEach var="booking" items="${resultAnimalOrder.rows}"><c:set var="clientFullName" value="${booking.clientfullname}"></c:set></c:forEach> 
		<p>Nama Klien: <c:out value="${clientFullName}"/></p> 
		
		<form method="post">
			<input type="hidden" name="bookingID" value="<%=booking_ID%>">
			<input type="hidden" name="animalOrderID" value="<%=animalOrder_ID%>">
			
		<table>
			<c:forEach var="animalOrder" items="${resultAnimalOrder.rows}">
			<tr>
				<td>Jenis Haiwan</td>
				<td><c:out value="${animalOrder.animaltype}"/></td>
			</tr>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="dependentName" value="${animalOrder.dependentname}" placeholder="Nama Tanggungan" required></td>
			</tr>
			</c:forEach>
		</table>
			<input type="hidden" name="nextPage" value="<%=nextPage%>"> 
			<button name="cancel" formaction="AnimalOrderHandler?action=cancelUpdate">BATAL</button>
			<button type="submit" formaction="AnimalOrderHandler?action=updateAnimalOrderCommittee">SIMPAN</button>	
		</form>
		<%-- # END: ANIMAL ORDER UPDATE FORM # --%>
	</body>
</html>