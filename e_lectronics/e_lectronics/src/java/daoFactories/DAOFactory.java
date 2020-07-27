package daoFactories;


import daoInterfaces.*;
import mySqlDAO.*;

public abstract class DAOFactory {
	public static final int mySQL=1;
	
	
	public abstract CustomerDAO getCustomerDAO();
	public abstract ProductDAO getProductDAO();
	public abstract OrderDAO getOrderDAO();
	public abstract CategoryDAO getCategoryDAO();
	public abstract CharacteristicsDAO getCharacteristicsDAO();
        public abstract ValuesDAO getValuesDAO();
        public abstract BasketDAO getBasketDAO();
	
	public static DAOFactory getDAOFactory(int whichFactory){
		switch(whichFactory){
			case mySQL: 
				return new MySqlDAOFactory();
			default:
				return null;
		}
	}
	
}