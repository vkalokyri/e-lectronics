<%-- 
    Document   : ShowConfirmOrderChange
    Created on : 17 Φεβ 2010, 10:29:37 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CustomerInfoBean"%>
<%@page import="model.CategoryInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επιβεβαίωση αλλαγών παραγγελίας</title>
<script type="text/javascript" src="validate_form.js"></script>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />

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
                <td valign="top" class=""><a href="Controller?action=myAccountPage">Ο λογαριασμός μου</a></td>
                <td valign="top" class=""><a href="Controller?action=showMyOrdersPage">Οι παραγγελίες μου</a></td>
                <td valign="top" class="current"><a href="#">Επιβεβαίωση αλλαγών</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>

	<div id="main_menu">
		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="header"> <b>Επιβεβαίωση αλλαγών παραγγελίας</b></td></tr>
		</table>


		<table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td colspan=2"><h2 style="margin-left:auto">Όλες οι αλλαγές σας έγιναν με επιτυχία!</h2></td>
                    <tr><td>
                     <p>&nbsp;</p>
                     <h3>Τώρα μπορείτε να πλοηγηθείτε:</h3>
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
