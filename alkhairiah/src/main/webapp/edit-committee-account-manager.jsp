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
		
		int previewCommitteeID = Integer.parseInt(request.getParameter("previewCommitteeID")); System.out.println(previewCommitteeID);
		String previewCommitteeType = request.getParameter("previewCommitteeType"); System.out.println(previewCommitteeType);
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
	
		<%-- # START: CURRENT COMMITTEE DETAILS SQL # --%>
		
		<%-- SQL QUERY: Management Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultManagement">
			SELECT m.committeeid AS "committeeid", m.committeefullname AS "committeefullname", m.committeeemail AS "committeeemail", m.committeephonenum AS "committeephonenum", 
			m.committeeaddress AS "committeeaddress", m.committeepassword AS "committeepassword", m.committeebirthdate AS "committeebirthdate", 
			m.managementposition AS "managementposition", c.committeefullname AS "managername" 
			FROM management m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = <%=committee_ID%>
		</sql:query> 
		
		<%-- # END: CURRENT COMMITTEE DETAILS SQL # --%>
		
		<%-- # START: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
		<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
		<a href="client-list.jsp">Senarai Klien</a><br>
		<a href="committee-list.jsp">Senarai AJK</a><br>		
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br><br>
		<%-- # END: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<%-- Management --%>
		
		<c:forEach var="management" items="${resultManagement.rows}">
			<span>PENGURUSAN (PENGURUS)</span><br>
            <span><c:out value="${management.managementposition}"/></span><br>
            <span><c:out value="${management.committeefullname}"/></span><br><br>
		</c:forEach>

		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: MANAGER LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultManager">
			SELECT * FROM management
			WHERE managementposition = 'Pengerusi' OR managementposition = 'Naib Pengerusi'
		</sql:query> 
		<%-- # END: MANAGER LIST --%>
		
		<%-- # START: EDIT COMMITTEE ACCOUNT # --%>
		<br><br><h2>KEMASKINI AKAUN</h2>
		
		<%-- SQL QUERY: COMMITTEE DETAILS --%>
		<%
		// Variables
		String SQL = "";
		char quote = '"';
		
		// Get connection
		Connection connection = ConnectionManager.getConnection();
		
		// SQL
		if(previewCommitteeType.equalsIgnoreCase("Management")) {
			SQL = "SELECT m.committeeid AS "+quote+"committeeid"+quote+", m.committeefullname AS "+quote+"committeefullname"+quote+", " +
				  "m.committeeemail AS "+quote+"committeeemail"+quote+", m.committeephonenum AS "+quote+"committeephonenum"+quote+", " +
			      "m.committeeaddress AS "+quote+"committeeaddress"+quote+", m.committeepassword AS "+quote+"committeepassword"+quote+", " +
				  "m.committeebirthdate AS "+quote+"committeebirthdate"+quote+", m.managementposition AS "+quote+"managementposition"+quote+", " +
			      "c.committeefullname AS "+quote+"managername"+quote+ ", m.managerid AS "+quote+"managerid"+quote+
			      " FROM management m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = ?";
;
			
		} else if (previewCommitteeType.equalsIgnoreCase("Voluntary")) {
			SQL = "SELECT v.committeeid AS "+quote+"committeeid"+quote+", v.committeefullname AS "+quote+"committeefullname"+quote+", " +
				  "v.committeeemail AS "+quote+"committeeemail"+quote+", v.committeephonenum AS "+quote+"committeephonenum"+quote+", " +
				  "v.committeeaddress AS "+quote+"committeeaddress"+quote+", v.committeepassword AS "+quote+"committeepassword"+quote+", " +
				  "v.committeebirthdate AS "+quote+"committeebirthdate"+quote+", v.voluntaryrole AS "+quote+"voluntaryrole"+quote+", v.hourlyrate AS "+quote+"hourlyrate"+quote+", " +
				  "c.committeefullname AS "+quote+"managername"+quote+ ", v.managerid AS "+quote+"managerid"+quote+
				  " FROM voluntary v LEFT OUTER JOIN committee c ON (v.managerid = c.committeeid) WHERE v.committeeid = ?";
		}
		
		// Prepare SQL Statement
		PreparedStatement committeeSQL = connection.prepareStatement(SQL);
		
		// Set ? values
		committeeSQL.setInt(1, previewCommitteeID);
		
		//Execute SQL
		ResultSet resultCommittee = committeeSQL.executeQuery();
		
		// Display and edit info
		while(resultCommittee.next()) {
		%>
		
		<%-- FORM: COMMITTEE DETAILS --%>

		<form method="post">
			<input type="hidden" name="previewCommitteeID" value='<%=previewCommitteeID%>'>
			<input type="hidden" name="previewCommitteeType" value='<%=previewCommitteeType%>'>
			<c:set var="previewCommitteeID" value='<%=previewCommitteeID%>'/>
		<table>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="committeeFullName" value='<%=resultCommittee.getString("committeefullname")%>'></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" name="committeePhoneNum" value='<%=resultCommittee.getString("committeephonenum")%>'></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><input type="date" name="committeeBirthDate" value='<%=resultCommittee.getDate("committeebirthdate")%>'></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><input type="text" name="committeeAddress" value='<%=resultCommittee.getString("committeeaddress")%>'></td>
			</tr>
			
			<%-- Management --%>
			<% if(previewCommitteeType.equalsIgnoreCase("Management")) { %>
			<tr>
				<td>Jawatan</td>
				<td><input type="text" name="managementPosition" value='<%=resultCommittee.getString("managementposition")%>'></td>
			</tr>
			<% if(!(resultCommittee.getString("managementposition")).equalsIgnoreCase("Pengerusi")) { %>
			<tr>
				<td>Nama Pengurus</td>
				<td>
					<select name="managerID">
						<option selected value='<%=resultCommittee.getInt("managerid")%>'><c:out value='<%=resultCommittee.getString("managername")%>'/><c:set var="thismanagerid" value='<%=resultCommittee.getInt("managerid")%>'/></option>
						<c:forEach var="manager" items="${resultManager.rows}">
							<c:if test="${thismanagerid != manager.committeeid}"> <%-- other manager's --%>
								<c:if test ="${previewCommitteeID != manager.committeeid}"> <%-- cannot be self manager --%>
									<option value="${manager.committeeid}"><c:out value="${manager.committeefullname}"/></option>
								</c:if>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			
			<%-- Voluntary --%>
			<% } } else if(previewCommitteeType.equalsIgnoreCase("Voluntary")) { %>
			<tr>
				<td>Peranan</td>
				<td><input type="text" name="voluntaryRole" value='<%=resultCommittee.getString("voluntaryrole")%>'></td>
			</tr>
			<tr>
				<td>Kadar Setiap Jam</td>
				<td><input type="text" name="hourlyRate" value='<%=resultCommittee.getDouble("hourlyrate")%>'></td>
			</tr>
			<tr>
				<td>Nama Pengurus</td>
				<td>
					<select name="managerID">
						<option selected value='<%=resultCommittee.getInt("managerid")%>'><c:out value='<%=resultCommittee.getString("managername")%>'/><c:set var="thismanagerid" value='<%=resultCommittee.getInt("managerid")%>'/></option>
						<c:forEach var="manager" items="${resultManager.rows}">
							<c:if test="${thismanagerid != manager.committeeid}">
								<option value="${manager.committeeid}"><c:out value="${manager.committeefullname}"/></option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			<% } %>
			
			<tr>
				<td>Emel</td>
				<td><input type="email" name="committeeEmail" value='<%=resultCommittee.getString("committeeemail")%>'></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" name="committeePassword" value='<%=resultCommittee.getString("committeepassword")%>'></td>
			</tr>
			<tr>
				<td>Masukkan Semula Kata Laluan</td>
				<td><input type="password" name="committeeRePassword" value='<%=resultCommittee.getString("committeepassword")%>'></td>
			</tr>
		</table>
		<input type="hidden" name="committeeID" value="<%=previewCommitteeID%>"> <%-- For handler --%>
		<button name="cancel" formaction="view-committee-account-manager.jsp">BATAL</button>
		<button type="submit" formaction="CommitteeHandler?action=updateCommitteeManager">SIMPAN</button>
		</form>
		<% } %>
		<%-- # END: EDIT COMMITTEE ACCOUNT # --%>
		
	</body>
</html>