<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Daftar Akaun Klien | Al-Khairiah</title>
		
		<style>
  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans:wght@700&family=Poppins:wght@400;500;600&display=swap');
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Poppins", sans-serif;
}
body{
  
  margin: 0;
  padding: 0;
  height: 100vh;
  overflow: hidden;
  background-color: #578572;
  
}
.container{
  background-image: url('loginOrderImage.jpg');
  background-size:cover ;
  background-repeat:no-repeat;
  margin: auto;
  width: 100%;
  height: 100%;
  max-width: 100%;
  min-width: 100%;
  max-height: 100%;
  position: absolute;
  z-index: -1;
}
.center{
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  min-width: 500px;
  min-height: 400px;
  background: rgb(255, 255, 255);
  border-radius: 10px;
  box-shadow: 15px 15px 15px 15px rgba(0, 0, 0, 0.05);
  
}
.center h1{
  text-align: center;
  padding: 20px 0;
  border-bottom: 1px solid silver;
  
}
.center form{
  position: relative;
  box-sizing:border-box;
  text-align:center;
  margin: auto;
  padding: 30px;
}
.image{
  background-color: #ffffff;
  height: 80vh;
  width: 100vh;
  z-index: 20;
  position: relative;
  display: block;
  margin: auto auto;
  padding: auto;
  top: 50%;
  left: 20%;
  transform: translate(-70%, -50%);
  backdrop-filter: blur(4px) saturate(180%);
    -webkit-backdrop-filter: blur(4px) saturate(180%);
    background-color: rgba(238, 240, 246, 0.65);
    border-radius: 12px;
    border: 1px solid rgba(255, 255, 255, 0.125);
 
  
}
.imagecontainer{
  height: 60vh;
  width: 70vh;
  z-index: 21;
  position: relative;
  display: flex;
  
  margin: auto auto;
  padding: 10px;
  top: 15%;
  left: 0%;
  border-radius: 12px;
  background-image: url('login.svg');
  background-repeat: no-repeat;
  background-size: 80%;
  background-position: 50%;
  
}
form .txt_field{
  position: relative;
  border-bottom: 2px solid #adadad;
  margin: 30px 0;
  
}
.txt_field input{
  width: 100%;
  padding: 0 5px;
  height: 40px;
  font-size: 16px;
  border: none;
  background: none;
  outline: none;
}
.txt_field label{
  position: absolute;
  top: 50%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  font-size: 16px;
  pointer-events: none;
  transition: .5s;
}
.txt_field span::before{
  content: '';
  position: absolute;
  top: 40px;
  left: 0;
  width: 0%;
  height: 2px;
  background: #26d98e;
  transition: .5s;
}
ul.valid-password {
    margin-top: 8px;
    font-size: 14px;
    line-height: 24px;
    list-style: circle;
    
    li.valid {
      color: green;
      list-style: disc;
    }
  }
