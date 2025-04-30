<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="club.DatabaseConnection" %> 
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
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
	<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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
    e.printStackTrace(); // À remplacer par un logger en production
}
String sql1 = "SELECT COUNT(*) FROM users;";
int nbusers = 0;

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement(); 
     ResultSet rs = stm.executeQuery(sql1)) { 

    if (rs.next()) {
        nbusers = rs.getInt(1); 
    }

} catch (SQLException e) {
    e.printStackTrace();
}
String sql2 = "SELECT COUNT(*) FROM evenement ;";
int nbevents = 0;

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement(); 
     ResultSet rs = stm.executeQuery(sql2)) { 

    if (rs.next()) {
        nbevents = rs.getInt(1); 
    }

} catch (SQLException e) {
    e.printStackTrace();
}
String sql3 = "SELECT COUNT(*) FROM evenement ;";
int nbparticipant = 0;

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement(); 
     ResultSet rs = stm.executeQuery(sql3)) { 

    if (rs.next()) {
        nbparticipant = rs.getInt(1); 
    }

} catch (SQLException e) {
    e.printStackTrace();
}
String sql4 = "SELECT COUNT(*) FROM club_membre ;";
int nbmembers = 0;

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement(); 
     ResultSet rs = stm.executeQuery(sql4)) { 

    if (rs.next()) {
        nbmembers = rs.getInt(1); 
    }

} catch (SQLException e) {
    e.printStackTrace();
}
String sql5 = "SELECT COUNT(*) FROM club ;";
int nbclubs = 0;

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement(); 
     ResultSet rs = stm.executeQuery(sql5)) { 

    if (rs.next()) {
        nbclubs = rs.getInt(1); 
    }

} catch (SQLException e) {
    e.printStackTrace();
}
int[] nbevent = new int[12]; 

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement()) {

    for (int month = 1; month <= 12; month++) {
        String sql7 = "SELECT COUNT(*) FROM evenement " +
                     "WHERE date_event >= '2025-01-01' AND date_event < '2030-01-01' " +
                     "AND MONTH(date_event) = " + month;

        try (ResultSet rs = stm.executeQuery(sql7)) {
            if (rs.next()) {
                nbevent[month - 1] = rs.getInt(1);
            }
        }
    }

} catch (SQLException e) {
    e.printStackTrace();
}

// Exemple d'accès : 
int nbeventJan = nbevent[0];
int nbeventFev = nbevent[1];
int nbeventMar = nbevent[2];
int nbeventavr = nbevent[3];
int nbeventmai = nbevent[4];
int nbeventjun = nbevent[5];
int nbeventjul = nbevent[6];
int nbeventaout = nbevent[7];
int nbeventsep = nbevent[8];
int nbeventoct = nbevent[9];
int nbeventnov = nbevent[10];
int nbeventdec = nbevent[11];

int[] nbmember = new int[nbclubs]; 

