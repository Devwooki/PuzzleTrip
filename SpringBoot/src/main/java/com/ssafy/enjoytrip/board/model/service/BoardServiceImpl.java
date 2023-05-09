package com.ssafy.enjoytrip.board.model.service;


import com.ssafy.enjoytrip.board.model.dto.Board;
import com.ssafy.enjoytrip.board.model.dto.Comment;
import com.ssafy.enjoytrip.board.model.mapper.BoardMapper;
import com.ssafy.enjoytrip.board.model.mapper.CommentMapper;
import com.ssafy.enjoytrip.common.dto.Page;
import com.ssafy.enjoytrip.common.dto.PageResult;
import com.ssafy.enjoytrip.controller.BoardController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService {

//    private BoardDao dao;
//    public BoardServiceImpl(BoardDao dao) {
//        this.dao = dao;
//    }
    private BoardMapper boardMapper;
    private CommentMapper commentMapper;
    private final Logger logger = LoggerFactory.getLogger(BoardController.class);

    @Autowired
    public BoardServiceImpl(BoardMapper boardMapper, CommentMapper commentMapper) {
        this.boardMapper = boardMapper;
        this.commentMapper = commentMapper;
    }

    @Override
    public Map<String, Object> boardLists(Map<String, Object> paramMap) throws Exception {
        int pageNo = (int) paramMap.get("pageNo");
        int boardType = (int) paramMap.get("boardType");

        Page page = new Page(pageNo);
        int pageSize = page.getListAmount();
        int start = pageNo * pageSize - pageSize;
        paramMap.put("start", start);
        paramMap.put("page", page);

        Map<String, Object> result = new HashMap<>();
        result.put("list", boardMapper.selectBoardLists(paramMap));
        result.put("pageResult", new PageResult(pageNo, boardMapper.selectBoardCount(boardType)));
        return result;
    }

    @Override
    public Board boardDetails(Map<String, Object> paramMap) throws Exception {
        /*paramMap {
            boardType : int
            boardNo : int
        } */
        boardMapper.updateBoardHit(paramMap);
        return boardMapper.selectByBoardNo(paramMap);
    }
    @Override
    public void writeBoard(Board board) throws Exception {
        boardMapper.insertBoard(board);
    }

    @Override
    public void modifyBoard(Map<String, Object> paramMap) throws Exception{
        /*paramMap {
            boardType : int
            boardNo : int
            board : {
                title : String
                content : String
            }
        } */
        boardMapper.updateBoard(paramMap);
    }

    @Override
    public void deleteBoard(Map<String, Object> paramMap) throws Exception {
        /*paramMap {
            boardType : int
            boardNo : int
        } */
        boardMapper.deleteByBoardNo(paramMap);
    }





    @Override
    public List<Comment> commentLists(Map<String, Object> paramMap) throws Exception {
        return commentMapper.selectComment(paramMap);
    }

    @Override
    public void writeComment(Map<String, Object> paramMap) throws Exception {
        commentMapper.insertComment(paramMap);
    }

    @Override
    public void modifyComment(Map<String, Object> paramMap) throws Exception {
        commentMapper.updateComment(paramMap);
    }

    @Override
    public void deleteComment(Map<String, Object> paramMap) throws Exception {
        commentMapper.deleteComment(paramMap);
    }


}
