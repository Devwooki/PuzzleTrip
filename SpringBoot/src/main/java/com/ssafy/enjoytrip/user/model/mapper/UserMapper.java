package com.ssafy.enjoytrip.user.model.mapper;


import com.ssafy.enjoytrip.user.model.dto.User;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
@Mapper
public interface UserMapper {
	void insertUser(User user) throws SQLException;
	User selectLogin(User user) throws SQLException;
	String selectIdCheck(String id) throws SQLException;
	void updateUser(User user) throws SQLException;
	void deleteUser(String userId) throws SQLException;
	void updateUserPw(User user) throws SQLException;

}
