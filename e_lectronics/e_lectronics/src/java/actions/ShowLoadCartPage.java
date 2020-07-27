/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.BasketDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartInfoBean;
import model.ProductOrder;
import model.ShoppingCartBean;

/**
 *
 * @author Valitsa
 */
public class ShowLoadCartPage implements Action {

    
    private String view;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session=req.getSession();
        synchronized(session){
            ShoppingCartBean cart=new ShoppingCartBean();           
            String cart_id=req.getParameter("cid");

            DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
         }
         // Create a DAO
        CartInfoBean cartBean=new CartInfoBean();
        BasketDAO cartDao = mysqlFactory.getBasketDAO();
        try {
            cartBean=cartDao.findProductsbyCartID(Integer.parseInt(cart_id));
        } catch (SQLException ex) {
            Logger.getLogger(ShowSpecificCartPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        //System.out.println("EFTASA EDW 2");
        for(int i=0;i< cartBean.getListOfProducts().size();i++){
            String productID=((ProductOrder)cartBean.getListOfProducts().get(i)).getProductID();
             
                try {
                    cart.setNumOrdered(productID,0);
                    //System.out.println(((ProductOrder) cartBean.getListOfProducts().get(i)).getNumItems());
                    cart.setNumOrdered(productID, ((ProductOrder) cartBean.getListOfProducts().get(i)).getNumItems());
                } catch (SQLException ex) {
                    Logger.getLogger(ShowLoadCartPage.class.getName()).log(Level.SEVERE, null, ex);
                }


        }

            session.setAttribute("shoppingCart", cart);
        }

        view = "./views/ShowShoppingCartView.jsp";
        


        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return null;
    }

}
