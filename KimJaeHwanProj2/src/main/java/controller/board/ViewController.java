package controller.board;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.BoardDTO;
import model.board.DTO.CommentDTO;

@WebServlet("/Board/View.kjh")
public class ViewController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		BoardDAO dao = new BoardDAO(getServletContext());
		// 조회수 증가 + view정보
		String url = req.getHeader("referer").substring(req.getHeader("referer").lastIndexOf("/")+1);
		BoardDTO record = dao.selectOne(no,url);
		req.setAttribute("record", record);
		// 좋아요 갯수 가져오기
		int likeRecord = dao.likeCount(no);
		req.setAttribute("likeRecord", likeRecord);
		// 게시글번호로 댓글내용 다 가져오기
		List<CommentDTO> commentList = dao.commentSelect(no);
		req.setAttribute("commentList", commentList);
		req.setAttribute("commentCount", commentList.size());
		
		
		req.getRequestDispatcher("/WEB-INF/Member/View.jsp").forward(req, resp);
	}
	
}
