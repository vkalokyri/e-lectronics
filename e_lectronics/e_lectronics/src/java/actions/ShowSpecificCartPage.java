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

/**
 *
 * @author Valitsa
 */
public class ShowSpecificCartPage implements Action {


    private String view;
    private CartInfoBean cart;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view="./views/ShowSpecificCartView.jsp";

        HttpSession session=req.getSession();
        String cart_id=req.getParameter("cid");


        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
         }
         // Create a DAO
        BasketDAO cartDao = mysqlFactory.getBasketDAO();
        try {
            cart=cartDao.findProductsbyCartID(Integer.parseInt(cart_id));
        } catch (SQLException ex) {
            Logger.getLogger(ShowSpecificCartPage.class.getName()).log(Level.SEVERE, null, ex);
        }
        

        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return cart;
    }

}