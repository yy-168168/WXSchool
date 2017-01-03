package com.wxschool.entity;

public class Goods {

	private int goodsId;
	private String uid;
	private String simDesc;
	private String dtlDesc;
	private String picUrl;
	private int price;
	private int old;
	private int cate;// 1.生活用品，2.电子产品，3.书籍资料，4.鞋包服装，5运动户外，10.其它
	private int type;
	private String tel;
	private String wxin;
	private String wxaccount;
	private int visitPerson;
	private String pubTime;
	private String uptTime;
	private int status;

	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getSimDesc() {
		return simDesc;
	}

	public void setSimDesc(String simDesc) {
		this.simDesc = simDesc;
	}

	public String getDtlDesc() {
		return dtlDesc;
	}

	public void setDtlDesc(String dtlDesc) {
		this.dtlDesc = dtlDesc;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getOld() {
		return old;
	}

	public void setOld(int old) {
		this.old = old;
	}

	public int getCate() {
		return cate;
	}

	public void setCate(int cate) {
		this.cate = cate;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getWxin() {
		return wxin;
	}

	public void setWxin(String wxin) {
		this.wxin = wxin;
	}

	public int getVisitPerson() {
		return visitPerson;
	}

	public void setVisitPerson(int visitPerson) {
		this.visitPerson = visitPerson;
	}

	public String getWxaccount() {
		return wxaccount;
	}

	public void setWxaccount(String wxaccount) {
		this.wxaccount = wxaccount;
	}

	public String getPubTime() {
		return pubTime;
	}

	public void setPubTime(String pubTime) {
		this.pubTime = pubTime;
	}

	public String getUptTime() {
		return uptTime;
	}

	public void setUptTime(String uptTime) {
		this.uptTime = uptTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
