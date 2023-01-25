<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Senarai AJK | Al-Khairiah</title>
	
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
		<%-- COMMITTEE: LOGIN REQUIREMENTS --%>
		<%
		// Variables
		int counter = 0; // for committee list display
		int committee_ID = 0;
		String query = "";
		
		// Filter user
		/* User is not logged in */
		if(session.getAttribute("committeeID")==null) {
			// Redirect to Login page
			response.sendRedirect("login.jsp");
		}
		/* User is logged in */
		else { 
			committee_ID = (int)session.getAttribute("committeeID");
		}
		
		if(request.getParameter("query") != null)
			query = request.getParameter("query");
		
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
		
		<%-- SQL QUERY: MANAGEMENT LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultManagement">
	   		SELECT committeeid, committeefullname, committeeemail, committeephonenum, managementposition AS "jobscope" FROM management
			WHERE committeefullname LIKE '%<%=query%>%' OR committeeemail LIKE '%<%=query%>%' OR committeephonenum LIKE '%<%=query%>%' OR managementposition LIKE '%<%=query%>%'
			ORDER BY committeeid
		</sql:query>
		
		<%-- SQL QUERY: VOLUNTARY LIST --%>
		<sql:query dataSource="${qurbanDatabase}" var="resultVoluntary">
			SELECT committeeid, committeefullname, committeeemail, committeephonenum, voluntaryrole AS "jobscope" FROM voluntary
			WHERE committeefullname LIKE '%<%=query%>%' OR committeeemail LIKE '%<%=query%>%' OR committeephonenum LIKE '%<%=query%>%' OR voluntaryrole LIKE '%<%=query%>%'
			ORDER BY committeeid
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
				<h2>PENGURUS</h2>
				<div class="sidebarname">
					<c:forEach var="manager" items="${resultCommittee.rows}">
			            <p><span><c:out value="${manager.managementposition}"/></span><br>
			            <p><span><c:out value="${manager.committeefullname}"/></span><br>
					</c:forEach>
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
					<li><a href="index-committee.jsp">Halaman Utama</a></li>
					<li><a href="booking-list-management.jsp" >Senarai Tempahan</a></li>
					<li><a href="animal-details-list.jsp">Senarai Maklumat Haiwan</a></li>
					<li><a href="client-list.jsp">Senarai Klien</a></li>
					<li><a href="committee-list.jsp">Senarai AJK</a></li>
					<li><a href="view-committee-account.jsp">Akaun</a></li>
					<li><a href="LoginHandler?action=logout"> Log Keluar</a></li>
				</ul> 
			</div>
		</div>
		<%-- # END: HEADER --%>
		<div style="width: 300px; position: absolute; right: 150px; top: 140px">
	<form action="" method="get">
		<input type="text" class="form-control" name="query" placeholder="Cari tempahan mengikut nama/tarikh..">
	 	<button name="search" formaction="committee-list.jsp" class="button" style="position: absolute; top: 5px; right:-100px; padding: 15px; padding-top: 7px; padding-bottom: 7px;">CARI</button>
	</form>
	<form action="" method="get">
		<input type="hidden" name="query" value="">
	 	<button name="q" formaction="committee-list.jsp" class="button" style="position: absolute; top: 50px; right:-100px; padding: 15px; background-color: #db0f31; color: white;  padding: 7px">RESET</button>
	</form>	
	</div>
		
		<%-- # START: NAVIGATION ELEMENTS # --%>
		
		<%-- # START: COMMITTEE INFO DISPLAY # --%>
		<br><br>
		<%-- Manager --%>
		
		<%-- # END: COMMITTEE INFO DISPLAY # --%>
		
		<%-- # START: COMMITTEE LIST CONTENT # --%>
		<br><br><h2>SENARAI AJK</h2>
		
		<%--SEARCH BAR
		<form method="get">
			<input type="text" name="query" placeholder="Carian Ikut Nama/Emel/...">
			<button type="submit" formaction="committee-list.jsp">CARI</button>
			
			<input type="hidden" name="query" value="">
			<button type="submit" formaction="committee-list.jsp">KEMBALI</button>
		</form>
		<br>
		--%>
		<%-- Committee List --%>
		<button name="add" id="tambah" onclick="location.href='registration-committee-choices.jsp'">TAMBAH AJK BARU</button>
		<br><br>
		
		<table>
			<tr>
				<th>No.</th>
				<th>Nama</th>
				<th>Emel</th>
				<th>No. Telefon</th>
				<th>Bahagian</th>
				<th>Skop Kerja</th>
				<th>Tindakan</th>
			</tr>
			<c:forEach var="management" items="${resultManagement.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${management.committeefullname}" /></td>
				<td><c:out value="${management.committeeemail}" /></td>
				<td><c:out value="${management.committeephonenum}" /></td>
				<td>Pengurusan</td>
				<td><c:out value="${management.jobscope}" /></td>
				<td>
					<form method="post">
						<input type="hidden" name="previewCommitteeType" value="Management">
						<input type="hidden" name="previewCommitteeID" value="${management.committeeid}">
						<button name="view" id="tambah" formaction="view-committee-account-manager.jsp">LIHAT</button>
						<c:if test="${management.jobscope != 'Pengerusi'}">
							<button name="delete" id="kosongkan" onclick="deleted()" formaction="CommitteeHandler?action=deleteCommittee">PADAM</button>
						</c:if>
					</form>
				</td>
			</tr>
			</c:forEach>
			<c:forEach var="voluntary" items="${resultVoluntary.rows}">
			<tr>
				<td><% counter++; %><%= counter %></td>
				<td><c:out value="${voluntary.committeefullname}" /></td>
				<td><c:out value="${voluntary.committeeemail}" /></td>
				<td><c:out value="${voluntary.committeephonenum}" /></td>
				<td>Sukarelawan</td>
				<td><c:out value="${voluntary.jobscope}" /></td>
				<td>
					<form method="post">
						<input type="hidden" name="previewCommitteeID" value="${voluntary.committeeid}">
						<input type="hidden" name="previewCommitteeType" value="Voluntary">
						<button name="view" id="tambah" formaction="view-committee-account-manager.jsp">LIHAT</button>
						<button name="delete" id="kosongkan" onclick="deleted()" formaction="CommitteeHandler?action=deleteCommittee">PADAM</button>
					</form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<%-- # END: COMMITTEE LIST CONTENT # --%>
	<script>
	
	function deleted(){
		alert("Successfully delete the Account");
	}
	
	
	</script>
	</body>
</html>