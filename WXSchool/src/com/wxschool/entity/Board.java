package com.wxschool.entity;


public class Board {

	private int boardId;
	private String content;
	private String way;
	private String contact;
	private String pubTime;
	private int cate;
	private String userwx;
	private String wxaccount;

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWay() {
		return way;
	}

	public void setWay(String way) {
		this.way = way;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public int getCate() {
		return cate;
	}

	public void setCate(int cate) {
		this.cate = cate;
	}

	public String getPubTime() {
		return pubTime;
	}

	public void setPubTime(String pubTime) {
		this.pubTime = pubTime;
	}

	public String getWxaccount() {
		return wxaccount;
	}

	public void setWxaccount(String wxaccount) {
		this.wxaccount = wxaccount;
	}

	public String getUserwx() {
		return userwx;
	}

	public void setUserwx(String userwx) {
		this.userwx = userwx;
	}
}
