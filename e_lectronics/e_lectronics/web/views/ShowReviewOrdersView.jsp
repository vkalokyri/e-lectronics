<%-- 
    Document   : ShowAllOrdersView
    Created on : 6 Φεβ 2010, 7:02:03 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επισκόπηση Παραγγελιών</title>
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
                <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
                <td valign="top" class="current"><a href="#">Αναζήτηση Παραγγελιών</a></td>
            </tr>
        </table>

        <%@include file="LeftMenu.jsp" %>        
        <div id=RightMenu>
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp"%>
        </div>

	<div id="main_menu">	
		<table class="bigger" cellspacing="3" cellpadding="3">
			<tr>
				<td class="blueheader"> <b>Αναζήτηση Παραγγελιών</b></td>
			</tr>
		</table>

                <form name="showOrders" action="Controller?action=showAllOrdersPage" method="post">
		<table class="biggerWithBorder" width="100%" border="0" cellpadding="0" cellspacing="8" align="center">
					<tr><td class="gray" colspan="2"><b>Aναζήτηση Παραγγελιών</b></td></tr>
					<tr><td><b>Κατάσταση παραγγελίας</b></td></tr>
					<tr><td>
                                            <select name="orderStatus" >
                                                <option value="6" selected="selected">Όλες οι καταστάσεις</option>
                                                <option value="0">Εκκρεμής</option>
                                                <option value="1">Προς Πακετάρισμα</option>
                                                <option value="2">Προς Τιμολόγηση</option>
                                                <option value="3">Εστάλη</option>
                                                <option value="4">Παραλήφθηκε</option>
                                                <option value="5">Ακυρωμένη</option>
                                            </select>
                                        </td></tr>
					<tr><td><b>Ημερομηνία πραγματοποίησης παραγγελίας</b></td></tr>
					<tr><td colspan="2">Eμφάνιση παραγγελιών από τις <input type="text" name="startDay" size="2">/<input type="text" name="startMonth" size="2">/<input type="text" name="startYear" size="4"> έως <input type="text" size="2" name="endDay">/<input type="text" name="endMonth" size="2">/<input type="text" name="endYear" size="4"></td></tr>
					<tr><td><b>Τρόπος αποστολής παραγγελίας</b></td>
					<tr><td>
                                            <select name="dispatch">
                                                <option value="0">Διανομή</option>
                                                <option value="1">Παραλαβή από κατάστημα</option>
                                                <option value="2" selected="selected">Όλοι οι τρόποι</option>
                                            </select>
					</td></tr>
					<tr><td><b>Τρόπος πληρωμής παραγγελίας</b></td></tr>
					<tr><td>
                                            <select name="payment">
                                                <option value="1">Αντικαταβολή</option>
                                                <option value="0">Πιστωτική κάρτα</option>
                                                <option value="2" selected="selected">Όλοι οι τρόποι</option>
                                            </select>
					</td></tr>
					<tr><td></td></tr>
					<tr><td align="left"><input value="Αναζήτηση"  type="submit" class="blue_button" style="font-weight:bold;" ></td></tr>
                    </table>
                    <table class="biggerWithBorder" width="100%" border="0" cellpadding="0" cellspacing="8" align="center">
                        <tr><td class="gray" colspan="2"><b>Aναζήτηση Συγκεκριμένης Παραγγελίας</b></td></tr>
                        <tr><td><b>Κωδικός παραγγελίας</b></td><td><input type="text" name="order_id" size="30"></tr>
                        <tr><td><b>Κωδικός πελάτη</b></td><td><input type="text" name="customer_id" size="30"></td></tr>
                        <tr><td><b>Eπώνυμο πελάτη</b></td><td><input type="text" name="lastname" size="30"></td></tr>
                        <tr><td></td></tr>
                        <tr><td align="left"><input value="Αναζήτηση" type="submit" class="blue_button" style="font-weight:bold;" ></td></tr>
                    </table>
                </form>
	</div>
    <%@include file="footer.jsp" %>
</div>

</body>

</html>