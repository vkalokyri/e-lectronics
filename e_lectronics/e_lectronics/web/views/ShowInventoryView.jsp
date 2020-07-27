<%-- 
    Document   : ShowInventoryView
    Created on : 16 Φεβ 2010, 8:34:09 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Έλεγχος αποθέματος</title>
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
                <td valign="top" class="current"><a href="#">Έλεγχος Αποθέματος</a></td>
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
				<td class="blueheader"> <b>Έλεγχος Αποθέματος</b></td>
			</tr>
		</table>

                <form name="showOrders" action="Controller?action=showShortagePage" method="post">
		<table class="biggerWithBorder" width="100%" cellpadding="0" cellspacing="10" align="center">
					
                        <tr><td><b>Που ανήκουν στην κατηγορία :</b></td></tr>
                        <tr><td>
                                <select id="category"  name="category">
                                    <option value="all" selected="selected" onclick="checkChangedInventoryCat()">Όλες οι κατηγορίες</option>
                                <%for(int i=0;i<listOfCategories.size();i++){
                                    String name=((CategoryInfoBean)listOfCategories.get(i)).getName();%>
                                    <option id="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" value="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>"  onclick="checkChangedInventoryCat()"><%=name%></option>
                                <%}%>
                                </select>
                          </td>
                        </tr>
                        <tr>
                            <td> <b>Που ανήκουν στην υποκατηγορία : </b></td>
                        </tr>
                        <tr><td width="30px">
                                <select id="emptyScroll" disabled="disabled" style="display:inline">
                                    <option>Όλες οι υποκατηγορίες</option>
                                </select>
                                <%for(int i=0;i<listOfCategories.size();i++){%>
                                    <select id="subcateg_<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" style="display:none" name="subcateg<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" >
                                        <option value="all" selected="selected">Όλες οι υποκατηγορίες</option>
                                    <%for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
                                        String name=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName();
                                        int sqlid  =((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID(); %>
                                        <option id="<%=sqlid%>" value="<%=sqlid%>" ><%=name%></option>
                                    <%}%>
                                </select>
                                <%}%>
                            </td>
                        </tr>
                        <tr><td><b>Ποσότητα Αποθέματος προϊόντων</b></td></tr>
                        <tr><td colspan="2">Eμφάνιση προϊόντων με ποσότητα αποθέματος από: <input type="text" name="startThres" size="2"> έως <input type="text" size="2" name="endThres"> τεμάχια.</td></tr>
                        <tr><td align="left"><input value="Αναζήτηση"  type="submit" class="blue_button" style="font-weight:bold;" ></td></tr>
                    </table>                    
                </form>
	</div>
        <%@include file="footer.jsp" %>
</div>

</body>

</html>