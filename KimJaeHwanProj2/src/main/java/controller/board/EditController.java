package controller.board;

import java.io.IOException;
import java.util.Arrays;
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

@WebServlet("/Board/Edit.kjh")
@MultipartConfig
public class EditController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String no = req.getParameter("no");
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO list = dao.selectOne(no);
		req.setAttribute("list", list);
		req.getRequestDispatcher("/WEB-INF/Member/Edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String no = req.getParameter("no");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String saveDirectory = getServletContext().getRealPath("/upload");
		String filename = req.getParameter("orginFileList").substring(0,req.getParameter("orginFileList").length()-1);
		BoardDAO dao = new BoardDAO(getServletContext());
		BoardDTO dto = new BoardDTO();
		dto.setNo(no);
		dto.setTitle(title);
		dto.setContent(content);	
		//파일관련
		Collection<Part> parts = req.getParts();
		List<Part> fileParts = parts.stream()
		        .filter(part -> part.getContentType() != null && "file".equals(part.getName()) && part.getSize() > 0)
		        .collect(Collectors.toList());
		if(fileParts.size()!=0 || !req.getParameter("updateFileList").isEmpty()) {
			//파일만 추가하는 경우 ( 기존db데이타 + 업데이트db데이타 )
			if(req.getParameter("updateFileList").isEmpty()) {
				filename = noOrginNewFile(parts,saveDirectory,req,filename);
			}
			//기존파일만 지우는 경우 ( 기존db수정만, )
			else if(fileParts.size()==0) {
				filename = newUpdateOrginNoFile(req,saveDirectory);
			}
			//기존파일도 지우고 + 파일추가 하는경우 ( 기존db수정 및 + 업데이트db데이타 )
			else {
				System.out.println("2개다 수정했을경우");
				
			}
		}
		dto.setAttachFile(filename);
		int result = dao.update(dto);
		dao.close();
		if(result==0) {
			System.out.println("수정실패");
		}
		resp.sendRedirect(req.getContextPath()+"/Board/View.kjh?no="+no);
	}


	//기존파일은 건들지않고 파일을 추가함
	private String noOrginNewFile(Collection<Part> parts, String saveDirectory, HttpServletRequest req, String orgin) {
		String filename = orgin;
		System.out.println("기존파일은 건들지않고 파일을 추가함");
		StringBuffer filenames = FileUtils.upload(parts, saveDirectory, req);
		System.out.println(filenames.toString());
		filename += ","+filenames.toString();
		return filename;
	}
	//기존파일을 수정하고 파일은 추가하지 않음
	private String newUpdateOrginNoFile(HttpServletRequest req, String saveDirectory) {
		System.out.println("기존파일을 수정하고 파일은 추가하지 않음");
		String filename;
		String[] updateFileList = req.getParameter("updateFileList").split(",");
		String[] orginFileList = req.getParameter("orginFileList").split(",");
		StringBuffer temp = new StringBuffer();
		for(String upValue : updateFileList) {
			for(String orValue : orginFileList) {
				if(upValue.equals(orValue)) {
					temp.append(upValue+",");
					System.out.println("안돌아??");
				}
			}
		}
		FileUtils.deletes(temp, saveDirectory, ",");
		filename = Arrays.stream(orginFileList)
                .filter(value -> !Arrays.asList(updateFileList).contains(value))
                .collect(Collectors.joining(", "));
		//내일 filename이 1개도없을때 어떻게 가는지 확인하고 X값넣어라
		return filename;
	}
	
	
	
	
}
