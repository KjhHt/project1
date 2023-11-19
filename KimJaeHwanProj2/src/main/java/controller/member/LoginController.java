package controller.member;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.JWTTokens;
import model.board.DAO.MemberDAO;
import model.board.DTO.MemberDTO;
@WebServlet(urlPatterns = "/Login.kjh")
public class LoginController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("login", "로그인페이지 입니다");
        req.getRequestDispatcher("/WEB-INF/Member/Login.jsp").forward(req, resp); 
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberDAO dao = new MemberDAO(getServletContext());
		
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		
		boolean loginCheck = dao.isMember(username, password);
		
		if(loginCheck) {
			//토큰생성
			Map<String,Object> payloads = new HashMap<>();
			payloads.put("username",username);
			long expirationTime = 1000 * 60 * 60 * 3;//3시간
			String token = JWTTokens.createToken(username, payloads, expirationTime);
			String cookieName = getServletContext().getInitParameter("COOKIE-NAME");
			Cookie cookie = new Cookie(cookieName, token);
			cookie.setPath(req.getContextPath());
			resp.addCookie(cookie);
			req.getSession().setAttribute("username", username);
			
			MemberDTO list = dao.selectOne(username);
			req.setAttribute("list", list);
			
			req.getRequestDispatcher("/WEB-INF/Member/Member_MyPage.jsp").forward(req, resp); 
		}else {
			req.setAttribute("ERROR", "등록된 회원아니에용");
			req.getRequestDispatcher("/WEB-INF/Member/Login.jsp").forward(req, resp); 
		}
		dao.close();
	}
	

}
