package alkhairiah.dao;

import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class ClientDAO {
	
	// Connection object
	Connection connection = null;
	
	// Attributes
	private int clientID;			// 1. ID (PK)
	private String clientFullName;		// 2. Full Name
	private String clientPhoneNum;	// 3. Phone Number
	private String clientAddress;	// 4. Address
	private Date clientBirthDate;	// 5. Birth Date
	private String clientEmail;		// 6. Email
	private String clientPassword;	// 7. Password
	
	// CRUD -----------------------------------------------------------------------
	
	// CREATE New Client
	public void createClient(Client newClient) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			clientFullName = newClient.getClientFullName();
			clientPhoneNum = newClient.getClientPhoneNum();
			clientAddress = newClient.getClientAddress();
			clientBirthDate = newClient.getClientBirthDate();
			clientEmail = newClient.getClientEmail();
			clientPassword = newClient.getClientPassword();
			
			// Prepare SQL Statement
			PreparedStatement createSQL = connection.prepareStatement
			( "INSERT INTO client "
			 + "(clientfullname, clientphonenum, clientaddress, clientbirthdate, clientemail, clientpassword) "
			 + "VALUES (?, ?, ?, ?, ?, ?)");
			
			// Set ? values
			createSQL.setString(1, clientFullName);
			createSQL.setString(2, clientPhoneNum);
			createSQL.setString(3, clientAddress);
			createSQL.setDate(4, clientBirthDate);
			createSQL.setString(5, clientEmail);
			createSQL.setString(6, clientPassword);
			
			// Execute SQL
			createSQL.executeUpdate();
			
			// Check SQL
			System.out.println(createSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		
	}
	
	// UPDATE Client (Update Existing Client)
	public void updateClientDetails(Client existingClient) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Get Values
			clientID = existingClient.getClientID();
			clientFullName = existingClient.getClientFullName();
			clientPhoneNum = existingClient.getClientPhoneNum();
			clientAddress = existingClient.getClientAddress();
			clientBirthDate = existingClient.getClientBirthDate();
			clientEmail = existingClient.getClientEmail();
			clientPassword = existingClient.getClientPassword();
			
			// Prepare SQL Statement
			PreparedStatement updateSQL = connection.prepareStatement
			( "UPDATE client "
			+ "SET clientfullname = ?, clientphonenum = ?, clientaddress = ?, "
			+ "clientbirthdate = ?, clientemail = ?, clientpassword = ? "
			+ "WHERE clientid = ?" );
			
			// Set ? values
			updateSQL.setString(1, clientFullName);
			updateSQL.setString(2, clientPhoneNum);
			updateSQL.setString(3, clientAddress);
			updateSQL.setDate(4, clientBirthDate);
			updateSQL.setString(5, clientEmail);
			updateSQL.setString(6, clientPassword);
			updateSQL.setInt(7, clientID);
			
			// Execute SQL
			updateSQL.executeUpdate();
			
			// Check SQL
			System.out.println(updateSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// DELETE Client (Manager Delete their account)
	// TENGOK BALIK, KLAU CLIENT DELETE, BOOKING DELETE TAK
	// Bila client delete, booking xdelete, jadi null
	public void deleteClient(int clientID) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM client "
			+ "WHERE clientid = ?");
			
			// Set ? values
			deleteSQL.setInt(1, clientID);
			
			// Execute SQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
