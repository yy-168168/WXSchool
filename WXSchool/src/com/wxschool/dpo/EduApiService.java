package com.wxschool.dpo;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.httpclient.ConnectTimeoutException;
import org.apache.commons.httpclient.ConnectionPoolTimeoutException;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.wxschool.dao.LogDao;
import com.wxschool.entity.ValidateCode;

public class EduApiService {
	
	//测试账号:1543010510  619619
	
	private RequestConfig defaultRequestConfig = RequestConfig.custom()
			.setSocketTimeout(20000).setConnectTimeout(20000)
			.setConnectionRequestTimeout(20000).setStaleConnectionCheckEnabled(
					false).build();

	private String getResult(String cookieStr, String url, HttpEntity paras)
			throws ClientProtocolException, IOException {

		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Cookie", cookieStr);
		httpPost.setConfig(defaultRequestConfig);
		String responseBody = null;

		try {
			if (paras != null) {
				httpPost.setEntity(paras);
			}
			HttpResponse response = httpClient.execute(httpPost);
			// System.out.println(response.getStatusLine().getStatusCode());
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				responseBody = EntityUtils.toString(entity, "UTF-8");

				// System.out.println(responseBody);
			}
			entity = null;
			response = null;
		} finally {
			httpPost.releaseConnection();
			httpClient.close();
		}
		return responseBody;
	}

	/**
	 * 获取牡丹江医学院验证码
	 * 
	 * @param httpClient
	 * @return
	 */
	public ValidateCode getValidateCode() {
		ValidateCode validateCode = new ValidateCode();

		String picUrl = "http://218.7.95.52:800/ACTIONVALIDATERANDOMPICTURE.APPPROCESS?id="
				+ Math.random();
		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpGet httpGet = new HttpGet(picUrl);
		httpGet.setConfig(defaultRequestConfig);
		httpGet.setHeader("Accept", "image/webp,*/*;q=0.8");
		httpGet.setHeader("Accept-Language",
				"zh-CN,zh;q=0.8,en;q=0.6,zh-TW;q=0.4");
		httpGet.setHeader("Content-Type", "image/gif");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "218.7.95.52:800");
		httpGet.setHeader("Referer",
				"http://218.7.95.52:800/ACTIONLOGON.APPPROCESS");

		try {
			HttpResponse response = httpClient.execute(httpGet);

			// 保存cookie
			Header[] headers = response.getAllHeaders();
			String cookieStr = "";
			for (int i = 0; i < headers.length; i++) {
				String name = headers[i].getName();
				String val = headers[i].getValue();
				// System.out.println(name+" "+val);
				if ("Set-Cookie".equalsIgnoreCase(name)) {
					if (!cookieStr.equals("")) {
						cookieStr += ";";
					}
					cookieStr += val;
				}
			}
			validateCode.setCookieStr(cookieStr);

			HttpEntity entity = response.getEntity();
			InputStream is = entity.getContent();
			BufferedImage image = ImageIO.read(is);
			validateCode.setBufferedImage(image);

			is = null;
			entity = null;
			response = null;
			return validateCode;
		} catch (SocketTimeoutException e) {
		} catch (ConnectionPoolTimeoutException e) {
		} catch (ConnectTimeoutException e) {
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "获取牡丹江医学院验证码；");
		} finally {
			httpGet.releaseConnection();
			try {
				httpClient.close();
			} catch (IOException e) {
			}
		}
		return null;
	}

	/**
	 * 登录牡丹江医学院教务平台
	 * 
	 * @param httpClient
	 * @param userName
	 * @param password
	 * @param code
	 * @return "ok"/"wrong"/errorMessage
	 */
	public String isLogin(String cookieStr, String userName, String password,
			String code) {

		String loginURL = "http://218.7.95.52:800/ACTIONLOGON.APPPROCESS";
		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(loginURL);
		httpPost.setHeader("Cookie", cookieStr);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("WebUserNO", userName));
		nvps.add(new BasicNameValuePair("Password", password));
		nvps.add(new BasicNameValuePair("Agnomen", code));
		nvps.add(new BasicNameValuePair("submit.x", "7"));
		nvps.add(new BasicNameValuePair("submit.y", "12"));
		nvps
				.add(new BasicNameValuePair("applicant",
						"ACTIONQUERYSTUDENTSCORE"));

		try {
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps);
			nvps = null;
			httpPost.setEntity(httpEntity);
			httpEntity = null;

			HttpResponse res = httpClient.execute(httpPost);
			int statusCode = res.getStatusLine().getStatusCode();
			res = null;
			// System.out.println(statusCode);

			if (statusCode == 302) {
				return "ok";
			} else {
				return "notRight";
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"登录牡丹江医学院教务平；userName:" + userName + ",password:"
							+ password);
		} finally {
			httpPost.releaseConnection();
			try {
				httpClient.close();
			} catch (IOException e) {
			}
		}
		return "wrong";
	}

	/**
	 * 获取牡丹江医学院期末成绩
	 * 
	 * @param httpClient
	 * @return
	 */
	public String[][] getScore(String cookieStr, String yearTrem) {
		try {
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("YearTermNO", yearTrem));
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps);

			String html = getResult(
					cookieStr,
					"http://218.7.95.52:800/ACTIONQUERYSTUDENTSCORE.APPPROCESS",
					httpEntity);

			Document doc = Jsoup.parse(html);
			Elements tables = doc.getElementsByTag("table");
			if (tables.size() < 3) {
				return null;
			}
			Element table = tables.get(3);
			Elements trs = table.getElementsByTag("tr");

			String[][] myScore = new String[trs.size() - 2][9];
			// 课程性质 课程号 课程名称 考试类型 学时 学分 成绩类型 期末成绩 总评成绩

			for (int i = 0; i < trs.size() - 2; i++) {
				Element tr = trs.get(i + 1);
				Elements tds = tr.getElementsByTag("td");
				for (int j = 0; j < tds.size(); j++) {
					Element td = tds.get(j);
					String text = td.text().replace("&nbsp;", "");
					myScore[i][j] = text;
				}
			}
			return myScore;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "获取牡丹江医学院期末成绩；");
		}
		return null;
	}
}
