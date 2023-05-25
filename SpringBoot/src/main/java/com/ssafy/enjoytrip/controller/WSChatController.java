package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.model.WSChat.dto.WSChat;
import com.ssafy.enjoytrip.model.WSChat.service.ChatService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;

import java.util.List;

//
@Controller
@RequestMapping("/chat")
public class WSChatController {
    private Logger logger = LoggerFactory.getLogger(WSChatController.class);

    private ChatService service;

    @Autowired
    public WSChatController(ChatService service) {
        this.service = service;
    }

//    @MessageMapping("/receive") //receive메세지를 받을 endpoint로 지정
//    @SendTo("/send") //send로 메세지를 반환한다.
//    public WSChat wsChatHandler(WSChat chat){
//        logger.debug("받은 메세지 {} :",chat );
//        //걀론 receive에서 받아서 send로 전송한다.
//        return chat;
//    }


    @MessageMapping("/receive") //receive메세지를 받을 endpoint로 지정
    @SendTo("/send") //send로 메세지를 반환한다.
//    public List<WSChat> wsChatHandler(WSChat chat) throws Exception {
    public WSChat wsChatHandler(WSChat chat) throws Exception {
        logger.debug("받은 메세지 {} :",chat );
        //service.record(chat);
        //return service.getChatLog();
        return chat;
    }
}
