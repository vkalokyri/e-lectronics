/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CustomerDAO;
import daoInterfaces.OrderDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CustomerInfoBean;
import model.OrderInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowSpecificOrderPage implements Action {

   private String view;

   private CustomerInfoBean customer;
   private OrderInfoBean order=new OrderInfoBean();

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       view = "./views/ShowSpecificOrderView.jsp";

       int order_id=Integer.parseInt(req.getParameter("oid"));

       HttpSession session=req.getSession();
       customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");

       if(customer!=null){
            order.setCustomer(customer);
            DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

            if(mysqlFactory==null){
                  mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
                  session.setAttribute("daoFactory", mysqlFactory);
             }
             // Create a DAO
            OrderDAO orderDao = mysqlFactory.getOrderDAO();
            try {
                order=orderDao.findProductsOrderedByOrder(order_id);
            } catch (SQLException ex) {
                Logger.getLogger(ShowMyOrdersPage.class.getName()).log(Level.SEVERE, null, ex);
            }

       }

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
                Logger.getLogger(ShowSpecificOrderPage.class.getName()).log(Level.SEVERE, null, ex);
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
       return order;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}
