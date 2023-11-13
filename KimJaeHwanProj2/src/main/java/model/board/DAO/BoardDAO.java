package model.board.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.sql.DataSource;

import jakarta.servlet.ServletContext;
import model.board.DTO.BoardDTO;
import service.DaoService;

public class BoardDAO implements DaoService<BoardDTO>{
	
	private Connection conn;
	private ResultSet rs;
	private PreparedStatement psmt;
	private static final String DATA_SOURCE = "DataSource";
	
	public BoardDAO(ServletContext context) {
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
	public List<BoardDTO> selectList(Map map) {
		List<BoardDTO> record = new Vector<>();
		String sql = "SELECT * FROM board ORDER BY NO DESC";
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNo(rs.getString(1));
				dto.setUsername(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setVisitcount(rs.getString(5));
				dto.setPostdate(rs.getDate(6));
				record.add(dto);
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		return record;
	}

	@Override
	public BoardDTO selectOne(String... params) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalRecordCount(Map map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(BoardDTO dto) {
		int affected=0;
		String sql="INSERT INTO board VALUES(SEQ_BOARD.NEXTVAL,?,?,?,DEFAULT,DEFAULT)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUsername());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());	
			affected=psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

	@Override
	public int update(BoardDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(BoardDTO dto) {
		// TODO Auto-generated method stub
		return 0;
	}

}
