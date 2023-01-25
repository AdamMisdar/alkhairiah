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
					<li><a href="client-list.jsp">Senarai Klien</a></li>
					<li><a href="committee-list.jsp">Senarai AJK</a><li>
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
		<br><br><h2>Daftar AJK Pengurusan</h2>
		<p>Sila isi borang berikut.</p>
		
		<form method="post" id="form">
			<input type="hidden" name="comType" value="management">
		<table>
			<tr>
				<td>Nama Penuh</td>
				<td><input type="text" name="committeeFullName" placeholder="Nama Penuh" required></td>
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" id="committeePhoneNum" name="committeePhoneNum" placeholder="0123456789" required></td>
				
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
				<td>Jawatan</td>
				<td><input type="text" name="managementPosition" placeholder="Bendahari/Setiausaha/.." required></td>
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
				<td><input type="email" id="email" name="committeeEmail" placeholder="contoh@emel.com" required onkeydown="validation()"></td>
				<td><span id="text" ></span></td>
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
			<button id="tambah"  type="submit" formaction="CommitteeHandler?action=createCommittee">DAFTAR AKAUN</button>
		</form>
		
		<br><button id="back" name="back" onclick="location.href='committee-list.jsp'">KEMBALI KE SENARAI</button>
		<br>Bukan AJK Pengurusan? <a href="registration-committee-voluntary.jsp">Daftar AJK Sukarelawan</a>
		
		
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
      	    text.innerHTML = "Your Email Address in valid"
      	    text.style.color = '#037247'
      	  } else {
      	    form.classList.remove('valid')
      	    form.classList.add('invalid')
      	    text.innerHTML = "Please Enter Valid Email Address"
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
		
		function phone_formatting(ele,restore) {
      	  var new_number,
      	      selection_start = ele.selectionStart,
      	      selection_end = ele.selectionEnd,
      	      number = ele.value.replace(/\D/g,'');
      	  
      	  // automatically add dashes
      	  if (number.length > 2) {
      	    // matches: 123 || 123-4 || 123-45
      	    new_number = number.substring(0,3) + '-';
      	    if (number.length === 4 || number.length === 5) {
      	      // matches: 123-4 || 123-45
      	      new_number += number.substr(3);
      	    }
      	    else if (number.length > 5) {
      	      // matches: 123-456 || 123-456-7 || 123-456-789
      	      new_number += number.substring(3,6) + '-';
      	    }
      	    if (number.length > 6) {
      	      // matches: 123-456-7 || 123-456-789 || 123-456-7890
      	      new_number += number.substring(6);
      	    }
      	  }
      	  else {
      	    new_number = number;
      	  }
      	  
      	  // if value is heigher than 12, last number is dropped
      	  // if inserting a number before the last character, numbers
      	  // are shifted right, only 12 characters will show
      	  ele.value =  (new_number.length > 12) ? new_number.substring(0,12) : new_number;
      	  
      	  // restore cursor selection,
      	  // prevent it from going to the end
      	  // UNLESS
      	  // cursor was at the end AND a dash was added
      	  document.getElementById('msg').innerHTML='<p>Selection is: ' + selection_end + ' and length is: ' + new_number.length + '</p>';
      	  
      	  if (new_number.slice(-1) === '-' && restore === false
      	      && (new_number.length === 8 && selection_end === 7)
      	          || (new_number.length === 4 && selection_end === 3)) {
      	      selection_start = new_number.length;
      	      selection_end = new_number.length;
      	  }
      	  else if (restore === 'revert') {
      	    selection_start--;
      	    selection_end--;
      	  }
      	  ele.setSelectionRange(selection_start, selection_end);

      	}
      	  
      	function phone_number_check(field,e) {
      	  var key_code = e.keyCode,
      	      key_string = String.fromCharCode(key_code),
      	      press_delete = false,
      	      dash_key = 189,
      	      delete_key = [8,46],
      	      direction_key = [33,34,35,36,37,38,39,40],
      	      selection_end = field.selectionEnd;
      	  
      	  // delete key was pressed
      	  if (delete_key.indexOf(key_code) > -1) {
      	    press_delete = true;
      	  }
      	  
      	  // only force formatting is a number or delete key was pressed
      	  if (key_string.match(/^\d+$/) || press_delete) {
      	    phone_formatting(field,press_delete);
      	  }
      	  // do nothing for direction keys, keep their default actions
      	  else if(direction_key.indexOf(key_code) > -1) {
      	    // do nothing
      	  }
      	  else if(dash_key === key_code) {
      	    if (selection_end === field.value.length) {
      	      field.value = field.value.slice(0,-1)
      	    }
      	    else {
      	      field.value = field.value.substring(0,(selection_end - 1)) + field.value.substr(selection_end)
      	      field.selectionEnd = selection_end - 1;
      	    }
      	  }
      	  // all other non numerical key presses, remove their value
      	  else {
      	    e.preventDefault();
//      	    field.value = field.value.replace(/[^0-9\-]/g,'')
      	    phone_formatting(field,'revert');
      	  }
      	}
      	document.getElementById('committeePhoneNum').onkeyup = function(e) {
      	  phone_number_check(this,e);
      	}
		
		</script>
	</body>
</html>