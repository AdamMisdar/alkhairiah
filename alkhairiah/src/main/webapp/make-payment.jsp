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
		<title>Pembayaran | Al-Khairiah</title>
	</head>
	<body>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		int booking_ID = 0;
		int counter = 0;
		double paymentTotal = 0.0;
		Connection connection;
		PreparedStatement animalOrderListSQL;
		ResultSet resultOrder;
		String strSQL;
		
		/* Current Date */
		long todayMillis = System.currentTimeMillis();
		Date dateToday = new Date(todayMillis);
		
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
			paymentTotal = (double)request.getAttribute("paymentTotal");
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
			SELECT * from booking
			JOIN animalorder
			USING (bookingid)
			JOIN animaldetails
			USING (animaldetailsid)
			WHERE bookingid = <%= booking_ID %>
			ORDER BY animalorderid ASC
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=index-client.jsp">Laman Utama</a><br>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=view-client-account.jsp">Akaun</a><br>
		<a href="#create-booking">Buat Tempahan</a><br>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=booking-list-client.jsp">Senarai Tempahan</a><br>
		<a href="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=logout">Log Keluar</a><br><br>
		
		<%-- CLIENT INFO DISPLAY --%>
		KLIEN <br><c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach><br>
		
		<%-- # START: PAYMENT FORM # --%>
		<br><br><h2>PEMBAYARAN</h2>
		
		<%-- Booking Details --%>
		<h3>INVOIS: MAKLUMAT TEMPAHAN</h3>
		<p>ID Tempahan: <%= booking_ID %></p> 
		<p>ID Akaun: <%= client_ID %></p>
		<p>Tarikh Pembayaran: <%= dateToday %></p>
		
		<%-- Animal Order(s) --%>
		<h3>SENARAI TEMPAHAN</h3>
		<table>
			<tr>
				<td>No.</td>
				<td>Nama Tanggungan</td>
				<td>Jenis Haiwan (Bahagian)</td>
				<td>Harga Sebahagian (RM)</td>
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
					
					} else if(resultOrder.getString("animaltype").equalsIgnoreCase("Unta")) { %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")/7%>'/> <% 
						
					} else if ((resultOrder.getString("animaltype")).equalsIgnoreCase("Kambing")){ %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")%>'/> <% 
					
					} %>
				</td>
			</tr>
		<%
			} } catch(Exception e){
				e.printStackTrace();
			}	
		%>
		</table> 
		
		<h4>Jumlah Bayaran: RM<fmt:formatNumber type="number" maxFractionDigits="2" value="<%= paymentTotal %>"/></h4>
		
		<%-- Payment Receipt Upload --%>
		<h3>BUKTI PEMBAYARAN</h3>
		<p>Sila muat naik resit pembayaran anda.</p>
		<p>PDF/PNG/JPEG sahaja diterima.</p>
		
		<form method="post" enctype="multipart/form-data">
			<p>Resit Anda:</p>
			<input type="file" accept="image/pdf" name="paymentReceipt">
			
			<br><br>
			<input type="hidden" name="paymentTotal" value="<%=paymentTotal%>">
			<input type="hidden" name="paymentDate" value="<%=dateToday%>">
			<input type="hidden" name="bookingID" value="<%=booking_ID%>">
			
			<button name="back" formaction="BookingHandler?action=toBooking&bookingID=<%=booking_ID%>">KEMBALI KE TEMPAHAN</button>
			<button name="cancel" formaction="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=index-client.jsp">BATALKAN TEMPAHAN</button>
			<button type="submit" formaction="PaymentHandler?action=addPayment">BAYAR</button>
		</form>
		<%-- # END: PAYMENT FORM # --%>
	</body>
</html>