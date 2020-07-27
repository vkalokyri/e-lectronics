package mySqlDAO;

import daoInterfaces.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.CustomerInfoBean;


public class MySqlCustomerDAO implements CustomerDAO {

        	
       public CustomerInfoBean login(CustomerInfoBean bean) throws SQLException {
       //preparing some objects for connection
       Connection conn=MySqlDAOFactory.Connection();
        
        String username = bean.getUsername();
        String password = bean.getPassword();
        String searchQuery = "select firstname,lastname,address,email,city,zip,phone,mobile_phone,id,isAdmin from users where username='" + username + "' AND password='" + password + "'";
        // "System.out.println" prints in the console; Normally used to trace the process
        System.out.println("Your user name is " + username);
        System.out.println("Your password is " + password);
        System.out.println("Query: "+searchQuery);

        Statement stmt=conn.createStatement();
        ResultSet rs = stmt.executeQuery(searchQuery);
        boolean more = rs.next();
 
        if (!more) 
        { System.out.println("Sorry, you are not a registered user! Please sign up first");
          bean.setValid(false); } 
        //if user exists set the isValid variable to true 
        else if (more) 
        { String firstName = rs.getString("firstname");
          String lastName = rs.getString("lastname");
          String address = rs.getString("address");
          String email = rs.getString("email");
          String city = rs.getString("city");
          String zip = rs.getString("zip");
          String phone = rs.getString("phone");
          String mobile_phone = rs.getString("mobile_phone");
          int id = rs.getInt("id");
          System.out.println(id);
          bean.setFirstname(firstName);
          bean.setLastname(lastName);
          bean.setAddress(address);
          bean.setEmail(email);
          bean.setCity(city);
          bean.setPostalCode(zip);
          bean.setPhone(phone);
          bean.setMobilePhone(mobile_phone);
          bean.setCustomerID(id);
          bean.setIsAdmin(false);
          if(rs.getInt("isAdmin")==1){
             bean.setIsAdmin(true);}
          bean.setValid(true);
        }

        stmt.close();
        conn.close();
        rs.close();

        return bean;

	}

        public CustomerInfoBean insertCustomer(CustomerInfoBean bean,int isAdmin) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            String username = bean.getUsername();
            String password = bean.getPassword();
            String email=bean.getEmail();
            String firstname=bean.getFirstname();
            String lastname=bean.getLastname();
            String street=bean.getAddress();
            String city=bean.getCity();
            String zip=bean.getPostalCode();
            String phone=bean.getPhone();
            String mobile=bean.getMobilePhone();

            String existsUsername="select * from users where username='" + username + "'";
            Statement stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(existsUsername);
            boolean existUsername = rs.next();

            String existsEmail="select * from users where email='" + email + "'";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(existsEmail);            
           
            boolean existEmail = rs.next();

            if (existEmail){
              System.out.println("Sorry,there is another user with that email");
              bean.setExistEmail(true);              
            }
            if (existUsername){
                //if user exists set the isValid variable to false
              System.out.println("Sorry,there is another user with that username");
              bean.setValid(false);
            }else if (!existUsername && !existEmail){
                String createQuery = "INSERT INTO `users` (`username`,`password`,`firstname`,`lastname`,`address`,`email`,`city`,`zip`,`phone`, `mobile_phone`,`isAdmin` ) VALUES ('" + username + "' ,'" + password + "' ,'" + firstname + "' ,'" + lastname + "' ,'" + street + "' ,'" + email + "' ,'" + city + "' ,'" + zip + "' ,'" + phone + "' ,'" + mobile + "','"+isAdmin+"' );" ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);

                createQuery = "select id from `users` where username= '" + username + "';" ;
                stmt=conn.createStatement();
                rs=stmt.executeQuery(createQuery);
                if(rs.next()){
                    bean.setCustomerID(rs.getInt(1));
                }

                bean.setValid(true);
                bean.setExistEmail(false);}

            stmt.close();
            conn.close();
            rs.close();
            
            return bean;  
			
	}

        public CustomerInfoBean updateCustomer(CustomerInfoBean bean) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            String username= bean.getUsername();
            String password = bean.getPassword();
            String email=bean.getEmail();
            String firstname=bean.getFirstname();
            String lastname=bean.getLastname();
            String street=bean.getAddress();
            String city=bean.getCity();
            String zip=bean.getPostalCode();
            String phone=bean.getPhone();
            String mobile=bean.getMobilePhone();

            String existsUsername="select username from users where email='" + email + "'";
            Statement stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(existsUsername);
            
            
            if(rs.next()){
                if(!rs.getString(1).equals(username)){
                    System.out.println("Sorry,there is another user with that email");
                    bean.setExistEmail(true);
                    bean.setValid(false);
                    return bean;
                }
            }

            String createQuery = " UPDATE `users` SET password='" + password + "', firstname='" + firstname + "' ,lastname= '" + lastname + "', address= '" + street + "', email='" + email + "', city='" + city + "', zip= '" + zip + "', phone='" + phone + "', mobile_phone='" + mobile + "' WHERE username='" + username + "';";

            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);
            bean.setValid(true);
            bean.setExistEmail(false);

            stmt.close();
            conn.close();
            rs.close();
            
           return bean;
	}
        
	public CustomerInfoBean retrievePassword(String email) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            CustomerInfoBean customer=new CustomerInfoBean();
            String searchQuery="select username,password from users where email='" + email + "'";
            Statement stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            if(rs.next()){
                customer.setUsername(rs.getString(1));
                customer.setPassword(rs.getString(2));
                customer.setValid(true);
                
                return customer;
            }
            customer.setValid(false);
             
            return customer;
        }

    
	
	
}
