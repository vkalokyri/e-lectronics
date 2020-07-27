/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package daoInterfaces;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;
import model.CharacteristicsInfoBean;

/**
 *
 * @author Valitsa
 */
public interface ValuesDAO {

    public ResultSet getSpecificValuesOfProduct(int SN) throws SQLException;
    public Vector insertValues(Vector listOfValues) throws SQLException;
    public boolean correspondValueID_SN(Vector listOfValues,int SN) throws SQLException;
    public CharacteristicsInfoBean getCharacteristicsAndValuesOfProduct(int SN) throws SQLException;
    public boolean updateValues(int SN,Vector listOfValues) throws SQLException;
}
