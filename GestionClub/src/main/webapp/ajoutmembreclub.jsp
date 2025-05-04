<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="club.DatabaseConnection" %> 
    <%@ page import="club.Club" %> 
<%@ page import="java.sql.*" %>
<%@ page import ="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
	<!-- Basic Page Info -->
	<meta charset="utf-8">
	<title>DeskApp - Bootstrap Admin Dashboard HTML Template</title>

	<!-- Site favicon -->
	<link rel="apple-touch-icon" sizes="180x180" href="vendors/images/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="vendors/images/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="vendors/images/favicon-16x16.png">

	<!-- Mobile Specific Metas -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

	<!-- Google Font -->
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
	<!-- CSS -->
	<link rel="stylesheet" type="text/css" href="vendors/styles/core.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/icon-font.min.css">
	<link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" type="text/css" href="src/plugins/datatables/css/responsive.bootstrap4.min.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/style.css">

	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());

		gtag('config', 'UA-119386393-1');
	</script>
	<style>
		.club-cards {
			display: grid;
			grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
			gap: 20px;
			padding: 20px;
		}
		.club-card {
			border-radius: 10px;
			overflow: hidden;
			box-shadow: 0 4px 8px rgba(0,0,0,0.1);
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			background: white;
		}
		.club-card:hover {
			transform: translateY(-5px);
			box-shadow: 0 8px 16px rgba(0,0,0,0.2);
		}
		.club-image {
			width: 100%;
			height: 180px;
			object-fit: cover;
		}
		.club-content {
			padding: 20px;
		}
		.club-title {
			font-size: 1.2rem;
			margin-bottom: 10px;
			color: #333;
		}
		.club-description {
			color: #666;
			margin-bottom: 15px;
			font-size: 0.9rem;
			line-height: 1.5;
		}
		.club-actions {
			display: flex;
			justify-content: flex-end;
		}
		.search-bar {
			margin-bottom: 20px;
			padding: 0 20px;
		}
	</style>
</head>
<body>
	<% 
