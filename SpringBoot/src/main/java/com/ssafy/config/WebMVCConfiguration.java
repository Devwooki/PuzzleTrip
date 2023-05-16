package com.ssafy.config;

import com.ssafy.interceptor.ConfirmInterceptor;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

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
@MapperScan(basePackages = {"com.ssafy.enjoytrip.**.mapper"})
public class WebMVCConfiguration implements WebMvcConfigurer {
    //SpringMVC구성 요소를 구성하고 커스터마이징하기 위한 인터페이스
    //@SpringBootApplication와 함께 사용함

    private final List<String> patterns = Arrays.asList("/board/*", "/admin");

    //인터셉터를 사용하기 위한 객체 생성
    private ConfirmInterceptor confirmInterceptor;

    @Autowired //생성자 정의
    public WebMVCConfiguration(ConfirmInterceptor confirmInterceptor) {
        super();
        this.confirmInterceptor = confirmInterceptor;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        WebMvcConfigurer.super.addResourceHandlers(registry);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(confirmInterceptor).addPathPatterns(patterns);
    }

}
