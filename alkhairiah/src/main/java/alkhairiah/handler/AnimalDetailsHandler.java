package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.dao.*;
import alkhairiah.javabean.*;

@WebServlet("/AnimalDetailsHandler")
public class AnimalDetailsHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// DAO object
	private AnimalDetailsDAO animalDetailsDAO;
      
	// Constructor
    public AnimalDetailsHandler() {
        super();
        animalDetailsDAO = new AnimalDetailsDAO();
    }

    // doGet Method
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	// doPost Method
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Set content type
		response.setContentType("text/html");
		
		// Get action
		String action = request.getParameter("action");
		System.out.println(action);
		
		// Filter action
		try {
			
			switch(action) {
			
			// CREATE
			case "createAnimalDetails":
				createAnimalDetails(request, response);
				break;
			
			// UPDATE
			case "updateAnimalDetails":
				updateAnimalDetails(request, response);
				break;
			
			// DELETE
			case "deleteAnimalDetails":
				deleteAnimalDetails(request, response);
				break;
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// CREATE Animal Details
	private void createAnimalDetails(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		String animalType = request.getParameter("animalType");
		double animalPrice = Double.parseDouble(request.getParameter("animalPrice"));
		
		// Create new AnimalDetails object
		AnimalDetails newAnimal = new AnimalDetails();
		newAnimal.setAnimalType(animalType);
		newAnimal.setAnimalPrice(animalPrice);
		
		// Send to DAO
		animalDetailsDAO.createAnimalDetails(newAnimal);
		
		// Redirect back to JSP
		response.sendRedirect("animal-details-list.jsp");
		
	}
	
	// UPDATE Animal Details
	private void updateAnimalDetails(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int animalDetailsID = Integer.parseInt(request.getParameter("animalDetailsID"));
		String animalType = request.getParameter("animalType");
		double animalPrice =  Double.parseDouble(request.getParameter("animalPrice"));
		
		// Create AnimalDetails object
		AnimalDetails existingAnimal = new AnimalDetails();
		existingAnimal.setAnimalDetailsID(animalDetailsID);
		existingAnimal.setAnimalPrice(animalPrice);
		existingAnimal.setAnimalType(animalType);
		
		// Send to DAO
		animalDetailsDAO.updateAnimalDetails(existingAnimal);
		
		// Redirect to JSP
		response.sendRedirect("animal-details-list.jsp");
				
	}
	
	// DELETE Animal Details
	private void deleteAnimalDetails(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int animalDetailsID = Integer.parseInt(request.getParameter("animalDetailsID"));
		
		// Send to DAO
		animalDetailsDAO.deleteAnimalDetails(animalDetailsID);
		
		// Redirect back to JSP
		response.sendRedirect("animal-details-list.jsp");
						
	}

}
