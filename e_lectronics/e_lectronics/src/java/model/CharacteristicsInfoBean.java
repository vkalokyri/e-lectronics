/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.util.Vector;

/**
 *
 * @author Valitsa
 */
public class CharacteristicsInfoBean implements java.io.Serializable {
    private String name;
    private int id;
    private int subcategId;
    private ValueInfoBean values;
    private Vector listOfCharacteristics=new Vector();

    public CharacteristicsInfoBean(){
        
    }


    public String getName(){
		return this.name;
	}

    public int getID(){
            return this.id;
    }

    public ValueInfoBean getValues(){
            return this.values;
    }

    public Vector getListOfCharacteristics(){
		return this.listOfCharacteristics;
    }

    public int getSubcategId(){
            return this.subcategId;
    }

    public void setName(String name){
		this.name=name;
    }

    public void setID(int id){
		this.id=id;
    }

    public void setListOfCharacteristics(Vector list){
		this.listOfCharacteristics=list;
    }

    public void setValues(ValueInfoBean value){
		this.values=value;
    }

    public void setSubcategId(int id){
		this.subcategId = id;
    }


}
