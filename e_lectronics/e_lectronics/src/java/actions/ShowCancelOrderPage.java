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

/**
 *
 * @author Valitsa
 */
public class ShowCancelOrderPage implements Action {

    private String view;
    private CustomerInfoBean customer;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        
        HttpSession session=req.getSession();

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
        }

        System.out.println(req.getParameter("oid"));
        String[] OrderIdValues = new String[1];
        OrderIdValues[0]=req.getParameter("oid");
        
        OrderDAO orderDao = mysqlFactory.getOrderDAO();        

        try {
            orderDao.changeOrdersStatus(OrderIdValues, "Ακυρωμένη");
        } catch (SQLException ex) {
             Logger.getLogger(ShowChangeOrdersPage.class.getName()).log(Level.SEVERE, null, ex);
        }


        view = "./views/ShowCancelOrderView.jsp";


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
                Logger.getLogger(AddToCartPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);

          }
          else{
                view = "./views/ShowWrongLoginView.jsp";

          }
      }

        customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");

        if(customer==null ){
           view = "./views/ShowFirstPageView.jsp";
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
