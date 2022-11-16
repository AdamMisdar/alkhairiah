package alkhairiah.handler;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import alkhairiah.dao.*;
import alkhairiah.javabean.*;

@WebServlet("/CommitteeHandler")
public class CommitteeHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	// DAO object
	private CommitteeManagementDAO managementDAO;
	private CommitteeVoluntaryDAO voluntaryDAO;
	
	// Variables
	HttpSession session;
	RequestDispatcher toPage;
	boolean managerEdit = false; // Manager is the one editing a person's account
	boolean accountEdit = false; // Ordinary Committee is the one editing their account
	
	// Constructor
    public CommitteeHandler() {
        super();
        managementDAO = new CommitteeManagementDAO();
        voluntaryDAO = new CommitteeVoluntaryDAO();
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
		String action = request.getParameter("action"); System.out.println(action);;
		
		// Filter action
		try {
			
			switch(action) {
			
			// CREATE
			case "createCommittee":
				createCommittee(request, response);
				break;
				
			// UPDATE
			case "updateCommitteeManager":
				managerEdit = true;
				
			case "updateCommittee":
				updateCommittee(request, response);
				break;
				
			// DELETE
			case "deleteCommittee":
				deleteCommittee(request, response);
				break;
			
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// OTHER METHODS -------------------------------------------------------------------------------
	
	// CREATE 
	private void createCommittee(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		String comType = request.getParameter("comType");
		System.out.println(comType);
		
		// Filter Committee type
		/* Management */
		if(comType.equalsIgnoreCase("management")) {
			
			// Get values from JSP
			String committeeFullName = request.getParameter("committeeFullName");
			String committeePhoneNum = request.getParameter("committeePhoneNum");
			Date committeeBirthDate = Date.valueOf(request.getParameter("committeeBirthDate"));
			String committeeAddress = request.getParameter("committeeAddress");
			String committeeEmail = request.getParameter("committeeEmail");
			String committeePassword = request.getParameter("committeePassword");
			int managerID = Integer.parseInt(request.getParameter("managerID"));
			String managementPosition = request.getParameter("managementPosition");
			
			// Create new Committee object
			Management newManagement = new Management();
			newManagement.setCommitteeFullName(committeeFullName);
			newManagement.setCommitteePhoneNum(committeePhoneNum);
			newManagement.setCommitteeBirthDate(committeeBirthDate);
			newManagement.setCommitteeAddress(committeeAddress);
			newManagement.setCommitteeEmail(committeeEmail);
			newManagement.setCommitteePassword(committeePassword);
			newManagement.setManagerID(managerID);
			newManagement.setManagementPosition(managementPosition);
			
			// Send to DAO
			managementDAO.createManagement(newManagement);
			
		}
		
		/* Voluntary */
		else if (comType.equalsIgnoreCase("voluntary")) {
			
			// Get values from JSP			
			String committeeFullName = request.getParameter("committeeFullName");
			String committeePhoneNum = request.getParameter("committeePhoneNum");
			Date committeeBirthDate = Date.valueOf(request.getParameter("committeeBirthDate"));
			String committeeAddress = request.getParameter("committeeAddress");
			String committeeEmail = request.getParameter("committeeEmail");
			String committeePassword = request.getParameter("committeePassword");
			int managerID = Integer.parseInt(request.getParameter("managerID"));
			String voluntaryRole = request.getParameter("voluntaryRole");
			double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
			
			// Create new Committee object
			Voluntary newVoluntary = new Voluntary();
			newVoluntary.setCommitteeFullName(committeeFullName);
			newVoluntary.setCommitteePhoneNum(committeePhoneNum);
			newVoluntary.setCommitteeBirthDate(committeeBirthDate);
			newVoluntary.setCommitteeAddress(committeeAddress);
			newVoluntary.setCommitteeEmail(committeeEmail);
			newVoluntary.setCommitteePassword(committeePassword);
			newVoluntary.setManagerID(managerID);
			newVoluntary.setVoluntaryRole(voluntaryRole);
			newVoluntary.setHourlyRate(hourlyRate);
			
			// Send to DAO
			voluntaryDAO.createVoluntary(newVoluntary);
			
		}
		
		// Redirect to JSP
		toPage = request.getRequestDispatcher("committee-list.jsp");
		toPage.forward(request, response);
		
	}
	
	// UPDATE
	private void updateCommittee(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
		
		// Get session
		session = request.getSession();
		
		// Get basic values from JSP
		String committeeType = (String)session.getAttribute("committeeType");
		int committeeID = Integer.parseInt(request.getParameter("committeeID"));
		String committeeFullName = request.getParameter("committeeFullName");
		String committeePhoneNum = request.getParameter("committeePhoneNum");
		Date committeeBirthDate = Date.valueOf(request.getParameter("committeeBirthDate"));
		String committeeAddress = request.getParameter("committeeAddress");
		String committeeEmail = request.getParameter("committeeEmail");
		String committeePassword = request.getParameter("committeePassword");
		
		/* Management */
		if(committeeType.equalsIgnoreCase("Management")) {
			
			// Create new Management object
			Management existingManagement = new Management();
			existingManagement.setCommitteeID(committeeID);
			existingManagement.setCommitteeFullName(committeeFullName);
			existingManagement.setCommitteePhoneNum(committeePhoneNum);
			existingManagement.setCommitteeBirthDate(committeeBirthDate);
			existingManagement.setCommitteeAddress(committeeAddress);
			existingManagement.setCommitteeEmail(committeeEmail);
			existingManagement.setCommitteePassword(committeePassword);
			
			if(managerEdit) {
				
				// Get extra values from JSP
				String managementPosition = request.getParameter("managementPosition");
				int managerID = Integer.parseInt(request.getParameter("managerID"));
				
				// Add values
				existingManagement.setManagementPosition(managementPosition);
				existingManagement.setManagerID(managerID);
				
			}
			
			// Send to DAO
			managementDAO.updateManagement(existingManagement, managerEdit); // managerEdit is false
			
		/* Voluntary */
		} else if(committeeType.equalsIgnoreCase("Voluntary")) {
			
			// Create new Voluntary object
			Voluntary existingVoluntary = new Voluntary();
			existingVoluntary.setCommitteeID(committeeID);
			existingVoluntary.setCommitteeFullName(committeeFullName);
			existingVoluntary.setCommitteePhoneNum(committeePhoneNum);
			existingVoluntary.setCommitteeBirthDate(committeeBirthDate);
			existingVoluntary.setCommitteeAddress(committeeAddress);
			existingVoluntary.setCommitteeEmail(committeeEmail);
			existingVoluntary.setCommitteePassword(committeePassword);
			
			if(managerEdit) {
				
				// Get extra values from JSP
				String voluntaryRole = request.getParameter("voluntaryRole");
				double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
				int managerID = Integer.parseInt(request.getParameter("managerID"));
				
				// Add values
				existingVoluntary.setVoluntaryRole(voluntaryRole);
				existingVoluntary.setHourlyRate(hourlyRate);
				existingVoluntary.setManagerID(managerID);
				
			}

			// Send to DAO
			voluntaryDAO.updateVoluntary(existingVoluntary, managerEdit); // managerEdit is false
			
		}
		
		// Redirect to JSP
		if(managerEdit) {
			toPage = request.getRequestDispatcher("view-committee-account-manager.jsp");
			toPage.forward(request, response);
		}
		else {
			toPage = request.getRequestDispatcher("view-committee-account.jsp");
			toPage.forward(request, response);
		}
	}
	
	// DELETE
	private void deleteCommittee(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, SQLException, IOException {
				
		// Get values from JSP
		int committeeID = Integer.parseInt(request.getParameter("previewCommitteeID"));
		String committeeType = request.getParameter("previewCommitteeType");
				
		// Filter committee type & Send to DAO
		if(committeeType.equalsIgnoreCase("Management")) 
			managementDAO.deleteManagement(committeeID);
				
		else if(committeeType.equalsIgnoreCase("Voluntary"))
			voluntaryDAO.deleteVoluntary(committeeID);;
				
		// Redirect to JSP
		response.sendRedirect("committee-list.jsp");
	}

}
