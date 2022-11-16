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
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		
		<%-- # START: CURRENT COMMITTEE DETAILS SQL # --%>
		<%
		/* Management */
		if(committeeType.equalsIgnoreCase("Management")) { 
		%>
		
		<%-- SQL QUERY: Management Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
			SELECT m.committeeid AS "committeeid", m.committeefullname AS "committeefullname", m.committeeemail AS "committeeemail", m.committeephonenum AS "committeephonenum", 
			m.committeeaddress AS "committeeaddress", m.committeepassword AS "committeepassword", m.committeebirthdate AS "committeebirthdate", 
			m.managementposition AS "managementposition", c.committeefullname AS "managername" 
			FROM management m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = <%=committee_ID%>
		</sql:query> 
			
		<%	 
		/* Voluntary */	
		} else if (committeeType.equalsIgnoreCase("Voluntary")) { 
		%>
				
		<%-- SQL QUERY: Voluntary Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
			SELECT m.committeeid AS "committeeid", m.committeefullname AS "committeefullname", m.committeeemail AS "committeeemail", m.committeephonenum AS "committeephonenum", 
			m.committeeaddress AS "committeeaddress", m.committeepassword AS "committeepassword", m.committeebirthdate AS "committeebirthdate", 
			m.voluntaryrole AS "voluntaryrole", m.hourlyrate AS "hourlyrate", c.committeefullname AS "managername" 
			FROM voluntary m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = <%=committee_ID%>
		</sql:query>
		
		<% } %>
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
		<%-- Management --%>
		<% if(committeeType.equalsIgnoreCase("Management")) { %>
		
		<c:forEach var="management" items="${resultCommittee.rows}">
			<% if(isManager) { /* If this is a Manager */%>
				<span>PENGURUSAN (PENGURUS)</span><br>
			<% } else { /* If this is an ordinary management committee */%>
				<span>PENGURUSAN</span><br>
			<% } %>
            <span><c:out value="${management.managementposition}"/></span><br>
            <span><c:out value="${management.committeefullname}"/></span><br><br>
		</c:forEach>
		
		<%-- Voluntary --%>
		<% } else if(committeeType.equalsIgnoreCase("Voluntary")) { %>
		
		<c:forEach var="voluntary" items="${resultCommittee.rows}">
			<span>SUKARELAWAN<br></span>
            <span><c:out value="${voluntary.voluntaryRole}"/></span><br>
            <span><c:out value="${voluntary.committeefullname}"/></span><br><br>
		</c:forEach>
		
		<% } %>
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: COMMITTEE'S ACCOUNT INFORMATION DISPLAY # --%>
		<br><br><h2>MAKLUMAT AKAUN</h2>
		
		<%-- Committee Account Details --%>
		<table>
			<c:forEach var="committee" items="${resultCommittee.rows}">
			<tr>
				<td>Nama</td>
				<td><c:out value="${committee.committeefullname}"/></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><c:out value="${committee.committeephonenum}"/></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><c:out value="${committee.committeebirthdate}"/></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><c:out value="${committee.committeeaddress}"/></td>
			</tr>
			
			<%-- Management --%>
			<% if(committeeType.equalsIgnoreCase("Management")) { %>
			<tr>
				<td>Jawatan</td>
				<td><c:out value="${committee.managementposition}"/></td>
			</tr>
			<% if(!isManager) { %>
			<tr>
				<td>Nama Pengurus</td>
				<td><c:out value="${committee.managername}"/></td>
			</tr>
			
			<%-- Voluntary --%>
			<% } } else if(committeeType.equalsIgnoreCase("Voluntary")) { %>
			<tr>
				<td>Peranan</td>
				<td><c:out value="${committee.voluntaryrole}"/></td>
			</tr>
			<tr>
				<td>Kadar Setiap Jam</td>
				<td><c:out value="RM${committee.hourlyrate}"/></td>
			</tr>
			<% } %>
			<tr>
				<td>Emel</td>
				<td><c:out value="${committee.committeeemail}"/></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" value="${committee.committeepassword}" readonly></td>
			</tr>
			</c:forEach>
		</table>
		
		<button name="edit" onclick="location.href='edit-committee-account.jsp'">KEMASKINI AKAUN</button>
		<%-- # END: COMMITTEE'S ACCOUNT INFORMATION DISPLAY # --%>
		
	</body>
</html>