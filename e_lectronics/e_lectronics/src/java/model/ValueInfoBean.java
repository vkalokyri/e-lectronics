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
public class ValueInfoBean implements java.io.Serializable{
    
    private String name;
    private int id;
    private int char_id;
    private Vector listOfValues=new Vector();

    public ValueInfoBean(){
        
    }

    
    public String getName(){
		return this.name;
	}

    public int getID(){
            return this.id;
    }

    public int getCharID(){
            return this.char_id;
    }

    public Vector getListOfValues(){
        return this.listOfValues;
    }

    public void setName(String name){
		this.name=name;
    }

    public void setID(int id){
		this.id=id;
    }

    public void setCharID(int id){
		this.char_id=id;
    }

    public void setListOfValues(Vector list){
	this.listOfValues=list;
    }



}
