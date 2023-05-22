package com.ssafy.enjoytrip.config;

import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//stomp를 사용하기 위해 선언하는  어노테이션
@EnableWebSocketMessageBroker
public class WebSokectConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
         registry.addEndpoint("/stomp/chat")
                 .setAllowedOrigins("http://localhost:8989")
                 .withSockJS();
    }

    //애플리케이션 내부에서 사용할 path
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // Client 에서 SEND 요청을 처리
        //Spring docs 에서는 /topic, /queue로 나오나 편의상 /pub, /sub로 변경
        registry.setApplicationDestinationPrefixes("/pub");
        //해당 경로로 SimpleBroker를 등록.
        // SimpleBroker는 해당하는 경로를 SUBSCRIBE하는 Client에게 메세지를 전달하는 간단한 작업을 수행
        registry.enableSimpleBroker("/sub");
        //enableStompBrokerRelay
        //SimpleBroker의 기능과 외부 Message Broker( RabbitMQ, ActiveMQ 등 )에 메세지를 전달하는 기능을 가짐
    }
