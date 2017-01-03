package com.wxschool.entity;

public class VotePerson {

	private int vpId;
	private int voteId;
	private String userwx;
	private String wxaccount;

	public int getVpId() {
		return vpId;
	}

	public void setVpId(int vpId) {
		this.vpId = vpId;
	}

	public int getVoteId() {
		return voteId;
	}

	public void setVoteId(int voteId) {
		this.voteId = voteId;
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
}
