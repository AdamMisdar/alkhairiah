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
		
		<style>
	body {
			padding: 0;
			margin: 0;
			font-family: Arial, Helvetica, sans-serif;
		}
		
	.sidebarname p{
	display:flex;
	color:white;
	position:relative;
	align-items:center;
	justify-content:center;
	margin-bottom:10px;
	}
	
	table {
			display:flex;
		    position: relative;
		    border-collapse: collapse;
		    width: 70%;
		    height: 50%;
		    border: 1px solid #bdc3c7;
		    box-shadow: 2px 2px 12px rgba(0,0,0,0.2), -1px -1px 8px rgba(0,0,0,0.2);
		    justify-content: center;
		    align-items: center;
		    margin: auto;
		    margin-top:10px;
		    margin-bottom:10px;
		    margin-left:300px;
		    text-align:center;
		}
		input {
			width: 100%;
			padding: 12px 20px;
			margin: 8px 0;
			display: inline-block;
			border: 1px solid #ccc;
			border-radius: 4px;
			box-sizing: border-box;
		}
		th,
		td {
			padding: 10px;
			text-align: center;
			border-bottom: 1px solid #ddd;
		}
		.header{
			background-color: #037247;
			color: rgb(8, 8, 8);
            padding: 20px;
		}
		
		h2 {
			font-weight: 600;
			text-align: center;
			color: rgb(5, 5, 5);
			padding: 10px 0px;
            font-size: 20px;
			
			
		}
		.title {
			color: #0c0c0c;
			border: #035317 2px solid;
			height: 50px;
			width: 40vh;
			display:flex;
			position: absolute;
			margin:auto;
			top:20%;
			left:22%;
			justify-content: center;
			padding : auto;
			border-radius: 10px;
			background-color: #037247;
			
		}
		.title h2{
			color: white;
		}
		@media only screen and (max-width: 768px) {
			table{
				width: 90%;
			}
		}
		
		button {
			border: none;
			padding: 15px 20px;
			text-align: center;
			text-decoration: none;
			display: flex;
			font-size: 16px;
			cursor: pointer;
			-webkit-transition-duration: 0.4s; 
			transition-duration: 0.4s;
			font-family: Arial, Helvetica, sans-serif;
            border-radius: 5px;
            margin:auto  ;
            margin-top:10px;
            margin-bottom:10px;
            position:relative;
            
			
		}
		#buttonhome{
			position: absolute;
			font-size: 16px;
		}
		button:hover {
			box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
		}
		#kosongkan{
	background-color:#cc3030;
	color:white;
	}
	#tambah{
	background-color:#037247;
	color:white;
	}
	
@import url('https://fonts.googleapis.com/css?family=Josefin+Sans&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  list-style: none;
  text-decoration: none;
  font-family: 'Josefin Sans', sans-serif;
}
body{
   background-color: #f3f5f9;
}
.wrapper{
  display: flex;
  position: relative;
}
.wrapper .sidebar{
  width: 250px;
  height: 100%;
  background: #037247;
  padding: 30px 0px;
  position: fixed;
}
.wrapper .sidebar h2{
  color: #fff;
  text-transform: uppercase;
  text-align: center;
  margin-bottom: 30px;
}
.wrapper .sidebar ul li{
  padding: 15px;
  border-bottom: 1px solid #bdb8d7;
  border-bottom: 1px solid rgba(0,0,0,0.05);
  border-top: 1px solid rgba(255,255,255,0.05);
}    
.wrapper .sidebar ul li a{
  color: #fafafa;
  display: block;
}
.wrapper .sidebar ul li a .fas{
  width: 25px;
}
.wrapper .sidebar ul li:hover{
  background-color: #023020;;
}
    
.wrapper .sidebar ul li:hover a{
  color: #fff;
}
 
.wrapper .sidebar .social_media{
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
}
.wrapper .sidebar .social_media a{
  display: block;
  width: 40px;
  background: #565558;
  height: 40px;
  line-height: 45px;
  text-align: center;
  margin: 0 5px;
  color: #ffffff;
  border-top-left-radius: 5px;
  border-top-right-radius: 5px;
}
.wrapper .main_content{
  width: 100%;
  margin-left: 200px;
}
.wrapper .main_content .header{
  padding: 20px;
  background: #fff;
  color: #717171;
  border-bottom: 1px solid #e0e4e8;
}
.wrapper .main_content .info{
  margin: 20px;
  color: #717171;
  line-height: 25px;
}
.wrapper .main_content .info div{
  margin-bottom: 20px;
}
@media (max-height: 500px){
  .social_media{
    display: none !important;
  }
}
</style>
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
		<sql:query dataSource="${qurbanDatabase}" var="resultManagement">
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
		<sql:query dataSource="${qurbanDatabase}" var="resultVoluntary">
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
					<div class="sidebarname">
					<% if(committeeType.equalsIgnoreCase("Management")) { %>
		
						<c:forEach var="management" items="${resultManagement.rows}">
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
						
						<c:forEach var="voluntary" items="${resultVoluntary.rows}">
							<span>SUKARELAWAN<br></span>
				            <span><c:out value="${voluntary.voluntaryRole}"/></span><br>
				            <span><c:out value="${voluntary.committeefullname}"/></span><br><br>
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
					
				<li><a href="index-committee.jsp">Laman Utama</a><br>	
				<li><a href="view-committee-account.jsp">Akaun</a><br>
				
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
		
		<%-- # START: EDIT COMMITTEE ACCOUNT # --%>
		<br><h2>KEMASKINI AKAUN</h2>
		
		<%-- SQL QUERY: COMMITTEE DETAILS --%>
		<%
		// Variables
		String SQL = "";
		char quote = '"';
		
		// Get connection
		Connection connection = ConnectionManager.getConnection();
		
		// SQL
		if(committeeType.equalsIgnoreCase("Management")) {
			SQL = "SELECT m.committeeid AS "+quote+"committeeid"+quote+", m.committeefullname AS "+quote+"committeefullname"+quote+", " +
				  "m.committeeemail AS "+quote+"committeeemail"+quote+", m.committeephonenum AS "+quote+"committeephonenum"+quote+", " +
			      "m.committeeaddress AS "+quote+"committeeaddress"+quote+", m.committeepassword AS "+quote+"committeepassword"+quote+", " +
				  "m.committeebirthdate AS "+quote+"committeebirthdate"+quote+", m.managementposition AS "+quote+"managementposition"+quote+", " +
			      "c.committeefullname AS "+quote+"managername"+quote+ ", m.managerid AS "+quote+"managerid"+quote+
			      " FROM management m LEFT OUTER JOIN committee c ON (m.managerid = c.committeeid) WHERE m.committeeid = ?";
;
			
		} else if (committeeType.equalsIgnoreCase("Voluntary")) {
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
		committeeSQL.setInt(1, committee_ID);
		
		//Execute SQL
		ResultSet resultCommittee = committeeSQL.executeQuery();
		
		// Display and edit info
		while(resultCommittee.next()) {
		%>
		
		<%-- FORM: COMMITTEE DETAILS --%>

		<form method="post">
			<input type="hidden" name="committeeID" value='<%=committee_ID%>'>
			
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
		
		<button id="kosongkan" name="cancel" formaction="view-committee-account.jsp">BATAL</button>
		<button id="tambah" type="submit" formaction="CommitteeHandler?action=updateCommittee">SIMPAN</button>
		</form>
		<% } %>
		<%-- # END: EDIT COMMITTEE ACCOUNT # --%>
		
	</body>
</html>