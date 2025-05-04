<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="club.DatabaseConnection" %> 
    
<%@ page import="java.sql.*" %>
<!DOCTYPE html>

<html>
<head>
<style>
.btn-submit {
    padding: 10px 25px;
    background: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer; 
}

.actions a {
    padding: 8px 15px;
    margin: 0 5px;
    text-decoration: none;
}

.actions a[href$="#previous"] {
    background: #f1f1f1;
}

.actions a[href$="#next"],
.actions a[href$="#finish"] {
    background: #2196F3;
    color: white;
}


/* Ajoutez ceci pour mieux voir les erreurs */
.error {
    border: 1px solid red !important;
}

.error-message {
    color: red;
    font-size: 12px;
    display: none;
    margin-top: 5px;
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

				<h4 class="weight-600 font-18 pb-10">Menu Dropdown Icon</h4>
				<div class="sidebar-radio-group pb-10 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-1" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-1" checked="">
						<label class="custom-control-label" for="sidebaricon-1"><i class="fa fa-angle-down"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-2" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-2">
						<label class="custom-control-label" for="sidebaricon-2"><i class="ion-plus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebaricon-3" name="menu-dropdown-icon" class="custom-control-input" value="icon-style-3">
						<label class="custom-control-label" for="sidebaricon-3"><i class="fa fa-angle-double-right"></i></label>
					</div>
				</div>

				<h4 class="weight-600 font-18 pb-10">Menu List Icon</h4>
				<div class="sidebar-radio-group pb-30 mb-10">
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-1" name="menu-list-icon" class="custom-control-input" value="icon-list-style-1" checked="">
						<label class="custom-control-label" for="sidebariconlist-1"><i class="ion-minus-round"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-2" name="menu-list-icon" class="custom-control-input" value="icon-list-style-2">
						<label class="custom-control-label" for="sidebariconlist-2"><i class="fa fa-circle-o" aria-hidden="true"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-3" name="menu-list-icon" class="custom-control-input" value="icon-list-style-3">
						<label class="custom-control-label" for="sidebariconlist-3"><i class="dw dw-check"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-4" name="menu-list-icon" class="custom-control-input" value="icon-list-style-4" checked="">
						<label class="custom-control-label" for="sidebariconlist-4"><i class="icon-copy dw dw-next-2"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-5" name="menu-list-icon" class="custom-control-input" value="icon-list-style-5">
						<label class="custom-control-label" for="sidebariconlist-5"><i class="dw dw-fast-forward-1"></i></label>
					</div>
					<div class="custom-control custom-radio custom-control-inline">
						<input type="radio" id="sidebariconlist-6" name="menu-list-icon" class="custom-control-input" value="icon-list-style-6">
						<label class="custom-control-label" for="sidebariconlist-6"><i class="dw dw-next"></i></label>
					</div>
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
						<a href="dashboardadmin.jsp" class="dropdown-toggle no-arrow">
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

	<div class="main-container">
		<div class="pd-ltr-20 xs-pd-20-10">
			<div class="min-height-200px">
				<div class="page-header">
					<div class="row">
						<div class="col-md-6 col-sm-12">
							<div class="title">
								<h4>Form Wizards</h4>
							</div>
							<nav aria-label="breadcrumb" role="navigation">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="index.html">Home</a></li>
									<li class="breadcrumb-item active" aria-current="page">Form Wizards</li>
								</ol>
							</nav>
						</div>
					
					</div>
				</div>

				<div class="pd-20 card-box mb-30">
					<div class="clearfix">
						<div class="row align-items-center justify-content-center">
    <div class="col-auto text-center">
        <h4 class="text-blue h4" >Event Details Form</h4>
    </div>
    <div class="col-auto text-center">
        <img src="vendors/images/red-carpet.png" alt="Event Image" class="img-fluid" style="max-height: 70px;">
    </div>
</div>

					</div>
					<div class="wizard-content">
						<form class="tab-wizard2 wizard-circle wizard" action="${pageContext.request.contextPath}/EvenementServlet" method="post">
								<h5>Event description</h5>
								<section>
									<input type="hidden" name="action" value="ajouter"/>
									<div class="form-wrap max-width-600 mx-auto">
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Event title :</label>
											<div class="col-sm-8">
												<input type="text" name="titre" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Event Description :</label>
											<div class="col-sm-8">
												<textarea  name="description" class="form-control"></textarea>
											</div>
										</div>
										
										<div class="form-group row">
    <label class="col-sm-4 col-form-label">Event Type :</label>
    <div class="col-sm-8">
        <select name="categorie" class="form-control">
            
            <option value="Sport">Sport</option>
            <option value="Culture">Culture</option>
            <option value="Music">Music</option>
            <option value="Art">Art</option>
            <option value="Technology">Technology</option>
            <option value="Education">Education</option>
            <option value="Business">Business</option>
            <option value="Charity">Charity</option>
            <option value="Food">Food</option>
            <option value="Other">Other</option>
        </select>
    </div>
</div>
									</div>
									
								</section>
								<!-- Step 2 -->
								<h5>Event Planning</h5>
								
								<section>
									<input type="hidden" name="action" value="ajouter"/>
									<div class="form-wrap max-width-600 mx-auto">
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Event date :</label>
											<div class="col-sm-8">
												<input type="date" name="date_event" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Event time :</label>
											<div class="col-sm-8">
												<input type="time"  name="heure" class="form-control">
											</div>
										</div>
										
											
										<input type="hidden" name="club_id" value="<%=  Integer.parseInt(request.getParameter("idclub")) %>" class="form-control">

										
										
									</div>
								</section>
								
								<h5>Event Arrangements</h5>
								<section>
									<input type="hidden" name="action" value="ajouter"/>
									<div class="form-wrap max-width-600 mx-auto">
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Capacity :</label>
											<div class="col-sm-8">
												<input type="number" name="capacite" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Place :</label>
											<div class="col-sm-8">
												<input  type="text" name="lieu" class="form-control">
											</div>
										</div>
										
									</div>
								</section>
								
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<!-- success Popup html Start -->
	
	<!-- success Popup html End -->
	<!-- js -->
	
	<script src="vendors/scripts/core.js"></script>
	<script src="vendors/scripts/script.min.js"></script>
	<script src="vendors/scripts/process.js"></script>
	<script src="vendors/scripts/layout-settings.js"></script>
	<script src="src/plugins/jquery-steps/jquery.steps.js"></script>
	

	<script type="text/javascript">
$(".tab-wizard").steps({
    headerTag: "h5",
    bodyTag: "section",
    transitionEffect: "fade",
    titleTemplate: '<span class="step">#index#</span> #title#',
    labels: {
        finish: "Submit"
    },
    onStepChanged: function (event, currentIndex, priorIndex) {
        $('.steps .current').prevAll().addClass('disabled');
    },
    onFinished: function (event, currentIndex) {
        $('#success-modal').modal('show');
    }
});

$(".tab-wizard2").steps({
    headerTag: "h5",
    bodyTag: "section",
    transitionEffect: "fade",
    titleTemplate: '<span class="step">#index#</span> <span class="info">#title#</span>',
    labels: {
        finish: "Submit",
        next: "Next",
        previous: "Previous",
    },
    onStepChanged: function(event, currentIndex, priorIndex) {
        $('.steps .current').prevAll().addClass('disabled');
        
        // Mettre à jour l'aperçu des informations à l'étape finale si nécessaire
        if (currentIndex === 2) { // 3ème étape (index 2)
            // Vous pouvez ajouter ici la logique pour afficher un aperçu des données si nécessaire
        }
    },
    onFinished: function(event, currentIndex) {
        let isValid = true;
        
        // Validation des champs obligatoires
        $(".tab-wizard2 input[required], .tab-wizard2 textarea[required]").each(function () {
            if ($(this).val().trim() === "") {
                isValid = false;
                $(this).addClass("error");
                $(this).next(".error-message").text("Ce champ est obligatoire").show();
            } else {
                $(this).removeClass("error");
                $(this).next(".error-message").hide();
            }
        });

        // Validation spécifique pour les champs numériques
        let capacite = $("input[name='capacite']").val();
        if (capacite && isNaN(capacite)) {
            isValid = false;
            $("input[name='capacite']").addClass("error");
            $("input[name='capacite']").next(".error-message").text("La capacité doit être un nombre").show();
        }

       

        // Validation de la date
        let eventDate = $("input[name='date_event']").val();
        if (eventDate) {
            let selectedDate = new Date(eventDate);
            let today = new Date();
            today.setHours(0, 0, 0, 0);
            
            if (selectedDate < today) {
                isValid = false;
                $("input[name='date_event']").addClass("error");
                $("input[name='date_event']").next(".error-message").text("La date ne peut pas être dans le passé").show();
            }
        }

        if (isValid) {
            // Soumettre le formulaire si tout est valide
            $(".tab-wizard2").submit();
        } else {
            // Afficher un message d'erreur général
            alert("Veuillez corriger les erreurs dans le formulaire avant de soumettre.");
            
            // Optionnel: Revenir à la première étape avec des erreurs
            $(".tab-wizard2").steps("setStep", 0);
        }
    }
});
</script>
</body></html>