<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="alkhairiah.connection.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %> <%-- Number formatter --%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Maklumat Tempahan | Al-Khairiah</title>
	</head>
	<body>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		int counter = 0;
		int booking_ID = 0;
		double paymentTotal = 0.0;
		Connection connection;
		PreparedStatement animalOrderListSQL;
		ResultSet resultOrder;
		String strSQL;
		
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
		
		<%-- SQL QUERY: BOOKING DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultBooking">
			SELECT *
			FROM payment
			JOIN booking
			USING (bookingid)
			WHERE bookingID = <%= booking_ID %>
		</sql:query>
		
		<%-- SQL QUERY: ANIMAL ORDER(S) DETAILS --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimalOrder">
			SELECT *
			FROM booking
			JOIN animalorder
			USING (bookingid)
			JOIN animaldetails
			USING (animaldetailsid)
			WHERE bookingID = <%= booking_ID %>
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
		<a href="index-client.jsp">Laman Utama</a><br>
		<a href="view-client-account.jsp">Akaun</a><br>
		<a href="BookingHandler?action=createBooking">Buat Tempahan</a><br>
		<a href="booking-list-client.jsp">Senarai Tempahan</a><br>
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br>
		
		<%-- CLIENT INFO DISPLAY --%>
		KLIEN <br><c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach><br>
		
		<%-- # START: BOOKING DETAILS # --%>
		<br><br><h2>MAKLUMAT TEMPAHAN</h2>
		
		<%-- Booking Details --%>
		<h3>MAKLUMAT TEMPAHAN</h3>
		<p>ID Tempahan: <%= booking_ID %></p> 
		<p>ID Akaun: <%= client_ID %></p>
		<c:forEach var="booking" items="${resultBooking.rows}">
			<p>Tarikh Tempahan: <c:out value='${booking.bookingdate}'/></p>
			<p>Tarikh Pembayaran: <c:out value='${booking.paymentdate}'/></p>
			<h4>Jumlah Bayaran: RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${booking.paymentTotal}"/></h4>
		</c:forEach>
		
		<%-- Animal Order(s) --%>
		<h3>SENARAI NAMA DAN TEMPAHAN HAIWAN</h3>
		<form method="post">
			<input type="hidden" name="bookingID" value="<%= booking_ID %>">
			<input type="hidden" name="clientID" value="<%= client_ID %>">
			
		<table>
			<tr>
				<td>No.</td>
				<td>Nama Tanggungan</td>
				<td>Jenis Haiwan (Bahagian)</td>
				<td>Harga Sebahagian (RM)</td>
				<td></td>
			</tr>
			<%
			try{
				
				// Get connection
				connection = ConnectionManager.getConnection();
				
				// SQL Statement
				strSQL = "SELECT * FROM animalorder JOIN animaldetails USING (animaldetailsid) WHERE bookingid = ?";
				
				// Prepare Statement
				animalOrderListSQL = connection.prepareStatement(strSQL);
				
				// Set ? values
				animalOrderListSQL.setInt(1, booking_ID);
				
				// Result
				resultOrder = animalOrderListSQL.executeQuery();
				
				// While
				while(resultOrder.next()){
			%>
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><%=resultOrder.getString("dependentname")%></td>
				<td><%=resultOrder.getString("animaltype")%></td>
				<td>	
					<%
					
					if((resultOrder.getString("animaltype")).equalsIgnoreCase("Lembu")) { %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")/7%>'/> <%
						
						paymentTotal += (resultOrder.getDouble("animalprice")/7);
					
					} else if(resultOrder.getString("animaltype").equalsIgnoreCase("Unta")) { %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")/7%>'/> <% 
						
						paymentTotal += (resultOrder.getDouble("animalprice")/7); 
						
					} else if ((resultOrder.getString("animaltype")).equalsIgnoreCase("Kambing")){ %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")%>'/> <% 
					
						paymentTotal += (resultOrder.getDouble("animalprice"));
					
					} %>
				</td>
				<td>
					<input type="hidden" name="nextPage" value="viewBooking">
					<button name="edit" formaction="AnimalOrderHandler?action=editAnimalOrder&animalOrderID=<%=resultOrder.getInt("animalorderid")%>">KEMASKINI NAMA</button>
				</td>
			</tr>
			<%
			} } catch(Exception e){
				e.printStackTrace();
			}	
			%>
			<%-- Total Payment of All Animal Order(s) --%>
			<tr>
				<td></td>
				<td></td>
				<td>Jumlah (RM)</td>
				<td>	
					<fmt:formatNumber type="number" maxFractionDigits="2" value="<%=paymentTotal%>"/>
					<input type="hidden" name="paymentTotal" value="<%=paymentTotal%>">
				</td>
			</tr>
		</table>
		
			<button name="back" formaction="booking-list-client.jsp">KEMBALI KE SENARAI</button>
		</form>
		
		<%-- # END: BOOKING DETAILS # --%>
	</body>
</html>