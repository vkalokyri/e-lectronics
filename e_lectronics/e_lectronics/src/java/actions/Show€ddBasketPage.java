/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.BasketDAO;
import daoInterfaces.CustomerDAO;
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
import model.CartInfoBean;
import model.CustomerInfoBean;
import model.ProductOrder;
import model.ShoppingCartBean;

/**
 *
 * @author Valitsa
 */
public class ShowΑddBasketPage implements Action {

    private String view;
    private CustomerInfoBean customer;
    private CartInfoBean cart=new CartInfoBean();
    

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       view = "./views/ShowConfirmSaveCartView.jsp";
       HttpSession session=req.getSession();
       customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");

       DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

       if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }
       
       String action = req.getParameter("action");

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
                Logger.getLogger(ShowMakeOrderPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);

          }
          else{
             view = "./views/ShowWrongLoginView.jsp";
             return true;
          }
       }

       if(customer==null){
           view = "./views/ShowUnregisterView.jsp";
           return true;
       }

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
      System.out.println(total_cost);
      cart.setTotalPrice(total_cost);
      cart.setListOfProducts(mycart.getItemsOrdered());
      cart.setDate(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format( new java.util.Date()));
      
      cart.setCustomer((CustomerInfoBean)session.getAttribute("CustomerInfo"));
      

        // Create a DAO
        BasketDAO cartDao = mysqlFactory.getBasketDAO();
        try {
           cartDao.insertCart(cart);
        } catch (SQLException ex) {
           Logger.getLogger(ShowConfirmOrderPage.class.getName()).log(Level.SEVERE, null, ex);
        }


        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return null;
    }

    


}
