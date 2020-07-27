/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.sql.Date;
import java.util.Vector;

/**
 *
 * @author Valitsa
 */
public class OrderInfoBean {

    private int order_id;
    private Date date;
    private String status;
    private double total_price;
    private String payment_type;
    private String dispatch_type;
    private String address;
    private String city;
    private int zip;
    private String phone;
    private String mobilePhone;
    private String firstName;
    private String lastName;
    private String email;
    private CustomerInfoBean customer;
    private CreditCardInfoBean card;
    private Vector listOfProducts;
    private boolean orderExists;



    public OrderInfoBean(){
        customer=new CustomerInfoBean ();
        card=new CreditCardInfoBean();
        listOfProducts=new Vector();
    }

    public String getFirstname(){
		return this.firstName;
	}

	public String getLastname(){
		return this.lastName;
	}

	public String getEmail(){
		return this.email;
	}

	public String getAddress(){
		return this.address;
	}

	public String getCity(){
		return this.city;
	}

	public int getPostalCode(){
		return this.zip;
	}

	public String getPhone(){
		return this.phone;
	}

	public String getMobilePhone(){
		return this.mobilePhone;
	}

        public int getOrderId(){
		return this.order_id;
	}

         public Date getDate(){
		return this.date;
	}

         public String getStatus(){
		return this.status;
	}

        public String getPaymentType(){
		return this.payment_type;
	}

        public String getDispatchType(){
		return this.dispatch_type;
	}

        public double getTotal_price(){
		return this.total_price;
	}

         public CustomerInfoBean getCustomer(){
		return this.customer;
	}

         public CreditCardInfoBean getCreditCard(){
		return this.card;
	}

        public Vector getListOfOrderedProducts(){
		return this.listOfProducts;
	}

        public boolean getOrderExists(){
		return this.orderExists;
	}
        
        
        //setters

        public void setFirstname(String fname){
		this.firstName=fname;
	}

	public void setLastname(String lname){
		this.lastName=lname;
	}

	public void setEmail(String email){
		this.email=email;
	}

	public void setAddress(String addr){
		this.address=addr;
	}

	public void setCity(String city){
		this.city=city;
	}

	public void setPostalCode(int pc){
		this.zip=pc;
	}

	public void setPhone(String phone){
		this.phone=phone;
	}

	public void setMobilePhone(String mobilePhone){
		this.mobilePhone=mobilePhone;
	}


        public void setOrderId(int id){
		this.order_id=id;
	}

         public void setDate(Date date){
		this.date=date;
	}

         public void setStatus(String status){
		this.status=status;
	}

        public void setPaymentType(String payment_type){
		this.payment_type=payment_type;
	}

        public void setDispatchType(String dispatch_type){
		this.dispatch_type=dispatch_type;
	}

        public void setTotal_price(double price){
		this.total_price=price;
	}

        public void setCustomer(CustomerInfoBean cust){
		this.customer=cust;
	}

        public void setCreditCard(CreditCardInfoBean card){
		this.card=card;
	}

        public void setListOfOrderedProducts(Vector list){
		this.listOfProducts=list;
	}

        public void setOrderExists(boolean ex){
		this.orderExists=ex;
	}

        

}
