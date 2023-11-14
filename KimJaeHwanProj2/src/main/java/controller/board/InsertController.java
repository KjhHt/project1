package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.BoardDTO;

@WebServlet(urlPatterns = "/Board/Insert.kjh")
public class InsertController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.getRequestDispatcher("/WEB-INF/Member/Insert.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost( HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String username = (String) req.getSession().getAttribute("username");
		
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO dto = new BoardDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setUsername(username);
		int result = dao.insert(dto);
		dao.close();
		
		System.out.println(result);
		if(result==0) {
			System.out.println("입력실패");
		}
		req.getRequestDispatcher("/Board/List.kjh").forward(req, resp);
		
	}
	
}
