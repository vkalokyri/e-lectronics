/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import daoFactories.DAOFactory;
import daoInterfaces.ProductDAO;
import java.sql.SQLException;
import java.util.Vector;

/**
 *
 * @author Valitsa
 */
public class ShoppingCartBean implements java.io.Serializable {

    private Vector productsOrdered;

    public ShoppingCartBean(){
        productsOrdered=new Vector();
    }


    public Vector getItemsOrdered(){
        return this.productsOrdered;
    }

    public synchronized void addProduct(String productID){
          ProductOrder order;
          for (int i=0;i<productsOrdered.size();i++){
              order=(ProductOrder)productsOrdered.get(i);
              if(order.getProductID().equals(productID)){
                  order.incrementNumItems();
                  return;
              }
          }
    }


    public synchronized void setNumOrdered(String productID,int numOrdered) throws SQLException{
        ProductOrder order;
        
        for (int i=0;i<productsOrdered.size();i++){
              order=(ProductOrder)productsOrdered.get(i);              
              if(order.getProductID().equals(productID)){
                 if(numOrdered<=0){
                     productsOrdered.remove(i);
                 }else{
                     order.setNumItems(numOrdered);
                 }
                 return;
              }
          }
        
       DAOFactory mysqlFactory = DAOFactory.getDAOFactory(DAOFactory.mySQL);       
       ProductDAO prodDAO = mysqlFactory.getProductDAO();
       ProductOrder newOrder=new ProductOrder(prodDAO.getProduct(productID));
       productsOrdered.add(newOrder);
       
    }

}
