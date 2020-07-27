<%-- 
    Document   : ShowProductDetailsView
    Created on : 15 Ιαν 2010, 5:46:16 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CharacteristicsInfoBean"%>
<%@page import="model.ValueInfoBean"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

 <% ProductInfoBean product = (ProductInfoBean)request.getAttribute("model");
  Vector listOfCategory = (Vector)session.getAttribute("CategoriesList");
  Vector currentCat = (Vector)session.getAttribute("CurrentMenu"); %>

<html>
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

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName()%></title>
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
                <td valign="top" class=""><a href="Controller?action=showCategoryPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>" ><%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getName()%></a></td>
                <td valign="top" class="current"><a href="#"><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName()%></a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
                <%@include file="SmallCart.jsp" %>
                <%@include file="login_form.jsp" %>
        </div>
        <div id="main_menu">
		<table class="bigger" cellspacing="0" cellpadding="0">
			<tr>
				<td class="header"><a href="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"><b><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName()%></b></a><a style="font-size:11px; float:right" href="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"><b>Επιστροφή στην λίστα των προϊόντων</b>&nbsp;»&nbsp;</a></td>
                                
			</tr>
		</table>

		
		<table class="bigger">
			<tr>
                            <%if(product.getImageUrl().equals("-")){%>
                                    <td><img src="images/noImage.jpg"></td>
                                <%}else{%>
                                    <td><img src="<%= product.getImageUrl()%>"></td>
                                <%}%>
				<td><b><%= product.getModel()%></b></td>
				<td><b>Tιμή: <span style="color:red"><%=product.getPrice()%>€</span></b></td>
				<td><a href="Controller?action=addToCartPage&<%=product.getSerialNumber()%>=1"><img alt="Προσθήκη στο καλάθι" src="images/basket_red.bmp"></a></td>
			</tr>
			<tr><td>&nbsp;</td></tr>
		</table>
		<table class="bigger">
			<tr>
				<td><h2>Περιγραφή</h2></td>
			</tr>
			<tr>
				<td>
				<%= product.getDescription()%>
				</td>
			</tr>
		</table>



		<table class="bigger" cellpadding="8">

			<tr>
				<td><h2>Xαρακτηριστικά</h2></td>
			</tr>
                        <tr>
				<td class="gray">Kατασκευαστής</td>
                                <td class="lightgray"><%= product.getManufacturer()%></td>
			</tr>
                        <tr>
				<td class="gray">Μοντέλο</td>
                                <td class="lightgray"><%= product.getModel()%></td>
			</tr>
                     <%for(int i=0;i<product.getCharacteristics().getListOfCharacteristics().size();i++){ %>
                    
			<tr>
				<td class="gray"><%= ((CharacteristicsInfoBean)product.getCharacteristics().getListOfCharacteristics().get(i)).getName()%></td>
                                <%if (((ValueInfoBean)product.getCharacteristics().getValues().getListOfValues().get(i)).getName()!=null){%>
                                <td class="lightgray"><%= ((ValueInfoBean)product.getCharacteristics().getValues().getListOfValues().get(i)).getName()%></td>
                                <%}else{%><td class="lightgray">-</td>
                                <%}%>
			</tr>
                     <%}%>
			<tr>
				<td class="gray">Τιμή</td>
				<td class="lightgray"><%= product.getPrice()%>€</td>
			</tr>
		</table>



	</div>
<%@include file="footer.jsp" %>
</div>        

</body>
</html>