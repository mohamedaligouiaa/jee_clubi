package club;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/EvenementParticipantServlet")
public class EvenementParticipantServlet extends HttpServlet {

    // Méthode pour afficher le message d'information
    private void afficherMessage(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        response.getWriter().println("<html><body>");
        response.getWriter().println("<h3>" + message + "</h3>");
        response.getWriter().println("<a href='index.jsp'>Retour à la liste des événements</a>");
        response.getWriter().println("</body></html>");
    }

    // Ajouter un participant à un événement
    private void ajouterParticipant(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int evenementId = Integer.parseInt(request.getParameter("evenement_id"));
        String avis = request.getParameter("avis");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO evenement_participant (user_id, evenement_id, avis) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setInt(2, evenementId);
            stmt.setString(3, avis);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                afficherMessage(response, "Participant ajouté avec succès !");
            } else {
                afficherMessage(response, "Erreur lors de l'ajout du participant.");
            }
        }
    }

    // Supprimer un participant d'un événement
    private void supprimerParticipant(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int evenementId = Integer.parseInt(request.getParameter("evenement_id"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM evenement_participant WHERE user_id = ? AND evenement_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);
            stmt.setInt(2, evenementId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                afficherMessage(response, "Participant supprimé avec succès !");
            } else {
                afficherMessage(response, "Erreur lors de la suppression du participant.");
            }
        }
    }

    // Modifier l'avis d'un participant
    private void modifierAvis(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));
        int evenementId = Integer.parseInt(request.getParameter("evenement_id"));
        String avis = request.getParameter("avis");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "UPDATE evenement_participant SET avis = ? WHERE user_id = ? AND evenement_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, avis);
            stmt.setInt(2, userId);
            stmt.setInt(3, evenementId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                afficherMessage(response, "Avis modifié avec succès !");
            } else {
                afficherMessage(response, "Erreur lors de la modification de l'avis.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("ajouter".equals(action)) {
                ajouterParticipant(request, response);
            } else if ("supprimer".equals(action)) {
                supprimerParticipant(request, response);
            } else if ("modifier".equals(action)) {
                modifierAvis(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            afficherMessage(response, "Erreur de base de données : " + e.getMessage());
        }
    }
}
