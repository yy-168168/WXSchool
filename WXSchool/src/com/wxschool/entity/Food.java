package com.wxschool.entity;

public class Food {

	private int foodId;
	private String foodName;
	private String price;
	private int type;
	private int sort;
	private String locUrl;
	private int status;

	public int getFoodId() {
		return foodId;
	}

	public void setFoodId(int foodId) {
		this.foodId = foodId;
	}

	public String getFoodName() {
		return foodName;
	}

	public void setFoodName(String foodName) {
		this.foodName = foodName;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getLocUrl() {
		return locUrl;
	}

	public void setLocUrl(String locUrl) {
		this.locUrl = locUrl;
	}
}
