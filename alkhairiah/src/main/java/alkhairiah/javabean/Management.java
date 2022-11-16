// Management inherits Committee

package alkhairiah.javabean;

public class Management extends Committee {

	// Attributes
	private String managementPosition;	// 1. Job Position
	
	// Constructor
	public Management() {
		super();
	}

	// Setters
	public void setManagementPosition(String managementPosition) {
		this.managementPosition = managementPosition;
	}

	// Getters
	public String getManagementPosition() {
		return managementPosition;
	}
	
}
