package com.ssafy.enjoytrip.model.user.service;


import com.ssafy.enjoytrip.model.user.dto.User;

public interface UserService {
	void join(User user) throws Exception;
	User getLogin(User user) throws Exception;
	User getUserInfo(String userId) throws Exception;
	void modifyUser(User user) throws Exception;
	void findPw(User user) throws Exception;
	void deleteUser(String userId) throws Exception;

	String idCheck(String id) throws Exception;
	User pwCheck(User user) throws Exception;

	void saveRefreshToken(String userId, String refreshToken) throws Exception;
	Object getRefreshToken(String userId) throws Exception;
	void deleRefreshToken(String userId) throws Exception;


}
