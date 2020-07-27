/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.ProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ProductInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowConfirmDeleteProductPage implements Action {

    private String view;
    private boolean isDeleted=true;
    private ProductInfoBean prod=new ProductInfoBean();

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowConfirmChangesProductView.jsp";
        HttpSession session=req.getSession();

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
        }
        ProductDAO prodDao = mysqlFactory.getProductDAO();        
        
        int sn=Integer.parseInt(req.getParameter("SN"));
        try {
            prodDao.deleteIncompatibleProducts(sn,prodDao.getIncompatibleProducts(sn));
            prodDao.deleteMaxPerformanceProducts(sn,prodDao.getMaxPerformanceProducts(sn));
            isDeleted=prodDao.deleteProduct(sn);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmDeleteProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        if(!isDeleted){
            prod.setIsDeleted(false);
            view = "./views/ShowDeleteProductView.jsp";
            
        }

        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return prod;
    }

}
