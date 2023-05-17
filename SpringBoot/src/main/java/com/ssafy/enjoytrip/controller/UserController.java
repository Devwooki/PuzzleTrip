package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.model.JWT.JwtServiceImpl;
import com.ssafy.enjoytrip.model.user.dto.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.ssafy.enjoytrip.model.user.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(UserController.class);
    //HttpStatus 표기를 위한 final 변수
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";



    @Autowired //JWT토큰을 이용하기에 생성자 주입 방식으로 주입
    private UserService service;
    @Autowired
    private JwtServiceImpl jwtService;

    /* 서버의 토큰 검증 시나리오
    1. 검증이 필요한(마이페이지, 게시판 글작성, 수정, 삭제, 댓글 등) client요청 header에 token포함
    2. Spring Interceptor 요청
    3. 사용자에게 제공된 token과 header의 토큰 일치하는지 체크
    4. auth0 jwt를 이용해 검증
    
    시나리오 이해가 안가면 다음 자료 참고
    https://inpa.tistory.com/entry/WEB-%F0%9F%93%9A-Access-Token-Refresh-Token-%EC%9B%90%EB%A6%AC-feat-JWT
    */

    @PostMapping("login")
    public ResponseEntity<?> login(@RequestBody User user) throws Exception {
        logger.debug("로그인 하기 : login {}", user);

        //로그인 반환 방식이 ResponseEntity라서 map객체 생성
        Map<String, Object> result = new HashMap<>();
        //반환할 때 함께 전달할 status
        HttpStatus status = null;
        //체크박스 선택여부 저장
        //쿠키는 vue쿠키 사용 https://kyounghwan01.github.io/blog/Vue/vue/vue-cookies/

        try{
            User loginUser = service.getLogin(user);
            if(loginUser != null){
                //보안 강화하기 위해 2개의 토큰을 발행한다
                //accessToken : API 요청에 사용하기 위한 토큰 - 위험도 낮은 작업에 사용
                //refreshToken : 인증, 접근, 권한 갱신 등 고위험 작업에 사용 - 서버에 저장하고 체크
                String accessToken = jwtService.createAccessToken("userId", loginUser.getId());// key, data
                String refreshToken = jwtService.createRefreshToken("userId", loginUser.getId());// key, data

                //DB에 사용자에게 RefreshToken토큰 부여
                service.saveRefreshToken(user.getId(), refreshToken);

                //token 정보 출력
                logger.debug("로그인 accessToken 정보 : {}", accessToken);
                logger.debug("로그인 refreshToken 정보 : {}", refreshToken);

                //
                result.put("accessToken", accessToken);
                result.put("refreshToken", refreshToken);
                result.put("message", SUCCESS);

                //acepted : 202 -> 요청 처리는 완료됬고 응답 대기 상태
                status = HttpStatus.ACCEPTED;
            }else {
                result.put("message", FAIL);
                status = HttpStatus.ACCEPTED;
            }
        }catch(Exception e){
            logger.error("로그인 실패 {}", e);
            result.put("message", e.getMessage());
            //INTERNAL_SERVER_ERROR : 500 -> 서버 내부 오류
            status = HttpStatus.INTERNAL_SERVER_ERROR;
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("info/{userId}")
    private ResponseEntity<?> getUserInfo(@PathVariable("userId") String userId,
                                          HttpServletRequest req) throws Exception{
        logger.debug("유저 {}의 정보 조회", userId);
        Map<String, Object> result = new HashMap<>();
        HttpStatus status = HttpStatus.UNAUTHORIZED;

        //요청 헤더에 accessToken이 담겨있는지 체크
        if(jwtService.checkToken(req.getHeader("accessToken"))){
            logger.info("해당 토큰은 사용할 수 있다");
            try{
                User userInfo = service.getUserInfo(userId);
                result.put("userInfo", userInfo);
                result.put("message", SUCCESS);
                status = HttpStatus.ACCEPTED;
            }catch(Exception e){
                logger.debug("정보 조회 실패 {}", e);
                result.put("message", FAIL);
                status = HttpStatus.INTERNAL_SERVER_ERROR;
            }
        }else{
            logger.error("사용 불가능한 토큰");
            result.put("message", FAIL);
            status = HttpStatus.UNAUTHORIZED;
        }
        //db에 접근해서 accessToken이 유효한지 체크
        return new ResponseEntity<>(result, status);
    }

    @PostMapping("refresh")
    private ResponseEntity<?> refreshToken(@RequestBody User user,
                                           HttpServletRequest req) throws Exception{
        logger.debug("{} 유저 토큰 재발급", user.getId());
        Map<String, Object> result = new HashMap<>();
        HttpStatus status = HttpStatus.UNAUTHORIZED;


        //HttpRequest 헤더에서 JWT를 파싱
        String refToken = req.getHeader("refreshToken");

        //refToken은 aaa.bbb.ccc형태의 JWT
        if(jwtService.checkToken(refToken)){//토큰에 payload가 존재
            //db에 저장된 userId의 refreshToken과 파싱해서 얻은 token 비교
            if(refToken.equals(service.getRefreshToken(user.getId()))){
                String accessToken = jwtService.createAccessToken("accessToken", user.getId());;
                logger.debug("{}의 accessToken 재발급{}", user.getId(), accessToken);
                result.put("accessToken", accessToken);
                result.put("message", SUCCESS);
                status = HttpStatus.ACCEPTED;
            }
        }else {
            logger.debug("refreshToken도 사용 불가");
            result.put("message", FAIL);
            status = HttpStatus.UNAUTHORIZED;
        }
        return new ResponseEntity<>(result, status);
    }

    @GetMapping("logout/{userId}")
    private ResponseEntity<?> removeToken(@PathVariable("userId") String userId) throws Exception{
        Map<String, Object> result = new HashMap<>();
        HttpStatus status = HttpStatus.ACCEPTED;

        try{
            service.deleRefreshToken(userId);
            result.put("message", SUCCESS);
            status = HttpStatus.INTERNAL_SERVER_ERROR;
        }catch(Exception e){
            logger.debug("로그아웃 실패 {}", e);
            result.put("message", e.getMessage());
            //INTERNAL_SERVER_ERROR : 500 -> 서버 내부 오류
            status = HttpStatus.INTERNAL_SERVER_ERROR;

        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }


    @GetMapping("idCheck/{userId}")
    public String idCheck(@PathVariable("userId") String id) throws Exception{
        System.out.println(id + ", " + service.idCheck(id));
        return service.idCheck(id);
    }


    @PostMapping("pwCheck")
    public ResponseEntity<?> pwCheck(@RequestBody User user) throws Exception {
        user = service.pwCheck(user);
        if(user == null) user = new User();
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @PostMapping("delete")
    public void deleteUser(User user) throws Exception{
        service.deleteUser(user.getId());
    }
}