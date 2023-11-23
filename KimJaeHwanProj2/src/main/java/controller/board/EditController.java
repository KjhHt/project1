package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.BoardDTO;

@WebServlet("/Board/Edit.kjh")
public class EditController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String no = req.getParameter("no");
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO list = dao.selectOne(no);
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/WEB-INF/Member/Edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String RequestNo = req.getParameter("no");
		String no = RequestNo.substring(0,RequestNo.length()-1);
		System.out.println(no);
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO dto = new BoardDTO();
		dto.setNo(no);
		dto.setTitle(title);
		dto.setContent(content);
		int result = dao.update(dto);
		
		dao.close();
		if(result==0) {
			System.out.println("수정실패");
		}
		resp.sendRedirect(req.getContextPath()+"/Board/View.kjh?no="+no);
	}
	
}
