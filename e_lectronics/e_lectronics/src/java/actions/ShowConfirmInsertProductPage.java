/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CharacteristicsDAO;
import daoInterfaces.ProductDAO;
import daoInterfaces.ValuesDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CharacteristicsInfoBean;
import model.ProductInfoBean;
import model.ValueInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowConfirmInsertProductPage implements Action {

    private String view;
    private ProductInfoBean productBean=new ProductInfoBean();
    private Vector characteristics=new Vector();
    private Vector values=new Vector();
    boolean inserted=true;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowConfirmInsertProductView.jsp";
        HttpSession session=req.getSession();

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
              mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
              session.setAttribute("daoFactory", mysqlFactory);
        }
        ProductDAO prodDao = mysqlFactory.getProductDAO();
        CharacteristicsDAO charactDao = mysqlFactory.getCharacteristicsDAO();
        ValuesDAO valueDao = mysqlFactory.getValuesDAO();

        

        int sn=Integer.parseInt(req.getParameter("sn"));
        productBean.setSerialNumber(sn);
        productBean.setManufacturer(req.getParameter("manufact"));
        productBean.setModel(req.getParameter("model"));
        productBean.setPrice(Double.parseDouble(req.getParameter("price")));
        productBean.setStock(Integer.parseInt(req.getParameter("stock")));
        productBean.setWarranty(req.getParameter("warranty"));
        productBean.setImageUrl(req.getParameter("image"));
        productBean.setThreshold(Integer.parseInt(req.getParameter("thres")));
        productBean.setDescription(req.getParameter("descript"));
        String[] incompatibleProducts=req.getParameterValues("incompatible");
        String[] maxPerformedProducts=req.getParameterValues("maxPerform");
        Vector listOfIncompatibleProducts=new Vector();
        Vector listOfMaxPerformedProducts=new Vector();
        if(incompatibleProducts!=null){
            for(int i=0;i<incompatibleProducts.length;i++){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(incompatibleProducts[i]));
                listOfIncompatibleProducts.add(prod);
            }
        }
        if(maxPerformedProducts!=null){
            for(int i=0;i<maxPerformedProducts.length;i++){
                ProductInfoBean prod=new ProductInfoBean();
                prod.setSerialNumber(Integer.parseInt(maxPerformedProducts[i]));
                listOfMaxPerformedProducts.add(prod);
            }
        }


        int category_id=Integer.parseInt(req.getParameter("category"));

        String subcategory_id=req.getParameter("subcateg"+category_id);
        productBean.setCategoryID(category_id);
        productBean.setSubcategoryID(Integer.parseInt(subcategory_id));
        //insert in product table
        try {
            inserted=prodDao.insertProduct(productBean,new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format( new java.util.Date()));
            if(!inserted){
                view = "./views/ShowNotInsertedProductView.jsp";
            }
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            prodDao.setIncompatibleProducts(productBean.getSerialNumber(),listOfIncompatibleProducts);
            prodDao.setMaxPerformanceProducts(productBean.getSerialNumber(),listOfMaxPerformedProducts);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        //get characteristics for the inserted subcategory
        try {
            characteristics=charactDao.getCharacteristicsbySubcategory(Integer.parseInt(subcategory_id));
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        //insert values for the characteristics
        for(int i=0;i<characteristics.size();i++){
            ValueInfoBean valueBean=new ValueInfoBean();
            int id=((CharacteristicsInfoBean)characteristics.get(i)).getID();            
            String name = req.getParameter("characteristic_"+subcategory_id+"_"+i);
            if (name.equals("")){
                valueBean.setName("-");
            }else{
                valueBean.setName(name);
            }
            valueBean.setCharID(id);
            values.add(valueBean);
        }

        try {
             values=valueDao.insertValues(values);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        //insert values for the specific product
        try {
            valueDao.correspondValueID_SN(values,sn);
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmInsertProductPage.class.getName()).log(Level.SEVERE, null, ex);
        }


        /*Enumeration paramNames = req.getParameterNames();
          while(paramNames.hasMoreElements()) {
            String paramName = (String)paramNames.nextElement();
            String[] paramValues = req.getParameterValues(paramName);
             System.out.println("name="+paramName +"value="+paramValues[0]);
          }*/
        
        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return inserted;
    }

}
