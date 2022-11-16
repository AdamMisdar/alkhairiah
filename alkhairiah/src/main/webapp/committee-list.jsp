<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Senarai AJK | Al-Khairiah</title>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int counter = 0; // for committee list display
		int committee_ID = 0;
		String query = "";
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("committeeID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			committee_ID = (int)session.getAttribute("committeeID");
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
		
		<%-- SQL QUERY: MANAGEMENT LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultManagement">
	   		SELECT committeeid, committeefullname, committeeemail, committeephonenum, managementposition AS "jobscope" FROM management
			WHERE committeefullname LIKE '%<%=query%>%' OR committeeemail LIKE '%<%=query%>%' OR committeephonenum LIKE '%<%=query%>%' OR managementposition LIKE '%<%=query%>%'
			ORDER BY committeeid
		</sql:query>
		
		<%-- SQL QUERY: VOLUNTARY LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultVoluntary">
			SELECT committeeid, committeefullname, committeeemail, committeephonenum, voluntaryrole AS "jobscope" FROM voluntary
			WHERE committeefullname LIKE '%<%=query%>%' OR committeeemail LIKE '%<%=query%>%' OR committeephonenum LIKE '%<%=query%>%' OR voluntaryrole LIKE '%<%=query%>%'
			ORDER BY committeeid
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
		<%-- Manager --%>
		<c:forEach var="manager" items="${resultCommittee.rows}">
			<span>PENGURUSAN (PENGURUS)</span><br>
            <span><c:out value="${manager.managementposition}"/></span><br>
            <span><c:out value="${manager.committeefullname}"/></span><br>
		</c:forEach>
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: COMMITTEE LIST CONTENT # --%>
		<br><br><h2>SENARAI AJK</h2>
		
		<%--SEARCH BAR--%>
		<form method="get">
			<input type="text" name="query" placeholder="Carian Ikut Nama/Emel/...">
			<button type="submit" formaction="committee-list.jsp">CARI</button>
			
			<input type="hidden" name="query" value="">
			<button type="submit" formaction="committee-list.jsp">KEMBALI</button>
		</form>
		<br>
		
		<%-- Committee List --%>
		<button name="add" onclick="location.href='registration-committee-choices.jsp'">TAMBAH AJK BARU</button>
		<br><br>
		
		<table>
			<tr>
				<th>No.</th>
				<th>Nama</th>
				<th>Emel</th>
				<th>No. Telefon</th>
				<th>Bahagian</th>
				<th>Skop Kerja</th>
				<th>Tindakan</th>
			</tr>
			<c:forEach var="management" items="${resultManagement.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${management.committeefullname}" /></td>
				<td><c:out value="${management.committeeemail}" /></td>
				<td><c:out value="${management.committeephonenum}" /></td>
				<td>Pengurusan</td>
				<td><c:out value="${management.jobscope}" /></td>
				<td>
					<form method="post">
						<input type="hidden" name="previewCommitteeType" value="Management">
						<input type="hidden" name="previewCommitteeID" value="${management.committeeid}">
						<button name="view" formaction="view-committee-account-manager.jsp">LIHAT</button>
						<c:if test="${management.jobscope != 'Pengerusi'}">
							<button name="delete" formaction="CommitteeHandler?action=deleteCommittee">PADAM</button>
						</c:if>
					</form>
				</td>
			</tr>
			</c:forEach>
			<c:forEach var="voluntary" items="${resultVoluntary.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${voluntary.committeefullname}" /></td>
				<td><c:out value="${voluntary.committeeemail}" /></td>
				<td><c:out value="${voluntary.committeephonenum}" /></td>
				<td>Sukarelawan</td>
				<td><c:out value="${voluntary.jobscope}" /></td>
				<td>
					<form method="post">
						<input type="hidden" name="previewCommitteeID" value="${voluntary.committeeid}">
						<input type="hidden" name="previewCommitteeType" value="Voluntary">
						<button name="view" formaction="view-committee-account-manager.jsp">LIHAT</button>
						<button name="delete" formaction="CommitteeHandler?action=deleteCommittee">PADAM</button>
					</form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<%-- # END: COMMITTEE LIST CONTENT # --%>

	</body>
</html>