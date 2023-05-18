package com.ssafy.enjoytrip.model.user.dto;

import com.ssafy.enjoytrip.model.board.dto.FileInfo;
import lombok.Data;

@Data
public class User {
	private String id;
	private String pw;
	private String name;
	private String email;
	private String emailDomain;
	private String type;
	private FileInfo profile;

}
