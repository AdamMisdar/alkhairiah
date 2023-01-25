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
								<p><span>PENGURUSAN (PENGURUS)</span><br></p>
							<% } else { /* If this is an ordinary management committee */%>
								<p><span>PENGURUSAN</span><br></p>
							<% } %>
				            <p><span><c:out value="${management.managementposition}"/></span><br></p>
				            <p><span><c:out value="${management.committeefullname}"/></span><br><br></p>
						</c:forEach>
						
						<%-- Voluntary --%>
						<% } else if(committeeType.equalsIgnoreCase("Voluntary")) { %>
						
						<c:forEach var="voluntary" items="${resultVoluntary.rows}">
							<p><span>SUKARELAWAN<br></span></p>
				            <p><span><c:out value="${voluntary.voluntaryRole}"/></span><br></p>
				            <p><span><c:out value="${voluntary.committeefullname}"/></span><br><br></p>
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

		<form method="post" id="form">
			<input type="hidden" name="committeeID" value='<%=committee_ID%>'>
			
		<table>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="committeeFullName" value='<%=resultCommittee.getString("committeefullname")%>'></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" name="committeePhoneNum" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11" value='<%=resultCommittee.getString("committeephonenum")%>' required></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><input type="date" name="committeeBirthDate" value='<%=resultCommittee.getDate("committeebirthdate")%>' required></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><input type="text" name="committeeAddress" value='<%=resultCommittee.getString("committeeaddress")%>' required></td>
			</tr>			
			<tr>
				<td>Emel</td>
				<td><input type="email" id="email" name="committeeEmail" value='<%=resultCommittee.getString("committeeemail")%>'  onkeydown="validation()" required></td>
				<td><span id="text"></span></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" id="committeePassword" name="committeePassword" value='<%=resultCommittee.getString("committeepassword")%>' required></td>
				<td>
					<div id="message">
				  <h3>Password must contain the following:</h3>
				  <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
				  <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
				  <p id="number" class="invalid">A <b>number</b></p>
				  <p id="length" class="invalid">Minimum <b>8 characters</b></p>
					</div>
				</td>
			</tr>
			<tr>
				<td>Masukkan Semula Kata Laluan</td>
				<td><input type="password" name="committeeRePassword" value='<%=resultCommittee.getString("committeepassword")%>' required></td>
			</tr>
		</table>
		
		<button id="kosongkan" onclick="cancel()" name="cancel" formaction="view-committee-account.jsp">BATAL</button>
		<button id="tambah" onclick="continues()"  type="submit" formaction="CommitteeHandler?action=updateCommittee">SIMPAN</button>
		</form>
		<% } %>
		<%-- # END: EDIT COMMITTEE ACCOUNT # --%>
		
		<script type="text/javascript">
		
		function validation() {
      	  let form = document.getElementById('form')
      	  let email = document.getElementById('email').value
      	  let text = document.getElementById('text')
      	  let pattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/

      	  if (email.match(pattern)) {
      	    form.classList.add('valid')
      	    form.classList.remove('invalid')
      	    text.innerHTML = "Emel yang dimasukkan adalah sah"
      	    text.style.color = '#037247'
      	  } else {
      	    form.classList.remove('valid')
      	    form.classList.add('invalid')
      	    text.innerHTML = "Sila masukkan emel yang sah"
      	    text.style.color = '#ff0000'
      	  }

      	  if (email == '') {
      	    form.classList.remove('valid')
      	    form.classList.remove('invalid')
      	    text.innerHTML = ""
      	    text.style.color = '#00ff00'
      	  }
      	}
		
		
		var myInput = document.getElementById("committeePassword");
		var letter = document.getElementById("letter");
		var capital = document.getElementById("capital");
		var number = document.getElementById("number");
		var length = document.getElementById("length");

		// When the user clicks on the password field, show the message box
		myInput.onfocus = function() {
		  document.getElementById("message").style.display = "block";
		}

		// When the user clicks outside of the password field, hide the message box
		myInput.onblur = function() {
		  document.getElementById("message").style.display = "none";
		}

		// When the user starts to type something inside the password field
		myInput.onkeyup = function() {
		  // Validate lowercase letters
		  var lowerCaseLetters = /[a-z]/g;
		  if(myInput.value.match(lowerCaseLetters)) {  
		    letter.classList.remove("invalid");
		    letter.classList.add("valid");
		  } else {
		    letter.classList.remove("valid");
		    letter.classList.add("invalid");
		  }
		  
		  // Validate capital letters
		  var upperCaseLetters = /[A-Z]/g;
		  if(myInput.value.match(upperCaseLetters)) {  
		    capital.classList.remove("invalid");
		    capital.classList.add("valid");
		  } else {
		    capital.classList.remove("valid");
		    capital.classList.add("invalid");
		  }

		  // Validate numbers
		  var numbers = /[0-9]/g;
		  if(myInput.value.match(numbers)) {  
		    number.classList.remove("invalid");
		    number.classList.add("valid");
		  } else {
		    number.classList.remove("valid");
		    number.classList.add("invalid");
		  }
		  
		  // Validate length
		  if(myInput.value.length >= 8) {
		    length.classList.remove("invalid");
		    length.classList.add("valid");
		  } else {
		    length.classList.remove("valid");
		    length.classList.add("invalid");
		  }
		}
		
		function continues() {
			  let text = "Anda pasti ingin teruskan?";
			  if (confirm(text) == true) {
			    text = "You pressed OK!";
			  } else {
			    text = "You canceled!";
			  }
			  document.getElementById("demo").innerHTML = text;
			}
		function cancel() {
			  let textC = "Anda pasti ingin batal?";
			  if (confirm(text) == true) {
			    text = "You pressed OK!";
			  } else {
			    text = "You canceled!";
			  }
			  document.getElementById("demo").innerHTML = textC;
			}
		</script>
	</body>
</html>