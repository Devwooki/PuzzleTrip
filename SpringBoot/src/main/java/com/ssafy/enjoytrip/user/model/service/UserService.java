package com.ssafy.enjoytrip.user.model.service;


import com.ssafy.enjoytrip.user.model.dto.User;

import java.sql.SQLException;

public interface UserService {
	void join(User user) throws Exception;
	User getLogin(User user) throws Exception;
	void modifyUser(User user) throws Exception;
	void findPw(User user) throws Exception;
	void deleteUser(String userId) throws Exception;

	String idCheck(String id) throws Exception;
	User pwCheck(User user) throws Exception;
}
