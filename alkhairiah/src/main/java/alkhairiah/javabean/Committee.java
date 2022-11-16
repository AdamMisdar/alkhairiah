package alkhairiah.javabean;

import java.sql.Date;

public class Committee {
	
	// Attributes
	private int committeeID;			// 1. ID (PK)
	private String committeeFullName;	// 2. Full Name
	private String committeePhoneNum;	// 3. Phone Number
	private String committeeAddress;	// 4. Address
	private Date committeeBirthDate;	// 5. Birth Date
	private String committeeEmail;		// 6. Email
	private String committeePassword;	// 7. Password
	private int managerID;				// 8. Manager ID (FK)
	
	// Constructor
	public Committee() {
		
	}
	
	// Setters
	public void setCommitteeID(int committeeID) {
		this.committeeID = committeeID;
	}
	
	public void setCommitteeFullName(String committeeName) {
		this.committeeFullName = committeeName;
	}
	
	public void setCommitteePhoneNum(String committeePhoneNum) {
		this.committeePhoneNum = committeePhoneNum;
	}
	
	public void setCommitteeAddress(String committeeAddress) {
		this.committeeAddress = committeeAddress;
	}
	
	public void setCommitteeBirthDate(Date committeeBirthDate) {
		this.committeeBirthDate = committeeBirthDate;
	}
	
	public void setCommitteeEmail(String committeeEmail) {
		this.committeeEmail = committeeEmail;
	}
	
	public void setCommitteePassword(String committeePassword) {
		this.committeePassword = committeePassword;
	}
	
	public void setManagerID(int managerID) {
		this.managerID = managerID;
	}
	
	// Getters
	public int getCommitteeID() {
		return committeeID;
	}

	public String getCommitteeFullName() {
		return committeeFullName;
	}

	public String getCommitteePhoneNum() {
		return committeePhoneNum;
	}

	public String getCommitteeAddress() {
		return committeeAddress;
	}

	public Date getCommitteeBirthDate() {
		return committeeBirthDate;
	}

	public String getCommitteeEmail() {
		return committeeEmail;
	}

	public String getCommitteePassword() {
		return committeePassword;
	}

	public int getManagerID() {
		return managerID;
	}
	
}
