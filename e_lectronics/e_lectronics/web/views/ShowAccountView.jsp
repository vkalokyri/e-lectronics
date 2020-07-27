<%-- 
    Document   : MyAccountView
    Created on : 30 Ιαν 2010, 5:28:07 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>O λογαριασμός μου</title>
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
        <table id="breadcrumb" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
                <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
                <td valign="top" class="current"><a href="#">Ο λογαριασμός μου</a></td>
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
				<td class="header"> <b>O λογαριασμός μου</b></td>
			</tr>
		</table>

		<table class="bigger" cellspacing="5" cellpadding="5">
			<tr>
				<td width="5px"><img src="images/profile30.gif"></td>
				<td class="lightgray"> <a href="Controller?action=showProfilePage"><b>Το προφίλ μου</b> </a></td>
			</tr>
			<tr>
				<td width="5px"><img src="images/orders30.gif"></td>
				<td class="lightgray"><a href="Controller?action=showMyOrdersPage"><b>Οι παραγγελίες μου</b> </a></td>
			</tr>
			<tr>
				<td width="5px"><img src="images/basket30.gif"></td>
				<td class="lightgray"><a href="Controller?action=showMyCartsPage"> <b>Τα καλάθια αγορών μου</b></a></td>
			</tr>

		</table>

	</div>
        <%@include file="footer.jsp"  %>
</div>

</body>

</html>