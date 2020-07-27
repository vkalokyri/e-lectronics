<%-- 
    Document   : ShowProfileView
    Created on : 30 Ιαν 2010, 7:10:22 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CustomerInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>To προφίλ μου</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="validate_form.js"></script>
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
                <td valign="top" class=""><a href="Controller?action=myAccountPage">Ο λογαριασμός μου</a></td>
                <td valign="top" class="current"><a href="#">Το προφίλ μου</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
        </div>

	<div id="main_menu">
		<table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td colspan="2" align="center" class="header"><b>Προσωπικό προφίλ</b></td></tr>
		</table>

		<form name ="profile"  method="Post"  action="Controller?action=showConfirmChangesPage" onsubmit="return validateForm(this)"  >
			<table class="biggerWithBorder" cellpadding="0" cellspacing="3" >
                                        <% CustomerInfoBean custInfoBean;
                                           if(cust!=null){
                                            custInfoBean=cust;
                                        }else{
                                            custInfoBean = (CustomerInfoBean)session.getAttribute("CustomerInfo");}%>
					<tr><td  colspan="3" valign="top" class="tdgray">Για αλλαγή κωδικού πρόσβασης συμπληρώστε τα πεδία</td></tr>
					<tr>
						<td  valign="top" style="background-color:#e0e6ed"><b>Κωδικός πρόσβασης:</b></td>
						<td  valign="top"><input name="password" class="form" size="50" maxlength="50" type="password" </td>
                                                <td><span id="pass_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="pass_error2" class="error" style="display:none; color:red">O κωδικός πρόσβασης μπορεί να περιέχει μόνο γράμματα,αριθμούς και το τελεστή _. </span>
                                                </td>
					</tr>
					<tr>
						<td  valign="top" style="background-color:#e0e6ed"><b>Επιβεβαίωση κωδικού πρόσβασης:</b></td>
						<td  valign="top"><input name="confirm_pass" class="form" size="50" maxlength="50" type="password" ></td>
                                                <td><span id="conf_pass_error" class="error" style="display:none; color:red">H επιβεβαίωση του κωδικού πρόσβασης πρέπει να είναι ίδια με τον κωδικό πρόσβασης.</span></td>
					</tr>
                                        <tr><td colspan="3" align="center" class="tdgray"></td></tr>
                                        <tr style="background-color:#e0e6ed">
						<td colspan="3" valign="bottom" >
							<ul>
								<li>Μπορείτε να αλλάξετε τις παρακάτω τιμές των πεδίων του προφίλ σας, αλλά σας υπενθυμίζουμε ότι κανένα από τα παρακάτω πεδία δεν μπορεί να είναι κενό.</li>
							</ul>
						</td>
					</tr>
                                        <tr><td colspan="3" align="center" class="tdgray">Επεξεργασία προσωπικού προφίλ</td></tr>
					<tr>
						<td  valign="top" style="background-color:#e0e6ed"><b>Εmail:</b></td>
						<td  valign="top"><input name="email" class="form" size="50" type="text" value="<%if(custInfoBean!=null){  if (custInfoBean.getEmail()!=null){%><%=custInfoBean.getEmail()%><%}}%>"></td>
                                                <td>
                                                <%
                                                      if(custInfoBean!=null){ if (custInfoBean.getExistEmail()) { %>
                                                         <span class="error" id="email_error4" style="display:inline; color:red">Αυτό το email χρησιμοποιείται ήδη. Παρακαλώ επιλέξτε κάποιο άλλο.</span><%}}%>

                                                    <span id="email_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                    <span id="email_error2" class="error" style="display:none; color:red">To email δεν μπορεί να περιέχει ειδικούς χαρακτήρες.</span>
                                                    <span id="email_error3" class="error" style="display:none; color:red">To email που δώσατε δεν είναι έγκυρο.</span></td>
					</tr>
					<tr><td  valign="top" style="background-color:#e0e6ed"><b>Όνομα:</b></td>
						<td  valign="top"><input name="firstname" class="form" size="50" maxlength="30" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getFirstname()!=null){%><%=custInfoBean.getFirstname()%><%}}%>"></td>
                                                <td><span id="name_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="name_error2" class="error" style="display:none; color:red">To όνομα μπορεί να περιέχει μόνο γράμματα.</span></td>
                                        </tr>
					<tr><td  valign="top" style="background-color:#e0e6ed"><b>Επώνυμο:</b></td>
						<td  valign="top"><input name="lastname" class="form" size="50" maxlength="30" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getLastname()!=null){%><%=custInfoBean.getLastname()%><%}}%>"></td>
                                                <td><span id="surname_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="surname_error2" class="error" style="display:none; color:red">To επώνυμο μπορεί να περιέχει μόνο γράμματα.</span></td>
                                        </tr>
					<tr><td  valign="top" style="background-color:#e0e6ed"><b>Διεύθυνση:</b></td>
						<td  valign="top"><input name="street" class="form" size="50" maxlength="50" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getAddress()!=null){%><%=custInfoBean.getAddress()%><%}}%>"></td>
                                                <td><span id="address_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="address_error2" class="error" style="display:none; color:red">H διεύθυνση μπορεί να περιέχει μόνο γράμματα και αριθμούς.</span></td>
                                        </tr>

					<tr><td  valign="top" style="background-color:#e0e6ed"><b>Πόλη:</b></td>
						<td  valign="top"><input name="city" class="form" size="50"  maxlength="20" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getCity()!=null){%><%=custInfoBean.getCity()%><%}}%>"></td>
                                                <td><span id="city_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="city_error2" class="error" style="display:none; color:red">To όνομα της πόλης μπορεί να περιέχει μόνο γράμματα.</span></td>
                                        </tr>

					<tr><td  valign="top" style="background-color:#e0e6ed"><b>ΤΚ:</b></td>
						<td  valign="top"><input name="zip" class="form" size="12" maxlength="10" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getPostalCode()!=null){%><%=custInfoBean.getPostalCode()%><%}}%>"></td>
                                                <td><span id="zip_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="zip_error2" class="error" style="display:none; color:red">O T.K. μπορεί να περιέχει μόνο αριθμούς.</span></td>
                                        </tr>
					<tr><td  valign="top" style="background-color:#e0e6ed"><b>Σταθερό Τηλέφωνο:</b></td>
						<td  valign="top"><input name="phone" class="form" size="12" maxlength="15" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getPhone()!=null){%><%=custInfoBean.getPhone()%><%}}%>"></td>
                                                <td><span id="phone_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Aν δεν έχετε σταθερό τηλέφωνο πληκτρολογείστε το 0.</span>
                                                <span id="phone_error2" class="error" style="display:none; color:red">To τηλέφωνο που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                                <span id="phone_error3" class="error" style="display:none; color:red">Τα ψηφία του τηλεφώνου πρέπει να είναι 10.Βεβαιωθείτε ότι εισάγατε τον κωδικό περιοχής.</span></td>
					</tr>
					<tr><td  valign="top" style="background-color:#e0e6ed"><b>Κινητό Τηλέφωνο:</b></td>
						<td  valign="top"><input name="mobile" size="12" maxlength="15" type="text" value="<%if(custInfoBean!=null){ if (custInfoBean.getMobilePhone()!=null){%><%=custInfoBean.getMobilePhone()%><%}}%>"></td>
                                                <td><span id="mobphone_error1" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.Δεν μπορεί να είναι κενό.</span>
                                                <span id="mobphone_error2" class="error" style="display:none; color:red">To τηλέφωνο που εισάγατε περιέχει μη έγκυρους χαρακτήρες.</span>
                                                <span id="mobphone_error3" class="error" style="display:none; color:red">Τα ψηφία του τηλεφώνου πρέπει να είναι 10.</span>
                                                <span id="mobphone_error4" class="error" style="display:none; color:red">To τηλέφωνο πρέπει να είναι της μορφής 69xxxxxxxx.</span></td>
                                        </tr>
                                        <tr><td colspan="3" align="center" class="tdgray"></td></tr>
					<tr><td colspan="4">&nbsp;</td></tr>
					<tr><td colspan="4">&nbsp;</td></tr>
					<tr>
                                            <td colspan="2" align="left"><input value="Ακύρωση" type="button" onclick="location.href='Controller?action=loadFirstPage'" class="gray_button"></td>
						<td align="center"><input  type="submit" value="Eφαρμογή αλλαγών" class="green_button"></td>
					</tr>
		</table>
		</form>
	</div>
        <%@include file="footer.jsp" %>
</div>

</body>
</html>