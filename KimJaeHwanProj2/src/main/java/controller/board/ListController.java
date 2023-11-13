package controller.board;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DAO.JWTTokens;
import model.board.DTO.BoardDTO;

@WebServlet("/Board/List.kjh")
public class ListController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO(getServletContext());
		List<BoardDTO> list = dao.selectList(null);
		dao.close();
		req.setAttribute("list", list);
		req.getRequestDispatcher("/WEB-INF/Member/List.jsp").forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO(getServletContext());
		List<BoardDTO> list = dao.selectList(null);
		dao.close();
		req.setAttribute("list", list);
		req.getRequestDispatcher("/WEB-INF/Member/List.jsp").forward(req, resp);		
	}
}
