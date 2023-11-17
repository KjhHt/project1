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
		if(username == null || username.trim().isEmpty() || !username.matches("^[a-z0-9_-]{5,20}$")) {
			 out.println("<script>alert('아이디를 확인하세요. -관리자 문의'); history.back();</script>");
		}
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
		//if(이메일 유효성)
		String email = req.getParameter("email");
		
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
