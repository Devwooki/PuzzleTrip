package com.ssafy.enjoytrip.model.board.dto;

import lombok.Data;

@Data
public class FileInfo {
    private String saveFolder;
    private String originalFile;
    private String saveFile;
    private long fileSize;
}
