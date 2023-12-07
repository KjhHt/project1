package controller.member;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.EmailUtil;
import service.mailSendService;

@WebServlet("/mailCheck")
public class EmailController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
		String email = req.getParameter("email");
		System.out.println(email);
		EmailUtil emailUtil = new EmailUtil();
		String result=emailUtil.joinEmail(email);
		System.out.println("최종결과? : "+result);
        String jsonResponse = "{\"result\": \"" + result + "\"}";
        resp.getWriter().write(jsonResponse);
	}
}
