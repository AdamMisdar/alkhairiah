<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Akaun | Al-Khairiah</title>
		<link rel="stylesheet" type="text/css" href="committee-style.css">
		
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
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px; color: white;">NETGREEN</span>
				<span></span>
			</div>
		</div>

		
		<div class="wrapper">
			<div class="sidebar">
				<h2>PENGURUSAN</h2>
					<% if(committeeType.equalsIgnoreCase("Management")) { %>
						<div class="sidebarname">
						<c:forEach var="management" items="${resultCommittee.rows}">
							<% if(isManager) { /* If this is a Manager */%>
								<p><span>PENGURUSAN (PENGURUS)</span><br></p>
							<% } else { /* If this is an ordinary management committee */%>
								<p><span>PENGURUSAN</span><br></p>
							<% } %>
				            <p><span><c:out value="${management.managementposition}"/></span><br></p>
				            <p><span><c:out value="${management.committeefullname}"/></span><br><br></p>
						</c:forEach>
						
						<%-- Voluntary --%>
						<% } else if(committeeType.equalsIgnoreCase("Voluntary")) { %>
						
						<c:forEach var="voluntary" items="${resultCommittee.rows}">
							<p><span>SUKARELAWAN<br></span></p>
				            <p><span><c:out value="${voluntary.voluntaryRole}"/></span><br></p>
				            <p><span><c:out value="${voluntary.committeefullname}"/></span><br><br></p>
						</c:forEach>
						
						<% } %>
						</div>
						
				<ul>
					
				<li><a href="index-committee.jsp">Laman Utama</a></li>
				<li><a href="view-committee-account.jsp">Akaun</a></li>
				
				<%-- Management Only --%>
				<% if(committeeType.equalsIgnoreCase("Management")) { %>
					<li><a href="booking-list-management.jsp">Senarai Tempahan</a></li>
					<li><a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a></li>
					<li><a href="client-list.jsp">Senarai Klien</a></li>
					<%-- Manager Only --%>
					<% if(isManager) { %>
						<li><a href="committee-list.jsp">Senarai AJK</a></li>
					<% } %>
					
				<% } %>
				
				<li><a href="LoginHandler?action=logout">Log Keluar</a></li>
		
				</ul> 
			</div>
		</div>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		<%-- All Committee --%>
		
		<%-- # END: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<%-- Management --%>
		
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: COMMITTEE'S ACCOUNT INFORMATION DISPLAY # --%>
		<h2>MAKLUMAT AKAUN</h2>
		
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
		
		<button name="edit" id="tambah" onclick="location.href='edit-committee-account.jsp'">KEMASKINI AKAUN</button>
		<%-- # END: COMMITTEE'S ACCOUNT INFORMATION DISPLAY # --%>
		
	</body>
</html>