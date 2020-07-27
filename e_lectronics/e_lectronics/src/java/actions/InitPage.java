/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CategoryDAO;
import daoInterfaces.CustomerDAO;
import daoInterfaces.ProductDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
public class InitPage implements Action {

   /** Page to be used to display data */
   private String view;
   private CustomerInfoBean customer;
   private Vector listOfCategories;
   private Vector currentCategories;
   private Vector ProductsInView=new Vector();
   private Vector newestProducts=new Vector();
   private Vector popularProducts=new Vector();

   public InitPage(){
   }

   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session=req.getSession();
        currentCategories=(Vector)session.getAttribute("CurrentMenu");

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

        if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
        }

        ProductDAO prodDAO = mysqlFactory.getProductDAO();

        try {
            newestProducts=prodDAO.getTheNewestProducts(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format( new java.util.Date()),3,"desc");
            ProductsInView.add(newestProducts);
            popularProducts=prodDAO.getTheMostPopularProducts(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format( new java.util.Date()),3,"desc");
            ProductsInView.add(popularProducts);
        } catch (SQLException ex) {
            Logger.getLogger(ShowFirstPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (currentCategories==null){
            currentCategories=new Vector();
            currentCategories.add(0,"-1");
            currentCategories.add(1,"-1");
        }else{
            view = "./views/ShowFirstPageView.jsp";
            String action = req.getParameter("action");

              if (req.getParameter("un")!=null && req.getParameter("pw")!=null){
                  System.out.println("un= " +req.getParameter("un"));
                  customer=new CustomerInfoBean();
                  customer.setUsername(req.getParameter("un"));
                  customer.setPassword(req.getParameter("pw"));

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
                  if (customer.isValid()) {
                     session.setAttribute("CustomerInfo", customer);
                  }
                  else{
                        view = "./views/ShowWrongLoginView.jsp";
                  }
              }
            return true;
        }


       session.setAttribute("CurrentMenu",currentCategories);
       synchronized(session){
            customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");
            listOfCategories=(Vector)session.getAttribute("CategoriesList");
            mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
            if (listOfCategories==null){
                listOfCategories=new Vector();
                session.setAttribute("CategoriesList", listOfCategories);
            }
            if (mysqlFactory==null){
                mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
                session.setAttribute("daoFactory", mysqlFactory);
            }

            if (customer==null){
                customer=new CustomerInfoBean();
                session.setAttribute("Customer", customer);
            }
            //DAOFactory mysqlFactory = DAOFactory.getDAOFactory(DAOFactory.mySQL);
            // Create a DAO
            CategoryDAO catDAO = mysqlFactory.getCategoryDAO();
            
            try {
                listOfCategories = catDAO.takeMainCategories();
                session.setAttribute("CategoriesList", listOfCategories);                
            } catch (SQLException ex) {
                Logger.getLogger(InitPage.class.getName()).log(Level.SEVERE, null, ex);
            }
       }

        view = "./views/ShowFirstPageView.jsp";





      return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return ProductsInView;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}