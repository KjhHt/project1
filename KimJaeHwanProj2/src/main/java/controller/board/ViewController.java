package controller.board;

import java.io.IOException;
import java.util.List;
import java.util.Vector;
import java.util.stream.Collectors;

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
		
		//테스트용
		List<CommentDTO> firstCommentList = dao.firstCommentList(no);
		System.out.println(firstCommentList.size());
		List<CommentDTO> secondCommentList = dao.secondCommentList(no);
		System.out.println("firstCommentList.size() : "+firstCommentList.size());
		System.out.println("secondCommentList.size() : "+secondCommentList.size());
		List<CommentDTO> resultList = new Vector<>();
		boolean test = false;
		int size = firstCommentList.size();
		if (secondCommentList.size() != 0) {
		    for (int i = 0; i < size; i++) {
		        CommentDTO comment = firstCommentList.get(i);
		        String cno = comment.getCno();
		        // 현재 댓글 추가
		        resultList.add(comment);
		        // 두 번째 댓글 목록에 대한 처리
		        for (int k = 0; k < secondCommentList.size(); k++) {
		            CommentDTO temp = secondCommentList.get(k);
		            // 현재 댓글과 subcomment가 일치하는 경우
		            if (temp.getSubcomment().equals(cno)) {
		                List<CommentDTO> subComments = dao.commentCnoEqualSub(cno);
		                if(!test) {
		                	resultList.addAll(subComments); // 두 번째 댓글 목록에 추가
		                	test = true;
		                }
		            }
		        }
		        test = false;
		    }
		    System.out.println("7이나와야됨" + resultList.size());
		}
		
		
		req.setAttribute("resultList", resultList);
		//테스트용
		dao.close();
		req.getRequestDispatcher("/WEB-INF/Member/View.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DOPOST");
		super.doPost(req, resp);
	}
	
}
