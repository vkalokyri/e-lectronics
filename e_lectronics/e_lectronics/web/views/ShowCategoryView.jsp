<%--
    Document   : ShowComputers
    Created on : 6 Ιαν 2010, 4:48:53 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="model.SubcategoryInfoBean"%>
<%@page import="java.util.*"%>
<%@page import="model.ShoppingCartBean"%>
<%@page import="java.util.Vector"%>
<%@page import="model.ProductOrder"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="daoInterfaces.CategoryDAO"%>
<%@page import="daoFactories.DAOFactory"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd"
 <% ProductInfoBean product = (ProductInfoBean)request.getAttribute("model");
   DAOFactory mySqlFactory=(DAOFactory)session.getAttribute("daoFactory");
  Vector listOfCategory = (Vector)session.getAttribute("CategoriesList");
  if (listOfCategory==null){
        listOfCategory=new Vector();
        session.setAttribute("CategoriesList", listOfCategory);
   }
  if (mySqlFactory==null){
       mySqlFactory=DAOFactory.getDAOFactory(DAOFactory.mySQL);
       session.setAttribute("daoFactory", mySqlFactory);
   }
   CategoryDAO cateDAO = mySqlFactory.getCategoryDAO();
    try {
        listOfCategory = cateDAO.takeMainCategories();
        session.setAttribute("CategoriesList", listOfCategory);
    } catch (SQLException ex) {
    }
  Vector currentCat = (Vector)session.getAttribute("CurrentMenu"); %>
 

 

<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="author" content="styledmenus.com" />
    <%int categVecIndex=0;
      Iterator it = listOfCategory.iterator();
      while(it.hasNext()){
        if(((CategoryInfoBean)it.next()).getCategoryID()==Integer.parseInt(currentCat.get(0).toString()))
            break;
        categVecIndex++;
      }
    %>
    <title><%= ((CategoryInfoBean)listOfCategory.get(categVecIndex)).getName() %></title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
    </head>
    <body>

<div id="wrap">
   <%@include file="header.html" %>
        <div id="menucontainer">
            <%@include file="logoBar.jsp" %>        
        </div>
	
        <%@include file="login_panel.jsp" %>	
	<%@include file="option_bar.jsp" %>
        <table id="breadcrumb" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
                <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
                <td valign="top" class="current"><a href="#"><%= ((CategoryInfoBean)listOfCategory.get(categVecIndex)).getName() %></a></td>

            </tr>
        </table>

	<%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
                <%@include file="SmallCart.jsp" %>
                <%@include file="login_form.jsp" %>
        </div>
	<div id="main_menu">              

                <% for(int j=0;j<((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().size();j++){ %>
		<table class="bigger" cellspacing="3" cellpadding="3">                    
			<tr>
                            
                            <td class="header"><a href="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(j)).getCategoryID()%>"><b><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(j)).getName()%></b></a></td>
			</tr>
                 </table>
                  
		<table class="bigger">
                    <% int[] found={-1,-1,-1}; int counter=0; %>
                    <% for(int i=0;i<product.getListOfProducts().size();i++){%>
                        <% if (((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(j)).getCategoryID() == ((ProductInfoBean)(product.getListOfProducts().get(i))).getSubcategoryID()) {%>
                        <%  found[counter]=i; counter++;   if (counter==3) break;%>
                    <%}}%>
                    
			<tr>
                                    <%for(int i=0;i<3;i++) {
                                        if(found[i]!=-1){
                                            if(((ProductInfoBean)(product.getListOfProducts().get(found[i]))).getImageUrl().equals("-")){%>
                                            <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)product.getListOfProducts().get(found[i])).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(j)).getCategoryID()%>"><img src="images/noImage.jpg" width="200" height="150" alt="noImage"/></a><hr></td>
                                            <%}else{%>
                                            <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)product.getListOfProducts().get(found[i])).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(j)).getCategoryID()%>"><img src="<%=((ProductInfoBean)(product.getListOfProducts().get(found[i]))).getImageUrl()%>" width="200" height="150"/></a><hr></td
                                    <%}}}%>

			</tr>
                        <% if( found[0]==-1 && found[1]==-1 && found[2]==-1){ %>
                            <tr>
                                   <td><h3>Δεν υπάρχουν διαθέσιμα προϊόντα προς πώληση από αυτή την υποκατηγορία.</h3></td>
                            </tr>
                        <%}%>

			<tr>
                                    <%for(int i=0;i<3;i++) {
                                        if(found[i]!=-1){%>
                                            <td><%=((ProductInfoBean)(product.getListOfProducts().get(found[i]))).getSerialNumber()%>	</td>
                                     <%}}%>
			</tr>
			<tr>
                                     <%for(int i=0;i<3;i++) {
                                        if(found[i]!=-1){%>
                                            <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)product.getListOfProducts().get(found[i])).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(j)).getCategoryID()%>"><b><%=((ProductInfoBean)product.getListOfProducts().get(found[i])).getModel()%></b></a></td>
                                      <%}}%>
                                     

			</tr>
			<tr>
                               <%for(int i=0;i<3;i++) {
                                        if(found[i]!=-1){%>
				<td>Tιμή: <span style="color:red"><%=((ProductInfoBean)(product.getListOfProducts().get(found[i]))).getPrice()%>€</span></td>
                                <%}}%>
                        </tr>
                        
		</table>
                <%}%>
	</div>
        <%@include file="footer.jsp"  %>
</div>


        
</body>
</html>
