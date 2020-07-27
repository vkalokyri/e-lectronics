<%-- 
    Document   : ShowMyCartsView
    Created on : 18 Φεβ 2010, 11:21:11 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CartInfoBean"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParsePosition"%>
<%@page import="java.text.SimpleDateFormat"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Tα καλάθια αγορών μου</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="validate_form.js"></script>
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<%Vector listOfCarts = (Vector)request.getAttribute("model");%>
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
                <td valign="top" class="current"><a href="#">Tα καλάθια αγορών μου</a></td>
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
				<td class="header"> <b>Τα καλάθια μου</b></td>
			</tr>                        
		</table>
                <table class="bigger" cellspacing="3" cellpadding="3" style="background-color:#e0e6ed;">
                    <tr><td colspan=2"   style="font-size:12px">Μπορείτε να επιλέξετε και να διαγράψετε όποια αποθηκευμένα καλάθια αγορών θέλετε ,
                            πατώντας το κουμπί "Διαγραφή καλαθιού".
                        </td>
                </table>

                <table class="biggerWithBorder" cellspacing="0" cellpadding="6">
			<tr>
                            <td class="gray" align="center">&nbsp</td>
                            <td class="gray" align="center"><b>Κωδικός καλαθιού</b></td>
                            <td class="gray" align="center"><b>Hμερομηνία αποθήκευσης καλαθιού</b></td>
                            <td class="gray" align="center"><b>Συνολικό κόστος</b></td>
			</tr>
                </table>

                <%if(listOfCarts.size()==0) {%>
                    <h2 align="middle" style="margin-top:50px"> Δεν υπάρχουν διαθέσιμα καλάθια αγορών...</h2>
                 <%}else{%>
                 <form name="myCarts" action="Controller?action=showDeleteCartPage" method="post">
                    <table class="biggerWithBorder" cellspacing="0" cellpadding="6">
                        <%for(int i=0;i<listOfCarts.size();i++){
                            CartInfoBean cart=(CartInfoBean)listOfCarts.get(i);%>
			<tr>
                            <td><input type="checkbox" name="check" value="<%=cart.getCartID()%>"></td>
                            <td align="center"><a href="Controller?action=showSpecificCartPage&cid=<%=cart.getCartID()%>" style="color:blue"><%=cart.getCartID()%></a></td>
                                <%DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                                  Date date=dateFormat.parse(cart.getDate(),new ParsePosition(0));
                                  dateFormat = new SimpleDateFormat("dd/MM/yyyy");  %>
                                  <td align="center"><%=dateFormat.format(date)%></td>
				<td align="center"><span style="color:red"><%=cart.getTotalPrice()%>  €</span></td>
			</tr>
                        <%}%>
                        
		</table>
                <table class="bigger" cellspacing="0" cellpadding="6">
                    <tr><td align="right"><input class="red_button" type="button" onclick="var answer=confirmOption(); if(answer){ javascript:document.myCarts.submit(); }" value="Διαγραφή καλαθιού"></td></tr>
                </table>
                <%}%>
                </form>
	</div>
        <%@include file="footer.jsp" %>
    </div>
    </body>
</html>
