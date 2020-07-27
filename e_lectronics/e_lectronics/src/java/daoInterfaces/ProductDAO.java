package daoInterfaces;


import java.sql.*;
import java.util.Vector;
import model.ProductInfoBean;

public interface ProductDAO {

        public Vector getProductsByCategory(int cat_id) throws SQLException;
        public Vector getProductsBySubcategory(int subcat_id,String orderBy) throws SQLException;
        public ResultSet getProductBasicCharacteristics(int SN) throws SQLException;
        public ProductInfoBean getProduct(String productID) throws SQLException;
	    public boolean insertProduct(ProductInfoBean product,String date) throws SQLException;
	    public boolean updateProduct(ProductInfoBean product) throws SQLException;
	    public boolean deleteProduct(int serial_num)throws SQLException;
        public ProductInfoBean getProductCharacteristics(int sn) throws SQLException;
        public Vector getProductsThresholds(String startThres, String endThres, String category, String subcat)throws SQLException;
        public Vector getProductsFromSearch(String keywords, String words,String order,String excludeWords,String category,String subcat,String startPrice,String endPrice) throws SQLException;
        public Vector getAllProducts() throws SQLException;
        public boolean setIncompatibleProducts(int sn,Vector products)throws SQLException;
	    public boolean setMaxPerformanceProducts(int sn,Vector products)throws SQLException;
        public Vector getIncompatibleProducts(int sn)throws SQLException;
        public Vector getMaxPerformanceProducts(int sn)throws SQLException;
        public boolean deleteMaxPerformanceProducts(int sn,Vector productsSN)throws SQLException;
        public boolean deleteIncompatibleProducts(int sn,Vector productsSN)throws SQLException;
        public Vector getTheNewestProducts(String date,int limit,String orderBy)throws SQLException;
        public Vector getTheMostPopularProducts(String date,int limit,String orderBy)throws SQLException;
	
	/*
	 * (non-javadoc)
	 */
	//public static final Product product = null;
	 
	
	
}
