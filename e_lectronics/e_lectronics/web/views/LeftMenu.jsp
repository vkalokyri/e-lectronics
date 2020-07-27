<%-- 
    Document   : LeftMenu
    Created on : 4 Ιαν 2010, 11:05:58 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="model.CustomerInfoBean"%>
<%@page import="java.util.Vector"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="daoInterfaces.CategoryDAO"%>
<%@page import="daoFactories.DAOFactory"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<% Vector listOfCategories = (Vector)session.getAttribute("CategoriesList");
   DAOFactory mysqlFactory=(DAOFactory)session.getAttribute("daoFactory");
   if (listOfCategories==null){
        listOfCategories=new Vector();
        session.setAttribute("CategoriesList", listOfCategories);
   }
   if (mysqlFactory==null){
       mysqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
       session.setAttribute("daoFactory", mysqlFactory);
   }
   CategoryDAO catDAO = mysqlFactory.getCategoryDAO();
    try {
        listOfCategories = catDAO.takeMainCategories();
        session.setAttribute("CategoriesList", listOfCategories);
    } catch (SQLException ex) {
    }

    Vector current=(Vector)session.getAttribute("CurrentMenu");
    
        if(current.get(0)==null || current.get(1)==null){            
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
          session.setAttribute("CurrentMenu",current);
          current=(Vector)session.getAttribute("CurrentMenu");
       }       
        CustomerInfoBean user = (CustomerInfoBean)session.getAttribute("CustomerInfo");
            if (user==null){
                user=new CustomerInfoBean();
                session.setAttribute("Customer", user);
            }%>

<div id="LeftMenu">
 <ul>     
     <%synchronized(session){
        for(int i=0;i<listOfCategories.size();i++){
            if (((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()!=Integer.parseInt(current.get(0).toString())){ %>
                <li class="categories"><a href="Controller?action=showCategoryPage&CategId=<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID() %>" ><%=((CategoryInfoBean)listOfCategories.get(i)).getName()%></a></li>
            <%}else{%>
                 <li class="categories"><a href="Controller?action=showCategoryPage&CategId=<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" ><b><%= ((CategoryInfoBean)listOfCategories.get(i)).getName()%></b></a></li>
                 <%for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
                    if (((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID()!=Integer.parseInt(current.get(1).toString())){ %>
                        <li class="sub_categories"><a href="Controller?action=showListOfProductsPage&CategId=<%=current.get(0).toString()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID()%>"><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName()%></a></li>
                  <%}else{%>
                       <li class="sub_categories"><a href="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>&SubcategId=<%=current.get(1).toString()%>"><b><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName()%></b></a></li>
                  <%}
                 }
               }
         }
      }%>
      <%if(user!=null){
          if (user.getIsAdmin()){%>
        <li class="adminCategories"><a href="Controller?action=showReviewOrdersPage" style="color:white; ">Eπισκόπηση Παραγγελιών</a></li>
        <li class="adminCategories"><a href="Controller?action=showInsertProductPage" style="color:white" >Eισαγωγή Προϊόντος</a></li>
        <li class="adminCategories"><a href="Controller?action=showInsertCategoryPage" style="color:white" >Επεξεργασία Κατηγοριών</a></li>
        <li class="adminCategories"><a href="Controller?action=showDeleteProductPage" style="color:white">Διαγραφή Προϊόντος</a></li>
        <li class="adminCategories"><a href="Controller?action=showChangeProductPage" style="color:white">Aλλαγή προϊόντος</a></li>
        <li class="adminCategories"><a href="Controller?action=showInventoryPage" style="color:white">Αποθέματα προϊόντων</a></li>
        
        <%}}%>

    </ul>
       
    <table cellspacing="3" border="0">
        <tr><td><img src="images/build2orderBanner.gif"/></td></tr>
        <tr><td><img src="images/services.jpg"/></td></tr>
    </table>
</div>

