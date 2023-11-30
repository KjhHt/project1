package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;

@WebServlet("/Board/CommentUpdate.kjh")
public class CommentUpdateController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String updateCno = req.getParameter("updateCno");
		String content = req.getParameter("commentcontent");
		String no = req.getParameter("no");
		System.out.println("updateCno = " +updateCno);
		System.out.println("content = " +content);
		BoardDAO dao = new BoardDAO(getServletContext());
		int result = dao.updateComment(updateCno,content);
		if(result==0) {
			System.out.println("CommentUpdateController 입력실패");
		}
		dao.close();
		resp.sendRedirect(req.getContextPath()+"/Board/View.kjh?no="+no);
	}
	
}
