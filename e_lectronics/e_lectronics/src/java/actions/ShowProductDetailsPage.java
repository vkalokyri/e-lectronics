/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.*;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
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
public class ShowProductDetailsPage implements Action {

     /** Page to be used to display data */
   private String view;
   //ProductInfoBean prodbean=new ProductInfoBean();
   CharacteristicsInfoBean charact=new CharacteristicsInfoBean();
   ValueInfoBean values=new ValueInfoBean();
   ProductInfoBean prod=new ProductInfoBean();
   CustomerInfoBean customer;
   //CategoryInfoBean categ=new CategoryInfoBean();


   public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

      HttpSession session=req.getSession();
      String SN=req.getParameter("SerialNumber");
      prod.setSerialNumber(Integer.parseInt(SN));      
      String category_id=req.getParameter("CategID");
      String subcategory_id=req.getParameter("SubcategID");

      session.setAttribute("previousProductPageUrl",req.getQueryString());

      Vector current=(Vector)session.getAttribute("CurrentMenu");
        if(current==null){
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
          session.setAttribute("CurrentMenu",current);
       }

      current.add(0,category_id);
      current.add(1,subcategory_id);
      session.setAttribute("CurrentMenu", current);

      //DAOFactory mysqlFactory = DAOFactory.getDAOFactory(DAOFactory.mySQL);
      DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");

       if(mysqlFactory==null){
          mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
          session.setAttribute("daoFactory", mysqlFactory);
       }
        // Create a DAO
      
      ValuesDAO valDAO = mysqlFactory.getValuesDAO();
      ProductDAO prodDAO = mysqlFactory.getProductDAO();
     // CategoryDAO catDAO = mysqlFactory.getCategoryDAO();
      
        try {

            ResultSet rs = prodDAO.getProductBasicCharacteristics(Integer.parseInt(SN));
            
            while(rs.next()){
                prod.setManufacturer(rs.getString(1));
                prod.setModel(rs.getString(2));
                prod.setPrice(rs.getDouble(3));
                prod.setImageUrl(rs.getString(4));
                prod.setDescription(rs.getString(5));
                prod.setWarranty(rs.getString(6));
            }

            //rs = charDAO.getCharacteristicsbyProduct(Integer.parseInt(SN));

            Vector tempList=charact.getListOfCharacteristics();

            //while (rs.next()){
             //   CharacteristicsInfoBean charbean=new CharacteristicsInfoBean();
             //   charbean.setName(rs.getString(1));
             //   tempList.add(charbean);
             //   charact.setListOfCharacteristics(tempList);
           // }

           // prod.setCharacteristics(charact);

            rs = valDAO.getSpecificValuesOfProduct(Integer.parseInt(SN));

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
            //categ.setProduct(prod);           

        } catch (SQLException ex) {
            Logger.getLogger(ShowProductDetailsPage.class.getName()).log(Level.SEVERE, null, ex);
        }


      
      view = "./views/ShowProductDetailsView.jsp";

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
                Logger.getLogger(ShowProductDetailsPage.class.getName()).log(Level.SEVERE, null, ex);
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
       return prod;
   }

   /** Return the page name (and path) to display the view */
   public String getView() {
       return view;
   }

}