package controller.member;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.JWTTokens;
@WebServlet(urlPatterns = "/Logout.kjh")
public class LogoutController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//req.getSession().removeAttribute("username");
		req.getSession().invalidate();
		JWTTokens.removeToken(req, resp);
        resp.sendRedirect("index.jsp");
	}
	

}
