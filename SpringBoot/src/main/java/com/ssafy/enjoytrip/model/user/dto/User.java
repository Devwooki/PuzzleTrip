package com.ssafy.enjoytrip.model.user.dto;

public class User {
	private String id;
	private String pw;
	private String name;
	private String email;
	private String emailDomain;
	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getEmailDomain() {
		return emailDomain;
	}
	public void setEmailDomain(String emailDomain) {
		this.emailDomain = emailDomain;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public String toString() {
		return "User{" +
				"id='" + id + '\'' +
				", pw='" + pw + '\'' +
				", name='" + name + '\'' +
				", email='" + email + '\'' +
				", emailDomain='" + emailDomain + '\'' +
				", type='" + type + '\'' +
				'}';
	}
}
