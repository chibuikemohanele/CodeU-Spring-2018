package codeu.controller;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ProfileServlet extends HttpServlet
{
    
    //Forwards the request to the profile.jsp to create the profile page
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws IOException, ServletException 
    {   
        //Checks to see if the user is logged into his or her page
        if (request.getSession().getAttribute("user") != null) 
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