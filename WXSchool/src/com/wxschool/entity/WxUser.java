package com.wxschool.entity;

public class WxUser {

	private int userId;
	private int isSubscribe;// 0未关注 1关注
	private String nickname;
	private int sex;// 0未知 1男性 2女性
	private String country;
	private String province;
	private String city;
	private String headImgUrl;
	private String subscribeTime;
	private String unsubscribeTime;
	private String lastUsedTime;
	private boolean beSearch;
	private boolean isSendMsg;
	private int level;
	private boolean isOnline;//是否在线
	private String userwx;
	private String wxaccount;
	private int status;

	public int getUserId() {
		return userId;
	}

	public int getIsSubscribe() {
		return isSubscribe;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public void setIsSubscribe(int isSubscribe) {
		this.isSubscribe = isSubscribe;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public boolean isBeSearch() {
		return beSearch;
	}

	public void setBeSearch(boolean beSearch) {
		this.beSearch = beSearch;
	}

	public boolean isSendMsg() {
		return isSendMsg;
	}

	public void setSendMsg(boolean isSendMsg) {
		this.isSendMsg = isSendMsg;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getHeadImgUrl() {
		return headImgUrl;
	}

	public void setHeadImgUrl(String headImgUrl) {
		this.headImgUrl = headImgUrl;
	}

	public String getSubscribeTime() {
		return subscribeTime;
	}

	public void setSubscribeTime(String subscribeTime) {
		this.subscribeTime = subscribeTime;
	}

	public String getUnsubscribeTime() {
		return unsubscribeTime;
	}

	public void setUnsubscribeTime(String unsubscribeTime) {
		this.unsubscribeTime = unsubscribeTime;
	}

	public String getLastUsedTime() {
		return lastUsedTime;
	}

	public void setLastUsedTime(String lastUsedTime) {
		this.lastUsedTime = lastUsedTime;
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

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public boolean isOnline() {
		return isOnline;
	}

	public void setOnline(boolean isOnline) {
		this.isOnline = isOnline;
	}
}
