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
import java.util.Enumeration;
import java.util.Vector;
import java.util.Iterator;
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
public class ShoppingCartPage implements Action {

    /** Page to be used to display data */
    private String view;
    private ShoppingCartBean cart;
    private CustomerInfoBean customer;


   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {


    HttpSession session=req.getSession();
    String action = req.getParameter("action");
    DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");              
    if(mysqlFactory==null){
      mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
      session.setAttribute("daoFactory", mysqlFactory);
    }
    ProductDAO prodDAO = mysqlFactory.getProductDAO();
    Vector AllIncompatibleProducts=new Vector();
    
       //check-compatibility
        if(req.getParameter("ch")!=null){
            if(req.getParameter("ch").equals("1")){               
                    cart=(ShoppingCartBean)session.getAttribute("shoppingCart");
                    if (cart==null){
                        cart=new ShoppingCartBean();
                        session.setAttribute("shoppingCart", cart);
                    }
                   Vector itemsOrdered=cart.getItemsOrdered();
                   if(itemsOrdered.size()!=0){
                        ProductOrder prOrder;
                        for(int i=0;i<itemsOrdered.size();i++){
                            prOrder=(ProductOrder)itemsOrdered.get(i);
                            try {
                                AllIncompatibleProducts.add(prodDAO.getIncompatibleProducts(Integer.parseInt(prOrder.getProductID())));
                            } catch (SQLException ex) {
                                Logger.getLogger(ShoppingCartPage.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            session.setAttribute("IncompatibleProducts", AllIncompatibleProducts);
                        }
                    }
                
            }
        }
    
        if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
              customer=new CustomerInfoBean();
              customer.setUsername(req.getParameter("un"));
              customer.setPassword(req.getParameter("pw"));
              System.out.println("un= " +req.getParameter("un"));              
               
                // Create a DAO
                CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
                try {
                    customer = custDAO.login(customer);
                } catch (SQLException ex) {
                    Logger.getLogger(ShoppingCartPage.class.getName()).log(Level.SEVERE, null, ex);
                }

              /** Set the view */
              if (action != null  && customer.isValid()) {
                 session.setAttribute("CustomerInfo", customer);

              }
              else{
                    view = "./views/ShowWrongLoginView.jsp";
              }
      }

       if (req.getParameter("ov")!=null && req.getParameter("ov").equals("1")){
            view="./views/ShowShoppingCartView.jsp";
            return true;
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

            Enumeration paramNames = req.getParameterNames();

            //create a copy of the products in shoppingCart
            Vector itemsOrdered=cart.getItemsOrdered();
            ProductOrder order=null;
            Vector tempcopy = new Vector();
            for(Iterator it = itemsOrdered.iterator();it.hasNext();){
                    tempcopy.add((ProductOrder)it.next());
            }

       

            while(paramNames.hasMoreElements()) {
                String paramName = (String)paramNames.nextElement();
                if(!paramName.equals("action") && !paramName.equals("un") && !paramName.equals("pw")){
                    
                    String[] paramValues = req.getParameterValues(paramName);

                    String productID=paramName;
                    for(int i=0; i<tempcopy.size(); i++){
                        if(((ProductOrder)tempcopy.get(i)).getProductID().equals(productID))
                                tempcopy.remove(i);
                    }

                    if (productID!=null){
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

                    }

                }//if
            }//while

            //scan what has remained in the temporary list to remove it from
            //the cart.
            Iterator it = tempcopy.iterator();
            while(it.hasNext()){                
                try {
                    cart.setNumOrdered(((ProductOrder)it.next()).getProductID(), 0); //0 to remove
                } catch (SQLException ex) {
                    Logger.getLogger(ShoppingCartPage.class.getName()).log(Level.SEVERE, null, ex);
                }
            }


            
        }//synchronized

        req.setAttribute("shoppingCart", cart);
        view = "./views/ShowShoppingCartView.jsp";

 
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