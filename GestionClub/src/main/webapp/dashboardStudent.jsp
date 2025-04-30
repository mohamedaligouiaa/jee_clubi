<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="club.DatabaseConnection" %> 
<%@ page import="java.sql.*" %>
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
	<link rel="stylesheet" type="text/css" href="vendors/styles/style.css">


	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-119386393-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());

		gtag('config', 'UA-119386393-1');
	</script>
</head>
<body>
<% 
String sql = "SELECT * FROM users WHERE email = ?"; 
String username="";
String image="";
try (Connection c = DatabaseConnection.getConnection();
     PreparedStatement pst = c.prepareStatement(sql)) {
     pst.setString(1, request.getParameter("email"));
     
     try (ResultSet rs = pst.executeQuery()) {
         if (rs.next()) {
             username = rs.getString("username");
             image = rs.getString("image");
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
	<div class="mobile-menu-overlay"></div>

	<div class="main-container">
		<div class="pd-ltr-20">
			<div class="card-box pd-20 height-100-p mb-30">
				<div class="row align-items-center">
					<div class="col-md-4">
						<img src="vendors/images/students_image.png" alt="">
					</div>
					<div class="col-md-8">
						<h4 class="font-20 weight-500 mb-10 text-capitalize">
							Welcome back <div class="weight-600 font-30 text-blue">Johnny Brown!</div>
						</h4>
						<p class="font-18 max-width-600">Happy to see you back on the platform. Check out your clubs, stay updated on upcoming events, and actively take part in student life!</p>
					</div>
				</div>
			</div>
		<div class="row">
    <!-- Bouton Clubs - Centré avec nouvelle couleur -->
    <div class="col-xl-6 col-lg-6 mb-30">
        <button onclick="location.href='clubs.jsp';" class="card-box height-100-p widget-style1 btn-clickable" 
                style="width: 100%; border: none; background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%); cursor: pointer; padding: 30px; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center;">
            <div class="progress-data mb-3">
                <img src="vendors/images/multiple-users-silhouette.png" alt="Clubs" style="width: 70px; height: 70px; filter: brightness(0) invert(1);">
            </div>
            <div class="widget-data">
                <div class="h3 mb-2" style="font-size: 26px; color: white; font-weight: 600;">Clubs</div>
                <div class="weight-600 font-14" style="font-size: 16px; color: rgba(255,255,255,0.8);">See your clubs</div>
            </div>
        </button>
    </div>
    
    <!-- Bouton Events - Centré avec nouvelle couleur -->
    <div class="col-xl-6 col-lg-6 mb-30">
        <button onclick="location.href='events.jsp';" class="card-box height-100-p widget-style1 btn-clickable" 
                style="width: 100%; border: none; background: linear-gradient(135deg, #56CCF2 0%, #2F80ED 100%); cursor: pointer; padding: 30px; display: flex; flex-direction: column; align-items: center; justify-content: center; text-align: center;">
            <div class="progress-data mb-3">
                <img src="vendors/images/event.png" alt="Events" style="width: 70px; height: 70px; filter: brightness(0) invert(1);">
            </div>
            <div class="widget-data">
                <div class="h3 mb-2" style="font-size: 26px; color: white; font-weight: 600;">Events</div>
                <div class="weight-600 font-14" style="font-size: 16px; color: rgba(255,255,255,0.8);">See your events</div>
            </div>
        </button>
    </div>
</div>

<style>
/* Styles améliorés pour les boutons */
.btn-clickable {
    transition: all 0.3s ease;
    border-radius: 12px !important;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    border: none !important;
}

.btn-clickable:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
    opacity: 0.9;
}

/* Effet de transition sur les images */
.progress-data img {
    transition: transform 0.3s ease;
}

.btn-clickable:hover .progress-data img {
    transform: scale(1.1);
}

/* Responsive design */
@media (max-width: 768px) {
    .btn-clickable {
        padding: 20px !important;
    }
    
    .progress-data img {
        width: 60px !important;
        height: 60px !important;
    }
    
    .h3 {
        font-size: 22px !important;
    }
}
</style>
			
			
		</div>
	</div>
	<script>
// Gestion des clics pour tous les boutons
document.querySelectorAll('.btn-clickable').forEach(button => {
    button.addEventListener('click', function() {
        const action = this.querySelector('.h4').textContent;
        
        switch(action) {
            case 'Clubs':
                window.location.href = '/clubs';
                break;
            case 'Events':
                window.location.href = '/events';
                break;
            case 'Members':
                window.location.href = '/members';
                break;
            case 'Settings':
                window.location.href = '/settings';
                break;
            default:
                console.log('Action non définie');
        }
    });
});
</script>
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