try (Connection c = DatabaseConnection.getConnection();
     Statement stm = c.createStatement()) {

    for (int club = 1; club <= nbclubs; club++) {
        String sql8 = "SELECT COUNT(*) FROM club_membre where club_id= " +club;
                     

        try (ResultSet rs = stm.executeQuery(sql8)) {
            if (rs.next()) {
                nbmember[club - 1] = rs.getInt(1);
            }
        }
    }

} catch (SQLException e) {
    e.printStackTrace();
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
<div class="main-container">
		<div class="pd-ltr-20">
			<div class="card-box pd-20 height-100-p mb-30">
				<div class="row align-items-center">
					<div class="col-md-4">
						<img src="vendors/images/banner-img.png" alt="">
					</div>
					<div class="col-md-8">
						<h4 class="font-20 weight-500 mb-10 text-capitalize">
							Bienvenue <div class="weight-600 font-30 text-blue"><%=username %>!</div>
						</h4>
						<p class="font-18 max-width-600">Bienvenue sur votre tableau de bord administratif pour la gestion des clubs de l'Institut Supérieur d'Informatique et de Multimédia de Sfax. Cet espace vous permet de superviser toutes les activités des clubs, de gérer les membres, les événements et les ressources. Vous pouvez également générer des rapports, suivre les participations et assurer une communication efficace entre les différents acteurs. Profitez des outils intuitifs pour optimiser l'organisation et dynamiser la vie étudiante au sein de notre institut.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xl-3 mb-30">
    <div class="card-box height-100-p widget-style1 d-flex justify-content-center align-items-center">
        <div class="text-center">
            <i class="icon-copy ion-person" style="font-size: 40px;"></i>
            <div class="h4 mb-0 mt-2"><%=nbusers %></div>
            <div class="weight-600 font-14">User</div>
        </div>
    </div>
</div>
<div class="col-xl-3 mb-30">
    <div class="card-box height-100-p widget-style1 d-flex justify-content-center align-items-center">
        <div class="text-center">
            <i class="icon-copy fa fa-bullhorn" style="font-size: 40px;"></i>
                        <div class="h4 mb-0 mt-2"><%=nbevents %></div>
            <div class="weight-600 font-14">Event</div>
        </div>
    </div>
</div>
<div class="col-xl-3 mb-30">
    <div class="card-box height-100-p widget-style1 d-flex justify-content-center align-items-center">
        <div class="text-center">
            <i class="icon-copy fi-torsos-all" style="font-size: 40px;"></i>
                        <div class="h4 mb-0 mt-2"><%=nbclubs %></div>
             
            <div class="weight-600 font-14">Club</div>
        </div>
    </div>
</div>
<div class="col-xl-3 mb-30">
    <div class="card-box height-100-p widget-style1 d-flex justify-content-center align-items-center">
        <div class="text-center">
            <i class="icon-copy fa fa-drivers-license" style="font-size: 40px;"></i>
                        <div class="h4 mb-0 mt-2"><%=nbmembers %></div>
             
            <div class="weight-600 font-14">Members</div>
        </div>
    </div>
</div>

				
			</div>
			<div class="row">
				<div class="col-xl-8 mb-30">
					<div class="card-box height-100-p pd-20">
						<h2 class="h4 mb-20">Event/Month</h2>
						<div id="chart5"></div>
					</div>
				</div>
				<div class="col-xl-8 mb-30">
					<div class="card-box height-100-p pd-20">
						<h2 class="h4 mb-20">Members/Club</h2>
						<div id="chart9"></div>
					</div>
				</div>
				
			</div>
			
			<div class="footer-wrap pd-20 mb-20 card-box">
				Clubi - ALL RIGHTS RESERVED
			</div>
		</div>
	</div>
	<script type="text/javascript">
	var options = {
			series: [80],
			grid: {
				padding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			},
			chart: {
				height: 100,
				width: 70,
				type: 'radialBar',
			},
			plotOptions: {
				radialBar: {
					hollow: {
						size: '50%',
					},
					dataLabels: {
						name: {
							show: false,
							color: '#fff'
						},
						value: {
							show: true,
							color: '#333',
							offsetY: 5,
							fontSize: '15px'
						}
					}
				}
			},
			colors: ['#ecf0f4'],
			fill: {
				type: 'gradient',
				gradient: {
					shade: 'dark',
					type: 'diagonal1',
					shadeIntensity: 0.8,
					gradientToColors: ['#1b00ff'],
					inverseColors: false,
					opacityFrom: [1, 0.2],
					opacityTo: 1,
					stops: [0, 100],
				}
			},
			states: {
				normal: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				hover: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				active: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
			}
		};

		var options2 = {
			series: [70],
			grid: {
				padding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			},
			chart: {
				height: 100,
				width: 70,
				type: 'radialBar',
			},
			plotOptions: {
				radialBar: {
					hollow: {
						size: '50%',
					},
					dataLabels: {
						name: {
							show: false,
							color: '#fff'
						},
						value: {
							show: true,
							color: '#333',
							offsetY: 5,
							fontSize: '15px'
						}
					}
				}
			},
			colors: ['#ecf0f4'],
			fill: {
				type: 'gradient',
				gradient: {
					shade: 'dark',
					type: 'diagonal1',
					shadeIntensity: 1,
					gradientToColors: ['#009688'],
					inverseColors: false,
					opacityFrom: [1, 0.2],
					opacityTo: 1,
					stops: [0, 100],
				}
			},
			states: {
				normal: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				hover: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				active: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
			}
		};

		var options3 = {
			series: [75],
			grid: {
				padding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			},
			chart: {
				height: 100,
				width: 70,
				type: 'radialBar',
			},
			plotOptions: {
				radialBar: {
					hollow: {
						size: '50%',
					},
					dataLabels: {
						name: {
							show: false,
							color: '#fff'
						},
						value: {
							show: true,
							color: '#333',
							offsetY: 5,
							fontSize: '15px'
						}
					}
				}
			},
			colors: ['#ecf0f4'],
			fill: {
				type: 'gradient',
				gradient: {
					shade: 'dark',
					type: 'diagonal1',
					shadeIntensity: 0.8,
					gradientToColors: ['#f56767'],
					inverseColors: false,
					opacityFrom: [1, 0.2],
					opacityTo: 1,
					stops: [0, 100],
				}
			},
			states: {
				normal: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				hover: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				active: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
			}
		};

		var options4 = {
			series: [85],
			grid: {
				padding: {
					top: 0,
					right: 0,
					bottom: 0,
					left: 0
				},
			},
			chart: {
				height: 100,
				width: 70,
				type: 'radialBar',
			},
			plotOptions: {
				radialBar: {
					hollow: {
						size: '50%',
					},
					dataLabels: {
						name: {
							show: false,
							color: '#fff'
						},
						value: {
							show: true,
							color: '#333',
							offsetY: 5,
							fontSize: '15px'
						}
					}
				}
			},
			colors: ['#ecf0f4'],
			fill: {
				type: 'gradient',
				gradient: {
					shade: 'dark',
					type: 'diagonal1',
					shadeIntensity: 0.8,
					gradientToColors: ['#2979ff'],
					inverseColors: false,
					opacityFrom: [1, 0.5],
					opacityTo: 1,
					stops: [0, 100],
				}
			},
			states: {
				normal: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				hover: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
				active: {
					filter: {
						type: 'none',
						value: 0,
					}
				},
			}
		};

		var options5 = {
			chart: {
				height: 350,
				type: 'bar',
				parentHeightOffset: 0,
				fontFamily: 'Poppins, sans-serif',
				toolbar: {
					show: false,
				},
			},
			colors: ['#1b00ff', '#f56767'],
			grid: {
				borderColor: '#c7d2dd',
				strokeDashArray: 5,
			},
			plotOptions: {
				bar: {
					horizontal: false,
					columnWidth: '25%',
					endingShape: 'rounded'
				},
			},
			dataLabels: {
				enabled: false
			},
			stroke: {
				show: true,
				width: 2,
				colors: ['transparent']
			},
			series: [{
				name: 'In Progress',
				data: [<%=nbeventJan%>, <%=nbeventFev%>, <%=nbeventMar%>, <%=nbeventavr%>, <%=nbeventmai%>, <%=nbeventjun%>,<%=nbeventjul%>,<%=nbeventaout%>,<%=nbeventsep%>,<%=nbeventoct%>,<%=nbeventnov%>,<%=nbeventdec%>]
			}],
			xaxis: {
				categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','July','Aug','Sep','Oct','Nov','Dec'],
				labels: {
					style: {
						colors: ['#353535'],
						fontSize: '16px',
					},
				},
				axisBorder: {
					color: '#8fa6bc',
				}
			},
			yaxis: {
				title: {
					text: ''
				},
				labels: {
					style: {
						colors: '#353535',
						fontSize: '16px',
					},
				},
				axisBorder: {
					color: '#f00',
				}
			},
			legend: {
				horizontalAlign: 'right',
				position: 'top',
				fontSize: '16px',
				offsetY: 0,
				labels: {
					colors: '#353535',
				},
				markers: {
					width: 10,
					height: 10,
					radius: 15,
				},
				itemMargin: {
					vertical: 0
				},
			},
			fill: {
				opacity: 1

			},
			tooltip: {
				style: {
					fontSize: '15px',
					fontFamily: 'Poppins, sans-serif',
				},
				y: {
					formatter: function(val) {
						return val
					}
				}
			}
		}
		var options9 = {
				chart: {
					height: 350,
					type: 'bar',
					parentHeightOffset: 0,
					fontFamily: 'Poppins, sans-serif',
					toolbar: {
						show: false,
					},
				},
				colors: ['#1b00ff', '#f56767'],
				grid: {
					borderColor: '#c7d2dd',
					strokeDashArray: 5,
				},
				plotOptions: {
					bar: {
						horizontal: false,
						columnWidth: '25%',
						endingShape: 'rounded'
					},
				},
				dataLabels: {
					enabled: false
				},
				stroke: {
					show: true,
					width: 2,
					colors: ['transparent']
				},
				<%
				String sql9 = "SELECT * FROM club;";
				ArrayList<String> clubNames = new ArrayList<>();
				ArrayList<Integer> membresList = new ArrayList<>();

				try (Connection c = DatabaseConnection.getConnection();
				     Statement stm = c.createStatement();
				     ResultSet rs = stm.executeQuery(sql9)) {

				    while (rs.next()) {
				        int clubId = rs.getInt("id");
				        String nomClub = rs.getString("nom");
				        clubNames.add("\"" + nomClub + "\""); // pour un tableau JS de chaînes

				        // Récupérer le nombre de membres de chaque club
				        String sql17 = "SELECT COUNT(*) FROM club_membre WHERE club_id=" + clubId;
				        try (Statement stm2 = c.createStatement();
				             ResultSet rs2 = stm2.executeQuery(sql17)) {

				            if (rs2.next()) {
				                membresList.add(rs2.getInt(1));
				            } else {
				                membresList.add(0);
				            }
				        }
				    }
				} catch (SQLException e) {
				    e.printStackTrace();
				}

				// Convertir en chaînes pour JavaScript
				String clubNamesJS = clubNames.toString(); // ["club1", "club2", ...]
				String membresJS = membresList.toString(); // [4, 7, 2, ...]
				%>

				series: [{
					name: 'In Progress',
					data: <%= membresJS %>
				}],
				xaxis: {
					
					categories:  <%= clubNamesJS %>,
					labels: {
						style: {
							colors: ['#353535'],
							fontSize: '16px',
						},
					},
					axisBorder: {
						color: '#8fa6bc',
					}
				},
				yaxis: {
					title: {
						text: ''
					},
					labels: {
						style: {
							colors: '#353535',
							fontSize: '16px',
						},
					},
					axisBorder: {
						color: '#f00',
					}
				},
				legend: {
					horizontalAlign: 'right',
					position: 'top',
					fontSize: '16px',
					offsetY: 0,
					labels: {
						colors: '#353535',
					},
					markers: {
						width: 10,
						height: 10,
						radius: 15,
					},
					itemMargin: {
						vertical: 0
					},
				},
				fill: {
					opacity: 1

				},
				tooltip: {
					style: {
						fontSize: '15px',
						fontFamily: 'Poppins, sans-serif',
					},
					y: {
						formatter: function(val) {
							return val
						}
					}
				}
			}

		var options6 = {
			series: [73],
			chart: {
				height: 350,
				type: 'radialBar',
				offsetY: 0
			},
			colors: ['#0B132B', '#222222'],
			plotOptions: {
				radialBar: {
					startAngle: -135,
					endAngle: 135,
					dataLabels: {
						name: {
							fontSize: '16px',
							color: undefined,
							offsetY: 120
						},
						value: {
							offsetY: 76,
							fontSize: '22px',
							color: undefined,
							formatter: function(val) {
								return val + "%";
							}
						}
					}
				}
			},
			fill: {
				type: 'gradient',
				gradient: {
					shade: 'dark',
					shadeIntensity: 0.15,
					inverseColors: false,
					opacityFrom: 1,
					opacityTo: 1,
					stops: [0, 50, 65, 91]
				},
			},
			stroke: {
				dashArray: 4
			},
			labels: ['Achieve Goals'],
		};

		var chart = new ApexCharts(document.querySelector("#chart"), options);
		chart.render();

		var chart2 = new ApexCharts(document.querySelector("#chart2"), options2);
		chart2.render();

		var chart3 = new ApexCharts(document.querySelector("#chart3"), options3);
		chart3.render();

		var chart4 = new ApexCharts(document.querySelector("#chart4"), options4);
		chart4.render();

		var chart5 = new ApexCharts(document.querySelector("#chart5"), options5);
		chart5.render();

		var chart6 = new ApexCharts(document.querySelector("#chart6"), options6);
		chart6.render();
		var chart9 = new ApexCharts(document.querySelector("#chart9"), options9);
		chart9.render();


		// datatable init
		$('document').ready(function() {
			$('.data-table').DataTable({
				scrollCollapse: true,
				autoWidth: true,
				responsive: true,
				searching: false,
				bLengthChange: false,
				bPaginate: false,
				bInfo: false,
				columnDefs: [{
					targets: "datatable-nosort",
					orderable: false,
				}],
				"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
				"language": {
					"info": "_START_-_END_ of _TOTAL_ entries",
					searchPlaceholder: "Search",
					paginate: {
						next: '<i class="ion-chevron-right"></i>',
						previous: '<i class="ion-chevron-left"></i>'
					}
				},
			});
		});
	</script>
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
	
</body>
</html>