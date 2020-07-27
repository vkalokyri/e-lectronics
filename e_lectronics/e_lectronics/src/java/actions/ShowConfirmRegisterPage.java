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
public class ShowConfirmRegisterPage implements Action {

    /** Page to be used to display data */
   /** Page to be used to display data */
    private String view;

     /** JavaBean used to represent a person */
    CustomerInfoBean cust;

    /**
    * Creates a new instance of ShowPersonInfo
    * No-arg constructor used to initialize the JavaBeans
    */
    public ShowConfirmRegisterPage() {
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
      cust.setUsername(req.getParameter("username"));
      cust.setPassword(req.getParameter("password"));
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

      if(session.getAttribute("CustomerInfo")!=null){
          if(((CustomerInfoBean)session.getAttribute("CustomerInfo")).getIsAdmin()){
                try {
                    cust = custDAO.insertCustomer(cust,1);
                } catch (SQLException ex) {
                  Logger.getLogger(ShowConfirmRegisterPage.class.getName()).log(Level.SEVERE, null, ex);
                }
          }

          if (action != null && action.equals("showConfirmRegisterPage") && cust.isValid() && !cust.getExistEmail() ) {
             view = "./views/ConfirmRegistrationView.jsp";
             return true;
          }else if(action != null && action.equals("showConfirmRegisterPage") && (!cust.isValid() || cust.getExistEmail() )){
              view = "./views/ShowRegisterView.jsp";
              return true;
          }


      }else{
          try {
            cust = custDAO.insertCustomer(cust,0);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmRegisterPage.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (action != null && action.equals("showConfirmRegisterPage") && cust.isValid() && !cust.getExistEmail()) {
            view = "./views/ConfirmRegistrationView.jsp";
            session.setAttribute("CustomerInfo", cust);
        }
        else if (action != null && action.equals("showConfirmRegisterPage") && (!cust.isValid() || cust.getExistEmail() )){
            view = "./views/ShowRegisterView.jsp";
        }

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
