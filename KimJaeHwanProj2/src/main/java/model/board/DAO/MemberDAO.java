package model.board.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import jakarta.servlet.ServletContext;
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
		MemberDTO dto= null;
		String sql = "SELECT * FROM member WHERE username =?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, params[0]);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setUsername(rs.getString(1));
				dto.setPassword(rs.getString(2));
				dto.setGender(rs.getString(3));
				dto.setInters(rs.getString(4));
				dto.setEducation(rs.getString(5));
				dto.setSelfintroduce(rs.getString(6));
				dto.setRegidate(rs.getDate(7));
				dto.setEmail(rs.getString(8));
				dto.setName(rs.getString(9));
				dto.setProfile(rs.getString(10));
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		
		return dto;
	}

	@Override
	public int getTotalRecordCount(Map map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insert(MemberDTO dto) {
		int affected = 0;
		String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,SYSDATE,?,?,DEFAULT)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUsername());
			psmt.setString(2, dto.getPassword());
			psmt.setString(3, dto.getGender());
			psmt.setString(4, dto.getInters());
			psmt.setString(5, dto.getEducation());
			psmt.setString(6, dto.getSelfintroduce());
			psmt.setString(7, dto.getEmail());
			psmt.setString(8, dto.getName());
			affected = psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}
		return affected;
	}

	@Override
	public int update(MemberDTO dto) {
		int affected = 0;
		String sql = "UPDATE member SET password=?,gender=?,inters=?,education=?,selfintroduce=?,email=?,name=? WHERE username = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getPassword());
			psmt.setString(2, dto.getGender());
			psmt.setString(3, dto.getInters());
			psmt.setString(4, dto.getEducation());
			psmt.setString(5, dto.getSelfintroduce());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getName());
			psmt.setString(8, dto.getUsername());
			affected = psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

	@Override
	public int delete(MemberDTO dto) {
		int affected = 0;
		/* 모든 자식 레코드 삭제*/
		String likesSql = "DELETE likes WHERE username = ?";
		String commentSql = "DELETE commenttable WHERE username = ?";
		String boardSql = "DELETE board WHERE username = ?";
		String sql = "DELETE member WHERE username = ?";
		
		try {
			//좋아요 username 모두 삭제
			psmt = conn.prepareStatement(likesSql);
			psmt.setString(1, dto.getUsername());
			affected = psmt.executeUpdate();
			//댓글 username 모두 삭제
			psmt = conn.prepareStatement(commentSql);
			psmt.setString(1, dto.getUsername());
			affected = psmt.executeUpdate();
			//게시판 username 모두 삭제
			psmt = conn.prepareStatement(boardSql);
			psmt.setString(1, dto.getUsername());
			affected = psmt.executeUpdate();
			//마지막 회원 삭제 <-
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUsername());
			affected = psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
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
	
	public boolean isDuplicationId(String username) {
		String sql = "SELECT COUNT(*) "
				   + "FROM member "
				   + "WHERE username = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, username);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) return false;
		}
		catch(SQLException e) {e.printStackTrace(); return false;}
		return true;
	}

	public int updateProfile(String username, String profile) {
		int affected = 0;
		String sql  = "UPDATE member "
					+ "SET profile = ? "
					+ "WHERE username = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, profile);
			psmt.setString(2, username);
			affected = psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

}
