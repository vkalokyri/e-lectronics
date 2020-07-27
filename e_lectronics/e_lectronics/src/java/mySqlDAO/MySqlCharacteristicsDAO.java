package mySqlDAO;

import daoFactories.*;
import daoInterfaces.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import model.CharacteristicsInfoBean;

public class MySqlCharacteristicsDAO implements CharacteristicsDAO {

        /*public Vector getCharacteristicsbyProduct(int SN) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();            

            String searchQuery = "select name from characteristics,subcategcharacteristics,product where serial_number=" +SN+ " and subcat_id=subcatID and charactID=id;";

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);
            Vector list=null;
            return list;
        }*/

        public Vector getCharacteristicsbySubcategory(int id) throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();           
            Vector characteristics=new Vector();            
            String searchQuery = "select characteristics.* from characteristics,subcategcharacteristics where charactID=id and subcatID="+id+" ;";

            stmt=conn.createStatement();
            ResultSet rs = stmt.executeQuery(searchQuery);

            while(rs.next()){
                CharacteristicsInfoBean charact=new CharacteristicsInfoBean();
                charact.setName(rs.getString(1));
                charact.setID(rs.getInt(2));
                charact.setSubcategId(id);
                characteristics.add(charact);
            }
            stmt.close();
            conn.close();
            rs.close();

            return characteristics;
        }

	public boolean insertCharacteristic(String name,String subcat_name,String cat_name)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            ResultSet rs;

            String searchQuery = "select name from characteristics where name='"+name+"';";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(searchQuery);

            if(!rs.next()){
                searchQuery = "INSERT INTO `characteristics` (`name`) VALUES ('" + name + "');";
                stmt=conn.createStatement();                
                stmt.executeUpdate(searchQuery);
            }
            searchQuery = "select id from characteristics where name='"+name+"';";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(searchQuery);
            rs.next();
            int char_id=rs.getInt(1);

            searchQuery = "select id from subcategory where name='"+subcat_name+"';";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(searchQuery);
            rs.next();
            int subcat_id=rs.getInt(1);
            searchQuery = "INSERT INTO `subcategcharacteristics` (`subcatID`,`charactID`) VALUES ('" + subcat_id + "','" + char_id + "');";
            stmt=conn.createStatement();
            stmt.executeUpdate(searchQuery);
            
            stmt.close();
            conn.close();
            rs.close();
            return true;
		
	}

        
	public boolean deleteCharacteristics(String charName)throws SQLException{
            Connection conn=MySqlDAOFactory.Connection();
            Statement stmt=conn.createStatement();
            ResultSet rs;

            String searchQuery = "select id from characteristics where name='"+charName+"';";
            stmt=conn.createStatement();
            rs = stmt.executeQuery(searchQuery);
            rs.next();
            int char_id=rs.getInt(1);

            String deleteQuery = "delete from subcategcharacteristics where charactID='"+char_id+"';";
            stmt=conn.createStatement();
            stmt.executeUpdate(deleteQuery);

            stmt.close();
            conn.close();
            rs.close();

            return true;

	}
	
	
}
