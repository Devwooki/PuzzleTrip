package com.ssafy.enjoytrip.config;

import com.ssafy.enjoytrip.interceptor.JWTInterceptor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
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
    private final List<String> jwtExclude = Arrays.asList("/user/**","/attraction/**", "/board/**", "/comment/**", "/file/**");
    //제외할 하위 모든 경로는 /**, 제외할 첫 번째 하위경로는 /* 주의
    private final List<String> jwtCheck = Arrays.asList("/board/*", "/admin");

    @Autowired
    private JWTInterceptor jwtInterceptor;
    //여행지 작성, 저장
    //게시판, 댓글, 수정, 삭제
    //유저 정보 수정

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(jwtInterceptor)
                .addPathPatterns("/**")//인터셉터가 적용될 경로 /**하면 모든 경로에 적용된다.
                .excludePathPatterns(jwtExclude);//인터셉터가 적용되지 않을 경로
}


    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")//모든 url경로에 대해 cors 설정 적용
                .allowedOrigins("*")//모든 도메인으로 부터 접속을 허용한다.
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS", "PATCH", "HEAD")//혀용할 HTTP메소드 선택
                .allowedHeaders("*")//모든 헤더에 대해서 허용
                .maxAge(1800);

        //https://yeonyeon.tistory.com/257
        //https://yeonyeon.tistory.com/236
        //현재 preflight에러 발생
        //브라우저가 한 번에 요청을 보내는 것이 아닌 예비요청/본요청으로 서버 전송하는 과정에서
        //예비 요청이 preflight -> 이 요청이 안전한 것인가? 체크하는건데 문제 없다.
        //예비요청 체크를 위해서는 Authorization 헤더가 필요하나 지금은 존재하지 않음


    }

}
