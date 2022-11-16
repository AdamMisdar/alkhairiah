<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Daftar AJK Pengurusan | Al-Khairiah</title>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int committee_ID = 0;
		String committeeType = ""; 
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("committeeID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			committee_ID = (int)session.getAttribute("committeeID");
			committeeType = (String)session.getAttribute("committeeType");
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
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAVIGATION ELEMENTS # --%>
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
		<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
		<a href="client-list.jsp">Senarai Klien</a><br>
		<a href="committee-list.jsp">Senarai AJK</a><br>
		<a href="LoginHandler?action=logout">Log Keluar</a><br>
		<%-- # END: NAVIGATION ELEMENTS # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<br><br>
		<c:forEach var="manager" items="${resultCommittee.rows}">
			<span>PENGURUSAN (PENGURUS)</span><br>
            <span><c:out value="${manager.managementposition}"/></span><br>
            <span><c:out value="${manager.committeefullname}"/></span><br>
		</c:forEach>
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: CHOOSE COMMITTEE TYPE # --%>
		<br><br><h2>Pilih Jenis AJK</h2>
		<button name="management" onclick="location.href='registration-committee-management.jsp'">PENGURUSAN</button>
		<button name="voluntary" onclick="location.href='registration-committee-voluntary.jsp'">SUKARELAWAN</button>
		<br><br>
		<button name="back" onclick="location.href='committee-list.jsp'">KEMBALI KE SENARAI</button>
		<%-- # END: CHOOSE COMMITTEE TYPE # --%>
	</body>
</html>