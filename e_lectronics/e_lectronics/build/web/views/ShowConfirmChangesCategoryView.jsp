<%--
    Document   : ShowConfirmChangesProductView
    Created on : 14 Φεβ 2010, 3:20:28 πμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επιβεβαίωση αλλαγών</title>
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
                <td valign="top" class=""><a href="Controller?action=showInsertCategoryPage">Eπεξεργασία κατηγοριών</a></td>
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
			<tr><td class="blueheader"> <b>Επιβεβαίωση αλλαγών</b></td></tr>
		</table>
		<table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td align="center" colspan=2"><h2 style="margin-left:auto">Οι αλλαγές πραγματοποιήθηκαν με επιτυχία!</h2></td>
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
	</div>


<%@include file="footer.jsp" %>
</div>
</body>
</html>
