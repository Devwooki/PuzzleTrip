package com.ssafy.enjoytrip.model.user.service;


import com.ssafy.enjoytrip.model.board.dto.FileInfo;
import com.ssafy.enjoytrip.model.board.service.BoardService;
import com.ssafy.enjoytrip.model.user.dto.User;
import com.ssafy.enjoytrip.model.user.mapper.UserMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    private UserMapper userMapper;

	private final Logger logger = LoggerFactory.getLogger(UserService.class);
    @Value("${file.path}")
    private String uploadPath;

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
        //프로필 파일이 null이 아니면 업데이트
        if (user.getProfile() != null) {

            //서버에 저장된 기존 파일은 삭제
            FileInfo profile = userMapper.selectUserProfile(user.getId());
            if(profile != null){
                logger.debug("profile이 없음 {}",profile);
                String file = profile.getSaveFolder() + File.separator + profile.getSaveFile();
                Path filePath = Paths.get(file);
                if(Files.exists(filePath)){
                    try {
                        Files.delete(filePath);
                        logger.debug("{}삭제 완료", profile.getSaveFile());
                    } catch (Exception e) {
                        logger.debug("{}삭제 실패!!!!", profile.getSaveFile());
                        e.printStackTrace();
                    }
                }else{
                    logger.debug("{} 파일이 존재하지 않습니다.", profile.getSaveFile());

                }
            }
            //프로필 사진 업데이트. 사진은 controller에서 저장함.
            userMapper.updateUserProfile(user);
        }
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

	@Override
	public FileInfo getUserProfile(User user) throws Exception {
		return userMapper.selectUserProfile(user.getId());
	}


}
