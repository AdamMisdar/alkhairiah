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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/fontawesome.min.css">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans|Roboto" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
		NETGREEN<br>
		<%-- # END: HEADER --%>
		
		<%-- # START: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		<%-- All Committee --%>
		<a href="index-committee.jsp">Laman Utama</a><br>
		<a href="view-committee-account.jsp">Akaun</a><br>
		
		<%-- Management Only --%>
		<% if(committeeType.equalsIgnoreCase("Management")) { %>
			<a href="booking-list-management.jsp">Senarai Tempahan</a><br>
			<a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a><br>
			<a href="client-list.jsp">Senarai Klien</a><br>
			<%-- Manager Only --%>
			<% if(isManager) { %>
				<a href="committee-list.jsp">Senarai AJK</a><br>
			<% } %>
			
		<% } %>
		
		<a href="LoginHandler?action=logout">Log Keluar</a><br><br><br>
	
       
		<%-- # END: NAV ELEMENTS DISPLAY ACCORDING TO COMMITTEE TYPE # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<%-- Management --%>
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
		

		<%-- Voluntary --%>
		<% } else if(committeeType.equalsIgnoreCase("Voluntary")) { %>
		
		<c:forEach var="voluntary" items="${resultCommittee.rows}">
			<span>SUKARELAWAN<br></span>
            <span><c:out value="${voluntary.voluntaryRole}"/></span><br>
            <span><c:out value="${voluntary.committeefullname}"/></span><br><br>
		</c:forEach>
		
		
		<% } %>
		
		<%-- # END: COMMITTEE INFO DISPLAY # --%>

		<%-- All other home page details here --%>
		<br><br>ALL OTHER ELEMENTS HERE
		
		
		
	</body>
</html>