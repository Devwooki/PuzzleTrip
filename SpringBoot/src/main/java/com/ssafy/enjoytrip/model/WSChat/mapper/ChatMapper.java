package com.ssafy.enjoytrip.model.WSChat.mapper;

import com.ssafy.enjoytrip.model.WSChat.dto.WSChat;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;

@Mapper
public interface ChatMapper {
    void insertChat(WSChat wsChat) throws SQLException;

    List<WSChat> selectLastChatLog() throws SQLException;
}
