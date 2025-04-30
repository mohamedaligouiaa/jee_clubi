package club;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
   

    public static Connection connect() {
        
            String nomDB = "club";
            String urlDB = "jdbc:mysql://localhost:3306/" + nomDB;
            String login = "root";
            String mot_de_passe = "magdell21102018";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Charger le driver MySQL
                
                Connection connection = DriverManager.getConnection(urlDB, login, mot_de_passe);
                System.out.println("Connexion établie !");
                return connection;
            } catch (ClassNotFoundException e) {
                System.out.println("Driver MySQL introuvable !");
                e.printStackTrace();
                return null;
            } catch (SQLException e) {
                System.out.println("Connexion non établie !");
                e.printStackTrace();
                return null;
            }
        }
        
    

    public static Connection getConnection() {
        return connect();
    }
}
