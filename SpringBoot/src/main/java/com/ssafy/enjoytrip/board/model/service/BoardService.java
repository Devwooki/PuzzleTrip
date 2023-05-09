package com.ssafy.enjoytrip.board.model.service;


import com.ssafy.enjoytrip.board.model.dto.Board;
import com.ssafy.enjoytrip.board.model.dto.Comment;
import com.ssafy.enjoytrip.common.dto.Page;

import java.util.List;
import java.util.Map;

public interface BoardService {
    Map<String, Object> boardLists(Map<String, Object> paramMap) throws Exception;

    Board boardDetails(Map<String, Object> paramMap) throws Exception;
    void writeBoard(Board board) throws Exception;

    void modifyBoard(Map<String, Object> paramMap) throws Exception;

    void deleteBoard(Map<String, Object> paramMap) throws Exception;



    //댓글 메소드
    List<Comment> commentLists(Map<String, Object> paramMap) throws Exception;
    void writeComment(Map<String, Object> paramMap) throws Exception;
    void modifyComment (Map<String, Object> paramMap) throws Exception;
    void deleteComment(Map<String, Object> paramMap) throws Exception;
}
