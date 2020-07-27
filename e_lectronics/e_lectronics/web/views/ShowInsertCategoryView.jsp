<%--
    Document   : ShowInsertProductView
    Created on : 7 Φεβ 2010, 4:06:14 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="model.CharacteristicsInfoBean"%>
<%@page import="java.util.Vector"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="author" content="styledmenus.com" />
    <title>Επεξεργασία Κατηγοριών</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>
<%Vector allCharacteristics=(Vector)request.getAttribute("model");
  Vector listOfSubcatID=new Vector();  %>

<body onload="onloadSetOption()">

    
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
                <td valign="top" class="current"><a href="#">Επεξεργασία κατηγοριών</a></td>
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
                        <td class="blueheader"> <b>Eπεξεργασία Κατηγοριών</b></td>
                    </tr>
            </table>

            
            <form action="Controller?action=showConfirmCategoriesChangesPage" method="POST" name="checkInsertForm">
                <table class="bigger" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" width="200px" style="font-size:12px;"><b>Kατηγορίες</b></td>
                        <td align="center" width="200px" style="font-size:12px;"><b>Υποκατηγορίες</b></td>
                        <td align="center" width="200px" style="font-size:12px;"><b>Χαρακτηριστικά</b></td>
                    </tr>
                    <tr>
                        <td width="200px">
                            <fieldset style="height:325px" id="Category_fieldset">
                                <select size="20"  name="category" style="width:200px">
                                <%for(int i=0;i<listOfCategories.size();i++){
                                    String name=((CategoryInfoBean)listOfCategories.get(i)).getName();%>
                                    <option id="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" value="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>_<%=name%>" onclick="checkChangedCategory(); checkChangedSubcategory()"><%=name%></option>
                                <%}%>                        
                                </select>  
                            </fieldset>
                         </td>
                        <td width="200px">
                            <fieldset style="height:325px" id="Subcategory_fieldset">
                                <%for(int i=0;i<listOfCategories.size();i++){
                                    String s;
                                    if(i==0){
                                        s="inline";
                                    }else{ s="none";}%>
                                    <select id="subcateg_<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" style="width:200px; display:<%=s%>" size="20" name="subcateg<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" >
                                    <%for(int j=0;j<((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().size();j++){
                                        String name=((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getName();
                                        int sqlid  =((CategoryInfoBean)((CategoryInfoBean)listOfCategories.get(i)).getListOfSubcategories().get(j)).getCategoryID();
                                        listOfSubcatID.add(sqlid);%>
                                        <option <%if(j==0){%>selected="selected"<%}%> id="<%=sqlid%>" value="<%=sqlid+"_"+name%>" onclick="checkChangedSubcategory()" ><%=name%></option>
                                    <%}%>
                                    </select>
                                <%}%>
                            </fieldset>

                        </td>
                        <td width="200px">
                           <fieldset style="height:325px" id="Characteristics_fieldset">
                               <%for(int i=0;i<allCharacteristics.size();i++){%>
                                    <select id="characteristic_<%=listOfSubcatID.get(i)%>" size="20" style="width:200px" style="display:none" name="characteristic<%=listOfSubcatID.get(i)%>">
                                    <%for(int j=0;j<((Vector)allCharacteristics.get(i)).size();j++){
                                        CharacteristicsInfoBean charact=((CharacteristicsInfoBean)((Vector)allCharacteristics.get(i)).get(j));%>
                                        <option value="characteristic_<%=charact.getSubcategId()%>_<%=j%>_<%=charact.getName()%>"><%=charact.getName()%></option>
                                    <%}%>
                                    </select>
                              <%}%>
                              
                         
                            </fieldset>
                        </td>
                    </tr>
                </table>                      
                 <table class="bigger" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="200px" align="right"><input id="addCat" type="button" value="+" onclick="addCategory()"><input id="delCat" type="button" value="-" onclick="delCategory()"></td>
                        <td width="200px"align="right"><input id="addSubcat" type="button" value="+" onclick="addSubcategory()"><input id="delSubcat" type="button" value="-" onclick="delSubcategory()"></td>
                        <td width="200px" align="right"><input id="addCharact" type="button" value="+" onclick="addCharacteristic()"><input id="delCharact" type="button" value="-" onclick="delCharacteristic()"></td>
                    </tr>
                </table>

                <table class="bigger" cellspacing="0" cellpadding="0">
                    <tr><td colspan="3">&nbsp</td></tr>
                     <tr><td colspan="3">&nbsp</td></tr>
                    <tr>
                        <td width="200px" align="right"></td>
                        <td width="200px"align="middle"><input style="height:25px" type="submit" onclick="sendAllAttributes()" value="Αποθήκευση Αλλαγών" class="green_button"></td>
                        <td width="200px" align="right"></td>
                    </tr>
                </table>

            </form>
        </div>
        <%@include file="footer.jsp" %>
    </div>
</body>

</html>