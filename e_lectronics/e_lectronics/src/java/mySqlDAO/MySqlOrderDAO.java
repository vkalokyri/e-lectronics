package mySqlDAO;

import daoInterfaces.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;;
import model.OrderInfoBean;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.Vector;
import model.CreditCardInfoBean;
import model.CustomerInfoBean;
import model.ProductInfoBean;
import model.ProductOrder;


public class MySqlOrderDAO implements OrderDAO {

	public OrderInfoBean insertOrder(OrderInfoBean order) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String street=order.getAddress();
            String firstname= order.getFirstname();
            String lastname= order.getLastname();
            String email =order.getEmail();
            String mobile =order.getMobilePhone();
            String phone=order.getPhone();
            int zip=order.getPostalCode();
            Date date=order.getDate();
            String status=order.getStatus();
            int cust_id=order.getCustomer().getCustomerID();
            double total_price=order.getTotal_price();
            String payment=order.getPaymentType();
            String dispatch=order.getDispatchType();
            String city=order.getCity();
            System.out.println(cust_id);

            //elegxoume mipws i idia paraggelia uparxei idi
            String searchQuery="select order_id from `order` where status='" + status + "' AND date='" + date + "' AND total_price='" + total_price + "' AND customer_id='" + cust_id + "' AND payment_type='" + payment + "' AND dispatch_type='" + dispatch + "' AND  dispatch_address='" + street + "' AND city='" + city + "' AND phone='" + phone + "' AND mobile_phone='" + mobile + "' AND zip='" + zip + "' AND firstname='" + firstname + "' AND lastname='" + lastname + "' AND email='" + email + "'";
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);
            order.setOrderExists(true);
            
            if(!rs.next()){
                String addQuery = "INSERT INTO `order` (`status`,`date`,`total_price`,`customer_id`,`payment_type`,`dispatch_type`,`dispatch_address`,`city`,`phone`, `mobile_phone`,`zip`,`firstname`,`lastname`,`email`) VALUES ('" + status + "' ,'" + date + "' ,'" + total_price + "','" + cust_id + "','" + payment + "','" + dispatch + "' ,'" + street + "' ,'" + city + "','" + phone + "' ,'" + mobile + "' ,'" + zip + "','" + firstname + "' ,'" + lastname + "' ,'" + email + "'   );" ;
                stmt=conn.createStatement();
                stmt.executeUpdate(addQuery);
                order.setOrderExists(false);
            } else{order.setOrderId(rs.getInt(1));}

            //find order_id
            searchQuery="select order_id from `order` where status='" + status + "' AND date='" + date + "' AND total_price='" + total_price + "' AND customer_id='" + cust_id + "' AND payment_type='" + payment + "' AND dispatch_type='" + dispatch + "' AND  dispatch_address='" + street + "' AND city='" + city + "' AND phone='" + phone + "' AND mobile_phone='" + mobile + "' AND zip='" + zip + "' AND firstname='" + firstname + "' AND lastname='" + lastname + "' AND email='" + email + "'";
            stmt=conn.createStatement();
            ResultSet rsOrderID=stmt.executeQuery(searchQuery);

            if(rsOrderID.next()){
            order.setOrderId(rsOrderID.getInt(1));
            //elegxos an i paraggelia einai me pistwtiki
            String num=null;
            if (order.getCreditCard()!=null){
                CreditCardInfoBean card=order.getCreditCard();                
                num=card.getCardNum();
                if (num!=null){
                    searchQuery="select * from creditcard where card_num='" + num + "' " ;
                    stmt=conn.createStatement();
                    rs=stmt.executeQuery(searchQuery);
                    //uparxei idi i pistwtiki
                    if(!rs.next()){
                        int cvv=card.getCvv();
                        String type=card.getCardType();
                        String month=card.getExpireMonth();
                        String name=card.getCardHolderName();
                        String cardphone=card.getCardHolderPhone();
                        int year=card.getExpireYear();
                        String createQuery="INSERT INTO creditcard (`card_type`,`card_num`,`cvv`,`expire_month`,`cardHolderName`,`cardHolderPhone`,`expire_year`,`order_id`) VALUES ('" + type + "' ,'" + num + "' ,'" + cvv + "','" + month + "','" + name + "','" + cardphone + "' ,'" + year + "','" + rsOrderID.getInt(1) + "'  );" ;
                        stmt=conn.createStatement();
                        stmt.executeUpdate(createQuery);
                    }
               }
            }

                order.setListOfOrderedProducts(order.getListOfOrderedProducts());
                for (int i=0;i<order.getListOfOrderedProducts().size();i++){
                    ProductOrder product=((ProductOrder)order.getListOfOrderedProducts().get(i));                    
                    String addQuery="INSERT INTO sellingproduct (`serial_number`,`order_id`,`amount`) VALUES ('" + product.getProductID() + "' ,'" + rsOrderID.getInt(1) + "' ,'" + product.getNumItems() + "' );" ;
                    stmt=conn.createStatement();
                    stmt.executeUpdate(addQuery);

                    

                    addQuery="update product set stock=stock-"+product.getNumItems()+" where serial_number='" + product.getProductID() + "' ;" ;
                    stmt=conn.createStatement();
                    stmt.executeUpdate(addQuery);
                }
            }

            stmt.close();
            conn.close();
            rs.close();

            return order;
	}


        public Vector findOrdersbyCustomerID(int customer_id)throws SQLException{
		
                Vector listOfOrders=new Vector();
                OrderInfoBean order;
                Connection conn=MySqlDAOFactory.Connection();
                Statement stmt=conn.createStatement();
                String searchQuery="select * from `order` where customer_id='"+ customer_id + "' ";
                stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(searchQuery);

                //System.out.println(rs.next());
                //for each order
                while(rs.next()){
                    order=new OrderInfoBean();                    
                    order.setOrderId(rs.getInt(1));
                    order.setStatus(rs.getString(2));
                    order.setDate(rs.getDate(3));
                    order.setTotal_price(rs.getInt(4));
                    order.setPaymentType(rs.getString(6));
                    order.setDispatchType(rs.getString(7));
                    order.setAddress(rs.getString(8));
                    order.setCity(rs.getString(9));
                    order.setPhone(rs.getString(10));
                    order.setMobilePhone(rs.getString(11));
                    order.setPostalCode(rs.getInt(12));
                    order.setFirstname(rs.getString(13));
                    order.setLastname(rs.getString(14));
                    order.setEmail(rs.getString(15));                    
                    listOfOrders.add(order);
                }
                stmt.close();
                conn.close();
                rs.close();

		return listOfOrders;
	}

        public OrderInfoBean findProductsOrderedByOrder(int order_id)throws SQLException{

            Vector listOfProducts=new Vector();
            OrderInfoBean order=new OrderInfoBean();
            CustomerInfoBean cust=new CustomerInfoBean();
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String searchQuery="select * from `order` where order_id='"+ order_id + "' ";
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);

            //System.out.println(rs.next());
            //for each order
            while(rs.next()){
                order.setOrderId(rs.getInt(1));
                order.setStatus(rs.getString(2));
                order.setDate(rs.getDate(3));
                order.setTotal_price(rs.getInt(4));
                cust.setCustomerID(rs.getInt(5));
                order.setCustomer(cust);
                order.setPaymentType(rs.getString(6));               
                order.setDispatchType(rs.getString(7));
                order.setAddress(rs.getString(8));
                order.setCity(rs.getString(9));
                order.setPhone(rs.getString(10));
                order.setMobilePhone(rs.getString(11));
                order.setPostalCode(rs.getInt(12));
                order.setFirstname(rs.getString(13));
                order.setLastname(rs.getString(14));
                order.setEmail(rs.getString(15));
            }

                
                searchQuery="select * from `sellingproduct` where order_id='"+ order_id + "' ";
                stmt=conn.createStatement();
                ResultSet rset=stmt.executeQuery(searchQuery);

                
                //for each product ordered in specific order
                while(rset.next()){
                    
                    searchQuery="select * from `product` where serial_number='"+ rset.getInt(1) + "' ";
                    stmt=conn.createStatement();
                    ResultSet rs2=stmt.executeQuery(searchQuery);
                    rs2.next();
                    
                    //while(rs2.next())   {
                          
                        ProductInfoBean prod=new ProductInfoBean();
                        prod.setSerialNumber(rs2.getInt(1));
                        prod.setManufacturer(rs2.getString(2));
                        prod.setModel(rs2.getString(3));
                        prod.setPrice(rs2.getDouble(4));
                        prod.setWarranty(rs2.getString(6));
                        prod.setImageUrl(rs2.getString(8));
                        prod.setCategoryID(rs2.getInt(9));
                        prod.setSubcategoryID(rs2.getInt(10));
                        prod.setDescription(rs2.getString(11));
                        ProductOrder product=new ProductOrder(prod);
                        product.setNumItems(rset.getInt(3));
                        listOfProducts.add(product);
                
                }
                order.setListOfOrderedProducts(listOfProducts);

                stmt.close();
                conn.close();
                rs.close();
                return order;
            
         }

        public boolean updateOrder(OrderInfoBean order) throws SQLException{

            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            int order_id=order.getOrderId();
            String street=order.getAddress();
            String firstname= order.getFirstname();
            String lastname= order.getLastname();
            String email =order.getEmail();
            String mobile =order.getMobilePhone();
            String phone=order.getPhone();
            int zip=order.getPostalCode();
            Date date=order.getDate();
            String status=order.getStatus();
            int cust_id=order.getCustomer().getCustomerID();
            double total_price=order.getTotal_price();
            String payment=order.getPaymentType();
            String dispatch=order.getDispatchType();
            String city=order.getCity();

            String createQuery="update `order` set status='" + status + "', date='" + date + "' , total_price='" + total_price + "' , customer_id='" + cust_id + "' , payment_type='" + payment + "', dispatch_type='" + dispatch + "',  dispatch_address='" + street + "' , city='" + city + "' , phone='" + phone + "' , mobile_phone='" + mobile + "' , zip='" + zip + "', firstname='" + firstname + "' , lastname='" + lastname + "' , email='" + email + "'  WHERE order_id='" + order_id + "';";
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);


            //CREDIT-CARD
            String num=null;
            if (order.getCreditCard()!=null){
                CreditCardInfoBean card=order.getCreditCard();
                num=card.getCardNum();                
                String searchQuery="select * from creditcard where order_id='" + order_id + "' " ;
                stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(searchQuery);
                //an den uparxei idi i pistwtiki
                if(!rs.next()){
                    int cvv=card.getCvv();
                    
                    String type=card.getCardType();
                    String month=card.getExpireMonth();
                    String name=card.getCardHolderName();
                    String cardphone=card.getCardHolderPhone();
                    int year=card.getExpireYear();
                    createQuery="INSERT INTO creditcard (`card_type`,`card_num`,`cvv`,`expire_month`,`cardHolderName`,`cardHolderPhone`,`expire_year`,`order_id`) VALUES ('" + type + "' ,'" + num + "' ,'" + cvv + "','" + month + "','" + name + "','" + cardphone + "' ,'" + year + "','" + order_id + "'  );" ;
                    stmt=conn.createStatement();
                    stmt.executeUpdate(createQuery);
                }else{
                    int cvv=card.getCvv();
                    String type=card.getCardType();
                    String month=card.getExpireMonth();
                    String name=card.getCardHolderName();
                    String cardphone=card.getCardHolderPhone();
                    int year=card.getExpireYear();
                    createQuery="update creditcard set card_type='" + type + "', card_num='" + num + "' , cvv='" + cvv + "' , expire_month='" + month + "' , cardHolderName='" + name + "' cardHolderPhone='" + cardphone + "',  expire_year='" + year + "' , order_id='" + order_id + "' WHERE order_id='" + order_id + "';";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(createQuery);
                }
            }else if(order.getCreditCard()==null){
                String searchQuery="select * from creditcard where order_id='" + order_id + "' " ;
                stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery(searchQuery);
                if(rs.next()){
                    createQuery="delete from creditcard where order_id='" + order_id + "';";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(createQuery);
                }
            }


            //PRODUCTS
            String searchQuery="select * from `sellingproduct` where order_id='"+ order_id + "' ";
            stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);

            boolean exists=true;
            while(rs.next()){
                exists=true;
                for(int i=0;i<order.getListOfOrderedProducts().size();i++){
                    ProductOrder product=(ProductOrder)order.getListOfOrderedProducts().get(i);
                    if(product.getProductID().equals(rs.getString(1))){
                        createQuery="update sellingproduct set amount='" + product.getNumItems() + "' where order_id='" + order_id + "' and serial_number='" + rs.getString(1) + "';";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(createQuery);
                        exists=false;
                    }                    
                }
                if (exists){
                    createQuery="delete from sellingproduct where serial_number='" + rs.getString(1) + "' and order_id='" + order_id + "';";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(createQuery);
                }
            }

            stmt.close();
            conn.close();
            rs.close();

            return true;
            
            
        }

        public Vector findOrders(OrderInfoBean order,String startDate,String endDate)throws SQLException{
            Vector listOfOrders=new Vector();
            Connection conn=MySqlDAOFactory.Connection();
            String status="";
            String dispatch="";
            String payment="";
            int id=0;
            CustomerInfoBean customer=null;
            CustomerInfoBean cust=new CustomerInfoBean() ;
            String searchQuery="select * from `order` ";
            Statement stmt=conn.createStatement();
            ResultSet rs=stmt.executeQuery(searchQuery);

            status=order.getStatus();
            dispatch=order.getDispatchType();
            payment=order.getPaymentType();
            
            if (order.getOrderId()!=0){
                id=order.getOrderId();
            }
            if (order.getCustomer().getCustomerID()!=0){
                customer=order.getCustomer();
            }
            if (!order.getCustomer().getLastname().equals("")){
                customer=order.getCustomer();
            }

            String includeStatus="";
            String includeDispatch="";
            String includePayment="";
            String includeDate="";
            System.out.println(status);
            if (!status.equals("All")) includeStatus="status='"+ status + "' and ";
            if (!dispatch.equals("All")) includeDispatch="dispatch_type='" + dispatch + "' and ";
            if (!payment.equals("All")) includePayment="payment_type='"+ payment + "' and ";
            System.out.println(startDate);
            if ((!startDate.equals("--")) && (!endDate.equals("--"))){
                includeDate="Date BETWEEN '" +startDate+ "' and '" +endDate+ "' ";
                searchQuery="select * from `order` where " + includeStatus+includeDispatch+includePayment+ includeDate+"   ";
                System.out.println(searchQuery);
                stmt=conn.createStatement();
                rs=stmt.executeQuery(searchQuery);
            }
            if ((startDate.equals("--")) || (endDate.equals("--"))){
                startDate="2000-01-01";
                endDate="2020-01-01";
                includeDate="Date BETWEEN '" +startDate+ "' and '" +endDate+ "' ";
                searchQuery="select * from `order` where " + includeStatus+includeDispatch+includePayment+ includeDate+"   ";
                System.out.println(searchQuery);
                stmt=conn.createStatement();
                rs=stmt.executeQuery(searchQuery);
            }


            String includeOrdID="";
            String includeCustID="";
            String includeLastName="";
            
            if (id!=0) includeOrdID="order_id='"+ id + "' and ";
            
            if (id!=0 && customer==null){
                searchQuery="select * FROM `order` where order_id='"+ id + "'  ";
                stmt=conn.createStatement();
                rs=stmt.executeQuery(searchQuery);
            }

            if(customer!=null){
                 if(customer.getCustomerID()!=0){
                     includeCustID="customer_id='" + customer.getCustomerID() + "' and ";
                 }
             }
            if(customer!=null){
                 if(!customer.getLastname().equals("")){
                     includeLastName="lastname='" + customer.getLastname() + "' ";
                     searchQuery="select * FROM `order` where " + includeOrdID + includeCustID +  includeLastName+"  ";
                     stmt=conn.createStatement();
                     rs=stmt.executeQuery(searchQuery);
                 }
                 if(customer.getLastname().equals("")){
                     includeLastName="lastname!='" + 12345 + "' ";
                     searchQuery="select * FROM `order` where " + includeOrdID + includeCustID +  includeLastName+"  ";
                     stmt=conn.createStatement();
                     rs=stmt.executeQuery(searchQuery);
                 }
             }
            

            while(rs.next()){
                OrderInfoBean ord=new OrderInfoBean();
                ord.setOrderId(rs.getInt(1));
                ord.setStatus(rs.getString(2));
                ord.setDate(rs.getDate(3));
                ord.setTotal_price(rs.getInt(4));
                cust.setCustomerID(rs.getInt(5));
                ord.setCustomer(cust);
                ord.setPaymentType(rs.getString(6));
                ord.setDispatchType(rs.getString(7));
                ord.setAddress(rs.getString(8));
                ord.setCity(rs.getString(9));
                ord.setPhone(rs.getString(10));
                ord.setMobilePhone(rs.getString(11));
                ord.setPostalCode(rs.getInt(12));
                ord.setFirstname(rs.getString(13));
                ord.setLastname(rs.getString(14));
                ord.setEmail(rs.getString(15));
                listOfOrders.add(ord);
            }

            stmt.close();
            conn.close();
            rs.close();

            return listOfOrders;


        }


        public boolean changeOrdersStatus(String[] orderIDs,String newStatus) throws SQLException{
            Vector listOfOrders=new Vector();
            Connection conn=MySqlDAOFactory.Connection();
            String updateQuery,searchQuery;
            Statement stmt=conn.createStatement();

            if(!newStatus.equals("Προς Διαγραφή")){
                for(int i=0;i<orderIDs.length;i++){
                    updateQuery="update `order` set status='"+newStatus+"' where order_id="+orderIDs[i]+";";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(updateQuery);
                }
            }else{
                for(int i=0;i<orderIDs.length;i++){
                    updateQuery="delete from creditcard where order_id='"+orderIDs[i]+"' ;";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(updateQuery);
                    updateQuery="select serial_number,amount from sellingproduct where order_id='"+orderIDs[i]+"' ;";
                    stmt=conn.createStatement();
                    ResultSet rs=stmt.executeQuery(updateQuery);
                    while(rs.next()){
                        updateQuery="update product set stock=stock+"+rs.getInt(2)+" where serial_number="+rs.getInt(1)+" ;";
                        stmt=conn.createStatement();
                        stmt.executeUpdate(updateQuery);
                    }
                    updateQuery="delete from sellingproduct where order_id='"+orderIDs[i]+"' ;";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(updateQuery);
                    updateQuery="delete from `order` where order_id='"+orderIDs[i]+"' ;";
                    stmt=conn.createStatement();
                    stmt.executeUpdate(updateQuery);
                    rs.close();
                }
                
            }

            stmt.close();
            conn.close();
            

            return true;

        }

	
	
	
}
