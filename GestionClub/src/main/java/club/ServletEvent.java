package club;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/EvenementServlet")
public class ServletEvent extends HttpServlet {

    // Ajouter un événement
    private void ajouterEvenement(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException, ServletException {
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String dateEvent = request.getParameter("date_event");
        String lieu = request.getParameter("lieu");
        String categorie = request.getParameter("categorie");
        int capacite = Integer.parseInt(request.getParameter("capacite"));
        int clubId = Integer.parseInt(request.getParameter("club_id"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "INSERT INTO evenement (titre, description, date_event, lieu, categorie, capacite, club_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, titre);
            stmt.setString(2, description);
            stmt.setString(3, dateEvent);
            stmt.setString(4, lieu);
            stmt.setString(5, categorie);
            stmt.setInt(6, capacite);
            stmt.setInt(7, clubId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                request.getSession().setAttribute("message", "Événement ajouté avec succès !");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Erreur lors de l'ajout de l'événement.");
                request.getSession().setAttribute("messageType", "error");
            }
            response.sendRedirect("events.jsp");
        }
    }

    // Supprimer un événement
    private void supprimerEvenement(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "DELETE FROM evenement WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, id);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                request.getSession().setAttribute("message", "Événement supprimé avec succès !");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Erreur lors de la suppression de l'événement.");
                request.getSession().setAttribute("messageType", "error");
            }
            response.sendRedirect("events.jsp");
        }
    }

    // Modifier un événement
    private void modifierEvenement(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String dateEvent = request.getParameter("date_event");
        String lieu = request.getParameter("lieu");
        String categorie = request.getParameter("categorie");
        int capacite = Integer.parseInt(request.getParameter("capacite"));
        int clubId = Integer.parseInt(request.getParameter("club_id"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String query = "UPDATE evenement SET titre = ?, description = ?, date_event = ?, lieu = ?, categorie = ?, capacite = ?, club_id = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, titre);
            stmt.setString(2, description);
            stmt.setString(3, dateEvent);
            stmt.setString(4, lieu);
            stmt.setString(5, categorie);
            stmt.setInt(6, capacite);
            stmt.setInt(7, clubId);
            stmt.setInt(8, id);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                request.getSession().setAttribute("message", "Événement modifié avec succès !");
                request.getSession().setAttribute("messageType", "success");
            } else {
                request.getSession().setAttribute("message", "Erreur lors de la modification de l'événement.");
                request.getSession().setAttribute("messageType", "error");
            }
            response.sendRedirect("events.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("ajouter".equals(action)) {
                ajouterEvenement(request, response);
            } else if ("supprimer".equals(action)) {
                supprimerEvenement(request, response);
            } else if ("modifier".equals(action)) {
                modifierEvenement(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Erreur de base de données: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect("events.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Format de nombre invalide: " + e.getMessage());
            request.getSession().setAttribute("messageType", "error");
            response.sendRedirect("events.jsp");
        }
    }
}