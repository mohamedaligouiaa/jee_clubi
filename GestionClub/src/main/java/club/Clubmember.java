package club;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Clubmember {
	private int userId;
	private int clubId ;
	private String avis ;
	public Clubmember(int userId, int clubId, String avis) {
		this.userId = userId;
		this.clubId = clubId;
		this.avis = avis;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getClubId() {
		return clubId;
	}
	public void setClubId(int clubId) {
		this.clubId = clubId;
	}
	public String getAvis() {
		return avis;
	}
	public void setAvis(String avis) {
		this.avis = avis;
	}
	public static ArrayList<Clubmember> afficherClubmembers() throws SQLException {
        ArrayList<Clubmember> liste = new ArrayList<>();
        Connection c = DatabaseConnection.getConnection(); 

        if (c == null) { 
            System.out.println("Erreur : Connexion à la base de données non établie !");
            return liste;
        }

        try {
            Statement stmt = c.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM club_membre");

            while (rs.next()) {
                Clubmember cl = new Clubmember(rs.getInt("user_id"), rs.getInt("club_id"), rs.getString("avis"));
                liste.add(cl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return liste;
    }
	
	
}
