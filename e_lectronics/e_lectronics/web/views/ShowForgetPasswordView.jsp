<%-- 
    Document   : ShowForgetPasswordView
    Created on : 28 Φεβ 2010, 3:00:28 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Υπενθύμιση κωδικού πρόσβασης</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<% CustomerInfoBean custInfoBean = (CustomerInfoBean)request.getAttribute("model");%>
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
                <td valign="top" class="current"><a href="#">Υπενθύμιση κωδικού</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>

	<div id="main_menu">

		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="header"> <b> Υπενθύμιση κωδικού πρόσβασης</b></td></tr>
		</table>

		<img src="images/usr_password.gif"/>

		<table class="bigger" cellspacing="3" cellpadding="3" >
			<tr>
				<td style="font-size:13px"><b>Εισάγετε το e-mail σας με το οποίο δημιουργήσατε τον λογαριασμό σας στο E-lectronics.</b></td>
			</tr>
                        <tr>
                            <td>Θα σας σταλεί ένα e-mail το οποίο θα σας υπενθυμίζει τον κωδικό σας.</td>
                        </tr>
		</table>
                <form name="forgotPass" action="Controller?action=sendEmail&fr=1" method="post">
                    <table  class="bigger" cellspacing="3" cellpadding="3" >
                        <tr><td align="center" width="100%"><span id="email_error1" class="error" style="display:none; color:red">Πρέπει να εισάγετε το e-mail σας.</span>
                            <span id="email_error2" class="error" style="display:none; color:red">To email μπορεί να περιέχει γράμματα, αριθμούς και τα σύμβολα '_','@','.'</span>
                            <span id="email_error3" class="error" style="display:none; color:red">To email που δώσατε δεν είναι έγκυρο.</span>
                            <span id="email_error3" class="error" style="display:none; color:red">To email που δώσατε δεν είναι έγκυρο.</span>
                             <% if(custInfoBean!=null){  %>
                                <span class="error" id="email_error4" style="display:inline; color:red">Αυτό το email δεν αντιστοιχεί σε κάποιο χρήστη του E-lectronics. Βεβαιωθείτε ότι πληκτολογήσατε το σωστό e-mail.</span>
                                <%}%>
                        </td></tr>
                    </table>
                    <table  class="bigger" cellspacing="3" cellpadding="3" >                            
                            <tr><td align="right" width="200px"><b>E-mail:</b></td>
                                <td align="left"><input id="email" name="email" size="50" maxlength="50" type="text"></td>                                
                            </tr>
                    </table>
                    <table  class="bigger" cellspacing="3" cellpadding="3" >
                            <tr>
                                <td colspan="2" align="center"> <input value="Aποστολή" type="button" onclick="var bool=checkForgetEmail(); if(bool==true){ javascript:document.forgotPass.submit();}" size="20" maxlength="10" class="green_button"></td>
                            </tr>
                    </table>
                </form>
                <hr>
                <table  class="bigger" cellspacing="3" cellpadding="3" >
			<tr>
                            <td colspan="2"> Mήπως έχει αλλάξει το e-mail σας;  Αν έχετε ξεχάσει τον κωδικό πρόσβασης σας και δεν χρησιμοποιείτε πλέον το e-mail με το οποίο κάνατε εγγραφή στο E-lectronics, μπορείτε να δημιουργήσετε νέο λογαριαμό πατώντας εδώ :
                            <a style="text-decoration:underline; color:blue" href="Controller?action=showRegisterPage">Εγγραφή νέου χρήστη</a>
                            </td>
			</tr>
		</table>



	</div>





</div>

</body>

</html>
