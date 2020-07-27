/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.ProductDAO;
import daoInterfaces.ValuesDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CharacteristicsInfoBean;
import model.ProductInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowDeleteProductPage implements Action {

    private String view;
    private ProductInfoBean prod;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowDeleteProductView.jsp";
        HttpSession session=req.getSession();

        Vector current=(Vector)session.getAttribute("CurrentMenu");

       if(current==null){
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
       }
       current.add(0, "-1");
       current.add(1, "-1");
       session.setAttribute("CurrentMenu",current);
       

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
        }

        if(req.getParameter("sn")!=null ){
            if(!req.getParameter("sn").equals("")){
                prod=new ProductInfoBean();
                String sn=req.getParameter("sn");
                ProductDAO prodDao = mysqlFactory.getProductDAO();
                ValuesDAO valueDao=mysqlFactory.getValuesDAO();
                CharacteristicsInfoBean charact=new CharacteristicsInfoBean();
                try {
                    prod=prodDao.getProductCharacteristics(Integer.parseInt(sn));
                    charact=valueDao.getCharacteristicsAndValuesOfProduct(Integer.parseInt(sn));
                    prod.setListOfIncompatibleProducts(prodDao.getIncompatibleProducts(Integer.parseInt(sn)));
                    prod.setListOfMaxPerformanceProducts(prodDao.getMaxPerformanceProducts(Integer.parseInt(sn)));
                } catch (SQLException ex) {
                    Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                prod.setCharacteristics(charact);
                prod.setSerialNumber(Integer.parseInt(sn));
                prod.setIsDeleted(true);
            }
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