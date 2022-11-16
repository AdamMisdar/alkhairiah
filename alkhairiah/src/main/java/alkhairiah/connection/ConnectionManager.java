package alkhairiah.connection;

import java.sql.*;

public class ConnectionManager {

	// Postgresql Database
	private static String dbURL = "jdbc:postgresql://localhost:5432/alkhairiah";
	private static String username = "postgres";
	private static String password = "system";
	
	// getConnection() method
	public static Connection getConnection() {
		
		// Connection object
		Connection connection = null;
		
		try {
			// Postgresql Driver
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection(dbURL, username, password);
		
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return connection;
	}
}
