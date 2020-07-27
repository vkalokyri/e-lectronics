/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;


import java.util.Vector;

/**
 *
 * @author Valitsa
 */
public class CartInfoBean implements java.io.Serializable {

     private int id;
     private String date;
     private CustomerInfoBean customer;
     private double total_price;
     private Vector listOfProducts;

     public CartInfoBean(){
         
     }

     public String getDate(){
         return this.date;
     }

     public CustomerInfoBean getCustomer(){
         return this.customer;
     }

      public double getTotalPrice(){
         return this.total_price;
     }

     public int getCartID(){
         return this.id;
     }

      public Vector getListOfProducts(){
        return this.listOfProducts;
      }

     public void setDate(String date){
         this.date=date;
     }

     public void setCustomer(CustomerInfoBean cust){
         this.customer=cust;
     }

     public void setTotalPrice(double price){
         this.total_price=price;
     }

     public void setCartID(int id){
         this.id=id;
     }

     public void setListOfProducts(Vector list){
            this.listOfProducts=list;
     }


}
