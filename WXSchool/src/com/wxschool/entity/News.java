package com.wxschool.entity;

public class News {

	private String title = ""; // 图文消息标题
	private String description = "";// 图文消息描述
	private String PicUrl = "";// 图片链接，支持JPG、PNG格式，较好的效果为大图640*320，小图80*80
	private String Url = "";// 点击图文消息跳转链接

	public News() {
	}

	public News(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPicUrl() {
		return PicUrl;
	}

	public void setPicUrl(String picUrl) {
		PicUrl = picUrl;
	}

	public String getUrl() {
		return Url;
	}

	public void setUrl(String url) {
		Url = url;
	}
}
