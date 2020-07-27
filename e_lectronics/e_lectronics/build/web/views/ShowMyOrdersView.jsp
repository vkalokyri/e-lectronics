<%-- 
    Document   : ShowMyOrdersView
    Created on : 3 Φεβ 2010, 9:44:41 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.OrderInfoBean"%>
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
<title>Οι παραγγελίες μου</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="validate_form.js"></script>
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<%Vector listOfOrders = (Vector)request.getAttribute("model");%>
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
                <td valign="top" class="current"><a href="#">Οι παραγγελίες μου</a></td>
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
				<td class="header"> <b>Oι Παραγγελίες μου</b></td>
			</tr>
                        <tr>
				<td style="font-size:12px">Mπορείτε να επιλέξετε και να επεξεργαστείτε τις παραγγελίες σας αρκεί η κατάσταση τους να είναι <b>Εκκρεμής</b>.
				Σε άλλη περίπτωση δεν μπορείτε να τις επεξεργαστείτε. </td>
			</tr>
		</table>



                <table class="biggerWithBorder" cellspacing="0" cellpadding="6">
			<tr>
				<td class="gray" align="center"><b>Κωδικός παραγγελίας</b></td>
				<td class="gray" align="center"><b>Hμερομηνία παραγγελίας</b></td>
				<td class="gray" align="center"><b>Συνολικό κόστος</b></td>
				<td class="gray" align="center"><b>Κατάσταση παραγγελίας</b></td>
			</tr>
                </table>

                <%if(listOfOrders.size()==0) {%>
                    <h2 align="middle" style="margin-top:50px"> Δεν υπάρχουν διαθέσιμες παραγγελίες...</h2>
                 <%}%>

		                      
                    <table class="biggerWithBorder" cellspacing="0" cellpadding="6">
                        <%for(int i=0;i<listOfOrders.size();i++){
                            OrderInfoBean order=(OrderInfoBean)listOfOrders.get(i);%>
			<tr>
                            <td align="center"><a href="Controller?action=showSpecificOrderPage&oid=<%=order.getOrderId()%>" style="color:blue"><%=order.getOrderId()%></a></td>
                                <% Date date=order.getDate();
                                   DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");%>
				<td align="center"><%=dateFormat.format(date)%></td>
				<td align="center"><%=order.getTotal_price()%> €</td>
                                <td align="center"><span <%if(order.getStatus().equals("Εκκρεμής")){%>style="color:#00EC76"<%}else{%> style="color:red;"  <%}%>><%=order.getStatus()%></span></td>
			</tr>
                        <%}%>
			
		</table>
	</div>
        <%@include file="footer.jsp" %>
    </div>
    </body>
</html>
