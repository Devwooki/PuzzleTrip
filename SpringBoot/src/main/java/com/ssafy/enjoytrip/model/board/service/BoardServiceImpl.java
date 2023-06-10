package com.ssafy.enjoytrip.model.board.service;


import com.ssafy.enjoytrip.model.board.dto.*;
import com.ssafy.enjoytrip.model.board.mapper.BoardMapper;
import com.ssafy.enjoytrip.model.board.mapper.CommentMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

    @Value("${file.path}")
    private String uploadPath;
    private final Logger logger = LoggerFactory.getLogger(BoardService.class);

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
        int boardNo = (int) paramMap.get("boardNo");
        return boardMapper.selectByBoardNo2(boardNo);
    }
    @Override
    public int writeBoard(Board board) throws Exception {
        System.out.println("글입력 전 dto : " + board);
        //게시글 작성
        boardMapper.insertBoard(board);
        System.out.println("작성 후 dto : " + board);
        //해당 게시글에 대한 file 정보 업로드
        List<FileInfo> fileInfos = board.getFileInfos();
        //controller에서 필터링 했지만 검사 한 번더.
        //파일 객체가 있을 때만 db에 파일 정보 저장한다.
        //실제파일은 server의 /update폴더에 존재.
        if (fileInfos != null && !fileInfos.isEmpty()) {
            boardMapper.insertFile(board);
        }
        return board.getNo();
    }

    @Override
    public void modifyBoard(Board board) throws Exception{
        /*paramMap {
            board : {
                no : int
                typeNo : int
                title : String
                content : String
                userId : String
                fileInfos : List<FileInfo>
            }
        } */
        List<FileInfo> fileInfos = board.getFileInfos();
        if (fileInfos != null && !fileInfos.isEmpty()) {
            boardMapper.insertFile(board);
        }
        boardMapper.updateBoard(board);
    }

    @Override
    public void deleteBoard(Map<String, Object> paramMap) throws Exception {
        /*paramMap {
            boardType : int
            boardNo : int
        } */

        //서버에 저장된 실제 파일 삭제
        List<FileInfo> fileList = boardMapper.fileInfoList((Integer) paramMap.get("boardNo"));
        for(FileInfo fileInfos : fileList){
            String file = uploadPath + File.separator + fileInfos.getSaveFolder()
                    + File.separator + fileInfos.getSaveFile();
            try{
                Path filePath = Paths.get(file);
                Files.delete(filePath);
                logger.debug("{}삭제 완료", fileInfos.getOriginalFile());
            }catch(Exception e){
                logger.debug("{}삭제 실패!!!!", fileInfos.getOriginalFile());
                e.printStackTrace();
            }
        }

        //DB정보 삭제
        boardMapper.deleteBoardFile(paramMap);
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

    @Override
    public List<FileInfo> deleteBoardFileBysFile(Map<String, Object> paramMap) throws Exception {
        /*
        "boardNo" : boardNo
        "sFolder" : sFolder
        "sFile" : sFile
        */
            String file = uploadPath + File.separator + paramMap.get("sFolder")
                    + File.separator + paramMap.get("sFile");
            try{
                Path filePath = Paths.get(file);
                Files.delete(filePath);
                logger.debug("삭제 완료");
            }catch(Exception e){
                logger.debug("삭제 실패!!!!");
                e.printStackTrace();
            }

        boardMapper.deleteBoardFileBysFile(paramMap);
        return boardMapper.fileInfoList((int)paramMap.get("boardNo"));
    }

    @Override
    public void updateBoardLike(Map<String, Object> paramMap) throws Exception {
        if((boolean)paramMap.get("likeSelect")){
            boardMapper.insertUserLikeBoard(paramMap);
        }else{
            boardMapper.deleteUserLikeBoard(paramMap);
        }
        boardMapper.updateBoardLike(paramMap);
    }


}
