package alkhairiah.dao;

import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class AnimalDetailsDAO {
	
	// Connection object
	Connection connection = null;
	
	// Attributes
	private int animalDetailsID;	// 1. ID (PK)
	private String animalType;		// 2. Animal Type
	private double animalPrice;		// 3. Animal Price
	
	// CRUD --------------------------------------------------------------------------
	
	// CREATE New Animal Details
	public void createAnimalDetails(AnimalDetails newAnimal) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			animalType = newAnimal.getAnimalType();
			animalPrice = newAnimal.getAnimalPrice();
			
			// Prepare SQL Statement
			PreparedStatement createSQL = connection.prepareStatement
			( "INSERT INTO animaldetails "
			+ "(animaltype, animalprice) "
			+ "VALUES (?, ROUND(?::numeric, 2))" );
			
			// Set ? values
			createSQL.setString(1, animalType);
			createSQL.setDouble(2, animalPrice);
			
			// Execute SQL
			createSQL.executeUpdate();
			
			// Check SQL
			System.out.println(createSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// UPDATE Animal Details (Existing Animal)
	public void updateAnimalDetails(AnimalDetails existingAnimal) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			animalPrice = existingAnimal.getAnimalPrice();
			animalType = existingAnimal.getAnimalType();
			animalDetailsID = existingAnimal.getAnimalDetailsID();
			
			// Prepare SQL Statement
			PreparedStatement updateSQL = connection.prepareStatement
			( "UPDATE animaldetails "
			+ "SET animalprice = ?, animaltype = ? "
			+ "WHERE animaldetailsid = ?" );
			
			// Set ? values
			updateSQL.setDouble(1, animalPrice);
			updateSQL.setString(2, animalType);
			updateSQL.setInt(3, animalDetailsID);
			
			// Execute SQL
			updateSQL.executeUpdate();
			
			// Check SQL
			System.out.println(updateSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// DELETE Animal Details
	public void deleteAnimalDetails(int animalDetailsID) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteSQL = connection.prepareStatement
			( "DELETE FROM animaldetails "
			+ "WHERE animaldetailsid = ?" );
			
			// Set ? values
			deleteSQL.setInt(1, animalDetailsID);
			
			// Execute SQL
			deleteSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
