<%-- 
    Document   : ShowShortageView
    Created on : 17 Φεβ 2010, 12:09:52 πμ
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
<title>Αποθέματα Προϊόντων</title>
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
                <td valign="top" class=""><a href="Controller?action=showΙnventoryPage">Έλεγχος Αποθεμάτων</a></td>
                <td valign="top" class="current"><a href="#">Αποθέματα Προϊόντων</a></td>
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
				<td class="blueheader"> <b>Αποθέματα Προϊόντων</b></td>
			</tr>
		</table>

                
		<table class="biggerWithBorder" cellspacing="0" cellpadding="6">
			<tr>
				
				<td class="gray" align="center"><b>Κωδικός</b></td>
                                <td class="gray">&nbsp;</td>
				<td class="gray" align="center"><b>Μοντέλο</b></td>
				<td class="gray" align="center"><b>Απόθεμα</b></td>
                                <%if(customer!=null){%>
                                <%if(customer.getIsAdmin()){%>
                                    <td class="gray">&nbsp;</td>
                                    <td class="gray">&nbsp;</td>
                                <%}}%>
				
			</tr>
                        
                        <% for(int i=0;i<listOfProducts.size();i++){%>
			<tr>
                            <td align="center"><%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%></td>
                                <td align="center"><a  href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>&CategID=<%=((ProductInfoBean)listOfProducts.get(i)).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)listOfProducts.get(i)).getSubcategoryID()%>"><img <%if(((ProductInfoBean)(listOfProducts.get(i))).getImageUrl().equals("-")){%> src="images/noImage.jpg" <%}else{%>src="<%=((ProductInfoBean)(listOfProducts.get(i))).getImageUrl()%>" <%}%>width="110px" height="110" style="border-width: 0px;"></a></td>
                                <td align="center"><a  href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>&CategID=<%=((ProductInfoBean)listOfProducts.get(i)).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)listOfProducts.get(i)).getSubcategoryID()%>"><%=((ProductInfoBean)(listOfProducts.get(i))).getModel()%></a></td>
                                <td align="center" style="color:red"><%=((ProductInfoBean)(listOfProducts.get(i))).getStock()%> τεμάχια</td>
                                <%if(customer!=null){%>
                                <%if(customer.getIsAdmin()){%>                                    
                                    <td><a href="Controller?action=showChangeProductPage&sn=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>"><img src="images/edit_button.gif" alt="Αλλαγή προϊόντος" ></a></td>
                                    <td><a href="Controller?action=showDeleteProductPage&sn=<%=((ProductInfoBean)(listOfProducts.get(i))).getSerialNumber()%>"><img src="images/Red-x.gif" alt="Διαγραφή προϊόντος"></a></td>
                                <%}}%>
			</tr>
			<%}%>
                        
		</table>
                <%if(listOfProducts.size()==0){%>
                    <table class="bigger" cellspacing="3" cellpadding="3">
                        <tr><td>&nbsp;</td></tr>
                        <tr><th style="font-size:15px">Δεν βρέθηκαν προϊόντα με χαμηλές τιμές αποθέματος σύμφωνα με τα κριτήρια που δόθηκαν.</th></tr>
                     </table>

                <%}%>

	</div>
    <%@include file="footer.jsp" %>
</div>

</body>

</html>