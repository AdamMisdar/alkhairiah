// Voluntary inherits Committee

package alkhairiah.javabean;

public class Voluntary extends Committee {

	// Attributes
	private double hourlyRate;		// 1. Hourly rate
	private String voluntaryRole;	// 2. Role
	
	// Constructor
	public Voluntary() {
		super();
	}
	
	// Setters
	public void setHourlyRate(double hourlyRate) {
		this.hourlyRate = hourlyRate;
	}

	public void setVoluntaryRole(String voluntaryRole) {
		this.voluntaryRole = voluntaryRole;
	}
	
	// Getters
	public double getHourlyRate() {
		return hourlyRate;
	}
	
	public String getVoluntaryRole() {
		return voluntaryRole;
	}

}
