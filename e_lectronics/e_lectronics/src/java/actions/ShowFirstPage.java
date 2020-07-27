/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CustomerDAO;
import daoInterfaces.ProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
public class ShowFirstPage implements Action {

    /** Page to be used to display data */
   private String view;
   CustomerInfoBean customer;
   Vector listOfCategories;
   private Vector ProductsInView=new Vector();
   private Vector newestProducts=new Vector();
   private Vector popularProducts=new Vector();


   public ShowFirstPage(){       
   }

   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       HttpSession session=req.getSession();
       Vector current=(Vector)session.getAttribute("CurrentMenu");

       if(current==null){
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
       }
       current.add(0, "-1");
       current.add(1, "-1");
       session.setAttribute("CurrentMenu",current);

       view = "./views/ShowFirstPageView.jsp";

       DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

       if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }

      String action = req.getParameter("action");
      ProductDAO prodDAO = mysqlFactory.getProductDAO();
      try {
           newestProducts=prodDAO.getTheNewestProducts(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format( new java.util.Date()),3,"desc");
           ProductsInView.add(newestProducts);
           popularProducts=prodDAO.getTheMostPopularProducts(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format( new java.util.Date()),3,"desc");
           ProductsInView.add(popularProducts);
      } catch (SQLException ex) {
          Logger.getLogger(ShowFirstPage.class.getName()).log(Level.SEVERE, null, ex);
      }
      

      if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
          customer=new CustomerInfoBean();
          customer.setUsername(req.getParameter("un"));
          customer.setPassword(req.getParameter("pw"));
          System.out.println("un= " +req.getParameter("un"));
          
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(ShowFirstPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);
             
          }
          else{
                view = "./views/ShowWrongLoginView.jsp";
          }
      }     

      return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return ProductsInView;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}