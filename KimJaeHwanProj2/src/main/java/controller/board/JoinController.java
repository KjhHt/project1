package controller.board;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.MemberDAO;
import model.board.DTO.MemberDTO;

@WebServlet("/JoinMember.kjh")
public class JoinController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/Member/Member_Join.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO(getServletContext());
		MemberDTO dto = new MemberDTO();
		PrintWriter out= resp.getWriter();
		
		String username = req.getParameter("username");
		String[] inters = req.getParameterValues("inters");
		StringBuilder sb = new StringBuilder();
		for(String interValue : inters) {
			switch(interValue) {
				case "1": sb.append("정치,"); break;
				case "2": sb.append("경제,"); break;
				default: sb.append("연예,");
			}
		}
		String inter = sb.substring(0,sb.length()-1).toString();
		String selfintroduce = req.getParameter("selfintroduce");
		String password = req.getParameter("password");
		String education = req.getParameter("education");
		String gender = req.getParameter("gender");
		
		dto.setUsername(username);
		dto.setPassword(password);
		dto.setEducation(education);
		dto.setInters(inter);
		dto.setSelfintroduce(selfintroduce);
		dto.setGender(gender);
		int insert = dao.insert(dto);
		
		dao.close();
		
		
		if(insert == 1 ) {
			resp.setContentType("text/html; charset=UTF-8");
			out.println("<script>");
			out.println("alert('회원가입 완료되었습니다! 로그인 후 이용하세요!');");
			out.println("location.href='"+req.getContextPath() + "/index.jsp';");
			out.println("</script>");
		}
		else {
			resp.setContentType("text/html; charset=UTF-8");
			out.println("<script>alert('회원가입에 실패했습니다.'); history.back();</script>");
		}
	}
}
