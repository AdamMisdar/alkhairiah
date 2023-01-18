package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.dao.*;
import alkhairiah.javabean.*;

@WebServlet("/BookingHandler")
public class BookingHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// DAO object
	private BookingDAO bookingDAO;
	
	// Variables
	HttpSession session;
	RequestDispatcher toPage;
	boolean isCommittee = false; /* Determines if user is committee */
      
	// Constructor
    public BookingHandler() {
        super();
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
			
			// CREATE
			case "createBooking":
				createBooking(request, response);
				break;

			// VIEW (through booking list)
			case "viewBookingCommittee":
				isCommittee = true;
				
			case "viewBooking":
				viewBooking(request, response);
				break;
				
			// DELETE
			case "deleteBooking":
				deleteBooking(request, response);
				break;	
				
			// Others
			case "cancelBooking":
				cancelBooking(request, response);
				break;
			
			case "toPayment":
				toPayment(request, response);
				break;
				
			case "toBooking":
				toBooking(request, response);
				break;
				
			case "toBookingList":
				toBookingList(request, response);
				break;
				
			case "toInvoice":
				toInvoice(request, response);
				break;
			
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// CREATE Booking
	private void createBooking(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get session
		session = request.getSession();
		
		// Get values from JSP
		int clientID = (int)session.getAttribute("clientID");
		
		long todayMillis = System.currentTimeMillis();
		Date bookingDate = new Date(todayMillis);
		
		// Create new Booking object
		Booking newBooking = new Booking();
		newBooking.setBookingDate(bookingDate);
		newBooking.setClientID(clientID);
		
		// Send to DAO and retrieve Booking ID
		int bookingID = bookingDAO.createBooking(newBooking);
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
				
		// Redirect to JSP
		toPage = request.getRequestDispatcher("create-booking.jsp");
		toPage.forward(request, response);
		
	}
	
	// VIEW Booking
	private void viewBooking(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		
		// Filter user
		/* If user is committee */
		if(isCommittee) {
			
			// Get extra attributes
			session = request.getSession();
			int committeeID = (int)session.getAttribute("committeeID");
			
			// Create new Booking object
			Booking existingBooking = new Booking();
			existingBooking.setBookingID(bookingID);
			existingBooking.setCommitteeID(committeeID);
			
			// Update committee ID in booking using DAO
			bookingDAO.updateBooking(existingBooking);
			
			// Set attributes
			request.setAttribute("bookingID", bookingID);

			
			// Redirect to JSP
			toPage = request.getRequestDispatcher("view-booking-management.jsp");
			toPage.forward(request, response);
			
		}
		
		/* If user is client */
		else {
			
			// Redirect to JSP
			toPage = request.getRequestDispatcher("view-booking-client.jsp");
			toPage.forward(request, response);
			
		}
	}
	
	// DELETE Booking (Committee Deletes Booking)
	private void deleteBooking(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Send to DAO
		bookingDAO.deleteBooking(bookingID);
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("booking-list-management.jsp");
		toPage.forward(request, response);
	}
	
	/* Others */
	
	// Cancel Booking (Client Cancels Booking (explicit/implicitly))
	private void cancelBooking(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Send to DAO (Delete Booking when cancel)
		bookingDAO.deleteBooking(bookingID);
		
		// Filter page to redirect
		String nextPage = request.getParameter("redirect");
		System.out.println("NextPage: " + nextPage);
		
		// Path
		if (nextPage.equalsIgnoreCase("logout")) {
			 toPage = request.getRequestDispatcher("LoginHandler?action=logout");
		}
		else {
			toPage = request.getRequestDispatcher(nextPage);
		}
		toPage.forward(request, response);
		
	}
	
	// Redirect To Payment
	private void toPayment(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		double paymentTotal = Double.parseDouble(request.getParameter("paymentTotal"));
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		request.setAttribute("paymentTotal", paymentTotal);
		
		// Redirect to get Application Path
		toPage = request.getRequestDispatcher("make-payment.jsp");
		toPage.forward(request, response);
		
	}
	
	// ------------------------------------------------------------------------------ TO BE INVESTIGATED
	
	// Redirect To Invoice
	private void toInvoice(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		double paymentTotal = Double.parseDouble(request.getParameter("paymentTotal"));
				
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		request.setAttribute("paymentTotal", paymentTotal);
				
		// Redirect to JSP
		toPage = request.getRequestDispatcher("invoice.jsp");
		toPage.forward(request, response);
		
	}
	
	// Redirect To Booking Page
	private void toBooking(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Set attribute before redirect
		request.setAttribute("bookingID", bookingID);
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("create-booking.jsp");
		toPage.forward(request, response);
		
	}
	
	// Redirect To Booking List
	private void toBookingList(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("client-booking-list.jsp");
		toPage.forward(request, response);
		
	}

}
