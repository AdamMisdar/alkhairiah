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
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		
		/* Current Date */
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("clientID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			client_ID = (int)session.getAttribute("clientID");
		} 
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		
		<%-- SQL QUERY: CLIENT DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
			SELECT * FROM client WHERE clientid = <%=client_ID%>
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
		<a href="index-client.jsp">Laman Utama</a><br>
		<a href="view-client-account.jsp">Akaun</a><br>
		<a href="BookingHandler?action=createBooking">Buat Tempahan</a><br>
		<a href="booking-list-client.jsp">Senarai Tempahan</a><br>
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br>
				
		<%-- CLIENT INFO DISPLAY --%>
		KLIEN <br><c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach><br>

		<%-- # START: EDIT CLIENT ACCOUNT # --%>
		<br><br><h2>KEMASKINI AKAUN</h2>
		
		<%-- SQL QUERY: CLIENT DETAILS --%>
		<%
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
			<button name="cancel" formaction="view-client-account.jsp">BATAL</button>
			<button type="submit" formaction="ClientHandler?action=updateClient">SIMPAN</button>
		</form>
		<% } %>
		<%-- # END: EDIT CLIENT ACCOUNT # --%>
	</body>
</html>