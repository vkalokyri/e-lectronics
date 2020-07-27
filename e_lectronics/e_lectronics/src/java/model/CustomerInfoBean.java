/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.sql.ResultSet;

/**
 *
 * @author Valitsa
 */
public class CustomerInfoBean implements java.io.Serializable{
        private int customerID;
        private String username;
	private String password;
	private String firstName;
	private String lastName;
	private String email;
	private String address;
	private String city;
	private String postalCode;
	private String phone;
	private String mobilePhone;
        private boolean valid;
        private boolean existEmail;
        private boolean isAdmin;

       public CustomerInfoBean(){
            valid=true;
	}
       
        //getters
	public int getCustomerID(){
		return this.customerID;
	}

	public String getUsername(){
		return this.username;
	}

	public String getPassword(){
		return this.password;
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

	public String getPostalCode(){
		return this.postalCode;
	}

	public String getPhone(){
		return this.phone;
	}

	public String getMobilePhone(){
		return this.mobilePhone;
	}


        public boolean getIsAdmin(){
		return this.isAdmin;
	}


        

        //setters

	public void setCustomerID(int cust_id){
		this.customerID=cust_id;
	}

	public void setUsername(String username){
		this.username=username;
	}

	public void setPassword(String password){
		this.password=password;
	}

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

	public void setPostalCode(String pc){
		this.postalCode=pc;
	}

	public void setPhone(String phone){
		this.phone=phone;
	}

	public void setMobilePhone(String mobilePhone){
		this.mobilePhone=mobilePhone;
	}

        public boolean isValid() { return this.valid; }

        public void setValid(boolean newValid) { this.valid = newValid; }

        public boolean getExistEmail() { return this.existEmail; }

        public void setExistEmail(boolean exist) { this.existEmail = exist; }

        public void setIsAdmin(boolean isAdmin){
            this.isAdmin=isAdmin;
	}



        /** Populates JavaBean with data from a JDBC result set */
   public boolean populate(ResultSet rs) {

      try {
        while (rs.next()) {
          setCustomerID( rs.getInt("secrPerson_id"));
          setFirstname( rs.getString("firstName") );
          setLastname( rs.getString("lastName" ) );
        }
      }
      catch (Exception e) {
         return false;
      }

      return true;
   }
}
