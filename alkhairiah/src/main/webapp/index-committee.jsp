<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Laman Utama | Al-Khairiah</title>
		<meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laman Utama Netgreen Qurban</title>
        
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
	
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int committee_ID = 0;
		boolean isManager = false;
		String committeeType = ""; 
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("committeeID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			committee_ID = (int)session.getAttribute("committeeID");
			committeeType = (String)session.getAttribute("committeeType");
			isManager = (boolean) session.getAttribute("isManager");
		} 
		%>
		
		<%-- DATABASE --%>
		<sql:setDataSource var="qurbanDatabase" driver="org.postgresql.Driver"
		                   url="jdbc:postgresql://localhost:5432/alkhairiah"
		                   user="postgres"
		                   password="system" />
		
		<%-- # START: CURRENT COMMITTEE DETAILS SQL # --%>
		<%
		/* Management */
		if(committeeType.equalsIgnoreCase("Management")) { 
		%>
		
		<%-- SQL QUERY: Management Details--%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
			SELECT * FROM management WHERE committeeid = <%=committee_ID%>
		</sql:query>	
			
		<%	 
		/* Voluntary */	
		} else if (committeeType.equalsIgnoreCase("Voluntary")) { 
		%>
				
		<%-- SQL QUERY: Voluntary Details --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultCommittee">
			SELECT * FROM voluntary WHERE committeeid = <%=committee_ID%>
		</sql:query>
		
		<% } %>
		<%-- # END: CURRENT COMMITTEE DETAILS SQL # --%>
		
		<%-- # START: HEADER --%>
		<div class="banner-area">
    <header>
           <div class="menu">
                <ul>
              		<li><a href="index-committee.jsp">Laman Utama</a></li>
					<li><a href="view-committee-account.jsp">Akaun</a></li>
		
                  	<% if(committeeType.equalsIgnoreCase("Management")) { %>
					<li><a href="booking-list-management.jsp">Senarai Tempahan</a></li>
					<li><a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a></li>
					<li><a href="client-list.jsp">Senarai Klien</a><br></li>
					<%-- Manager Only --%>
					<% if(isManager) { %>
						<li><a href="committee-list.jsp">Senarai AJK</a></li>
					<% } %>
					
				<% } %>
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
		<%-- # END: HEADER --%>
		
		<%-- # START: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		<%-- All Committee --%>
		<%--
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		--%>
		<%-- Management Only 
		<% if(committeeType.equalsIgnoreCase("Management")) { %>
			<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
			<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
			<a href="client-list.jsp">Senarai Klien</a><br>
			<%-- Manager Only 
			<% if(isManager) { %>
				<a href="committee-list.jsp">Senarai AJK</a><br>
			<% } %>
			
		<% } %>
		
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br><br>
			--%>
       
		<%-- # END: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<%-- Management 
		<% if(committeeType.equalsIgnoreCase("Management")) { %>
		
		<c:forEach var="management" items="${resultCommittee.rows}">
			<% if(isManager) { /* If this is a Manager */%>
				<span>PENGURUSAN (PENGURUS)</span><br>
			<% } else { /* If this is an ordinary management committee */%>
				<span>PENGURUSAN</span><br>
			<% } %>
            <span><c:out value="${management.managementposition}"/></span><br>
            <span><c:out value="${management.committeefullname}"/></span><br><br>
		</c:forEach>
		
			--%>
		<%-- Voluntary 
		<% } else if(committeeType.equalsIgnoreCase("Voluntary")) { %>
		
		<c:forEach var="voluntary" items="${resultCommittee.rows}">
			<span>SUKARELAWAN<br></span>
            <span><c:out value="${voluntary.voluntaryRole}"/></span><br>
            <span><c:out value="${voluntary.committeefullname}"/></span><br><br>
		</c:forEach>
		
		
		<% } %>
		--%>
		<%-- # END: COMMITTEE INFO DISPLAY # --%>

		<%-- All other home page details here --%>
		
		
		
		
	</body>
</html>