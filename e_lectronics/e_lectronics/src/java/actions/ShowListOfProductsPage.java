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
import java.sql.*;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CustomerInfoBean;
import model.ProductInfoBean;
/**
 *
 * @author Valitsa
 */
public class ShowListOfProductsPage implements Action {

    /** Page to be used to display data */
   private String view;
   
   ProductInfoBean product=new ProductInfoBean();
   CustomerInfoBean customer;
   Vector listOfProducts=new Vector();


   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

       HttpSession session=req.getSession();
       String category_id=req.getParameter("CategId");
       String subcategory_id=req.getParameter("SubcategId");
       session.setAttribute("previousProductPageUrl",req.getQueryString());

       String orderBy;
       if(req.getParameter("order")!=null){
           orderBy=req.getParameter("order");
       }else{
           orderBy="asc";
       }

       Vector current=(Vector)session.getAttribute("CurrentMenu");
       if(current==null){
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
          session.setAttribute("CurrentMenu",current);
       }
      
      current.add(0,category_id);
      current.add(1,subcategory_id);
      session.setAttribute("CurrentMenu", current);

       //categ.setCategoryID(Integer.parseInt(category_id));
       //categ.setSubcategoryID(Integer.parseInt(subcategory_id));
       //DAOFactory mysqlFactory = DAOFactory.getDAOFactory(DAOFactory.mySQL);
        // Create a DAO
       DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

       if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }
       
        ProductDAO prodDAO = mysqlFactory.getProductDAO();
       

           
        try {
            listOfProducts= prodDAO.getProductsBySubcategory(Integer.parseInt(subcategory_id),orderBy);
            listOfProducts.add(orderBy);
        } catch (SQLException ex) {
            Logger.getLogger(ShowListOfProductsPage.class.getName()).log(Level.SEVERE, null, ex);
        }
            
      

      view = "./views/ShowListOfProductsView.jsp";

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
                Logger.getLogger(ShowListOfProductsPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);
             
          }
          else{
                view = "./views/ShowWrongLoginView.jsp";
          }
      }

      return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return listOfProducts;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}
