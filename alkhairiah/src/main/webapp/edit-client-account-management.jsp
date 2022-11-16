<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="alkhairiah.connection.*" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Kemaskini Akaun | Al-Khairiah</title>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int counter = 0; // for client list display
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
		                   
		<%-- SQL QUERY: CURRENT COMMITTEE DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
	   		SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_ID %>
		</sql:query>
		
		<%-- SQL QUERY: CLIENT LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
	   		SELECT * FROM client ORDER BY clientfullname
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
		
		<%-- # START: EDIT CLIENT ACCOUNT # --%>
		<br><br><h2>KEMASKINI AKAUN</h2>
		
		<%-- SQL QUERY: CLIENT DETAILS --%>
		<%
		// Variables
		int client_ID = Integer.parseInt(request.getParameter("clientID"));
		
		// Get connection
		Connection connection = ConnectionManager.getConnection();
		
		// Prepare SQL Statement
		PreparedStatement clientSQL = connection.prepareStatement
		("SELECT * FROM client WHERE clientid = ?");
		
		// Set ? values
		clientSQL.setInt(1, client_ID);
		
		//Execute SQL
		ResultSet resultClient = clientSQL.executeQuery();
		
		// Display and edit info
		while(resultClient.next()) {
		%>
		
		<%-- CLIENT ACCOUNT INFORMATION --%>
		<form method="post">
			<input type="hidden" name="clientID" value="<%=client_ID%>">
		<table>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="clientFullName" value='<%=resultClient.getString("clientfullname")%>'></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" name="clientPhoneNum" value='<%=resultClient.getString("clientphonenum")%>'></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="email" name="clientEmail" value='<%=resultClient.getString("clientemail")%>'></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><input type="date" name="clientBirthDate" value='<%=resultClient.getDate("clientbirthdate")%>'></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><input type="text" name="clientAddress" value='<%=resultClient.getString("clientaddress")%>'></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" name="clientPassword" value='<%=resultClient.getString("clientPassword")%>'></td>
			</tr>
			<tr>
				<td>Masukkan Semula Kata Laluan</td>
				<td><input type="password" name="clientRePassword" value='<%=resultClient.getString("clientPassword")%>'></td>
			</tr>
		</table>
			<button name="cancel" formaction="view-client-account-management.jsp">BATAL</button>
			<button type="submit" formaction="ClientHandler?action=updateClientCom&nextPage=viewAccount">SIMPAN</button>
		</form>
		<% } %>
		<%-- # END: EDIT CLIENT ACCOUNT # --%>
	</body>
</html>