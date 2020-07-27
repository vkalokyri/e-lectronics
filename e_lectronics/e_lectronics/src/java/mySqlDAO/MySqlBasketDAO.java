package mySqlDAO;


import daoInterfaces.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import model.CartInfoBean;
import model.CustomerInfoBean;
import model.ProductInfoBean;
import model.ProductOrder;


public class MySqlBasketDAO implements BasketDAO{

        public boolean insertCart(CartInfoBean cart)throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String addQuery="insert into cart (`date_of_formation`, `cust_id`,`total_price`) values ('"+cart.getDate()+"','"+cart.getCustomer().getCustomerID()+"','"+cart.getTotalPrice()+"')";
            stmt=conn.createStatement();
            stmt.executeUpdate(addQuery);

            String searchQuery="select cart_id from cart where date_of_formation='"+cart.getDate()+"' and cust_id='"+cart.getCustomer().getCustomerID()+"'";
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);
            if(rs.next()){
                int cart_id=rs.getInt(1);
                for(int i=0;i<cart.getListOfProducts().size();i++){
                addQuery="insert into cartproducts (`cart_id`, `serial_number`, `amount`) values ('"+cart_id+"','"+((ProductOrder)cart.getListOfProducts().get(i)).getProductID()+"','"+((ProductOrder)cart.getListOfProducts().get(i)).getNumItems()+"')";
                stmt=conn.createStatement();
                stmt.executeUpdate(addQuery);
                }
            }
            stmt.close();
            conn.close();
            rs.close();
            return true;
        }


	public Vector findCartsbyCustomerID(int id)throws SQLException{
            Vector listOfCarts = new Vector();           

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String searchQuery="select * from cart where cust_id='"+id+"'";
            stmt=conn.createStatement();
            ResultSet rset=stmt.executeQuery(searchQuery);

            while(rset.next()){
                CartInfoBean cart=new CartInfoBean();
                cart.setCartID(rset.getInt(1));
                cart.setDate(rset.getString(2));
                cart.setTotalPrice(rset.getInt(4));                
                listOfCarts.add(cart);
            }
            stmt.close();
            conn.close();
            rset.close();
            return listOfCarts;
	}
        
        public CartInfoBean findProductsbyCartID(int id)throws SQLException{
            
            Vector products=new Vector();
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            
            String searchQuery="select * from cart where cart_id='"+id+"'";
            stmt=conn.createStatement();
            ResultSet rset=stmt.executeQuery(searchQuery);
            CartInfoBean cart=new CartInfoBean();
            if(rset.next()){                
                cart.setCartID(rset.getInt(1));
                CustomerInfoBean customer=new CustomerInfoBean();
                customer.setCustomerID(rset.getInt(3));
                cart.setCustomer(customer);
                cart.setDate(rset.getString(2));
                cart.setTotalPrice(rset.getInt(4));
                       
                searchQuery="select * from cartproducts where cart_id='"+id+"'";
                stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(searchQuery);
                while(rs.next()){
                    int sn=rs.getInt(2);
                    searchQuery="select model,price,image_url,cat_id,subcat_id from product where serial_number='"+sn+"'";
                    stmt=conn.createStatement();
                    ResultSet rst=stmt.executeQuery(searchQuery);
                    rst.next();
                    ProductInfoBean prod=new ProductInfoBean();
                    ProductOrder prodOrd=new ProductOrder();
                    prod.setSerialNumber(sn);
                    prod.setModel(rst.getString(1));
                    prod.setPrice(rst.getInt(2));
                    prod.setImageUrl(rst.getString(3));
                    prod.setCategoryID(rst.getInt(4));
                    prod.setSubcategoryID(rst.getInt(5));
                    prodOrd.setProduct(prod);
                    prodOrd.setNumItems(rs.getInt(3));
                    products.add(prodOrd);
                }
                cart.setListOfProducts(products);
                rs.close();
            }
             stmt.close();
            conn.close();
            rset.close();
            
            return cart;
	}

        public boolean deleteCart(String[] ids)throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String delQuery;
            for(int i=0;i<ids.length;i++){
                delQuery="delete from cartproducts where cart_id="+ids[i]+"; ";
                stmt=conn.createStatement();
                stmt.executeUpdate(delQuery);
                delQuery="delete from cart where cart_id="+ids[i]+"; ";
                stmt=conn.createStatement();
                stmt.executeUpdate(delQuery);
            }
             stmt.close();
            conn.close();
            return true;
        }
	
}
