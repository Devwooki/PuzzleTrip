package com.ssafy.enjoytrip.controller;


import com.ssafy.enjoytrip.model.board.dto.Board;
import com.ssafy.enjoytrip.model.board.dto.FileInfo;
import com.ssafy.enjoytrip.model.board.service.BoardService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/board")
public class BoardController {
    private final Logger logger = LoggerFactory.getLogger(BoardController.class);
    private BoardService service;
    @Value("${file.path}") //application.properties에서 지정한 값을 얻어올 수 있다. 그냥 문자열 쓰면 문자열로 저장됨
    private String uploadPath;

    @Autowired
    public BoardController(BoardService service) {
        this.service = service;
    }

    //페이지 이동이 아닌, ajax
    @GetMapping("lists/{boardType}/{pageNo}")
    private ResponseEntity<?> boardLists(@PathVariable("boardType") int boardType,
                                        @PathVariable("pageNo") int pageNo) throws Exception{
        logger.debug("게시판 리스트 출력 화면로 이동");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("pageNo", pageNo);

        Map<String, Object> returnData = service.boardLists(paramMap);
        logger.debug("게시판 리스트 출력 {}", returnData);
        return new ResponseEntity<>(returnData, HttpStatus.OK);
    }

    @GetMapping("details/{boardType}/{boardNo}")
    public Board boardDetails(@PathVariable("boardType")int boardType,
                                          @PathVariable("boardNo") int boardNo) throws Exception {
        logger.debug("상세보기 접근 " + boardType + ", " + boardNo);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        Board result = service.boardDetails(paramMap);
        logger.debug("게시글 정보 가져오기: {}", result);
        return result;
    }

    //조금 복잡하넹,,,ㅎㅎ 암튼 설명해주겠음 - BoardWrite.vue의 write()메소드에 주석 1차 참고해주고
    //넘겨받은 form 데이터에는
        /*
        {
            title : 제목,
            content : 본문
            boardType : 게시판 타입,
            files : {
                파일 정보1,
                파일 정보2,
                파일 정보3
            }
        }
        가 들어있는데 JSON형식이 아닌 multi-part형태라 @ResquestBody하면 전달받는 타입이 이상하다해서 이렇게 수정했음...
        */
    @PostMapping("write")
    public int writeBoard(@RequestParam Map<String, Object> map,
                          @RequestParam(value = "files", required = false) MultipartFile[] mFiles) throws Exception{
        //파일 업로드 하지 않으면 files는 null이다
        logger.debug("게시글 작성 : {}, {}", map, mFiles);

        //Board 정보입력
        Board board = new Board();
        board.setTypeNo(Integer.parseInt((String)map.get("boardType")));
        board.setTitle((String)map.get("title"));
        board.setContent((String)map.get("content"));
        board.setUserId((String)map.get("userId"));

        //파일 정보 로드 후 게시글에 업로드된 파일 정보 추가히기(setFileInfo)
        if(mFiles != null){
            String realPath = uploadPath; //실제 저장할 경로
            String today = new SimpleDateFormat("yyMMdd").format(new Date()); //파일 저장할 날짜 기록
            String saveFolder = realPath + File.separator + today; //OS구분받지 않고 파일 업로드를 구현하고자 File.sepaerator 사용
            logger.debug("저장할 폴더 경로 : {}", saveFolder);
            
            File folder = new File(saveFolder);
            if(!folder.exists()) {
                folder.mkdir();
                logger.debug("@@@@@@경로에 폴더 생성@@@@@@@@ : {}", saveFolder);
                //폴더가 존재하지 않으면 생성
            }

            //파일 리스트 객체 만들어서 db에 저장하자!
            List<FileInfo> fileInfos = new ArrayList<>();
            for(MultipartFile mFile : mFiles){
                FileInfo fileInfo = new FileInfo();
                String originalFileName = mFile.getOriginalFilename(); //진짜 파일 명 저장

                if (!originalFileName.isEmpty()) { //파일명이 유효(빈 문자열이 아닐 때)할 때 업로드를 진행함
                    String saveFileName = UUID.randomUUID().toString() //기존 파일명.확장자 -> UUID.확장자로 변경
                            + originalFileName.substring(originalFileName.lastIndexOf('.'));

                    fileInfo.setOriginalFile(originalFileName);
                    fileInfo.setSaveFile(saveFileName);
                    fileInfo.setSaveFolder(today); //저장한 폴더는 업로드 날짜로 변경
                    logger.debug("원본 파일 이름 : {}, 실제 저장 파일 이름 : {}", mFile.getOriginalFilename(), saveFileName);

                    //MultipartFile mFile를 File 객체로 변환해 서버에 저장하는 메서드
                    //첫번째 파라미터 경로에 두 번째 파라미터 명으로 저장한다.
                    mFile.transferTo(new File(folder, saveFileName));
                }
                fileInfos.add(fileInfo);
            }
            board.setFileInfos(fileInfos); //fileInfo 리스트를 boarddto에 저장
        }

        //게시글 작성 후 게시글 번호를 반환한다.
        //이 반환값을 front server로 보내 게시글 작성 -> 작성한 글 조화 프로세스를 수행시킨다.
        int writeBoardNo = service.writeBoard(board);
//        return writeBoardNo;
        logger.debug("작성된 글 번호 : {}", writeBoardNo);
        return writeBoardNo;
    }

