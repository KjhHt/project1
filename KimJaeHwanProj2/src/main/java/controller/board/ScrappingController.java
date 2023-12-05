package controller.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Vector;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.board.DTO.InterDTO;

@WebServlet("/Board/Scrapping.kjh")
public class ScrappingController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String subject = req.getParameter("interId");
		Document doc = null;
		PrintWriter out= resp.getWriter();
		if(subject.equals("politics")) {
			doc = Jsoup.connect("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%A0%95%EC%B9%98+%EA%B8%B0%EC%82%AC").get();
		}
		else if(subject.equals("economy")) {
			doc = Jsoup.connect("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EA%B2%BD%EC%A0%9C+%EA%B8%B0%EC%82%AC").get();
		}
		else if(subject.equals("entertainment")) {
			doc = Jsoup.connect("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%97%B0%EC%98%88+%EA%B8%B0%EC%82%AC").get();
		}
		else {
			out.println("<script>alert('에러발생! -관리자에게 문의하세요'); history.back();</script>");
		}
    	
    	Elements uls = doc.select("#main_pack > section.sc_new.sp_nnews._prs_nws_all > div > div.group_news > ul");
		
    	List<InterDTO> list = new Vector<InterDTO>();
    	Date currentDate = new Date();
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	String formattedDate = dateFormat.format(currentDate);
    	req.setAttribute("time", formattedDate);
    	
    	for (Element ul : uls) {
    		Elements newsTits = doc.select(".news_tit");
    		Elements newsDscs = doc.select(".news_dsc");
    		for(int i=0; i<newsTits.size();i++) {
    			InterDTO dto = new InterDTO();
                Element newsTit = newsTits.get(i);
                Element newsDsc = newsDscs.get(i);
                String description = newsDsc.text();
                int maxLength = Math.min(50, description.length());
                String truncatedDescription = description.substring(0, maxLength);
                dto.setTitle(newsTit.text());
                dto.setLink(newsTit.absUrl("href"));
                dto.setContent(truncatedDescription+"...");
                list.add(dto);
    		}
    	}
    	req.setAttribute("list", list);
    	
    	req.getRequestDispatcher("/WEB-INF/Member/Inters.jsp").forward(req, resp);
	}

}
