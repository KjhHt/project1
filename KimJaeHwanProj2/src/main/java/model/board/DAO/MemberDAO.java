package model.board.DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.sql.DataSource;

import jakarta.servlet.ServletContext;
import model.board.DTO.BoardDTO;
import model.board.DTO.MemberDTO;
import service.DaoService;

public class MemberDAO implements DaoService<MemberDTO>{

	private Connection conn;
	private ResultSet rs;
	private PreparedStatement psmt;
	private static final String DATA_SOURCE = "DataSource";
	
	//생성자
	public MemberDAO(ServletContext context) {
		try {
			//커넥션 풀 사용.즉 커넥션 풀에서 커넥션 객체 가져오기
			//(리스너에서 컨텍스트 영역에 저장한 데이타소스 가져오기)
			DataSource source = (DataSource)context.getAttribute(DATA_SOURCE);
			conn = source.getConnection();
		}
		catch(Exception e) { e.printStackTrace();}
	}///////////
	
	@Override
	public void close() {
		try {
			if(rs != null) rs.close();
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		}
		catch(SQLException e) {}
	}

	@Override
	public List<MemberDTO> selectList(Map map) {

		return null;
	}

	@Override
	public MemberDTO selectOne(String... params) {
		
		return null;
	}

	@Override
	public int getTotalRecordCount(Map map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(MemberDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(MemberDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(MemberDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public boolean isMember(String username,String password) {
		String sql = "SELECT COUNT(*) "
					+ "FROM member "
					+ "WHERE username=?"
					+ "AND password=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, username);
			psmt.setString(2, password);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) return false;
		}
		catch(SQLException e) {e.printStackTrace(); return false;}
		return true;
	}

}
