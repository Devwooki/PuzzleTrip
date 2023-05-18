package com.ssafy.enjoytrip.model.user.service;


import com.ssafy.enjoytrip.model.user.dto.User;
import com.ssafy.enjoytrip.model.user.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService{
	private UserMapper userMapper;

	public UserServiceImpl(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public void join(User user) throws Exception {
		userMapper.insertUser(user);
		userMapper.insertInitUserProfile(user);
	}
	@Override
	public User getLogin(User user) throws Exception {
		return userMapper.selectLogin(user);
	}

	@Override
	public User getUserInfo(String userId) throws Exception {
		return userMapper.selectUserInfo(userId);
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

	@Override
	public void saveRefreshToken(String userId, String refreshToken) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("userId", userId);
		map.put("token", refreshToken);
		userMapper.saveRefreshToken(map);
	}

	@Override
	public Object getRefreshToken(String userId) throws Exception {
		return userMapper.getRefreshToken(userId);
	}

	@Override
	public void deleRefreshToken(String userId) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userId);
		map.put("token", null);
		userMapper.deleteRefreshToken(map);
	}


}
