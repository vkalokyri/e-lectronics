<%-- 
    Document   : ShowMakeOrderView
    Created on : 31 Ιαν 2010, 9:57:28 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Ολοκλήρωση Παραγγελίας</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>
<% ShoppingCartBean cart = (ShoppingCartBean)session.getAttribute("shoppingCart");%>
<body onload="checkChanged(); checkChanged2();">

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
                <td valign="top" class=""><a href="Controller?action=shoppingCartPage&ov=1">Το καλάθι μου</a></td>
                <td valign="top" class="current"><a href="#">Ολοκλήρωση Παραγγελίας</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>	
	<div id="main_menu">	
		<table cellpadding="0" cellspacing="5" class="bigger">
                    <tr><td colspan="2" align="center" class="header"><b>Ολοκλήρωση παραγγελίας</b></td></tr>
		</table>

		<table cellpadding="0" cellspacing="5" class="bigger">
			<tr>
				<td align="center" colspan="5" class="greendark">H Παραγγελία σας</td>
			</tr>
		</table>

                <% synchronized(session){
               String id="";
               int num=0;
               Vector itemsOrdered=cart.getItemsOrdered();
               if (itemsOrdered.size()==0){%>
               <h2 align="left" style="margin-top:50px"> To καλάθι σας είναι άδειο...</h2>
             <%}else{
                   ProductOrder order;%>

		<form name ="order"  method="Post"  action="Controller?action=showConfirmOrderPage" onsubmit="return validateOrder(this)"  >
		<table class="basketTable" cellspacing="0" cellpadding="0">
				<tr><td align="center" class="gray" colspan="2"><b>Όνομα προϊόντος</b></td>
					<td align="center" class="gray">Tιμή μον.</td>
					<td align="center" class="gray">&nbsp;</td>
					<td align="center" class="gray">Τεμάχια </td>
					<td align="center" class="gray">&nbsp;</td>
					<td align="center" class="gray">Τελική Αξία </td>
					<td align="center" class="gray">&nbsp;</td>
				</tr>
                          <%double total_price=0;%>
                       <%for(int i=0;i<itemsOrdered.size();i++){
                            order=(ProductOrder)itemsOrdered.get(i);   %>
                            <tr>
                                <td><img src="<%=order.getImageUrl() %>" height="65px" width="65px" ></td>
                                <td align="center"><a style="color:blue" href="Controller?action=showProductDetailsPage&SerialNumber=<%=order.getProductID()%>&CategID=<%=order.getCategoryID()%>&SubcategID=<%=order.getSubcategoryID()%>"><span style="color:blue" id="<%= order.getProductID()%>"><%= order.getModel()%></span><span style="color:gray" align="left"> -<%= order.getProductID()%></span></a></td>
                                <td align="center"><%=order.getUnitCost()%> €</td>
                                <td align="center">&nbsp;</td>
                                <td align="center"><%=order.getNumItems()%></td>
                                <td align="center">&nbsp;</td>
                                <td align="center"><span style="color:red"><b><%=order.getTotalCost()%> €</b></span></td>                                      
                           </tr>

                               <% total_price=total_price + order.getTotalCost();  %>
				<%}%>                               
				<tr><td colspan="8">&nbsp;</td></tr><tr><td colspan="8"></td></tr>
				<tr><td colspan="6" align="right"><b>Συνολικό κόστος :  </b></td>
					<td align="center"><span style="color:red"><b><%=total_price%> €</b></span></td>
				</tr>
				<tr><td colspan="8">&nbsp;</td>
		</table>
               
                <%}}%>

		<table cellpadding="0" cellspacing="5" class="bigger">
			<tr>
				<td align="center" colspan="5" class="greendark">Φόρμα Παραγγελίας</td>
			</tr>
		</table>

                <% CustomerInfoBean custInfoBean;
                   if(cust!=null){
                    custInfoBean=cust;
                    }else{
                    custInfoBean = (CustomerInfoBean)session.getAttribute("CustomerInfo");}%>
                
                    <table cellpadding="0" cellspacing="3" class="biggerWithBorder">
                                <tr><td colspan="3" align="center" class="tdgray"><b>Στοιχεία πληρωμής</b></td></tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Τρόπος πληρωμής:</b></td>
                                    <td  colspan="2" valign="top">
                                        <select name="pliromi" class="select" onchange="checkChanged()" >
                                            <option value="1" selected="selected">Αντικαταβολή</option>
                                            <option value="0" >Πιστωτική κάρτα</option>
					</select>                                        
                                </tr>
                                
                                <tr>
                                    <td style="background-color:#e0e6ed"><span id="space"  style="display:none;"></span></td>
                                    <td colspan="2"><span id="info" style="display:none;">Για την πρώτη φορά χρήσης της πιστωτικής κάρτας στο κατάστημά μας
					πρέπει να αποστείλετε ένα αντίγραφο της ταυτότητας καθώς
					και της πιστωτικής κάρτας (με καλυμμένα τα 4 τελευταία ψηφία) στο
					<a href="mailto:vkalokyri@gmail.com" style="color:blue">logistirio@e-lectronics.gr</a>
					ή στο fax 28210&nbsp;68&nbsp;358 </span></td>
                                </tr>
                                </tbody>
                                <tr>
                                    <td style="background-color:#e0e6ed">
                                        <span id="creditCard" style="display:none"><b>*Πιστωτική κάρτα:</b></span></td>
                                    <td colspan="2" align="left" valign="middle">
					<span id="creditCardOpt" style="display:none;"><select name="cardtype" class="select">
					<option value="VISA" >VISA</option>
					<option value="MasterCard">MasterCard</option>
					<option value="Euroline">Euroline</option>
					<option value="Diners">Diners</option>
					<option value="American Express">American Express</option>
					</select>
					<br><br><a href="javascript:selectcard('VISA');"><img src="images/visa.gif" border="0"></a> <a href="javascript:selectcard('MasterCard');"><img src="images/mastercard.gif" border="0"></a> <a href="javascript:selectcard('Euroline');"><img src="images/euroline.gif" border="0"></a> <a href="javascript:selectcard('Diners');"><img src="images/diners.gif" border="0"></a> <a href="javascript:selectcard('American Express');"><img src="images/americanexpress.gif" border="0"></a></span>
				    </td>

                                </tr>
                                <tr>
                                    <td style="background-color:#e0e6ed" width="50%" valign="middle">
                                        <span id="cardno" style="display:none"><b>*Αρ. κάρτας</b></span></td>
                                    <td align="left" valign="middle"><span id="cardnofield" style="display:none"><input name="cardnumber" class="form" size="30" maxlength="20" type="text"></span></td>
                                    <td><span id="cardno_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="cardno_error2" class="error" style="display:none; color:red">O αριθμός που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                        <span id="cardno_error3" class="error" style="display:none; color:red">Τα ψηφία του αριθμού της κάρτας πρέπει να είναι 16.</span></td>
                                </tr>
                                <tr>
                                        <td style="background-color:#e0e6ed" width="50%" valign="middle">
                                            <span id="cvv" style="display:none"><b>*Αρ. CVV2</b></span></td>
                                        <td align="left" valign="middle">
                                        <span id="cvvfld" style="display:none"><input name="cvv" class="form" size="5" maxlength="4" type="text">&nbsp;&nbsp;CVV2:Tα 3 ψηφία στο πίσω μέρος της κάρτας</span></td>
                                        <td><span id="cvv_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="cvv_error2" class="error" style="display:none; color:red">O αριθμός που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                        <span id="cvv_error3" class="error" style="display:none; color:red">Τα ψηφία του αριθμού cvv2 πρέπει να είναι 3.</span></td>

                                </tr>
                                <tr>
                                    <td style="background-color:#e0e6ed" width="50%" valign="middle">
					<span id="expire" style="display:none" ><b>*Ημερομηνία λήξεως κάρτας:</b></span></td>
                                        <td align="left" valign="middle">
                                        <span id="expiredate" style="display:none" >
					<select name="expiremonth" class="select">
					<option value="Ιανουάριος">Ιανουάριος</option>
					<option value="Φεβρουάριος">Φεβρουάριος</option>
					<option value="Μάρτιος">Μάρτιος</option>
					<option value="Απρίλιος">Απρίλιος</option>
					<option value="Μάιος">Μάιος</option>
					<option value="Ιούνιος">Ιούνιος</option>
					<option value="Ιούλιος">Ιούλιος</option>
					<option value="Αύγουστος">Αύγουστος</option>
					<option value="Σεπτέμβριος">Σεπτέμβριος</option>
					<option value="Οκτώβριος">Οκτώβριος</option>
					<option value="Νοέμβριος">Νοέμβριος</option>
					<option value="Δεκέμβριος">Δεκέμβριος</option>
					</select>&nbsp;
					<select name="expireyear" class="select">
					<option value="2010">2010</option>
                                        <option value="2011">2011</option>
                                        <option value="2012">2012</option>
                                        <option value="2013">2013</option>
                                        <option value="2014">2014</option>

                                        <option value="2015">2015</option>
                                        <option value="2016">2016</option>
					</select>
                                        </span>
					</td>
                                        
                                </tr>
                                <tr>
                                    <td style=" background-color:#e0e6ed"><span id="cardholderName"  style="display:none; background-color:#e0e6ed"><b>*Όνομα κατόχου κάρτας:</b></span></td>
                                    <td><span id="cardholderNameField"  style="display:none; background-color:#e0e6ed"><input name="cardholder" class="form" size="50"  maxlength="30" type="text"></span>
                                        <td><span id="cardname_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="cardname_error2" class="error" style="display:none; color:red">To όνομα μπορεί να περιέχει μόνο γράμματα.</span></td>
                                </tr>
                                <tr>
                                    <td style=" background-color:#e0e6ed"><span id="cardholderPho"  style="display:none; background-color:#e0e6ed"><b>*Τηλέφωνο κατόχου κάρτας:</b></span></td>
                                    <td><span id="cardholderPhoField"  style="display:none; background-color:#e0e6ed"><input name="cardholderpho" class="form" size="50"  maxlength="10" type="text"></span>
                                    <td><span id="cardpho_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Aν δεν υπάρχει τηλέφωνο πληκτρολογείστε το 0.</span>
                                        <span id="cardpho_error2" class="error" style="display:none; color:red">To τηλέφωνο που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                        <span id="cardpho_error3" class="error" style="display:none; color:red">Τα ψηφία του τηλεφώνου πρέπει να είναι 10.</span></td>
                                </tr> 
                                
                           
                           
                                <tr><td colspan="3" align="center" class="tdgray">Στοιχεία αποστολής</td></tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Τρόπος αποστολής:</b></td>
                                    <td  valign="top">  <select name="apostoli" class="select"  onchange="checkChanged2()">
                                                        <option selected="selected">Διανομή</option>
                                                        <option>Παραλαβή από κατάστημα</option>          
                                                         </select>
                                    </td>
                               </tr>
                                <tr><td style="background-color:#e0e6ed" width="50%" valign="top"><span id="shop" style="display:none" ><b>*Kατάστημα:</b></span></td>
                                        <td align="left" valign="middle">
                                        <span id="shopName" style="display:none" >
					<select name="shop" class="select" >
                                        <option>Αθήνα-Αιγάλεω</option>
                                        <option>Αθήνα-Πειραιάς</option>
                                        <option>Θεσσαλονίκη</option>
                                        <option>Χανιά</option>
                                        <option>Βόλος</option>
                                        <option>Λάρισα</option>
                                        <option>Πάτρα</option>
                                        <option>Ηράκλειο</option>
                                        </select>
                                    </span></td>
                                </tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Όνομα:</b></td>
                                        <td  valign="top"><input name="firstname" class="form" size="50" maxlength="30" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getFirstname()!=null){%><%=custInfoBean.getFirstname()%><%}}%>"></td>
                                        <td><span id="name_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="name_error2" class="error" style="display:none; color:red">To όνομα μπορεί να περιέχει μόνο γράμματα.</span></td>
                                </tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Επώνυμο:</b></td>
                                        <td  valign="top"><input name="lastname" class="form" size="50" maxlength="30" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getLastname()!=null){%><%=custInfoBean.getLastname()%><%}}%>"></td>
                                        <td><span id="surname_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="surname_error2" class="error" style="display:none; color:red">To επώνυμο μπορεί να περιέχει μόνο γράμματα.</span></td>
                                </tr>
                                <tr>
                                    <td  valign="top" style="background-color:#e0e6ed"><b>*Εmail:</b></td>
                                    <td  valign="top"><input name="email" class="form" size="50" type="text" value="<%if(custInfoBean!=null){  if (custInfoBean.getEmail()!=null){%><%=custInfoBean.getEmail()%><%}}%>"></td>
                                    <td>
                                    <%
                                          if(custInfoBean!=null){ if (custInfoBean.getExistEmail()) { %>
                                             <span class="error" id="email_error4" style="display:inline; color:red">Αυτό το email χρησιμοποιείται ήδη. Παρακαλώ επιλέξτε κάποιο άλλο.</span><%}}%>

                                        <span id="email_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="email_error2" class="error" style="display:none; color:red">To email δεν μπορεί να περιέχει ειδικούς χαρακτήρες.</span>
                                        <span id="email_error3" class="error" style="display:none; color:red">To email που δώσατε δεν είναι έγκυρο.</span></td>
                                </tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Διεύθυνση:</b></td>
                                        <td  valign="top"><input name="street" class="form" size="50" maxlength="50" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getAddress()!=null){%><%=custInfoBean.getAddress()%><%}}%>"></td>
                                        <td><span id="address_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="address_error2" class="error" style="display:none; color:red">H διεύθυνση μπορεί να περιέχει μόνο γράμματα και αριθμούς.</span></td>
                                </tr>

                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Πόλη:</b></td>
                                        <td  valign="top"><input name="city" class="form" size="50"  maxlength="20" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getCity()!=null){%><%=custInfoBean.getCity()%><%}}%>"></td>
                                        <td><span id="city_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="city_error2" class="error" style="display:none; color:red">To όνομα της πόλης μπορεί να περιέχει μόνο γράμματα.</span></td>
                                </tr>

                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*ΤΚ:</b></td>
                                        <td  valign="top"><input name="zip" class="form" size="12" maxlength="10" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getPostalCode()!=null){%><%=custInfoBean.getPostalCode()%><%}}%>"></td>
                                        <td><span id="zip_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="zip_error2" class="error" style="display:none; color:red">O T.K. μπορεί να περιέχει μόνο αριθμούς.</span></td>
                                </tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Σταθερό Τηλέφωνο:</b></td>
                                        <td  valign="top"><input name="phone" class="form" size="12" maxlength="15" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getPhone()!=null){%><%=custInfoBean.getPhone()%><%}}%>"></td>
                                        <td><span id="phone_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Aν δεν έχετε σταθερό τηλέφωνο πληκτρολογείστε το 0.</span>
                                        <span id="phone_error2" class="error" style="display:none; color:red">To τηλέφωνο που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                        <span id="phone_error3" class="error" style="display:none; color:red">Τα ψηφία του τηλεφώνου πρέπει να είναι 10.Βεβαιωθείτε ότι εισάγατε τον κωδικό περιοχής.</span></td>
                                </tr>
                                <tr><td  valign="top" style="background-color:#e0e6ed"><b>*Κινητό Τηλέφωνο:</b></td>
                                        <td  valign="top"><input name="mobile" size="12" maxlength="15" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getMobilePhone()!=null){%><%=custInfoBean.getMobilePhone()%><%}}%>"></td>
                                        <td><span id="mobphone_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                        <span id="mobphone_error2" class="error" style="display:none; color:red">To τηλέφωνο που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                        <span id="mobphone_error3" class="error" style="display:none; color:red">Τα ψηφία του τηλεφώνου πρέπει να είναι 10.</span>
                                        <span id="mobphone_error4" class="error" style="display:none; color:red">To τηλέφωνο πρέπει να είναι της μορφής 69xxxxxxxx.</span></td>
                                </tr>
                                <tr><td>&nbsp;<td></tr>
                                <tr><td><input value="Aκύρωση" type="button" onclick="location.href='Controller?action=shoppingCartPage&ov=1';" class="gray_button">
                                <td>&nbsp;</td><td><input value="Aποστολή Παραγγελίας" type="submit" class="green_button"></td></tr>
			</table>
                </form>
	</div>
        <%@include file="footer.jsp" %>
    </div>
</body>
</html>