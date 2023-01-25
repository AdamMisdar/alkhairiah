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
		<%-- # START: HEADER --%>
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px; color: white;">NETGREEN</span>
				<span></span>
			</div>
		</div>

		
		<div class="wrapper">
			<div class="sidebar">
				<h2>PENGURUS</h2>
				<div class="sidebarname">
					<c:forEach var="management" items="${resultManagement.rows}">
						<p><span>PENGURUSAN (PENGURUS)</span><br></p>
			            <p><span><c:out value="${management.managementposition}"/></span><br></p>
			            <p><span><c:out value="${management.committeefullname}"/></span><br><br></p>
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
		</div>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
	
		<%-- # END: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<%-- Management --%>
		
	

		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: MANAGER LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultManager">
			SELECT * FROM management
			WHERE managementposition = 'Pengerusi' OR managementposition = 'Naib Pengerusi'
		</sql:query> 
		<%-- # END: MANAGER LIST --%>
		
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

		<form method="post" id="form">  
			<input type="hidden" name="previewCommitteeID" value='<%=previewCommitteeID%>'>
			<input type="hidden" name="previewCommitteeType" value='<%=previewCommitteeType%>'>
			<c:set var="previewCommitteeID" value='<%=previewCommitteeID%>'/>
		<table>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="committeeFullName" value='<%=resultCommittee.getString("committeefullname")%>' required></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" name="committeePhoneNum" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11"  value='<%=resultCommittee.getString("committeephonenum")%>' required></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><input type="date" name="committeeBirthDate" value='<%=resultCommittee.getDate("committeebirthdate")%>' required></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><input type="text" name="committeeAddress" value='<%=resultCommittee.getString("committeeaddress")%>' required></td>
			</tr>
			
			<%-- Management --%>
			<% if(previewCommitteeType.equalsIgnoreCase("Management")) { %>
			<tr>
				<td>Jawatan</td>
				<td><input type="text" name="managementPosition" value='<%=resultCommittee.getString("managementposition")%>' required></td>
			</tr>
			<% if(!(resultCommittee.getString("managementposition")).equalsIgnoreCase("Pengerusi")) { %>
			<tr>
				<td>Nama Pengurus</td>
				<td>
					<select name="managerID">
						<option selected value='<%=resultCommittee.getInt("managerid")%>'><c:out value='<%=resultCommittee.getString("managername")%>'/><c:set var="thismanagerid" value='<%=resultCommittee.getInt("managerid")%>' /></option>
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
				<td><input type="text" name="voluntaryRole" value='<%=resultCommittee.getString("voluntaryrole")%>' required></td>
			</tr>
			<tr>
				<td>Kadar Setiap Jam</td>
				<td><input type="text" name="hourlyRate" value='<%=resultCommittee.getDouble("hourlyrate")%>' required></td>
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
				<td><input type="email" id="email" name="committeeEmail" value='<%=resultCommittee.getString("committeeemail")%>' onkeydown="validation()" required></td>
				<td><span id="text" ></span></td>
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
				<td><input type="password" name="committeeRePassword" value='<%=resultCommittee.getString("committeepassword")%>'  required></td>

			</tr>
		</table>
		<input type="hidden" name="committeeID" value="<%=previewCommitteeID%>"> <%-- For handler --%>
		<button name="cancel" id="kosongkan" onclick="cancel()" formaction="view-committee-account-manager.jsp">BATAL</button>
		<button type="submit" id="tambah" onclick="continues()" formaction="CommitteeHandler?action=updateCommitteeManager">SIMPAN</button>
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