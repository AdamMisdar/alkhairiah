<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Laman Utama Netgreen Qurban | Al-Khairiah</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
   		 <meta name="viewport" content="width=device-width, initial-scale=1.0">
				<style>
				*{
		    margin: 0;
		    padding: 0;
		}
		.banner-area{
		    background-image: url("cow_bg.jpg");
		    background-position: center center;
		    background-size:cover ;
		    /* -webkit-background-size:cover ; */
		    height: 100vh;
		    width: auto;
		    margin: auto;
		}
		.menu{
		    float: right;
		    list-style: none;
		    margin-top:30px;
		}
		.menu ul li{
		    display: inline-block;
		}
		.menu ul li a{
		    color: #fff;
		    text-decoration: none;
		    padding: 5px 20px;
		    font-family: 'poppins' ,sans-serif;
		    font-size: 16px;
		}
		.menu ul li a:hover{
		    color: #09b15d;
		}
		/* .logo{
		    height: 20%;
		    float: left;
		    color: azure;
		    list-style: none;
		    
		} */
		.banner-text{
		    position: absolute;
		    width: 800px;
		    height: 300px;
		    margin: 20% 20%;
		    text-align: center;
		    
		}
		.banner-text h1{
		    text-align: center;
		    color:#005229;
		    text-transform: uppercase;
		    font-size: 50px;
		
		    font-family: 'poppins' , sans-serif;
		}
		.banner-text p{
		    color: #fff;
		    font-size: 15px;
		}
		.banner-text a{
		    border: 1px solid #fff;
		    padding: 10px 25px;
		    text-decoration: none;
		    text-transform: uppercase;
		    font-size: 14px;
		    margin-top: 20px;
		    display: inline-block;
		    color: #fff;
		}
		.banner-text a:hover{
		    background-color: #037247;
		    color: white;
		    font-weight: bold;
		    border:none;
		    
		    
		}
		.welcome{
			position:absolute;
			margin:0 auto;
			display:flex;
			align-items:center;
		
		}
		</style>
		
	</head>
	<body>
		<div class="banner-area">
    <header>
           <div class="menu">
                <ul>
                    <li><a href="index-client.jsp">Laman Utama</a></li>
                    <li><a href="view-client-account.jsp">Akaun</a></li>
                    <li><a href="BookingHandler?action=createBooking">Buat Tempahan</a></li>
                    <li><a href="booking-list-client.jsp">Senarai Tempahan</a></li>
                    <li><a href="LoginHandler?action=logout">Log Keluar</a></li>
                  
                </ul>
            </div>
            
	
        </header>
        <div class="banner-text">
            <h1>QURBAN AL-KHAIRIAH</h1>
            <p>Tidak ada suatu amalan yang paling dicintai oleh Allah daripada Bani Adam ketika hari raya Eidul Adha selain menyembelih haiwan korban. Sesungguhnya haiwan itu akan datang pada hari kiamat (sebagai saksi) dengan tanduk, bulu dan kukunya. Dan sesungguhnya darah haiwan korban telah terletak di suatu tempat di sisi Allah sebelum mengalir di tanah. Kerana itu, bahagiakan dirimu dengannya.</p>
            <a href="BookingHandler?action=createBooking">Buat tempahan</a>
        </div>


    </div>
		<%-- CLIENT: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int client_ID = 0;
		
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
		
		<%-- # START: HEADER --%>
		
		<%-- # END: HEADER --%>
		
		<%-- NAVIGATION ELEMENTS --%>
			
		<%-- CLIENT INFO DISPLAY --%>
		<div class="welcome">
		Selamat Datang, <c:forEach var="client" items="${resultClient.rows}"><c:out value="${client.clientfullname}"/></c:forEach><br>
		</div>
		<%-- All other home page details here --%>
		
		
	</body>
</html>