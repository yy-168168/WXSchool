package com.wxschool.dpo;

import java.util.*;
import java.util.Map.Entry;

import com.wxschool.dao.AccountDao;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Config;
import com.wxschool.entity.Dqorder;
import com.wxschool.entity.News;
import com.wxschool.util.*;

public class ExpressService {

	public News computeReceive(String wxaccount, String receiveContent) {

		String com = ExpressService.getENname(receiveContent);// 快递公司
		String num = "";// 运单号

		if (receiveContent.startsWith("邮政小包")) {
			num = receiveContent.substring(receiveContent.indexOf("包") + 1)
					.trim();
		} else if (receiveContent.startsWith("邮政平邮")) {
			num = receiveContent.substring(receiveContent.indexOf("平邮") + 2)
					.trim();
		} else if (receiveContent.toLowerCase().startsWith("ems")) {
			num = receiveContent.substring(3).trim();
		} else if (receiveContent.startsWith("宅急送")) {
			num = receiveContent.substring(3).trim();
		} else {
			num = receiveContent.substring(2).trim();
		}

		News news = new News();
		news.setPicUrl("");

		String ex = getExpress(wxaccount, com, num);

		if (ex == null || ex.indexOf("NULL") > -1) {
			news.setTitle("点击进入使用网址查询");
			news.setDescription("单号不存在，或者还未发货\n查快递格式如：\n圆通  3230169980");
			news.setUrl("http://m.kuaidi100.com/uc/index.html");
		} else if (ex.indexOf("正确") > -1 || ex.indexOf("错误") > -1
				|| ex.indexOf("不存在") > -1) {
			news.setTitle("点击进入使用网址查询");
			news.setDescription(ex + "格式如：圆通  3230169980\n邮政分：EMS  邮政小包  邮政平邮");
			news.setUrl("http://m.kuaidi100.com/uc/index.html");
		} else {
			String url = Config.SITEURL + "/mobile/other?ac=query&wxaccount="
					+ wxaccount + "&com=" + com + "&num=" + num;
			String CNcom = getCNname(com);
			news.setTitle(CNcom + num + "(点击进入可以实时查询)");
			news.setDescription(ex);
			news.setUrl(url);
		}
		return news;
	}

	public String getExpress(String wxaccount, String com, String nu) {
		AccountDao aDao = new AccountDao();
		aDao.updateFiled(wxaccount, "express", 1);
		aDao = null;

		String url = "http://api.ickd.cn";
		String paras = "com=" + com + "&nu=" + nu
				+ "&id=986973C19825E28831C1870D567B8C49&type=text&encode=utf8";
		try {
			String str = HttpUtils.doGet(url, paras, "UTF-8");
			return str;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "com:" + com + ",num:" + nu);
			return null;
		}
	}

	public static String getENname(String key) {
		String com = null;

		if (key.matches(".*快递.*")) {

		} else if (key.matches(".*邮政小包.*")) {
			com = "pingyou";
		} else if (key.matches(".*邮政平邮.*")) {
			com = "pingyou";
		} else if (key.toLowerCase().matches(".*ems.*")
				|| key.matches(".*邮政.*")) {
			com = "ems";
		} else if (key.matches(".*宅急送.*")) {
			com = "zhaijisong";
		} else if (key.length() >= 2) {
			key = key.substring(0, 2);

			Map<String, String> expressCom = Dqorder
					.getExpressCompanyAndEnname();
			com = expressCom.get(key.toUpperCase());
			expressCom = null;
		}

		return com;
	}

	public static String getCNname(String com) {
		Map<String, String> expressCom = Dqorder.getExpressCompanyAndEnname();
		Set<Entry<String, String>> expressCom_set = expressCom.entrySet();
		Iterator<Entry<String, String>> expressCom_iterator = expressCom_set
				.iterator();

		while (expressCom_iterator.hasNext()) {
			Entry<String, String> e = expressCom_iterator.next();
			if (e.getValue().equals(com)) {
				return e.getKey();
			}

		}
		return "";
	}

	public static void main(String[] args) {
		// System.out.println(new ExpressDpo().getExpress("1", "jingdong",
		// "5204782031"));
		// System.out.println(new ExpressDpo().getExpress("huitong",
		// "210513801114"));
		new ExpressService().computeReceive("1", "中通371166376789");
	}
}
