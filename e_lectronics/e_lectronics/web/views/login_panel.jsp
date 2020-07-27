<%-- 
    Document   : login_panel
    Created on : 21 Ιαν 2010, 10:25:20 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CustomerInfoBean"%>

        
<table id="loginPanel">
                    <tr valign="middle">
                        <%session=request.getSession();
                      CustomerInfoBean customer;
                      synchronized(session){
                           customer = (CustomerInfoBean)session.getAttribute("CustomerInfo");
                           if (customer!=null){%>
                        <td valign="middle" class="userpanel">Kαλώς ήρθες
                        <b> <%= customer.getFirstname()%> </b>
                        <b> <%= customer.getLastname()%> ! </b></td>
                        <td width="20px" valign="middle" class="logout"><a href="Controller?action=showlogoutPage"><img src="images/exit4.gif" alt="Αποσύνδεση"/></a></td>
                        <td width="90px" valign="middle" class="logout"><a href="Controller?action=showlogoutPage" style="color:black; font-weight:bold">Αποσύνδεση</a></td>

                         <%}}%>
                        </tr>
                       
                    </table>
               

