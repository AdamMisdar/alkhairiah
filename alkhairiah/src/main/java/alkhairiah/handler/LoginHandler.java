package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.connection.*;

@WebServlet("/LoginHandler")
public class LoginHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Constructor
    public LoginHandler() {
        super();
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
			
			case "login":
				login(request, response);
				break;
				
			case "logout":
				logout(request, response);
				break;
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// Log In
	private void login(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get values
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		// Create new session
		HttpSession session = request.getSession();
		
		// Create dispatcher
		RequestDispatcher toPage = null;
		
		try {
			
			// Get connection
			Connection connection = ConnectionManager.getConnection();
			
			// Prepare SQL Statements
			/* Check Client */
			PreparedStatement checkClientSQL = connection.prepareStatement
			("SELECT * FROM client WHERE clientemail = ? AND clientpassword = ?");
			
			/* Check Committee */
			PreparedStatement checkCommitteeSQL = connection.prepareStatement
			("SELECT * FROM committee WHERE committeeemail = ? AND committeepassword = ?");
			
			// Set ? values
			/* Client */
			checkClientSQL.setString(1, email);
			checkClientSQL.setString(2, password);
			
			/* Committee */
			checkCommitteeSQL.setString(1, email);
			checkCommitteeSQL.setString(2, password);
			
			// Check SQL
			/* Client */
			System.out.println(checkClientSQL);
			
			/* Committee */
			System.out.println(checkCommitteeSQL);
			
			// Execute Query
			/* Client */
			ResultSet resultClient = checkClientSQL.executeQuery();
			
			/* Committee */
			ResultSet resultCommittee = checkCommitteeSQL.executeQuery();
			
			// Logic
			boolean loginClient = false;
			boolean loginCommittee = false;
			
			if(resultClient.next()) {
				loginClient = true;
			}
			
			if(resultCommittee.next()) {
				loginCommittee = true;
			}
			
			/* If user is client */
			if(loginClient) {
				
				// Set client for this session
				session.setAttribute("clientID", resultClient.getInt(1));
				
				// Redirect to client's home page
				toPage = request.getRequestDispatcher("index-client.jsp");
				toPage.forward(request, response);
				
				// Check
				System.out.println("This user is a client.");
				
			}
			
			/* If user is committee */
			else if (loginCommittee) {
				
				// Check committee type
				String committeeType = "";
				boolean isManager = false;
				
				//Prepare SQL statements
				/* Management */
				PreparedStatement managementSQL = connection.prepareStatement("SELECT * FROM management JOIN committee USING (committeeid) WHERE committeeid = ?");
				
				/* Voluntary */
				PreparedStatement voluntarySQL = connection.prepareStatement("SELECT * FROM voluntary JOIN committee USING (committeeid) WHERE committeeid = ?");
				
				// Set ? values
				/* Management */
				managementSQL.setInt(1, resultCommittee.getInt(1));
				
				/* Voluntary */
				voluntarySQL.setInt(1, resultCommittee.getInt(1));
				
				// Execute SQL
				/* Management */
				ResultSet resultManagement = managementSQL.executeQuery();
				
				/* Voluntary */
				ResultSet resultVoluntary = voluntarySQL.executeQuery();
				
				// Check SQL
				System.out.println(managementSQL);
				System.out.println(voluntarySQL);
				
				// Filter Committee
				/* If user is Committee-Management */
				if(resultManagement.next()) {
					committeeType = "Management";
					System.out.println("Committee Type: " + committeeType);
					
					// Filter if user is manager
					if((resultManagement.getString("managementposition")).equalsIgnoreCase("Pengerusi") ||
					   (resultManagement.getString("managementposition")).equalsIgnoreCase("Naib Pengerusi")) {
						
						isManager = true;
						System.out.println("Also a manager.");
					}
				}
				
				/* If user is Committee-Voluntary */
				if(resultVoluntary.next()) {
					committeeType = "Voluntary";
					System.out.println("Committee Type: " + committeeType);
				}
				
				// Set committee for this session
				session.setAttribute("isManager", isManager);
				session.setAttribute("committeeType", committeeType);
				session.setAttribute("committeeID", resultCommittee.getInt(1));
				
				// Redirect to committee's home page
				toPage = request.getRequestDispatcher("index-committee.jsp");
				toPage.forward(request, response);
			
			}
			
			/* Not a registered user */
			else {
				
				// Set status: login failed
				request.setAttribute("status", "loginfailed");
				
				// Redirect back to login page
				toPage = request.getRequestDispatcher("login.jsp");
				toPage.forward(request, response);
				
				// Check
				System.out.println("Login failed / Not a registered user.");
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();	
		}
	}
	
	// Log Out
	private void logout(HttpServletRequest request, HttpServletResponse response) 
	throws ServletException, SQLException, IOException {
		
		// Get current session
		HttpSession session = request.getSession();
		
		// Invalidate/terminate session
		session.invalidate();
		
		// Redirect to login page
		response.sendRedirect("login.jsp");
		
	}

}
