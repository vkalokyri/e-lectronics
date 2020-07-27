<%-- 
    Document   : ShowLogoutView
    Created on : 20 Φεβ 2010, 1:44:01 πμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<meta http-equiv="refresh" content="3;url=Controller?action=loadFirstPage">
<title>Αποσύνδεση</title>
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
                <td valign="top" class="current"><a href="Controller?action=loadFirstPage">Αρχική</a></td>
                <td valign="top" class="current"><a href="#">Αποσύνδεση</a></td>
            </tr>
      </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>

	<div id="main_menu">
		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="header"> <b>Επιτυχής Αποσύνδεση</b></td></tr>
		</table>


		<table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td colspan=2"><h2 style="margin-left:auto">Σας ευχαριστούμε που επισκεφτήκατε το κατάστημα μας.</h2></td>                   
        </table>
	</div>

<%@include file="footer.jsp" %>
</div>


</body>
</html>
