<%-- 
    Document   : ShowContactView
    Created on : 13 Ιαν 2010, 2:53:28 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επικοινωνία</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<body>

<div id="wrap">
   <%@include file="header.html" %>
  <div id="menucontainer">
    <div id="menu">
        <ul>
                <li><a href="Controller?action=loadFirstPage">αρχικη</a></li>
                <li><a href="Controller?action=showShopsPage">Kαταστηματα</a></li>
                <li><a href="#" class="current">Επικοινωνια</a></li>
        </ul>
    </div>
	</div>
	
        <%@include file="login_panel.jsp" %>	
	<%@include file="option_bar.jsp" %>

        <table id="breadcrumb" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
                <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
                <td valign="top" class="current"><a href="#">Επικοινωνία</a></td>
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
				<td class="header"> <b>Επικοινωνήστε μαζί μας </b></td>
			</tr>
			<tr>
				<td style="font-size:12px"> Αν θα θέλατε να επικοινωνήσετε μαζί μας για οποιοδήποτε θέμα σας ενδιαφέρει ή να μας ενημερώσετε για τις παρατηρήσεις σας παρακαλούμε να συμπληρώσετε την παρακάτω φόρμα.</td>
			</tr>
		</table>

                <form name="contact" action="Controller?action=sendEmail" method="post">
                    <table align="center"  class="bigger" cellspacing="3" cellpadding="5" >
                            <tr>
                                    <td class="gray" align="center" colspan="2"> Φόρμα επικοινωνίας</td>
                            </tr>                          
                            <tr><td  valign="top" style="background-color:#e0e6ed"><b>E-mail:</b></td>
                                <td  valign="top">
                                <input id="email" name="email" size="50" maxlength="50" type="text"></td>
                                <td width="100%"><span id="email_error1" class="error" style="display:none; color:red">Πρέπει να εισάγετε το e-mail σας.</span>
                                    <span id="email_error2" class="error" style="display:none; color:red">To email μπορεί να περιέχει γράμματα, αριθμούς και τα σύμβολα '_','@','.'</span>
                                    <span id="email_error3" class="error" style="display:none; color:red">To email που δώσατε δεν είναι έγκυρο.</span>
                                </td>
                            </tr>
                            <tr><td  valign="top" style="background-color:#e0e6ed"><b>Θέμα:</b></td>
                                    <td  valign="top">
                                    <input id="subject" name="subject" size="50"  maxlength="20" type="text">
                            </td></tr>

                            <tr><td  valign="top" style="background-color:#e0e6ed"><b>Μήνυμα:</b></td>
                                    <td  valign="top">
                                    <textarea id="body" name="body" rows="10" cols="38" class="text"></textarea>

                            </td></tr>
                            <tr><td><input value="Aκύρωση" type="button" onclick="loaction.href='Controller?action=loadFirstPage'" class="gray_button"></td>
                                    <td align="center"><input value="Αποστολή" onclick="var bool=checkEmailFields(); if(bool==true){ javascript:document.contact.submit();}" type="button" class="green_button"></td></tr>



                    </table>
                </form>
	</div>
        <%@include file="footer.jsp" %>
</div>
</body>
</html>