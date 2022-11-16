<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Senarai Klien | Al-Khairiah</title>
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
		
		<%-- SQL QUERY: CLIENT LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
	   		SELECT * FROM client 
	   		WHERE clientfullname LIKE '%<%=query%>%' OR clientemail LIKE '%<%=query%>%' OR clientphonenum LIKE '%<%=query%>%'
	   		ORDER BY clientfullname
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
		
		<%-- # START: CLIENT LIST CONTENT # --%>
		<br><br><h2>SENARAI KLIEN</h2>
		
		<%--SEARCH BAR--%>
		<form method="get">
			<input type="text" name="query" placeholder="Carian Ikut Nama/Emel/...">
			<button type="submit" formaction="client-list.jsp">CARI</button>
			
			<input type="hidden" name="query" value="">
			<button type="submit" formaction="client-list.jsp">KEMBALI</button>
		</form>
		<br>
		
		<%-- Client list --%>
		<table>
			<tr>
				<th>No.</th>
				<th>Nama</th>
				<th>Emel</th>
				<th>No. Telefon</th>
				<th>Tindakan</th>
			</tr>
			<c:forEach var="client" items="${resultClient.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${client.clientfullname}"/></td>
				<td><c:out value="${client.clientemail}"/></td>
				<td><c:out value="${client.clientphonenum}"/></td>
				<td>
					<form method="post">
						<input type="hidden" name="clientID" value="${client.clientid}">
						<button name="view" formaction="view-client-account-management.jsp">LIHAT</button>
						<button name="delete" formaction="ClientHandler?action=deleteClient">PADAM</button>
					</form>
				</td>
			</tr>
			</c:forEach>	
		</table>
		<%-- # END: CLIENT LIST CONTENT # --%>
	</body>
</html>