package com.wxschool.entity;

import java.util.ArrayList;
import java.util.List;

public class CourseList {

	private int day;
	private List<Course> courses = new ArrayList<Course>();

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public List<Course> getCourses() {
		return courses;
	}

	public void setCourses(List<Course> courses) {
		this.courses = courses;
	}
}
