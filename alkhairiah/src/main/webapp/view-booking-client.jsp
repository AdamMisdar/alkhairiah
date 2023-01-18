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
	
	#back{
	background-color:#3679dd;
	color:white;
	}
	.parent{
	display: flex;
    align-items: center;
    justify-content: center;
	}
	input[type="file"]{
		display:block;
		width:200px;
	}
	
	#file{
	
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
</style>
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
		<div class="header">
			<div>
				<span style="position: absolute; right: 20px; top:7px; font-size: 16px; color: white;">NETGREEN</span>
				<span></span>
			</div>
		</div>
		<div class="wrapper">
			<div class="sidebar">
				<h2>PENGGUNA</h2>
				<div class="sidebarname">
					<p><c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach></p>
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
					
					<li><a href="index-client.jsp" ><i class="fas fa-home"></i>Halaman Utama</a></li>
					<li><a href="booking-list-client.jsp" ><i class="fas fa-address-book"></i>Senarai Tempahan</a></li>
					<li><a href="BookingHandler?action=createBooking" ><i class="fas fa-address-book"></i>Buat Tempahan</a></li>
					<li><a href="view-client-account.jsp"><i class="fas fa-user"></i> Akaun</a></li>
					<li><a href="LoginHandler?action=logout"> Log Keluar</a></li>
			
				</ul> 
			</div>
		</div>
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
		
		<%-- CLIENT INFO DISPLAY --%>
		
		
		<%-- # START: BOOKING DETAILS # --%>
		<br><br><h2>MAKLUMAT TEMPAHAN</h2>
		
		<%-- Booking Details --%>
		
     
		<p>ID Tempahan: <%= booking_ID %></p> 
		<p>ID Akaun: <%= client_ID %></p>
		<c:forEach var="booking" items="${resultBooking.rows}">
			<p>Tarikh Tempahan: <c:out value='${booking.bookingdate}'/></p>
			<p>Tarikh Pembayaran: <c:out value='${booking.paymentdate}'/></p>
			<h4>Jumlah Bayaran: RM<fmt:formatNumber type="number" maxFractionDigits="2" value="${booking.paymentTotal}"/></h4>
		</c:forEach>
		<br>
		
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
		
			<button name="back" id="back" formaction="booking-list-client.jsp">KEMBALI KE SENARAI</button>
		</form>
		
		<%-- # END: BOOKING DETAILS # --%>
	</body>
</html>