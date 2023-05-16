package com.ssafy.enjoytrip.model.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
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
}
