<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
// Connexion BD
String url = "jdbc:mysql://localhost:3306/ma_base";
String user = "root";
String password = "";

// Récupérer le message
String userMessage = request.getParameter("msg");
String botResponse = "Bonjour, comment puis-je vous aider ?";
String options = "Clubs|Événements|Autre question";

if(userMessage != null && !userMessage.trim().isEmpty()) {
    try {
        Connection conn = DriverManager.getConnection(url, user, password);
        
        // Chercher dans tous les mots-clés
        String sql = "SELECT reponse, options FROM chatbot WHERE ? LIKE CONCAT('%', keyword, '%')";
        PreparedStatement stmt = conn.prepareStatement(sql);
        
        // Split des mots-clés et recherche
        String[] keywords = userMessage.split(" ");
        for(String keyword : keywords) {
            stmt.setString(1, keyword);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()) {
                botResponse = rs.getString("reponse");
                options = rs.getString("options");
                break;
            }
        }
        conn.close();
    } catch(Exception e) {
        botResponse = "Désolé, service indisponible. Veuillez réessayer.";
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chatbot Faculté</title>
    <style>
        .chat-container {
            width: 350px; 
            border: 1px solid #6a1b9a;
            border-radius: 10px;
            font-family: Arial, sans-serif;
        }
        .chat-header {
            background: #6a1b9a;
            color: white;
            padding: 10px;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }
        .chat-body {
            height: 300px;
            overflow-y: auto;
            padding: 10px;
            background: #f9f9f9;
        }
        .user-msg {
            background: #e1bee7;
            padding: 8px;
            margin: 5px;
            border-radius: 5px;
            max-width: 80%;
            float: right;
        }
        .bot-msg {
            background: white;
            padding: 8px;
            margin: 5px;
            border-radius: 5px;
            max-width: 80%;
            float: left;
            border: 1px solid #ddd;
        }
        .options {
            display: flex;
            flex-wrap: wrap;
            gap: 5px;
            padding: 10px;
        }
        .option-btn {
            background: #9c27b0;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 15px;
            cursor: pointer;
        }
        .chat-input {
            display: flex;
            padding: 10px;
            border-top: 1px solid #ddd;
        }
        #user-input {
            flex-grow: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">Assistant Faculté</div>
        <div class="chat-body" id="chat-body">
            <% if(userMessage != null) { %>
                <div class="user-msg"><%= userMessage %></div>
                <div class="bot-msg"><%= botResponse %></div>
            <% } else { %>
                <div class="bot-msg"><%= botResponse %></div>
            <% } %>
        </div>
        <div class="options">
            <% for(String opt : options.split("\\|")) { %>
                <button class="option-btn" onclick="sendMsg('<%= opt %>')"><%= opt %></button>
            <% } %>
        </div>
        <form method="post" class="chat-input">
            <input type="text" id="user-input" name="msg" placeholder="Tapez votre message...">
            <input type="submit" value="Envoyer">
        </form>
    </div>

    <script>
        function sendMsg(msg) {
            document.getElementById('user-input').value = msg;
            document.forms[0].submit();
        }
        
        // Scroll automatique
        window.onload = function() {
            document.getElementById('chat-body').scrollTop = document.getElementById('chat-body').scrollHeight;
        };
    </script>
</body>
</html>