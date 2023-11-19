package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DAO.MemberDAO;
import model.board.DTO.BoardDTO;

@WebServlet("/Board/View.kjh")
public class ViewController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		BoardDAO dao = new BoardDAO(getServletContext());
		
		BoardDTO record = dao.selectOne(no);
		req.setAttribute("record", record);
		req.getRequestDispatcher("/WEB-INF/Member/View.jsp").forward(req, resp);
	}
	
}
