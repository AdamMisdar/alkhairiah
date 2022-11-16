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
		<title>Tempahan Baru | Al-Khairiah</title>
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
		
		<%-- SQL QUERY: ANIMAL DETAILS LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimalDetails">
			SELECT * FROM animaldetails ORDER BY animaltype
		</sql:query>
		
		<%-- SQL QUERY: ANIMAL ORDER LIST FOR THIS BOOKING --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultAnimalOrder">
			SELECT * from booking
			JOIN animalorder
			USING (bookingid)
			JOIN animaldetails
			USING (animaldetailsid)
			WHERE bookingid = <%= booking_ID %>
			ORDER BY animalorderid
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
		
		<%-- # START: BOOKING SEGMENT # --%>
		<br><br><h2>TEMPAHAN BARU</h2>
		
		<p>ID Tempahan: <%= booking_ID %></p>
		<p>ID Akaun: <%= client_ID %></p>
		
		<%-- SECTION: Add Animal Order(s) --%>
		<br><h3>Informasi Korban</h3>
				
		<%-- Dependent Information --%>
		<form method="post">
		<table>
			<tr>
				<td>Jenis Haiwan</td>
				<td>
					<select name="animalDetailsID">
						<c:forEach var="animal" items="${resultAnimalDetails.rows}">
							<option value="${animal.animaldetailsid}"><c:out value="${animal.animaltype} - RM${animal.animalprice}"/></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>Nama Tanggungan</td>
				<td><input type="text" name="dependentName" value="" placeholder="Nama Tanggungan"></td>
			</tr>
		</table>
			<input type="hidden" name="bookingID" value="<%=booking_ID%>">
			<button type="reset">KOSONGKAN</button>
			<button type="submit" formaction="AnimalOrderHandler?action=addAnimalOrder">TAMBAH</button>
		</form>
		
		<%-- SECTION: Animal Details List --%>
		<br><h3>SENARAI HAIWAN KORBAN</h3>
		<table>
			<tr>
				<td>Jenis Haiwan</td>
				<td>Harga Sebahagian</td>
			</tr>
			<c:forEach var="animalDetails" items="${resultAnimalDetails.rows}">
			<tr>
				<td><c:out value="${animalDetails.animaltype}"/></td>
				<td>
				 	<c:if test="${animalDetails.animaltype == 'Lembu'}">
						RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${animalDetails.animalprice/7}"/>/bahagian (seekor RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${animalDetails.animalprice}"/>)
					</c:if>
				 	<c:if test="${animalDetails.animaltype == 'Unta'}">
						RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${animalDetails.animalprice/7}"/>/bahagian (seekor RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${animalDetails.animalprice}"/>)
					</c:if>
					<c:if test="${animalDetails.animaltype == 'Kambing'}">
						RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${animalDetails.animalprice}"/>
					</c:if> 
				</td>
			</tr>
			</c:forEach>
		</table>
		
		<%-- SECTION: Inserted Animal Order(s) --%>
		<h3>SENARAI NAMA DAN TEMPAHAN HAIWAN</h3>
		<form method="post">
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
					<input type="hidden" name="nextPage" value="createBooking">
					<input type="hidden" name="animalOrderID" value="<%=resultOrder.getInt("animalorderid")%>">  
					<button name="edit" formaction="AnimalOrderHandler?action=editAnimalOrder&animalOrderID=<%=resultOrder.getInt("animalorderid")%>">KEMASKINI NAMA</button>
					<button name="delete" formaction="AnimalOrderHandler?action=deleteAnimalOrder&animalOrderID=<%=resultOrder.getInt("animalorderid")%>">BUANG</button>
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
		
			<input type="hidden" name="bookingID" value="<%=booking_ID%>">
			<input type="hidden" name="clientID" value="<%=client_ID%>">
			
			<button name="cancel" formaction="BookingHandler?action=cancelBooking&bookingID=<%= booking_ID %>&redirect=index-client.jsp">BATALKAN TEMPAHAN</button>
			<button type="submit" formaction="BookingHandler?action=toPayment">TERUS KE PEMBAYARAN</button>
		</form>
		<%-- # END: BOOKING SEGMENT # --%>
		
	</body>
</html>