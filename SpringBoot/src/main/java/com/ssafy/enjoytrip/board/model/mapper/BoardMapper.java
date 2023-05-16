package com.ssafy.enjoytrip.board.model.mapper;

import com.ssafy.enjoytrip.board.model.dto.Board;
import com.ssafy.enjoytrip.board.model.dto.FileInfo;
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

    Board selectByBoardNo2(int boardNo) throws SQLException;
    void updateBoardHit(Map<String, Object> map) throws SQLException;

    void updateBoard(Board board) throws SQLException;
    void deleteByBoardNo(Map<String, Object> map) throws SQLException;

    void insertBoard(Board board) throws SQLException;
    void insertFile(Board board) throws SQLException;

    Board getLastNo(Board board) throws SQLException;

    List<FileInfo> fileInfoList(int articleNo) throws Exception;


    void deleteBoardFile(Map<String, Object> paramMap) throws SQLException;

    void deleteBoardFileBysFile(Map<String, Object> paramMap) throws SQLException;

    void updateBoardLike(Map<String, Object> paramMap) throws SQLException;

    void insertUserLikeBoard(Map<String, Object> paramMap) throws SQLException;

    void deleteUserLikeBoard(Map<String, Object> paramMap) throws SQLException;
    Board selectUserLikeBoard (Map<String, Object> paramMap) throws SQLException;
}
