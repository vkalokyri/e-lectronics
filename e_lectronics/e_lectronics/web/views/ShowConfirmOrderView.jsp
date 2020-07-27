<%--
    Document   : ShowRegisterView
    Created on : 8 Ιαν 2010, 8:38:23 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.OrderInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επιβεβαίωση αποστολής Παραγγελίας</title>
<script type="text/javascript" src="validate_form.js"></script>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />

<% OrderInfoBean order = (OrderInfoBean)request.getAttribute("model");%>
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
                <td valign="top" class=""><a href="Controller?action=shoppingCartPage&ov=1">Το καλάθι μου</a></td>
                <td valign="top" class="current"><a href="#">Επιβεβαίωση αποστολής</a></td>
            </tr>
        </table>

         <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>
	<div id="main_menu">		

		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="header"> <b>Επιβεβαίωση αποστολής παραγγελίας</b></td></tr>
		</table>


		<table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td colspan=2"><h2 style="margin-left:auto">Η παραγγελία σας στάλθηκε με επιτυχία!</h2></td>
                </table>


                 <table class="biggerWithBorder" cellspacing="3" cellpadding="3">
			<tr><td  style="font-size:16px"><b>Kωδικός παραγγελίας: <%=order.getOrderId()%></b></td></tr>
                        <%if(order.getDispatchType().equals("Παραλαβή")){%>
                            <tr><td style="font-size:13px">Μέθοδος αποστολής: <b>Παραλαβή από κατάστημα</b></td></tr>
                        <%}else{%>
                            <tr><td style="font-size:13px">Μέθοδος αποστολής: <b>Διανομή</b></td></tr>
                        <%}%>
                        <%if(order.getPaymentType().equals("Αντικαταβολή")){%>
                            <tr><td style="font-size:13px">Mέθοδος πληρωμής: <b>Αντικαταβολή</b></td></tr>
                        <%}else{%>
                            <tr><td style="font-size:13px">Mέθοδος πληρωμής: <b>Πιστωτική Κάρτα</b></td></tr>
                        <%}%>
`			
		</table>

		<table class="biggerWithBorder" cellspacing="3" cellpadding="3" style="background-color:#fff6bf">
			<tr><td  style="font-size:16px">Kατάσταση παραγγελίας:<b><%= order.getStatus()%>...</b></td></tr>
			<tr><td style="font-size:13px">Κωδικός πελάτη:<b><%=order.getCustomer().getCustomerID()%></b></td></tr>
                        
		</table>

                 <table class="bigger" cellspacing="3" cellpadding="3" style="background-color:#e0e6ed;">
                    <tr><td colspan=2"   style="font-size:12px">Όσο η παραγγελία σας είναι ακόμα σε κατάσταση <b>Εκκρεμής</b> μπορείτε να την επεξεργαστείτε ή ακόμα και να την ακυρώσετε.<br>
                                Επίσης, μπορείτε να βλέπετε την εξέλιξη κάθε παραγγελίας σας κάθε στιγμή, επισκέπτοντας τις <a href="Controller?action=showMyOrdersPage" style="text-decoration:underline; color:blue"> παραγγελίες σας</a> στον προσωπικό σας λογαριασμό.
                        </td>
                </table>
                
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
                                <%for (int i=0;i<order.getListOfOrderedProducts().size();i++){
                                    ProductOrder product=((ProductOrder)order.getListOfOrderedProducts().get(i));%>
                                    <tr><td><img src="<%=product.getImageUrl()%>" height="65px" width="65px" ></td>
					<td align="center"><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=product.getProductID()%>&CategID=<%=product.getCategoryID()%>&SubcategID=<%=product.getSubcategoryID()%>"><span style="color:blue" id="<%= product.getProductID()%>"><%= product.getModel()%></span><span style="color:gray" align="left"> -<%= product.getProductID()%></span></a></td>
					<td align="center"><%=product.getUnitCost()%> €</td>
					<td align="center">&nbsp;</td>                                        
                                        <td align="center"><%=product.getNumItems()%></td>
                                        <td align="center">&nbsp;</td>
                                        <td align="center"><span style="color:red"><b><%=product.getTotalCost()%>€</b></span></td>
                                    </tr>			

                                <% total_price=total_price + product.getTotalCost();  %>
				<%}%>
				<tr><td colspan="8">&nbsp;</td></tr><tr><td colspan="8"></td></tr>
				<tr><td colspan="6" align="right"><b>Συνολικό κόστος :  </b></td>
					<td align="center"><span style="color:red"><b><%=total_price%>€</b></span></td>
				</tr>
				<tr><td colspan="8">&nbsp;</td>
		</table>

                <table class="bigger" cellspacing="3" cellpadding="3">

                    <tr><td>
                     <p>&nbsp;</p>
                     <h3>Μπορείτε να πλοηγηθείτε:</h3>
                     <br>

                     - Στην <a href="Controller?action=loadFirstPage" style="font-weight:bold; text-decoration:underline;">αρχική σελίδα</a> του ηλεκτρονικού καταστήματος e-lectronics
                     <br>
                     <br>
                     - Στους προϊόντικούς καταλόγους μας
                     <br>
                     <br>
                     - Στη σελίδα του <a href="Controller?action=myAccountPage" style="font-weight:bold; text-decoration:underline;">λογαριασμού σας</a>

                     <br>
                     <br>
                     - Στη σελίδα <a href="Controller?action=showContactPage" style="font-weight:bold; text-decoration:underline;">επικοινωνίας</a>
                     <br>
                     <br>
                     - Στο <a href="Controller?action=shoppingCartPage" style="font-weight:bold; text-decoration:underline;">καλάθι σας</a>
                     <br>
                    </td></tr>
        </table>

    </div>
    <%@include file="footer.jsp" %>

</div>

</body>
</html>