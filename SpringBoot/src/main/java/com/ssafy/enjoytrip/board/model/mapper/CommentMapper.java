package com.ssafy.enjoytrip.board.model.mapper;

import com.ssafy.enjoytrip.board.model.dto.Comment;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface CommentMapper {
    List<Comment> selectComment(Map<String, Object> paramMap) throws SQLException;
    void insertComment(Map<String, Object> paramMap) throws SQLException;
    void updateComment(Map<String, Object> paramMap) throws SQLException;
    void deleteComment(Map<String, Object> paramMap) throws SQLException;

}
