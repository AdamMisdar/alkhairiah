package alkhairiah.dao;

import java.io.*;
import java.sql.*;
import alkhairiah.connection.*;
import alkhairiah.javabean.*;

public class PaymentDAO {

	// Connection object
	Connection connection = null;
	
	// Attributes
	/*private int paymentID;			// 1. ID (PK) */
	private double paymentTotal;		// 2. Total Payment
	private Date paymentDate;			// 3. Payment Date
	private String paymentReceiptFile;	// 4. Path of Receipt
	private String paymentReceiptName;	// 5. Name of Receipt
	private int bookingID;				// 6. Booking ID (FK)
	
	// CRUD --------------------------------------------------------
	
	// ADD Payment
	public void addPayment(Payment newPayment) throws SQLException {
		
		try {
			
			// Get connection
			connection = ConnectionManager.getConnection();
			
			// Get values
			paymentTotal = newPayment.getPaymentTotal();
			paymentDate = newPayment.getPaymentDate();
			paymentReceiptFile = newPayment.getPaymentReceiptFile();
			paymentReceiptName = newPayment.getPaymentReceiptName();
			bookingID = newPayment.getBookingID();
			
			// Prepare SQL Statement
			PreparedStatement addSQL = connection.prepareStatement
			( "INSERT INTO payment "
			+ "(paymenttotal, paymentdate, paymentreceiptfile, paymentreceiptname, bookingid) "
			+ "VALUES (ROUND(?::numeric, 2), ?, ?, ?, ?)" );
			
			// Create new File from the created path given
			File newFile = new File(paymentReceiptFile); // paymentReceiptFile = temporary file path created from controller/handler to store the file
			
			// Convert File into FileInputStream
			try (FileInputStream fileInputStream = new FileInputStream(newFile)) {
				
				// Set ? values for SQL
				addSQL.setDouble(1, paymentTotal);
				addSQL.setDate(2, paymentDate);
				addSQL.setBinaryStream(3, fileInputStream, (int)newFile.length());
				addSQL.setString(4, paymentReceiptName);
				addSQL.setInt(5, bookingID);
				
				// Execute SQL
				addSQL.executeUpdate();
				
				// Check SQL
				System.out.println(addSQL + "\nFile Successfully added.\n - - -");
				
			} catch (IOException e) {
				e.printStackTrace();
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// No need DELETE because we can use ON CASCADE DELETE ON FK
		
	}
}
