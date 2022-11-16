package alkhairiah.dao;

import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class CommitteeVoluntaryDAO {
	
	// Connection object
	Connection connection = null;
	
	// Attributes
	private int committeeID;			// 1. ID (PK)
	private String committeeFullName;	// 2. Full Name
	private String committeePhoneNum;	// 3. Phone Number
	private String committeeAddress;	// 4. Address
	private Date committeeBirthDate;	// 5. Birth Date
	private String committeeEmail;		// 6. Email
	private String committeePassword;	// 7. Password
	private int managerID;				// 8. Manager ID (FK)
	private double hourlyRate;			// 9. Hourly Rate
	private String voluntaryRole;		// 10. Role
	
	// CRUD ----------------------------------------------------------------------------
	
	// CREATE New Voluntary (Manager Only)
	public void createVoluntary(Voluntary newVoluntary) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeFullName = newVoluntary.getCommitteeFullName();
			committeePhoneNum = newVoluntary.getCommitteePhoneNum();
			committeeAddress = newVoluntary.getCommitteeAddress();
			committeeBirthDate = newVoluntary.getCommitteeBirthDate();
			committeeEmail = newVoluntary.getCommitteeEmail();
			committeePassword = newVoluntary.getCommitteePassword();
			managerID = newVoluntary.getManagerID();
			hourlyRate = newVoluntary.getHourlyRate();
			voluntaryRole = newVoluntary.getVoluntaryRole();
			
			// Prepare SQL Statement
			PreparedStatement createVoluntarySQL = connection.prepareStatement
			( "INSERT INTO voluntary "
			+ "(committeefullname, committeephonenum, committeeaddress, "
			+ "committeebirthdate, committeeemail, committeepassword, "
			+ "managerid, hourlyrate, voluntaryrole) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)" );
			
			// Set ? values
			createVoluntarySQL.setString(1, committeeFullName);
			createVoluntarySQL.setString(2, committeePhoneNum);
			createVoluntarySQL.setString(3, committeeAddress);
			createVoluntarySQL.setDate(4, committeeBirthDate);
			createVoluntarySQL.setString(5, committeeEmail);
			createVoluntarySQL.setString(6, committeePassword);
			createVoluntarySQL.setInt(7, managerID);
			createVoluntarySQL.setDouble(8, hourlyRate);
			createVoluntarySQL.setString(9, voluntaryRole);
			
			// Execute SQL
			createVoluntarySQL.executeUpdate();
			
			// Check SQL
			System.out.println("createVoluntarySQL");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// UPDATE Voluntary (Voluntary Committee + Manager)
	
	/*	Update yang asal (for voluntary) ada 2 jenis
	 *  1. Voluntary committee sendiri update
	 *  2. Manager yg tlg updatekan account voluntary
	 *  
	 *  Dalam telah digabungkan ketiga2 method ini.
	 */
	
	public void updateVoluntary(Voluntary existingVoluntary, boolean isManager) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values (Basic attributes)
			committeeID = existingVoluntary.getCommitteeID();
			committeeFullName = existingVoluntary.getCommitteeFullName();
			committeePhoneNum = existingVoluntary.getCommitteePhoneNum();
			committeeAddress = existingVoluntary.getCommitteeAddress();
			committeeBirthDate = existingVoluntary.getCommitteeBirthDate();
			committeeEmail = existingVoluntary.getCommitteeEmail();
			committeePassword = existingVoluntary.getCommitteePassword();
			
			// If updater is Manager (Pengerusi/Naib Pengerusi is updater)
			if (isManager) {
				
				// Get values (Additional attributes)
				managerID = existingVoluntary.getManagerID();
				hourlyRate = existingVoluntary.getHourlyRate();
				voluntaryRole = existingVoluntary.getVoluntaryRole();
				
				// Prepare SQL Statement
				PreparedStatement updateManagerSQL = connection.prepareStatement
				( "UPDATE voluntary "
				+ "SET committeefullname = ?, committeephonenum = ?, committeeaddress = ?, "
				+ "committeebirthdate = ?, committeeemail = ?, committeepassword = ?, "
				+ "managerid = ?, hourlyrate = ?, voluntaryrole = ? "
				+ "WHERE committeeid = ?" );
				
				// Set ? values
				updateManagerSQL.setString(1, committeeFullName);
				updateManagerSQL.setString(2, committeePhoneNum);
				updateManagerSQL.setString(3, committeeAddress);
				updateManagerSQL.setDate(4, committeeBirthDate);
				updateManagerSQL.setString(5, committeeEmail);
				updateManagerSQL.setString(6, committeePassword);
				updateManagerSQL.setInt(7, managerID);
				updateManagerSQL.setDouble(8, hourlyRate);
				updateManagerSQL.setString(9, voluntaryRole);
				updateManagerSQL.setInt(10, committeeID);
				
				// Execute SQL
				updateManagerSQL.executeUpdate();
				
				// Check SQL
				System.out.println(updateManagerSQL);
				
			}
			
			// If updater is Ordinary Voluntary Committee
			else {
				
				// Prepare SQL Statement
				PreparedStatement updateVoluntarySQL = connection.prepareStatement
				( "UPDATE voluntary "
				+ "SET committeefullname = ?, committeephonenum = ?, committeebirthdate = ?, "
				+ "committeeaddress = ?, committeeemail = ?, committeepassword = ? "
				+ "WHERE committeeid = ?");
				
				
				// Set ? Values
				updateVoluntarySQL.setString(1, committeeFullName);
				updateVoluntarySQL.setString(2, committeePhoneNum);
				updateVoluntarySQL.setDate(3, committeeBirthDate);
				updateVoluntarySQL.setString(4, committeeAddress);
				updateVoluntarySQL.setString(5, committeeEmail);
				updateVoluntarySQL.setString(6, committeePassword);
				updateVoluntarySQL.setInt(7, committeeID);
				
				// Execute SQL
				updateVoluntarySQL.executeUpdate();
				
				// Check SQL
				System.out.println(updateVoluntarySQL);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// DELETE Voluntary (Manager Only)
	public void deleteVoluntary(int committeeID) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteVoluntarySQL = connection.prepareStatement
			( "DELETE FROM voluntary "
			+ "WHERE committeeid = ?" );
			
			// Set ? values
			deleteVoluntarySQL.setInt(1, committeeID);
			
			// Execute SQL
			deleteVoluntarySQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteVoluntarySQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	

}
