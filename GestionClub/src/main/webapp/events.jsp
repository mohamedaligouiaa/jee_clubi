<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, club.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Events</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4bb543;
            --danger-color: #ff3333;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        
        .events-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .event-card {
            background-color: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }
        
        .event-header {
            background: linear-gradient(135deg, var(--accent-color), var(--primary-color));
            color: white;
            padding: 15px;
            position: relative;
        }
        
        .event-title {
            font-size: 1.4rem;
            margin-bottom: 5px;
        }
        
        .event-category {
            display: inline-block;
            background-color: rgba(255, 255, 255, 0.2);
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-bottom: 10px;
        }
        
        .event-body {
            padding: 20px;
        }
        
        .event-details {
            margin-bottom: 15px;
        }
        
        .event-details p {
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }
        
        .event-details i {
            margin-right: 10px;
            color: var(--accent-color);
            width: 20px;
            text-align: center;
        }
        
        .event-description {
            margin-bottom: 20px;
            color: #555;
        }
        
        .event-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px 20px;
        }
        
        .event-capacity {
            font-size: 0.9rem;
            color: #666;
        }
        
        .btn {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }
        
        .btn-danger {
            background-color: var(--danger-color);
            color: white;
        }
        
        .btn-danger:hover {
            background-color: #cc0000;
        }
        
        .btn-success {
            background-color: var(--success-color);
            color: white;
        }
        
        .btn-success:hover {
            background-color: #3a9e36;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        .search-filter {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .search-box, .filter-box {
            display: flex;
            align-items: center;
            background-color: white;
            padding: 10px 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .search-box input, .filter-box select {
            border: none;
            outline: none;
            padding: 8px;
            font-size: 1rem;
            width: 100%;
        }
        
        .search-box i, .filter-box i {
            color: #666;
            margin-right: 10px;
        }
        
        .no-events {
            text-align: center;
            grid-column: 1 / -1;
            padding: 40px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        @media (max-width: 768px) {
            .events-container {
                grid-template-columns: 1fr;
            }
            
            .search-filter {
                flex-direction: column;
            }
        }
              .event-time {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        .time-icon {
            margin-right: 10px;
            color: var(--accent-color);
        }
         .club-filter-box {
            display: flex;
            align-items: center;
            background-color: white;
            padding: 10px 15px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .club-filter-box i {
            color: #666;
            margin-right: 10px;
        }
        
        .club-filter-box select {
            border: none;
            outline: none;
            padding: 8px;
            font-size: 1rem;
            width: 100%;
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
	<link rel="stylesheet" type="text/css" href="src/plugins/jquery-steps/jquery.steps.css">
	<link rel="stylesheet" type="text/css" href="vendors/styles/style.css">
    <link rel="stylesheet" type="text/css" href="vendors/styles/siwar.css">

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
	<div class="mobile-menu-overlay"></div>

	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				

    <div class="container">
        <header>
            <h1>Available Events</h1>
            <p>Discover all events organized by our clubs</p>
        </header>
        
        <div class="search-filter">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search for an event...">
            </div>
            <div class="filter-box">
                <i class="fas fa-filter"></i>
                <select id="categoryFilter">
                    <option value="">All categories</option>
                    <option value="Sport">Sport</option>
                    <option value="Culture">Culture</option>
                    <option value="Music">Music</option>
                    <option value="Art">Art</option>
                    <option value="Technology">Technology</option>
                    <option value="Education">Education</option>
                    <option value="Business">Business</option>
                    <option value="Charity">Charity</option>
                    <option value="Food">Food</option>
                </select>
            </div>
            <div class="club-filter-box">
                <i class="fas fa-users"></i>
                <select id="clubFilter">
                    <option value="">All clubs</option>
                    <%
                        Connection clubConn = null;
                        PreparedStatement clubStmt = null;
                        ResultSet clubRs = null;
                        
                        try {
                            clubConn = DatabaseConnection.getConnection();
                            String clubQuery = "SELECT DISTINCT id, nom FROM club.club ORDER BY nom ASC";
                            clubStmt = clubConn.prepareStatement(clubQuery);
                            clubRs = clubStmt.executeQuery();
                            
                            while (clubRs.next()) {
                    %>
                    <option value="<%= clubRs.getString("nom") %>"><%= clubRs.getString("nom") %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } 
                    %>
                </select>
            </div>
        </div>
        
        <div class="events-container">
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                
                try {
                    conn = DatabaseConnection.getConnection();
                    if(conn == null || conn.isClosed()) {
                        out.println("<div class='no-events'><h3>Database connection error</h3></div>");
                    } else {
                        String query = "SELECT e.id, e.titre, e.description, e.date_event, e.lieu, " +
                                      "e.categorie, e.capacite, e.club_id, e.heure, c.nom as club_nom " +
                                      "FROM club.evenement e " +
                                      "LEFT JOIN club.club c ON e.club_id = c.id " +
                                      "ORDER BY e.date_event ASC";
                        
                        stmt = conn.prepareStatement(query);
                        rs = stmt.executeQuery();
                        
                        boolean hasEvents = false;
                        
                        while (rs.next()) {
                            hasEvents = true;
                            String heureEvent = rs.getString("heure");
                            if(heureEvent != null && heureEvent.length() > 5) {
                                heureEvent = heureEvent.substring(0, 5);
                            }
            %>
            <div class="event-card" data-category="<%= rs.getString("categorie") %>" data-club="<%= rs.getString("club_nom") != null ? rs.getString("club_nom") : "Unknown" %>">
                <div class="event-header">
                    <h3 class="event-title"><%= rs.getString("titre") %></h3>
                    <span class="event-category"><%= rs.getString("categorie") %></span>
                </div>
                <div class="event-body">
                    <div class="event-details">
                        <p><i class="fas fa-calendar-alt"></i> <%= rs.getString("date_event") %></p>
                        <% if(heureEvent != null && !heureEvent.isEmpty()) { %>
                            <p><i class="fas fa-clock"></i> <%= heureEvent %></p>
                        <% } %>
                        <p><i class="fas fa-map-marker-alt"></i> <%= rs.getString("lieu") %></p>
                        <p><i class="fas fa-users"></i> Club: <%= rs.getString("club_nom") != null ? rs.getString("club_nom") : "Unknown" %></p>
                    </div>
                    <div class="event-description">
                        <p><%= rs.getString("description") %></p>
                    </div>
                </div>
                <div class="event-footer">
    <span class="event-capacity"><i class="fas fa-user-check"></i> <%= rs.getInt("capacite") %> Available places</span>
    <div class="actions">
        <a href="ticket.jsp?eventId=<%= rs.getString("id") %>" class="btn btn-primary">Register Now!</a>
    </div>
</div>
            </div>
            <%
                        }
                        
                        if (!hasEvents) {
            %>
            <div class="no-events">
                <h3>No available events</h3>
                <p>There are no events at this time</p>
               
            </div>
            <%
                        }
                    }
                } catch (SQLException e) {
                    out.println("<div class='no-events'><h3>Technical error</h3><p>" + e.getMessage() + "</p></div>");
                    e.printStackTrace();
                }
            %>
        </div>
    </div>
    
    
    
    
    <script src="vendors/scripts/core.js"></script>
	<script src="vendors/scripts/script.min.js"></script>
	<script src="vendors/scripts/process.js"></script>
	<script src="vendors/scripts/layout-settings.js"></script>
	<script src="src/plugins/jquery-steps/jquery.steps.js"></script>
    
    
    
    <script>
        // Search function
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const events = document.querySelectorAll('.event-card');
            
            events.forEach(event => {
                const title = event.querySelector('.event-title').textContent.toLowerCase();
                const description = event.querySelector('.event-description').textContent.toLowerCase();
                const club = event.getAttribute('data-club').toLowerCase();
                
                if (title.includes(searchTerm) || description.includes(searchTerm) || club.includes(searchTerm)) {
                    event.style.display = 'block';
                } else {
                    event.style.display = 'none';
                }
            });
        });
        
        // Category filter
        document.getElementById('categoryFilter').addEventListener('change', function() {
            applyFilters();
        });
        
        // Club filter
        document.getElementById('clubFilter').addEventListener('change', function() {
            applyFilters();
        });
        
        // Combined filter function
        function applyFilters() {
            const selectedCategory = document.getElementById('categoryFilter').value;
            const selectedClub = document.getElementById('clubFilter').value;
            const events = document.querySelectorAll('.event-card');
            
            events.forEach(event => {
                const eventCategory = event.getAttribute('data-category');
                const eventClub = event.getAttribute('data-club');
                
                const categoryMatch = selectedCategory === '' || eventCategory === selectedCategory;
                const clubMatch = selectedClub === '' || eventClub === selectedClub;
                
                if (categoryMatch && clubMatch) {
                    event.style.display = 'block';
                } else {
                    event.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>