package model.board.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.sql.DataSource;

import jakarta.servlet.ServletContext;
import model.board.PagingUtil;
import model.board.DTO.BoardDTO;
import model.board.DTO.CommentDTO;
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
		String sql ="	SELECT *"
				+ "		FROM ("
				+ "		  SELECT B.*,name,RANK() OVER (ORDER BY no DESC) AS no_rank ,"
				+ "       (SELECT COUNT(*) FROM likes WHERE no = B.no) AS likecount ,"
				+ "		  (SELECT COUNT(*) FROM commenttable WHERE no = B.no) AS commentcount "
				+ "		  FROM board B JOIN member M ON b.username = m.username WHERE 1=1";
		if(map.get("dateRange") != null) {
			sql += " AND "+map.get("dateRange") + " >= " + map.get("dateRangeResult") ;
		}
		if(map.get("searchColumn") != null) {
			sql += " AND "+map.get("searchColumn") + " LIKE '%"+map.get("searchWord")+"%' ";
		}
		sql+= ") WHERE no_rank BETWEEN ? AND ? ";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, map.get(PagingUtil.START).toString() );
			psmt.setString(2, map.get(PagingUtil.END).toString() );
			rs = psmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNo(rs.getString(1));
				dto.setUsername(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setVisitcount(rs.getString(5));
				dto.setPostdate(rs.getDate(6));
				dto.setAttachFile(rs.getString(7));
				dto.setName(rs.getString(8));
				dto.setLikecount(rs.getString(10));
				dto.setCommentCount(rs.getString(11));
				record.add(dto);
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		return record;
	}

	@Override
	public BoardDTO selectOne(String... params) {
		BoardDTO dto = null;
		try {
			if(params.length >= 2 && (params[1].toUpperCase().startsWith("LIST"))) {
				psmt = conn.prepareStatement("UPDATE board SET visitcount=visitcount+1 WHERE no=?");
				psmt.setString(1, params[0]);
				psmt.executeUpdate();
			}
			String sql = "SELECT b.*,name "
					+ "FROM board b JOIN member m ON b.username=m.username "
					+ "WHERE no=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, params[0]);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto = new BoardDTO();
				dto.setNo(rs.getString(1));
				dto.setUsername(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setVisitcount(rs.getString(5));
				dto.setPostdate(rs.getDate(6));
				dto.setAttachFile(rs.getString(7));
				dto.setName(rs.getString(8));
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		return dto;
	}

	@Override
	public int getTotalRecordCount(Map map) {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM board b JOIN member m ON b.username=m.username WHERE 1=1";
		if(map.get("dateRange") != null) {
			sql += " AND "+map.get("dateRange") + " >= " + map.get("dateRangeResult") ;
		}
		if(map.get("searchColumn") != null) {
			sql += " AND "+map.get("searchColumn") + " LIKE '%"+map.get("searchWord")+"%' ";
		}
		try {
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(SQLException e) {e.printStackTrace();}
		
		return totalCount;
	}

	@Override
	public int insert(BoardDTO dto) {
		int affected=0;
		String sql="INSERT INTO board VALUES(SEQ_BOARD.NEXTVAL,?,?,?,DEFAULT,DEFAULT,?)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getUsername());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());	
			psmt.setString(4, dto.getAttachFile());	
			affected=psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

	@Override
	public int update(BoardDTO dto) {
		int affected = 0;
		String sql = "UPDATE board SET title=?,content=? WHERE no=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getNo());
			affected = psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}
		
		return affected;
	}

	@Override
	public int delete(BoardDTO dto) {
		int affected=0;
		String sql="DELETE board WHERE no = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNo());	
			
			affected=psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

	public int likeCount(String no) {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM likes WHERE no = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,no);
			rs = psmt.executeQuery();
			if (rs.next()) {
			    totalCount = rs.getInt(1);
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		return totalCount;
	}

	public List<CommentDTO> firstCommentList(String no) {
		List<CommentDTO> flist = new Vector<>();
		String sql = " SELECT c.*,name "
				   + " FROM member m JOIN commenttable c ON m.username = c.username "
				   + " WHERE no = ? "
				   + " AND replaywhether = 'F' "
				   + " ORDER BY commentdate ";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,no);	
			rs = psmt.executeQuery();	
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setCno(rs.getString(1));
				dto.setNo(rs.getString(2));
				dto.setUsername(rs.getString(3));
				dto.setCommentcontent(rs.getString(4));
				dto.setCommentdate(rs.getDate(5));
				dto.setReplaywhether(rs.getString(6));
				dto.setSubcomment(rs.getString(7));
				dto.setSubname(rs.getString(8));
				dto.setName(rs.getString(9));
				flist.add(dto);
			}			
		}
		catch(SQLException e) {e.printStackTrace();}
		return flist;
	}

	public List<CommentDTO> secondCommentList(String no) {
		List<CommentDTO> slist = new Vector<>();
		String sql = " SELECT c.*,name "
				   + " FROM member m JOIN commenttable c ON m.username = c.username "
				   + " WHERE no = ? "
				   + " AND replaywhether = 'Y' ";	
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,no);
			rs = psmt.executeQuery();	
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setCno(rs.getString(1));
				dto.setNo(rs.getString(2));
				dto.setUsername(rs.getString(3));
				dto.setCommentcontent(rs.getString(4));
				dto.setCommentdate(rs.getDate(5));
				dto.setReplaywhether(rs.getString(6));
				dto.setSubcomment(rs.getString(7));
				dto.setSubname(rs.getString(8));
				dto.setName(rs.getString(9));
				slist.add(dto);
			}			
		}
		catch(SQLException e) {e.printStackTrace();}
		return slist;
	}

	public List<CommentDTO> commentCnoEqualSub(String cno) {
	    List<CommentDTO> resultList = new ArrayList<>();
	    String sql = "SELECT b.*, name " +
	                 "FROM COMMENTTABLE a " +
	                 "JOIN COMMENTTABLE b ON a.cno = b.subcomment " +
	                 "JOIN member m ON m.username = b.username " +
	                 "WHERE b.subcomment = ? " +
	                 "ORDER BY b.subcomment, b.commentdate ASC";
		    try {
		        psmt = conn.prepareStatement(sql);
		        psmt.setString(1, cno);
		        rs = psmt.executeQuery();
	
		        while (rs.next()) {
		            CommentDTO dto = new CommentDTO();
		            dto.setCno(rs.getString(1));
		            dto.setNo(rs.getString(2));
		            dto.setUsername(rs.getString(3));
		            dto.setCommentcontent(rs.getString(4));
		            dto.setCommentdate(rs.getDate(5));
		            dto.setReplaywhether(rs.getString(6));
		            dto.setSubcomment(rs.getString(7));
					dto.setSubname(rs.getString(8));
					dto.setName(rs.getString(9));
		            resultList.add(dto);
		        }
		    } 
		    catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return resultList;
		}

	public int insertComment(CommentDTO dto) {
		int affected=0;
		String sql="INSERT INTO commenttable VALUES(SEQ_comment.NEXTVAL,?,?,?,DEFAULT,DEFAULT,0,DEFAULT)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNo());
			psmt.setString(2, dto.getUsername());
			psmt.setString(3, dto.getCommentcontent());	
			affected=psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

	public int insertSubComment(CommentDTO dto) {
		int affected=0;
		String sql="INSERT INTO commenttable VALUES(SEQ_comment.NEXTVAL,?,?,?,DEFAULT,?,?,?)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getNo());
			psmt.setString(2, dto.getUsername());
			psmt.setString(3, dto.getCommentcontent());	
			psmt.setString(4, dto.getReplaywhether());	
			psmt.setString(5, dto.getCno());	
			psmt.setString(6, dto.getSubname());	
			affected=psmt.executeUpdate();
		}
		catch(SQLException e) {e.printStackTrace();}		
		return affected;
	}

	public boolean likeCountUp(String no, String username) {
		boolean affected=false;
		String sql="INSERT INTO likes VALUES(SEQ_likes.NEXTVAL,?,?,DEFAULT)";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, no);
			psmt.setString(2, username);	
			psmt.executeUpdate();
			affected = true;
		}
		catch(SQLException e) {
			e.printStackTrace();
			affected = false;
		}	
		return affected;
	}

	public boolean likeCountDown(String no, String username) {
		boolean affected=false;
		String sql="DELETE likes WHERE no=? AND username=?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, no);
			psmt.setString(2, username);	
			psmt.executeUpdate();
			affected = true;
		}
		catch(SQLException e) {
			e.printStackTrace();
			affected = false;
		}	
		return affected;
	}

	public int isLike(String no, String username) {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM likes WHERE no = ? AND username = ?";
		try {
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,no);
			psmt.setString(2,username);
			rs = psmt.executeQuery();
			if (rs.next()) {
			    totalCount = rs.getInt(1);
			}
		}
		catch(SQLException e) {e.printStackTrace();}
		return totalCount;
	}

}
