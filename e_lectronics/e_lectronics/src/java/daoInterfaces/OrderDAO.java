package daoInterfaces;

import java.util.*;
import java.sql.SQLException;
import model.OrderInfoBean;

public interface OrderDAO {
	public OrderInfoBean insertOrder(OrderInfoBean order) throws SQLException;
        public boolean updateOrder(OrderInfoBean order) throws SQLException;
        public Vector findOrders(OrderInfoBean order,String startDate,String endDate)throws SQLException;	
	public Vector findOrdersbyCustomerID(int customer_id)throws SQLException;
        public OrderInfoBean findProductsOrderedByOrder(int order_id)throws SQLException;
        public boolean changeOrdersStatus(String[] orderIDs,String newStatus) throws SQLException;
		
	
	
	 
	
}
