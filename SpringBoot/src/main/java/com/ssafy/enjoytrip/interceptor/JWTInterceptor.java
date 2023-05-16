package com.ssafy.enjoytrip.interceptor;

import com.ssafy.enjoytrip.exception.UnAuthorizedException;
import com.ssafy.enjoytrip.model.JWT.JwtService;
import com.ssafy.enjoytrip.model.user.dto.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class JWTInterceptor implements HandlerInterceptor {

//    public static final Logger logger = LoggerFactory.getLogger(JWTInterceptor.class);
//
//    private static final String HEADER_AUTH = "auth-token";
//
//    @Autowired
//    private JwtService jwtService;
//
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//            throws Exception {
//        final String token = request.getHeader(HEADER_AUTH);
//
//        if(token != null && jwtService.checkToken(token)){
//            logger.info("토큰 사용 가능 : {}", token);
//            return true;
//        }else{
//            logger.info("토큰 사용 불가능 : {}", token);
//            throw new UnAuthorizedException();
//        }
//
//    }

}
