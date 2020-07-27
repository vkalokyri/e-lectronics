/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CustomerDAO;
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
import model.CustomerInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowSearchResultsPage implements Action {

    private String view;
    private Vector list;
    private CustomerInfoBean customer;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view="./views/ShowSearchResultsView.jsp";

        HttpSession session=req.getSession();
        
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
          mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

           if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
           }
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(ShowFirstPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);
             view="./views/ShowComplexSearchView.jsp";
              return true;
          }
          else{
                view = "./views/ShowWrongLoginView.jsp";
                return true;
          }
      }


        String category="all";
        String subcategory="all";
        String keywords;
        String excludeWords="";
        String startPrice="";
        String endPrice="";
        String words;
        String order;
        if(req.getParameter("simpleSearch")!=null){                        
            keywords=req.getParameter("simpleSearch");            
            words="specific";
            order="all";
        }else{
            category=req.getParameter("category");
            subcategory=req.getParameter("subcateg"+category);
            keywords=req.getParameter("keywords");
            String searchLimits=req.getParameter("searchLimits");
            excludeWords=req.getParameter("excludeWords");
            startPrice=req.getParameter("startPrice");
            endPrice=req.getParameter("endPrice");
            String [] temp=searchLimits.split("_");
            words=temp[0];
            order=temp[1];
        }

        ProductDAO prodDao = mysqlFactory.getProductDAO();
        

        if(category.equals("all")){
            try {
                list=prodDao.getProductsFromSearch(keywords,words,order,excludeWords,category,"all",startPrice,endPrice);
            } catch (SQLException ex) {
                Logger.getLogger(ShowSearchResultsPage.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else{
            try {
                list=prodDao.getProductsFromSearch(keywords,words,order,excludeWords,category,subcategory,startPrice,endPrice);
            } catch (SQLException ex) {
                Logger.getLogger(ShowSearchResultsPage.class.getName()).log(Level.SEVERE, null, ex);
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
