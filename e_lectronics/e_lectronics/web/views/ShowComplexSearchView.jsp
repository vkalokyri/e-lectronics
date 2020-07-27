<%-- 
    Document   : ShowComplexSearchView
    Created on : 17 Φεβ 2010, 11:28:09 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Σύνθετη Αναζήτηση</title>
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
                <td valign="top" class="current"><a href="#">Σύνθετη Αναζήτηση</a></td>
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
				<td class="header"> <b>Σύνθετη αναζήτηση</b> <span style="font-size:12px"></span></td>
			</tr>
		</table>

            <form method="post" action="Controller?action=showSearchResultsPage" >
		<table class="bigger" cellpadding="0" cellspacing="8" align="center">
                    <tr><td><b>Eισάγετε λέξεις κλειδιά</b></td></tr>
                    <tr><td width="320px"><input name="keywords" type="text" size="45"></td>
                        <td width="320px"><select  name="searchLimits">
                    <option value="or_all">οποιεσδήποτε λέξεις,οποιαδήποτε σειρά</option>
                    <option value="specific_specific">συγκεκριμένες λέξεις,συγκεκριμένη σειρά</option>
                    <option value="and_all">συγκεκριμένες λέξεις,οποιαδήποτε σειρά</option>
                    </select></td>
                    </tr>
                    <tr><td>Αποκλείστε λέξεις από την αναζήτηση σας </td></tr>
                    <tr><td><input name="excludeWords" type="text" size="40"></td></tr>
                    <tr><td><b>Επιλέξτε κατηγορία </b></td></tr>
                    <tr><td><select id="category"  name="category">
                                <option value="all" selected="selected" onclick="checkChangedInventoryCat()">Όλες οι κατηγορίες</option>
                            <%for(int i=0;i<listOfCategories.size();i++){
                                String name=((CategoryInfoBean)listOfCategories.get(i)).getName();%>
                                <option id="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>" value="<%=((CategoryInfoBean)listOfCategories.get(i)).getCategoryID()%>"  onclick="checkChangedInventoryCat()"><%=name%></option>
                            <%}%>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td> <b>Επιλέξτε Υποκατηγορία </b></td>
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
                        <tr><td><b>Tιμή</b></td></tr>
                        <tr><td colspan="2">Eμφάνιση προϊόντων με τιμή από <input type="text" name="startPrice" size="5"> € έως <input name="endPrice" type="text" size="5"> €</td></tr>
                        <tr><td><input value="Αναζήτηση" type="submit" class="green_button" style="font-weight:bold;" ></td></tr>
					
		</table>	
                </form>

	</div>	

    <%@include file="footer.jsp"  %>
</div>

</body>
</html>
