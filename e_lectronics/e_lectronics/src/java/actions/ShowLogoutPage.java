/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CategoryDAO;
import daoInterfaces.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CustomerInfoBean;



/**
 *
 * @author Valitsa
 */
public class ShowLogoutPage implements Action {

   /** Page to be used to display data */
   private String view;
   CustomerInfoBean customer;
   Vector listOfCategories;
   Vector currentCategories;


   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowLogoutView.jsp";

        HttpSession session=req.getSession();
        session.invalidate();
        session=req.getSession();
        currentCategories=new Vector();
        currentCategories.add(0,"-1");
        currentCategories.add(1,"-1");
        
        session.setAttribute("CurrentMenu",currentCategories);
        
            
            String action = req.getParameter("action");

              if (req.getParameter("un")!=null && req.getParameter("pw")!=null){
                  System.out.println("un= " +req.getParameter("un"));
                  customer=new CustomerInfoBean();
                  customer.setUsername(req.getParameter("un"));
                  customer.setPassword(req.getParameter("pw"));

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
                        Logger.getLogger(ShowFirstPage.class.getName()).log(Level.SEVERE, null, ex);
                    }

                  /** Set the view */
                  if (customer.isValid()) {
                     session.setAttribute("CustomerInfo", customer);
                  }
                  else{
                        view = "./views/ShowWrongLoginView.jsp";
                  }
              }
            
              listOfCategories=new Vector();
              DAOFactory mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
              customer=new CustomerInfoBean();
              session.setAttribute("Customer", customer);

              CategoryDAO catDAO = mysqlFactory.getCategoryDAO();
              try {
                listOfCategories = catDAO.takeMainCategories();
                session.setAttribute("CategoriesList", listOfCategories);

            } catch (SQLException ex) {
                Logger.getLogger(InitPage.class.getName()).log(Level.SEVERE, null, ex);
            }
          

      return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return null;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}