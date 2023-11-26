package model.board.DTO;

import java.sql.Date;

public class LikeDTO {
	private String lno;
	private String no;
	private String username;
	private Date likedate;
	
	public LikeDTO() {}

	public String getLno() {
		return lno;
	}

	public void setLno(String lno) {
		this.lno = lno;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getLikedate() {
		return likedate;
	}

	public void setLikedate(Date likedate) {
		this.likedate = likedate;
	}

	
	
	
}
