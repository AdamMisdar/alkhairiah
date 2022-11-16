<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

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
		int committee_ID = 0;
		String committeeType = "";
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
			committeeType = (String)session.getAttribute("committeeType");
			isManager = (boolean)session.getAttribute("isManager");
		}
		
		int previewCommitteeID = Integer.parseInt(request.getParameter("previewCommitteeID"));
		String previewCommitteeType = request.getParameter("previewCommitteeType");
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		
		<%-- # START: CURRENT COMMITTEE DETAILS SQL # --%>
		
		<%-- SQL QUERY: Management Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
			SELECT m.committeeid AS "committeeid", m.committeefullname AS "committeefullname", m.committeeemail AS "committeeemail", m.committeephonenum AS "committeephonenum", 
			m.committeeaddress AS "committeeaddress", m.committeepassword AS "committeepassword", m.committeebirthdate AS "committeebirthdate", 
			m.managementposition AS "managementposition", c.committeefullname AS "managername" 
			FROM management m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = <%=committee_ID%>
		</sql:query> 	

		<%-- # END: CURRENT COMMITTEE DETAILS SQL # --%>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		<%-- All Committee --%>
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		
		<%-- Management Only --%>
		<% if(committeeType.equalsIgnoreCase("Management")) { %>
			<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
			<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
			<a href="client-list.jsp">Senarai Klien</a><br>
			<%-- Manager Only --%>
			<% if(isManager) { %>
				<a href="committee-list.jsp">Senarai AJK</a><br>
			<% } %>
		<% } %>
		
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br><br>
		<%-- # END: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<c:forEach var="manager" items="${resultCommittee.rows}">
			<span>PENGURUSAN (PENGURUS)</span><br>
            <span><c:out value="${manager.managementposition}"/></span><br>
            <span><c:out value="${manager.committeefullname}"/></span><br><br>
		</c:forEach>
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: PREVIEW COMMITTEE DETAILS SQL # --%>
		<%
		/* Management */
		if(previewCommitteeType.equalsIgnoreCase("Management")) { 
		%>
		
		<%-- SQL QUERY: Management Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="previewCommittee">
			SELECT m.committeeid AS "committeeid", m.committeefullname AS "committeefullname", m.committeeemail AS "committeeemail", m.committeephonenum AS "committeephonenum", 
			m.committeeaddress AS "committeeaddress", m.committeepassword AS "committeepassword", m.committeebirthdate AS "committeebirthdate", 
			m.managementposition AS "managementposition", c.committeefullname AS "managername" 
			FROM management m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = <%=previewCommitteeID%>
		</sql:query> 
			
		<%	 
		/* Voluntary */	
		} else if (previewCommitteeType.equalsIgnoreCase("Voluntary")) { 
		%>
				
		<%-- SQL QUERY: Voluntary Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="previewCommittee">
			SELECT m.committeeid AS "committeeid", m.committeefullname AS "committeefullname", m.committeeemail AS "committeeemail", m.committeephonenum AS "committeephonenum", 
			m.committeeaddress AS "committeeaddress", m.committeepassword AS "committeepassword", m.committeebirthdate AS "committeebirthdate", 
			m.voluntaryrole AS "voluntaryrole", m.hourlyrate AS "hourlyrate", c.committeefullname AS "managername" 
			FROM voluntary m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = <%=previewCommitteeID%>
		</sql:query>
		
		<% } %>
		<%-- # END: PREVIEW COMMITTEE DETAILS SQL # --%>
		
		<%-- # START: PREVIEW COMMITTEE'S ACCOUNT INFORMATION DISPLAY # --%>
		<br><br><h2>MAKLUMAT AKAUN</h2>
		
		<%-- Committee Account Details --%>
		<form method="post">
		<table>
			<c:forEach var="prevCommittee" items="${previewCommittee.rows}">
			<tr>
				<td>Nama</td>
				<td><c:out value="${prevCommittee.committeefullname}"/></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><c:out value="${prevCommittee.committeephonenum}"/></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><c:out value="${prevCommittee.committeebirthdate}"/></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><c:out value="${prevCommittee.committeeaddress}"/></td>
			</tr>
			
			<%-- Management --%>
			<% if(previewCommitteeType.equalsIgnoreCase("Management")) { %>
			<tr>
				<td>Jawatan</td>
				<td><c:out value="${prevCommittee.managementposition}"/></td>
			</tr>
			<c:if test="${prevCommittee.managementposition != 'Pengerusi'}">
				<tr>
					<td>Nama Pengurus</td>
					<td><c:out value="${prevCommittee.managername}"/></td>
				</tr>
			</c:if>
			<%-- Voluntary --%>
			<% } else if(previewCommitteeType.equalsIgnoreCase("Voluntary")) { %>
			<tr>
				<td>Peranan</td>
				<td><c:out value="${prevCommittee.voluntaryrole}"/></td>
			</tr>
			<tr>
				<td>Kadar Setiap Jam</td>
				<td><c:out value="RM${prevCommittee.hourlyrate}"/></td>
			</tr>
			<tr>
				<td>Nama Pengurus</td>
				<td><c:out value="${prevCommittee.managername}"/></td>
			</tr>
			<% } %>
			<tr>
				<td>Emel</td>
				<td><c:out value="${prevCommittee.committeeemail}"/></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" value="${prevCommittee.committeepassword}" readonly></td>
			</tr>
			</c:forEach>
		</table>
		<input type="hidden" name="previewCommitteeID" value="<%=previewCommitteeID%>">
		<input type="hidden" name="previewCommitteeType" value="<%=previewCommitteeType%>">
		<button name="back" formaction="committee-list.jsp">KEMBALI KE SENARAI</button>
		<button name="edit" formaction="edit-committee-account-manager.jsp">KEMASKINI AKAUN</button>
		</form>
		<%-- # END: COMMITTEE'S ACCOUNT INFORMATION DISPLAY # --%>
		
	</body>
</html>