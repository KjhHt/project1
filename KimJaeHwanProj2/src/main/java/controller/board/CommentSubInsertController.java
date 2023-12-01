package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.CommentDTO;

@WebServlet("/Board/CommentSubInsert.kjh")
public class CommentSubInsertController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = (String) req.getSession().getAttribute("username");
		String no = req.getParameter("no");
		String replaywhether = req.getParameter("replaywhether");
		String cno = req.getParameter("cno");
		String content = req.getParameter("commentcontent");
		String subname = req.getParameter("subname");
		
		System.out.println("??"+subname+"?");
		System.out.println(subname==null);
		System.out.println(subname=="");
		System.out.println(content);
		
		if(subname==null) {
			subname="X";
		}

		BoardDAO dao = new BoardDAO(getServletContext());
		CommentDTO dto = new CommentDTO();
		dto.setCno(cno);
		dto.setReplaywhether(replaywhether);
		dto.setNo(no);
		dto.setUsername(username);
		dto.setCommentcontent(content);
		dto.setSubname(subname);
		int result = dao.insertSubComment(dto);
		
		if(result==0) {
			System.out.println("입력실패");
		}
		dao.close();	
		resp.sendRedirect(req.getContextPath()+"/Board/View.kjh?no="+no);
	}
	
}
