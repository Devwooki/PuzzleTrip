package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.user.model.dto.User;
import org.apache.tomcat.Jar;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.ssafy.enjoytrip.user.model.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
@CrossOrigin("*")
public class UserController {

    private final Logger logger = LoggerFactory.getLogger(UserController.class);
    private UserService service;

    @Autowired
    public UserController(UserService userService) {
        this.service = userService;
    }

    @GetMapping("login")
    public String loginForm() {
        logger.debug("GET : login {}");
        return "user/login";
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

    @PostMapping("login")
    @ResponseBody
    public ResponseEntity<?> login(@RequestBody User user, @RequestBody String saveId) throws Exception {
        logger.debug("Post : login {}, saveId {}", user, saveId);

        Map<String, Object> result = new HashMap<>();
        result.put("userInfo", service.getLogin(user));
        result.put("saveId", saveId);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }


    @GetMapping("logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/";
    }


    @GetMapping("join")
    public String joinForm() {
        return "user/join";
    }

    @PostMapping("join")
    public String join(User user) throws Exception {
        service.join(user);
        return "redirect:/user/login";
    }

    @GetMapping("idCheck/{userId}")
    @ResponseBody
    public String idCheck(@PathVariable("userId") String id) throws Exception{
        System.out.println(id + ", " + service.idCheck(id));
        return service.idCheck(id);
    }

    @GetMapping("findPw")
    public String findPwForm(){
        return "user/findPw";
    }

    @PostMapping("findPw")
    public String findPw(User user) throws Exception {
        service.findPw(user);
        return "redirect:/user/login";
    }

    @GetMapping("mypage")
    public String mypage() throws Exception{
        return "user/mypage";
    }

    @PostMapping("pwCheck")
    @ResponseBody
    public ResponseEntity<?> pwCheck(@RequestBody User user) throws Exception {
        user = service.pwCheck(user);
        if(user == null) user = new User();
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @PostMapping("modify")
    public String modify(User user) throws Exception{
        System.out.println(user);
        service.modifyUser(user);
        return "index";
    }

    @PostMapping("delete")
    public String deleteUser(User user) throws Exception{
        service.deleteUser(user.getId());
        return "redirect:/";
    }
}