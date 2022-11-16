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
		<title>Tempahan | Al Khairiah</title>
	</head>
	<body>
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int booking_ID = 0;
		int committee_ID = 0;
		int counter = 0;
		boolean isManager = false;
		double paymentTotal = 0.0;
		Connection connection;
		PreparedStatement animalOrderListSQL;
		ResultSet resultOrder;
		String strSQL;
		
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
		
		booking_ID = (int)request.getAttribute("bookingID");
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
		
		<%-- SQL QUERY: BOOKING INFORMATION --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultBooking">
			SELECT c.clientid AS "clientid", c.clientfullname AS "clientfullname", c.clientemail AS "clientemail", c.clientphonenum AS "clientphonenum", c.clientaddress AS "clientaddress", c.clientpassword AS "clientpassword", c.clientbirthdate AS "clientbirthdate",
        	b.bookingid AS "bookingid", b.bookingdate AS "bookingdate", b.committeeid AS "committeeid",
       	 	p.paymentid AS "paymentid", p.paymenttotal AS "paymenttotal", p.paymentdate AS "paymentdate", p.paymentreceiptfile AS "paymentreceiptfile", p.paymentreceiptname AS "paymentreceiptname"
			FROM client c
			JOIN booking b
			USING (clientid)
			JOIN payment p
			USING (bookingid)
			WHERE b.bookingid = <%= booking_ID %>
		</sql:query>
		
		<%-- # START: HEADER --%>
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAVIGATION ELEMENTS # --%>
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
		<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
		<a href="client-list.jsp">Senarai Klien</a><br>
		<% if(isManager) { /* If committee is Manager */%>
			<a href="committee-list.jsp">Senarai AJK</a><br>
		<% } %>
		<a href="LoginHandler?action=logout">Log Keluar</a><br>
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
		
		<%-- # START: BOOKING INFORMATION DISPLAY # --%>
		<br><br><h2>MAKLUMAT TEMPAHAN</h2>
		
		<c:forEach var="booking" items="${resultBooking.rows}">
		
		<%-- Client Information --%>
		<h3>Klien</h3>
		<table>
			<tr>
				<td>ID Klien:</td>
				<td><c:out value="${booking.clientid}"/></td>
			</tr>
			<tr>
				<td>Nama:</td>
				<td><c:out value="${booking.clientfullname}"/></td>
			</tr>
			<tr>
				<td>Tarikh Lahir:</td>
				<td><c:out value="${booking.clientbirthdate}"/></td>
			</tr>
			<tr>
				<td>Alamat:</td>
				<td><c:out value="${booking.clientaddress}"/></td>
			</tr>
			<tr>
				<td>No. Telefon:</td>
				<td><c:out value="${booking.clientphonenum}"/></td>
			</tr>
			<tr>
				<td>Email:</td>
				<td><c:out value="${booking.clientemail}"/></td>
			</tr>
		</table>
		
		<%-- Booking Information --%>
		<br><br>
		<h3>Tempahan</h3>
		<table>
			<tr>
				<td>ID Tempahan: </td>
				<td><c:out value="${booking.bookingid}"/></td>
			</tr>
			<tr>
				<td>Tarikh Tempahan: </td>
				<td><c:out value="${booking.bookingdate}"/></td>
			</tr>
			<tr>
				<td>Jumlah Bayaran: </td>
				<td>RM<fmt:formatNumber type="number" maxFractionDigits="2" value='${booking.paymenttotal}'/></td>
			</tr>
			
		</table>
		</c:forEach>
		
		<%-- Animal Order(s) --%>
		<h3>Senarai Tempahan</h3>
		<form method="post">
		<table>
			<tr>
				<td>No.</td>
				<td>Nama Tanggungan</td>
				<td>Jenis Bahagian</td>
				<td>Harga (RM)</td>
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
					
					} else if(resultOrder.getString("animaltype").equalsIgnoreCase("Unta")) { %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")/7%>'/> <% 
						
					} else if ((resultOrder.getString("animaltype")).equalsIgnoreCase("Kambing")){ %>
						<fmt:formatNumber type="number" maxFractionDigits="2" value='<%=resultOrder.getDouble("animalprice")%>'/> <% 
					
					} %>
				</td>
				<td>
					<input type="hidden" name="nextPage" value="viewBookingManagement">
					<input type="hidden" name="bookingID" value="<%=resultOrder.getInt("bookingID")%>">
					<button name="edit" formaction="AnimalOrderHandler?action=editAnimalOrderCommittee&animalOrderID=<%=resultOrder.getInt("animalorderid")%>">KEMASKINI NAMA</button>
				</td>
			</tr>
		<%
			} } catch(Exception e){
				e.printStackTrace();
			}	
		%>
		</table>
		
		<button name="back" formaction="booking-list-management.jsp">KEMBALI KE SENARAI</button>
		</form>
		<%-- # END: BOOKING INFORMATION DISPLAY # --%>

	</body>
</html>