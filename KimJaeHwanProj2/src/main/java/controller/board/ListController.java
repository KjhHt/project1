package controller.board;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		if(req.getParameter("postDate")!= null && req.getParameter("postDate").length()!=0) {
			String postDate = req.getParameter("postDate");
			String dateRange = "TO_DATE(postdate, 'YY/MM/DD')";
			String dateRangeResult="";
			switch(postDate) {
				case "day": dateRangeResult = "TRUNC(SYSDATE) - 1"; break;
				case "week": dateRangeResult = "TRUNC(SYSDATE) - 7"; break;
				case "oneMonth": dateRangeResult = "TRUNC(SYSDATE, 'MM') - 1"; break;
				case "sixMonth": dateRangeResult = "TRUNC(SYSDATE, 'MM') - 6"; break;
				case "year": dateRangeResult = "TRUNC(SYSDATE, 'YYYY') - 1"; break;
			}
			map.put("dateRange",dateRange);
			map.put("dateRangeResult",dateRangeResult);
			
		}
		if(req.getParameter("searchColumn")!= null) {
			String searchColumn = req.getParameter("searchColumn");
			String searchWord = req.getParameter("searchWord");
			map.put("searchColumn", searchColumn);
			map.put("searchWord", searchWord);
		}
		PagingUtil.setMapForPaging(map, dao, req, this);
		int totalRecordCount = Integer.parseInt(map.get( PagingUtil.TOTAL_RECORD_COUNT).toString());
		int pageSize = Integer.parseInt( map.get( PagingUtil.PAGE_SIZE ).toString() );
		int blockPage = Integer.parseInt( map.get( PagingUtil.BLOCK_PAGE ).toString() );
		int nowPage = Integer.parseInt( map.get( PagingUtil.NOWPAGE ).toString() );
		int totalPage = Integer.parseInt( map.get( PagingUtil.TOTAL_PAGE ).toString() );
		
		String pagingString=PagingUtil.pagingBootStrapStyle(totalRecordCount, pageSize, blockPage, nowPage,req.getContextPath()+"/Board/List.kjh?");
		
		List<BoardDTO> list = dao.selectList(map);
		dao.close();
		req.setAttribute("list", list);
		req.setAttribute("paging", pagingString);
		req.getRequestDispatcher("/WEB-INF/Member/List.jsp").forward(req, resp);
	}
	
	

}
