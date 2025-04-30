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
    private void ajoutClub(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sql = "INSERT INTO club (image, nom, description) VALUES (?, ?, ?);";  
        
        String nom = request.getParameter("nom");
        String description = request.getParameter("description");
        Part filePart = request.getPart("image");
        String imageName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            imageName = "img_" + System.currentTimeMillis() + fileExtension;
            
            // Définir le chemin correct vers le dossier images dans webapp/vendors/images
            String uploadPath = getServletContext().getRealPath(UPLOAD_DIR);
            System.out.println("Chemin absolu du dossier d'upload : " + uploadPath);
            
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                if (created) {
                    System.out.println("✅ Dossier créé : " + uploadPath);
                } else {
                    System.out.println("❌ Impossible de créer le dossier !");
                }
            }
            
            // Enregistrer l'image
            filePart.write(uploadPath + File.separator + imageName);
            System.out.println("✅ Image enregistrée avec succès : " + uploadPath + File.separator + imageName);
        }
        try (Connection c = DatabaseConnection.getConnection();
             PreparedStatement pst = c.prepareStatement(sql)) {
            
            pst.setString(1, imageName);
            pst.setString(2, nom);
            pst.setString(3, description);
            pst.executeUpdate();
            
            response.sendRedirect("clubs.jsp?success=Club ajouté avec succès");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("clubs.jsp?error=Erreur lors de l'ajout du club");
        }
    }


    private void modifierclub (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	String sql ="UPDATE club SET nom=? , description = ? WHERE id=? ;";
    	int id = Integer.parseInt(request.getParameter("id"));
    	String nom = request.getParameter("nom");
    	String description = request.getParameter("description");
    	try {
    		Connection c = DatabaseConnection.getConnection();
    		PreparedStatement pst = c.prepareStatement(sql);
    		
    		pst.setString(1, nom);
    		pst.setString(2, description);
    		pst.setInt(3, id);
    		pst.executeUpdate();
    	}catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    	
    }
    private void supprimerclub (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	String sql ="DELETE FROM club WHERE id=? ;";
    	int id = Integer.parseInt(request.getParameter("id"));
    	try {
    		Connection c = DatabaseConnection.getConnection();
    		PreparedStatement pst = c.prepareStatement(sql);
    		pst.setInt(1, id);
    		pst.executeUpdate();
    	}catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    	
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String action = request.getParameter("action");

	     if ("supprimer".equals(action)) {
	    	 supprimerclub(request, response);
		} 
			 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
		    ajoutClub(request, response);
		} else if ("modifier".equals(action)) {
		    modifierclub(request, response);
		} else {
			System.out.println("nonnnn");
		}
    }

}
