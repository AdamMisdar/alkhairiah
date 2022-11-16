<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Akaun | Al-Khairiah</title>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		int committee_ID = 0;
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
		
		if (request.getParameter("clientID") == null)
			client_ID = (int)request.getAttribute("clientID");
		else
			client_ID = Integer.parseInt(request.getParameter("clientID"));
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
		
		<%-- SQL QUERY: CLIENT INFORMATION --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
	   		SELECT * FROM client WHERE clientid = <%= client_ID %>
		</sql:query>
		
		<%-- SQL QUERY: CLIENT BOOKING(S) --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultBooking">
	   		SELECT * FROM payment
	   		JOIN booking
	   		USING (bookingid) 
	   		WHERE clientid = <%= client_ID %>
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
		
		<%-- # START: CLIENT'S ACCOUNT DISPLAY # --%>
		<br><br><h2>MAKLUMAT AKAUN</h2>
		
		<%-- Client Account Details --%>
		<form method="post">
		<c:forEach var="client" items="${resultClient.rows}">
		<table>
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
		</table>
		<input type="hidden" name="clientID" value="${client.clientid}">
		</c:forEach>
		
		<button name="back" formaction="client-list.jsp">KEMBALI KE SENARAI</button>
		<button name="edit" formaction="edit-client-account-management.jsp">KEMASKINI AKAUN</button>
		<button name="delete" formaction="ClientHandler?action=deleteClient">PADAM AKAUN INI</button>
		</form>
		<%-- # END: CLIENT'S ACCOUNT DISPLAY # --%>
		
		
		<%-- # END: BOOKING(S) BY THIS CLIENT # --%>
		
	</body>
</html>