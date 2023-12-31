package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.MemberDAO;
import model.board.DTO.MemberDTO;

@WebServlet("/Board/EditMember.kjh")
public class MemberEditController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO(getServletContext());
		String username = (String) req.getSession().getAttribute("username");
		MemberDTO memberDto = dao.selectOne(username);
		req.setAttribute("memberDto", memberDto);
		dao.close();
		req.getRequestDispatcher("/WEB-INF/Member/Member_Edit.jsp").forward(req, resp);		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO(getServletContext());
		MemberDTO dto = new MemberDTO();
		PrintWriter out= resp.getWriter();
		
		String username = (String) req.getSession().getAttribute("username");
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
		if(inter == null || inter.trim().isEmpty() ) {
			 out.println("<script>alert('관심사항을 선택하세요. -관리자 문의'); history.back();</script>");
		}
		String selfintroduce = req.getParameter("selfintroduce");
		if(selfintroduce == null || selfintroduce.trim().isEmpty() ) {
			 out.println("<script>alert('자기소개를 입력하세요. -관리자 문의'); history.back();</script>");
		}
		String password = req.getParameter("password");
		if(password == null || password.trim().isEmpty() 
				|| !password.matches("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*[!@#$%^&*()_-])[A-Za-z\\d!@#$%^&*()_-]{8,16}$")) {
			out.println("<script>alert('비밀번호를 확인하세요. -관리자 문의'); history.back();</script>");
		}
		String email = req.getParameter("email");
		if(email == null || email.trim().isEmpty() ) {
			out.println("<script>alert('이메일을 입력하세요. -관리자 문의'); history.back();</script>");
		}
		String name = req.getParameter("name");
		if(name == null || name.trim().isEmpty() ) {
			out.println("<script>alert('이름을 입력하세요. -관리자 문의'); history.back();</script>");
		}
		String education = req.getParameter("education");
		if(education == null || education.trim().isEmpty() ) {
			out.println("<script>alert('학력를 선택하세요. -관리자 문의'); history.back();</script>");
		}
		String gender = req.getParameter("gender");
		if(gender == null || gender.trim().isEmpty() ) {
			out.println("<script>alert('성별을 선택하세요. -관리자 문의'); history.back();</script>");
		}
		
		dto.setUsername(username);
		dto.setPassword(password);
		dto.setEmail(email);
		dto.setName(name);
		dto.setEducation(education);
		dto.setInters(inter);
		dto.setSelfintroduce(selfintroduce);
		dto.setGender(gender);
		
		int update = dao.update(dto);
		dao.close();
		
		
		if(update == 1 ) {
			resp.setContentType("text/html; charset=UTF-8");
			out.println("<script>");
			out.println("alert('수정 완료되었습니다!');");
			out.println("location.href='"+req.getContextPath() + "/Board/MyPage.kjh';");
			out.println("</script>");
			
		}
		else {
			resp.setContentType("text/html; charset=UTF-8");
			out.println("<script>alert('수정 실패했습니다.'); history.back();</script>");
		}		
		
	}

}
