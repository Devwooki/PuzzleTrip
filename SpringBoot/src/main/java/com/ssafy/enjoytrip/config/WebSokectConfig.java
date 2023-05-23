package com.ssafy.enjoytrip.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//stomp를 사용하기 위해 선언하는  어노테이션
@EnableWebSocketMessageBroker
@Configuration
public class WebSokectConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    // 클라이언트가 메시지를 구독할 endpoint를 정의합니다.
    public void configureMessageBroker(MessageBrokerRegistry config) {
        config.enableSimpleBroker("/send");
    }

    @Override
    // connection을 맺을때 CORS 허용합니다.
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/chat/**")
                // 스프링 5.3, 스프링부트 2.4 버전 부터 allowCredentials이 true인 경우 setAllowedOrigins 메서드에서
                // 와일드 카드 `'*'`을 사용하실 수 없습니다.
                //  	.setAllowedOrigins("*")
                .setAllowedOriginPatterns("http://localhost:8080", "http://192.168.212.62:8080/")
                .withSockJS();
    }

//    @Override
//    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        registry.addEndpoint("/stomp/chat") //websocket 핸드셰이크를 위한 endpoint 지정
//                .setAllowedOrigins("http://localhost:8080") //해당 url에 대해서 cors해제
//                .withSockJS();
//    }
//
//
//    @Override
//    public void configureMessageBroker(MessageBrokerRegistry registry) {//클라이언트가 메세지를 구독할 endpoint 지정
//        //애플리케이션 내부에서 사용할 path
//        // Client 에서 SEND 요청을 처리
//        //Spring docs 에서는 /topic, /queue로 나오나 편의상 /pub, /sub로 변경
//        registry.setApplicationDestinationPrefixes("/pub");
//        //해당 경로로 SimpleBroker를 등록.
//        // SimpleBroker는 해당하는 경로를 SUBSCRIBE하는 Client에게 메세지를 전달하는 간단한 작업을 수행
//        registry.enableSimpleBroker("/sub");
//        //enableStompBrokerRelay
//        //SimpleBroker의 기능과 외부 Message Broker( RabbitMQ, ActiveMQ 등 )에 메세지를 전달하는 기능을 가짐
//    }
}
