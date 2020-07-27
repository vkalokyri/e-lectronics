/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package mySqlDAO;

import daoInterfaces.ValuesDAO;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import model.CharacteristicsInfoBean;
import model.ValueInfoBean;

/**
 *
 * @author Valitsa
 */
public class MySqlValuesDAO implements ValuesDAO {


    public ResultSet getSpecificValuesOfProduct(int SN) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String searchQuery = "select tbl1.name, tbl2.name from (select name, id from characteristics,subcategcharacteristics,product where serial_number="+SN+ " and subcat_id=subcatID and charactID=id) as tbl1 LEFT JOIN (select name, char_id from `values`,productvalues where prod_id="+SN+" and value_id=id) as tbl2 ON tbl1.id = tbl2.char_id;";
            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            return rs;
     }


    public Vector insertValues(Vector listOfValues) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            String searchQuery,createQuery;
            Vector ListOfValues=new Vector();
            

            for(int i=0;i<listOfValues.size();i++){
                
                String name=((ValueInfoBean)listOfValues.get(i)).getName();
                int char_id=((ValueInfoBean)listOfValues.get(i)).getCharID();       
                createQuery = "INSERT INTO `values` (`name`,`char_id`) VALUES ('" + name + "' ,'" + char_id + "' );" ;
               
                
                stmt.executeUpdate(createQuery);
                searchQuery = "select id from `values` where name='" + name + "' and char_id='" + char_id + "';" ;
                
                ResultSet rs = stmt.executeQuery(searchQuery);
                ValueInfoBean valuebean=((ValueInfoBean)listOfValues.get(i));
                while(rs.next()){
                    valuebean.setID(rs.getInt(1));
                }
                ListOfValues.add(i, valuebean);
            }
            stmt.close();
            conn.close();            
            return listOfValues;
    }


    public boolean correspondValueID_SN(Vector listOfValues,int SN) throws SQLException{
        
        Connection conn=MySqlDAOFactory.Connection();
        Statement stmt=conn.createStatement();
        String createQuery;


        for(int i=0;i<listOfValues.size();i++){
            int id=((ValueInfoBean)listOfValues.get(i)).getID();
            createQuery = "insert into productvalues (`prod_id`,`value_id`) values ('" + SN + "' ,'" + id + "' );" ;
            stmt=conn.createStatement();
            stmt.executeUpdate(createQuery);
        }
        stmt.close();
        conn.close();
        return true;
    }


    public CharacteristicsInfoBean getCharacteristicsAndValuesOfProduct(int SN) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();

            String searchQuery = "select tbl1.name, tbl2.name from (select name, id from characteristics,subcategcharacteristics,product where serial_number="+SN+ " and subcat_id=subcatID and charactID=id) as tbl1 LEFT JOIN (select name, char_id from `values`,productvalues where prod_id="+SN+" and value_id=id) as tbl2 ON tbl1.id = tbl2.char_id;";

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            Vector tempList=new Vector();
            Vector tempList2=new Vector();
            CharacteristicsInfoBean charact=new CharacteristicsInfoBean();
            ValueInfoBean values=new ValueInfoBean();
            while (rs.next()){
                ValueInfoBean value=new ValueInfoBean();
                CharacteristicsInfoBean charbean=new CharacteristicsInfoBean();
                charbean.setName(rs.getString(1));
                tempList.add(charbean);
                charact.setListOfCharacteristics(tempList);
                
                value.setName(rs.getString(2));
                tempList2.add(value);
                values.setListOfValues(tempList2);
            }
            
            charact.setValues(values);
            stmt.close();
            conn.close();
            rs.close();

            return charact;
     }

    public boolean updateValues(int SN,Vector listOfValues) throws SQLException{
        Connection conn=MySqlDAOFactory.Connection();
        Statement stmt=conn.createStatement();
        String searchQuery,updateQuery;
        Vector ValueIDs=new Vector();

        searchQuery = "SELECT value_id from productvalues where prod_id="+SN ;        
        ResultSet rs=stmt.executeQuery(searchQuery);

        while(rs.next()){
            int valID=rs.getInt(1);
            ValueIDs.add(valID);
        }

        for(int j=0;j<ValueIDs.size();j++){
        updateQuery = "select char_id from `values` where id="+ValueIDs.get(j)+";" ;
            rs=stmt.executeQuery(updateQuery);
            if(rs.next()){
                int char_id=rs.getInt(1);
                for(int i=0;i<listOfValues.size();i++){
                    if(((ValueInfoBean)listOfValues.get(i)).getCharID()==char_id){
                        String name=((ValueInfoBean)listOfValues.get(i)).getName();
                        updateQuery = "update `values` set name='"+ name+"' where char_id="+char_id+" and id="+ValueIDs.get(j)+"; " ;
                        stmt.executeUpdate(updateQuery);
                        break;
                    }
                }
            }
        }
        stmt.close();
        conn.close();
        rs.close();
        return true;
        
    }




}
