package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.dao.*;
import alkhairiah.javabean.*;

@WebServlet("/ClientHandler")
public class ClientHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// DAO object
	private ClientDAO clientDAO;
	
	// Variables
	HttpSession session;
	RequestDispatcher toPage;
	boolean isCommittee = false; /* Determines if user is committee */
	
	// Constructor
    public ClientHandler() {
        super();
        clientDAO = new ClientDAO();
    }

    // doGet Method
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	// doPost Method
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// set content type
		response.setContentType("text/html");
		
		// Get action
		String action = request.getParameter("action");
		
		// Filter action
		try {
			
			switch(action) {
			
			// CREATE
			case "createClient":
				createClient(request, response);
				break;
	
			// UPDATE		
			case "updateClientCom":
				isCommittee = true;
				
			case "updateClient":
				updateClient(request, response);
				break;

			// DELETE
			case "deleteClient":
				deleteClient(request, response);
				break;
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// CREATE Client Account
	private void createClient(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		String clientFullName = request.getParameter("clientFullName"); System.out.println(clientFullName);
		String clientAddress = request.getParameter("clientAddress"); System.out.println(clientAddress);
		String clientPhoneNum = request.getParameter("clientPhoneNum"); System.out.println(clientPhoneNum);
		Date clientBirthDate = Date.valueOf(request.getParameter("clientBirthDate")); System.out.println(clientBirthDate);
		String clientEmail = request.getParameter("clientEmail"); System.out.println(clientEmail);
		String clientPassword = request.getParameter("clientPassword"); System.out.println(clientPassword);
		
		// Create new Client object
		Client newClient = new Client();
		newClient.setClientFullName(clientFullName);
		newClient.setClientAddress(clientAddress);
		newClient.setClientPhoneNum(clientPhoneNum);
		newClient.setClientBirthDate(clientBirthDate);
		newClient.setClientEmail(clientEmail);
		newClient.setClientPassword(clientPassword);
		
		// Send to DAO
		clientDAO.createClient(newClient);
		
		// Redirect to JSP
		response.sendRedirect("login.jsp");
		
	}
	
	// UPDATE Client Account
	private void updateClient(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int clientID = Integer.parseInt(request.getParameter("clientID"));
		String clientFullName = request.getParameter("clientFullName");
		String clientAddress = request.getParameter("clientAddress");
		String clientPhoneNum = request.getParameter("clientPhoneNum");
		Date clientBirthDate = Date.valueOf(request.getParameter("clientBirthDate"));
		String clientEmail = request.getParameter("clientEmail");
		String clientPassword = request.getParameter("clientPassword");
		
		// Create new Client object
		Client existingClient = new Client();
		existingClient.setClientID(clientID);
		existingClient.setClientFullName(clientFullName);
		existingClient.setClientAddress(clientAddress);
		existingClient.setClientPhoneNum(clientPhoneNum);
		existingClient.setClientBirthDate(clientBirthDate);
		existingClient.setClientEmail(clientEmail);
		existingClient.setClientPassword(clientPassword);
		
		// Send to DAO
		clientDAO.updateClientDetails(existingClient);
		
		// Redirect to JSP
		/* If user is committee */
		if(isCommittee) {
			
			if(request.getParameter("nextPage").equalsIgnoreCase("viewAccount")) {
				
				request.setAttribute("clientID", clientID);
				
				toPage = request.getRequestDispatcher("view-client-account-management.jsp");
				toPage.forward(request, response);
			}
				
			else
				response.sendRedirect("client-list.jsp");
		}
		
		/* If user is client */
		else {
			response.sendRedirect("view-client-account.jsp");
		}
		
	}
	
	// DELETE Client Account
	private void deleteClient(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int clientID = Integer.parseInt(request.getParameter("clientID"));
		
		// Send to DAO
		clientDAO.deleteClient(clientID);
		
		// Redirect to JSP
		response.sendRedirect("client-list.jsp");
		
	}

}
