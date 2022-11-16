<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Daftar Akaun Klien | Al-Khairiah</title>
	</head>
	<body>
		<%-- # REGISTRATION FORM # --%>
		<h2>DAFTAR AKAUN KLIEN</h2>
				
		<form method="post">
			<table>
				<tr>
					<td>Nama Penuh</td>
					<td><input type="text" name="clientFullName" placeholder="Nama" required></td>
				</tr>
				<tr>
					<td>Emel</td>
					<td><input type="email" name="clientEmail" placeholder="contoh@emel.com" required></td>
				</tr>
				<tr>
					<td>No. Telefon</td>
					<td><input type="text" name="clientPhoneNum" placeholder="0123456789" required></td>
				</tr>
				<tr>
					<td>Alamat Rumah</td>
					<td><input type="text" name="clientAddress" placeholder="Alamat" required></td>
				</tr>
				<tr>
					<td>Tarikh Lahir</td>
					<td><input type="date" name="clientBirthDate" required></td>
				</tr>
				<tr>
					<td>Kata Laluan</td>
					<td><input type="password" name="clientPassword" placeholder="********" required></td>
				</tr>
				<tr>
					<td>Masukkan Semula Kata Laluan</td>
					<td><input type="password" name="clientRePassword" placeholder="********" required></td>
				</tr>
			</table>
			
			<button type="submit" formaction="ClientHandler?action=createClient">DAFTAR AKAUN</button>
		</form>
		
		<br>Sudah ada akaun? <a href="login.jsp">Log Masuk</a>
	</body>
</html>