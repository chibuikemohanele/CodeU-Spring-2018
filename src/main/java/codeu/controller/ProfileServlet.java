package codeu.controller;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
//import codeu.model.data.User;
//import codeu.model.store.basic.UserStore;

public class ProfileServlet extends HttpServlet
{
    /** Store class that gives access to Users. */
    //private UserStore userStore;
    
    //Forwards the request to the profile.jsp to create the profile page
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException 
    {
        String requestUrl = request.getRequestURI();
        String username = requestUrl.substring("/profile/".length());
        //String username = request.getParameter("username");
        
        if (username.equals(request.getSession().getAttribute("user"))) 
        {
            request.getRequestDispatcher("/WEB-INF/view/profile.jsp").forward(request, response);
            return;
        }
        else
        {
            request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
            return;
        }
    }

}