<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Senarai Maklumat Haiwan | Al-Khairiah</title>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
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
		                   
		<%-- SQL QUERY: ANIMAL DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimal">
	   		SELECT * FROM animaldetails 
	   		WHERE animaltype LIKE '%<%=query%>%' OR CAST(animalprice AS VARCHAR) LIKE '%<%=query%>%'
	   		ORDER BY animaltype
		</sql:query>
		
		<%-- SQL QUERY: CURRENT COMMITTEE DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
	   		SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_ID %>
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
		
		<%-- # START: ANIMAL DETAILS CONTENT # --%>
		<br><br><h2>SENARAI HAIWAN</h2>
		
		<%--SEARCH BAR--%>
		<form method="get">
			<input type="text" name="query" placeholder="Carian">
			<button type="submit" formaction="animal-details-list.jsp">CARI</button>
			
			<input type="hidden" name="query" value="">
			<button type="submit" formaction="animal-details-list.jsp">KEMBALI</button>
		</form>
		<br>
		
		<%-- ANIMAL DETAILS TABLE --%>
		<button name="create" onclick="location.href='create-animal-details.jsp'">TAMBAH HAIWAN</button><br><br>
		
		<table>
			<tr>
				<td>Jenis Haiwan</td>
				<td>Harga Seekor (RM)</td>
				<td></td>
			</tr>
			<c:forEach var="animal" items="${resultAnimal.rows}">
			<tr>
				<td><c:out value="${animal.animaltype}"/></td>
				<td><c:out value="${animal.animalprice}"/></td>
				<td>
					<form method="post">
						<input type="hidden" name="animalDetailsID" value="${animal.animaldetailsid}">
						<button name="edit" formaction="edit-animal-details.jsp">KEMASKINI HARGA</button>
						<button name="delete" formaction="AnimalDetailsHandler?action=deleteAnimalDetails">PADAM</button>
					</form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<%-- # END: ANIMAL DETAILS CONTENT # --%>
	</body>
</html>