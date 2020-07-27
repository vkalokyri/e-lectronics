/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CategoryDAO;
import daoInterfaces.CharacteristicsDAO;
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
public class ShowInsertCategoryPage implements Action {

    private String view;
    private Vector Allcharacteristics=new Vector();

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowInsertCategoryView.jsp";

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
           if(listOfCategories==null){
               CategoryDAO catDAO = mysqlFactory.getCategoryDAO();
                 try {
                    listOfCategories = catDAO.takeMainCategories();
                } catch (SQLException ex) {
                    Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                }
                session.setAttribute("CategoriesList",listOfCategories);
                listOfCategories = (Vector)session.getAttribute("CategoriesList");
           }

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



        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return Allcharacteristics;
    }

}
