package controller.board;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.PagingUtil;
import model.board.DAO.BoardDAO;
import model.board.DTO.BoardDTO;

@WebServlet(urlPatterns = "/Board/List.kjh",initParams = {@WebInitParam(name="BLOCK-PAGE",value="3"),@WebInitParam(name="PAGE-SIZE",value="5")})
public class ListController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO(getServletContext());
		Map map = new HashMap<>(); 
		if ("POST".equalsIgnoreCase(req.getMethod())) {
			InputStream is = req.getInputStream();
			ObjectMapper objectMapper = new ObjectMapper();
			Map jsonData = objectMapper.readValue(is, new TypeReference<Map>() {});
			req.getSession().setAttribute("pageSize", jsonData.get("data") );
		}
		PagingUtil.setMapForPaging(map, dao, req, this);
		int totalRecordCount = Integer.parseInt(map.get( PagingUtil.TOTAL_RECORD_COUNT).toString());
		int pageSize = Integer.parseInt( map.get( PagingUtil.PAGE_SIZE ).toString() );
		int blockPage = Integer.parseInt( map.get( PagingUtil.BLOCK_PAGE ).toString() );
		int nowPage = Integer.parseInt( map.get( PagingUtil.NOWPAGE ).toString() );
		int totalPage = Integer.parseInt( map.get( PagingUtil.TOTAL_PAGE ).toString() );
		
		String url = req.getContextPath()+"/Board/List.kjh?";
		if(req.getParameter("postDate")!=null || req.getParameter("searchColumn")!=null) {
			String postDate = req.getParameter("postDate");
			String searchColumn = req.getParameter("searchColumn");
			String searchWord = req.getParameter("searchWord");
			url = req.getContextPath()+"/Board/List.kjh?&postDate="+postDate
													+"&searchColumn="+searchColumn
													+"&searchWord="+searchWord+"&";
		}
		String pagingString=PagingUtil.pagingBootStrapStyle(totalRecordCount, pageSize, blockPage, nowPage,url);
		
		List<BoardDTO> list = dao.selectList(map);
		dao.close();
		req.setAttribute("list", list);
		req.setAttribute("paging", pagingString);
		req.getRequestDispatcher("/WEB-INF/Member/List.jsp").forward(req, resp);
	}
	
	

}
