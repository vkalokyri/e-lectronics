/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.*;

/**
 *
 * @author Valitsa
 */
public class ShowConfirmChangesPage implements Action {

    /** Page to be used to display data */
   /** Page to be used to display data */
    private String view;

     /** JavaBean used to represent a person */
    CustomerInfoBean cust;

    /**
    * Creates a new instance of ShowPersonInfo
    * No-arg constructor used to initialize the JavaBeans
    */
    public ShowConfirmChangesPage() {
        cust = new CustomerInfoBean();
    }

    /**
    * Execute business logic
    * Retrieves general info and populates the JavaBean
    */
    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

      HttpSession session=req.getSession();
      /** Retrieve parameters to perform action */
      String action = req.getParameter("action");
      cust.setUsername(((CustomerInfoBean)session.getAttribute("CustomerInfo")).getUsername());
      if (!req.getParameter("password").equals("")){
        cust.setPassword(req.getParameter("password"));
      }else{
          cust.setPassword(((CustomerInfoBean)session.getAttribute("CustomerInfo")).getPassword());
      }
      cust.setEmail(req.getParameter("email"));
      cust.setFirstname(req.getParameter("firstname"));
      cust.setLastname(req.getParameter("lastname"));
      cust.setAddress(req.getParameter("street"));
      cust.setCity(req.getParameter("city"));
      cust.setPostalCode(req.getParameter("zip"));
      cust.setPhone(req.getParameter("phone"));
      cust.setMobilePhone(req.getParameter("mobile"));

      DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

       if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }
        // Create a DAO
      CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
        try {
            cust = custDAO.updateCustomer(cust);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmChangesPage.class.getName()).log(Level.SEVERE, null, ex);
        }

      /** Set the view */
     
      if (action != null && action.equals("showConfirmChangesPage") && cust.isValid()) {
          view = "./views/ShowConfirmChangesView.jsp";
          cust.setIsAdmin(((CustomerInfoBean)session.getAttribute("CustomerInfo")).getIsAdmin());
          session.setAttribute("CustomerInfo", cust);
      }
      else if (action != null && action.equals("showConfirmChangesPage") && !cust.isValid()){
          view = "./views/ShowProfileView.jsp";
      }

      return true;
    }

    /** Return the page name (and path) to display the view */
    public Object getModel() {
        return cust;
    }

     /** Return the page name (and path) to display the view */
    public String getView() {
        return view;
    }

}