.txt_field input:focus ~ label,
.txt_field input:valid ~ label{
  top: -5px;
  color: #26d98e;
}
.txt_field input:focus ~ span::before,
.txt_field input:valid ~ span::before{
  width: 100%;
}
.pass{
  margin: -5px 0 20px 5px;
  color: #a6a6a6;
  cursor: pointer;
}
.pass:hover{
  text-decoration: underline;
}
input[type="submit"]{
  width: 100%;
  height: 50px;
  border: 1px solid;
  background: #1dac70;
  border-radius: 25px;
  font-size: 18px;
  color: #e9f4fb;
  font-weight: 700;
  cursor: pointer;
  outline: none;
}
input[type="submit"]:hover{
  border-color: #2691d9;
  transition: .5s;
}
.signup_link{
  margin: 30px 0;
  text-align: center;
  font-size: 16px;
  color: #666666;
}
.signup_link a{
  color: #2691d9;
  text-decoration: none;
}
.signup_link a:hover{
  text-decoration: underline;
}
input[type="date"]::before {
  content: attr(placeholder);
  position: absolute;
  color: #999999;
}
input[type="date"] {
  color: #ffffff;
}
input[type="date"]:focus,
input[type="date"]:valid {
  color: #666666;
}
input[type="date"]:focus::before,
input[type="date"]:valid::before {
  content: "";
}
#alert{
  color:red;
  font-weight: 500;
  padding-bottom: 10px;
}
#voluntary{
  text-align: left;
  color: #1dac70;
}
select {
  -webkit-appearance:none;
  -moz-appearance:none;
  -ms-appearance:none;
  appearance:none;
  outline:0;
  box-shadow:none;
  border:0!important;
  background: #057561;
  background-image: none;
  flex: 1;
  padding: 5px;
  color:#fff;
  cursor:pointer;
  font-size: 1em;
  font-family: 'Open Sans', sans-serif;
}
select::-ms-expand {
  display: none;
}
.select {
  position: relative;
  display: flex;
  width: 20em;
  height: 2.5em;
  line-height: 3;
  background: 057561;
  overflow: hidden;
  border-radius: .25em;
  margin-top: 5px;
}
.select::after {
  content: '\25BC';
  position: absolute;
  top: 0;
  right: 0;
  padding: 0 1em;
  background: #035e43;
  cursor:pointer;
  pointer-events:none;
  transition:.25s all ease;
}
.select:hover::after {
  color: #b0f0e4;
}
</style>

	</head>
	<body >
		<%-- # REGISTRATION FORM # --%>
		<div class="center">
			<h1>DAFTAR AKAUN KLIEN</h1>
			<div class="containerform">		
			<form id="form" method="post" onsubmit="return validate()">
				<div class="txt_field">
			            <input type="text" name="clientFullName" required>
			            <span></span>
			            <label>Nama Penuh:</label>
         		 </div>
         		 <div class="txt_field">
			            <input id="email" type="email" name="clientEmail" required onkeydown="validation()">
			            
			            <span id="text" ></span>
			            <label>Email:</label>
			           
          		</div>
          		<div class="txt_field">
           				<input id="clientPhoneNum" type="text" name="clientPhoneNum" required >
            			<span ></span>
            			<label >Phone Number</label>
         		 </div>
         		 <div class="txt_field">
			            <input type="text" name="clientAddress" required>
			            <span></span>
			            <label>Alamat:</label>
          		</div>
          		 <div class="txt_field">
			            <input type="date" name="clientBirthDate" required>
			            <span></span>
			            <label>Tarikh Lahir:</label>
         		 </div>
         		 <div class="txt_field">
			            <input type="password" name="clientPassword" id="clientPassword" required >
			            <span></span>
			            <label>Kata Laluan:</label>
			            
		          </div>
		         
		          <div class="txt_field">
			            <input type="password" name="clientPassword" id="clientReenterPassword" onkeyup="check(this)" required >
			            <span></span>
			            <label>Masukkan semula kata laluan:</label>
		          </div>
          				<p><error id="alert"></error></p>
				<%-- 
				<button type="submit" formaction="ClientHandler?action=createClient">DAFTAR AKAUN</button>
				--%>
				<input type="submit" id="create" class="button" name="submit" formaction="ClientHandler?action=createClient" onsubmit="validatePassword()" onclick="wrong_pass_alert()" value="Daftar Akaun" >
				<div class="signup_link">
	            	<a href="login.jsp">Kembali</a>
	          	</div>
	          	
			</form>
			<%-- 
			<br>Sudah ada akaun? <a href="login.jsp">Log Masuk</a>
			--%>
			</div>
		</div>
		
		
		<script type="text/javascript">
		
		
        var password = document.getElementById('clientPassword');
        var flag= 1; 
        function check(elem){
            if(elem.value.length > 0){
                if(elem.value != password.value){
                    document.getElementById('alert').innerText = "Kata laluan tidak sama";
                    flag=0;
                    document.getElementById('create').disabled = true;
                document.getElementById('create').style.opacity = (0.4);
                }
                else{
                    document.getElementById('alert').innerText="";
                    flag=1;
                    document.getElementById('create').disabled = false;
                    document.getElementById('create').style.opacity = (1);
                }
            }else{
                document.getElementById('alert').innerText = "Masukkan kembali kata laluan anda";
                flag=0;
                document.getElementById('create').disabled = true;
                document.getElementById('create').style.opacity = (0.4);
            }
        }
        
        function validate(){
            if(flag==1){
                return true;
            }
            else{
                return false;
            }
        }
        
        function wrong_pass_alert() {
            if (document.getElementById('clientPassword').value != "" &&
                document.getElementById('clientReenterPassword').value != "") {
                alert("Pendaftaran akaun anda telah berjaya");
            } else {
                alert("Sila isi semua maklumat");
            }
            
            	}
        
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
//        	    field.value = field.value.replace(/[^0-9\-]/g,'')
        	    phone_formatting(field,'revert');
        	  }

        	}

        	document.getElementById('clientPhoneNum').onkeyup = function(e) {
        	  phone_number_check(this,e);
        	}
        	
        	function validatePassword() {
        	    var p = document.getElementById('clientPassword').value,
        	        errors = [];
        	    if (p.length < 8) {
        	        errors.push("Your password must be at least 8 characters"); 
        	    }
        	    if (p.search(/[a-z]/i) < 0) {
        	        errors.push("Your password must contain at least one letter.");
        	    }
        	    if (p.search(/[0-9]/) < 0) {
        	        errors.push("Your password must contain at least one digit."); 
        	    }
        	    if (errors.length > 0) {
        	        alert(errors.join("\n"));
        	        return false;
        	    }
        	    return true;
        	}
        	
       
</script>
	</body>
</html>