package com.wxschool.entity;

public class Student {

	private int stuId;
	private String wxaccount;
	private String userwx;
	private String stuNum;
	private String personId;
	private String password;
	private String stuName;
	private String grade;
	private String depart;
	private String major;
	private String province;
	private String city;
	private String county;
	private String find;
	private String cetNum;
	private String cetName;
	private String selCourse;
	private int sex;
	private int status;
	private String IDCard;
	private String trueSex;
	private String gkScore;
	private String originProvince;

	private WxUser wxUser;

	public int getStuId() {
		return stuId;
	}

	public void setStuId(int stuId) {
		this.stuId = stuId;
	}

	public String getUserwx() {
		return userwx;
	}

	public void setUserwx(String userwx) {
		this.userwx = userwx;
	}

	public String getGkScore() {
		return gkScore;
	}

	public void setGkScore(String gkScore) {
		this.gkScore = gkScore;
	}

	public String getSelCourse() {
		return selCourse;
	}

	public void setSelCourse(String selCourse) {
		this.selCourse = selCourse;
	}

	public String getWxaccount() {
		return wxaccount;
	}

	public void setWxaccount(String wxaccount) {
		this.wxaccount = wxaccount;
	}

	public String getDepart() {
		return depart;
	}

	public void setDepart(String depart) {
		this.depart = depart;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getStuNum() {
		return stuNum;
	}

	public void setStuNum(String stuNum) {
		this.stuNum = stuNum;
	}

	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId.replace("'", "\\'");
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password.replace("'", "\\'");
	}

	public String getStuName() {
		return stuName;
	}

	public void setStuName(String stuName) {
		this.stuName = stuName;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getCetNum() {
		return cetNum;
	}

	public void setCetNum(String cetNum) {
		this.cetNum = cetNum;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
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

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getCetName() {
		return cetName;
	}

	public void setCetName(String cetName) {
		this.cetName = cetName;
	}

	public String getFind() {
		return find;
	}

	public void setFind(String find) {
		this.find = find;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getIDCard() {
		return IDCard;
	}

	public void setIDCard(String iDCard) {
		IDCard = iDCard;
	}

	public String getTrueSex() {
		return trueSex;
	}

	public void setTrueSex(String trueSex) {
		this.trueSex = trueSex;
	}

	public String getOriginProvince() {
		return originProvince;
	}

	public void setOriginProvince(String originProvince) {
		this.originProvince = originProvince;
	}

	public WxUser getWxUser() {
		return wxUser;
	}

	public void setWxUser(WxUser wxUser) {
		this.wxUser = wxUser;
	}

}
