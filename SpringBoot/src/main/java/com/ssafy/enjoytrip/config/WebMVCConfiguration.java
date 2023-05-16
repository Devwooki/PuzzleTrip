package com.ssafy.enjoytrip.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.*;

import java.util.Arrays;
import java.util.List;

/*
Spring - MyBatis 설정
기존 myBatis와 달리
application.properties : myBatis설정 정보
    - Datasource : db정보 입력
    - type-Alias : dto 별청 지정
    - mapper-Location : sql문 작성
WebMVCConfiguration : Mapper(구 Dao) 정보를 가진 경로 설정
    - @MapperScan 어노테이션을 걸어주면 된다.
* */


@Configuration
@EnableWebMvc
public class WebMVCConfiguration implements WebMvcConfigurer {
    //SpringMVC구성 요소를 구성하고 커스터마이징하기 위한 인터페이스
    //@SpringBootApplication와 함께 사용함
    private Logger logeer = LoggerFactory.getLogger(WebMVCConfiguration.class);
    private final List<String> patterns = Arrays.asList("/board/*", "/admin");


//    @Override
//    public void addCorsMappings(CorsRegistry registry) {
//		System.out.println("CORS Setting");
//
//        registry.addMapping("/**")//API적용 범위 선택 -> 전체
//                .allowedOrigins("*")
//                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH", "HEAD")//혀용할 HTTP메소드 선택
//                .allowedHeaders("headers")//
//                .maxAge(1800);
//
//        //https://yeonyeon.tistory.com/257
//        //https://yeonyeon.tistory.com/236
//        //현재 preflight에러 발생
//        //브라우저가 한 번에 요청을 보내는 것이 아닌 예비요청/본요청으로 서버 전송하는 과정에서
//        //예비 요청이 preflight -> 이 요청이 안전한 것인가? 체크하는건데 문제 없다.
//        //예비요청 체크를 위해서는 Authorization 헤더가 필요하나 지금은 존재하지 않음
//
//
//    }

}
