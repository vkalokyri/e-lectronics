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
public class ShowMakeOrderPage implements Action {

     /** Page to be used to display data */
   private String view;

   private CustomerInfoBean customer;

   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       view = "./views/ShowMakeOrderView.jsp";

       HttpSession session=req.getSession();
       customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");

       
       String action = req.getParameter("action");

       if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
          customer=new CustomerInfoBean();
          customer.setUsername(req.getParameter("un"));
          customer.setPassword(req.getParameter("pw"));
          System.out.println("un= " +req.getParameter("un"));
          DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

           if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
           }
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(ShowMakeOrderPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);

          }
          else{
             view = "./views/ShowWrongLoginView.jsp";
          }
       }


       if(customer==null){
           view = "./views/ShowUnregisterView.jsp";
       }

      return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return customer;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}