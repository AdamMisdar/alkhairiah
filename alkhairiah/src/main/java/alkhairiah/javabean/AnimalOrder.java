package alkhairiah.javabean;

public class AnimalOrder {
	
	// Attributes
	private int animalOrderID;		// 1. ID (PK)
	private String dependentName;	// 2. Dependent Name
	private int bookingID;			// 3. Booking ID (FK)
	private int animalDetailsID;	// 4. Animal Details ID (FK)
	
	// Constructor
	public AnimalOrder() {
		
	}

	// Setters
	public void setAnimalOrderID(int animalOrderID) {
		this.animalOrderID = animalOrderID;
	}
	
	public void setDependentName(String dependentName) {
		this.dependentName = dependentName;
	}
	
	public void setBookingID(int bookingID) {
		this.bookingID = bookingID;
	}
	
	public void setAnimalDetailsID(int animalDetailsID) {
		this.animalDetailsID = animalDetailsID;
	}
	
	// Getters
	public int getAnimalOrderID() {
		return animalOrderID;
	}

	public String getDependentName() {
		return dependentName;
	}

	public int getBookingID() {
		return bookingID;
	}

	public int getAnimalDetailsID() {
		return animalDetailsID;
	}
	
}
