package mySqlDAO;

import daoInterfaces.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import model.ProductInfoBean;


public class MySqlProductDAO implements ProductDAO {        
    

    public Vector getProductsByCategory(int cat_id) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();            
            Statement stmt=conn.createStatement();            
           
            String searchQuery = "select serial_number,model,price,image_url,subcat_id from product where cat_id="+ cat_id;

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
                        
            Vector tempList=new Vector();
            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(rs.getString(1)));
                prod.setModel(rs.getString(2));
                prod.setPrice(Double.parseDouble(rs.getString(3)));
                prod.setImageUrl(rs.getString(4));
                prod.setSubcategoryID(Integer.parseInt(rs.getString(5)));
                tempList.add(prod);
            }

            stmt.close();
            conn.close();
            rs.close();
            
            return tempList;
    }

    public Vector getProductsBySubcategory(int subcat_id,String orderBy) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String searchQuery = "select serial_number,model,price,image_url from product where subcat_id="+ subcat_id+" order by price " +orderBy+ " ;";
            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            Vector tempList=new Vector();
            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(rs.getString(1)));
                prod.setModel(rs.getString(2));
                prod.setPrice(Double.parseDouble(rs.getString(3)));
                prod.setImageUrl(rs.getString(4));
                tempList.add(prod);
            }

            stmt.close();
            conn.close();
            rs.close();

            return tempList;
        }
     

    public Vector getAllProducts() throws SQLException{
        Connection conn=MySqlDAOFactory.Connection();
        //String searchQuery = "select id from subcategory where cat_id='" + cat_id + "'";
        Statement stmt=conn.createStatement();
        //ResultSet rs = stmt.executeQuery(searchQuery);

        Vector list=new Vector();
        String searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product ORDER BY serial_number ASC;";
        stmt=conn.createStatement();
        ResultSet rs = stmt.executeQuery(searchQuery);
        while(rs.next()){
            ProductInfoBean prod=new ProductInfoBean();
            prod.setSerialNumber(rs.getInt(1));
            prod.setModel(rs.getString(2));
            prod.setPrice(rs.getInt(3));
            prod.setImageUrl(rs.getString(4));
            prod.setCategoryID(rs.getInt(5));
            prod.setSubcategoryID(rs.getInt(6));
            list.add(prod);
        }

        stmt.close();
        conn.close();
        rs.close();

        return list;
    }



     public ResultSet getProductBasicCharacteristics(int SN) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();            
            Statement stmt=conn.createStatement();
            Vector productlist=new Vector();

            String searchQuery = "select manufacturer,model,price,image_url,description,warranty,serial_number from product where serial_number="+ SN;

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            return rs;
        }


     public ProductInfoBean getProduct(String productID) throws SQLException{
            ProductInfoBean product=new ProductInfoBean();
            Connection conn=MySqlDAOFactory.Connection();

            Statement stmt=conn.createStatement();

            String searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where serial_number="+ Integer.parseInt(productID);

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            if (productID==null){
                return null;
            }
           while (rs.next()){               
                if(rs.getString(1).equals(productID)){
                    product.setSerialNumber(Integer.parseInt(rs.getString(1)));
                    product.setModel(rs.getString(2));
                    product.setPrice(Double.parseDouble(rs.getString(3)));
                    product.setImageUrl(rs.getString(4));
                    product.setCategoryID(rs.getInt(5));
                    product.setSubcategoryID(rs.getInt(6));
                    stmt.close();
                    conn.close();
                    rs.close();
                    return product;
                }
            }
        stmt.close();
        conn.close();
        rs.close();

        return null;
     }

	public boolean insertProduct(ProductInfoBean productBean,String date) throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            int sn=productBean.getSerialNumber();
            String manufact=productBean.getManufacturer();
            String model=productBean.getModel();
            Double price=productBean.getPrice();
            int stock=productBean.getStock();
            String warranty=productBean.getWarranty();
            String image_url=productBean.getImageUrl();
            int thres=productBean.getThreshold();
            String descript=productBean.getDescription();
            int cat_id=productBean.getCategoryID();
            int subcat_id=productBean.getSubcategoryID();
            if(image_url.equals("-")) image_url="images/noImage.jpg";

            String searchQuery = "select serial_number from product where serial_number='" + sn + "';" ;
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);
            if(rs.next()){
               return false;
            }

            String createQuery = "INSERT INTO product (`serial_number`,`manufacturer`,`model`,`price`,`stock`,`warranty`,`threshold`,`image_url`,`cat_id`, `subcat_id`,`description`,`insertionDate` ) VALUES ('" + sn + "' ,'" + manufact + "' ,'" + model + "' ,'" + price + "' ,'" + stock + "' ,'" + warranty + "' ,'" + thres + "' ,'" + image_url + "' ,'" + cat_id + "' ,'" + subcat_id + "','" + descript + "', '" + date + "' );" ;
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);

            stmt.close();
            conn.close();            
            return true;
                      
	}


        public ProductInfoBean getProductCharacteristics(int sn) throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String searchQuery = "select manufacturer,model,price,image_url,description,warranty,stock,threshold,cat_id,subcat_id from product where serial_number="+ sn;

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            ProductInfoBean prod=new ProductInfoBean();            
            
            while(rs.next()){
                prod.setManufacturer(rs.getString(1));
                prod.setModel(rs.getString(2));
                prod.setPrice(rs.getDouble(3));
                prod.setImageUrl(rs.getString(4));
                prod.setDescription(rs.getString(5));
                prod.setWarranty(rs.getString(6));
                prod.setStock(rs.getInt(7));
                prod.setThreshold(rs.getInt(8));
                prod.setSubcategoryID(rs.getInt(10));
                prod.setCategoryID(rs.getInt(9));
            }
            stmt.close();
            conn.close();
            rs.close();

            return prod;
        }


	public boolean updateProduct(ProductInfoBean productBean) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            int sn=productBean.getSerialNumber();
            String manufact=productBean.getManufacturer();
            String model=productBean.getModel();
            Double price=productBean.getPrice();
            int stock=productBean.getStock();
            String warranty=productBean.getWarranty();
            String image_url=productBean.getImageUrl();
            int thres=productBean.getThreshold();
            String descript=productBean.getDescription();
            int cat_id=productBean.getCategoryID();
            int subcat_id=productBean.getSubcategoryID();

            String createQuery = "update product set  manufacturer='" + manufact + "', model='" + model + "' ,price='" + price + "' ,stock='" + stock + "', warranty='" + warranty + "' ,threshold='" + thres + "',image_url='" + image_url + "',cat_id='" + cat_id + "', subcat_id='" + subcat_id + "',description='" + descript + "' where serial_number='" + sn + "' ; " ;
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);

            stmt.close();
            conn.close();
            

            return true;
        }



	public boolean deleteProduct(int serial_num) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String createQuery;


            //check if there is a pending order
            String searchQuery = "select order_id from sellingproduct where serial_number="+serial_num+" ; " ;
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);

            if(rs.next()){
                return false;
            }

            searchQuery = "select value_id from productvalues where prod_id="+serial_num+" ; " ;
            stmt=conn.createStatement();
            rs=stmt.executeQuery(searchQuery);

            while(rs.next()){
                createQuery = "delete from productvalues where prod_id="+serial_num+" and value_id="+rs.getInt(1)+" ; " ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);
                createQuery = "delete from `values`where id="+rs.getInt(1)+" ; " ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);
            }

            createQuery = "delete from incompatible where serial_number="+serial_num+" or incompatibleSN="+serial_num+" ; " ;
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);

            createQuery = "delete from maxperformance where serial_number="+serial_num+" or maxPerformanceSN="+serial_num+" ; " ;
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);

            createQuery = "delete from `product`where serial_number="+serial_num+" ; " ;
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);
            
            stmt.close();
            conn.close();
            rs.close();

            return true;
	}


        public Vector getProductsThresholds(String startThres, String endThres,String category,String subcat)throws SQLException{

            Vector list=new Vector();
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String searchQuery;
            ResultSet rs;
            //check if there is a pending order
            if(category.equals("all")){
                if(!startThres.equals("") && !endThres.equals("")){
                    searchQuery = "select serial_number,model,stock,image_url,cat_id,subcat_id from product where stock between '" +startThres+ "' and '" +endThres+ "'; " ;
                    stmt=conn.createStatement();
                    rs=stmt.executeQuery(searchQuery);
                }else{
                    searchQuery = "select serial_number,model,stock,image_url,cat_id,subcat_id from product where stock<threshold; " ;
                    stmt=conn.createStatement();
                    rs=stmt.executeQuery(searchQuery);
                }
            }else{                
                if(subcat.equals("all")){
                    if(!startThres.equals("") && !endThres.equals("")){
                        searchQuery = "select serial_number,model,stock,image_url,cat_id,subcat_id from product where cat_id="+category+" and stock between '" +startThres+ "' and '" +endThres+ "'; " ;
                        stmt=conn.createStatement();
                        rs=stmt.executeQuery(searchQuery);
                    }else{
                        searchQuery = "select serial_number,model,stock,image_url,cat_id,subcat_id from product where cat_id="+category+" and stock<threshold " ;
                        stmt=conn.createStatement();
                        rs=stmt.executeQuery(searchQuery);
                    }
                }else{
                    if(!startThres.equals("") && !endThres.equals("")){
                        searchQuery = "select serial_number,model,stock,image_url,cat_id,subcat_id from product where cat_id="+category+" and subcat_id="+subcat+" and stock between " +startThres+ " and " +endThres+ "; " ;
                        stmt=conn.createStatement();
                        rs=stmt.executeQuery(searchQuery);
                    }else{
                        searchQuery = "select serial_number,model,stock,image_url,cat_id,subcat_id from product where cat_id="+category+" and subcat_id="+subcat+" and stock<threshold " ;
                        stmt=conn.createStatement();
                        rs=stmt.executeQuery(searchQuery);
                    }
                }
            }

            while(rs.next()){
                
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(rs.getInt(1));
                prod.setModel(rs.getString(2));
                prod.setStock(rs.getInt(3));
                prod.setImageUrl(rs.getString(4));
                prod.setCategoryID(rs.getInt(5));
                prod.setSubcategoryID(rs.getInt(6));
                list.add(prod);
            }

            stmt.close();
            conn.close();
            rs.close();

            return list;

        }


        public Vector getProductsFromSearch(String keywords, String words,String order,String excludeWords,String categ,String subcat,String startPrice,String endPrice) throws SQLException{
            Vector list=new Vector();
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String searchQuery;
            ResultSet rs = null;
            String[] keys=keywords.split(" ");
            String[] exclude_word=excludeWords.split(" ");
            String exclude="";
            String includePrice="";
            if(keywords.equals("")){
                return list;
            }
            
            if(!startPrice.equals("") && !endPrice.equals("")){
                includePrice=" price between "+startPrice+" and "+endPrice+" and ";
            }
            
            if(!excludeWords.equals("")){
                exclude=" and model not like '%"+exclude_word[0]+"%' ";
                for(int i=1;i<exclude_word.length;i++){
                    exclude=exclude+" and model not like '%"+exclude_word[i]+"%' ";
                }
            }
           
            if(categ.equals("all")){
                if(order.equals("all")){
                    if(keys.length!=0){
                        String includeLikes="model like '%"+keys[0]+"%' ";
                        for(int i=1;i<keys.length;i++){
                          includeLikes=includeLikes+words+" model like '%"+keys[i]+"%' ";
                        }
                        searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where "+includePrice+" ("+includeLikes+exclude+") ;" ;
                        System.out.println(searchQuery);
                        stmt=conn.createStatement();
                        rs= stmt.executeQuery(searchQuery);
                    }         
                }else if(order.equals("specific")){
                    if(keys.length!=0){
                        String keywordbeg="'%";
                        String keyword="";
                        for(int i=0;i<keys.length;i++){
                          keyword=keyword+keys[i]+"%";
                        }
                        keyword=keywordbeg+keyword+"'";
                        searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where "+includePrice+" model like "+keyword+exclude+" ;" ;
                        System.out.println(searchQuery);
                        stmt=conn.createStatement();
                        rs= stmt.executeQuery(searchQuery);
                    }
                     
                }
                while(rs.next()){
                    ProductInfoBean prod=new ProductInfoBean();
                    prod.setSerialNumber(rs.getInt(1));
                    prod.setModel(rs.getString(2));
                    prod.setPrice(rs.getInt(3));
                    prod.setImageUrl(rs.getString(4));
                    prod.setCategoryID(rs.getInt(5));
                    prod.setSubcategoryID(rs.getInt(6));
                    list.add(prod);
                 }
                 return list;
            }else{
                if(subcat.equals("all")){
                    if(order.equals("all")){
                        if(keys.length!=0){
                            String includeLikes="model like '%"+keys[0]+"%' ";
                            for(int i=1;i<keys.length;i++){
                              includeLikes=includeLikes+words+" model like '%"+keys[i]+"%' ";
                            }
                            searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where cat_id="+categ+" and "+includePrice+" ("+includeLikes+exclude+") ;" ;
                            System.out.println(searchQuery);
                            stmt=conn.createStatement();
                            rs= stmt.executeQuery(searchQuery);
                        }
                    }else if(order.equals("specific")){
                        if(keys.length!=0){
                            String keywordbeg="'%";
                            String keyword="";
                            for(int i=0;i<keys.length;i++){
                              keyword=keyword+keys[i]+"%";
                            }
                            keyword=keywordbeg+keyword+"'";
                            searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where cat_id="+categ+" and "+includePrice+" model like "+keyword+exclude+" ;" ;
                            System.out.println(searchQuery);
                            stmt=conn.createStatement();
                            rs= stmt.executeQuery(searchQuery);
                        }
                    }                    
                }else{
                    if(order.equals("all")){
                        if(keys.length!=0){
                            String includeLikes="model like '%"+keys[0]+"%' ";
                            for(int i=1;i<keys.length;i++){
                              includeLikes=includeLikes+words+" model like '%"+keys[i]+"%' ";
                            }
                            searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where cat_id="+categ+" and subcat_id="+subcat+" and "+includePrice+" ("+includeLikes+exclude+") ;" ;
                            System.out.println(searchQuery);
                            stmt=conn.createStatement();
                            rs= stmt.executeQuery(searchQuery);
                        }
                    }else if(order.equals("specific")){
                         if(keys.length!=0){
                            String keywordbeg="'%";
                            String keyword="";
                            for(int i=0;i<keys.length;i++){
                              keyword=keyword+keys[i]+"%";
                            }
                            keyword=keywordbeg+keyword+"'";
                            searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where cat_id="+categ+" and subcat_id="+subcat+" and "+includePrice+" model like "+keyword+exclude+" ;" ;
                            System.out.println(searchQuery);
                            stmt=conn.createStatement();
                            rs= stmt.executeQuery(searchQuery);
                        }
                        
                    }
                }
                while(rs.next()){
                    ProductInfoBean prod=new ProductInfoBean();
                    prod.setSerialNumber(rs.getInt(1));
                    prod.setModel(rs.getString(2));
                    prod.setPrice(rs.getInt(3));
                    prod.setImageUrl(rs.getString(4));
                    prod.setCategoryID(rs.getInt(5));
                    prod.setSubcategoryID(rs.getInt(6));
                    list.add(prod);
                 }
                stmt.close();
                conn.close();
                rs.close();
                return list;
            }


        }

        public boolean setIncompatibleProducts(int sn,Vector productsSN)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();           
            String createQuery;
            String searchQuery;
            ResultSet rs;
            
            for(int i=0;i<productsSN.size();i++){
                searchQuery = "select * from incompatible where incompatibleSN='" + sn + "' and serial_number='"+((ProductInfoBean)productsSN.get(i)).getSerialNumber()+"';" ;
                stmt=conn.createStatement();
                rs=stmt.executeQuery(searchQuery);
                if(!rs.next()){
                    createQuery = "INSERT INTO incompatible (`serial_number`, `incompatibleSN`) VALUES ('" + sn + "' ,'" + ((ProductInfoBean)productsSN.get(i)).getSerialNumber() + "');" ;
                    stmt=conn.createStatement();
                    stmt.executeUpdate(createQuery);
                }
                rs.close();
            }

            conn.close();
            stmt.close();
            


            return true;
        }

        public boolean deleteIncompatibleProducts(int sn,Vector productsSN)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String createQuery;
            for(int i=0;i<productsSN.size();i++){
                createQuery = "delete from incompatible where serial_number='" + sn + "' and incompatibleSN='" + ((ProductInfoBean)productsSN.get(i)).getSerialNumber() + "';" ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);
                createQuery = "delete from incompatible where incompatibleSN='" + sn + "' and serial_number='" + ((ProductInfoBean)productsSN.get(i)).getSerialNumber() + "';" ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);
            }

            conn.close();
            stmt.close();


            return true;
        }

        
	public boolean setMaxPerformanceProducts(int sn,Vector productsSN)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String createQuery;
            String searchQuery;
            ResultSet rs=null;

            
            for(int i=0;i<productsSN.size();i++){
                searchQuery = "select * from maxperformance where maxPerformanceSN='" + sn + "' and serial_number='"+((ProductInfoBean)productsSN.get(i)).getSerialNumber()+"';" ;
                stmt=conn.createStatement();
                rs=stmt.executeQuery(searchQuery);
                if(!rs.next()){
                    createQuery = "INSERT INTO maxperformance (`serial_number`, `maxPerformanceSN`) VALUES ('" + sn + "' ,'" + ((ProductInfoBean)productsSN.get(i)).getSerialNumber() + "');" ;
                    stmt=conn.createStatement();
                    stmt.executeUpdate(createQuery);
                }
                rs.close();
            }

            conn.close();
            stmt.close();
            
            return true;
        }

        public boolean deleteMaxPerformanceProducts(int sn,Vector productsSN)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String createQuery;
            for(int i=0;i<productsSN.size();i++){
                createQuery = "delete from maxperformance where serial_number='" + sn + "' and maxPerformanceSN='" + ((ProductInfoBean)productsSN.get(i)).getSerialNumber() + "';" ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);
                createQuery = "delete from maxperformance where maxPerformanceSN='" + sn + "' and serial_number='" + ((ProductInfoBean)productsSN.get(i)).getSerialNumber() + "';" ;
                stmt=conn.createStatement();
                stmt.executeUpdate(createQuery);
            }

            conn.close();
            stmt.close();
            return true;
        }

        public Vector getIncompatibleProducts(int sn)throws SQLException{
            
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            Vector listOfIncompatibleProducts=new Vector();
            String searchQuery="select incompatibleSN from incompatible where serial_number='"+sn+"'";
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);

            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(rs.getInt(1));
                searchQuery="select model,image_url from product where serial_number='"+rs.getInt(1)+"'";
                stmt=conn.createStatement();
                ResultSet rset=stmt.executeQuery(searchQuery);
                if(rset.next()){
                    prod.setModel(rset.getString(1));
                    prod.setImageUrl(rset.getString(2));
                }
                rset.close();
                listOfIncompatibleProducts.add(prod);
            }

            searchQuery="select serial_number from incompatible where incompatibleSN='"+sn+"'";
            stmt=conn.createStatement();
            rs=stmt.executeQuery(searchQuery);

            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(rs.getInt(1));
                searchQuery="select model,image_url from product where serial_number='"+rs.getInt(1)+"'";
                stmt=conn.createStatement();
                ResultSet rset=stmt.executeQuery(searchQuery);
                if(rset.next()){
                    prod.setModel(rset.getString(1));
                    prod.setImageUrl(rset.getString(2));
                }
                rset.close();
                listOfIncompatibleProducts.add(prod);
            }

            conn.close();
            stmt.close();
            rs.close();
            

            return listOfIncompatibleProducts;
        }


	public Vector getMaxPerformanceProducts(int sn)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            Vector listOfMaxPerformanceProducts=new Vector();
            String searchQuery="select maxPerformanceSN from maxperformance where serial_number='"+sn+"'";
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);

            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(rs.getInt(1));
                searchQuery="select model,image_url from product where serial_number='"+rs.getInt(1)+"'";
                stmt=conn.createStatement();
                ResultSet rset=stmt.executeQuery(searchQuery);
                if(rset.next()){
                    prod.setModel(rset.getString(1));
                    prod.setImageUrl(rset.getString(2));
                }
                rset.close();
                listOfMaxPerformanceProducts.add(prod);
            }

            searchQuery="select serial_number from maxperformance where maxPerformanceSN='"+sn+"'";
            stmt=conn.createStatement();
            rs=stmt.executeQuery(searchQuery);

            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(rs.getInt(1));
                searchQuery="select model,image_url from product where serial_number='"+rs.getInt(1)+"'";
                stmt=conn.createStatement();
                ResultSet rset=stmt.executeQuery(searchQuery);
                if(rset.next()){
                    prod.setModel(rset.getString(1));
                    prod.setImageUrl(rset.getString(2));
                }
                rset.close();
                listOfMaxPerformanceProducts.add(prod);
            }

            conn.close();
            stmt.close();
            rs.close();


            return listOfMaxPerformanceProducts;
        }

        public Vector getTheNewestProducts(String date,int limit,String orderBy)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            Vector newestProducts=new Vector();
            String searchQuery;
            if(limit>0){
                searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id FROM product where DATE(insertionDate)> SUBDATE(CURDATE(), INTERVAL 30 DAY) order by insertionDate desc limit "+limit+";";
                System.out.println(searchQuery);
            }else{
                searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id FROM product where DATE(insertionDate)> SUBDATE(CURDATE(), INTERVAL 30 DAY) order by price "+orderBy+";";
            }

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            
            while(rs.next()){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(rs.getString(1)));
                prod.setModel(rs.getString(2));
                prod.setPrice(Double.parseDouble(rs.getString(3)));
                prod.setImageUrl(rs.getString(4));
                prod.setCategoryID(rs.getInt(5));
                prod.setSubcategoryID(rs.getInt(6));
                newestProducts.add(prod);
            }

            stmt.close();
            conn.close();
            rs.close();

            return newestProducts;

        }

        public Vector getTheMostPopularProducts(String date,int limit,String orderBy)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            Vector popularProducts=new Vector();
            //String searchQuery = "select sellingproduct.serial_number, sum(sellingproduct.amount) as nc from sellingproduct group by sellingproduct.serial_number order by nc desc limit 3;";
            String searchQuery;
            if(limit>0){
                searchQuery = "select sellingproduct.serial_number,`date`, sum(sellingproduct.amount) as nc from sellingproduct,`order` where sellingproduct.order_id=`order`.order_id and `date`> SUBDATE(CURDATE(), INTERVAL 30 DAY) group by sellingproduct.serial_number order by nc desc limit "+limit+";";
                stmt=conn.createStatement();
                ResultSet rset = stmt.executeQuery(searchQuery);
                while(rset.next()){
                    int sn=rset.getInt(1);
                    searchQuery = "select serial_number,model,price,image_url,cat_id,subcat_id from product where serial_number="+sn+" ;";
                    System.out.println(searchQuery);
                    stmt=conn.createStatement();
                    ResultSet rs = stmt.executeQuery(searchQuery);
                    while(rs.next()){
                        ProductInfoBean prod=new ProductInfoBean();
                        prod.setSerialNumber(Integer.parseInt(rs.getString(1)));
                        prod.setModel(rs.getString(2));
                        prod.setPrice(Double.parseDouble(rs.getString(3)));
                        prod.setImageUrl(rs.getString(4));
                        prod.setCategoryID(rs.getInt(5));
                        prod.setSubcategoryID(rs.getInt(6));
                        popularProducts.add(prod);
                    }
                    rs.close();
                }
                stmt.close();
                conn.close();
                rset.close();
            }else{
                searchQuery = searchQuery = "select product.serial_number,model,price,image_url,cat_id,subcat_id,sellingproduct.serial_number,`date`, sum(sellingproduct.amount) as nc from sellingproduct,`order`,product where product.serial_number=sellingproduct.serial_number and sellingproduct.order_id=`order`.order_id and `date`> SUBDATE(CURDATE(), INTERVAL 30 DAY) group by sellingproduct.serial_number order by price "+orderBy+";";
                stmt=conn.createStatement();
                ResultSet rs = stmt.executeQuery(searchQuery);
                while(rs.next()){
                    ProductInfoBean prod=new ProductInfoBean();
                    prod.setSerialNumber(Integer.parseInt(rs.getString(1)));
                    prod.setModel(rs.getString(2));
                    prod.setPrice(Double.parseDouble(rs.getString(3)));
                    prod.setImageUrl(rs.getString(4));
                    prod.setCategoryID(rs.getInt(5));
                    prod.setSubcategoryID(rs.getInt(6));
                    popularProducts.add(prod);
                }
                rs.close();
                stmt.close();
                conn.close();
            }          

            

            return popularProducts;

        }





	
}
