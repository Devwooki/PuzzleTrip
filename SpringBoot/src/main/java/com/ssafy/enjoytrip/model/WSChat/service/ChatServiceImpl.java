package com.ssafy.enjoytrip.model.WSChat.service;

import com.ssafy.enjoytrip.model.WSChat.dto.WSChat;
import com.ssafy.enjoytrip.model.WSChat.mapper.ChatMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatServiceImpl implements ChatService{
    @Autowired
    private ChatMapper mapper;
    private Logger logger = LoggerFactory.getLogger(ChatServiceImpl.class);
    @Override
    public void record(WSChat wsChat) throws Exception {
        logger.debug("채팅 기록 : {}", wsChat );
        mapper.insertChat(wsChat);
        logger.debug("기록완료" );
    }

    @Override
    public List<WSChat> getChatLog() throws Exception {
        logger.debug("최근 200개 채팅 기록 반환");
        return mapper.selectLastChatLog();
    }
}
