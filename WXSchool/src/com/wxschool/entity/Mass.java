package com.wxschool.entity;

public class Mass {

	private int massId;
	private String content;
	private String sendTime;
	private String wxaccount;
	private int status;

	public int getMassId() {
		return massId;
	}

	public void setMassId(int massId) {
		this.massId = massId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getWxaccount() {
		return wxaccount;
	}

	public void setWxaccount(String wxaccount) {
		this.wxaccount = wxaccount;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
