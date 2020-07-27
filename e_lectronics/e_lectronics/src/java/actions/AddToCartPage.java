/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;


import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CategoryDAO;
import daoInterfaces.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CustomerInfoBean;
import model.ProductOrder;
import model.ShoppingCartBean;

/**
 *
 * @author Valitsa
 */
public class AddToCartPage implements Action {

    /** Page to be used to display data */
    private String view;
    private ShoppingCartBean cart;
    private CustomerInfoBean customer;


   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session=req.getSession();
        

        String action = req.getParameter("action");

      if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
          customer=new CustomerInfoBean();
          customer.setUsername(req.getParameter("un"));
          customer.setPassword(req.getParameter("pw"));
          System.out.println("un= " +req.getParameter("un"));
          DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

           if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
           }
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(AddToCartPage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);
             
          }
          else{
                view = "./views/ShowWrongLoginView.jsp";
                
          }
      }

        Vector current=(Vector)session.getAttribute("CurrentMenu");
        if(current==null){
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
          session.setAttribute("CurrentMenu",current);
       }

        synchronized(session){
            cart=(ShoppingCartBean)session.getAttribute("shoppingCart");
            
            if (cart==null){
                cart=new ShoppingCartBean();
                session.setAttribute("shoppingCart", cart);
            }

            //-------------------------------------------------
            Enumeration paramNames = req.getParameterNames();
            Vector shoppinglist = cart.getItemsOrdered();
            boolean foundInList = false;

            while(paramNames.hasMoreElements()) {
                foundInList = false;
                String paramName = (String)paramNames.nextElement();
                if(!paramName.equals("action") && !paramName.equals("un") && !paramName.equals("pw")){
                    String[] paramValues = req.getParameterValues(paramName);


                    String productID=paramName;
                    if (productID!=null){

                        // first search if product already exists.
                        // if yes, just update quantity.
                        ProductOrder prod = null;
                        for(int i=0; i<shoppinglist.size(); i++){
                            prod = (ProductOrder)shoppinglist.get(i);
                            if(prod.getProductID().equals(productID)){
                                prod.setNumItems(prod.getNumItems()+1);
                                foundInList = true;
                            }
                        }

                        if(!foundInList){
                            String numItemsString=paramValues[0]; //req.getParameter("numItems");
                            
                            if(numItemsString==null){
                                cart.addProduct(productID);
                            }else{
                                int numItems;
                                try{
                                    numItems=Integer.parseInt(numItemsString);
                                }catch(NumberFormatException nfe){
                                    numItems=1;
                                }
                                try {
                                     
                                    cart.setNumOrdered(productID, numItems);
                                } catch (SQLException ex) {
                                    Logger.getLogger(ShoppingCartPage.class.getName()).log(Level.SEVERE, null, ex);
                                }
                            }
                        }//if not found in list

                    }

                }//if
            }//while

        }//synchronized

      req.setAttribute("shoppingCart", cart);
      view = "./views/ShowShoppingCartView.jsp";

        Vector listOfCategories=new Vector();
        synchronized(session){
            customer=(CustomerInfoBean)session.getAttribute("CustomerInfo");
            listOfCategories=(Vector)session.getAttribute("CategoriesList");
            DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
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
                Logger.getLogger(MyAccountPage.class.getName()).log(Level.SEVERE, null, ex);
            }
       }
      
      
      

      return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return cart;
   }


   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}