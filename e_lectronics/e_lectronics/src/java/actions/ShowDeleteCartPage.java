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
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Valitsa
 */
public class ShowDeleteCartPage implements Action {

    private String view;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowConfirmDeleteCartsView.jsp";
        HttpSession session=req.getSession();

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
            mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
            session.setAttribute("daoFactory", mysqlFactory);
        }

        BasketDAO cartDao = mysqlFactory.getBasketDAO();

        String[] CartIdValues;
        Enumeration paramNames = req.getParameterNames();
        while(paramNames.hasMoreElements()) {
            String paramName = (String)paramNames.nextElement();
             if(paramName.equals("check")){
                CartIdValues = req.getParameterValues(paramName);
                try {
                    cartDao.deleteCart(CartIdValues);
                } catch (SQLException ex) {
                     Logger.getLogger(ShowChangeOrdersPage.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
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
