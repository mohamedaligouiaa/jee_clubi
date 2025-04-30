package club;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class User {
	private int id;
	private String email;
	private String username;
	private String password;
	private String full_name;
	private String gender;
	private String city;
	private String role;
	public User(int id, String email, String username, String password, String full_name, String gender, String city,
			String role) {
		this.id = id;
		this.email = email;
		this.username = username;
		this.password = password;
		this.full_name = full_name;
		this.gender = gender;
		this.city = city;
		this.role = role;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public static ArrayList<User> afficherUserss() throws SQLException {
        ArrayList<User> liste = new ArrayList<>();
        Connection c = DatabaseConnection.getConnection(); 

        if (c == null) { 
            System.out.println("Erreur : Connexion à la base de données non établie !");
            return liste;
        }

        try {
            Statement stmt = c.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");

            while (rs.next()) {
                User cl = new User(rs.getInt("id"), rs.getString("email"), rs.getString("username"),rs.getString("password"), rs.getString("fullname"),rs.getString("gender"), rs.getString("city"),rs.getString("role"));
                liste.add(cl);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return liste;
    }
	
}
