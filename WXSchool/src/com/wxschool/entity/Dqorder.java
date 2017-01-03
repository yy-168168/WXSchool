package com.wxschool.entity;

import java.util.HashMap;
import java.util.Map;

public class Dqorder {

	private int orderId;
	private String name;
	private String tel;
	private String company;
	private String address;
	private String info;
	private String loc_time;
	private String sendTime;
	private String type;
	private String userwx;
	private String wxaccount;
	private String pubTime;
	private int status;

	public static String[] getExpressCompany() {
		String[] companys = { "顺丰", "圆通", "韵达", "中通", "天天", "汇通", "京东", "全峰",
				"国通", "尼尔", "邮政", "EMS", "宅急送" };

		return companys;
	}

	public static Map<String, String> getExpressCompanyAndEnname() {
		Map<String, String> expressCompany = new HashMap<String, String>();

		expressCompany.put("申通", "shentong");
		expressCompany.put("顺丰", "shunfeng");
		expressCompany.put("圆通", "yuantong");
		expressCompany.put("韵达", "yunda");
		expressCompany.put("中通", "zhongtong");
		expressCompany.put("天天", "tiantian");
		expressCompany.put("中铁", "zhongtie");
		expressCompany.put("中邮", "zhongyou");
		expressCompany.put("汇通", "huitong");
		expressCompany.put("国通", "guotong");
		expressCompany.put("优速", "yousu");
		expressCompany.put("全峰", "quanfeng");
		expressCompany.put("京东", "jingdong");
		expressCompany.put("邮政", "ems");
		expressCompany.put("EMS", "ems");
		expressCompany.put("邮政平邮", "pingyou");
		expressCompany.put("邮政小包", "gnxb");
		expressCompany.put("宅急送", "zhaijisong");

		return expressCompany;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getLoc_time() {
		return loc_time;
	}

	public void setLoc_time(String locTime) {
		loc_time = locTime;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getUserwx() {
		return userwx;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
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

	public String getPubTime() {
		return pubTime;
	}

	public void setPubTime(String pubTime) {
		this.pubTime = pubTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
