<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="club.DatabaseConnection" %> 
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Modifier un club</title>
</head>
<body>

<% 
String id= request.getParameter("id");
String sql="SELECT * FROM club WHERE idclub = ?";

Connection c = DatabaseConnection.connect();

String nom = "";
String description = "";


try {
    PreparedStatement stm = c.prepareStatement(sql);
    stm.setString(1, id);
    ResultSet rs = stm.executeQuery();
    
    if (rs.next()) {  // Vérifier s'il y a un résultat
        nom = rs.getString("nom");
        description = rs.getString("description");
        
    }

    rs.close();
    stm.close();
} catch(SQLException e){
    e.printStackTrace();
}
%>

<h1>Modifier une personne</h1>

<form action="ClubServlet" method="post">
    <input type="hidden" name="id" value="<%= id %>"/> 
	<input type="hidden" name="action" value="modifier"/>
    <h2>Nom :</h2>
    <input name="nom" type="text" value="<%= nom %>" required />
    <br/>

    <h2>Adresse :</h2>
    <input name="description" type="text" value="<%= description %>" required />
    <br/>

    

    <input type="submit" value="Modifier"/>
</form>

</body>
</html>