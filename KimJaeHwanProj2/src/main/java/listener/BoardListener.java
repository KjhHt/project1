package listener;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import model.board.DAO.JWTTokens;

@WebListener
public class BoardListener implements ServletContextListener{

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		System.out.println("커넥션 풀 연결시도");
		try {
			Context ctx = new InitialContext();
			DataSource source = (DataSource)ctx.lookup(sce.getServletContext().getInitParameter("JNDI-ROOT")+"/ict");
			sce.getServletContext().setAttribute("DataSource", source);
			System.out.println("OK");
		}
		catch(Exception e) {e.printStackTrace();}
	}
	

	
	
}
