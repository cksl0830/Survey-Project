package org.sist.project.domain;

public class Criteria {
	private int page; //현재 페이지
	private int perPageNum; //페이지당 출력할 게시글 수
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 5;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
		}
		this.page = page;
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		if (this.perPageNum <= 0 || this.perPageNum > 50) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	public int getPageStart() {
		return (this.page - 1) * this.perPageNum;
	} //시작 게시글 번호
}
