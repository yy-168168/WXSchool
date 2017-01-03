package com.wxschool.dpo;

import java.io.IOException;
import java.net.*;

import org.dom4j.*;

import com.wxschool.dao.AccountDao;
import com.wxschool.dao.LogDao;
import com.wxschool.util.HttpUtils;

public class WeatherService {

	public String computeReceive(String wxaccount, String receiveContent) {
		AccountDao aDao = new AccountDao();
		aDao.updateFiled(wxaccount, "weather", 1);
		aDao = null;

		String city = "";
		if (receiveContent.equals("天气") || receiveContent.matches(".*天气.*查.*")
				|| receiveContent.matches(".*查.*天气.*")) {
			city = "哈尔滨";
		} else if (receiveContent.startsWith("天气")) {
			city = receiveContent.substring(2).trim();
		} else if (receiveContent.endsWith("天气")) {
			city = receiveContent.substring(0, receiveContent.length() - 2)
					.trim();
		} else {
			city = "哈尔滨";
		}
		String replyContent = getWeather(city);
		return replyContent;
	}

	public String getWeather(String city) {
		String reply = "";

		try {
			StringBuffer sb = new StringBuffer();

			String todayXml = getConnetion(city, 0);
			String today = getMoreInfo(todayXml);
			if (today == null) {
				return "查询天气出错";
			} else {
				sb.append(city + "实时天气  " + todayXml.substring(57, 73)
						+ "发布:\n\n");
				sb.append(today);
				String tomorXml = getConnetion(city, 1);
				String tomor = getMoreInfo(tomorXml);
				if (tomor == null) {
					reply = sb.toString();
				} else {
					sb.append("\n\n明日天气  ");
					sb.append(tomor);
					String thirdXml = getConnetion(city, 2);
					String third = getLittleInfo(thirdXml);
					if (third == null) {
						reply = sb.toString();
					} else {
						sb.append("\n\n后天天气  ");
						sb.append(third);
						reply = sb.toString();
					}
				}
			}
		} catch (NullPointerException e) {
			return "所输城市名需为省/市/县等地名\n格式为：北京 天气";
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "city:" + city);
			return "查询天气出错";
		}

		reply += "\n\n其他城市天气请回复'城市名 天气' 如：北京 天气";
		return reply;
	}

	private String getConnetion(String city, int day) throws IOException {

		city = URLEncoder.encode(city, "GBK");
		String url = "http://php.weather.sina.com.cn/xml.php?city=" + city
				+ "&password=DJOYnieT8234jlsK&day=" + day;
		String str = HttpUtils.doGet(url, null, "UTF-8");
		return str;
	}

	private String getMoreInfo(String xml) {

		StringBuffer res = new StringBuffer();
		try {
			Document document = DocumentHelper.parseText(xml);

			Element root = document.getRootElement();
			Element first = root.element("Weather");

			String status1 = first.elementText("status1");
			String status2 = first.elementText("status2");
			if (!status1.equals(status2) && !status2.equals("")) {
				res.append(status1 + "转" + status2 + " ");
			} else {
				res.append(status1 + " ");
			}
			String temperature1 = first.elementText("temperature1");
			String temperature2 = first.elementText("temperature2");
			res.append(temperature2 + "~" + temperature1 + "°C ");
			String direction1 = first.elementText("direction1");
			String power1 = first.elementText("power1");
			res.append(direction1 + power1 + "级\n");
			String gm_l = first.elementText("gm_l");
			String gm_s = first.elementText("gm_s");
			res.append("感冒指数:" + gm_l + "  " + gm_s + "\n");
			String yd_s = first.elementText("yd_s");
			res.append("运动指数:" + yd_s + "\n");
			String zwx_l = first.elementText("zwx_l");
			res.append("紫外线指数:" + zwx_l);
		} catch (Exception e) {
			return null;
		}

		return res.toString();
	}

	private String getLittleInfo(String xml) {

		StringBuffer res = new StringBuffer();
		try {
			Document document = DocumentHelper.parseText(xml);

			Element root = document.getRootElement();
			Element first = root.element("Weather");

			res.append("天气  ");
			String status1 = first.elementText("status1");
			String status2 = first.elementText("status2");
			if (!status1.equals(status2) && !status2.equals("")) {
				res.append(status1 + "转" + status2 + " ");
			} else {
				res.append(status1 + " ");
			}
			String temperature1 = first.elementText("temperature1");
			String temperature2 = first.elementText("temperature2");
			res.append(temperature2 + "~" + temperature1 + "°C ");
			String direction1 = first.elementText("direction1");
			String power1 = first.elementText("power1");
			res.append(direction1 + power1 + "级");
		} catch (Exception e) {
			return null;
		}

		return res.toString();
	}

	public static void main(String[] args) {
		WeatherService weatherDpo = new WeatherService();
		System.out.println(weatherDpo.computeReceive("", "北京 天气"));
	}
}
