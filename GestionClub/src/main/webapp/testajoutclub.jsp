<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajout club</title>
</head>
<body>
	<h1>ajout club</h1>
	<form action = "ClubServlet" method = "post">
		<input type="hidden" name="action" value="ajouter"/>
		name : <input type = "text" name ="nom"/>
		description : <input type = "text" name ="description"/>
		<input type ="submit" name="ajouter" value="ajouter"/>
	</form>
</body>
</html>