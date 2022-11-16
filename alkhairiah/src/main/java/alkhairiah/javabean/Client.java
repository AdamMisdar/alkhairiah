package alkhairiah.javabean;

import java.sql.Date;

public class Client {
	
	// Attributes
	private int clientID;			// 1. ID (PK)
	private String clientFullName;		// 2. Full Name
	private String clientPhoneNum;	// 3. Phone Number
	private String clientAddress;	// 4. Address
	private Date clientBirthDate;	// 5. Birth Date
	private String clientEmail;		// 6. Email
	private String clientPassword;	// 7. Password
	
	// Constructor
	public Client() {
		
	}
	
	// Setters
	public void setClientID(int clientID) {
		this.clientID = clientID;
	}
	
	public void setClientFullName(String clientName) {
		this.clientFullName = clientName;
	}
	
	public void setClientPhoneNum(String clientPhoneNum) {
		this.clientPhoneNum = clientPhoneNum;
	}

	public void setClientAddress(String clientAddress) {
		this.clientAddress = clientAddress;
	}
	
	public void setClientBirthDate(Date clientBirthDate) {
		this.clientBirthDate = clientBirthDate;
	}
	
	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}
	
	public void setClientPassword(String clientPassword) {
		this.clientPassword = clientPassword;
	}
	
	// Getters
	public int getClientID() {
		return clientID;
	}

	public String getClientFullName() {
		return clientFullName;
	}

	public String getClientPhoneNum() {
		return clientPhoneNum;
	}

	public String getClientAddress() {
		return clientAddress;
	}

	public Date getClientBirthDate() {
		return clientBirthDate;
	}

	public String getClientEmail() {
		return clientEmail;
	}

	public String getClientPassword() {
		return clientPassword;
	}
	
}
