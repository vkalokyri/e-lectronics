<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CharacteristicsInfoBean"%>
<%@page import="model.ValueInfoBean"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="model.SubcategoryInfoBean"%>
<%@page import="java.util.Iterator"%>
 <% ProductInfoBean product = (ProductInfoBean)request.getAttribute("model");
  Vector listOfCategory = (Vector)session.getAttribute("CategoriesList");
  Vector currentCat = (Vector)session.getAttribute("CurrentMenu"); %>

﻿<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Σύγκριση Προϊόντων</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>


<%int categVecIndex=0;
  int subcategVecIndex=0;
      Iterator it = listOfCategory.iterator();
      Iterator it2 ;
      CategoryInfoBean temp;
      while(it.hasNext()){
          temp=((CategoryInfoBean)it.next());
        if(temp.getCategoryID()==Integer.parseInt(currentCat.get(0).toString())){
            it2=temp.getListOfSubcategories().iterator();
            while(it2.hasNext()){
                if ( ((CategoryInfoBean)it2.next()).getCategoryID()==Integer.parseInt(currentCat.get(1).toString()) )
                  break;
                subcategVecIndex++ ;
            }
            break;
        }
        categVecIndex++;
      }
    %>
    
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
            <td valign="top" class=""><a href="Controller?action=showCategoryPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>"><%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getName()%></a></td>
            <td valign="top" class=""><a href="Controller?action=showCategoryPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName()%>"><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName()%></a></td>
            <td valign="top" class="current"><a href="#">Σύγκριση</a></td>
        </tr>
    </table>

     <%@include file="LeftMenu.jsp" %>
    <div id=RightMenu>
        <%@include file="SmallCart.jsp" %>
        <%@include file="login_form.jsp" %>
    </div>
	<div id="main_menu">	      
		<table class="bigger" cellspacing="3" cellpadding="3">
                        <tr>
				<td class="header"><a href="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"> <b><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName() %></b></a></td>
			</tr>
		</table>
            
		<table class="bigger" cellpadding="8">
			<tr>
                            <td>&nbsp;</td>
                            <% for (int j=0;j<product.getListOfProducts().size();j++){%>
                             <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)product.getListOfProducts().get(j)).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"><img src="<%= ((ProductInfoBean)product.getListOfProducts().get(j)).getImageUrl()%>" height="110px" width="110px"></a></td>
                             <%}%>
			</tr>
			<tr><td>&nbsp;</td></tr>		
                        <tr>                           
				<td class="gray">Kατασκευαστής</td>
                                    <% for (int j=0;j<product.getListOfProducts().size();j++){%>
                                <td class="lightgray"><%= ((ProductInfoBean)product.getListOfProducts().get(j)).getManufacturer()%></td>
                                <%}%>
			</tr>
                        <tr>
				<td class="gray">Μοντέλο</td>
                                 <% for (int j=0;j<product.getListOfProducts().size();j++){%>
                                    <td class="lightgray"><%= ((ProductInfoBean)product.getListOfProducts().get(j)).getModel()%></td>
                                <%}%>
			</tr>
                        <%for(int i=0;i<((ProductInfoBean)product.getListOfProducts().get(0)).getCharacteristics().getListOfCharacteristics().size();i++){ %>

			<tr>
				<td class="gray"><%= ((CharacteristicsInfoBean)((ProductInfoBean)product.getListOfProducts().get(0)).getCharacteristics().getListOfCharacteristics().get(i)).getName()%></td>
                                <%for(int pr=0;pr<product.getListOfProducts().size();pr++){ %>
                                <%if (((ValueInfoBean)((ProductInfoBean)product.getListOfProducts().get(pr)).getCharacteristics().getValues().getListOfValues().get(i)).getName()!= null){%>
                                <td class="lightgray"><%= ((ValueInfoBean)((ProductInfoBean)product.getListOfProducts().get(pr)).getCharacteristics().getValues().getListOfValues().get(i)).getName()%></td>
                                <%}else{%> <td class="lightgray">-</td><%}%>
                                <%}%>
			</tr>
                     <%}%>
			<tr>
				<td class="gray">Τιμή</td>
                                <% for (int j=0;j<product.getListOfProducts().size();j++){%>
				<td class="lightgray"><%= ((ProductInfoBean)product.getListOfProducts().get(j)).getPrice()%>€</td>
                                <%}%>
			</tr>
		</table>
              
	</div>
        <%@include file="footer.jsp" %>
    </div>
</body>
</html>
