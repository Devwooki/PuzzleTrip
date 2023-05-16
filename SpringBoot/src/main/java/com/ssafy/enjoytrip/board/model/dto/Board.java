package com.ssafy.enjoytrip.board.model.dto;


import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

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
