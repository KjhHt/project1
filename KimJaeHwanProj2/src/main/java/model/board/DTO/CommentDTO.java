package model.board.DTO;

import java.sql.Date;

public class CommentDTO {
	private String cno;
	private String no;
	private String username;
	private String commentcontent;
	private Date commentdate;
	private String name;
	private String count;
	private String replaywhether;
	private String subcomment;
	private String subname;
	
	public CommentDTO() {}
	
	public String getCno() {
		return cno;
	}
	public void setCno(String cno) {
		this.cno = cno;
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
	public String getCommentcontent() {
		return commentcontent;
	}
	public void setCommentcontent(String commentcontent) {
		this.commentcontent = commentcontent;
	}
	public Date getCommentdate() {
		return commentdate;
	}
	public void setCommentdate(Date commentdate) {
		this.commentdate = commentdate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getReplaywhether() {
		return replaywhether;
	}

	public void setReplaywhether(String replaywhether) {
		this.replaywhether = replaywhether;
	}

	public String getSubcomment() {
		return subcomment;
	}

	public void setSubcomment(String subcomment) {
		this.subcomment = subcomment;
	}

	public String getSubname() {
		return subname;
	}

	public void setSubname(String subname) {
		this.subname = subname;
	}
	
	
}
