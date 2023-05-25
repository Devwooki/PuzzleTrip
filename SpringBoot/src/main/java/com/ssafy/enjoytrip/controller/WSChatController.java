package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.model.WSChat.dto.WSChat;
import com.ssafy.enjoytrip.model.WSChat.service.ChatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/chat")
public class WSChatController {
    private Logger logger = LoggerFactory.getLogger(WSChatController.class);

    private ChatService service;

    @Autowired
    public WSChatController(ChatService service) {
        this.service = service;
    }

    @MessageMapping("/receive") //receive메세지를 받을 endpoint로 지정
    @SendTo("/send") //send로 메세지를 반환한다.
    private List<WSChat> wsChatHandler(WSChat chat) throws Exception {
    //public WSChat wsChatHandler(WSChat chat) throws Exception {
        logger.debug("받은 메세지 {} :",chat );
        try{
            service.record(chat);
        }catch(Exception e){
            e.printStackTrace();
        }

        return service.getChatLog();
        //return chat;
    }

    @GetMapping("init")
    @ResponseBody
    public List<WSChat> initChatting() throws Exception {
        logger.debug("채팅방 초기 데이터 호출");


        return service.getChatLog();
    }
}
