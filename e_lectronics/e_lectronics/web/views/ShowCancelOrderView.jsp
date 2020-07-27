<%-- 
    Document   : ShowCancelOrderView
    Created on : 17 Φεβ 2010, 9:56:38 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CustomerInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επιβεβαίωση Ακύρωσης Παραγγελίας</title>
<script type="text/javascript" src="validate_form.js"></script>
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
<link href="style.css" rel="stylesheet" type="text/css" />

</head>

<body>

<div id="wrap">
    <%@include file="header.html" %>
    <div id="menucontainer">
         <%@include file="logoBar.jsp" %>
    </div>
    
    <%@include file="login_panel.jsp" %>
    <%@include file="option_bar.jsp" %>

    <%if(customer!=null){
        if(!customer.getIsAdmin()){%>
    <table id="breadcrumb" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
            <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
            <td valign="top" class=""><a href="Controller?action=myAccountPage">Ο λογαριασμός μου</a></td>
            <td valign="top" class=""><a href="Controller?action=showMyOrdersPage">Οι παραγγελίες μου</a></td>
            <td valign="top" class="current"><a href="#">Ακύρωση παραγγελίας</a></td>
        </tr>
    </table>
    <%}}%>

    <%if(customer!=null){
        if(customer.getIsAdmin()){%>        
    <table id="breadcrumb" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
            <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
            <td valign="top" class=""><a href="Controller?action=showReviewOrdersPage">Αναζήτηση παραγγελιών</a></td>
            <td valign="top" class="current"><a href="#">Ακύρωση παραγγελίας</a></td>
        </tr>
    </table>
    <%}}%>
    
    <%@include file="LeftMenu.jsp" %>
    <div id=RightMenu>
        <%@include file="SmallCart.jsp" %>
        <%@include file="login_form.jsp" %>
    </div>
	<div id="main_menu">
                <%if(customer!=null){
                    if(!customer.getIsAdmin()){%>                   
                    <table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="header"> <b>Επιβεβαίωση ακύρωσης παραγγελίας</b></td></tr>
                    </table>
                    <%}else{%>
                        <table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="blueheader"> <b>Επιβεβαίωση ακύρωσης παραγγελίας</b></td></tr>
                    </table>
                    <%}%>
                    <%if(!customer.getIsAdmin()){%>
                    <table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td align="center" colspan=2"><h2 style="margin-left:auto">Η ακύρωση της παραγγελίας πραγματοποιήθηκε με επιτυχία!</h2></td>
                    <tr><td>
                     <p>&nbsp;</p>
                     <h3>Μπορείτε να επισκεφτείτε:</h3>
                     <br>
                     - Την <a href="Controller?action=loadFirstPage" style="font-weight:bold; text-decoration:underline;">αρχική σελίδα</a> του ηλεκτρονικού καταστήματος
                     <br>
                     <br>
                     - Την <a href="Controller?action=showReviewOrdersPage" style="font-weight:bold; text-decoration:underline;">επισκόπηση παραγγελιών</a>
                     <br>
                     <br>
                     - Την σελίδα <a href="Controller?action=showInsertProductPage" style="font-weight:bold; text-decoration:underline;">εισαγωγής νέου προϊοντος</a>

                     <br>
                     <br>
                     - Την σελίδα <a href="Controller?action=showInsertCategoryPage" style="font-weight:bold; text-decoration:underline;">επεξεργασίας κατηγοριών</a>
                     <br>
                     <br>
                     - Την σελίδα <a href="Controller?action=showDeleteProductPage" style="font-weight:bold; text-decoration:underline;">διαγραφής προϊόντος</a>
                     <br>
                      <br>
                     - Την σελίδα <a href="Controller?action=showChangeProductPage" style="font-weight:bold; text-decoration:underline;">αλλαγής προϊόντος</a>
                     <br>
                    </td></tr>
                </table>
                <%}else{%>                   
                    
                    <table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="blueheader"> <b>Επιβεβαίωση ακύρωσης παραγγελίας</b></td></tr>
                    </table>
                        <table class="bigger" cellspacing="3" cellpadding="3">
                        <tr><td align="center" colspan=2"><h2 style="margin-left:auto">Η ακύρωση της παραγγελίας πραγματοποιήθηκε με επιτυχία!</h2></td>
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
                <%}}else{%>
                    <table class="biggerState" cellspacing="0" cellpadding="0">
                    <tr><td><a style="text-decoration:underline" href="Controller?action=loadFirstPage">Αρχική</a>&nbsp;»&nbsp;<a style="text-decoration:underline" href="Controller?action=myAccountPage">Ο λογαριασμός μου</a>&nbsp;»&nbsp;<a style="text-decoration:underline" href="Controller?action=showMyOrdersPage">Οι παραγγελίες μου</a>&nbsp;»&nbsp;<span style="color:gray">Aδυναμία Ακύρωσης Παραγγελίας</span></td></tr>
                    </table>
                    <table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="blueheader"> <b>Αδυναμία ακύρωσης παραγγελίας</b></td></tr>
                    </table>
                    <table class="bigger" cellspacing="3" cellpadding="3">
                        <tr><td align="center" colspan=2"><h3 style="margin-left:auto">Η ακύρωση της παραγγελίας απέτυχε.Παρακαλούμε ξαναδοκιμάστε.</h3></td>
                        <tr><td>
                         <p>&nbsp;</p>
                         <h4>Μπορείτε να πλοηγηθείτε:</h4>
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


                <%}%>
	</div>


<%@include file="footer.jsp" %>
</div>
</body>
</html>

