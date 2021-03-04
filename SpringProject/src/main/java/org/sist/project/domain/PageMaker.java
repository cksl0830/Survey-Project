package org.sist.project.domain;

public class PageMaker {
	private int totalCount; //데이터의 전체 개수
	private int totalPage; //총 출력되는 페이지수
	private int displayPageNum = 5; //총 출력할 페이지수
	
	private Criteria cri;
	
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", totalPage=" + totalPage + ", displayPageNum=" + displayPageNum
				+ ", cri=" + cri + "]";
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		this.totalPage = (int) Math.ceil(totalCount / (double)cri.getPerPageNum());
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
}