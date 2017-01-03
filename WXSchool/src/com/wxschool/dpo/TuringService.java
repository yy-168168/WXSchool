package com.wxschool.dpo;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.News;
import com.wxschool.web.MsgSendManager;

public class TuringService {

	private MsgSendManager msm = MsgSendManager.instance();

	public static void main(String[] args) {
		System.out.println(new TuringService().compute("", "", "在么"));
	}

	public String compute(String user, String developer, String info) {
		JSONObject jo = getFromTuring(info);
		String reply = "";
		if (jo != null) {
			String code = jo.getString("code");

			if (code.equals("100000")) {
				String text = jo.getString("text");

				// 如果是疑问句加入客服提醒
				String[] yiwenci = { "吗", "?", "？", "人工", "怎样", "怎么", "什么时候",
						"哪里", "多少" };
				for (int i = 0; i < yiwenci.length; i++) {
					if (info.indexOf(yiwenci[i]) > -1) {
						text += "\n\n如需帮助，请回复【客服】";
						break;
					}
				}

				// 过滤敏感词
				text = text.replace("图灵", "");

				reply = msm.replyText(user, developer, text);
			} else if (code.equals("200000")) {
				String text = jo.getString("text");
				String url = jo.getString("url");
				reply = msm.replyText(user, developer, "<a href='" + url + "'>"
						+ text + "</a>");
			} else if (code.equals("301000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String name = joi.getString("name");
					String author = joi.getString("author");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(name + " " + author);
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			} else if (code.equals("302000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String article = joi.getString("article");
					// String source = joi.getString("source");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(article);
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			} else if (code.equals("304000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String name = joi.getString("name");
					String count = joi.getString("count");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(name + " " + count + "下载量");
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			} else if (code.equals("305000")) {
				JSONArray list = jo.getJSONArray("list");
				StringBuffer temp = new StringBuffer();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String start = joi.getString("start");
					String terminal = joi.getString("terminal");
					String starttime = joi.getString("starttime");
					String endtime = joi.getString("endtime");

					temp.append(start + "(" + starttime + ")->" + terminal
							+ "(" + endtime + ")\n");
				}
				reply = msm.replyText(user, developer, temp.toString());
			} else if (code.equals("306000")) {
				JSONArray list = jo.getJSONArray("list");
				StringBuffer temp = new StringBuffer();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String flight = joi.getString("flight");
					String route = joi.getString("route");
					String starttime = joi.getString("starttime");
					String endtime = joi.getString("endtime");
					String state = joi.getString("state");

					temp.append("航班:" + flight + "\n路线:" + route + "\n起飞:"
							+ starttime + "\n到达:" + endtime + "\n状态:" + state
							+ "\n");
				}
				reply = msm.replyText(user, developer, temp.toString());
			} else if (code.equals("307000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String name = joi.getString("name");
					String count = joi.getString("count");
					String price = joi.getString("price");
					// String infom = joi.getString("infom");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(name + " ￥" + price + " " + count + "人参与");
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			} else if (code.equals("308000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String name = joi.getString("name");
					String infom = joi.getString("infom");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(name + " " + infom);
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			} else if (code.equals("309000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String name = joi.getString("name");
					// String count = joi.getString("count");
					String price = joi.getString("price");
					String satisfaction = joi.getString("satisfaction");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(name + " ￥" + price + " 满意度为" + satisfaction);
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			} else if (code.equals("311000") || code.equals("312000")) {
				JSONArray list = jo.getJSONArray("list");
				List<News> nsl = new ArrayList<News>();

				for (int i = 0; i < list.size() && i < 9; i++) {
					JSONObject joi = list.getJSONObject(i);
					String name = joi.getString("name");
					String price = joi.getString("price");
					String detailurl = joi.getString("detailurl");
					String icon = joi.getString("icon");

					News ns = new News();
					ns.setTitle(name + " ￥" + price);
					ns.setPicUrl(icon);
					ns.setUrl(detailurl);
					nsl.add(ns);
				}
				reply = msm.replyNewsList(user, developer, nsl);
			}
		}
		return reply;
	}

	private JSONObject getFromTuring(String info) {
		String url = "http://www.tuling123.com/openapi/api";
		String queryString = "key=04beb14b2214cbe2b7b7f7508e8ab4a2&info=";
		try {
			StringBuffer temp = new StringBuffer();
			info = URLEncoder.encode(info, "utf-8");
			URL u = new URL(url + "?" + queryString + info);
			InputStream is = u.openStream();
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					is, "utf-8"));
			String line = null;
			while ((line = reader.readLine()) != null) {
				temp.append(line + "\n");
			}
			reader.close();
			is.close();

			return JSON.parseObject(temp.toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "调用图灵接口出错;content:" + info);
			return null;
		}
	}
}
