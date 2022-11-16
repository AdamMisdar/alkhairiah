package alkhairiah.dao;

import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class BookingDAO {
	
	// Connection object 
	Connection connection = null;
	
	// Attributes
	private int bookingID;		// 1. ID (PK)
	private Date bookingDate;	// 2. Booking Date
	private int clientID;		// 3. Client ID (FK)
	private int committeeID;	// 4. Committee ID (FK)
	
	// CRUD ------------------------------------------------------
	
	// CREATE Booking (Returns Booking ID to JSP/Controller)
	public int createBooking(Booking newBooking) throws SQLException {
		
		int booking_id = 0;
		
		try {
			
			// ## CREATE Booking ##
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			bookingDate = newBooking.getBookingDate();
			clientID = newBooking.getClientID();
			
			// Prepare SQL Statement
			PreparedStatement createSQL = connection.prepareStatement
			( "INSERT INTO booking "
			+ "(bookingdate, clientid) "
			+ "VALUES (?, ?)" );
			
			// Set ? values
			createSQL.setDate(1, bookingDate);
			createSQL.setInt(2, clientID);
			
			// Execute SQL
			createSQL.executeUpdate();
			
			// Check SQL
			System.out.println(createSQL);
			
			// ## SELECT Booking ID of the created Booking ##
			
			// Prepare SQL Statement
			PreparedStatement selectSQL = connection.prepareStatement
			( "SELECT bookingid, clientid "
			+ "FROM booking "
			+ "WHERE clientid = ? "
			+ "ORDER BY bookingid" );
			
			// Set ? values
			selectSQL.setInt(1, clientID);
			
			// Execute SQL
			ResultSet result = selectSQL.executeQuery();
			
			// Assign Booking ID to booking_id
			while(result.next()) {
				booking_id = result.getInt("bookingid");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Return value of Booking ID
		return booking_id;
		
	}
	
	// UPDATE Booking (Update Committee ID - Manage Booking)
	public void updateBooking(Booking existingBooking) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeID = existingBooking.getCommitteeID();
			bookingID = existingBooking.getBookingID();
			
			// Prepare SQL
			PreparedStatement updateSQL = connection.prepareStatement
			( "UPDATE booking "
			+ "SET committeeid = ? "
			+ "WHERE bookingid = ?" );
			
			// Set ? values
			updateSQL.setInt(1, committeeID); System.out.println(committeeID);
			updateSQL.setInt(2, bookingID); System.out.println(bookingID);
			
			// Execute SQL
			updateSQL.executeUpdate();
			
			// Check SQL
			System.out.println(updateSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// DELETE Booking (Management Only) (ON DELETE CASCADE)
	public void deleteBooking(int bookingID) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM booking "
			+ "WHERE bookingid = ?" );
			
			// Set ? values
			deleteSQL.setInt(1, bookingID);
			
			// Execute SQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
