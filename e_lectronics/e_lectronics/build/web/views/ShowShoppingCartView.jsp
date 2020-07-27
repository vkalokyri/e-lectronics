<%-- 
    Document   : ShowShoppingCartView
    Created on : 20 Ιαν 2010, 1:30:48 πμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ShoppingCartBean"%>
<%@page import="java.util.Vector"%>
<%@page import="model.ProductOrder"%>
<%@page import="model.ProductInfoBean"%>



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
<% ShoppingCartBean cart = (ShoppingCartBean)session.getAttribute("shoppingCart");%>
<% Vector incompProducts = (Vector)session.getAttribute("IncompatibleProducts");%>

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
            <td valign="top" class="current"><a href="#">Το καλάθι μου</a></td>
        </tr>
    </table>

    <%@include file="LeftMenu.jsp" %>
    <div id=RightMenu>
        <%@include file="SmallCart.jsp" %>
        <%@include file="login_form.jsp" %>
    </div>
    <div id="main_menu">
        <table class="bigger" cellspacing="3" cellpadding="3">
            <tr><td colspan="2" align="left" class="basket_header"><img alt="To καλάθι μου" src="images/basket.gif"/><b>Το καλάθι μου</b></td></tr>
        </table>

        <% synchronized(session){
           String id="";
           int num=0;
           Vector itemsOrdered=cart.getItemsOrdered();
           if (itemsOrdered.size()==0){%>
                <h2 align="middle" style="margin-top:50px"> To καλάθι σας είναι άδειο...</h2>
         <%}else{
                ProductOrder order;%>
                <table class="bigger" cellspacing="3" cellpadding="3">
                    <tr>
                        <td><input onclick="location.href='Controller?action=showΑddBasketPage';" type="image" src="images/SaveIcon.png" class="green_button" value="Αποθήκευση Καλαθιού"></td>
                        <td  style="background-color:#e0e6ed;"><b>Tip!</b>&nbsp;Μπορείτε να αποθηκεύσετε το τρέχον καλάθι σας και να το χρησιμοποιήσετε την επόμενη φορά που θα επισκεφτείτε το κατάστημα μας.</td>
                    </tr>
                </table>
                <form name="cartForm" action="Controller?action=shoppingCartPage" method="post">
                    <table class="basketTable" cellspacing="0" cellpadding="0">
                        <tr><td align="center" class="gray" colspan="2"><b>Όνομα προϊόντος</b></td>
                                <td align="center" class="gray">Tιμή μον.</td>
                                <td align="center" class="gray">&nbsp;</td>
                                <td align="center" class="gray" width="90px">Τεμάχια </td>
                                <td align="center" class="gray">&nbsp;</td>
                                <td align="center" class="gray">Τελική Αξία </td>
                                <td align="center" class="gray">&nbsp;</td>
                        </tr>
                        <%double total_price=0;%>
                        <%for(int i=0;i<itemsOrdered.size();i++){
                            order=(ProductOrder)itemsOrdered.get(i);   %>
                            <tr>
                                <td><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=order.getProductID()%>&CategID=<%=order.getCategoryID()%>&SubcategID=<%=order.getSubcategoryID()%>"><img alt="Image" src="<%=order.getImageUrl() %>" height="65px" width="65px" ></a></td>
                                <td align="center"><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=order.getProductID()%>&CategID=<%=order.getCategoryID()%>&SubcategID=<%=order.getSubcategoryID()%>"><span style="color:blue" id="<%= order.getProductID()%>"><%= order.getModel()%></span><span style="color:gray" align="left"> -<%= order.getProductID()%></span></a></td>
                                <td align="center"><%=order.getUnitCost()%> €</td>
                                <td align="center">&nbsp;</td>
                                <td align="center"><input type="text" id="<%= order.getProductID()%>_numItems" value="<%=order.getNumItems()%>" size="1" name="<%= order.getProductID()%>"></td>
                                <td align="center">&nbsp;</td>
                                <td align="center"><span style="color:red"><b><%=order.getTotalCost()%> €</b></span></td>
                                <td align="left" width="25px"><span id="<%= order.getProductID()%>_delet"><input type="image" onclick="deleteProduct('<%= order.getProductID()%>'); return false;"  src="images/Red-x.gif"/></span>
                                                              <span id="<%= order.getProductID()%>_recov" style="display:none"><input type="image" onclick="undoDeleteProduct('<%= order.getProductID()%>'); return false;" src="images/undo.png"/></span></td>
                            </tr>                                
                            <% total_price=total_price + order.getTotalCost();  %>
                            <%}%>
                            <tr><td colspan="3"></td><td colspan="3" align="center" ><input maxlength="16"  value="εφαρμογή αλλαγών" type="submit" class="silverline"  ></td></tr>
                            <tr><td colspan="8">&nbsp;</td></tr><tr><td colspan="8"></td></tr>
                            <tr><td colspan="6" align="right"><b>Συνολικό κόστος :  </b></td>
                                    <td align="center"><span style="color:red"><b><%=total_price%> €</b></span></td>
                            </tr>
                            <tr><td colspan="8">&nbsp;</td>
                    </table>                    
                </form>                
                

                <form action="Controller?action=shoppingCartPage&ov=1&ch=1#incompatibility_table" method="post">
                    <table cellpadding="0" cellspacing="10" class="bigger">
                            <tr>
                                    <td>Αν τα προϊόντα που έχετε προσθέσει στο καλάθι σας αποτελούν μία σύνθεση, και επιθυμείτε να δείτε την συμβατότητα
                                            αυτών, πατήστε εδώ.</td>
                            </tr>
                            <tr>
                                <td><input value="Έλεγχος συμβατότητας" type="submit" name="check_compatibility"></td>
                            </tr>
                    </table>
                </form>
                <a name="incompatibility_table"></a>
                <%if(incompProducts!=null){%>
                <table class="basketTable" border="1" cellspacing="0" cellpadding="0">
                     <tr><td align="center" class="gray" colspan="2"><b>Όνομα προϊόντος</b></td>
                        <td align="center" colspan="2" class="gray">Μη συμβατά προϊόντα</td>
                     </tr>
                    <%ProductOrder cartProd;
                    int total_inc = 0;
                    Vector tempListOfItems=itemsOrdered;
                    for(int i=0;i<tempListOfItems.size();i++){

                        cartProd=(ProductOrder)tempListOfItems.get(i);
                        int found=0;
                        for(int j=0;j<((Vector)incompProducts.get(i)).size();j++){
                            ProductInfoBean prodBean=(ProductInfoBean)((Vector)incompProducts.get(i)).get(j);                            
                               for(int k=i+1;k<tempListOfItems.size();k++){                                   
                                    ProductOrder prorder=(ProductOrder)tempListOfItems.get(k);
                                    if(Integer.parseInt(prorder.getProductID())==prodBean.getSerialNumber()){ 
                                        found=found+1;
                                        break;
                                    }                                    
                               }
                        }%>
                        <%if(found!=0){
                            total_inc = total_inc + found;%>
                        <tr>
                            <td><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=cartProd.getProductID()%>&CategID=<%=cartProd.getCategoryID()%>&SubcategID=<%=cartProd.getSubcategoryID()%>"><span style="color:blue" id="<%= cartProd.getProductID()%>"><img src="<%=cartProd.getImageUrl() %>" alt="Image" height="65px" width="65px" ></a></td>
                            <td><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=cartProd.getProductID()%>&CategID=<%=cartProd.getCategoryID()%>&SubcategID=<%=cartProd.getSubcategoryID()%>"><span style="color:blue" id="<%= cartProd.getProductID()%>"><%= cartProd.getModel()%></span><span style="color:gray" align="left"> -<%= cartProd.getProductID()%></span></a></td>
                            <td><table>
                                    <%for(int j=0;j<((Vector)incompProducts.get(i)).size();j++){
                                        ProductInfoBean prodBean=(ProductInfoBean)((Vector)incompProducts.get(i)).get(j);
                                        for(int k=i+1;k<tempListOfItems.size();k++){
                                                ProductOrder prorder=(ProductOrder)tempListOfItems.get(k);
                                                if(Integer.parseInt(prorder.getProductID())==prodBean.getSerialNumber()){ %>
                                                <tr>
                                                    <td><img src="<%=prodBean.getImageUrl() %>" height="65px" width="65px" ></td>
                                                    <td align="center"><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=prodBean.getSerialNumber()%>&CategID=<%=prodBean.getCategoryID()%>&SubcategID=<%=prodBean.getSubcategoryID()%>"><span style="color:blue" id="<%= prodBean.getSerialNumber()%>"><%= prodBean.getModel()%></span><span style="color:gray" align="left"> -<%= prodBean.getSerialNumber()%></span></a></td>
                                                </tr>

                                    <%}}}%>
                                </table>
                            </td>
                        </tr>                       
                      <%}}%>                        
                </table>

                  <table class="bigger" cellspacing="0" cellpadding="0">
                  <%if(total_inc == 0){%>                  
                     <tr><td align="center" style="font-size:13px;" colspan="2"><b>Δεν εντοπίστηκαν ασυμβατότητες. Ο έλεγχος της σύνθεσης ολοκληρώθηκε με επιτυχία.</b></td>
                    
                  <%}else{%>

                    <tr><td  style="font-size:13px;" colspan="2"><b>Εντοπίστηκαν συνολικά <%=total_inc%> ασυμβατότητες.</b></td></tr>
                  <%}%>
                  </table>
                <%}%>
                <% session.setAttribute("IncompatibleProducts",null);%>
                <%}%>
                
                <table cellpadding="0" cellspacing="10" class="bigger">
			<tr><td></td></tr><tr><td></td></tr><tr><td></td></tr>
                        <%if ((String)session.getAttribute("previousProductPageUrl")!=null){ %>
                        <tr><td><input value="Συνέχεια αγορών" type="button" class="gray_button" onclick="location.href='Controller?<%=(String)session.getAttribute("previousProductPageUrl")%>';" </td>
                        <%}%>
			<%if (itemsOrdered.size()!=0){%>
                            <td align="right"><input value="Oλοκλήρωση παραγγελίας" onclick="location.href='Controller?action=showMakeOrderPage';" type="button" class="green_button"></td></tr>
                        <%}%>
                        <%}%>
		</table>


	</div>

<%@include file="footer.jsp" %>
</div>

</body>

</html>