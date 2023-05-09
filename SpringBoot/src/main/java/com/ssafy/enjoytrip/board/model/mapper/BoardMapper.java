package com.ssafy.enjoytrip.board.model.mapper;

import com.ssafy.enjoytrip.board.model.dto.Board;
import org.apache.ibatis.annotations.Mapper;
import javax.naming.NamingException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {
    List<Board> selectBoardLists(Map<String, Object> map) throws SQLException, NamingException;
    int selectBoardCount(int boardType) throws SQLException, NamingException;

    Board selectByBoardNo(Map<String, Object> map) throws SQLException;
    void insertBoard(Board board) throws SQLException;

    void updateBoardHit(Map<String, Object> map) throws SQLException;

    void updateBoard(Map<String, Object> map) throws SQLException;
    void deleteByBoardNo(Map<String, Object> map) throws SQLException;

}
