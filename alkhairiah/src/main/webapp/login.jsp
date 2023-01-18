<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Log Masuk | Al-Khairiah</title>
		<link rel="stylesheet" type="text/css" href="login.css">
		
	</head>
	<body>
	<div class="container">
	</div>
	<div class="center">
		<%-- # LOGIN FORM # --%>
		<form method="post">
		<h1>Log Masuk</h1>
		<div class="containerform">
		<%-- 1. Login Details --%>
		
		E-mel
		<div class="txt_field">
		<input id="email" type="text" name="email" required><br><br>
		</div>
		
		Kata laluan
		<div class="txt_field">
		<input id="password" type="password" name="password" required><br><br>
		</div>
		<%-- 2. Submit Button --%>
		<div class="pass">Terlupa Kata Laluan?</div>
		<input type="submit" value="Log Masuk" onclick="validation();" formaction="LoginHandler?action=login"><br><br>
		
		<%-- 3. Other buttons --%>
		<div class="signup_link">
			Tiada akaun? <a href="registration-client.jsp">Cipta akaun baru</a>
		</div>
		</form>
		<%-- # CLOSE LOGIN FORM # --%>
		</div>
	</div>
	<div class="image">
      	<div class="imagecontainer">

      	</div> 
    </div>
    
   
	</body>
</html>