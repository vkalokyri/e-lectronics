/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import java.io.IOException;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Valitsa
 */
public class ShowInventoryPage implements Action {

    private String view;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        
       HttpSession session=req.getSession();
       Vector current=(Vector)session.getAttribute("CurrentMenu");

       if(current==null){
          current=new Vector();
          current.add(0, "-1");
          current.add(1, "-1");
       }
       current.add(0, "-1");
       current.add(1, "-1");
       session.setAttribute("CurrentMenu",current);
        
        view = "./views/ShowInventoryView.jsp";
        
        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return null;
    }

}
