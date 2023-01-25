<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Daftar AJK Pengurusan | Al-Khairiah</title>
		<link rel="stylesheet" type="text/css" href="committee-style.css">
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
					<c:forEach var="manager" items="${resultCommittee.rows}">
			            <p><span><c:out value="${manager.managementposition}"/></span><br>
			            <p><span><c:out value="${manager.committeefullname}"/></span><br>
					</c:forEach>
				</div>
					
				<ul>
					<li><a href="index-committee.jsp"><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="booking-list-management.jsp" ><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
					<li><a href="client-list.jsp">Senarai Klien</a></li>
					<li><a href="committee-list.jsp">Senarai AJK</a></li>
					<li><a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a></li>
					<li><a href="view-committee-account.jsp"><i class="fas fa-user"></i> Akaun</a></li>
					<li><a href="LoginHandler?action=logout"> Log Keluar</a></li>
				</ul> 
			</div>
		</div>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAVIGATION ELEMENTS # --%>
		
		<%-- # END: NAVIGATION ELEMENTS # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<br><br>
		
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
				<td><input type="password" id="committeePassword" name="committeePassword" placeholder="********" required></td>
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
				<td><input type="password" name="committeeRePassword" placeholder="********" required></td>
			</tr>
		</table>
			<button type="submit" onclick="continues()" formaction="CommitteeHandler?action=createCommittee">DAFTAR AKAUN</button>
		</form>
		
		<br><button name="back" onclick="location.href='committee-list.jsp'">KEMBALI KE SENARAI</button>
		<br>Bukan AJK Sukarelawan? <a href="registration-committee-management.jsp">Daftar AJK Pengurusan</a>
		<%-- # END: REGISTRATION FORM # --%>
	
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