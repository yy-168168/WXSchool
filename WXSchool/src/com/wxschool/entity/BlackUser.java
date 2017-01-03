package com.wxschool.entity;

public class BlackUser {

	private int userId;
	private String userwx;
	private String wxaccount;
	private String cate;
	private int status;

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserwx() {
		return userwx;
	}

	public void setUserwx(String userwx) {
		this.userwx = userwx;
	}

	public String getWxaccount() {
		return wxaccount;
	}

	public void setWxaccount(String wxaccount) {
		this.wxaccount = wxaccount;
	}

	public String getCate() {
		return cate;
	}

	public void setCate(String cate) {
		this.cate = cate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
