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
public class ProductInfoBean implements java.io.Serializable {

        private int serialNumber;
	private String manufacturer;
	private String model;
	private double price;
	private String warranty;
	private int stock;
	private int threshold;
	private int sales_num;
        private String image_url;
        private String description;
        private int subcategID;
        private int categID;
        private Vector listOfProducts;
        private boolean isDeleted;
        private CharacteristicsInfoBean charact;
        private Vector listOfIncompatibleProducts;
        private Vector listOfMaxPerformanceProducts;        

	public ProductInfoBean(){
             this.listOfProducts=new  Vector();            
             
	}

	//getters
	public int getSerialNumber(){
		return this.serialNumber;
	}

	public String getManufacturer(){
		return this.manufacturer;
	}

	public String getModel(){
		return this.model;
	}

	public double getPrice(){
		return this.price;
	}

	public String getWarranty(){
		return this.warranty;
	}
        public String getDescription(){
		return this.description;
	}

	public int getStock(){
		return this.stock;
	}

	public int getThreshold(){
		return this.threshold;
	}

	public int getSalesNum(){
		return this.sales_num;
	}

        public String getImageUrl(){
		return this.image_url;
	}

        public Vector getListOfProducts(){
		return this.listOfProducts;
	}

        public Vector getListOfIncompatibleProducts(){
		return this.listOfIncompatibleProducts;
	}

        public Vector getListOfMaxPerformanceProducts(){
		return this.listOfMaxPerformanceProducts;
	}

        public int getSubcategoryID(){
		return this.subcategID;
	}

        public int getCategoryID(){
		return this.categID;
	}

        public CharacteristicsInfoBean getCharacteristics(){
            return this.charact;
        }

        public boolean IsDeleted(){
		return this.isDeleted;
	}


	//setters

	public void setSerialNumber(int serialNum){
		this.serialNumber=serialNum;
	}

	public void setManufacturer(String manufacturer){
		this.manufacturer=manufacturer;
	}

	public void setModel(String model){
		this.model=model;
	}

	public void setPrice(double price){
		this.price=price;
	}

	public void setWarranty(String warranty){
		this.warranty=warranty;
	}

	public void setStock(int stock){
		this.stock=stock;
	}

	public void setThreshold(int threshold){
		this.threshold=threshold;
	}

	public void setSalesNum(int sales_num){
		this.sales_num=sales_num;
	}

        public void setImageUrl(String url){
		this.image_url=url;
	}

        public void setCategoryID(int id){
		this.categID=id;
	}

        public void setSubcategoryID(int id){
		this.subcategID=id;
	}

        public void setListOfProducts(Vector list){
		this.listOfProducts=list;
	}

        public void setListOfIncompatibleProducts(Vector list){
		this.listOfIncompatibleProducts=list;
	}

        public void setListOfMaxPerformanceProducts(Vector list){
		this.listOfMaxPerformanceProducts=list;
	}

        public void setCharacteristics(CharacteristicsInfoBean charact){
		this.charact=charact;
        }

        public void setDescription(String des){
		this.description=des;
        }

        public void setIsDeleted(boolean isDel){
		this.isDeleted=isDel;
	}

}