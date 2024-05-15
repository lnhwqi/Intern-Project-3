
import JDBC.JDBCConnection;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author lengo
 */
public class NewClass {
    
    public static Connection getJDBCConnection(){
        String url="jdbc:mysql://localhost:3306/weblab5?user=root;password=1234567";
        String user = "root";
        String password = "1234567";
        try {
            Class.forName("com.mysql.jdbc.Driver");

            return DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(NewClass.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(NewClass.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;   
    }
    
    private static boolean checkAuthentcation(String username, String password){
        boolean valid = false;
        String sql = "Select * from users where username='" + username +
                                "' and password='" + password + "'";
        
        try (Connection conn = JDBCConnection.getJDBCConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {


            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
//                    if (rs.getString("username").equals(username) && rs.getString("password").equals(password))
//                    {
                        valid = true;
//                    }
                }
            }
        } catch (SQLException e) {
//            e.printStackTrace();
        }
        return valid;
    }
    
    public static void main(String[] args) {
        boolean a = checkAuthentcation("lnhuujy","123");
        System.out.println(a);
    }
}

