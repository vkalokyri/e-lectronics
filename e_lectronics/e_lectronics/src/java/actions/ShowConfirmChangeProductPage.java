/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CharacteristicsDAO;
import daoInterfaces.CustomerDAO;
import daoInterfaces.ProductDAO;
import daoInterfaces.ValuesDAO;
import java.io.IOException;
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
public class ShowConfirmChangeProductPage implements Action {

    private String view;
    private ProductInfoBean productBean=new ProductInfoBean();
    CustomerInfoBean customer;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        view = "./views/ShowConfirmChangesProductView.jsp";
        HttpSession session=req.getSession();

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
        }
        ProductDAO prodDao = mysqlFactory.getProductDAO();
        CharacteristicsDAO charactDao = mysqlFactory.getCharacteristicsDAO();
        ValuesDAO valueDao = mysqlFactory.getValuesDAO();




        int sn=Integer.parseInt(req.getParameter("SN"));
        productBean.setSerialNumber(sn);
        productBean.setManufacturer(req.getParameter("manufact"));
        productBean.setModel(req.getParameter("model"));
        productBean.setPrice(Double.parseDouble(req.getParameter("price")));
        productBean.setStock(Integer.parseInt(req.getParameter("stock")));
        productBean.setWarranty(req.getParameter("warranty"));
        productBean.setImageUrl(req.getParameter("image"));
        productBean.setThreshold(Integer.parseInt(req.getParameter("thres")));
        productBean.setDescription(req.getParameter("descript"));
        int category_id=Integer.parseInt(req.getParameter("category"));
        String subcategory_id=req.getParameter("subcateg"+category_id);
        productBean.setCategoryID(category_id);
        productBean.setSubcategoryID(Integer.parseInt(subcategory_id));

        Vector listOfIncompatibleProducts=new Vector();
        Vector listOfMaxPerformedProducts=new Vector();
        try {            
            listOfIncompatibleProducts=prodDao.getIncompatibleProducts(sn);
            listOfMaxPerformedProducts=prodDao.getMaxPerformanceProducts(sn);
        } catch (SQLException ex) {
            Logger.getLogger(ShowInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        Vector forIncompatibleInsert=new Vector();
        Vector forMaxPerformanceInsert=new Vector();        
        String[] incompatibleSNs=req.getParameterValues("incompatible");
        String[] maxPerformedSns=req.getParameterValues("maxPerform");

        if(incompatibleSNs!=null){
            for(int i=0;i<incompatibleSNs.length;i++){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(incompatibleSNs[i]));
                int found=0;
                for(int j=0;j<listOfIncompatibleProducts.size();j++){
                    if(((ProductInfoBean)listOfIncompatibleProducts.get(j)).getSerialNumber()==Integer.parseInt(incompatibleSNs[i])){
                        listOfIncompatibleProducts.remove(j);
                        found=1;
                        break;
                    }
                }
                if(found==0){
                    forIncompatibleInsert.add(prod);
                }
            }
        }

        if(maxPerformedSns!=null){
            for(int i=0;i<maxPerformedSns.length;i++){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(maxPerformedSns[i]));
                int found=0;
                for(int j=0;j<listOfMaxPerformedProducts.size();j++){
                    if(((ProductInfoBean)listOfMaxPerformedProducts.get(j)).getSerialNumber()==Integer.parseInt(maxPerformedSns[i])){
                        listOfMaxPerformedProducts.remove(j);
                        found=1;
                        break;
                    }
                }
                if(found==0){
                    forMaxPerformanceInsert.add(prod);
                }
            }
        }

        /////////////////////////////////
        for(int j=0;j<listOfMaxPerformedProducts.size();j++){
            System.out.println("MaxPerformforDelete="+((ProductInfoBean)listOfMaxPerformedProducts.get(j)).getSerialNumber());
        }
        for(int j=0;j<forMaxPerformanceInsert.size();j++){
            System.out.println("forInsertMax="+((ProductInfoBean)forMaxPerformanceInsert.get(j)).getSerialNumber());
        }

        for(int j=0;j<forIncompatibleInsert.size();j++){
            System.out.println("forInsert="+((ProductInfoBean)forIncompatibleInsert.get(j)).getSerialNumber());
        }

        for(int j=0;j<listOfIncompatibleProducts.size();j++){
            System.out.println("forDeleteIncomp="+((ProductInfoBean)listOfIncompatibleProducts.get(j)).getSerialNumber());
        }

        //////////////////////////////////
        
        //update product
        try {
            prodDao.deleteIncompatibleProducts(sn,listOfIncompatibleProducts);
            prodDao.deleteMaxPerformanceProducts(sn,listOfMaxPerformedProducts);
            prodDao.setIncompatibleProducts(sn, forIncompatibleInsert);
            prodDao.setMaxPerformanceProducts(sn, forMaxPerformanceInsert);
            prodDao.updateProduct(productBean);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        Vector characteristics=new Vector();
        Vector values=new Vector();
         //get characteristics for the inserted subcategory
        try {
            characteristics=charactDao.getCharacteristicsbySubcategory(Integer.parseInt(subcategory_id));
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        //update values for the characteristics
        for(int i=0;i<characteristics.size();i++){
            ValueInfoBean valueBean=new ValueInfoBean();
            int id=((CharacteristicsInfoBean)characteristics.get(i)).getID();
            String name = req.getParameter("characteristic"+i);
            System.out.println(name);
            if (name.equals("")){
                valueBean.setName("-");
            }else{
                valueBean.setName(name);
            }
            valueBean.setCharID(id);
            values.add(valueBean);
        }

        try {
               valueDao.updateValues(sn,values);
            } catch (SQLException ex) {
               Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
            }


        String action = req.getParameter("action");
        
      if (req.getParameter("un")!=null && req.getParameter("pw")!=null && customer==null){
          customer=new CustomerInfoBean();
          customer.setUsername(req.getParameter("un"));
          customer.setPassword(req.getParameter("pw"));
          System.out.println("un= " +req.getParameter("un"));
          
            // Create a DAO
            CustomerDAO custDAO = mysqlFactory.getCustomerDAO();
            try {
                customer = custDAO.login(customer);
            } catch (SQLException ex) {
                Logger.getLogger(ShowFirstPage.class.getName()).log(Level.SEVERE, null, ex);
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

    public String getView() {
        return view;
    }

    public Object getModel() {
        return null;
    }

}
