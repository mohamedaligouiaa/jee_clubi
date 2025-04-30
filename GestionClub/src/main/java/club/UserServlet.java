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

import org.mindrot.jbcrypt.BCrypt;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "/vendors/images"; // Dossier relatif au projet
       
    public UserServlet() {
        super();
    }

    private void ajoutUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sql = "INSERT INTO users (image,email, username, password, full_name, gender, city, role) VALUES (?,?,?,?,?,?,?,?);";  
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String role = request.getParameter("role");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        Part filePart = request.getPart("image");
        String imageName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            imageName = "img_" + System.currentTimeMillis() + fileExtension;
            
            // Vérification du type de fichier
            String allowedFileTypes = "image/jpeg image/png image/gif";
            String contentType = filePart.getContentType();
            
            if (allowedFileTypes.contains(contentType)) {
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
            } else {
                request.setAttribute("errorMessage", "Seules les images (JPG, PNG, GIF) sont autorisées.");
                request.getRequestDispatcher("formulaire.jsp").forward(request, response);
                return;
            }
        }

        try (Connection c = DatabaseConnection.getConnection();
             PreparedStatement pst = c.prepareStatement(sql)) {
            pst.setString(1, imageName); 
            pst.setString(2, email);
            pst.setString(3, username);
            pst.setString(4, hashedPassword);
            pst.setString(5, fullname);
            pst.setString(6, gender);
            pst.setString(7, city);
            pst.setString(8, role);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de l'ajout de l'utilisateur.");
            request.getRequestDispatcher("formulaire.jsp").forward(request, response);
            return;
        }
        
        if (role.equals("admin")) {
            request.setAttribute("email", email);
            request.getRequestDispatcher("dashboardadmin.jsp").forward(request, response);
        } else {
            request.setAttribute("email", email);
            request.getRequestDispatcher("dashboardStudent.jsp").forward(request, response);
        }
    }


    private void modifieruser (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	String sql ="UPDATE users SET email=? ,username=?, password=?, full_name=?, gender=?, city=?,role=? WHERE id=? ;";
    	int id = Integer.parseInt(request.getParameter("id"));
    	String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("full_name");
        String gender = request.getParameter("gender");
        String city = request.getParameter("city");
        String role = request.getParameter("role");
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    	try {
    		Connection c = DatabaseConnection.getConnection();
    		PreparedStatement pst = c.prepareStatement(sql);
    		
    		pst.setString(1, email);
            pst.setString(2, username);
            pst.setString(3, hashedPassword);
            pst.setString(4, fullname);
            pst.setString(5, gender);
            pst.setString(6, city);
            pst.setString(7, role);
            pst.setInt(7, id);
    		pst.executeUpdate();
    	}catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    	
    }
    private void supprimeruser (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	String sql ="DELETE FROM users WHERE id=? ;";
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
	    	 supprimeruser(request, response);
		} 
			 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
		    ajoutUser(request, response);
		    
		} else if ("modifier".equals(action)) {
		    modifieruser(request, response);
		}
    }


}
