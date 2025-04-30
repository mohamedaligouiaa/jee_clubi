<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirmation</title>
    <script type="text/javascript">
        // Fonction pour afficher le popup en fonction du paramètre success
        window.onload = function() {
            var success = '<%= request.getParameter("success") %>';
            if (success === 'true') {
                alert("Événement ajouté avec succès !");
            } else {
                alert("Erreur lors de l'ajout de l'événement.");
            }
        };
    </script>
</head>
<body>
    <h2>Confirmation de l'ajout de l'événement</h2>
    <!-- Contenu qui peut être ajusté ou laissé vide si le popup suffit -->
</body>
</html>
