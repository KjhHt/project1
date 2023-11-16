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

@WebServlet("/checkUsername.kjh")
public class IdCheckController extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//axios 데이터받기
		String jsonUserName = req.getReader().lines().collect(Collectors.joining());
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(jsonUserName);
		String username = jsonNode.get("data").asText();
		//쿼리결과반송
		MemberDAO dao = new MemberDAO(getServletContext());
		boolean isDuplication = dao.isDuplicationId(username);
		resp.getWriter().write(String.valueOf(isDuplication));
	}
}
