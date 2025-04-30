<!DOCTYPE html>
<html lang="fr">
<head>
	<meta charset="utf-8">
	<title>DeskApp - Connexion</title>

	<!-- Favicon -->
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

	<!-- JS -->
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
					<img src="vendors/images/logoclubi.svg" alt="Logo DeskApp">
				</a>
			</div>
			<div class="login-menu">
				<ul>
					<li><a href="register.html">S'inscrire</a></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="login-wrap d-flex align-items-center flex-wrap justify-content-center">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-7">
					<img src="vendors/images/login-page-img.png" alt="Image de connexion">
				</div>
				<div class="col-md-6 col-lg-5">
					<div class="login-box bg-white box-shadow border-radius-10">
						<div class="login-title">
							<h2 class="text-center text-primary">Connexion à Clubi</h2>
						</div>
						<form action="LoginServlet" method="post">
							<!-- Protection CSRF -->
							<input type="hidden" name="csrf_token" value="GENERATED_CSRF_TOKEN">

							<div class="select-role">
								<div class="btn-group btn-group-toggle" data-toggle="buttons">
									<label class="btn active">
										<input type="radio" name="role" id="admin" value="admin" checked>
										<div class="icon"><img src="vendors/images/briefcase.svg" class="svg" alt="Manager"></div>
										<span>Je suis</span> Admin
									</label>
									<label class="btn">
										<input type="radio" name="role" id="user" value="membre">
										<div class="icon"><img src="vendors/images/person.svg" class="svg" alt="Employee"></div>
										<span>Je suis</span> Membre
									</label>
								</div>
							</div>

							<div class="input-group custom">
								<input type="text" class="form-control form-control-lg" placeholder="Email" name="email" required>
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="icon-copy dw dw-user1"></i></span>
								</div>
							</div>

							<div class="input-group custom">
								<input type="password" class="form-control form-control-lg" placeholder="Mot de passe" name="password" required autocomplete="off">
								<div class="input-group-append custom">
									<span class="input-group-text"><i class="dw dw-padlock1"></i></span>
								</div>
							</div>

							<div class="row pb-30">
								<div class="col-6">
									<div class="custom-control custom-checkbox">
										<input type="checkbox" class="custom-control-input" id="customCheck1">
										<label class="custom-control-label" for="customCheck1">Se souvenir de moi</label>
									</div>
								</div>
								<div class="col-6 text-right">
									<a href="forgot-password.html">Mot de passe oublié ?</a>
								</div>
							</div>

							<div class="row">
								<div class="col-sm-12">
									<div class="input-group mb-0">
										<input class="btn btn-primary btn-lg btn-block" type="submit" value="Se connecter" id="submitBtn" disabled>
									</div>
									<div class="font-16 weight-600 pt-10 pb-10 text-center" data-color="#707373">OU</div>
									<div class="input-group mb-0">
										<a class="btn btn-outline-primary btn-lg btn-block" href="register.jsp">Créer un compte</a>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- JS -->
	<script src="vendors/scripts/core.js"></script>
	<script src="vendors/scripts/script.min.js"></script>
	<script src="vendors/scripts/process.js"></script>
	<script src="vendors/scripts/layout-settings.js"></script>

	<script>
		// Désactiver le bouton "Se connecter" tant que les champs ne sont pas remplis
		document.addEventListener("DOMContentLoaded", function() {
			const username = document.querySelector('input[name="email"]');
			const password = document.querySelector('input[name="password"]');
			const submitBtn = document.getElementById("submitBtn");

			function checkInputs() {
				submitBtn.disabled = !(username.value.trim() && password.value.trim());
			}

			username.addEventListener("input", checkInputs);
			password.addEventListener("input", checkInputs);
		});
	</script>
</body>
</html>
