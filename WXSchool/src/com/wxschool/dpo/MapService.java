package com.wxschool.dpo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import com.alibaba.fastjson.*;
import com.wxschool.entity.*;
import com.wxschool.util.*;

public class MapService {

	public String searchRound(String px, String py, String tar) {
		if (tar.equals("wc")) {
			tar = "公共厕所";
		}

		try {
			tar = URLEncoder.encode(tar, "GBK");
		} catch (UnsupportedEncodingException e1) {
			tar = "公共厕所";
		}

		String url = "http://api.map.baidu.com/place/v2/search?&query="
				+ tar
				+ "&location="
				+ px
				+ ","
				+ py
				+ "&radius=1000&output=json&ak=8079e888ed39985d6c2869d64af2ae2f";
		String reply = "";
		try {
			MapResult mr = new MapResult();
			mr.setLat(px);
			mr.setLng(py);

			// String json = OpenUrl.getStr(url);
			String json = HttpUtils.doGet(url, null, "UTF-8");
			JSONObject jo = JSONObject.parseObject(json);
			JSONArray results = jo.getJSONArray("results");
			Address add = null;
			JSONObject jsadd = null;
			for (int i = 0; i < results.size(); i++) {
				jsadd = results.getJSONObject(i);
				add = new Address();
				add.setAddress(jsadd.getString("address"));
				add.setName(jsadd.getString("name"));
				add.setLat(jsadd.getJSONObject("location").getString("lat"));
				add.setLng(jsadd.getJSONObject("location").getString("lng"));
				mr.getResults().add(add);
			}
			reply = JSONObject.toJSONString(mr);
		} catch (Exception e) {
			return "wrong";
		}
		return reply;
	}
}
