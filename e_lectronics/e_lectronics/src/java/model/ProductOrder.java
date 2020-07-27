/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

/**
 *
 * @author Valitsa
 */
public class ProductOrder implements java.io.Serializable {

    private ProductInfoBean product;
    private int numItems;

    public ProductOrder(ProductInfoBean product){
        setProduct(product);
        setNumItems(1);
    }

    public ProductOrder(){

    }


    public ProductInfoBean getProduct(){
        return this.product;
    }

    public void setProduct(ProductInfoBean product){
        this.product=product;
    }

    public String getProductID(){
        return Integer.toString(getProduct().getSerialNumber());
    }

    public String getModel(){
        return getProduct().getModel();
    }

    public double getUnitCost(){
        return getProduct().getPrice();
    }

    public String getImageUrl(){
        return getProduct().getImageUrl();
    }

    public int getCategoryID(){
        return getProduct().getCategoryID();
    }

    public int getSubcategoryID(){
        return getProduct().getSubcategoryID();
    }

    
    public int getNumItems(){
        return this.numItems;
    }

    public void setNumItems(int n){
        this.numItems=n;
    }

    public void incrementNumItems(){
        setNumItems(getNumItems()+1);
    }

    public void cancelOrder(){
        setNumItems(0);
    }

    public double getTotalCost(){
        return (getNumItems()*getUnitCost());
    }

}
