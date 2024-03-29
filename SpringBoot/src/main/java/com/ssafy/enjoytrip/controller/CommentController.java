package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.model.board.dto.Comment;
import com.ssafy.enjoytrip.model.board.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/comment")
public class CommentController {

    private final Logger logger = LoggerFactory.getLogger(CommentController.class);

    private BoardService service;

    @Autowired
    public CommentController(BoardService service) {
        this.service = service;
    }

    //댓글 작성
    //댓글 수정
    //댓글 삭제
    //댓글 조회 ->
    @GetMapping("/{boardType}/{boardNo}")
    @ResponseBody
    private List<Comment> listsComment(@PathVariable int boardType,
                                      @PathVariable int boardNo) throws Exception {
        logger.debug("댓글 가져오기 : boardType {}, boardNo{}", boardType, boardNo);
        logger.debug("boardType {}, boardNo {}", boardType, boardNo );
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        return service.commentLists(paramMap);
    }

    @PostMapping("/{boardType}/{boardNo}")
    @ResponseBody
    private List<Comment> writeComment(@PathVariable int boardType,
                                     @PathVariable int boardNo,
                                     @RequestBody Comment comment) throws Exception {
        logger.debug("comment write : {}", comment.toString());
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        paramMap.put("comment", comment);
        service.writeComment(paramMap);
        return service.commentLists(paramMap);
    }
    @PutMapping("/{boardType}/{boardNo}")
    @ResponseBody
    private List<Comment> modifyComment(@PathVariable int boardType,
                                        @PathVariable int boardNo,
                                        @RequestBody Comment comment) throws Exception {
        logger.debug("comment update : {}", comment.toString());
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        paramMap.put("comment", comment);
        service.modifyComment(paramMap);
        return service.commentLists(paramMap);
    }
    @DeleteMapping("/{boardType}/{boardNo}/{commentNo}")
    @ResponseBody
    private List<Comment> deleteComemnt(@PathVariable int boardType,
                                        @PathVariable int boardNo,
                                        @PathVariable int commentNo) throws Exception {
        logger.debug("comment delete : {} {} {}", boardType, boardNo, commentNo);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        paramMap.put("commentNo", commentNo);
        service.deleteComment(paramMap);
        return service.commentLists(paramMap);
    }

}
