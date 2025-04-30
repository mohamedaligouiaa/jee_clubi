<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" type="text/css" href="src/plugins/jquery-steps/jquery.steps.css">
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

<body class="login-page">
	<div class="login-header box-shadow">
		<div class="container-fluid d-flex justify-content-between align-items-center">
			<div class="brand-logo">
				<a href="login.html">
					<img src="vendors/images/logoclubi.svg" alt="Logo clubi">
				</a>
			</div>
			<div class="login-menu">
				<ul>
					<li><a href="login.html">Login</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="register-page-wrap d-flex align-items-center flex-wrap justify-content-center">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-7">
					<img src="vendors/images/register-page-img.png" alt="">
				</div>
				<div class="col-md-6 col-lg-5">
					<div class="register-box bg-white box-shadow border-radius-10">
						<div class="wizard-content">
							<form class="tab-wizard2 wizard-circle wizard" action="UserServlet" method ="post" enctype="multipart/form-data">
								<h5>Basic Account Credentials</h5>
								<section>
									<input type="hidden" name="action" value="ajouter"/>
									<div class="form-wrap max-width-600 mx-auto">
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Email Address*</label>
											<div class="col-sm-8">
												<input type="email" name="email" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Username*</label>
											<div class="col-sm-8">
												<input type="text" name="username" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Password*</label>
											<div class="col-sm-8">
												<input type="password" name="password" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Confirm Password*</label>
											<div class="col-sm-8">
												<input type="password" name="confirmpassword" class="form-control">
											</div>
										</div>
									</div>
								</section>
								<!-- Step 2 -->
								<h5>Personal Information</h5>
								<section>
									<div class="form-wrap max-width-600 mx-auto">
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Full Name*</label>
											<div class="col-sm-8">
												<input type="text" name="full_name" class="form-control">
											</div>
										</div>
										<div class="form-group row">
										    <label for="image" class="col-sm-4 col-form-label">Télécharger une image</label>
										    <div class="col-sm-8">
										        <input type="file" class="form-control" id="image" name="image" accept="image/*" required onchange="previewImage(event)">
										    </div>
										</div>
										<!-- Zone de prévisualisation -->
										<div class="form-group row mt-2">
										    <div class="col-sm-8">
										        <img id="imagePreview" src="#" alt="Aperçu de l'image" style="display: none; max-width: 100%; height: auto; border-radius: 8px;">
										    </div>
										</div>
										
										<script>
										    function previewImage(event) {
										        var reader = new FileReader();
										        reader.onload = function(){
										            var output = document.getElementById('imagePreview');
										            output.src = reader.result;
										            output.style.display = 'block';
										        };
										        reader.readAsDataURL(event.target.files[0]);
										    }
										</script>

										<div class="form-group row align-items-center">
											<label class="col-sm-4 col-form-label">Gender*</label>
											<div class="col-sm-8">
												<div class="custom-control custom-radio custom-control-inline pb-0">
													<input type="radio" id="male" value="male" name="gender" class="custom-control-input">
													<label class="custom-control-label" for="male">Male</label>
												</div>
												<div class="custom-control custom-radio custom-control-inline pb-0">
													<input type="radio" id="female" value="female" name="gender" class="custom-control-input">
													<label class="custom-control-label" for="female">Female</label>
												</div>
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">City</label>
											<div class="col-sm-8">
												<input type="text" name="city" class="form-control">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-sm-4 col-form-label">Role</label>
											<div class="col-sm-8">
												<input type="text" name="role" class="form-control">
											</div>
										</div>
									</div>
								</section>
								<h5>Overview Information</h5>
								<section>
								    <div class="form-wrap max-width-600 mx-auto">
								        <ul class="register-info">
								            <li>
								                <div class="row">
								                    <div class="col-sm-4 weight-600">Email Address</div>
								                    <div class="col-sm-8" id="overview-email">...</div>
								                </div>
								            </li>
								            <li>
								                <div class="row">
								                    <div class="col-sm-4 weight-600">Username</div>
								                    <div class="col-sm-8" id="overview-username">...</div>
								                </div>
								            </li>
								            <li>
								                <div class="row">
								                    <div class="col-sm-4 weight-600">Password</div>
								                    <div class="col-sm-8" id="overview-password">******* </div>
								                </div>
								            </li>
								            <li>
								                <div class="row">
								                    <div class="col-sm-4 weight-600">Full Name</div>
								                    <div class="col-sm-8" id="overview-fullname">...</div>
								                </div>
								            </li>
								            <li>
								                <div class="row">
								                    <div class="col-sm-4 weight-600">Location</div>
								                    <div class="col-sm-8" id="overview-location">...</div>
								                </div>
								            </li>
								        </ul>
								        <div class="custom-control custom-checkbox mt-4">
								            <input type="checkbox" class="custom-control-input" id="customCheck1">
								            <label class="custom-control-label" for="customCheck1">I have read and agreed to the terms of services and privacy policy</label>
								        </div>
								    </div>
								</section>

							</form>
						</div>
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

	    // Mettre à jour l'Overview Information à l'étape 3
	    if (currentIndex === 2) { 
	        $("#overview-email").text($("input[name='email']").val());
	        $("#overview-username").text($("input[name='username']").val());
	        $("#overview-password").text("*******"); 
	        $("#overview-fullname").text($("input[name='full_name']").val());
	        $("#overview-location").text($("input[name='city']").val());
	    }
	},
	    onFinished: function(event, currentIndex) {
	        let isValid = true;

	        $(".tab-wizard2 input").each(function () {
	            if ($(this).val().trim() === "") {
	                isValid = false;
	                $(this).css("border", "1px solid red");
	            } else {
	                $(this).css("border", "");
	            }
	        });

	        let password = $("input[name='password']").val();
	        let confirmPassword = $("input[name='confirmpassword']").val();

	        if (password !== confirmPassword) {
	            alert("Les mots de passe ne correspondent pas !");
	            isValid = false;
	        }

	        if (!$("#customCheck1").is(":checked")) {
	            alert("Vous devez accepter les conditions d'utilisation !");
	            isValid = false;
	        }

	        if (isValid) {
	            $(".tab-wizard2").submit();
	        } else {
	            alert("Veuillez remplir tous les champs !");
	        }
	    }
	});
	</script>
</body>

</html>