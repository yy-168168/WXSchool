package com.wxschool.entity;

public class BarrierResult {

	private int resultId;
	private int barrierId;
	private int overScore;
	private String info;
	private int status;

	public int getResultId() {
		return resultId;
	}

	public void setResultId(int resultId) {
		this.resultId = resultId;
	}

	public int getBarrierId() {
		return barrierId;
	}

	public void setBarrierId(int barrierId) {
		this.barrierId = barrierId;
	}

	public int getOverScore() {
		return overScore;
	}

	public void setOverScore(int overScore) {
		this.overScore = overScore;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
