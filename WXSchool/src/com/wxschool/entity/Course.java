package com.wxschool.entity;

public class Course {

	private int courseId;
	private int day;
	private String coureName;
	private String teacher;
	private String address;
	private int startLession;
	private int endLession;
	private int startWeek;
	private int endWeek;
	private int isDifWeek;
	private String major;
	private String grade;
	private String picUrl;
	private int visitPerson;
	private String wxaccount;

	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getCoureName() {
		return coureName;
	}

	public void setCoureName(String coureName) {
		this.coureName = coureName;
	}

	public String getTeacher() {
		return teacher;
	}

	public void setTeacher(String teacher) {
		this.teacher = teacher;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getStartLession() {
		return startLession;
	}

	public void setStartLession(int startLession) {
		this.startLession = startLession;
	}

	public int getEndLession() {
		return endLession;
	}

	public void setEndLession(int endLession) {
		this.endLession = endLession;
	}

	public int getStartWeek() {
		return startWeek;
	}

	public void setStartWeek(int startWeek) {
		this.startWeek = startWeek;
	}

	public int getEndWeek() {
		return endWeek;
	}

	public void setEndWeek(int endWeek) {
		this.endWeek = endWeek;
	}

	public int getIsDifWeek() {
		return isDifWeek;
	}

	public void setIsDifWeek(int isDifWeek) {
		this.isDifWeek = isDifWeek;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getWxaccount() {
		return wxaccount;
	}

	public void setWxaccount(String wxaccount) {
		this.wxaccount = wxaccount;
	}

	public String getPicUrl() {
		return picUrl;
	}

	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}

	public int getVisitPerson() {
		return visitPerson;
	}

	public void setVisitPerson(int visitPerson) {
		this.visitPerson = visitPerson;
	}
}
