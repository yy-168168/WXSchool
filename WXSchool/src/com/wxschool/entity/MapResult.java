package com.wxschool.entity;

import java.util.ArrayList;
import java.util.List;

public class MapResult {
	private String lng;
	private String lat;
	private List<Address> results = new ArrayList<Address>();

	public String getLng() {
		return lng;
	}

	public void setLng(String lng) {
		this.lng = lng;
	}

	public String getLat() {
		return lat;
	}

	public void setLat(String lat) {
		this.lat = lat;
	}

	public List<Address> getResults() {
		return results;
	}

	public void setResults(List<Address> results) {
		this.results = results;
	}
}
