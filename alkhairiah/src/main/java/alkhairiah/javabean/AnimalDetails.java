package alkhairiah.javabean;

public class AnimalDetails {

	// Attributes
	private int animalDetailsID;	// 1. Animal Details
	private String animalType;		// 2. Animal Type
	private double animalPrice;		// 3. Animal Price
	
	// Constructor
	public AnimalDetails() {
		
	}

	// Setters
	public void setAnimalDetailsID(int animaldetailsID) {
		this.animalDetailsID = animaldetailsID;
	}
	
	public void setAnimalType(String animalType) {
		this.animalType = animalType;
	}
	
	public void setAnimalPrice(double animalPrice) {
		this.animalPrice = animalPrice;
	}
	
	// Getters
	public int getAnimalDetailsID() {
		return animalDetailsID;
	}

	public String getAnimalType() {
		return animalType;
	}

	public double getAnimalPrice() {
		return animalPrice;
	}
	
}
