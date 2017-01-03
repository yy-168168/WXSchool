package com.wxschool.entity;

public class Account {

	private int accountId;
	private String wxAccount;
	private String wxNum;
	private String wxName;
	private int fans;
	private String appId;
	private String appSecret;
	private String accessToken;
	private String expireTimeOfToken;
	private String guideUrl;
	private boolean textChat;
	private boolean voiceChat;
	private boolean robotChat;
	private boolean translate;
	private boolean weather;
	private boolean express;
	private String regTime;
	private boolean isAuth;// 1:认证 -1:未认证
	private int status;// 1:无权限 1:部分接口 2:全部接口

	public int getAccountId() {
		return accountId;
	}

	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}

	public String getWxAccount() {
		return wxAccount;
	}

	public void setWxAccount(String wxAccount) {
		this.wxAccount = wxAccount;
	}

	public String getWxNum() {
		return wxNum;
	}

	public void setWxNum(String wxNum) {
		this.wxNum = wxNum;
	}

	public boolean isAuth() {
		return isAuth;
	}

	public void setAuth(boolean isAuth) {
		this.isAuth = isAuth;
	}

	public String getWxName() {
		return wxName;
	}

	public void setWxName(String wxName) {
		this.wxName = wxName;
	}

	public int getFans() {
		return fans;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

	public String getExpireTimeOfToken() {
		return expireTimeOfToken;
	}

	public void setExpireTimeOfToken(String expireTimeOfToken) {
		this.expireTimeOfToken = expireTimeOfToken;
	}

	public void setFans(int fans) {
		this.fans = fans;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getGuideUrl() {
		return guideUrl;
	}

	public void setGuideUrl(String guideUrl) {
		this.guideUrl = guideUrl;
	}

	public boolean isTextChat() {
		return textChat;
	}

	public void setTextChat(boolean textChat) {
		this.textChat = textChat;
	}

	public boolean isVoiceChat() {
		return voiceChat;
	}

	public void setVoiceChat(boolean voiceChat) {
		this.voiceChat = voiceChat;
	}

	public boolean isRobotChat() {
		return robotChat;
	}

	public void setRobotChat(boolean robotChat) {
		this.robotChat = robotChat;
	}

	public boolean isTranslate() {
		return translate;
	}

	public void setTranslate(boolean translate) {
		this.translate = translate;
	}

	public boolean isWeather() {
		return weather;
	}

	public void setWeather(boolean weather) {
		this.weather = weather;
	}

	public boolean isExpress() {
		return express;
	}

	public void setExpress(boolean express) {
		this.express = express;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
