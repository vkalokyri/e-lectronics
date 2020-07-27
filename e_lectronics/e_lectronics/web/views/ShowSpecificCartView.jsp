<%-- 
    Document   : ShowSpecificCartView
    Created on : 19 Φεβ 2010, 12:43:32 πμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CartInfoBean"%>
<%@page import="java.util.Vector"%>
<%@page import="model.ProductOrder"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Καλάθι αγορών</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="validate_form.js"></script>
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>
<% CartInfoBean cart = (CartInfoBean)request.getAttribute("model");%>
<% ShoppingCartBean currcart = (ShoppingCartBean)session.getAttribute("shoppingCart");%>

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
                <td valign="top" class=""><a href="Controller?action=myAccountPage">Ο λογαριασμός μου</a></td>
                <td valign="top" class=""><a href="Controller?action=showMyCartsPage">Tα καλάθια αγορών μου</a></td>
                <td valign="top" class="current"><a href="#">Tο καλάθι μου</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>
	<div id="main_menu">
		<table class="bigger" cellspacing="3" cellpadding="3">
		<tr><td colspan="2" align="left" class="basket_header"><img src="images/basket.gif"/><b>Το καλάθι μου</b></td></tr>
		</table>

             <%if(cart.getListOfProducts().size()==0){%>
               <h2 align="middle" style="margin-top:50px"> To καλάθι σας είναι άδειο...</h2>
             <%}else{
                   ProductOrder order;%>
              <table class="bigger" cellspacing="3" cellpadding="3" style="background-color:#e0e6ed;">
                    <tr><td colspan=2"   style="font-size:12px">Αν θέλετε μπορείτε να φορτώσετε αυτό το αποθηκευμένο καλάθι σας στο τρέχον καλάθι σας πατώντας το κουμπί<b>"Φόρτωση Καλαθιού"</b>.
                            <p>Προσοχή όμως, καθώς αν έχετε ήδη προσθέσει προϊόντα στο τρέχον καλάθι σας, αυτά θα διαγραφούν με την φόρτωση του αποθηκευμένου καλαθιού αγορών.
                    </td>
              </table>

             <form name="cartForm" action="Controller?action=shoppingCartPage" method="post">
		<table class="basketTable" cellspacing="0" cellpadding="0">
				<tr><td align="center" class="gray" colspan="2"><b>Όνομα προϊόντος</b></td>
					<td align="center" class="gray">Tιμή μον.</td>
					<td align="center" class="gray">&nbsp;</td>
					<td align="center" class="gray">Τεμάχια </td>
					<td align="center" class="gray">&nbsp;</td>
					<td align="center" class="gray">Τελική Αξία </td>
					<td align="center" class="gray">&nbsp;</td>
				</tr>
                          <%double total_price=0;%>
                       <%for(int i=0;i<cart.getListOfProducts().size();i++){
                            order=(ProductOrder)cart.getListOfProducts().get(i);   %>
                            <tr><td><img src="<%=order.getImageUrl() %>" height="65px" width="65px" ></td>
					<td align="center"><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=order.getProductID()%>&CategID=<%=order.getCategoryID()%>&SubcategID=<%=order.getSubcategoryID()%>"><span style="color:blue" id="<%= order.getProductID()%>"><%= order.getModel()%></span><span style="color:gray" align="left"> -<%= order.getProductID()%></span></a></td>
					<td align="center"><%=order.getUnitCost()%> €</td>
					<td align="center">&nbsp;</td>
                                        <td align="center"><%=order.getNumItems()%></td>
					<td align="center">&nbsp;</td>
					<td align="center"><span style="color:red"><b><%=order.getTotalCost()%> €</b></span></td>                                        
				</tr>

                               <% total_price=total_price + order.getTotalCost();  %>
				<%}%>                               
				<tr><td colspan="8">&nbsp;</td></tr><tr><td colspan="8"></td></tr>
				<tr><td colspan="6" align="right"><b>Συνολικό κόστος :  </b></td>
					<td align="center"><span style="color:red"><b><%=total_price%> €</b></span></td>
				</tr>
				<tr><td colspan="8">&nbsp;</td>
		</table>
                </form>
                <table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td align="right">
                            <input type="submit" value="Φόρτωση Καλαθιού" <%if(currcart.getItemsOrdered().size()!=0){%> onclick="var answer=confirmLoad(); if(answer){ location.href='Controller?action=showLoadCartPage&cid=<%=cart.getCartID()%>'; }" <%}else{%> onclick="location.href='Controller?action=showLoadCartPage&cid=<%=cart.getCartID()%>';" <%}%>  class="green_button">
                    </td></tr>
                </table>
                <%}%>


	</div>

<%@include file="footer.jsp" %>
</div>

</body>

</html>