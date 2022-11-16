<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Log Masuk | Al-Khairiah</title>
	</head>
	<body>
	
	<%-- # LOGIN FORM # --%>
	<form method="post">
	<h2>Log Masuk</h2><br><br>
	
	<%-- 1. Login Details --%>
	E-mel
	<input type="text" name="email" required><br><br>
	
	Kata laluan
	<input type="password" name="password" required><br><br>
	
	<%-- 2. Submit Button --%>
	<input type="submit" value="Log Masuk" formaction="LoginHandler?action=login"><br><br>
	
	<%-- 3. Other buttons --%>
	<a href="#">Terlupa kata laluan?</a><br>
	<a href="registration-client.jsp">Tiada akaun? Cipta akaun baru</a>

	</form>
	<%-- # CLOSE LOGIN FORM # --%>
	
	</body>
</html>