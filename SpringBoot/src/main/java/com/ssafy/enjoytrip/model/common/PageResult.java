package com.ssafy.enjoytrip.model.common;

import lombok.Data;

@Data
public class PageResult {
    private int pageNo; //현재 페이지 번호 -> page에서 받아온다.
    private int totalBoard;//총 게시글 수 -> db에서 받아옴
    private int listSize;
    private int pageSize;

    private int currTab; //현재 페이지는 몇 번째 탭?
    private int startPageRange; //현재 페이지 기준 시작점
    private int endPageRange; //현재 페이지 기준 끝점
    private int totalTab; //총 페이지 수
    private int lastPage; //마지막 페이지 번호 계산

    public PageResult(int pageNo, int totalBoardCount){
        this(pageNo, totalBoardCount, 10, 10);

    }

    public PageResult(int pageNo, int totalBoard, int listSize, int pageSize) {
        this.pageNo = pageNo;
        this.totalBoard = totalBoard;
        this.listSize = listSize;
        this.pageSize = pageSize;
        //현재 페이지는 몇 번째 리스트?
        // pageNo =3 -> 1~ 10 사이, 1번 탭
        // pageNo =15 -> 11 ~ 20 사이, 2번 탭
        this.currTab = (pageNo) / pageSize + 1;
        //총 탭의 수를 구한다.
        this.totalTab = totalBoard / listSize;
        if (this.totalBoard % this.listSize > 0) totalTab++;

        //마지막 페이지 번호 구하기
        //게시글 수가 225개면 마지막 페이지는 23번이다.
        this.lastPage = (int) Math.ceil(totalBoard / 10d);

        //현재 탭을 기준으로 pageRange 구함
        //startPageRnage = 1 -> end 10
        //startPageRange = 11 -> 20까지..
        this.startPageRange = (this.currTab - 1) * pageSize + 1;
        this.endPageRange = startPageRange + pageSize - 1;

        //게시글이 225일 때, 먼저 계산한 endPageRange는 30임
        //근데 실제 마지막 페이지는 23페이지까지니까 보정해준다.
        if (endPageRange > lastPage) endPageRange = lastPage;
    }
}