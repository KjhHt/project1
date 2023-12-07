package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.BoardDTO;

@WebServlet("/Board/Delete.kjh")
public class DeleteController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO dto = new BoardDTO();
		dto.setNo(no);
		
		int result = dao.delete(dto);
		dao.close();
		
		if(result==0) {
			System.out.println("입력실패");
		}
		req.getRequestDispatcher("/Board/List.kjh").forward(req, resp);
	}
	
}
