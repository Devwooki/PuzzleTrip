package com.ssafy.enjoytrip.model.board.dto;


import lombok.Data;

import java.util.List;

@Data
public class Board {
    private int no;
    private int typeNo;
    private String userId;
    private String title;
    private String content;
    private int hit;
    private int likeCnt;
    private String createdAt;
    private int status;
    private List<FileInfo> fileInfos;

}
