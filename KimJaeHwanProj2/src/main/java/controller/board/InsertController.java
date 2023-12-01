package controller.board;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.board.FileUtils;
import model.board.DAO.BoardDAO;
import model.board.DTO.BoardDTO;

@WebServlet(urlPatterns = "/Board/Insert.kjh")
@MultipartConfig
public class InsertController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/Member/Insert.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost( HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String username = (String) req.getSession().getAttribute("username");		
		//파일
		String saveDirectory = getServletContext().getRealPath("/upload");
		String filename;
		Collection<Part> parts = req.getParts();
		List<Part> fileParts = parts.stream()
		        .filter(part -> part.getContentType() != null && "file".equals(part.getName()))
		        .collect(Collectors.toList());
		
		StringBuffer filenames = FileUtils.upload(parts, saveDirectory, req);
		if(filenames == null) 
			filename = "X";
		else 
			filename = filenames.toString();
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO dto = new BoardDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setUsername(username);
		System.out.println("insert 여기야"+filename);
		dto.setAttachFile(filename);
		int result = dao.insert(dto);
		dao.close();
		if(result==0) {
			FileUtils.deletes(filenames, saveDirectory, ",");
			System.out.println("입력실패");
		}
		resp.sendRedirect(req.getContextPath()+"/Board/List.kjh");
		
	}
	
}
