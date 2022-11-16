package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.dao.*;
import alkhairiah.javabean.*;

@WebServlet("/AnimalOrderHandler")
public class AnimalOrderHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// DAO object
	private AnimalOrderDAO animalOrderDAO;
	private BookingDAO bookingDAO;
	
	// Variables
	HttpSession session;
	RequestDispatcher toPage;
	boolean isCommittee = false; /* Determines if user is committee */

	// Constructor
    public AnimalOrderHandler() {
        super();
        animalOrderDAO = new AnimalOrderDAO();
        bookingDAO = new BookingDAO();
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
		
		// Filter action
		try {
			
			switch(action) {
			
			// ADD
			case "addAnimalOrder":
				addAnimalOrder(request, response);
				break;
			
			// UPDATE
			case "updateAnimalOrderCommittee":
				isCommittee = true;
				
			case "updateAnimalOrder":
				updateAnimalOrder(request, response);
				break;
			
			// VIEW
			case "editAnimalOrderCommittee":
				isCommittee = true;
				
			case "editAnimalOrder":
				editAnimalOrder(request, response);
				break;
				
			// DELETE
			case "deleteAnimalOrder":
				deleteAnimalOrder(request, response);
				break;
				
			// Other (Used)
			case "cancelUpdateCommittee":
				isCommittee = true;
				
			case "cancelUpdate":
				cancelUpdate(request, response);
				break;
				
			}	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// ADD Animal Order
	private void addAnimalOrder(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		String dependentName = request.getParameter("dependentName");
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		int animalDetailsID = Integer.parseInt(request.getParameter("animalDetailsID"));
		
		// Create new Animal Order object
		AnimalOrder newAnimalOrder = new AnimalOrder();
		newAnimalOrder.setDependentName(dependentName);
		newAnimalOrder.setBookingID(bookingID);
		newAnimalOrder.setAnimalDetailsID(animalDetailsID);
		
		// Send to DAO
		animalOrderDAO.addAnimalOrder(newAnimalOrder);
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		
		// Redirect to Booking Handler to Add Animal Order	
		toPage = request.getRequestDispatcher("create-booking.jsp");
		toPage.forward(request, response);
		
	}
	
	// VIEW Animal Order
	private void editAnimalOrder(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
	
		// Get values from JSP
		int animalOrderID = Integer.parseInt(request.getParameter("animalOrderID"));
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		String nextPage = request.getParameter("nextPage"); System.out.println("Next Page: " + nextPage);
		
		// Set attribute
		request.setAttribute("animalOrderID", animalOrderID);
		request.setAttribute("bookingID", bookingID);
		request.setAttribute("nextPage", nextPage);
		
		// Filter user
		/* If user is committee */
		if (isCommittee) {
			
			// Get session
			session = request.getSession();
			
			// Get extra values
			int committeeID = (int)session.getAttribute("committeeID");
			
			// Create new Booking object
			Booking existingBooking = new Booking();
			existingBooking.setBookingID(bookingID);
			existingBooking.setCommitteeID(committeeID);
			
			// Update committeeID in booking using DAO
			bookingDAO.updateBooking(existingBooking);
			
			// Check
			System.out.println("Committee ID has been updated in Booking ID " + bookingID);
			
			// Redirect to JSP
			toPage = request.getRequestDispatcher("edit-animal-order-management.jsp");
			toPage.forward(request, response);
			
		}
		
		/* If user is client */
		else {
			
			// Redirect to JSP
			toPage = request.getRequestDispatcher("edit-animal-order-client.jsp");
			toPage.forward(request, response);
		}
		
	}
	
	// UPDATE Animal Order
	private void updateAnimalOrder(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
	
		// Get values
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		String dependentName = request.getParameter("dependentName");
		int animalOrderID = Integer.parseInt(request.getParameter("animalOrderID"));
		String nextPage = request.getParameter("nextPage");
		
		// Create new Animal Order object
		AnimalOrder existingAnimalOrder = new AnimalOrder();
		existingAnimalOrder.setDependentName(dependentName);
		existingAnimalOrder.setAnimalOrderID(animalOrderID);
		
		// Send to DAO
		animalOrderDAO.updateAnimalOrder(existingAnimalOrder);
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		
		// Filter user
		/* If user is committee */
		if(isCommittee) {
			
			// Get extra values
			int committeeID = (int)session.getAttribute("committeeID");
			
			// Create new Booking object
			Booking existingBooking = new Booking();
			existingBooking.setBookingID(bookingID);
			existingBooking.setCommitteeID(committeeID);
			
			// Update committeeID in booking using DAO
			bookingDAO.updateBooking(existingBooking);
			
			// Redirect to JSP
			if(nextPage.equalsIgnoreCase("viewBookingManagement"))
				toPage = request.getRequestDispatcher("view-booking-management.jsp");
			
			toPage.forward(request, response);
			
		}
		
		/* If user is client*/
		else {
			// Redirect to JSP
			if(nextPage.equalsIgnoreCase("createBooking")) 
				toPage = request.getRequestDispatcher("create-booking.jsp");
			
			else if(nextPage.equalsIgnoreCase("viewBooking")) 
				toPage = request.getRequestDispatcher("view-booking-client.jsp");
			
			toPage.forward(request, response);
		}
		
	}
	
	// DELETE Animal Order
	private void deleteAnimalOrder(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
	
		// Get values from JSP
		int animalOrderID = Integer.parseInt(request.getParameter("animalOrderID")); System.out.println("AnimalOrderID received: " + animalOrderID);
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Send to DAO
		animalOrderDAO.deleteAnimalOrder(animalOrderID);
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("create-booking.jsp");
		toPage.forward(request, response);
		
	}
	
	/* Others*/
	
	// Cancel Update
	private void cancelUpdate(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		String nextPage = request.getParameter("nextPage");
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		
		// Filter user
		/* If user is committee */
		if (isCommittee) {
			
			// Redirect to JSP 
			if(nextPage.equalsIgnoreCase("viewBookingManagement"))
				toPage = request.getRequestDispatcher("view-booking-management.jsp");
		}
		
		/* If user is client*/
		else {
			
			// Redirect to JSP
			if(nextPage.equalsIgnoreCase("createBooking"))
				toPage = request.getRequestDispatcher("create-booking.jsp");
			
			else if(nextPage.equalsIgnoreCase("viewBooking")) // KIV
				toPage = request.getRequestDispatcher("view-booking-client.jsp");
		}
		
		toPage.forward(request, response);
	}
}
