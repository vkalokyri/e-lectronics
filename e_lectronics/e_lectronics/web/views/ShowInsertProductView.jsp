<%-- 
    Document   : ShowInsertProductView
    Created on : 7 Φεβ 2010, 4:06:14 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="model.CharacteristicsInfoBean"%>
<%@page import="model.ProductInfoBean"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="author" content="styledmenus.com" />
    <title>Εισαγωγή προϊόντος</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<body onload="onloadSetOptions()">
    
    <%Vector AllCharacteristicsAndProducts=(Vector)request.getAttribute("model");%>
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
                <td valign="top" class="current"><a href="#">Εισαγωγή προϊόντος</a></td>
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
                        <td class="blueheader"> <b>Eισαγωγή Προϊόντος</b></td>
                    </tr>
            </table>

            <form action="Controller?action=showConfirmInsertProductPage" method="POST" name="checkInsertForm" onsubmit="return validateOnInsertProduct(this)" >
		<table class="bigger" cellspacing="3" cellpadding="3">
                    <tr>
			
			<td style="font-size:12px"> <b>Εισαγωγή προϊόντος σε υπάρχουσα κατηγορία/υποκατηγορία </b> </td>
                    </tr>
		</table>                
		<table class="biggerWithBorder" cellspacing="3" cellpadding="3" >
                    <tr>
                        <td class="lightgray" width="20%"> <b>Kατηγορία :</b></td>
                        <td> <select  name="category" >
                            <%for(int i=0;i<listOfCategories.size();i++){
                                String name=((CategoryInfoBean)listOfCategories.get(i)).getName();
                                %>
                                <option value="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" onclick="checkChangedCateg('<%=listOfCategories.size()%>'); checkChangedSubcateg('<%=((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size()%>','<%=((Vector)AllCharacteristicsAndProducts.get(0)).size()%>')"><%=name%></option>
                            <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="lightgray" width="20%"> <b>Yποκατηγορία : </b></td>
                        <td width="30px">
                        <%for(int i=0;i<listOfCategories.size();i++){
                            String s;
                            if(i==0){
                                s="inline";
                            }else{ s="none";}%>
                            <select id="subcateg_<%=i%>" style="display:<%=s%>" name="subcateg<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" >
                            <%for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
                                String name=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName();
                                int sqlid  =((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID(); %>
                                <option id="<%=sqlid%>" value="<%=sqlid%>" onclick="checkChangedSubcateg('<%=((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size()%>','<%=((Vector)AllCharacteristicsAndProducts.get(0)).size()%>')"><%=name%></option>
                            <%}%>
                        </select>
                        <%}%>
                        </td>
                    </tr>
                </table>
                <div id="check0_options" style="display:none">
                    <table class="bigger" cellspacing="3" cellpadding="3" >
                        <tr>
                            <td class="greendark"> <b>Xαρακτηριστικά προϊόντος</b></td>
                        </tr>
                    </table>
                    <table class="biggerWithBorder" cellspacing="3" cellpadding="3">
                    <tr>
                            <td class="lightgray"> <b>Κωδικός προϊόντος : </b></td>
                            <td><input name="sn" type="text" size="30" ></td>
                            <td><span id="sn_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span>
                            <span id="sn_error2" class="error" style="display:none; color:red">Μη έγκυροι χαρακτήρες.Εισάγετε αριθμό.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray"> <b>Κατασκευαστής </b></td>
                            <td><input name="manufact" type="text" size="30" ></td>
                            <td><span id="manufact_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray"> <b>Μοντέλο : </b></td>
                            <td><input name="model" type="text" size="30" ></td>
                            <td><span id="model_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray"> <b>Τιμή : </b></td>
                            <td><input name="price" type="text" size="30" ></td>
                            <td><span id="price_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span>
                            <span id="price_error2" class="error" style="display:none; color:red">Mή έγκυροι χαρακτήρες.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray"> <b>Εγγύηση : </b></td>
                            <td><input name="warranty" type="text" size="30" ></td>
                            <td><span id="warranty_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray"> <b>Ποσότητα Αποθέματος : </b></td>
                            <td><input name="stock" type="text" size="30" ></td>
                            <td><span id="stock_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray" valign="top"> <b>Url Εικόνας : </b></td>
                            <td><input name="image" type="text" size="30" ></td>
                            <td><span id="image_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray" valign="top"> <b>Όριο ποσότητας αποθέματος : </b></td>
                            <td><input name="thres" type="text" size="30" ></td>
                            <td><span id="thres_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span>
                            <span id="thres_error2" class="error" style="display:none; color:red">Μη έγκυροι χαρακτήρες.Εισάγετε αριθμό.</span></td>
                    </tr>
                    <tr>
                            <td class="lightgray" valign="top"> <b>Περιγραφή : </b></td>
                            <td><textarea name="descript" rows="10" cols="38" class="text"></textarea> </td>
                            <td><span id="descript_error" class="error" style="display:none; color:red">Υποχρεωτικό πεδίο.</span></td>
                    </tr>
                                
                         <%for(int i=0;i<((Vector)AllCharacteristicsAndProducts.get(0)).size();i++){
                            String s;
                            String s2;
                            if(i==0){
                                s="table-row";
                            }else{ s="none";};
                            for(int j=0;j<((Vector)((Vector)AllCharacteristicsAndProducts.get(0)).get(i)).size();j++){
                                CharacteristicsInfoBean charact=((CharacteristicsInfoBean)((Vector)((Vector)AllCharacteristicsAndProducts.get(0)).get(i)).get(j));%>
                                <tr id="characteristic_<%=charact.getSubcategId()%>_<%=j%>"  style="display:<%=s%>">
                                    <td valign="top" class="lightgray"> <b><%=charact.getName()%> :</b></td>
                                    <td><input type="text" name="characteristic_<%=charact.getSubcategId()%>_<%=j%>" size="30" ></td>
                                </tr>
                        <%}}%>
                        <tr>
                            <td class="lightgray" valign="top"> <b>Μή συμβατότητα : </b></td>

                           <td colspan="2">
                            <div style="overflow-x:scroll; width:380px; overflow: -moz-scrollbars-horizontal;">
                                <select name="products" multiple="multiple" size="10" id="products" >
                                    <%for(int j=0;j<((Vector)AllCharacteristicsAndProducts.get(1)).size();j++){
                                        ProductInfoBean prod=((ProductInfoBean)((Vector)AllCharacteristicsAndProducts.get(1)).get(j));%>
                                        <option  value="<%=prod.getSerialNumber()%>" id="<%=prod.getSerialNumber()%>-><%=prod.getModel()%>"><%=prod.getSerialNumber()%>-><%=prod.getModel()%>  </option>
                                    <%}%>
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
                                    <select  style="width:380px" name="incompatible" multiple="multiple" id="incompatible" size="10" >
                                        
                                    </select>                                
                            </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="lightgray" valign="top"> <b>Μέγιστη απόδοση : </b></td>

                           <td colspan="2">
                            <div style="overflow-x:scroll; width:380px; overflow: -moz-scrollbars-horizontal;">
                                <select name="maxProducts" multiple="multiple" size="10" id="maxProducts" >
                                    <%for(int j=0;j<((Vector)AllCharacteristicsAndProducts.get(1)).size();j++){
                                        ProductInfoBean prod=((ProductInfoBean)((Vector)AllCharacteristicsAndProducts.get(1)).get(j));%>
                                        <option value="<%=prod.getSerialNumber()%>" id="max_<%=prod.getSerialNumber()%>-><%=prod.getModel()%>"><%=prod.getSerialNumber()%>-><%=prod.getModel()%>  </option>
                                    <%}%>
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
                                    <select style="width:380px" name="maxPerform" multiple="multiple" id="maxPerform" size="10" >
                                        
                                    </select>
                            </div>
                            </td>
                        </tr>
                        <tr><td>&nbsp;</td></tr>
                        <tr><td>&nbsp;</td><td align="right"><input value="Εισαγωγή προϊόντος" type="submit"  onclick="sendAttributes()" class="green_button"></td></tr>
                    </table>
                </div>
                
            </form>
        </div>
        <%@include file="footer.jsp" %>
    </div>
</body>

</html>