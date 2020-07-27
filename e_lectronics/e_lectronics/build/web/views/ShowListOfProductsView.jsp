<%-- 
    Document   : ShowListOfProducts
    Created on : 13 Ιαν 2010, 3:21:52 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
 <% Vector listOfProducts = (Vector)request.getAttribute("model");
  Vector listOfCategory = (Vector)session.getAttribute("CategoriesList");
  Vector currentCat = (Vector)session.getAttribute("CurrentMenu"); %>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Προϊόντα</title>
<script type="text/javascript" src="validate_form.js"></script>
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
                <td valign="top" class="current"><a href="#"><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName()%></a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
                <%@include file="SmallCart.jsp" %>
                <%@include file="login_form.jsp" %>
        </div>
	<div id="main_menu">
            <a name="sBy"></a>
		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr>
				<td class="header"><a href="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"> <b><%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getName() %></b></a></td>
			</tr>
		</table>
            
		<table class="big_gray">
			<tr>
                           
                            <td align="left" style="width:50px"><input onclick="var valid=true;   valid=checkCompare(); if(valid){javascript:document.checkForm.submit();}" type="image" alt="Σύγκριση" src="images/compare.bmp"></td>
				<td align="left">Eπιλέξτε τα προϊόντα που θέλετε και πατήστε το κουμπί "Σύγκριση"</td>
		</table>
                <form name="orderBy" action="Controller?action=showListOfProductsPage&CategId=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategId=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>#sBy" method="post">
                    <table class="bigger">
                        <tr>
                            <td align="right" style="font-size:12px; width:500px">Ταξινόμηση :</td>
                            <td align="right">
                                <select id="order" name="order">
                                    <option <% if (listOfProducts.size()!=0)
                                            if(((String)listOfProducts.get(listOfProducts.size()-1)).equals("asc")){%>
                                            selected="selected"
                                            <%}%>
                                            onclick="javascript:document.orderBy.submit();" value="asc">Φθηνότερο -> Ακριβότερο</option>
                                    <option <% if (listOfProducts.size()!=0)
                                            if(((String)listOfProducts.get(listOfProducts.size()-1)).equals("desc")){%>
                                            selected="selected"
                                            <%}%> onclick="javascript:document.orderBy.submit();" value="desc">Ακριβότερο -> Φθηνότερο</option>
                                    </select>
                            </td>
                        </tr>
                    </table>
                </form>
                
		<hr>
                <form action="Controller?action=showComparePage" method="POST"  name="checkForm" >
                    <table class="bigger">
                            <tr>
                                    <th>&nbsp;</th>
                                    <th>Κωδικός</th>
                                    <th colspan="2">Περιγραφή</th>
                                    <th>Τιμή</th>
                                    <th>&nbsp;</th>
                            </tr>


                            <%for(int i=0;i<listOfProducts.size()-1;i++){ %>
                            <tr>
                                <td><input name="check<%=i%>" value="<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>" type="checkbox" onclick="checkclick('check<%=i%>')"></td>
                                    <td><a  href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"><span><%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%></span></a></td>
                                    <td><a  href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"><img <%if (((ProductInfoBean)(listOfProducts.get(i))).getImageUrl().equals("-")){%> src="images/noImage.jpg" <%}else{%>src="<%=((ProductInfoBean)(listOfProducts.get(i))).getImageUrl()%>" <%}%> width="110px" height="110" style="border-width: 0px;"></a></td>
                                    <td><a  href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>&CategID=<%=((CategoryInfoBean)listOfCategory.get(categVecIndex)).getCategoryID()%>&SubcategID=<%=((CategoryInfoBean)((CategoryInfoBean)listOfCategory.get(categVecIndex)).getListOfSubcategories().get(subcategVecIndex)).getCategoryID()%>"><%=((ProductInfoBean)(listOfProducts.get(i))).getModel()%></a></td>
                                    <td><b><span style="color:red"><%=((ProductInfoBean)(listOfProducts.get(i))).getPrice()%>€</span></b></td>
                                    <td><a href="Controller?action=addToCartPage&<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>=1"><img src="images/basket_red.bmp" alt="Προσθήκη στο καλάθι"></a></td>
                                    <%if(customer!=null){%>
                                    <%if(customer.getIsAdmin()){%>
                                        <td><a href="Controller?action=showDeleteProductPage&sn=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>"><img src="images/Red-x.gif" alt="Διαγραφή προϊόντος"></a></td>
                                        <td><a href="Controller?action=showChangeProductPage&sn=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>"><img src="images/edit_button.gif" alt="Αλλαγή προϊόντος" ></a></td>
                                    <%}}%>
                                    
                            </tr>
                            <%}%>

                    </table>
                </form>
	</div>
        <%@include file="footer.jsp" %>
</div>
</body>
</html>

