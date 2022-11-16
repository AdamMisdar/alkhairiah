package alkhairiah.dao;

import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class AnimalOrderDAO {
	
	// Connection object
	Connection connection = null;
	
	// Attributes
	private int animalOrderID;		// 1. ID (PK)
	private String dependentName;	// 2. Dependent Name
	private int bookingID;			// 3. Booking ID (FK)
	private int animalDetailsID;	// 4. Animal Details ID (FK)
	
	// CRUD -------------------------------------------------------
	
	// ADD Animal Order
	public void addAnimalOrder(AnimalOrder newAnimalOrder) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			dependentName = newAnimalOrder.getDependentName();
			bookingID = newAnimalOrder.getBookingID();
			animalDetailsID = newAnimalOrder.getAnimalDetailsID();
			
			// Prepare SQL Statement
			PreparedStatement addSQL = connection.prepareStatement
			( "INSERT INTO animalorder "
			+ "(dependentname, bookingid, animaldetailsid) "
			+ "VALUES (?, ?, ?)" );
			
			// Set ? values
			addSQL.setString(1, dependentName);
			addSQL.setInt(2, bookingID);
			addSQL.setInt(3, animalDetailsID);
			
			// Execute SQL
			addSQL.executeUpdate();
			
			// Check SQL
			System.out.println(addSQL);
					
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// UPDATE Animal Order
	public void updateAnimalOrder(AnimalOrder existingAnimalOrder) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			dependentName = existingAnimalOrder.getDependentName();
			animalOrderID = existingAnimalOrder.getAnimalOrderID();
			
			// Prepare SQL Statement
			PreparedStatement updateSQL = connection.prepareStatement
			( "UPDATE animalorder "
			+ "SET dependentname = ? "
			+ "WHERE animalorderid = ?" );
			
			// Set ? values
			updateSQL.setString(1, dependentName);
			updateSQL.setInt(2, animalOrderID);
			
			// Execute SQL
			updateSQL.executeUpdate();
			
			// Check SQL
			System.out.println(updateSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// DELETE Animal Order (by Animal Order ID)
	public void deleteAnimalOrder(int animalOrderID) throws SQLException {
		
		try {
		
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM animalorder "
			+ "WHERE animalorderid = ?" );
			
			// Set ? values
			deleteSQL.setInt(1, animalOrderID);
			
			// Execute SQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// DELETE Animal Order (By Booking ID) (Needed?)
	public void deleteAnimalOrderByBooking(int bookingID) throws SQLException{
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteByBookingSQL = connection.prepareStatement
			( "DELETE FROM animalorder "
			+ "WHERE bookingid = ?" );
			
			// Set ? values
			deleteByBookingSQL.setInt(1, bookingID);
			
			// Execute SQL
			deleteByBookingSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteByBookingSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
