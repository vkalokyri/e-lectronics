<%--
    Document   : ShowDeleteProductView
    Created on : 12 Φεβ 2010, 5:46:16 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CharacteristicsInfoBean"%>
<%@page import="model.ValueInfoBean"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Διαγραφή προϊόντος</title>
<script type="text/javascript" src="validate_form.js"></script>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<body>

<%ProductInfoBean prod=(ProductInfoBean)request.getAttribute("model");%>
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
                <td valign="top" class="current"><a href="#">Διαγραφή προϊόντος</a></td>
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
				<td class="blueheader"> <b>Διαγραφή Προϊόντος</b></td>
			</tr>

		</table>

                <form name="deleteProduct" action="Controller?action=showDeleteProductPage" method="post" onsubmit="return validateNumber(sn)">
                    <table class="biggerWithBorder" cellspacing="3" cellpadding="8">
                            <tr><td class="gray" colspan="3"><b>Aναζήτηση προϊόντος προς διαγραφή</b></td></tr>
                            <tr id="nbr_error" style="display:none"><td colspan="3"><span  class="error" style="color:red">Μη έγκυροι χαρακτήρες.</span></td></tr>
                            <tr><td><b>Κωδικός προϊόντος</b></td><td><input name="sn" type="text" size="30"></td>
                            <td align="left"><input value="Αναζήτηση" type="submit" class="blue_button" style="font-weight:bold;" ></td></tr>
                    </table>
                </form>

                


                <form name="deleteProduct" >
                    <%if(prod!=null){
                        if(!prod.IsDeleted()){%>
                            <table class="bigger" cellspacing="3" cellpadding="3">
                                     <tr><td>&nbsp;</td></tr>
                                    <tr><th style="font-size:15px">Η διαγραφή δεν μπόρεσε να πραγματοποιηθεί λόγω εκκρεμούς παραγγελίας.</th></tr>
                            </table>
                        <%}else{
                               if(prod.getManufacturer()!=null){%>
                        <table class="bigger" cellspacing="3" cellpadding="3">
                            <tr>
                                <td class="greendark"> <b>Χαρακτηριστικά Προϊόντος</b></td>
                            </tr>
                        </table>
                        <table class="biggerWithBorder" cellspacing="3" cellpadding="3">
                            <tr style="display:none"><td><input name="SN" type="text" value="<%=prod.getSerialNumber()%>" > </td></tr>
                            <tr>
                                    <td class="lightgray"> <b>Κωδικός προϊόντος  </b></td>
                                    <td height="27px"><%=prod.getSerialNumber()%></td>
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Κατασκευαστής </b></td>
                                    <td height="27px"><%=prod.getManufacturer()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Μοντέλο  </b></td>
                                    <td height="27px"><%=prod.getModel()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Τιμή (€)</b></td>
                                    <td height="27px"><%=prod.getPrice()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Εγγύηση  </b></td>
                                    <td height="27px"><%=prod.getWarranty()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Ποσότητα Αποθέματος  </b></td>
                                    <td height="27px"><%=prod.getStock()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray" valign="top"> <b>Url Εικόνας  </b></td>
                                    <td height="27px"><%=prod.getImageUrl()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray" valign="top"> <b>Όριο ποσότητας αποθέματος  </b></td>
                                    <td height="27px"><%=prod.getThreshold()%></td>
                                    
                            </tr>
                            <tr>
                                    <td class="lightgray" valign="top"> <b>Περιγραφή  </b></td>
                                    <td height="27px"><%=prod.getDescription()%></td>
                                    
                            </tr>
                                <%for(int i=0;i<prod.getCharacteristics().getListOfCharacteristics().size();i++){ %>
                                <tr>
                                        <td class="lightgray"><%= ((CharacteristicsInfoBean)prod.getCharacteristics().getListOfCharacteristics().get(i)).getName()%></td>
                                        <%if (((ValueInfoBean)prod.getCharacteristics().getValues().getListOfValues().get(i)).getName()!=null){%>
                                        <td><%= ((ValueInfoBean)prod.getCharacteristics().getValues().getListOfValues().get(i)).getName()%></td>
                                        <%}else{%>
                                            <td height="27px">-</td>
                                        <%}%>
                                </tr>
                             <%}%>
                             <tr>
                                 <td class="lightgray">Mή συμβατότητα</td>
                                <%if(prod.getListOfIncompatibleProducts().size()!=0){%>
                                <td><%=((ProductInfoBean)prod.getListOfIncompatibleProducts().get(0)).getSerialNumber()%>-><%=((ProductInfoBean)prod.getListOfIncompatibleProducts().get(0)).getModel()%></td>
                                <%}else{%>
                                <td>-</td>
                                <%}%>
                             </tr>
                             <%for(int i=1;i<prod.getListOfIncompatibleProducts().size();i++){ %>
                             <tr>
                                <td class="lightgray"></td>                                
                                <td><%=((ProductInfoBean)prod.getListOfIncompatibleProducts().get(i)).getSerialNumber()%>-><%=((ProductInfoBean)prod.getListOfIncompatibleProducts().get(i)).getModel()%></td>                               
                             </tr>
                              <%}%>
                              <tr>
                                <td class="lightgray">Mέγιστη Απόδοση</td>
                                <%if(prod.getListOfMaxPerformanceProducts().size()!=0){%>
                                <td><%=((ProductInfoBean)prod.getListOfMaxPerformanceProducts().get(0)).getSerialNumber()%>-><%=((ProductInfoBean)prod.getListOfMaxPerformanceProducts().get(0)).getModel()%></td>
                                <%}else{%>
                                <td>-</td>
                                <%}%>
                             </tr>
                              <%for(int j=1;j<prod.getListOfMaxPerformanceProducts().size();j++){ %>
                             <tr>
                                <td class="lightgray"></td>                                
                                <td><%=((ProductInfoBean)prod.getListOfMaxPerformanceProducts().get(j)).getSerialNumber()%>-><%=((ProductInfoBean)prod.getListOfMaxPerformanceProducts().get(j)).getModel()%></td>                                
                             </tr>
                             <%}%>
                     </table>
                     <table class="bigger" cellspacing="3" cellpadding="3">
                         <tr><td align="right"><input value="Διαγραφή" type="button" onclick="confirmDelete(<%=prod.getSerialNumber()%>); " class="red_button"></td></tr>
                    </table>
                     <%}else{%>
                                <table class="bigger" cellspacing="3" cellpadding="3">
                                    <tr><td>&nbsp;</td></tr>
                                    <tr><th style="font-size:15px">Δεν υπάρχει προϊόν με αυτό τον κωδικό.</th></tr>
                                 </table>
                    <%}}}%>
           </form>

	</div>
        <%@include file="footer.jsp" %>
</div>

</body>

</html>