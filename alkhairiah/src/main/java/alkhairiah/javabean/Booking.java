package alkhairiah.javabean;

import java.sql.Date;

public class Booking {

	// Attributes
	private int bookingID;		// 1. ID (PK)
	private Date bookingDate;	// 2. Booking Date
	private int clientID;		// 3. Client ID (FK)
	private int committeeID;	// 4. Committee ID (FK)
	/*paymentID here or not? */
	private int paymentID;		// 5. Payment ID (FK)
	
	// Constructor
	public Booking() {
		
	}

	// Setters
	public void setBookingID(int bookingID) {
		this.bookingID = bookingID;
	}	
	
	public void setBookingDate(Date bookingDate) {
		this.bookingDate = bookingDate;
	}
	
	public void setClientID(int clientID) {
		this.clientID = clientID;
	}
	
	public void setCommitteeID(int committeeID) {
		this.committeeID = committeeID;
	}
	
	public void setPaymentID(int paymentID) {
		this.paymentID = paymentID;
	}
	
	// Getters
	public int getBookingID() {
		return bookingID;
	}

	public Date getBookingDate() {
		return bookingDate;
	}

	public int getClientID() {
		return clientID;
	}

	public int getCommitteeID() {
		return committeeID;
	}

	public int getPaymentID() {
		return paymentID;
	}

}
