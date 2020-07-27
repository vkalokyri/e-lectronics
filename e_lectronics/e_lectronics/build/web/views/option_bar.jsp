<%--
    Document   : SmallCart
    Created on : 20 Ιαν 2010, 4:37:52 μμ
    Author     : Valitsa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<form method="post" action="Controller?action=showSearchResultsPage">
    <table id="option_bar" cellpadding="0" cellspacing="0">
          <tr>
            <td width="158px" class="search_input"><input name="simpleSearch" type="text" size="20"></td>
            <td width="23px" class="search"><input type="image" src="images/search.gif" alt="Αναζήτηση" /></td>
            <td><a href="Controller?action=showComplexSearchPage">Σύνθετη Αναζήτηση </a></td>
            <td width="130px" align="center"><a href="Controller?action=myAccountPage">O λογαριασμός μου </a></td>
            <td width="5px" align="center"> | </td>
            <td width="130px" align="center" class="basket"><a href="Controller?action=shoppingCartPage&ov=1"><img src="images/basket.gif" alt="To καλάθι μου"/>To καλάθι μου</a></td>
        </tr>
    </table>
</form>

