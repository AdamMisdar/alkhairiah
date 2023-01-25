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

input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
}

/* Style the submit button */
input[type=submit] {
  background-color: #04AA6D;
  color: white;
}

/* Style the container for inputs */
.container {
  background-color: #f1f1f1;
  padding: 20px;
}

/* The message box is shown when the user clicks on the password field */
#message {
	width:400px;
	height:100%;	
  display:none;
  background: white;
  color: black;
  position: relative;
  padding: 10px;
  margin-top: 5px;
}

#message p {
  padding: 5px 20px;
  font-size: 10px;
}

/* Add a green text color and a checkmark when the requirements are right */
#text .valid {
  color: green;
}
#message .valid {
  color: green;
}


.valid:before {
  position: relative;
  left: -35px;
  
}

/* Add a red text color and an "x" when the requirements are wrong */
#text .invalid {
  color: red;
}
#message .invalid {
  color: red;
}


.invalid:before {
  position: relative;
  left: -35px;
 
}
</style>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int counter = 0; // for client list display
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
		                   
		<%-- SQL QUERY: CURRENT COMMITTEE DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
	   		SELECT * FROM committee JOIN management USING (committeeid) WHERE committeeid = <%=committee_ID %>
		</sql:query>
		
		<%-- SQL QUERY: CLIENT LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
	   		SELECT * FROM client ORDER BY clientfullname
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
				<h2>PENGURUSAN</h2>
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
					<li><a href="index-committee.jsp" ><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="booking-list-management.jsp" ><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
					<li><a href="animal-details-list.jsp" ><i class="fas fa-address-book"></i>Senarai Maklumat Haiwan</a></li>
					<li><a href="client-list.jsp">Senarai Klien</a></li>
					<% if (isManager) { %>
					<li><a href="committee-list.jsp" >Senarai AJK</a></li>
						<% } %> 
					<li><a href="view-committee-account.jsp"><i class="fas fa-user"></i> Akaun</a></li>
					<li><a href="LoginHandler?action=logout"><i class="fas fa-sign-out-alt"></i> Log Keluar</a></li>
				</ul> 
			</div>
		</div>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAVIGATION ELEMENTS # 
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
		<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
		<a href="client-list.jsp">Senarai Klien</a><br>
		<% if(isManager) { /* If committee is Manager */%>
			<a href="committee-list.jsp">Senarai AJK</a><br>
			
		<% } %>
		
		<a href="LoginHandler?action=logout">Log Keluar</a><br>
		--%>
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
		
		<%-- # START: EDIT CLIENT ACCOUNT # --%>
		<br><br><h2>KEMASKINI AKAUN</h2>
		
		<%-- SQL QUERY: CLIENT DETAILS --%>
		<%
		// Variables
		int client_ID = Integer.parseInt(request.getParameter("clientID"));
		
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
		<form method="post" id="form">
			<input type="hidden" name="clientID" value="<%=client_ID%>">
		<table>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="clientFullName" value='<%=resultClient.getString("clientfullname")%>' required></td>
				
			</tr>
			<tr>
				<td>No. Telefon</td>
				<td><input type="text" required name="clientPhoneNum" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" maxlength="11"  value='<%=resultClient.getString("clientphonenum")%>'></td>
			</tr>
			<tr>
				<td>Emel</td>
				<td><input type="email" id="email" required name="clientEmail" value='<%=resultClient.getString("clientemail")%>' onkeydown="validation()"></td>
				<td><span id="text" ></span></td>
			</tr>
			<tr>
				<td>Tarikh Lahir</td>
				<td><input type="date" name="clientBirthDate"  required value='<%=resultClient.getDate("clientbirthdate")%>'></td>
			</tr>
			<tr>
				<td>Alamat</td>
				<td><input type="text" name="clientAddress"  required value='<%=resultClient.getString("clientaddress")%>'></td>
			</tr>
			<tr>
				<td>Kata Laluan</td>
				<td><input type="password" id="clientPassword"  required name="clientPassword" value='<%=resultClient.getString("clientPassword")%>'></td>
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
				<td><input type="password" name="clientRePassword" value='<%=resultClient.getString("clientPassword")%>'></td>
			</tr>
		</table>
			<button name="cancel" formaction="view-client-account-management.jsp">BATAL</button>
			<button type="submit" formaction="ClientHandler?action=updateClientCom&nextPage=viewAccount">SIMPAN</button>
		</form>
		<% } %>
		<%-- # END: EDIT CLIENT ACCOUNT # --%>
		<script>
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
			
			
			var myInput = document.getElementById("clientPassword");
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