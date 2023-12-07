package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.JWTTokens;
import model.board.DAO.MemberDAO;
import model.board.DTO.MemberDTO;

@WebServlet("/Board/DelMember.kjh")
public class MemberDelController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO(getServletContext());
		MemberDTO dto = new MemberDTO();
		PrintWriter out= resp.getWriter();
		String username = (String) req.getSession().getAttribute("username");
		dto.setUsername(username);
		int delete = dao.delete(dto);
		dao.close();
		if(delete == 1 ) {
			req.getSession().removeAttribute("username");
			JWTTokens.removeToken(req, resp);
			resp.setContentType("text/html; charset=UTF-8");
			out.println("<script>");
			out.println("alert('회원탈퇴 완료되었습니다!');");
			out.println("location.href='"+req.getContextPath() + "/index.jsp';");
			out.println("</script>");
		}
		else {
			resp.setContentType("text/html; charset=UTF-8");
			out.println("<script>alert('탈퇴 실패했습니다.'); history.back();</script>");
		}	
	}
	

}
