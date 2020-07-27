/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
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
public class ShowConfirmOrderPage implements Action {

    /** Page to be used to display data */
   /** Page to be used to display data */
    private String view;

     /** JavaBean used to represent a person */
    CustomerInfoBean cust;
    CreditCardInfoBean card=new CreditCardInfoBean();
    OrderInfoBean order;

    /**
    * Creates a new instance of ShowPersonInfo
    * No-arg constructor used to initialize the JavaBeans
    */
    public ShowConfirmOrderPage() {
        cust = new CustomerInfoBean();
        order=new OrderInfoBean();

    }

    /**
    * Execute business logic
    * Retrieves general info and populates the JavaBean
    */
    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

      HttpSession session=req.getSession();
      /** Retrieve parameters to perform action */
      
      //System.out.println(new java.sql.Date( new java.util.Date().getTime() ));


      if(Integer.parseInt(req.getParameter("pliromi"))==0){
          order.setPaymentType("Πιστωτική Κάρτα");
          card.setCardType(req.getParameter("cardtype"));
          card.setCardNum(req.getParameter("cardnumber"));
          card.setCvv(Integer.parseInt(req.getParameter("cvv")));
          card.setExpireMonth(req.getParameter("expiremonth"));
          card.setExpireYear(Integer.parseInt(req.getParameter("expireyear")));
          card.setCardHolderName(req.getParameter("cardholder"));
          card.setCardHolderPhone(req.getParameter("cardholderpho"));
          order.setCreditCard(card);
      }else{
          order.setPaymentType("Αντικαταβολή");
      }
      
      if(req.getParameter("apostoli").startsWith("Διανομή")){
            order.setDispatchType("Διανομή");
            order.setCity(req.getParameter("city"));
      }else if (req.getParameter("apostoli").startsWith("Παραλαβή")){
            order.setDispatchType("Παραλαβή");
            order.setCity(req.getParameter("shop"));
      }
      order.setAddress(req.getParameter("street"));
      order.setFirstname(req.getParameter("firstname"));
      order.setLastname(req.getParameter("lastname"));
      order.setEmail(req.getParameter("email"));
      order.setMobilePhone(req.getParameter("mobile"));
      order.setPhone(req.getParameter("phone"));
      order.setPostalCode(Integer.parseInt(req.getParameter("zip")));
      order.setDate(new java.sql.Date( new java.util.Date().getTime() ));
      order.setStatus("Εκκρεμής");
      System.out.println(((CustomerInfoBean)session.getAttribute("CustomerInfo")).getCustomerID());
      order.setCustomer((CustomerInfoBean)session.getAttribute("CustomerInfo"));

      double total_cost=0;
      ShoppingCartBean mycart=(ShoppingCartBean)session.getAttribute("shoppingCart");
      
      synchronized(session){
        Vector itemsOrdered=mycart.getItemsOrdered();
        ProductOrder productOrdered;
            for(int i=0;i<itemsOrdered.size();i++){
                   productOrdered=(ProductOrder)itemsOrdered.get(i);
                   total_cost=total_cost+productOrdered.getTotalCost();
            }
      }
      order.setTotal_price(total_cost);
      order.setListOfOrderedProducts(mycart.getItemsOrdered());
      

      DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

      if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }
        // Create a DAO
        OrderDAO orderDao = mysqlFactory.getOrderDAO();
        try {
           order=orderDao.insertOrder(order);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmOrderPage.class.getName()).log(Level.SEVERE, null, ex);
        }
        
            

      view = "./views/ShowConfirmOrderView.jsp";

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
