/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import daoFactories.DAOFactory;
import daoInterfaces.CategoryDAO;
import daoInterfaces.CharacteristicsDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CategoryInfoBean;
import model.CharacteristicsInfoBean;
import model.SubcategoryInfoBean;

/**
 *
 * @author Valitsa
 */
public class ShowConfirmCategoriesChangesPage  implements Action { 
    

    private String view;
    private Vector Categories=new Vector();
    private Vector listOfCategories=new Vector();

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        view = "./views/ShowConfirmChangesCategoryView.jsp";
        HttpSession session=req.getSession();

        DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
        if(mysqlFactory==null){
            mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
            session.setAttribute("daoFactory", mysqlFactory);
        }
        CharacteristicsDAO charactDao = mysqlFactory.getCharacteristicsDAO();

        
        String[] categValues = req.getParameterValues("category");
        for (int i=0;i<categValues.length;i++){
            
            Vector Subcategories=new Vector();
            CategoryInfoBean categ=new CategoryInfoBean();
            String value=categValues[i];
            String [] temp;
            temp=value.split("_");
            int cat_id=Integer.parseInt(temp[0]);
            categ.setCategoryID(cat_id);
            categ.setName(temp[1]);
            String[] subcatValues = req.getParameterValues("subcateg"+cat_id);
            if(subcatValues!=null){
                for (int j=0;j<subcatValues.length;j++){
                    Vector Characteristics=new Vector();
                    SubcategoryInfoBean subcateg=new SubcategoryInfoBean();
                    value=subcatValues[j];
                    temp=value.split("_");
                    int subcat_id;
                    if(temp[0].startsWith("new")){
                        subcat_id=-1;
                    }else{
                        subcat_id=Integer.parseInt(temp[0]);
                    }
                    subcateg.setID(subcat_id);
                    subcateg.setName(temp[1]);
                    Subcategories.add(subcateg);
                    categ.setListOfSubcategories(Subcategories);
                    String[] charactValues = req.getParameterValues("characteristic"+temp[0]);
                    if(charactValues!=null){
                        for (int m=0;m<charactValues.length;m++){
                            CharacteristicsInfoBean charact=new CharacteristicsInfoBean();
                            value=charactValues[m];
                            temp=value.split("_");
                            if(temp.length==4){
                                charact.setSubcategId(Integer.parseInt(temp[1]));
                                charact.setName(temp[3]);
                            }else if(temp.length==6){
                                charact.setSubcategId(Integer.parseInt(temp[2]));
                                charact.setName(temp[5]);
                            }

                            Characteristics.add(charact);
                            subcateg.setListOfCharacteristics(Characteristics);
                        }
                    }
                }
            }
            Categories.add(categ);
        }


        CategoryDAO catDAO = mysqlFactory.getCategoryDAO();
        try {
            listOfCategories = catDAO.takeMainCategories();
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        //delete the elements that weren't changed and add in forDelete list
        //the elements that are going to be deleted
        String categName;
        String subcategName;
        String charact;
        int subcategID;
        CategoryInfoBean findCateg=new CategoryInfoBean();
        SubcategoryInfoBean findSubcateg=new SubcategoryInfoBean();
        Vector characteristics=new Vector();
        Vector forDelete=new Vector();
        int i=0;
        for(i=0;i<listOfCategories.size();i++){
           categName=((CategoryInfoBean)listOfCategories.get(i)).getName();
           int m;
           int foundCateg=0;
           for(m=0;m<Categories.size();m++){
               if(((CategoryInfoBean)Categories.get(m)).getName().equals(categName)){
                    findCateg=(CategoryInfoBean)Categories.get(m);
                    foundCateg=1;
                    break;
               }
           }
           if(foundCateg!=0){
               for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
                   subcategName=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName();
                   subcategID=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID();
                   int l;
                   int foundSubcateg=0;
                   for(l=0;l<findCateg.getListOfSubcategories().size();l++){
                       if(((SubcategoryInfoBean)findCateg.getListOfSubcategories().get(l)).getName().equals(subcategName)){
                            findSubcateg=(SubcategoryInfoBean)findCateg.getListOfSubcategories().get(l);
                            foundSubcateg=1;
                            break;
                       }
                   }
                   if(foundSubcateg!=0){
                       try {
                            characteristics=charactDao.getCharacteristicsbySubcategory(subcategID);
                        } catch (SQLException ex) {
                            Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                        }
                       for (int n=0;n<characteristics.size();n++){
                           charact=((CharacteristicsInfoBean)characteristics.get(n)).getName();
                           
                           int found=0;
                           for(int k=0;k<findSubcateg.getListOfCharacteristics().size();k++){
                               if(((CharacteristicsInfoBean)findSubcateg.getListOfCharacteristics().get(k)).getName().equals(charact)){
                                   findSubcateg.getListOfCharacteristics().remove(k);
                                   found=1;
                               }
                           }
                           if(found==0){
                               forDelete.add(characteristics.get(n));
                           }                           
                       }
                       if(findSubcateg.getListOfCharacteristics().size()==0){
                           System.out.println("vgazw apo lista to:"+((SubcategoryInfoBean)findCateg.getListOfSubcategories().get(l)).getName());
                           findCateg.getListOfSubcategories().remove(l);
                       }
                    }else{
                       forDelete.add((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j));
                    }                   
                }
           }else{
               forDelete.add((CategoryInfoBean)listOfCategories.get(i));
           }
           if(findCateg.getListOfSubcategories().size()==0 && Categories.size()!=0){
               System.out.println("vgazw apo lista to:"+((CategoryInfoBean)Categories.get(m)).getName());
                Categories.remove(m);
           }
        }

