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

/**
 * Servlet implementation class ClubmemberServlet
 */
public class ClubmemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClubmemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    private void ajoutClubmember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sql = "INSERT INTO club_membre (user_id, club_id,avis) VALUES (?, ?,?);";
        int userid = Integer.parseInt(request.getParameter("user_id"));
        int clubid = Integer.parseInt(request.getParameter("club_id"));
        String avis = request.getParameter("avis");

        try {
            Connection c = DatabaseConnection.getConnection();
            PreparedStatement pst = c.prepareStatement(sql);
            pst.setInt(1, userid);
            pst.setInt(2, clubid);
            pst.setString(3, avis);
            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void modifieravisclubmembre (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	String sql ="UPDATE club_membre SET avis = ? WHERE user_id=? AND club_id=? ;";
    	int userid = Integer.parseInt(request.getParameter("user_id"));
        int clubid = Integer.parseInt(request.getParameter("club_id"));
        String avis = request.getParameter("avis");
    	try {
    		Connection c = DatabaseConnection.getConnection();
    		PreparedStatement pst = c.prepareStatement(sql);
    		
    		pst.setString(1, avis);
    		pst.setInt(2, userid);
    		pst.setInt(3, clubid);
    		pst.executeUpdate();
    	}catch(SQLException e) {
    		e.printStackTrace();
    	}
    	
    	
    }
    private void supprimerclubmember (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	String sql ="DELETE FROM club_membre WHERE club_id=? AND user_id=? ;";
    	int userid = Integer.parseInt(request.getParameter("user_id"));
        int clubid = Integer.parseInt(request.getParameter("club_id"));
    	try {
    		Connection c = DatabaseConnection.getConnection();
    		PreparedStatement pst = c.prepareStatement(sql);
    		pst.setInt(1, userid);
    		pst.setInt(2, clubid);
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
	    	 supprimerclubmember(request, response);
		} 
			 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("ajouter".equals(action)) {
		    ajoutClubmember(request, response);
		} else if ("modifier".equals(action)) {
		    modifieravisclubmembre(request, response);
		}
    }

}
