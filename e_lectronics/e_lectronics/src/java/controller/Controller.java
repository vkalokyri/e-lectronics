/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import java.io.IOException;
import java.util.HashMap;
import javax.servlet.*;
import javax.servlet.http.*;


/**
 *
 * @author Valitsa
 */
public class Controller extends HttpServlet {

    /** The HashMap events is used to hold the action/event definitions: */

  protected HashMap actions = new HashMap();

  /**
   * The init() method reads the events from a properties file and inserts them 
   * into the event handler table. An action/event definition consists of an 
   * action/event name and the corresponding handler class: 
   *
   * @throws javax.servlet.ServletException
   */
  public void init() throws ServletException {
    super.init();
    
    /**
     * The Event.properties file is read to determine the actions/events that 
     * can be processed. 
     *
     * The format of the file is: event/action = handler full class name.
     * For example:
     *
     * loadFirstPage=tuc.ced.music.ecesite.actions.ShowMainAction
     */
     actions.put("showFirstPage", "actions.InitPage");
     actions.put("loadFirstPage", "actions.ShowFirstPage");
     actions.put("showRegisterPage", "actions.ShowRegisterPage");
     actions.put("showConfirmRegisterPage", "actions.ShowConfirmRegisterPage");
     actions.put("showShopsPage", "actions.ShowShopsPage");
     actions.put("showContactPage", "actions.ShowContactPage");
     actions.put("showListOfProductsPage", "actions.ShowListOfProductsPage");
     actions.put("showCategoryPage", "actions.ShowCategoryPage");
     actions.put("showProductDetailsPage", "actions.ShowProductDetailsPage");
     actions.put("showComparePage", "actions.ShowComparePage");
     actions.put("shoppingCartPage", "actions.ShoppingCartPage");
     actions.put("addToCartPage", "actions.AddToCartPage");
     actions.put("myAccountPage", "actions.MyAccountPage");
     actions.put("showProfilePage", "actions.ShowProfilePage");
     actions.put("showConfirmChangesPage", "actions.ShowConfirmChangesPage");
     actions.put("showMakeOrderPage", "actions.ShowMakeOrderPage");
     actions.put("showConfirmOrderPage", "actions.ShowConfirmOrderPage");
     actions.put("showConfirmOrderChanges", "actions.ShowConfirmOrderChanges");
     actions.put("showMyOrdersPage", "actions.ShowMyOrdersPage");
     actions.put("showSpecificOrderPage", "actions.ShowSpecificOrderPage");
     actions.put("showReviewOrdersPage", "actions.ShowReviewOrdersPage");
     actions.put("showAllOrdersPage", "actions.ShowAllOrdersPage");
     actions.put("showInsertProductPage", "actions.ShowInsertProductPage");
     actions.put("showConfirmInsertProductPage", "actions.ShowConfirmInsertProductPage");
     actions.put("showInsertCategoryPage", "actions.ShowInsertCategoryPage");
     actions.put("showConfirmCategoriesChangesPage", "actions.ShowConfirmCategoriesChangesPage");
     actions.put("showChangeProductPage", "actions.ShowChangeProductPage");
     actions.put("showDeleteProductPage", "actions.ShowDeleteProductPage");
     actions.put("showConfirmChangeProductPage", "actions.ShowConfirmChangeProductPage");
     actions.put("showConfirmDeleteProductPage", "actions.ShowConfirmDeleteProductPage");
     actions.put("showChangeOrdersPage", "actions.ShowChangeOrdersPage");
     actions.put("showCancelOrderPage", "actions.ShowCancelOrderPage");
     actions.put("showInventoryPage", "actions.ShowInventoryPage");
     actions.put("showShortagePage", "actions.ShowShortagePage");
     actions.put("showComplexSearchPage", "actions.ShowComplexSearchPage");
     actions.put("showSearchResultsPage", "actions.ShowSearchResultsPage");
     actions.put("showΑddBasketPage", "actions.ShowΑddBasketPage");
     actions.put("showMyCartsPage", "actions.ShowMyCartsPage");
     actions.put("showSpecificCartPage", "actions.ShowSpecificCartPage");
     actions.put("showDeleteCartPage", "actions.ShowDeleteCartPage");
     actions.put("showLoadCartPage", "actions.ShowLoadCartPage");
     actions.put("showlogoutPage", "actions.ShowLogoutPage");
     actions.put("showPopularProductsPage", "actions.ShowPopularProductsPage");
     actions.put("showNewestProductsPage", "actions.ShowNewestProductsPage");
     actions.put("sendEmail", "actions.ShowSendEmailPage");
     actions.put("showForgetPasswordPage", "actions.ShowForgetPasswordPage");
     actions.put("showHelpPage", "actions.ShowHelpPage");



  }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        /* Wrap request object with helper */
      request.setCharacterEncoding("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("text/html;charset=UTF-8");

      RequestUtility reqUtil = new RequestUtility(request, actions);

      /* Create an Action object based on request parameters */
      Action action = reqUtil.getAction();
      System.out.println("action==" +action);
      

      /* Execute business logic */
      if (action != null && action.execute(request, response)) {

         /* Get appropriate view for action */
        String view = action.getView();

        /* Add the model to the request attributes */
        request.setAttribute("model", action.getModel());
        

        /* Forward the request to the given view */
        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
      }

    }    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}