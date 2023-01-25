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
	<link rel="stylesheet" type="text/css" href="committee-style.css">
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
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px; color: white;">NETGREEN</span>
				<span></span>
			</div>
		</div>

		
		<div class="wrapper">
			<div class="sidebar">
				<h2>PENGURUSAN</h2>
					<div class="sidebarname">
					<% if(isManager) {%>
						<c:forEach var="manager" items="${resultCommittee.rows}">
							<p><span>PENGURUSAN (PENGURUS)</span><br></p>
			            	<p><span><c:out value="${manager.managementposition}"/></span><br></p>
			            	<p><span><c:out value="${manager.committeefullname}"/></span><br></p>
						</c:forEach>
						
					<%-- Ordinary Management --%>
						<% } else { %>
							<c:forEach var="committee" items="${resultCommittee.rows}">
								<p><span>PENGURUSAN</span><br></p>
				            	<p><span><c:out value="${committee.managementposition}"/></span><br></p>
				            	<p><span><c:out value="${committee.committeefullname}"/></span><br></p>
							</c:forEach>
						<% } %>
					</div>
					<c:forEach var="committee" items="${committeeResult.rows}">
						<p style="position:relative;Left:18px;color: rgb(253, 253, 253); font-weight: bold;">
						<c:out value="${committee.committeefullname}"/>
						</p>
						<p style="position:relative;Left:18px;color: rgb(253, 253, 253);">
						<c:out value="${committee.managementposition}"/>
						</p>
					</c:forEach>
				<ul>
					<li><a href="index-committee.jsp"><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="booking-list-management.jsp" ><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
					<li><a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a></li>
					<li><a href="client-list.jsp">Senarai Klien</a></li>
					<% if(isManager) { /* If committee is Manager */%>
					<li><a href="committee-list.jsp">Senarai AJK</a></li>
					<% } %>
					<li><a href="view-committee-account.jsp"><i class="fas fa-user"></i> Akaun</a></li>
					<li><a href="LoginHandler?action=logout">Log Keluar</a></li>
					
				</ul> 
			</div>
		</div>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAVIGATION ELEMENTS # --%>
		
		<%-- # END: NAVIGATION ELEMENTS # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<br><br>
		<%-- Manager --%>
		
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
		
		<button name="back" id="back" formaction="client-list.jsp">KEMBALI KE SENARAI</button>
		<button name="edit" id="tambah" formaction="edit-client-account-management.jsp">KEMASKINI AKAUN</button>
		<button name="delete" id="kosongkan" formaction="ClientHandler?action=deleteClient">PADAM AKAUN INI</button>
		</form>
		<%-- # END: CLIENT'S ACCOUNT DISPLAY # --%>
		
		
		<%-- # END: BOOKING(S) BY THIS CLIENT # --%>
		
	</body>
</html>