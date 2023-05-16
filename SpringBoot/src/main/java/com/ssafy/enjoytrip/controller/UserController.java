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

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/user")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(UserController.class);



    @Autowired //JWT토큰을 이용하기에 생성자 주입 방식으로 주입
    private UserService service;
    @Autowired
    private JwtServiceImpl jwtService;

    //HttpStatus 표기를 위한 final 변수
    private static final String SUCCESS = "success";
    private static final String FAIL = "fail";

    @PostMapping("login/")
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
                String accessToken = jwtService.createAccessToken("userid", loginUser.getId());// key, data
                String refreshToken = jwtService.createRefreshToken("userid", loginUser.getPw());// key, data

                //DB에 사용자에게 토큰 부여
                service.saveRefreshToken(user.getId(), refreshToken);

                //token 정보 출력
                logger.debug("로그인 accessToken 정보 : {}", accessToken);
                logger.debug("로그인 refreshToken 정보 : {}", refreshToken);

                //
                result.put("access-token", accessToken);
                result.put("refresh-token", refreshToken);
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

//    @PostMapping("login")
//    public String login(User user, HttpSession session, RedirectAttributes ra,
//                        HttpServletRequest request, HttpServletResponse response,
//                        @RequestParam(name="saveId", required = false) String saveid) throws Exception {
//        logger.debug("Post : login {}", user);
//        User userInfo = service.getLogin(user);
//        if(userInfo == null){
//            //에러메시지도 출력시키자
//            ra.addFlashAttribute("msg", "id와 비밀번호를 확인해주세요");
//            return "redirect:login";
//        }else {
//            //유저 정보 세션에 등록
//            session.setAttribute("userInfo", userInfo);
//            //아이디 저장 정보 쿠키 추가
//            if (saveid != null) {
//                Cookie loginCookie = new Cookie("idCookie", user.getId());
//                loginCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일
//                // 쿠키를 HttpServletResponse 객체에 추가
//                response.addCookie(loginCookie);
//            } else {
//                Cookie cookies[] = request.getCookies();
//                if (cookies != null) {
//                    for (Cookie cookie : cookies) {
//                        if ("idCookie".equals(cookie.getName())) {
//                            cookie.setMaxAge(0);
//                            response.addCookie(cookie);
//                            break;
//                        }
//                    }
//                }
//            }
//            return "redirect:/";
//        }
//    }