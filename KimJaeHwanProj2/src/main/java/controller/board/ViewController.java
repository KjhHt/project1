package controller.board;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DAO.MemberDAO;
import model.board.DTO.BoardDTO;
import model.board.DTO.CommentDTO;
import model.board.DTO.MemberDTO;

@WebServlet("/Board/View.kjh")
public class ViewController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = (String) req.getSession().getAttribute("username");
		MemberDAO dao2 = new MemberDAO(getServletContext());
		MemberDTO info = dao2.selectOne(username);
		req.setAttribute("name", info.getName());
		dao2.close();
		String no = req.getParameter("no");
		BoardDAO dao = new BoardDAO(getServletContext());
		// 조회수 증가 + view정보
		String url = req.getHeader("referer").substring(req.getHeader("referer").lastIndexOf("/")+1);
		BoardDTO record = dao.selectOne(no,url);
        int fileCount = countFiles(record.getAttachFile());
        req.setAttribute("fileCount", fileCount);
		req.setAttribute("record", record);
		// 좋아요 갯수 가져오기
		int likeRecord = dao.likeCount(no);
		req.setAttribute("likeRecord", likeRecord);
		// 좋아요 누른여부? 1:누른적있음 0:누른적없음
		int isLike = dao.isLike(no,username);
		req.setAttribute("isLike", isLike);
		//해당 게시글 댓글 수 가져오기
		int commentCount = dao.commentCountOne(no);
		req.setAttribute("commentCount", commentCount);
		
		//댓글 게시글 뿌려주기
		List<CommentDTO> firstCommentList = dao.firstCommentList(no);
		List<CommentDTO> secondCommentList = dao.secondCommentList(no);
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
		}
		
		if(secondCommentList.size()!=0) {
			req.setAttribute("resultList", resultList);
		}
		else {
			req.setAttribute("resultList", firstCommentList);
		}
		dao.close();
		req.getRequestDispatcher("/WEB-INF/Member/View.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("DOPOST");
		super.doPost(req, resp);
	}
	
    private static int countFiles(String attachFile) {
        if ("X".equals(attachFile.trim())) {
            return 0;
        }
        String[] files = attachFile.split(",");
        return files.length > 0 ? files.length : 0;
    }
    
	
}
