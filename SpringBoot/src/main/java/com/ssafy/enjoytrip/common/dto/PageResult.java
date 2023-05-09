package com.ssafy.enjoytrip.common.dto;

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

    private boolean prev;
    private boolean next;

    private String listHTML;
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
        this.currTab = (pageNo)  / pageSize + 1;

        //총 탭의 수를 구한다.
        this.totalTab = totalBoard / listSize;
        if(this.totalBoard % this.listSize > 0) totalTab ++;

        //마지막 페이지 번호 구하기
        //게시글 수가 225개면 마지막 페이지는 23번이다.
        this.lastPage =  (int)Math.ceil(totalBoard/10d);

        //현재 탭을 기준으로 pageRange 구함
        //startPageRnage = 1 -> end 10
        //startPageRange = 11 -> 20까지..
        this.startPageRange =  (this.currTab -1) * pageSize + 1;
        this.endPageRange = startPageRange + pageSize - 1;

        //게시글이 225일 때, 먼저 계산한 endPageRange는 30임
        //근데 실제 마지막 페이지는 23페이지까지니까 보정해준다.
        if(endPageRange > lastPage ) endPageRange = lastPage;


        //이전으로 갈 수 있는가?
        this.prev = this.startPageRange > 1;
        //다음으로 갈 수 있는가?
        this.next = endPageRange != lastPage;

        StringBuilder sb = new StringBuilder();
        sb.append(
                "   <ul class=\"pagination  justify-content-center\">\n" +
                "       <li class=\"page-item\" id=\"first-page\" data-pg=\"1\">\n" +
                "           <a href=\"#\" class=\"page-link\"><<</a>\n" +
                "       </li>\n" +
                "       <li class=\"page-item\" id=\"prev-page\" data-pg=\""+ (this.prev ? (currTab - 1) : 1) +"\">\n" +
                "           <a href=\"#\" class=\"page-link\"><</a>\n" +
                "       </li>");
        for(int i = this.startPageRange ; i <= this.endPageRange ; ++i){
                        //"<li class=\"page-item\" data-pg=\"2>");
            sb.append(" <li class=\"" + "page-item"  + "\"" + "data-pg=\""+i+"\">" +
                    "       <a href=\"#\" class=\"page-link\">"+ i +"</a>\n" +
                    "   </li>");
        }
        sb.append("     <li class=\"page-item\" id=\"next-page\" data-pg=\""+ (this.next ? currTab : (currTab + 1)) +"\">\n" +
                "           <a href=\"#\" class=\"page-link\">></a>\n" +
                "       </li>\n" +
                "       <li class=\"page-item\" id=\"last-page\" data-pg=\"" + lastPage +"\">\n" +
                "           <a href=\"#\" class=\"page-link\">>></a>\n" +
                "       </li>\n" +
                "   </ul>");
        listHTML = sb.toString();
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getTotalBoard() {
        return totalBoard;
    }

    public void setTotalBoard(int totalBoard) {
        this.totalBoard = totalBoard;
    }

    public int getListSize() {
        return listSize;
    }

    public void setListSize(int listSize) {
        this.listSize = listSize;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getCurrTab() {
        return currTab;
    }

    public void setCurrTab(int currTab) {
        this.currTab = currTab;
    }

    public int getStartPageRange() {
        return startPageRange;
    }

    public void setStartPageRange(int startPageRange) {
        this.startPageRange = startPageRange;
    }

    public int getEndPageRange() {
        return endPageRange;
    }

    public void setEndPageRange(int endPageRange) {
        this.endPageRange = endPageRange;
    }

    public int getTotalTab() {
        return totalTab;
    }

    public void setTotalTab(int totalTab) {
        this.totalTab = totalTab;
    }

    public int getLastPage() {
        return lastPage;
    }

    public void setLastPage(int lastPage) {
        this.lastPage = lastPage;
    }

    public boolean isPrev() {
        return prev;
    }

    public void setPrev(boolean prev) {
        this.prev = prev;
    }

    public boolean isNext() {
        return next;
    }

    public String getListHTML() {
        return listHTML;
    }

    public void setListHTML(String listHTML) {
        this.listHTML = listHTML;
    }

    public void setNext(boolean next) {
        this.next = next;
    }

    @Override
    public String toString() {
        return "PageResult{" +
                "pageNo=" + pageNo +
                ", totalBoard=" + totalBoard +
                ", listSize=" + listSize +
                ", pageSize=" + pageSize +
                ", currTab=" + currTab +
                ", startPageRange=" + startPageRange +
                ", endPageRange=" + endPageRange +
                ", totalTab=" + totalTab +
                ", lastPage=" + lastPage +
                ", prev=" + prev +
                ", next=" + next +
                '}';
    }
}