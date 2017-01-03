package com.wxschool.entity;

public class Page {

	private int curPage;// 当前页
	private int everyPage = 20;// 每页显示条数
	private int totalPage;// 总页码数
	private int totalRecord;// 总记录数
	private int curPageCount;// 当前页显示条数
	private boolean hasNext;// 是否有下一页
	private int pageStyle = 1;// 1-显示总条数，2-不显示总条数

	public Page(int curPage, int everyPage, int totalRecord) {
		this.curPage = curPage;
		this.everyPage = everyPage;
		this.totalRecord = totalRecord;
		if (totalRecord % everyPage == 0) {
			this.totalPage = totalRecord / everyPage;
		} else {
			this.totalPage = totalRecord / everyPage + 1;
		}
	}

	public Page(int curPage, int everyPage) {
		this.curPage = curPage;
		this.everyPage = everyPage;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getEveryPage() {
		return everyPage;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public int getCurPageCount() {
		return curPageCount;
	}

	public void setCurPageCount(int curPageCount) {
		this.curPageCount = curPageCount;
		this.pageStyle = 2;
		if (curPageCount < this.everyPage) {
			this.hasNext = false;
		} else {
			this.hasNext = true;
		}
	}

	public void setEveryPage(int everyPage) {
		this.everyPage = everyPage;
	}

	public boolean isHasNext() {
		return hasNext;
	}

	public void setHasNext(boolean hasNext) {
		this.hasNext = hasNext;
	}

	public int getPageStyle() {
		return pageStyle;
	}

	public void setPageStyle(int pageStyle) {
		this.pageStyle = pageStyle;
	}
}
