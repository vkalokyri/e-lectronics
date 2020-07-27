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

public class CategoryInfoBean implements java.io.Serializable {

       private String name;
       private int category_id;
       private int subcateg_id;
       private Vector listOfCategories=new Vector();
       private Vector listOfSubcategories=new Vector();
       private ProductInfoBean prod;
 

	public CategoryInfoBean(){
           prod=new ProductInfoBean();
           
	}

	//getters
	public String getName(){
		return this.name;
	}

	public int getCategoryID(){
		return this.category_id;
	}

        public int getSubcategoryID(){
		return this.subcateg_id;
	}
        
        public Vector getListOfCategories(){
		return this.listOfCategories;
	}

        public Vector getListOfSubcategories(){
		return this.listOfSubcategories;
	}

        public ProductInfoBean getProduct(){
		return this.prod;
	}

	//setters
	public void setName(String name){
		this.name=name;
	}

	public void setCategoryID(int id){
		this.category_id=id;
	}

        public void setSubcategoryID(int id){
		this.subcateg_id=id;
	}

        public void setListOfCategories(Vector list){
		this.listOfCategories=list;
	}

        public void setListOfSubcategories(Vector list){
		this.listOfSubcategories=list;
	}
        
        public  void setProduct(ProductInfoBean prod){
		this.prod=prod;
	}

}