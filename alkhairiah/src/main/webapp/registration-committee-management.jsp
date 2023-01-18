<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Daftar AJK Pengurusan | Al-Khairiah</title>
		
		<style>
	<style>
	body {
			padding: 0;
			margin: 0;
			font-family: Arial, Helvetica, sans-serif;
			text-align:center;
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
			display: inline-block;
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
		
		table button {
		
			border: none;
			padding: 15px 20px;
			text-align: center;
			text-decoration: none;
			display: inline-block;
			justify-content: center;
			align-items:center;
			margin:auto;
			font-size: 16px;
			cursor: pointer;
			-webkit-transition-duration: 0.4s; 
			transition-duration: 0.4s;
			font-family: Arial, Helvetica, sans-serif;
            border-radius: 5px;
            margin:0 ;
            
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
	
	#back{
	background-color:#3679dd;
	color:white;
	}
	.parent{
	display: flex;
    align-items: center;
    justify-content: center;
	}
	input[type="file"]{
		display:block;
		width:200px;
	}
	
	#file{
	
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
  position:fixed;
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
  background-color: #023020;
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
				<td><input type="password" name="committeePassword" placeholder="********" required></td>
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