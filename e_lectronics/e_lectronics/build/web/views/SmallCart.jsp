<%-- 
    Document   : SmallCart
    Created on : 20 Ιαν 2010, 4:37:52 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ShoppingCartBean"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="model.ProductOrder"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="validate_form.js"></script>
        <title></title>
    </head>
    <body>
        <% session=request.getSession();
          ShoppingCartBean mycart;%>
        <% synchronized(session){
               mycart = (ShoppingCartBean)session.getAttribute("shoppingCart");
               if (mycart==null){
                   mycart=new ShoppingCartBean();
                   session.setAttribute("shoppingCart",mycart);
                   }

            
           }
            synchronized(session){
               Vector itemsOrdered=mycart.getItemsOrdered();
               if (itemsOrdered.size()==0){%>
               <table style="width:100%" cellpadding="2" cellspacing="0" class="veryPale">
                            <tr>
                                    <td class="gray" align="center" colspan="3"><a href="Controller?action=shoppingCartPage"><img src="images/basket.gif" alt="To καλάθι μου"/>To καλάθι μου</a></td>
                            </tr>
                            <tr>
                                    <td colspan="3" align="center">To καλάθι σας είναι άδειο...</td>
                            </tr>
                            <tr>
                                    <td colspan="3"></td>
                            </tr>
                            <tr>
                                    <td colspan="3"></td>
                            </tr>

               </table>
             <%}else{
                   ProductOrder porder;%>
        <table border="0" cellpadding="3" cellspacing="0" class="veryPale">
            <tr>
                    <td class="gray" align="center" colspan="3"><a href="Controller?action=shoppingCartPage&ov=1"><img src="images/basket.gif"/>To καλάθι μου</a></td>
            </tr>
            <%double total_price=0;%>
             <%for(int i=0;i<itemsOrdered.size();i++){
                            porder=(ProductOrder)itemsOrdered.get(i);   %>
            <tr>
                    <td colspan="2" style="font-size:10px"><b><%=porder.getNumItems()%>x</b><%= porder.getModel()%></td>
                    
            </tr>
            <% total_price=total_price + porder.getTotalCost();  %>
            <%}%>
            <tr>
                    <td colspan="1" align="right"><b> Συνολική αξία: </b></td>
                    <td style="color:red;"><%=total_price%>€</td>
            </tr>
            <tr>
                <td colspan="3" align="right"><a href="Controller?action=showMakeOrderPage"><img src="images/agora.bmp" alt="Αγορά"/></a></td>
            </tr>
	</table>
           <% } }%>
    </body>
</html>