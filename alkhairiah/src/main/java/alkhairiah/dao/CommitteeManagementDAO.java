package alkhairiah.dao;

import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class CommitteeManagementDAO {

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
	private String managementPosition;	// 9. Job Position
	
	// CRUD --------------------------------------------------------------
	
	// CREATE New Management (Manager Only)
	public void createManagement(Management newManagement) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			committeeFullName = newManagement.getCommitteeFullName();
			committeePhoneNum = newManagement.getCommitteePhoneNum();
			committeeAddress = newManagement.getCommitteeAddress();
			committeeBirthDate = newManagement.getCommitteeBirthDate();
			committeeEmail = newManagement.getCommitteeEmail();
			committeePassword = newManagement.getCommitteePassword();
			managerID = newManagement.getManagerID();
			managementPosition = newManagement.getManagementPosition();
			
			// Prepare SQL Statements
			PreparedStatement createManagementSQL = connection.prepareStatement
			( "INSERT INTO management "
			+ "(committeefullname, committeephonenum, committeebirthdate, "
			+ "committeeaddress, managerID, committeeemail, committeepassword, managementposition) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)" );
			
			// Set ? values
			createManagementSQL.setString(1, committeeFullName);
			createManagementSQL.setString(2, committeePhoneNum);
			createManagementSQL.setDate(3, committeeBirthDate);
			createManagementSQL.setString(4, committeeAddress);
			createManagementSQL.setInt(5, managerID);
			createManagementSQL.setString(6, committeeEmail);
			createManagementSQL.setString(7, committeePassword);
			createManagementSQL.setString(8, managementPosition);
			
			// Execute SQL
			createManagementSQL.executeUpdate();
			
			// Check SQL
			System.out.println(createManagementSQL);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// UPDATE Management (Management Committee)
	
	/*	Update yang asal (for management) ada tiga jenis
	 *  1. Management committee sendiri update
	 *  2. Manager yg tlg updatekan account management
	 *  3. Update for Pengerusi punya account sbb dia xde manager id
	 *  
	 *  Dalam telah digabungkan ketiga2 method ini.
	 */
	public void updateManagement(Management existingManagement, boolean isManager) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values (Basic attributes)
			committeeID = existingManagement.getCommitteeID();
			committeeFullName = existingManagement.getCommitteeFullName();
			committeePhoneNum = existingManagement.getCommitteePhoneNum();
			committeeAddress = existingManagement.getCommitteeAddress();
			committeeBirthDate = existingManagement.getCommitteeBirthDate();
			committeeEmail = existingManagement.getCommitteeEmail();
			committeePassword = existingManagement.getCommitteePassword();
			
			// If updater is Manager (Pengerusi/Naib Pengerusi is updater)
			if (isManager) {
				
				// Get values (Additional attributes)
				managementPosition = existingManagement.getManagementPosition();
				
				// if this account is Pengerusi's (cannot update managerID)
				if(managementPosition.equalsIgnoreCase("Pengerusi")) {
					
					// Prepare SQL Statement
					PreparedStatement updatePengerusiSQL = connection.prepareStatement
					( "UPDATE management "
					+ "SET committeefullname = ?, committeephonenum = ?, committeebirthdate = ?, "
					+ "committeeaddress = ?, committeeemail = ?, committeepassword = ?, managementposition = ? "
					+ "WHERE committeeid = ?");
								
					// Set ? values
					updatePengerusiSQL.setString(1, committeeFullName);
					updatePengerusiSQL.setString(2, committeePhoneNum);
					updatePengerusiSQL.setDate(3, committeeBirthDate);
					updatePengerusiSQL.setString(4, committeeAddress);
					updatePengerusiSQL.setString(5, committeeEmail);
					updatePengerusiSQL.setString(6, committeePassword);
					updatePengerusiSQL.setString(7, managementPosition);
					updatePengerusiSQL.setInt(8, committeeID);
								
					// Execute SQL
					updatePengerusiSQL.executeUpdate();
								
					// Check SQL
					System.out.println(updatePengerusiSQL);
					
				}
				
				// if this account is not Pengerusi's (can update managerID)
				else {
					
					// Get values (Additional attributes)
					managerID = existingManagement.getManagerID();
				
					// Prepare SQL Statement
					PreparedStatement updateManagerSQL = connection.prepareStatement
					( "UPDATE management "
					+ "SET committeefullname = ?, committeephonenum = ?, committeebirthdate = ?, "
					+ "committeeaddress = ?, committeeemail = ?, committeepassword = ?, managerid = ?, managementposition = ? "
					+ "WHERE committeeid = ?");
				
					// Set ? values
					updateManagerSQL.setString(1, committeeFullName);
					updateManagerSQL.setString(2, committeePhoneNum);
					updateManagerSQL.setDate(3, committeeBirthDate);
					updateManagerSQL.setString(4, committeeAddress);
					updateManagerSQL.setString(5, committeeEmail);
					updateManagerSQL.setString(6, committeePassword);
					updateManagerSQL.setInt(7, managerID);
					updateManagerSQL.setString(8, managementPosition);
					updateManagerSQL.setInt(9, committeeID);
				
					// Execute SQL
					updateManagerSQL.executeUpdate();
				
					// Check SQL
					System.out.println(updateManagerSQL);
				}
				
			}
			
			// If updater is Ordinary Management Committee
			else {
				
				// Prepare SQL Statement
				PreparedStatement updateManagementSQL = connection.prepareStatement
				( "UPDATE management "
				+ "SET committeefullname = ?, committeephonenum = ?, committeebirthdate = ?, "
				+ "committeeaddress = ?, committeeemail = ?, committeepassword = ? "
				+ "WHERE committeeid = ?" );
				
				// Set ? values
				updateManagementSQL.setString(1, committeeFullName);
				updateManagementSQL.setString(2, committeePhoneNum);
				updateManagementSQL.setDate(3, committeeBirthDate);
				updateManagementSQL.setString(4, committeeAddress);
				updateManagementSQL.setString(5, committeeEmail);
				updateManagementSQL.setString(6, committeePassword);
				updateManagementSQL.setInt(7, committeeID);
				
				// Execute SQL
				updateManagementSQL.executeUpdate();
				
				// Check SQL
				System.out.println(updateManagementSQL);
				
				
			}		
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// DELETE Management (Manager Only)
	public void deleteManagement(int committeeID) throws SQLException {
		
		try {
			
			// Get Connection
			connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statement
			PreparedStatement deleteManagementSQL = connection.prepareStatement
			( "DELETE FROM management "
			+ "WHERE committeeid = ?");
			
			// Set ? values
			deleteManagementSQL.setInt(1, committeeID);
			
			// Execute SQL
			deleteManagementSQL.executeUpdate();
			
			// Check SQL
			System.out.println(deleteManagementSQL);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
