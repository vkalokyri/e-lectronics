package daoInterfaces;

import java.util.*;
import java.sql.SQLException;
import model.CartInfoBean;

public interface BasketDAO {

	public Vector findCartsbyCustomerID(int id)throws SQLException;
        public boolean insertCart(CartInfoBean cart)throws SQLException;
        public CartInfoBean findProductsbyCartID(int id)throws SQLException;
        public boolean deleteCart(String[] ids)throws SQLException;
		
	
	/*
	 * (non-javadoc)
	 */
	
	 
}
