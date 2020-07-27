package mySqlDAO;

import daoInterfaces.*;
import java.sql.*;
import java.util.Vector;
import model.CategoryInfoBean;

public class MySqlCategoryDAO implements CategoryDAO {
        

        public Vector takeMainCategories() throws SQLException {
           //preparing some objects for connection
            Vector listOfCategories=new Vector();
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String searchQuery = "select name,category_id from category ";
            ResultSet rs = stmt.executeQuery(searchQuery);

            while (rs.next()){
                Vector listOfSubcategories=new Vector();
                CategoryInfoBean cat=new CategoryInfoBean();
                cat.setName(rs.getString(1));
                cat.setCategoryID(rs.getInt(2));
                listOfSubcategories =takeSubcategories(rs.getInt(2));
                cat.setListOfSubcategories(listOfSubcategories);
                listOfCategories.add(cat);

            }
            stmt.close();
            conn.close();
            rs.close();
            

            return listOfCategories;

	}

        public Vector takeSubcategories(int catId) throws SQLException {
           //preparing some objects for connection
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            Vector listOfSubcategories = new Vector();
            String searchQuery = "select name,id from subcategory where cat_id="+catId ;
            ResultSet rs = stmt.executeQuery(searchQuery);
            while(rs.next()){
                CategoryInfoBean subcat=new CategoryInfoBean();
                subcat.setName(rs.getString(1));
                subcat.setCategoryID(rs.getInt(2));
                listOfSubcategories.add(subcat);
            }
            stmt.close();
            conn.close();
            rs.close();

            return listOfSubcategories;

	}
        
	public boolean insertNewCategory(String name)throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            
            String createQuery = "INSERT INTO `category` (`name`) VALUES ('" + name + "');";
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);

            stmt.close();
            conn.close();

            return true;
		
	}

        public boolean insertNewSubcategory(String name,String catName)throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            ResultSet rs;

            String searchQuery = "select category_id from category where name='"+catName+"';";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(searchQuery);
            rs.next();
            int cat_id=rs.getInt(1);

            String createQuery = "INSERT INTO `subcategory` (`name`,`cat_id`) VALUES ('" + name + "','" + cat_id + "');";
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);

            conn.close();
            rs.close();
            stmt.close();

            return true;

	}
        
        public boolean deleteCategory(String name)throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            ResultSet rs;

            String searchQuery = "select category_id from category where name='"+name+"';";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(searchQuery);
            //is a categoryName => delete the whole category
            if(rs.next()){
                int cat_id=rs.getInt(1);
                searchQuery = "select sellingproduct.serial_number from `sellingproduct`,`product` where sellingproduct.serial_number=product.serial_number and cat_id='"+cat_id+"';";
                stmt=conn.createStatement();
                rs = stmt.executeQuery(searchQuery);
                //if there isn't a pending order
                if(!rs.next()){
                    //find all subcategories
                    searchQuery = "select id from subcategory where cat_id='"+cat_id+"';";
                    stmt=conn.createStatement();
                    rs = stmt.executeQuery(searchQuery);
                    while(rs.next()){
                        int subcat_id=rs.getInt(1);
                        String deleteQuery = "delete from `subcategcharacteristics` where subcatID='"+subcat_id+"';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(deleteQuery);
                        deleteQuery = "delete from `product` where subcat_id='"+subcat_id+"';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(deleteQuery);
                        deleteQuery = "delete from `subcategory` where id='"+subcat_id+"';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(deleteQuery);                        
                    }
                    String deleteQuery = "delete from `category` where category_id='"+cat_id+"';";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(deleteQuery);
                    System.out.println("delete "+cat_id);
                }
            }else{
                searchQuery = "select id from subcategory where name='"+name+"';";
                stmt=conn.createStatement();
                rs = stmt.executeQuery(searchQuery);
                //is a subcategoryName => delete the subcategory
                if(rs.next()){
                    int subcat_id=rs.getInt(1);
                    searchQuery = "select sellingproduct.serial_number from `sellingproduct`,`product` where sellingproduct.serial_number=product.serial_number and subcat_id='"+subcat_id+"';";
                    stmt=conn.createStatement();
                    rs = stmt.executeQuery(searchQuery);
                    //if there isn't a pending order
                    if(!rs.next()){
                        System.out.println("Δεν υπάρχει pending παραγγελία");
                        String deleteQuery = "delete from `subcategcharacteristics` where subcatID='"+subcat_id+"';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(deleteQuery);
                        deleteQuery = "delete from `product` where subcat_id='"+subcat_id+"';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(deleteQuery);
                        deleteQuery = "delete from `subcategory` where id='"+subcat_id+"';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(deleteQuery);

                    }

                }
            }
            conn.close();
            rs.close();
            stmt.close();
            
            return true;
	}




	
}
