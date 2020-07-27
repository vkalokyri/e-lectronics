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
import java.util.Enumeration;
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
public class ShowConfirmOrderChanges implements Action {

    /** Page to be used to display data */
   /** Page to be used to display data */
    private String view;

     /** JavaBean used to represent */
     
     
     OrderInfoBean order=new OrderInfoBean();;
     OrderInfoBean myorder=new OrderInfoBean();
     
    /**
    * Execute business logic
    * Retrieves general info and populates the JavaBean
    */
    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session=req.getSession();
        int order_id=Integer.parseInt(req.getParameter("oid"));
        order.setOrderId(order_id);

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
         }

        
        if(Integer.parseInt(req.getParameter("pliromi"))==0){
          order.setPaymentType("Πιστωτική Κάρτα");
          order.setCreditCard(null);
          /*CreditCardInfoBean card=new CreditCardInfoBean();
          card.setCardType(req.getParameter("cardtype"));
          card.setCardNum(req.getParameter("cardnumber"));
          card.setCvv(Integer.parseInt(req.getParameter("cvv")));
          card.setExpireMonth(req.getParameter("expiremonth"));
          card.setExpireYear(Integer.parseInt(req.getParameter("expireyear")));
          card.setCardHolderName(req.getParameter("cardholder"));
          card.setCardHolderPhone(req.getParameter("cardholderpho"));
          order.setCreditCard(card);*/
        }else{
          order.setPaymentType("Αντικαταβολή");
          order.setCreditCard(null);
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
      order.setCustomer((CustomerInfoBean)session.getAttribute("CustomerInfo"));

       
         // Create a DAO
        OrderDAO orderDao = mysqlFactory.getOrderDAO();
        try {
            myorder=orderDao.findProductsOrderedByOrder(order_id);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmOrderChanges.class.getName()).log(Level.SEVERE, null, ex);
        }

        
        double total_price=0;
        Enumeration paramNames = req.getParameterNames();
        Vector listOfAlteredProds=new Vector();
        for(int i=0;i<myorder.getListOfOrderedProducts().size();i++){
            ProductOrder product=(ProductOrder)myorder.getListOfOrderedProducts().get(i);
            paramNames = req.getParameterNames();
            while(paramNames.hasMoreElements()) {
                String paramName = (String)paramNames.nextElement();
                
                if(paramName.equals(product.getProductID())){
                     String[] paramValues = req.getParameterValues(paramName);
                    total_price=total_price+product.getUnitCost()*(Integer.parseInt(paramValues[0]));
                    ProductOrder prod=new ProductOrder();
                    ProductInfoBean p=new ProductInfoBean();
                    p.setSerialNumber(Integer.parseInt(product.getProductID()));                                      
                    prod.setNumItems(Integer.parseInt(paramValues[0]));
                    prod.setProduct(p);
                    listOfAlteredProds.add(prod);
                }
            }
      }

     
      order.setTotal_price(total_price);
      order.setListOfOrderedProducts(listOfAlteredProds);

        try {
            orderDao.updateOrder(order);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmOrderChanges.class.getName()).log(Level.SEVERE, null, ex);
        }

      CustomerInfoBean cust=((CustomerInfoBean)session.getAttribute("CustomerInfo"));
      if(cust!=null){
          if(cust.getIsAdmin()){
            view = "./views/ShowConfirmOrderChangesView.jsp";
          }else{
            view = "./views/ShowConfirmOrderChange.jsp";
          }
      }else{
          view = "./views/ShowUnregisterView.jsp";
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
