<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Tambah Haiwan Baru | Al-Khairiah</title>
	</head>
	<body>
	<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int committee_ID = 0;
		boolean isManager = false; // edit to false
		
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
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		                   
		<%-- SQL QUERY: ANIMAL DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimal">
	   		SELECT * FROM animaldetails ORDER BY animaldetailsid
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
		
		<%-- # START: CREATE ANIMAL DETAILS FORM --%>
		<br><br><h2>TAMBAH HAIWAN BARU</h2>
		
		<form method="post">
			<table>
				<tr>
					<th>Informasi</th>
					<th></th>
				</tr>
				<tr>
					<td>Jenis Haiwan</td>
					<td>
						<select name="animalType">
							<option value="Kambing">Kambing</option>
							<option value="Lembu">Lembu</option>
							<option value="Unta">Unta</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Harga Seekor (RM)</td>
					<td><input type="number" step="any" name="animalPrice" value="" placeholder="Harga(RM) XXXX.XX"></td>
				</tr>
			</table>
			<button name="cancel" formaction="animal-details-list.jsp">BATAL</button>
			<button type="submit" formaction="AnimalDetailsHandler?action=createAnimalDetails">TAMBAH</button>
		</form>
		<%-- # END: CREATE ANIMAL DETAILS FORM --%>
	</body>
</html>