String email = request.getParameter("email");
String sql = "SELECT * FROM users WHERE email = ?"; 
String username="";
String image="";
int iduser = -1;
try (Connection c = DatabaseConnection.getConnection();
     PreparedStatement pst = c.prepareStatement(sql)) {
     pst.setString(1, email);
     
     try (ResultSet rs = pst.executeQuery()) {
         if (rs.next()) {
             username = rs.getString("username");
             image = rs.getString("image");
             iduser = rs.getInt("id");
         }
     }
} catch (SQLException e) {
    e.printStackTrace(); // À remplacer par un logger en production
}
%>


	

	<div class="header">
		<div class="header-left">
			<div class="menu-icon dw dw-menu"></div>
			<div class="search-toggle-icon dw dw-search2" data-toggle="header_search"></div>
			<div class="header-search">
				<form>
					<div class="form-group mb-0">
						<i class="dw dw-search2 search-icon"></i>
						<input type="text" class="form-control search-input" placeholder="Search Here">
						<div class="dropdown">
							<a class="dropdown-toggle no-arrow" href="#" role="button" data-toggle="dropdown">
								<i class="ion-arrow-down-c"></i>
							</a>
							<div class="dropdown-menu dropdown-menu-right">
								<div class="form-group row">
									<label class="col-sm-12 col-md-2 col-form-label">From</label>
									<div class="col-sm-12 col-md-10">
										<input class="form-control form-control-sm form-control-line" type="text">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-12 col-md-2 col-form-label">To</label>
									<div class="col-sm-12 col-md-10">
										<input class="form-control form-control-sm form-control-line" type="text">
									</div>
								</div>
								<div class="form-group row">
									<label class="col-sm-12 col-md-2 col-form-label">Subject</label>
									<div class="col-sm-12 col-md-10">
										<input class="form-control form-control-sm form-control-line" type="text">
									</div>
								</div>
								<div class="text-right">
									<button class="btn btn-primary">Search</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="header-right">
			<div class="dashboard-setting user-notification">
				<div class="dropdown">
					<a class="dropdown-toggle no-arrow" href="javascript:;" data-toggle="right-sidebar">
						<i class="dw dw-settings2"></i>
					</a>
				</div>
			</div>
			
			<div class="user-info-dropdown">
				<div class="dropdown">
					<a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
						<span class="user-icon">
							<img src="vendors/images/<%=image %>" alt="">
						</span>
						<span class="user-name"><%= username %></span>
					</a>
					<div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
						<a class="dropdown-item" href="profile.html"><i class="dw dw-user1"></i> Profile</a>
						<a class="dropdown-item" href="profile.html"><i class="dw dw-settings2"></i> Setting</a>
						<a class="dropdown-item" href="faq.html"><i class="dw dw-help"></i> Help</a>
						<a class="dropdown-item" href="login.html"><i class="dw dw-logout"></i> Log Out</a>
					</div>
				</div>
			</div>
			
		</div>
	</div>

	<div class="right-sidebar">
		<div class="sidebar-title">
			<h3 class="weight-600 font-16 text-blue">
				Layout Settings
				<span class="btn-block font-weight-400 font-12">User Interface Settings</span>
			</h3>
			<div class="close-sidebar" data-toggle="right-sidebar-close">
				<i class="icon-copy ion-close-round"></i>
			</div>
		</div>
		<div class="right-sidebar-body customscroll">
			<div class="right-sidebar-body-content">
				<h4 class="weight-600 font-18 pb-10">Header Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary header-white active">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary header-dark">Dark</a>
				</div>

				<h4 class="weight-600 font-18 pb-10">Sidebar Background</h4>
				<div class="sidebar-btn-group pb-30 mb-10">
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-light ">White</a>
					<a href="javascript:void(0);" class="btn btn-outline-primary sidebar-dark active">Dark</a>
				</div>

				<div class="reset-options pt-30 text-center">
					<button class="btn btn-danger" id="reset-settings">Reset Settings</button>
				</div>
			</div>
		</div>
	</div>

	<div class="left-side-bar">
		<div class="brand-logo">
			<a href="index.html">
				<img src="vendors/images/logoclubi.svg" alt="" class="dark-logo">
				<img src="vendors/images/logoclubi.svg" alt="" class="light-logo">
			</a>
			<div class="close-sidebar" data-toggle="left-sidebar-close">
				<i class="ion-close-round"></i>
			</div>
			<ul>
			<li>
						<div class="dropdown-divider"></div>
					</li>
					
			</ul>
		</div>
		
		
		<div class="menu-block customscroll">
			<div class="sidebar-menu">
				<ul id="accordion-menu">
					
					<li>
						<a href="dashboardStudent.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">Home</span>
						</a>
					</li>
					<li>
						<a href="ajoutmembreclub.jsp" class="dropdown-toggle no-arrow">
							<span class="micon fa fa-group"></span><span class="mtext">Clubs</span>
						</a>
					</li>
					
					<li>
						<a href="events.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-television"></span><span class="mtext">Events</span>
						</a>
						
					</li>
					<li>
						<a href="chatbot.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-chat3"></span><span class="mtext">Chatbot</span>
						</a>
					</li>
					
					
				</ul>
			</div>
		</div>
	</div>

	<div class="main-container">
		<div class="pd-ltr-20">
			<div class="card-box mb-30">
				<h2 class="h4 pd-20">Clubs</h2>
				
				<div class="club-cards">
					<% ArrayList<Club> clubs = Club.afficherClubs();
					for ( Club club : clubs ){%>
					<div class="club-card">
						<img src="vendors/images/<%=club.getImage() %>" alt="<%=club.getNom() %>" class="club-image">
						<div class="club-content">
							<h3 class="club-title"><%=club.getNom() %></h3>
							<p class="club-description"><%=club.getDescription() %></p>
							<div class="club-actions">
								<a href="ClubmemberServlet?action=ajouter&club_id=<%= club.getId() %>&user_id=<%= iduser %>" role="button" class="btn btn-primary">

									Register
								</a>
							</div>
						</div>
					</div>
					<% } %>
				</div>
			</div>
			<div class="footer-wrap pd-20 mb-20 card-box">
				Clubi -© All rights reserved
			</div>
		</div>
	</div>
	<!-- js -->
	<script src="vendors/scripts/core.js"></script>
	<script src="vendors/scripts/script.min.js"></script>
	<script src="vendors/scripts/process.js"></script>
	<script src="vendors/scripts/layout-settings.js"></script>
	<script src="src/plugins/apexcharts/apexcharts.min.js"></script>
	<script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
	<script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
	<script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
	<script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
	<script src="vendors/scripts/dashboard.js"></script>
</body>
</html>