<%-- Pay attention to navigation elements --%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Kemaskini Nama | Al-Khairiah</title>
	</head>
	<body>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		int booking_ID = 0;
		int animalOrder_ID = 0;
		boolean isCreateBooking = false;
		String nextPage = "";
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("clientID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			client_ID = (int)session.getAttribute("clientID");
			booking_ID = (int)request.getAttribute("bookingID");
			animalOrder_ID = (int)request.getAttribute("animalOrderID");
			nextPage = (String)request.getAttribute("nextPage");
		}
		
		// If client is in 'create booking' use case, navigation links is different
		if(nextPage.equalsIgnoreCase("createBooking")){
			isCreateBooking = true;
		}
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		<%-- SQL QUERY: CLIENT DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultClient">
			SELECT * FROM client WHERE clientid = <%=client_ID%>
		</sql:query>
		
		<%-- SQL QUERY: THIS SPECIFIC ANIMAL ORDER DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimalOrder">
			SELECT * from booking
			JOIN animalorder
			USING (bookingid)
			JOIN animaldetails
			USING (animaldetailsid)
			WHERE bookingid = <%= booking_ID %>
			AND animalorderid = <%= animalOrder_ID %>
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
		<% if(isCreateBooking) { %>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=index-client.jsp">Laman Utama</a><br>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=view-client-account.jsp">Akaun</a><br>
		<a href="#create-booking">Buat Tempahan</a><br>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=booking-list-client.jsp">Senarai Tempahan</a><br>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=logout">Log Keluar</a><br><br>
		<% } else { %>
		<a href="index-client.jsp">Laman Utama</a><br>
		<a href="view-client-account.jsp">Akaun</a><br>
		<a href="BookingHandler?action=createBooking">Buat Tempahan</a><br>
		<a href="booking-list-client.jsp">Senarai Tempahan</a><br>
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br>
		<% } %>
		
		<%-- CLIENT INFO DISPLAY --%>
		KLIEN<br><c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach><br>
		
		<%-- # START: ANIMAL ORDER UPDATE FORM # --%>
		<br><br><h2>KEMASKINI NAMA TEMPAHAN</h2>
		
		<p>ID Tempahan: <%= booking_ID %></p> 
		<p>ID Akaun: <%= client_ID %></p> 
		
		<form method="post">
			<input type="hidden" name="bookingID" value="<%=booking_ID%>">
			<input type="hidden" name="animalOrderID" value="<%=animalOrder_ID%>">
			
		<table>
			<c:forEach var="animalOrder" items="${resultAnimalOrder.rows}">
			<tr>
				<td>Jenis Haiwan</td>
				<td><c:out value="${animalOrder.animaltype}"/></td>
			</tr>
			<tr>
				<td>Nama</td>
				<td><input type="text" name="dependentName" value="${animalOrder.dependentname}" placeholder="Nama Tanggungan"></td>
			</tr>
			</c:forEach>
		</table>
			<input type="hidden" name="nextPage" value="<%=nextPage%>"> 
			<button name="cancel" formaction="AnimalOrderHandler?action=cancelUpdate">BATAL</button>
			<button type="submit" formaction="AnimalOrderHandler?action=updateAnimalOrder">SIMPAN</button>	
		</form>
		<%-- # END: ANIMAL ORDER UPDATE FORM # --%>
	</body>
</html>