<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, club.DatabaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Ticket</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .ticket-container {
            width: 100%;
            max-width: 500px;
        }
        
        .ticket {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            position: relative;
        }
        
        .ticket-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 25px;
            text-align: center;
            position: relative;
        }
        
        .ticket-header::after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 0;
            right: 0;
            height: 20px;
            background: radial-gradient(circle at 50% -10px, transparent 75%, #f8f9fa 76%);
        }
        
        .ticket-title {
            font-size: 1.8rem;
            margin-bottom: 5px;
            font-weight: 600;
        }
        
        .ticket-subtitle {
            font-size: 1rem;
            opacity: 0.9;
        }
        
        .ticket-body {
            padding: 25px;
            position: relative;
        }
        
        .ticket-info {
            margin-bottom: 25px;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #e0e0e0;
        }
        
        .info-label {
            font-weight: 500;
            color: #666;
            flex: 1;
        }
        
        .info-value {
            font-weight: 600;
            flex: 2;
            text-align: right;
            color: var(--dark-color);
        }
        
        .ticket-qrcode {
            text-align: center;
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .ticket-qrcode img {
            max-width: 150px;
            height: auto;
        }
        
        .ticket-number {
            text-align: center;
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            color: #666;
            letter-spacing: 2px;
            margin-top: 10px;
        }
        
        .ticket-footer {
            background: #f8f9fa;
            padding: 20px;
            text-align: center;
            border-top: 1px dashed #e0e0e0;
        }
        
        .ticket-actions {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }
        
        .watermark {
            position: absolute;
            opacity: 0.05;
            font-size: 8rem;
            font-weight: 800;
            color: var(--primary-color);
            transform: rotate(-30deg);
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-30deg);
            z-index: 0;
            pointer-events: none;
        }
        
        .ticket-rip {
            position: relative;
            height: 40px;
            margin: 0 20px;
            background: linear-gradient(to right, 
                transparent 0%, transparent 10%, 
                #ddd 10%, #ddd 12%, 
                transparent 12%, transparent 88%, 
                #ddd 88%, #ddd 90%, 
                transparent 90%, transparent 100%);
        }
        
        .ticket-rip::before,
        .ticket-rip::after {
            content: "";
            position: absolute;
            width: 20px;
            height: 20px;
            background-color: #f5f7fa;
            border-radius: 50%;
            top: -10px;
        }
        
        .ticket-rip::before {
            left: -10px;
        }
        
        .ticket-rip::after {
            right: -10px;
        }
    </style>
</head>
<body>
    <%
        String eventId = request.getParameter("eventId");
        if (eventId == null || eventId.isEmpty()) {
            response.sendRedirect("events.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String query = "SELECT e.id, e.titre, e.description, e.date_event, e.lieu, " +
                           "e.categorie, e.capacite, e.club_id, e.heure, c.nom as club_nom " +
                           "FROM club.evenement e " +
                           "LEFT JOIN club.club c ON e.club_id = c.id " +
                           "WHERE e.id = ?";
            
            stmt = conn.prepareStatement(query);
            stmt.setString(1, eventId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                String heureEvent = rs.getString("heure");
                // Format time to display only HH:mm
                if (heureEvent != null && !heureEvent.trim().isEmpty()) {
                    if (heureEvent.contains(":")) {
                        String[] parts = heureEvent.split(":");
                        if (parts.length >= 2) {
                            heureEvent = parts[0] + ":" + parts[1];
                        }
                    }
                } else {
                    heureEvent = "Not specified";
                }
    %>
    <div class="ticket-container">
        <div class="ticket">
            <div class="watermark">TICKET</div>
            
            <div class="ticket-header">
                <h2 class="ticket-title">REGISTRATION CONFIRMED</h2>
                <p class="ticket-subtitle">Your spot is reserved</p>
            </div>
            
            <div class="ticket-body">
                <div class="ticket-info">
                    <div class="info-row">
                        <span class="info-label">Event:</span>
                        <span class="info-value"><%= rs.getString("titre") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Club:</span>
                        <span class="info-value"><%= rs.getString("club_nom") != null ? rs.getString("club_nom") : "Not specified" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Date:</span>
                        <span class="info-value"><%= rs.getString("date_event") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Time:</span>
                        <span class="info-value"><%= heureEvent %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Location:</span>
                        <span class="info-value"><%= rs.getString("lieu") %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Category:</span>
                        <span class="info-value"><%= rs.getString("categorie") %></span>
                    </div>
                </div>
                
                <div class="ticket-qrcode">
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=<%= rs.getString("id") %>-<%= System.currentTimeMillis() %>" 
                         alt="QR Code">
                    <div class="ticket-number">ID: <%= rs.getString("id") %>-<%= System.currentTimeMillis() %></div>
                </div>
            </div>
            
            <div class="ticket-rip"></div>
            
            <div class="ticket-footer">
                <p>Present this ticket at the event entrance</p>
                <p><small>A confirmation email has been sent to you</small></p>
                
                <div class="ticket-actions">
                    <button class="btn btn-primary" onclick="window.print()">
                        <i class="fas fa-print"></i> Print
                    </button>
                </div>
            </div>
        </div>
    </div>
    <%
            } else {
                out.println("<p>Event not found</p>");
            }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>