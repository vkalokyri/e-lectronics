<%-- 
    Document   : login_form
    Created on : 21 Ιαν 2010, 8:06:57 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CustomerInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%session=request.getSession();
          CustomerInfoBean cust;
          if (session.getAttribute("currentUrl")!=null){
              if (!((String)session.getAttribute("currentUrl")).startsWith("action=shoppingCartPage") && !((String)session.getAttribute("currentUrl")).startsWith("action=addToCartPage") ){
                session.setAttribute("previousUrl",session.getAttribute("currentUrl"));
              }
          }

          if (request.getQueryString()!=null){
             if(request.getQueryString().startsWith("action=shoppingCartPage") || request.getQueryString().startsWith("action=addToCartPage") ){
                session.setAttribute("currentUrl","action=shoppingCartPage&ov=1");
             }else{
                 session.setAttribute("currentUrl",request.getQueryString());
             }
          }


          
          synchronized(session){
               cust = (CustomerInfoBean)session.getAttribute("CustomerInfo");              
           
            if (cust==null){ %>         
            <form name ="sign_in"  method="Post"  action=<%="Controller?"+ session.getAttribute("currentUrl")%> onsubmit="return validateFormOnLogin(this)">
                            <table style="width:100%" border="0" cellpadding="3" cellspacing="0" class="veryPale">
                                    <tr>
                                            <td class="greendark" align="center" colspan="2">Eίσοδος χρήστη</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><span id="user_error" class="error" style="display:none; color:red; font-size:10">Δεν εισάγατε όνομα χρήστη.</span>
                                         <span id="pass_error" class="error" style="display:none; color:red">Δεν εισάγατε κωδικό.</span></td>
                                    </tr>
                                    <tr>
                                            <td> Όνομα Χρήστη </td>
                                            <td> <input  class="form" name="un" size="10" type="text"></td>
                                    </tr>
                                    
                                    <tr>
                                            <td> Κωδικός πρόσβασης </td>
                                            <td> <input class="form" name="pw" size="10" type="password"></td>
                                    </tr>
                                    <tr>
                                            <td></td>
                                            <td align="center"><input type="submit" value="EΙΣΟΔΟΣ" class="green_button"></td>
                                    </tr>
                                    <tr>
                                              <td class="bold" height="25"  colspan="2" >
                                              <a href="Controller?action=showForgetPasswordPage"> Ξέχασα τον κωδικό πρόσβασης !</a>	</td>

                                     </tr>

                            </table>
                    


                    <table style="width:100%" border="0" cellpadding="3" cellspacing="0" class="veryPale">
                            <tr>
                                    <td class="greendark" align="center" colspan="3"></td>
                            </tr>
                            <tr>
                                    <td colspan="3" align="center" class="bold"> <a href="Controller?action=showRegisterPage">Eγγραφή νέου χρήστη</a></td>
                            </tr>
                            <tr>
                                    <td class="greendark" align="center" colspan="3"></td>
                            </tr>
                    </table>
                            </form>
           
         <%}%>
            <%if (cust!=null && cust.getIsAdmin()){ %>
                <table style="width:100%" border="0" cellpadding="3" cellspacing="0" class="veryPale">
                            <tr>
                                    <td class="greendark" align="center" colspan="3"></td>
                            </tr>
                            <tr>
                                    <td colspan="3" align="center" class="bold"> <a href="Controller?action=showRegisterPage">Eγγραφή νέου διαχειριστή</a></td>
                            </tr>
                            <tr>
                                    <td class="greendark" align="center" colspan="3"></td>
                            </tr>
                    </table>
            <%}%>
         <%}%>
         <table style="width:100%" cellspacing="3" border="1">
              <tr><td><img src="images/0909_Router_Belkin_1332023_160.jpg"/></td></tr>
         </table>
    </body>
</html>
