

<%--
    Document   : ShowChangeProductView
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
<title>Αλλαγή προϊόντος</title>
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
                <td valign="top" class="current"><a href="#">Aλλαγή προϊόντος</a></td>
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
				<td class="blueheader"> <b>Αλλαγή Χαρακτηριστικών Προϊόντος</b></td>
			</tr>

		</table>

                <form name="changeProduct" action="Controller?action=showChangeProductPage" method="post" onsubmit="return validateNumber(sn)">
                    <table class="biggerWithBorder" cellspacing="3" cellpadding="8">
                            <tr><td class="gray" colspan="3"><b>Aναζήτηση προϊόντος</b></td></tr>
                            <tr id="nbr_error" style="display:none"><td colspan="3"><span  class="error" style="color:red">Μη έγκυροι χαρακτήρες.</span></td></tr>
                            <tr><td><b>Κωδικός προϊόντος</b></td><td><input name="sn" type="text" size="30"></td>
                            <td align="left"><input value="Αναζήτηση" type="submit" class="blue_button" style="font-weight:bold;" ></td></tr>
                    </table>
                </form>
                <form name="changeProduct" action="Controller?action=showConfirmChangeProductPage" method="post" onsubmit="return validateOnInsertProduct(this)">
                    <%if(prod!=null){
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
                                    <td><input disabled="true" style="background-color:white" name="sn" type="text" value="<%=prod.getSerialNumber()%>" size="38" ></td>
                                    <td><span id="sn_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span>
                                        <span id="sn_error2" class="error" style="display:none; color:red">Μη έγκυροι χαρακτήρες. Εισάγετε αριθμό.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Κατασκευαστής </b></td>
                                    <td><input name="manufact" value="<%=prod.getManufacturer()%>" type="text" size="38" ></td>
                                    <td><span id="manufact_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Μοντέλο  </b></td>
                                    <td><input name="model" value="<%=prod.getModel()%>" type="text" size="38" ></td>
                                    <td><span id="model_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Τιμή (€)</b></td>
                                    <td><input name="price" value="<%=prod.getPrice()%>" type="text" size="38" ></td>
                                    <td><span id="price_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span>
                                    <span id="price_error2" class="error" style="display:none; color:red">Μη έγκυρη τιμή. π.χ.19.38</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Εγγύηση  </b></td>
                                    <td><input name="warranty" value="<%=prod.getWarranty()%>" type="text" size="38" ></td>
                                    <td><span id="warranty_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray"> <b>Ποσότητα Αποθέματος  </b></td>
                                    <td><input name="stock" value="<%=prod.getStock()%>" type="text" size="38" ></td>
                                    <td><span id="stock_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray" valign="top"> <b>Url Εικόνας  </b></td>
                                    <td><input name="image"  value="<%=prod.getImageUrl()%>" type="text" size="38" ></td>
                                    <td><span id="image_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray" valign="top"> <b>Όριο ποσότητας αποθέματος  </b></td>
                                    <td><input name="thres" type="text" value="<%=prod.getThreshold()%>" size="38" ></td>
                                    <td><span id="thres_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span>
                                    <span id="thres_error2" class="error" style="display:none; color:red">Μη έγκυροι χαρακτήρες. Εισάγετε αριθμό.</span></td>
                            </tr>
                            <tr>
                                    <td class="lightgray" valign="top"> <b>Περιγραφή  </b></td>
                                    <td><textarea name="descript" rows="10" cols="38" class="text"><%=prod.getDescription()%></textarea> </td>
                                    <td><span id="descript_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                            </tr>
                                <%for(int i=0;i<prod.getCharacteristics().getListOfCharacteristics().size();i++){ %>

                                <tr>
                                        <td class="lightgray"><%= ((CharacteristicsInfoBean)prod.getCharacteristics().getListOfCharacteristics().get(i)).getName()%></td>
                                        <%if (((ValueInfoBean)prod.getCharacteristics().getValues().getListOfValues().get(i)).getName()!=null){%>
                                        <td><input name="characteristic<%=i%>" type="text" value="<%= ((ValueInfoBean)prod.getCharacteristics().getValues().getListOfValues().get(i)).getName()%>" size="38" ></td>
                                        <%}else{%>
                                            <td><input name="" type="text" value="-" size="38" ></td>
                                        <%}%>
                                </tr>                                
                             <%}%>
                             <tr>
                        <td class="lightgray" width="20%"> <b>Kατηγορία </b></td>
                        <td> <select id="category"  name="category">
                            <%for(int i=0;i<listOfCategories.size();i++){
                                String name=((CategoryInfoBean)listOfCategories.get(i)).getName();%>
                                <option <%if(((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()==prod.getCategoryID()){%> selected="selected" <%}%> value="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>"  onclick="checkChangedCat()"><%=name%></option>
                            <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="lightgray" width="20%"> <b>Yποκατηγορία  </b></td>
                        <td width="30px">
                        <%for(int i=0;i<listOfCategories.size();i++){ %>
                            <select id="subcateg_<%=i%>" <%if(((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()==prod.getCategoryID()){%> style="display:inline" <%}else{%>style="display:none"<%}%> name="subcateg<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" >
                            <%for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
                                String name=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName();
                                int sqlid  =((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID(); %>
                                <option <%if(sqlid==prod.getSubcategoryID()){%> selected="selected" <%}%> id="<%=sqlid%>" value="<%=sqlid%>" ><%=name%></option>
                            <%}%>
                        </select>
                        <%}%>
                        </td>
                    </tr>
                    <tr>
                            <td class="lightgray" valign="top"> <b>Μή συμβατότητα : </b></td>

                           <td colspan="2">
                            <div style="overflow-x:scroll; width:380px; overflow: -moz-scrollbars-horizontal;">
                                <select name="products" multiple="multiple" size="10" id="products" >
                                    <%for(int j=0;j<prod.getListOfProducts().size();j++){
                                        int found=0;
                                        ProductInfoBean product=(ProductInfoBean)prod.getListOfProducts().get(j);%>
                                        <%for(int k=0;k<prod.getListOfIncompatibleProducts().size();k++){
                                            if(((ProductInfoBean)prod.getListOfIncompatibleProducts().get(k)).getSerialNumber()==product.getSerialNumber()){
                                                    found=1;
                                                    break;
                                            }}%>
                                        <%if(found!=1){%>
                                        <option  value="<%=product.getSerialNumber()%>" id="<%=product.getSerialNumber()%>-><%=product.getModel()%>"><%=product.getSerialNumber()%>-><%=product.getModel()%>  </option>
                                    <%}}%>
                                </select>
                            </div>
                         </td>
                        </tr>
                        <tr><td class="lightgray"></td>
                            <td align="center">Προσθήκη<input value="+" type="button" onclick="addIncompatibleProduct()">&nbsp;&nbsp; <input value="-" onclick="delIncompatibleProduct()" type="button">Αφαίρεση</td>

                        </tr>
                        <tr>
                            <td class="lightgray"></td>
                            <td>
                                <div style="overflow-x:scroll; width:380px; overflow: -moz-scrollbars-horizontal;">
                                    <select  name="incompatible" multiple="multiple" id="incompatible" size="10" >
                                    <%for(int j=0;j<prod.getListOfIncompatibleProducts().size();j++){
                                        ProductInfoBean product=(ProductInfoBean)prod.getListOfIncompatibleProducts().get(j);%>
                                        <option style="color:blue"  value="<%=product.getSerialNumber()%>" label="<%=product.getSerialNumber()%>-><%=product.getModel()%>"><%=product.getSerialNumber()%>-><%=product.getModel()%>  </option>
                                    <%}%>
                                    </select>
                            </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lightgray" valign="top"> <b>Μέγιστη απόδοση : </b></td>

                           <td colspan="2">
                            <div style="overflow-x:scroll; width:380px; overflow: -moz-scrollbars-horizontal;">
                                <select name="maxProducts" multiple="multiple" size="10" id="maxProducts" >
                                    <%for(int j=0;j<prod.getListOfProducts().size();j++){
                                        int found=0;
                                        ProductInfoBean product=(ProductInfoBean)prod.getListOfProducts().get(j);%>
                                        <%for(int k=0;k<prod.getListOfMaxPerformanceProducts().size();k++){
                                            if(((ProductInfoBean)prod.getListOfMaxPerformanceProducts().get(k)).getSerialNumber()==product.getSerialNumber()){
                                                    found=1;
                                                    break;
                                            }}%>
                                        <%if(found!=1){%>
                                        <option  value="<%=product.getSerialNumber()%>" id="max_<%=product.getSerialNumber()%>-><%=product.getModel()%>"><%=product.getSerialNumber()%>-><%=product.getModel()%>  </option>
                                    <%}}%>
                                </select>
                            </div>
                         </td>
                        </tr>
                        <tr><td class="lightgray"></td>
                            <td align="center">Προσθήκη<input value="+" type="button" onclick="addMaxPerformanceProduct()">&nbsp;&nbsp; <input value="-" onclick="delMaxPerformanceProduct()" type="button">Αφαίρεση</td>

                        </tr>
                        <tr>
                            <td class="lightgray"></td>
                            <td>
                                <div style="overflow-x:scroll; width:380px; overflow: -moz-scrollbars-horizontal;">
                                    <select name="maxPerform" multiple="multiple" id="maxPerform" size="10" >
                                    <%for(int j=0;j<prod.getListOfMaxPerformanceProducts().size();j++){
                                        ProductInfoBean product=(ProductInfoBean)prod.getListOfMaxPerformanceProducts().get(j);%>
                                        <option style="color:blue"  value="<%=product.getSerialNumber()%>" label="<%=product.getSerialNumber()%>-><%=product.getModel()%>"><%=product.getSerialNumber()%>-><%=product.getModel()%>  </option>
                                    <%}%>
                                    </select>
                            </div>
                            </td>
                        </tr>
                  </table>                    
                        <table class="bigger" cellspacing="3" cellpadding="3">
                            <tr>                                
                                <td align="right"><input value="Eνημέρωση αλλαγών" onclick="sendAttributes()" type="submit" class="green_button"></td>
                            </tr>
                        </table>
                    <%}else{%>
                        <table class="bigger" cellspacing="3" cellpadding="3">
                                <tr><td>&nbsp;</td></tr>
                                <tr><th style="font-size:15px">Δεν υπάρχει προϊόν με αυτό τον κωδικό.</th></tr>
                        </table>
                    <%}}%>
               </form>
	</div>
<%@include file="footer.jsp" %>
</div>

</body>

</html>