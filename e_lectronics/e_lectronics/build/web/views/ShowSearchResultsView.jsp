<%-- 
    Document   : ShowSearchResultsView
    Created on : 18 Φεβ 2010, 6:15:55 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Αποτελέσματα Αναζήτησης</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<%Vector listOfProducts=(Vector)request.getAttribute("model"); %>

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
                <td valign="top" class=""><a href="Controller?action=showComplexSearchPage">Σύνθετη Αναζήτηση</a></td>
                <td valign="top" class="current"><a href="#">Αποτελέσματα Αναζήτησης</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
		<%@include file="SmallCart.jsp" %>
                <%@include file="login_form.jsp"%>
        </div>
	<div id="main_menu">
		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr>
				<td class="header"> <b>Αποτελέσματα Αναζήτησης</b></td>
			</tr>           
		</table>
                <table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td style="font-size:14px;"><b> Βρέθηκαν <%=listOfProducts.size()%> αποτελέσματα.</b></td>
                    </tr>
		</table>


                <hr>
                <%if(listOfProducts.size()!=0){%>
                    <table class="bigger">
                        <tr>

                                <th>Κωδικός</th>
                                <th colspan="2">Περιγραφή</th>
                                <th>Τιμή</th>
                                <th>&nbsp;</th>
                        </tr>


                        <%for(int i=0;i<listOfProducts.size();i++){ %>
                        <tr>
                            <td><span><%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%></span></td>
                            <td><img <%if (((ProductInfoBean)(listOfProducts.get(i))).getImageUrl().equals("-")){%> src="images/noImage.jpg" <%}else{%>src="<%=((ProductInfoBean)(listOfProducts.get(i))).getImageUrl()%>" <%}%> width="110px" height="110" style="border-width: 0px;"></td>
                            <td><a  href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>&CategID=<%=((ProductInfoBean)(listOfProducts.get(i))).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)(listOfProducts.get(i))).getSubcategoryID()%>"><%=((ProductInfoBean)(listOfProducts.get(i))).getModel()%></a></td>
                            <td><b><span style="color:red"><%=((ProductInfoBean)(listOfProducts.get(i))).getPrice()%>€</span></b></td>
                            <td><a href="Controller?action=addToCartPage&<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>=1"><img src="images/basket_red.bmp" alt="Προσθήκη στο καλάθι"></a></td>
                            <%if(customer!=null){%>
                            <%if(customer.getIsAdmin()){%>
                                <td><a href="Controller?action=showDeleteProductPage&sn=<%=((ProductInfoBean)listOfProducts.get(i)).getSerialNumber()%>"><img src="images/Red-x.gif" alt="Διαγραφή προϊόντος"></a></td>
                                <td><a href="Controller?action=showChangeProductPage&sn=<%=((ProductInfoBean)listOfProducts.get(i)).getSerialNumber()%>"><img src="images/edit_button.gif" alt="Αλλαγή προϊόντος" ></a></td>
                            <%}}%>

                        </tr>
                        <%}%>
                </table>
                <%}%>
	</div>
        <%@include file="footer.jsp" %>
</div>

</body>

</html>