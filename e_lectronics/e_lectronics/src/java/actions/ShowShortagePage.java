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
import java.util.Vector;
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
public class ShowShortagePage implements Action {

    private String view;
    private Vector list;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {


        view = "./views/ShowShortageView.jsp";
        HttpSession session=req.getSession();
        /*Enumeration paramNames = req.getParameterNames();
        
        while(paramNames.hasMoreElements()) {
            String paramName = (String)paramNames.nextElement();
            String [] OrderIdValues = req.getParameterValues(paramName);
            System.out.println(paramName+"_"+OrderIdValues[0]);
        }*/

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
            mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
            session.setAttribute("daoFactory", mysqlFactory);
        }

        ProductDAO prodDao = mysqlFactory.getProductDAO();

        String category=req.getParameter("category");
        String subcategory=req.getParameter("subcateg"+category);
        //System.out.println(category);
        //System.out.println(subcategory);
        String startThres=req.getParameter("startThres");
        String endThres=req.getParameter("endThres");
        if(category.equals("all")){            
            try {
                list=prodDao.getProductsThresholds(startThres, endThres, category, "all");
            } catch (SQLException ex) {
                Logger.getLogger(ShowShortagePage.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else{
            try {
                list=prodDao.getProductsThresholds(startThres, endThres, category, subcategory);
            } catch (SQLException ex) {
                Logger.getLogger(ShowShortagePage.class.getName()).log(Level.SEVERE, null, ex);
            }
        }


        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return list;
    }

}
