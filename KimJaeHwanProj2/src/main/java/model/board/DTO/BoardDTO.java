package model.board.DTO;

import java.sql.Date;

public class BoardDTO {
	private String no;
	private String username;
	private String title;
	private String content;
	private String visitcount;
	private Date postdate;
	private String name;
	
	private String likecount;
	private String attachFile;
	private String commentCount;
	private String profile;
	
	public BoardDTO() {}
	
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public Date getPostdate() {
		return postdate;
	}
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLikecount() {
		return likecount;
	}

	public void setLikecount(String likecount) {
		this.likecount = likecount;
	}

	public String getAttachFile() {
		return attachFile;
	}

	public void setAttachFile(String attachFile) {
		this.attachFile = attachFile;
	}

	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	
}
