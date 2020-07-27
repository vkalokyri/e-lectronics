<%-- 
    Document   : ShowFirstPageView
    Created on : 4 Ιαν 2010, 9:40:43 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.CategoryInfoBean"%>
<%@page import="model.ProductInfoBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Ε-lectronics</title>
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
<script type="text/javascript" src="validate_form.js"></script>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<%Vector productsInView=(Vector)request.getAttribute("model");%>

<body>

<div id="wrap">
  <%@include file="header.html" %>
  <div id="menucontainer">
    <div id="menu">
        <ul>
                <li><a href="#" class="current">αρχικη</a></li>
                <li><a href="Controller?action=showShopsPage">καταστηματα</a></li>
                <li><a href="Controller?action=showContactPage">επικοινωνια</a></li>
        </ul>
    </div>
  </div>
  
  <%@include file="login_panel.jsp" %> 
  <%@include file="option_bar.jsp" %>
  
  <table id="breadcrumb" cellspacing="0" cellpadding="0">
        <tr>
            <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
            <td valign="top" class="current"><a href="Controller?action=loadFirstPage">Αρχική</a></td>
        </tr>
  </table>
  

  
    

  <%@include file="LeftMenu.jsp" %>
     <div id="RightMenu">
            <%@include file="SmallCart.jsp" %>
            <%@include file="login_form.jsp" %>
     </div>
        <div id="main_menu">
            <table class="bigger" cellspacing="0" cellpadding="3">
                    <tr>
                        <td class="header"><a href="Controller?action=showNewestProductsPage"> <b>Nέες παραλαβές.</b></a><a href="Controller?action=showNewestProductsPage" style="font-size:11px; float:right;"><b>Δείτε όλες τις παραλαβές του μήνα</b>&nbsp;»&nbsp;</a></td>
                    </tr>
            </table>

            <table class="bigger">                
                <tr>  
                <%for(int i=0;i<((Vector)productsInView.get(0)).size();i++){%>
                    <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getSerialNumber()%>&CategID=<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getSubcategoryID()%>"><img src="<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getImageUrl()%>"/></a><hr></td>
                <%}%>
                </tr>
                <tr>
                <%for(int i=0;i<((Vector)productsInView.get(0)).size();i++){%>
                    <td><%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getSerialNumber()%></td>
                <%}%>
                </tr>
                <tr>
                 <%for(int i=0;i<((Vector)productsInView.get(0)).size();i++){%>
                    <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getSerialNumber()%>&CategID=<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getSubcategoryID()%>"><%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getModel()%></a></td>
                 <%}%>
                </tr>
                <tr>
                <%for(int i=0;i<((Vector)productsInView.get(0)).size();i++){%>
                    <td>Tιμή: <span style="color:red"><%=((ProductInfoBean)((Vector)productsInView.get(0)).get(i)).getPrice()%></span></td>
                 <%}%>                    
                </tr>
            </table>



            <table class="bigger" cellspacing="0" cellpadding="3">
                    <tr>
                        <td class="header"><a href="Controller?action=showPopularProductsPage"> <b>Τα πιο δημοφιλή προϊόντα.</b></a><a href="Controller?action=showPopularProductsPage" style="font-size:11px; float:right;"><b>Δείτε όλα τα δημοφιλέστερα προϊόντα του μήνα</b>&nbsp;»&nbsp;</a></td>
                    </tr>
            </table>

            <table class="bigger">
            <tr>
                <%for(int i=0;i<((Vector)productsInView.get(1)).size();i++){%>
                <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getSerialNumber()%>&CategID=<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getSubcategoryID()%>"><img src="<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getImageUrl()%>"/></a><hr></td>
                <%}%>
                </tr>
                <tr>
                <%for(int i=0;i<((Vector)productsInView.get(1)).size();i++){%>
                    <td><%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getSerialNumber()%></td>
                <%}%>
                </tr>
                <tr>
                 <%for(int i=0;i<((Vector)productsInView.get(1)).size();i++){%>
                    <td><a href="Controller?action=showProductDetailsPage&SerialNumber=<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getSerialNumber()%>&CategID=<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getCategoryID()%>&SubcategID=<%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getSubcategoryID()%>"><%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getModel()%></a></td>
                 <%}%>
                </tr>
                <tr>
                <%for(int i=0;i<((Vector)productsInView.get(1)).size();i++){%>
                    <td>Tιμή: <span style="color:red"><%=((ProductInfoBean)((Vector)productsInView.get(1)).get(i)).getPrice()%></span></td>
                 <%}%>
                </tr>
            </table>


    </div>
    
<%@include file="footer.jsp" %>
</div>


</body>

</html>