package alkhairiah.javabean;

import java.sql.Date;

public class Payment {

	// Attributes
	private int paymentID;				// 1. ID (PK)
	private double paymentTotal;		// 2. Total Payment
	private Date paymentDate;			// 3. Payment Date
	private String paymentReceiptFile;	// 4. File Path to store/retrieve receipt
	private String paymentReceiptName;	// 5. Receipt Name
	private int bookingID;			// 6. Booking ID
	
	// Constructor
	public Payment() {
		
	}

	// Setters
	public void setPaymentID(int paymentID) {
		this.paymentID = paymentID;
	}	

	public void setPaymentTotal(double paymentTotal) {
		this.paymentTotal = paymentTotal;
	}
	
	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}
	
	public void setPaymentReceiptFile(String paymentReceiptPath) {
		this.paymentReceiptFile = paymentReceiptPath;
	}
	
	public void setPaymentReceiptName(String paymentReceiptName) {
		this.paymentReceiptName = paymentReceiptName;
	}
	
	public void setBookingID(int bookingID) {
		this.bookingID = bookingID;
	}
	
	// Getters
	public int getPaymentID() {
		return paymentID;
	}

	public double getPaymentTotal() {
		return paymentTotal;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public String getPaymentReceiptFile() {
		return paymentReceiptFile;
	}

	public String getPaymentReceiptName() {
		return paymentReceiptName;
	}

	public int getBookingID() {
		return bookingID;
	}


	
}
