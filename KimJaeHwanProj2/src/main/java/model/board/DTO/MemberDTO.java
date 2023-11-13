package model.board.DTO;

import java.sql.Date;

public class MemberDTO {
	private String username;
	private String password;
	private String gender;
	private String inters;
	private String education;
	private String selfintroduce;
	private Date regidate;
	
	public MemberDTO() {}
	
	public MemberDTO(String username, String password, String gender, String inters, String education,
			String selfintroduce, Date regidate) {
		this.username = username;
		this.password = password;
		this.gender = gender;
		this.inters = inters;
		this.education = education;
		this.selfintroduce = selfintroduce;
		this.regidate = regidate;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getInters() {
		return inters;
	}

	public void setInters(String inters) {
		this.inters = inters;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getSelfintroduce() {
		return selfintroduce;
	}

	public void setSelfintroduce(String selfintroduce) {
		this.selfintroduce = selfintroduce;
	}

	public Date getRegidate() {
		return regidate;
	}

	public void setRegidate(Date regidate) {
		this.regidate = regidate;
	}
	
	
	
}
