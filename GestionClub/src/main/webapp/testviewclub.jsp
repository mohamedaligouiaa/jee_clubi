<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="club.Club" %> 
<%@ page import="java.util.ArrayList" %>  
<%
	ArrayList<Club> clubs = Club.afficherClubs();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liste des Clubs</title>
</head>
<body>
	<%if(clubs != null && !clubs.isEmpty()){ %>
	<table border="1">
		<tr>
			<th>id</th>
			<th>nom</th>
			<th>description</th>
			
		</tr>
		<%for (Club p : clubs){
			 
			%>
			<tr>
				<td><%= p.getId() %></td>
				<td><%= p.getNom() %></td>
				<td><%= p.getDescription() %></td>
				<td>
				<a class="btn btn-primary" href="testmodifier.jsp?id=<%= p.getId() %>" role="button">modifier </a>
				<a href="ClubServlet?id=<%= p.getId() %>&action=supprimer" 
   class="btn btn-danger" 
   onclick="return confirm('Voulez-vous vraiment supprimer ce club ?');">Supprimer</a>


			</tr>
		<%} %>
	</table>
	<%
		} else {%>
			<p style="color: red;">Aucune personne trouvée</p>
		<% }%>
		<a href="testajout.jsp" role="button">ajouter</a>
</body>
</html>