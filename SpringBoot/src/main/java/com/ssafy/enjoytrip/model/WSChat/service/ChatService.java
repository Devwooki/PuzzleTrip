package com.ssafy.enjoytrip.model.WSChat.service;

import com.ssafy.enjoytrip.model.WSChat.dto.WSChat;

import java.util.List;

public interface ChatService {
    void record(WSChat wsChat) throws Exception;
    List<WSChat> getChatLog() throws Exception;

}
