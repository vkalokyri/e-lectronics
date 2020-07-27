package daoInterfaces;


import java.sql.SQLException;
import model.CustomerInfoBean;

public interface CustomerDAO {
        public CustomerInfoBean login(CustomerInfoBean bean) throws SQLException;
	public CustomerInfoBean insertCustomer(CustomerInfoBean bean,int isAdmin) throws SQLException;
        public CustomerInfoBean updateCustomer(CustomerInfoBean bean) throws SQLException;
        public CustomerInfoBean retrievePassword(String email) throws SQLException;


	 
	
}
