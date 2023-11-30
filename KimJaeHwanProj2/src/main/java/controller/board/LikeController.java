package controller.board;

import java.io.IOException;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;
import model.board.DTO.LikeDTO;

@WebServlet("/Board/Like.kjh")
public class LikeController extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> jsonMap = objectMapper.readValue(req.getReader(), new TypeReference<Map<String, Object>>() {});
        String no = (String) jsonMap.get("no");
        String data = (String) jsonMap.get("data");
        String username = (String) req.getSession().getAttribute("username");
        BoardDAO dao = new BoardDAO(getServletContext());
		if(data.equals("UP")) {
			boolean  insertResult = dao.likeCountUp(no,username);
			if(!insertResult) {
				System.out.println("수정실패");
			}
			sendResult(resp, insertResult);
		}
		if(data.equals("DOWN")) {
			boolean  deleteResult = dao.likeCountDown(no,username);
			if(!deleteResult) {
				System.out.println("삭제실패");
			}
			sendResult(resp, deleteResult);
		}
		dao.close();
	}
	
    private void sendResult(HttpServletResponse resp, boolean result) throws IOException {
        // JSON 응답을 생성
        String jsonResponse = "{\"success\":" + result + "}";
        // JSON 형태의 응답을 클라이언트에 전송
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonResponse);
    }
    
    
}
