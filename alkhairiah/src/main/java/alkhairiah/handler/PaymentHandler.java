package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.dao.*;
import alkhairiah.javabean.*;

@WebServlet("/PaymentHandler")
@MultipartConfig(maxFileSize = 5000000) // 5MB
public class PaymentHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// DAO object
	PaymentDAO paymentDAO;
	
	// Variables
	HttpSession session;
	RequestDispatcher toPage;
	String UPLOAD_DIRECTORY = "images" + File.separator + "tempAddFiles" + File.separator;

	// Constructor
    public PaymentHandler() {
        super();
        paymentDAO = new PaymentDAO();
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
			
			switch (action) {
			
			// ADD
			case "addPayment":
				addPayment(request, response);
				break;
			
			// Others
			case "getApplicationPath":
				getAppPath(request, response);
				break;
			}
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// ADD Payment
	private void addPayment(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		double paymentTotal = Double.parseDouble(request.getParameter("paymentTotal"));
		Part paymentReceipt = request.getPart("paymentReceipt");
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		long todayMillis = System.currentTimeMillis();
		Date paymentDate = new Date(todayMillis);
		
		// Get submitted file name
		String paymentReceiptName = paymentReceipt.getSubmittedFileName();
		
		// Get application path
		String appPath = (String) session.getAttribute("appPath");
		System.out.println("App Path: " + appPath);
		
		// Create image path
		String uploadPath = appPath + UPLOAD_DIRECTORY + "BookingID" + bookingID;
		System.out.println("Upload directory: " + uploadPath);
		
		// Create new file
		File fileUploadDirectory = new File(uploadPath);
		
		// Check if file upload directory exists
		/* If file directory doesn't exist */
		if(!fileUploadDirectory.exists()) {
			
			// Create the directory
			fileUploadDirectory.mkdirs();
			System.out.println("Directory added.\n - - - ");
			
		} 
		
		/* If file directory already exist */
		else {
			System.out.println("Directory exists.\n - - - ");
		}
		
		// Create the submitted file path
		String paymentReceiptFile = uploadPath + File.separator + paymentReceiptName;
		System.out.println("Submitted File Path: " + paymentReceiptFile);
		
		// Write the image in the file upload directory
		paymentReceipt.write(paymentReceiptFile + File.separator);
		
		// Create new Payment object
		Payment newPayment = new Payment();
		newPayment.setPaymentTotal(paymentTotal);
		newPayment.setPaymentDate(paymentDate);
		newPayment.setPaymentReceiptFile(paymentReceiptFile);
		newPayment.setPaymentReceiptName(paymentReceiptName);
		newPayment.setBookingID(bookingID);
		
		// Send to DAO
		paymentDAO.addPayment(newPayment);
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("booking-list-client.jsp");
		toPage.forward(request, response);
		
	}
	
	/* Others */
	
	// Application Path Getter
	private void getAppPath(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
	
		// Create temporary Application Path for image storing in server
		String appPath = getServletContext().getRealPath("");
		System.out.println("App Path: " + appPath + "\n - - - ");
		
		// Get session
		session = request.getSession();
		
		// Set attributes for Application Path and others
		session.setAttribute("appPath", appPath);
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("login.jsp");
		toPage.forward(request, response);
	}

}
