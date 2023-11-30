package controller.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DAO.BoardDAO;

@WebServlet("/Board/deleteComment.kjh")
public class DeleteCommentController extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> jsonResponse = new HashMap<>();
        Map<String, Object> jsonMap = objectMapper.readValue(req.getReader(), new TypeReference<Map<String, Object>>() {});
        String cno = (String) jsonMap.get("dataCno");
        BoardDAO dao = new BoardDAO(getServletContext());
        int result = dao.commentDelete(cno);
        if(result==1) {
        	sendResult(resp,"성공했어요");
        }
        else {
        	sendResult(resp,"실패했어요");       	
        }
        dao.close();
	}
	
    private void sendResult(HttpServletResponse resp, String result) throws IOException {
        // JSON 응답을 생성
    	String jsonResponse = "{\"success\":\"" + result + "\"}";
        // JSON 형태의 응답을 클라이언트에 전송
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(jsonResponse);
    }
}
