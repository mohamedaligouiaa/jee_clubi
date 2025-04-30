<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="club.DatabaseConnection" %> 
    
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <title>Club Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .club-card {
            transition: transform 0.3s;
        }
        .club-card:hover {
            transform: scale(1.03);
        }
        .club-img {
            height: 200px;
            object-fit: cover;
        }
    </style>

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
String sql = "SELECT * FROM users WHERE role = ?"; 
String username="";
String image="";
try (Connection c = DatabaseConnection.getConnection();
     PreparedStatement pst = c.prepareStatement(sql)) {
     pst.setString(1, "Admin");
     
     try (ResultSet rs = pst.executeQuery()) {
         if (rs.next()) {
             username = rs.getString("username");
             image = rs.getString("image");
         }
     }
} catch (SQLException e) {
    e.printStackTrace(); // Replace with a logger in production
}
%>


<div class="mobile-menu-overlay"></div>

	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			
				
				<!-- horizontal Basic Forms End -->
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
						<a href="homeadmin.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-house-1"></span><span class="mtext">Home</span>
						</a>
					</li>
					<li>
						<a href="clubs.jsp" class="dropdown-toggle no-arrow">
							<span class="micon fa fa-group"></span><span class="mtext">Clubs</span>
						</a>
					</li>
					
					<li>
						<a href="events.jsp" class="dropdown-toggle no-arrow">
							<span class="micon dw dw-television"></span><span class="mtext">Events</span>
						</a>
						
					</li>
					
					
					
				</ul>
			</div>
		</div>
	</div>
	<div class="mobile-menu-overlay"></div>


	 <div class="container mt-5">
        <h1 class="text-center mb-4">Club Management</h1>
        
        <%-- Display success/error messages --%>
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getParameter("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <%= request.getParameter("error") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        
        <!-- Button to add a new club -->
        <a href="ClubServlet?action=afficherAjout" class="btn btn-primary mb-4">
    Add Club
</a>
        
        <!-- Club list -->
        <div class="row">
            <%
            try (Connection c = DatabaseConnection.getConnection();
                 Statement stmt = c.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM club")) {
                
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String imageName = rs.getString("image");
                    String nom = rs.getString("nom");
                    String description = rs.getString("description");
                    
                    String imagePath = request.getContextPath() + "/vendors/images/" + imageName;
            %>
            <div class="col-md-4 mb-4">
                <div class="card club-card">
                    <% if (imageName != null && !imageName.isEmpty()) { %>
                        <img src="<%= imagePath %>" class="card-img-top club-img" alt="<%= nom %>">
                    <% } else { %>
                        <img src="https://via.placeholder.com/300x200" class="card-img-top club-img" alt="Default image">
                    <% } %>
                    <div class="card-body">
                        <h5 class="card-title"><%= nom %></h5>
                        <p class="card-text"><%= description %></p>
                        <div class="d-flex justify-content-between">
                            <button class="btn btn-warning btn-sm" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#editClubModal"
                                    data-id="<%= id %>"
                                    data-nom="<%= nom %>"
                                    data-description="<%= description %>">
                                Edit
                            </button>
                            <a href="ClubServlet?action=supprimer&id=<%= id %>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to delete this club?')">
                                Delete
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            %>
            <div class="alert alert-danger">Error loading clubs</div>
            <% } %>
        </div>
    </div>
    
    
    <!-- Edit Club Modal -->
    <div class="modal fade" id="editClubModal" tabindex="-1" aria-labelledby="editClubModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="ClubServlet" method="post">
                    <input type="hidden" name="action" value="modifier">
                    <input type="hidden" id="editId" name="id">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editClubModalLabel">Edit Club</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="editNom" class="form-label">Club Name</label>
                            <input type="text" class="form-control" id="editNom" name="nom" required>
                        </div>
                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Description</label>
                            <textarea class="form-control" id="editDescription" name="description" rows="3" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
				

			</div>
			<div class="footer-wrap pd-20 mb-20 card-box">
				Clubi -© All rights reserved
			</div>
		</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Script pour remplir le modal de modification avec les données du club
        document.getElementById('editClubModal').addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var nom = button.getAttribute('data-nom');
            var description = button.getAttribute('data-description');
            
            var modal = this;
            modal.querySelector('#editId').value = id;
            modal.querySelector('#editNom').value = nom;
            modal.querySelector('#editDescription').value = description;
        });
    </script>
	
	<!-- js -->
	<script src="vendors/scripts/core.js"></script>
	<script src="vendors/scripts/script.min.js"></script>
	<script src="vendors/scripts/process.js"></script>
	<script src="vendors/scripts/layout-settings.js"></script>
</body>
</html>