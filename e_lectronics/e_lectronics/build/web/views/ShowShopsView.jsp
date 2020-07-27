<%-- 
    Document   : ShowShopsView
    Created on : 13 Ιαν 2010, 2:27:03 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="author" content="styledmenus.com" />
<title>Τα καταστήματα μας</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<link rel="icon" type="image/x-icon" href="images/titleLogo.png" />
</head>

<body>

<div id="wrap">
   <%@include file="header.html" %>
  <div id="menucontainer">
    <div id="menu">
		<ul>
			<li><a href="Controller?action=loadFirstPage">αρχικη</a></li>
			<li><a href="#" class="current">Kαταστηματα</a></li>
			<li><a href="Controller?action=showContactPage">Επικοινωνια</a></li>
		</ul>
    </div>
	</div>
	
        <%@include file="login_panel.jsp" %>	
	<%@include file="option_bar.jsp" %>

        <table id="breadcrumb" cellspacing="0" cellpadding="0">
            <tr>
                <td valign="top"><a href="Controller?action=loadFirstPage" title="" class="home">Home</a></td>
                <td valign="top" class=""><a href="Controller?action=loadFirstPage">Αρχική</a></td>
                <td valign="top" class="current"><a href="#">Καταστήματα</a></td>
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
				<td class="header"> <b>Δίκτυο Καταστημάτων </b></td>
			</tr>
			<tr>
				<td style="font-size:12px"> Για να βρείτε το κατάστημα της e-lectronics που σας εξυπηρετεί καλύτερα, επιλέξτε τον νομό που θέλετε απο τον χάρτη. Στην συνέχεια, επιλέξτε το κατάστημα που θέλετε για να δείτε περισσότερες πληροφορίες.
				</td>
			</tr>
			<tr>
				<td> <hr></td>
			</tr>
			<tr>
		<td><div id="shopsMap"><img src="images/diktioMap.gif" alt="" usemap="#Map" width="391" border="0" height="399">
                <map name="Map" id="Map1">
	                <area title="Έβρου" shape="rect" coords="280,34,300,64" href="# ">
	                <area title="Ροδόπης" shape="rect" coords="258,30,277,55" href="# ">
	                <area title="Ξάνθης" shape="rect" coords="226,21,245,46" href="# ">
	                <area title="Δράμας" shape="rect" coords="198,15,217,36" href="# ">
	                <area title="Καβάλας" shape="rect" coords="201,37,221,57" href="# ">

	                <area title="Σέρρων" shape="rect" coords="169,27,191,52" href="# ">
	                <area title="Θεσσαλονίκης" shape="rect" coords="155,63,178,88" href="# ">
	                <area title="Κοζάνης" shape="rect" coords="102,83,116,100" href="# ">
	                <area title="Κοζάνης" shape="rect" coords="86,72,99,90" href="# ">
	                <area title="Καστοριάς" shape="rect" coords="64,67,77,85" href="# ">
	                <area title="Γρεβενών" shape="rect" coords="74,90,88,106" href="# ">
	                <area title="Κερκύρας" shape="rect" coords="9,115,24,133" href="# ">
	                <area title="Θεσπρωτίας" shape="rect" coords="30,126,44,144" href="# ">

	                <area title="Ιωαννίνων" shape="rect" coords="47,103,60,119" href="# ">

	                <area title="Άρτας" shape="rect" coords="64,137,77,153" href="# ">
	                <area title="Πρέβεζας" shape="rect" coords="46,142,60,160" href="# ">
	                <area title="Κεφαλλονιάς" shape="rect" coords="41,195,54,213" href="# ">
	                <area title="Αιτωλοακαρνανίας" shape="rect" coords="70,172,83,190" href="# ">
	                <area title="Φωκίδας" shape="rect" coords="103,180,117,197" href="# ">
	                <area title="Κορινθίας" shape="rect" coords="134,207,147,225" href="# ">
	                <area title="Αργολίδας" shape="rect" coords="145,234,158,252" href="# ">

	                <area title="Αργολίδας" shape="rect" coords="130,233,143,249" href="# ">
	                <area title="Αρκαδίας" shape="rect" coords="109,233,122,250" href="# ">

	                <area title="Αχαίας" shape="rect" coords="97,203,109,221" href="# ">
	                <area title="Ηλείας" shape="rect" coords="81,218,94,234" href="# ">
	                <area title="Ζακύνθου" shape="rect" coords="48,218,60,236" href="# ">
	                <area title="Μεσσηνίας" shape="rect" coords="96,261,109,278" href="# ">
	                <area title="Λακωνίας" shape="rect" coords="130,267,143,287" href="# ">
	                <area title="Χανίων" shape="rect" coords="185,354,198,372" href="# ">

	                <area title="Ρεθύμνου" shape="rect" coords="217,359,230,377" href="# ">
	                <area title="Ηρακλείου" shape="rect" coords="244,365,258,383" href="# ">
	                <area title="Λασιθίου" shape="rect" coords="279,366,293,385" href="# ">

	                <area title="Δωδεκανήσου" shape="rect" coords="367,307,380,326" href="# ">
	                <area title="Πέλλας" shape="rect" coords="110,37,128,63" href="# ">
	                <area title="Φλώρινας" shape="rect" coords="79,46,96,70" href="# ">
	                <area title="Ημαθίας" shape="rect" coords="114,65,128,84" href="# ">
	                <area title="Λάρισας" shape="rect" coords="119,110,134,130" href="# ">

	                <area title="Λέσβου" shape="rect" coords="291,143,307,163" href="# ">
	                <area title="Χίου" shape="rect" coords="276,178,293,198" href="# ">
	                <area title="Σάμου" shape="rect" coords="312,220,329,243" href="# ">
	                <area title="Κυκλάδων" shape="rect" coords="235,229,254,249" href="# ">

	                <area title="Κυκλάδων" shape="rect" coords="245,277,262,297" href="# ">
	                <area title="Ευβοίας" shape="rect" coords="174,175,192,196" href="#">
	                <area title="Βοιωτίας" shape="rect" coords="150,187,166,208" href="#">
	                <area title="Αττικής" shape="rect" coords="179,204,195,225" href="#">

	                <area title="Μαγνησίας" shape="rect" coords="138,143,154,164" href="#">
	                <area title="Φθιώτιδος" shape="rect" coords="116,156,133,176" href="#">
	                <area title="Καρδίτσας" shape="rect" coords="98,133,113,154" href="#">
	                <area title="Τρικάλων" shape="rect" coords="87,107,102,129" href="#">
	                <area title="Πιερίας" shape="rect" coords="124,85,138,103" href="#">
                    </map>
                </div>
                </td>
	      </tr>

		</table>
	</div>
<%@include file="footer.jsp" %>
</div>


</body>
</html>
