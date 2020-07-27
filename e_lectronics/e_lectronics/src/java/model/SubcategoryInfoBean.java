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
public class SubcategoryInfoBean implements java.io.Serializable {

    private String name;
    private int id;
    private Vector listOfCharacteristics;

    public SubcategoryInfoBean(){
        listOfCharacteristics=new Vector();
    }

    //getters
	public String getName(){
		return this.name;
	}

	public int getID(){
		return this.id;
	}

        public Vector getListOfCharacteristics(){
            return this.listOfCharacteristics;
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


}
