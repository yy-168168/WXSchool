package com.wxschool.entity;

public class Text {

	private int textId;
	private String key;
	private String value;
	private String wxaccount;
	private int status = 1;

	public int getTextId() {
		return textId;
	}

	public void setTextId(int textId) {
		this.textId = textId;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
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
