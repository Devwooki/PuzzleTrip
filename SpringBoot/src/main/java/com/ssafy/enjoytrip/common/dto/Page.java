package com.ssafy.enjoytrip.common.dto;

public class Page {

    int pageNo;//페이지 번호 기반 시작 위치
    int listAmount;//총 게시글 수목록 수를 저장
    //페이지 기본 게시글 수 10개 제한
    public Page() {//기본으로 출력하는 리스트는 보통 1페이지에10개씩 자동설정
        this(1, 10);
    }
    public Page(int pageNo) {//기본으로 출력하는 리스트는 보통 1페이지에10개씩
        this(pageNo, 10);
    }
    public Page(int pageNo, int listAmount) {
        this.pageNo = pageNo;
        this.listAmount = listAmount;
    }
    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getListAmount() {
        return listAmount;
    }

    public void setListAmount(int listAmount) {
        this.listAmount = listAmount;
    }

    //결국 필요한 것 -> limit를 제한 하기편하게, begin은 있으면 좋고 end는 listAmount로 해결 가능
    public int getBegin(){
        return (pageNo-1) * this.listAmount;
    }
}
