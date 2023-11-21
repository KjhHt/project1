package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.JWTTokens;

import java.io.IOException;
import java.io.PrintWriter;

@WebFilter("/Board/*")
public class LoginCheckFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
		String token = JWTTokens.getToken(req, req.getServletContext().getInitParameter("COOKIE-NAME"));
		boolean isAuthenticated = JWTTokens.verifyToken(token);
		if(!isAuthenticated) {
			HttpServletResponse resp=(HttpServletResponse)response;
			resp.setContentType("text/html; charset=UTF-8");
			PrintWriter out= resp.getWriter();
			out.println("<script>");
			out.println("alert('유효하지 않는 접근방법입니다 로그인 먼저 부탁드려요!')");
			out.println("location.replace('"+req.getContextPath()+"/')");
			out.println("</script>");
			return;
		}
		chain.doFilter(request, response);
    }


    
    

}