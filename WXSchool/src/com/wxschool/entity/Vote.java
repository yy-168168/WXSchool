package com.wxschool.entity;

public class Vote {

	private int voteId;
	private int topicId;
	private String name;
	private int num;
	private String content;
	private long supportNum;
	private long opposeNum;
	private long replyNum;
	private long size;
	private String remark;
	private String wxaccount;
	private String userwx;
	private String addTime;
	// private String pubTime;
	private String headImgUrl;
	private String nickname;
	private int status;

	public int getVoteId() {
		return voteId;
	}

	public void setVoteId(int voteId) {
		this.voteId = voteId;
	}

	public int getTopicId() {
		return topicId;
	}

	public void setTopicId(int topicId) {
		this.topicId = topicId;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public long getSupportNum() {
		return supportNum;
	}

	public void setSupportNum(long supportNum) {
		this.supportNum = supportNum;
	}

	public long getOpposeNum() {
		return opposeNum;
	}

	public void setOpposeNum(long opposeNum) {
		this.opposeNum = opposeNum;
	}

	public long getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(long replyNum) {
		this.replyNum = replyNum;
	}

	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getAddTime() {
		return addTime;
	}

	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
}
