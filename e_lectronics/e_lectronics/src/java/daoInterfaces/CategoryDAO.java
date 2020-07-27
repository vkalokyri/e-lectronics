package daoInterfaces;


import java.sql.*;
import java.util.Vector;

public interface CategoryDAO {


        public Vector takeMainCategories() throws SQLException ;
        public Vector takeSubcategories(int catId) throws SQLException;
        //public ResultSet getSubcategoriesByCategory(int cat_id) throws SQLException;
	public boolean insertNewCategory(String name) throws SQLException;
        public boolean insertNewSubcategory(String name,String catName)throws SQLException;
        public boolean deleteCategory(String name)throws SQLException;

	
	
	
}
