/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

/**
 *
 * @author Valitsa
 */
public class CreditCardInfoBean implements java.io.Serializable {

    
    private String cardType;
    private String cardNum;
    private int cvv;
    private String expireMonth;
    private int expireYear;
    private String cardHolderName;
    private String cardHolderPhone;


    public CreditCardInfoBean(){

    }


    public String getCardType(){
        return this.cardType;
    }

    public String getCardHolderName(){
        return this.cardHolderName;
    }

    public String getCardNum(){
        return this.cardNum;
    }

    public int getCvv(){
        return this.cvv;
    }

    public String getCardHolderPhone(){
        return this.cardHolderPhone;
    }

    public String getExpireMonth(){
        return this.expireMonth;
    }

    public int getExpireYear(){
        return this.expireYear;
    }


    public void setCardType(String type){
        this.cardType=type;
    }

    public void setCardHolderName(String name ){
        this.cardHolderName=name;
    }

    public void setCardNum(String num){
        this.cardNum=num;
    }

    public void setCvv(int cvv){
        this.cvv=cvv;
    }

    public void setCardHolderPhone(String phone){
        this.cardHolderPhone=phone;
    }

    public void setExpireMonth(String month){
        this.expireMonth=month;
    }

    public void setExpireYear(int year){
        this.expireYear=year;
    }

}
