package com.ssafy.enjoytrip.user.model.service;


import com.ssafy.enjoytrip.user.model.dto.User;
import com.ssafy.enjoytrip.user.model.mapper.UserMapper;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
	private UserMapper userMapper;

	public UserServiceImpl(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public void join(User user) throws Exception {
		userMapper.insertUser(user);
	}
	@Override
	public User getLogin(User user) throws Exception {
		return userMapper.selectLogin(user);
	}
	@Override
	public void modifyUser(User user) throws Exception {
		userMapper.updateUser(user);
	}
	@Override
	public void deleteUser(String userId) throws Exception {
		userMapper.deleteUser(userId);
	}
	@Override
	public void findPw(User user) throws Exception {
		userMapper.updateUserPw(user);
	}
	@Override
	public String idCheck(String id) throws Exception {
		return userMapper.selectIdCheck(id);
	}

	@Override
	public User pwCheck(User user) throws Exception {
		return userMapper.selectLogin(user);
	}


}
