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
		
		<%-- # START: MANAGER LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultManager">
			SELECT * FROM management
			WHERE managementposition = 'Pengerusi' OR managementposition = 'Naib Pengerusi'
		</sql:query> 
		<%-- # END: MANAGER LIST --%>
		
		<%-- # START: REGISTRATION FORM # --%>
		<br><br><h2>Daftar AJK Sukarelawan</h2>
		<p>Sila isi borang berikut.</p>
		
		<form method="post">
			<input type="hidden" name="comType" value="voluntary">
		<table>
			<tr>
				<td>Nama Penuh</td>
				<td><input type="text" name="committeeFullName" placeholder="Nama Penuh" required></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" name="committeePhoneNum" placeholder="0123456789" required></td>
			</tr>
			<tr>
				<td>Alamat Rumah</td>
				<td><input type="text" name="committeeAddress" placeholder="Alamat" required></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><input type="date" name="committeeBirthDate" required></td>
			</tr>
			<tr>
				<td>Peranan Sukarela</td>
				<td><input type="text" name="voluntaryRole" placeholder="Penyembelih/.." required></td>
			</tr>
			<tr>
				<td>Kadar Setiap Jam</td>
				<td><input type="number" name="hourlyRate" placeholder="RM XX.XX" required></td>
			</tr>
			<tr>
				<td>Nama Pengurus</td>
				<td>
					<select name="managerID">
						<c:forEach var="manager" items="${resultManager.rows}">
							<option value="${manager.committeeid}"><c:out value="${manager.committeefullname}"/></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>Emel</td>
				<td><input type="email" name="committeeEmail" placeholder="contoh@emel.com" required></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" name="committeePassword" placeholder="********" required></td>
			</tr>
			<tr>
				<td>Masukkan Semula Kata Laluan</td>
				<td><input type="password" name="committeeRePassword" placeholder="********" required></td>
			</tr>
		</table>
			<button type="submit" formaction="CommitteeHandler?action=createCommittee">DAFTAR AKAUN</button>
		</form>
		
		<br><button name="back" onclick="location.href='committee-list.jsp'">KEMBALI KE SENARAI</button>
		<br>Bukan AJK Sukarelawan? <a href="registration-committee-management.jsp">Daftar AJK Pengurusan</a>
		<%-- # END: REGISTRATION FORM # --%>
	</body>
</html>