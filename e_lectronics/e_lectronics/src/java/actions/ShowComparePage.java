/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CustomerDAO;
import daoInterfaces.ProductDAO;
import daoInterfaces.ValuesDAO;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CharacteristicsInfoBean;
import model.CustomerInfoBean;
import model.ProductInfoBean;
import model.ValueInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowComparePage implements Action {

     /** Page to be used to display data */
   private String view;
   //CategoryInfoBean categ=new CategoryInfoBean();
   ProductInfoBean product=new ProductInfoBean();
   CustomerInfoBean customer=new CustomerInfoBean();

   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

    HttpSession session=req.getSession();

    Vector current=(Vector)session.getAttribute("CurrentMenu");
    if(current==null){
      current=new Vector();
      current.add(0, "-1");
      current.add(1, "-1");
      session.setAttribute("CurrentMenu",current);
   }

    DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
    //DAOFactory mysqlFactory = DAOFactory.getDAOFactory(DAOFactory.mySQL);

        if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }

    ProductDAO prodDAO = mysqlFactory.getProductDAO();
    ValuesDAO valDAO = mysqlFactory.getValuesDAO();

    ResultSet rs;
    Vector productlist=new Vector();

    Enumeration paramNames = req.getParameterNames();
    while(paramNames.hasMoreElements()) {
      String paramName = (String)paramNames.nextElement();
      //System.out.println( paramName );
      String[] paramValues = req.getParameterValues(paramName);

         System.out.println( paramValues.length );
                try {
                    int integ;
                    try{
                        integ=Integer.parseInt(paramValues[0]);
                    }catch(Exception e){
                        break;
                    }
                    rs = prodDAO.getProductBasicCharacteristics(Integer.parseInt(paramValues[0]));

                    ProductInfoBean prod=new ProductInfoBean();
                    while (rs.next()) {
                    prod.setManufacturer(rs.getString(1));
                    prod.setModel(rs.getString(2));
                    prod.setPrice(rs.getInt(3));
                    prod.setImageUrl(rs.getString(4));
                    prod.setDescription(rs.getString(5));
                    prod.setWarranty(rs.getString(6));
                    prod.setSerialNumber(rs.getInt(7));
                    productlist.add(prod);
                    product.setListOfProducts(productlist);
                    }

                   rs = valDAO.getSpecificValuesOfProduct(Integer.parseInt(paramValues[0]));

                   CharacteristicsInfoBean charact=new CharacteristicsInfoBean();
                    ValueInfoBean values=new ValueInfoBean();
                    Vector tempList=charact.getListOfCharacteristics();
                    Vector tempList2=values.getListOfValues();

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

                    prod.setCharacteristics(charact);
                    charact.setValues(values);

                     //prod.setCharacteristics(charact);


                    //rs = charDAO.getCharacteristicsbyProduct(Integer.parseInt(SN));
                    } catch (SQLException ex) {
                        Logger.getLogger(ShowComparePage.class.getName()).log(Level.SEVERE, null, ex);
                    }

   }
    view = "./views/ShowCompareView.jsp";

    String action = req.getParameter("action");

      if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
          customer=new CustomerInfoBean();
          customer.setUsername(req.getParameter("un"));
          customer.setPassword(req.getParameter("pw"));
          System.out.println("un= " +req.getParameter("un"));
          mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

           if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
           }
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(ShowComparePage.class.getName()).log(Level.SEVERE, null, ex);
            }

          /** Set the view */
          if (action != null  && customer.isValid()) {
             session.setAttribute("CustomerInfo", customer);

          }
          else{
                view = "./views/ShowWrongLoginView.jsp";
          }
      }

    return true;
   }
   /** Return the page name (and path) to display the view */
   public Object getModel() {
       return product;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}