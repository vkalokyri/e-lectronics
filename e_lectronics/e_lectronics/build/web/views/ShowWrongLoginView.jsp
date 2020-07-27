<%--
    Document   : ShowFirstPageView
    Created on : 4 Ιαν 2010, 9:40:43 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CategoryInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Λάθος στοιχεία εισόδου</title>
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

  <table id="breadcrumb" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
            <td valign="top" class="current"><a href="Controller?action=loadFirstPage">Αρχική</a></td>
            <td valign="top" class="current"><a href="#">Είσοδος χρήστη</a></td>
        </tr>
  </table>
  
  <%@include file="option_bar.jsp" %>
  <%@include file="LeftMenu.jsp" %>
  <div id=RightMenu>        
        <%@include file="SmallCart.jsp" %>
        <%@include file="login_form.jsp" %>
    </div>

    <div id="main_menu">
            <table class="bigger" cellspacing="3" cellpadding="3">
			<tr><td class="header"> <b>Λάθος στοιχεία εισόδου</b></td></tr>
            </table>

            <form name ="sign_in"  method="Post"  action=<%="Controller?"+request.getQueryString()%> onsubmit="return validateFormOnLogin(this)">
            <table class="biggerWithBorder" cellspacing="0" cellpadding="3" style="background-color: #FAFDFE;" >
                <tr>
                    <td class="lightgray" colspan="2" style="border-right: 1px solid gray;"><h3>Είμαι ήδη μέλος </h3> </td>
                    <td class="lightgray" ><h3>Θέλω να γίνω μέλος </h3> </td>
                </tr>
                <tr><td colspan="2" style="border-right: 1px solid gray;"><span id="base_error" class="error" style="display:inline; color:red; font-size:11px; ">To όνομα χρήστη ή ο κωδικός πρόσβασης που εισάγατε δεν είναι έγκυρα.</span></td>
                <td style="font-size:13px">Δεν είστε μέλος στο e-lectrοnics;</td></tr>
                <tr><td></td><td style="border-right: 1px solid gray;"><span id="user_error" class="error" style="display:none; color:red;">Δεν εισάγατε όνομα χρήστη.</span></td>
                            
                        <tr>

                                <td style="" align="left"><b>Όνομα χρήστη:</b></td>
                                <td valign="top" style="border-right: 1px solid gray;"><input name="un" class="form" size="30" maxlength="10" type="text"></td>
                                
                                <td style="font-size:13px">Mπορείτε να γίνετε τώρα.</td>
                                
                        </tr>
                        <tr><td></td><td style="border-right: 1px solid gray;"><span id="pass_error" class="error" style="display:none; color:red">Δεν εισάγατε κωδικό.</span></td></tr>
                        <tr>
                                <td style="" align="left"><b>Κωδικός πρόσβασης:</b></td>
                                <td style="border-right: 1px solid gray;" valign="top"><input name="pw" class="form" size="30" maxlength="10" type="password"></td>
                                
                                <td colspan="2" align="center"><a href="Controller?action=showRegisterPage" style="color:blue; text-decoration:underline; font-size:15px" ><b>Εγγραφή τώρα</b></a>
                        </tr>
                        <tr>
                            
                            <td colspan="2" style="border-right: 1px solid gray;"><a href="Controller?action=showForgetPasswordPage" style="color:blue; text-decoration:underline">Ξέχασα τον κωδικό πρόσβασης </a></td>
                        </tr>
                        <tr><td colspan="2" style="border-right: 1px solid gray;"></td></tr>
                        <tr>
                            <td><input style="font-size:12px" value="Aκύρωση" type="button" <%if (request.getQueryString()!=null){%>onclick="location.href='Controller?<%=request.getQueryString()%>'"<%}else{%> onclick="location.href='Controller?action=loadFirstPage'" <%}%> size="20" maxlength="10" class="gray_button"></td>
                            <td align="center" style="border-right: 1px solid gray;"><input style="font-size:12px" value="Eίσοδος" type="submit" size="20" maxlength="10" class="green_button"></td>
                        </tr>
                        
            </table>
        </form>
            
            
    </div>

<%@include file="footer.jsp" %>
</div>



</body>

</html>