    @PutMapping("modify")
    private String modifyBoard(@RequestParam Map<String, Object> map, @RequestParam(value = "files", required = false) MultipartFile[] mFiles) throws Exception{
        logger.debug("게시글 수정 접근 {}, 수정파일 정보 {}", map, mFiles);
        //Board 정보입력
        Board board = new Board();
        board.setTypeNo(Integer.parseInt((String)map.get("typeNo")));
        board.setNo(Integer.parseInt((String) map.get("boardNo")));
        board.setTitle((String)map.get("title"));
        board.setContent((String)map.get("content"));
        board.setUserId((String)map.get("userId"));

        //파일 정보 로드 후 게시글에 업로드된 파일 정보 추가히기(setFileInfo)
        if(mFiles != null){
            String realPath = uploadPath; //실제 저장할 경로
            String today = new SimpleDateFormat("yyMMdd").format(new Date()); //파일 저장할 날짜 기록
            String saveFolder = realPath + File.separator + today; //OS구분받지 않고 파일 업로드를 구현하고자 File.sepaerator 사용
            logger.debug("저장할 폴더 경로 : {}", saveFolder);

            File folder = new File(saveFolder);
            if(!folder.exists()) {
                folder.mkdir();
                logger.debug("@@@@@@경로에 폴더 생성@@@@@@@@ : {}", saveFolder);
                //폴더가 존재하지 않으면 생성
            }

            //파일 리스트 객체 만들어서 db에 저장하자!
            List<FileInfo> fileInfos = new ArrayList<>();
            for(MultipartFile mFile : mFiles){
                FileInfo fileInfo = new FileInfo();
                String originalFileName = mFile.getOriginalFilename(); //진짜 파일 명 저장

                if (!originalFileName.isEmpty()) { //파일명이 유효(빈 문자열이 아닐 때)할 때 업로드를 진행함
                    String saveFileName = UUID.randomUUID().toString() //기존 파일명.확장자 -> UUID.확장자로 변경
                            + originalFileName.substring(originalFileName.lastIndexOf('.'));

                    fileInfo.setOriginalFile(originalFileName);
                    fileInfo.setSaveFile(saveFileName);
                    fileInfo.setSaveFolder(today); //저장한 폴더는 업로드 날짜로 변경
                    logger.debug("원본 파일 이름 : {}, 실제 저장 파일 이름 : {}", mFile.getOriginalFilename(), saveFileName);

                    //MultipartFile mFile를 File 객체로 변환해 서버에 저장하는 메서드
                    //첫번째 파라미터 경로에 두 번째 파라미터 명으로 저장한다.
                    mFile.transferTo(new File(folder, saveFileName));
                }
                fileInfos.add(fileInfo);
            }
            board.setFileInfos(fileInfos); //fileInfo 리스트를 boarddto에 저장
        }
        service.modifyBoard(board);

        return String.valueOf(board.getNo());
    }


    @DeleteMapping("{boardType}/{boardNo}")
    private String deleteBoard(@PathVariable("boardType") int boardType,
                               @PathVariable("boardNo") int boardNo) throws Exception{
        logger.debug("게시판 삭제 접근");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardType", boardType);
        paramMap.put("boardNo", boardNo);
        service.deleteBoard(paramMap);
        return null;
    }

    @DeleteMapping("deleteFile/{boardNo}/{sFolder}/{sFile}")
    private List<FileInfo> deleteFile(
            @PathVariable("boardNo")int boardNo,
            @PathVariable("sFolder")String sFolder,
            @PathVariable("sFile")  String sFile
    ) throws Exception{
        logger.debug("게시글 수정 중 파일 삭제 삭제를 위한 접근");
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("boardNo", boardNo);
        paramMap.put("sFolder", sFolder);
        paramMap.put("sFile", sFile);
        return service.deleteBoardFileBysFile(paramMap);
    }

    @PutMapping("like")
    private String boardLike(@RequestBody Map<String, Object> paramMap) throws Exception{
        logger.debug("게시글 추천 {} ",paramMap);
        service.updateBoardLike(paramMap);
        return null;
    }
}
