package com.ssafy.enjoytrip.model.user.mapper;


import com.ssafy.enjoytrip.model.user.dto.User;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.Map;

@Mapper
public interface UserMapper {
	void insertUser(User user) throws SQLException;
	User selectLogin(User user) throws SQLException;
	User selectUserInfo(String userId) throws SQLException;
	String selectIdCheck(String id) throws SQLException;
	void updateUser(User user) throws SQLException;
	void deleteUser(String userId) throws SQLException;
	void updateUserPw(User user) throws SQLException;

	void saveRefreshToken(Map<String, String> map) throws SQLException;
	Object getRefreshToken(String userId) throws SQLException;
	void deleteRefreshToken(Map<String, String> map) throws SQLException;


    void insertInitUserProfile(User user) throws SQLException;
}
