/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package actions;

import controller.Action;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Valitsa
 */
public class ShowHelpPage implements Action {

    private String view;

    public boolean execute(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        view="./views/ShowHelpView.jsp";
        return true;
    }

    public String getView() {
        return view;
    }

    public Object getModel() {
        return null;
    }

}
