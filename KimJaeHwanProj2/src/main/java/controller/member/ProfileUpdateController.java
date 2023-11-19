package controller.member;

import java.io.IOException;
import java.util.stream.Collectors;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.MemberDAO;

@WebServlet("/Board/ProfileUpdate.kjh")
public class ProfileUpdateController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet방식");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = (String) req.getSession().getAttribute("username");
		//axios 데이터받기
		String selectValue = req.getReader().lines().collect(Collectors.joining());
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(selectValue);
		String profile = jsonNode.get("data").asText();
		
		MemberDAO dao = new MemberDAO(getServletContext());
		int result = dao.updateProfile(username,profile);
		dao.close();
		resp.getWriter().write(result);
//		//쿼리결과반송
//		MemberDAO dao = new MemberDAO(getServletContext());
//		boolean isDuplication = dao.isDuplicationId(profile);
//		resp.getWriter().write(String.valueOf(isDuplication));
	}
	
}
