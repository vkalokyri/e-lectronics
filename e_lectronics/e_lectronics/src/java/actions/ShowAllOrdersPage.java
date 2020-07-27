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
import java.util.Vector;
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
public class ShowAllOrdersPage implements Action {

    private String view;

   private CustomerInfoBean customer;
   private OrderInfoBean order=new OrderInfoBean();
   private Vector listOfOrders=new Vector();

   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       view = "./views/ShowAllOrdersView.jsp";

       HttpSession session=req.getSession();
       String action = req.getParameter("action");


       if (req.getParameter("payment")!=null){
           if(Integer.parseInt(req.getParameter("payment"))==0){
              order.setPaymentType("Πιστωτική Κάρτα");
          }else if (Integer.parseInt(req.getParameter("payment"))==1){
              order.setPaymentType("Αντικαταβολή");
          }else{
              order.setPaymentType("All");
          }
       }

       if (req.getParameter("orderStatus")!=null){
           if(Integer.parseInt(req.getParameter("orderStatus"))==0){
              order.setStatus("Εκκρεμής");
          }else if (Integer.parseInt(req.getParameter("orderStatus"))==1){
              order.setStatus("Προς Πακετάρισμα");
          }else if (Integer.parseInt(req.getParameter("orderStatus"))==2){
              order.setStatus("Προς Τιμολόγηση");
          }else if (Integer.parseInt(req.getParameter("orderStatus"))==3){
              order.setStatus("Εστάλη");
          }else if (Integer.parseInt(req.getParameter("orderStatus"))==4){
              order.setStatus("Παραλήφθηκε");
          }else if (Integer.parseInt(req.getParameter("orderStatus"))==5){
              order.setStatus("Ακυρωμένη");
          }
          else{
              order.setStatus("All");
          }
       }

       String startDate="";
       String endDate="";
       //System.out.println("date="+req.getParameter("startDay"));
       if(req.getParameter("startDay")!=null && req.getParameter("startMonth")!=null && req.getParameter("startYear")!=null){
            startDate=req.getParameter("startYear")+"-"+req.getParameter("startMonth")+"-"+req.getParameter("startDay");
       }
       if(req.getParameter("endDay")!=null && req.getParameter("endMonth")!=null && req.getParameter("endYear")!=null){
            endDate=req.getParameter("endYear")+"-"+req.getParameter("endMonth")+"-"+req.getParameter("endDay");
       }

       if(req.getParameter("dispatch")!=null){
          if(Integer.parseInt(req.getParameter("dispatch"))==0){
              order.setDispatchType("Διανομή");
          }else if (Integer.parseInt(req.getParameter("dispatch"))==1){
              order.setDispatchType("Παραλαβή");
          }else{
              order.setDispatchType("All");
          }
       }

       if(req.getParameter("order_id")!=null){
            if(!req.getParameter("order_id").equals("")){
                order.setOrderId(Integer.parseInt(req.getParameter("order_id")));
            }
       }

       CustomerInfoBean cust=new CustomerInfoBean();
       if(req.getParameter("customer_id")!=null){
           if(!req.getParameter("customer_id").equals("")){
                cust.setCustomerID(Integer.parseInt(req.getParameter("customer_id")));
                order.setCustomer(cust);
           }
       }

       
       if(req.getParameter("lastname")!=null){
           cust.setLastname(req.getParameter("lastname"));
           order.setCustomer(cust);
        }

       DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
       if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
           }
            // Create a DAO
       
       
            OrderDAO orderDAO = mysqlFactory.getOrderDAO();
            try {
                listOfOrders = orderDAO.findOrders(order, startDate, endDate);
            } catch (SQLException ex) {
                Logger.getLogger(ShowAllOrdersPage.class.getName()).log(Level.SEVERE, null, ex);
            }
       
       

       //customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");

      if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
          customer=new CustomerInfoBean();
          customer.setUsername(req.getParameter("un"));
          customer.setPassword(req.getParameter("pw"));
          System.out.println("un= " +req.getParameter("un"));
          mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

           if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
           }
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(ShowAllOrdersPage.class.getName()).log(Level.SEVERE, null, ex);
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
       return listOfOrders;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}
