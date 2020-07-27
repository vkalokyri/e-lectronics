package daoInterfaces;


import java.sql.SQLException;
import java.util.Vector;


public interface CharacteristicsDAO {

        //public Vector getCharacteristicsbyProduct(int SN) throws SQLException;
        public Vector getCharacteristicsbySubcategory(int id) throws SQLException;
	public boolean insertCharacteristic(String name,String subcat_name,String cat_name)throws SQLException;
	public boolean deleteCharacteristics(String charName)throws SQLException;
		
	
	/*
	 * (non-javadoc)
	 */
	 
}
