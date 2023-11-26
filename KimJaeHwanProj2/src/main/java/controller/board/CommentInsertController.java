package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.CommentDTO;

@WebServlet("/Board/CommentInsert.kjh")
public class CommentInsertController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = (String) req.getSession().getAttribute("username");
		String no = req.getParameter("no");
		String content = req.getParameter("commentcontent");
		
		
		BoardDAO dao = new BoardDAO(getServletContext());
		CommentDTO dto = new CommentDTO();
		dto.setNo(no);
		dto.setUsername(username);
		dto.setCommentcontent(content);
		int result = dao.insertComment(dto);
		
		if(result==0) {
			System.out.println("입력실패");
		}
		dao.close();
		resp.sendRedirect(req.getContextPath()+"/Board/View.kjh?no="+no);
	}
	
}
