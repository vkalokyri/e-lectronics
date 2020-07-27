package mySqlDAO;

import daoFactories.*;
import daoInterfaces.*;
import java.sql.*;

public class MySqlDAOFactory extends DAOFactory {

   
    public static final String DBURL="jdbc:mysql://localhost:3306/electronics";
    
    
	public static Connection Connection() throws  SQLException{
            Connection conn = null;
		try {
     		Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DBURL,"root","valia");                
                } catch(Exception e) {
                 e.printStackTrace();
                }
                return conn;
                
        }


	public CustomerDAO getCustomerDAO(){
		return new MySqlCustomerDAO();
	}
	
	public ProductDAO getProductDAO(){
		return new MySqlProductDAO();
	}
	
	public OrderDAO getOrderDAO(){
		return new MySqlOrderDAO();
	}
	
	public CategoryDAO getCategoryDAO(){
		return new MySqlCategoryDAO();
	}
	
	public CharacteristicsDAO getCharacteristicsDAO(){
		return new MySqlCharacteristicsDAO();
	}
	
	public BasketDAO getBasketDAO(){
		return new MySqlBasketDAO();
	}

        public ValuesDAO getValuesDAO(){
		return new MySqlValuesDAO();
	}
 
	
}