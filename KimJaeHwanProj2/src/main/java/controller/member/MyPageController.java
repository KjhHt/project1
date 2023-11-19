package controller.member;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.MemberDAO;
import model.board.DTO.MemberDTO;

@WebServlet("/Board/MyPage.kjh")
public class MyPageController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = (String) req.getSession().getAttribute("username");
		MemberDAO dao = new MemberDAO(getServletContext());
		MemberDTO list = dao.selectOne(username);
		req.setAttribute("list", list);
		req.getRequestDispatcher("/WEB-INF/Member/Member_MyPage.jsp").forward(req, resp); 
	}
	
}
