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
		<title>Kemaskini Maklumat Haiwan | Al-Khairiah</title>
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
		
		<%-- # START: EDIT ANIMAL DETAILS # --%>
		<h2>KEMASKINI HAIWAN</h2><br><br>
		
		<%-- SQL QUERY: ANIMAL DETAILS --%>
		<%
		// Get connection
		Connection connection = ConnectionManager.getConnection();
		
		// Get values
		int animalDetailsID = Integer.parseInt(request.getParameter("animalDetailsID"));
		
		// Prepare SQL Statement
		PreparedStatement animalSQL = connection.prepareStatement
		("SELECT * FROM animaldetails WHERE animaldetailsid = ?");
		
		// Set ? values
		animalSQL.setInt(1, animalDetailsID);
		
		//Execute SQL
		ResultSet resultAnimal = animalSQL.executeQuery();
		
		// Display and edit info
		while(resultAnimal.next()) {
		%>
		
		<%-- ANIMAL DETAILS DISPLAY --%>
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
							<option value='<%=resultAnimal.getString("animaltype")%>' selected><%=resultAnimal.getString("animaltype")%></option>
							<c:set var="animaltype" value='<%=resultAnimal.getString("animaltype")%>'/>
							
							<c:if test="${animaltype == 'Lembu'}">
							<option value="Kambing">Kambing</option>
							<option value="Unta">Unta</option>
							</c:if>
							
							<c:if test="${animaltype == 'Kambing'}">
							<option value="Lembu">Lembu</option>
							<option value="Unta">Unta</option>
							</c:if>
							
							<c:if test="${animaltype == 'Unta'}">
							<option value="Kambing">Kambing</option>
							<option value="Lembu">Lembu</option>
							</c:if>
					</select>
				</td>
			</tr>
			<tr>
				<td>Harga Seekor (RM)</td>
				<td><input type="number" id="animalPrice" step="any" min="0" oninput="check(this)" name="animalPrice" placeholder="Harga(RM) XXXX.XX" value='<%=resultAnimal.getDouble("animalprice")%>' required></td>
			</tr>
		</table>
			<input type="hidden" name="animalDetailsID" value='<%=resultAnimal.getInt("animaldetailsid")%>'>
			<button type="submit" formaction="AnimalDetailsHandler?action=updateAnimalDetails">SIMPAN</button>
		</form>
		
		<button name="cancel" onclick="location.href='animal-details-list.jsp'">BATAL</button>
		
		<% } %>
		<%-- # END: EDIT ANIMAL DETAILS # --%>
		
		<script>
		function check(input) {
			var price = document.getElementById('animalPrice').value;
			
			if (price > 0) {
				input.setCustomValidity('');
				
			}
			
			else if (price == '' || price == null){
				input.setCustomValidity('Sila masukkan harga.');
				input.preventDefault();
				
			}
			
			else if (price <= 0) {
				input.setCustomValidity('Harga mesti lebih RM0.00');
				input.preventDefault();
				
			} 
			
		}
		
		</script>
	</body>
</html>