<%-- 
    Document   : ShowAllOrdersView
    Created on : 6 Φεβ 2010, 7:40:12 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.OrderInfoBean"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Επισκόπηση Παραγγελιών</title>
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<%Vector listOfOrders=(Vector)request.getAttribute("model"); %>

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
                <td valign="top" class=""><a href="Controller?action=showReviewOrdersPage">Αναζήτηση Παραγγελιών</a></td>
                <td valign="top" class="current"><a href="#">Eπισκόπηση Παραγγελιών</a></td>
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
				<td class="blueheader"> <b>Eπισκόπηση Παραγγελιών</b></td>
			</tr>
		</table>

                <form name="changeOrders" method="post" action="Controller?action=showChangeOrdersPage" >
		<table class="bigger" width="100%" border="0" cellpadding="0" cellspacing="8" align="center">
					<tr><td><b>Tαξινόμηση με βάση:</b></td>
						<td><select>
						<option>Hμερομηνία: παλαιότερη-> νεότερη</option>
						<option>Τιμή: ακριβότερη->φθηνότερη</option>
						<option>Τιμή: φθηνότερη->ακριβότερη</option>
						</select></td>
						<td><b>Aποτελέσματα ανά σελίδα:</b></td>
						<td><select>
						<option>10</option>
						<option>15</option>
						<option>20</option>
						</select></td></tr>
		</table>
                <table class="bigger" cellspacing="3" cellpadding="3">
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td style="font-size:14px;"><b> Βρέθηκαν <%=listOfOrders.size()%> αποτελέσματα.</b></td>
                    </tr>
		</table>
                <%if(listOfOrders.size()!=0){%>
		<table class="biggerWithBorder" cellspacing="0" cellpadding="6">
			<tr>
				<td class="gray">&nbsp;</td>
				<td class="gray" align="center"><b>Κωδικός παραγγελίας</b></td>
				<td class="gray" align="center"><b>Hμερομηνία παραγγελίας</b></td>
				<td class="gray" align="center"><b>Συνολικό κόστος</b></td>
				<td class="gray" align="center"><b>Κατάσταση παραγγελίας</b></td>
			</tr>

                        <% for(int i=0;i<listOfOrders.size();i++){
                            OrderInfoBean ord=(OrderInfoBean)listOfOrders.get(i);%>
			<tr>
				<td><input name="check" value="<%=ord.getOrderId()%>" type="checkbox"></td>
				<td align="center"><a href="Controller?action=showSpecificOrderPage&oid=<%=ord.getOrderId()%>"><span style="color:blue"><%=ord.getOrderId()%></span></a></td>
				 <% Date date=ord.getDate();
                                   DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");%>
				<td align="center"><%=dateFormat.format(date)%></td>
				<td align="center"><%=ord.getTotal_price()%> €</td>
				<td align="center"><span <%if (ord.getStatus().equals("Εστάλη") || ord.getStatus().equals("Ακυρωμένη") || ord.getStatus().equals("Παραλήφθηκε") ){%>style="color:red"<%}else{%>style="color:#00EC76"<%}%>  ><%=ord.getStatus()%></span></td>
			</tr>
			<%}%>			
		</table>

		<table class="bigger" cellspacing="0" cellpadding="6">
			<tr><td width="370px"><b>Mεταβολή κατάστασης προεπιλεγμένων παραγγελιών σε:</b></td>
                            <td align="left"><select name="changeStatus">
                                <option value="Προς Πακετάρισμα">Προς Πακετάρισμα...</option>
                                <option value="Προς Τιμολόγηση">Προς Τιμολόγηση...</option>
                                <option value="Εστάλη">Εστάλη</option>
                                <option value="Παραλήφθηκε">Παραλήφθηκε</option>
                                <option value="Ακυρωμένη">Ακυρωμένη</option>
                                <option value="Προς Διαγραφή">Προς Διαγραφή</option>
				</select></td></tr>
				<tr><td></td></tr>
                                <tr><td></td></tr>
                                <tr><td></td></tr>
                                <tr><td colspan="2" align="right"><input value="Ενημέρωση παραγγελιών" onclick="var answer=confirmChangeOrdersOption(); if(answer) javascript:document.changeOrders.submit();" type="button" class="green_button"></td></tr>
		</table>
                <%}%>
                </form>

	</div>
        <%@include file="footer.jsp" %>
</div>

</body>

</html>