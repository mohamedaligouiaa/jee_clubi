package club;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * Servlet implementation class ClubServlet
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
    )
public class ClubServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "/vendors/images";

    /**
     * Default constructor. 
     */
    public ClubServlet() {
        // TODO Auto-generated constructor stub
    }
    
    private void addClub(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sql = "INSERT INTO club (image, nom, description) VALUES (?, ?, ?);";  
        
        String name = request.getParameter("nom");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");
        String imageName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            imageName = "img_" + System.currentTimeMillis() + fileExtension;
            
            // Set the correct path to the images folder in webapp/vendors/images
            String uploadPath = getServletContext().getRealPath(UPLOAD_DIR);
            System.out.println("Absolute upload folder path: " + uploadPath);
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                if (created) {
                    System.out.println("✅ Folder created: " + uploadPath);
                } else {
                    System.out.println("❌ Failed to create folder!");
                }
            }
            
            // Save the image
            filePart.write(uploadPath + File.separator + imageName);
            System.out.println("✅ Image saved successfully: " + uploadPath + File.separator + imageName);
        }
        
        try (Connection c = DatabaseConnection.getConnection();
             PreparedStatement pst = c.prepareStatement(sql)) {
            
            pst.setString(1, imageName);
            pst.setString(2, name);
            pst.setString(3, description);
            pst.executeUpdate();
            
            response.sendRedirect("clubs.jsp?success=Club added successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("clubs.jsp?error=Error while adding club");
        }
    }

    private void updateClub(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sql = "UPDATE club SET nom=?, description=? WHERE id=?;";
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("nom");
        String description = request.getParameter("description");
        
        try (Connection c = DatabaseConnection.getConnection();
             PreparedStatement pst = c.prepareStatement(sql)) {
            
            pst.setString(1, name);
            pst.setString(2, description);
            pst.setInt(3, id);
            pst.executeUpdate();
            
            response.sendRedirect("clubs.jsp?success=Club updated successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("clubs.jsp?error=Error while updating club");
        }
    }
    
    private void deleteClub(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sql = "DELETE FROM club WHERE id=?;";
        int id = Integer.parseInt(request.getParameter("id"));
        
        try (Connection c = DatabaseConnection.getConnection();
             PreparedStatement pst = c.prepareStatement(sql)) {
            
            pst.setInt(1, id);
            pst.executeUpdate();
            
            response.sendRedirect("clubs.jsp?success=Club deleted successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("clubs.jsp?error=Error while deleting club");
        }
    }
    
    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("supprimer".equals(action)) {
            deleteClub(request, response);
        } else if ("afficherAjout".equals(action)) {
            // Redirect to ajoutclub.jsp page
            response.sendRedirect("ajoutclub.jsp");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
            addClub(request, response);
        } else if ("modifier".equals(action)) {
            updateClub(request, response);
        } else {
            System.out.println("noooo");
        }
    }
}