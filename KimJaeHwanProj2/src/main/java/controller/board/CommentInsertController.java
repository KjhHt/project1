package controller.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Board/CommentInsert.kjh")
public class CommentInsertController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String content = req.getParameter("commentcontent");
		System.out.println(no);
		System.out.println(content);
		
		System.out.println("dopost입장~~");
		resp.sendRedirect(req.getContextPath()+"/Board/View.kjh?no="+no);
	}
	
}
