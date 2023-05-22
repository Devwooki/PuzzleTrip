package com.ssafy.enjoytrip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;

@Controller
@RequestMapping("/chat")
public class WSChatController {

    //receive메세지를 받을 endpoint로 지정
    @MessageMapping("/receive")

}
