package com.ssafy.enjoytrip.controller;


import com.ssafy.enjoytrip.board.model.dto.Board;
import com.ssafy.enjoytrip.board.model.service.BoardService;

import com.ssafy.enjoytrip.common.dto.Page;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/board")
//@CrossOrigin(origins = "http://localhost:8080")
@CrossOrigin("*")
public class BoardController {
    private final Logger logger = LoggerFactory.getLogger(BoardController.class);
    private BoardService service;
    private String UPLOAD_PATH = "/upload";

    @Autowired
    public BoardController(BoardService service) {
        this.service = service;
    }

    //board로 이동
    @GetMapping("lists/{boardType}")
    private String moveBoard(){
        logger.debug("게시판으로 이동");
        return "board/board";
    }


    //페이지 이동이 아닌, ajax
    @GetMapping("lists/{boardType}/{pageNo}")
    @ResponseBody
    private ResponseEntity<?> boardLists(@PathVariable("boardType") int boardType,
                                        @PathVariable("pageNo") int pageNo) throws Exception{
        logger.debug("게시판 리스트 출력 화면로 이동");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("pageNo", pageNo);

        Map<String, Object> returnData = service.boardLists(paramMap);

        return new ResponseEntity<>(returnData, HttpStatus.OK);
    }

    @GetMapping("details/{boardType}/{boardNo}")
    @ResponseBody
    public ResponseEntity<?> boardDetails(@PathVariable("boardType")int boardType,
                                      @PathVariable("boardNo") int boardNo) throws Exception {
        logger.debug("상세보기 접근 " + boardType + ", " + boardNo);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);

        Board result = service.boardDetails(paramMap);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @GetMapping("write")
    private String moveWrite(@RequestParam Map<String, String> map){
        return "board/writeBoard";
    }

    @PostMapping(value="write/{boardType}")
    private String writeBoard(@PathVariable("boardType") int boardType,
                         //@RequestBody Board board,
                         Board board,
                         @RequestParam("file") MultipartFile[] files) throws Exception {
        //하면서 배웠다. @RequestBody를 사용하면 form 데이터를 json형태로 파싱하기 때문에
        //form enctype="multipart/form-data"와 일치ㅈ하지 않아 에러발생
        //https://thesse.tistory.com/141
        logger.debug("작성한 글 데이터 넘어옴 {}", board.toString());
        service.writeBoard(board);
        return "redirect:/board/list/" + boardType;
    }

    @GetMapping("modify/{boardType}/{boardNo}")
    private String modifyBoard(@PathVariable("boardType") int boardType,
                               @PathVariable("boardNo") int boardNo,
                               @RequestParam Map<String, Object> map) throws Exception{
        logger.debug("게시글 수정 접근");
        map.put("boardType", boardType);
        map.put("boardNo", boardNo);
        map.put("board", map);
        for(String key : map.keySet()){
            logger.debug(key + " " + map.get(key));
        }
        service.modifyBoard(map);

        return "redirect:/board/list/"+boardType;
    }


    @DeleteMapping("delete/{boardType}/{boardNo}")
    @ResponseBody
    private String deleteBoard(@PathVariable("boardType") int boardType,
                               @PathVariable("boardNo") int boardNo) throws Exception{
        logger.debug("게시판 삭제 접근");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        service.deleteBoard(paramMap);

        return  "/board/list/"+boardType;
    }
}