        //insert new elements
        for(int m=0;m<Categories.size();m++){
            System.out.println("CATEGORY="+((CategoryInfoBean)Categories.get(m)).getName());
            String catName=((CategoryInfoBean)Categories.get(m)).getName();
            int catfound=0;
            for(int w=0;w<listOfCategories.size();w++){
                if(catName.equals(((CategoryInfoBean)listOfCategories.get(w)).getName())){
                    catfound=1;
                    break;
                }
            }
            if(catfound==0){
                try {
                    catDAO.insertNewCategory(catName);
                    System.out.println("Insert category:"+catName);
                } catch (SQLException ex) {
                    Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            for(int k=0;k<((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().size();k++){
                System.out.println("SUBCATEGORY="+((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getName());
                String subcatName=((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getName();
                int subcatFound=0;
                for(int w=0;w<listOfCategories.size();w++){
                    for(int g=0;g<((CategoryInfoBean)listOfCategories.get(w)).getListOfSubcategories().size();g++)
                        if(subcatName.equals(((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(w)).getListOfSubcategories().get(g)).getName())){
                        subcatFound=1;
                        break;
                    }
                }
                if(subcatFound==0){
                    try {
                        catDAO.insertNewSubcategory(subcatName,catName);
                        System.out.println("Insert in category:"+catName+"subcategory:"+subcatName);
                    } catch (SQLException ex) {
                        Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                for(int j=0;j<((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getListOfCharacteristics().size();j++){
                    System.out.println("CHARACT="+((CharacteristicsInfoBean)((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getListOfCharacteristics().get(j)).getName());
                    String charName=((CharacteristicsInfoBean)((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getListOfCharacteristics().get(j)).getName();
                    try {
                        charactDao.insertCharacteristic(charName,subcatName,catName);
                        System.out.println("Insert in category:"+catName+" and subcategory:"+subcatName+"characteristic:"+charName);
                    } catch (SQLException ex) {
                        Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }
        }

        
        
    


        /*for(int m=0;m<Categories.size();m++){
            System.out.println("CATEGORY="+((CategoryInfoBean)Categories.get(m)).getName());
            for(int k=0;k<((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().size();k++){
              System.out.println("SUBCATEGORY="+((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getName());
                for(int j=0;j<((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getListOfCharacteristics().size();j++){
                    System.out.println("CHARACT="+((CharacteristicsInfoBean)((SubcategoryInfoBean)((CategoryInfoBean)Categories.get(m)).getListOfSubcategories().get(k)).getListOfCharacteristics().get(j)).getName());
                }
            }
        }*/

        //delete elements
        for(int p=0;p<forDelete.size();p++){
            if(forDelete.get(p).getClass().getSimpleName().equals("CategoryInfoBean")){
                System.out.println(((CategoryInfoBean)forDelete.get(p)).getName());
                String name=((CategoryInfoBean)forDelete.get(p)).getName();
                try {
                        catDAO.deleteCategory(name);
                        System.out.println("delete cat/subcat="+name);
                    } catch (SQLException ex) {
                        Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                    }


            }
            if(forDelete.get(p).getClass().getSimpleName().equals("CharacteristicsInfoBean")){
                System.out.println(((CharacteristicsInfoBean)forDelete.get(p)).getName());
                String charName=((CharacteristicsInfoBean)forDelete.get(p)).getName();
                try {
                        charactDao.deleteCharacteristics(charName);
                        System.out.println("delete char="+charName);
                    } catch (SQLException ex) {
                        Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
                    }
            }
            
        }

        try {
            listOfCategories = catDAO.takeMainCategories();
        } catch (SQLException ex) {
            Logger.getLogger(ShowConfirmCategoriesChangesPage.class.getName()).log(Level.SEVERE, null, ex);
        }

        session.setAttribute("CategoriesList", listOfCategories);

        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return null;
    }

}
