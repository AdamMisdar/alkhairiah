// This class is to test the connection of the system to the database

package alkhairiah.connection;

import java.sql.*;

public class TestConnection {

	public static void main(String[] args) {
		
		// Connection object
		Connection connection = null;
		
		// Get Connection
		connection = ConnectionManager.getConnection();
		
		// Test Connection
		if (connection != null) {
			
			System.out.println("Connection: Success!");
		}
		else {
			
			System.out.println("Connection: Failed.");
		}

	}

}
