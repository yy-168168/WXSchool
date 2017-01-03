package com.wxschool.entity;

import java.io.Serializable;

public class Admin implements Serializable {

	private static final long serialVersionUID = 1L;
	private int adminId;
	private String wxaccount;
	private String userwx;
	private String key;
	private String token;
	private int maxUsedNum;
	private int maxBoxNum;
	private int maxResNum;
	private String regTime;
	private String lastTime;
	private String type;
	private int status;

	public int getAdminId() {
		return adminId;
	}

	public void setAdminId(int adminId) {
		this.adminId = adminId;
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

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public int getMaxUsedNum() {
		return maxUsedNum;
	}

	public void setMaxUsedNum(int maxUsedNum) {
		this.maxUsedNum = maxUsedNum;
	}

	public int getMaxBoxNum() {
		return maxBoxNum;
	}

	public void setMaxBoxNum(int maxBoxNum) {
		this.maxBoxNum = maxBoxNum;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getMaxResNum() {
		return maxResNum;
	}

	public void setMaxResNum(int maxResNum) {
		this.maxResNum = maxResNum;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getLastTime() {
		return lastTime;
	}

	public void setLastTime(String lastTime) {
		this.lastTime = lastTime;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
}
