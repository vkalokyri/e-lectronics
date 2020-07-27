/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CharacteristicsDAO;
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
import model.CategoryInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowInsertProductPage implements Action {

    private String view;
    private Vector Allcharacteristics=new Vector();
    private Vector AllCharacteristicsAndProducts=new Vector();

   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowInsertProductView.jsp";
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



        Vector listOfCategories = (Vector)session.getAttribute("CategoriesList");

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
        }

       CharacteristicsDAO charDAO = mysqlFactory.getCharacteristicsDAO();
       ProductDAO prodDao=mysqlFactory.getProductDAO();

       Vector characteristicsBySubcateg=new Vector();
       for (int i=0;i<listOfCategories.size();i++){
           for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
               int id=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID();
                try {
                     characteristicsBySubcateg = charDAO.getCharacteristicsbySubcategory(id);
                } catch (SQLException ex) {
                    Logger.getLogger(ShowInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
                }
               Allcharacteristics.add(characteristicsBySubcateg);
               }
       }
       Vector allProducts=new Vector();
        try {
            allProducts = prodDao.getAllProducts();
        } catch (SQLException ex) {
            Logger.getLogger(ShowInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }
         AllCharacteristicsAndProducts.add(Allcharacteristics);
         AllCharacteristicsAndProducts.add(allProducts);

       return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return AllCharacteristicsAndProducts;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}