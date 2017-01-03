package com.wxschool.dpo;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Student;
import com.wxschool.entity.ValidateCode;

public class EduService {
	private RequestConfig defaultRequestConfig = RequestConfig.custom()
			.setSocketTimeout(20000).setConnectTimeout(20000)
			.setConnectionRequestTimeout(20000)
			.setStaleConnectionCheckEnabled(false).build();

	private String getResult(String cookieStr, String url, HttpEntity paras)
			throws ClientProtocolException, IOException {

		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeader("Accept",
				"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
		httpPost.setHeader("Accept-Language",
				"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3");
		httpPost.setHeader("Content-Type",
				"application/x-www-form-urlencoded; charset=UTF-8");
		httpPost.setHeader("Accept-Encoding", "gzip, deflate");
		httpPost.setHeader("X-Ext.Net", "delta=true");
		httpPost.setHeader("X-Requested-With", "XMLHttpRequest");
		httpPost.setHeader("Origin", "http://jwc.hrbnu.edu.cn:8000");
		httpPost.setHeader("Host", "jwc.hrbnu.edu.cn:8000");
		httpPost.setHeader("Connection", "keep-alive");
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
	 * 检测教务平台是否可用
	 * 
	 * @param httpClient
	 * @return
	 */
	public String checkEduAccess() {
		String picUrl = "http://jwc.hrbnu.edu.cn/Account/Access/Login";

		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpGet httpGet = new HttpGet(picUrl);
		httpGet.setHeader("Accept", "*/*");
		httpGet.setHeader("Accept-Language",
				"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3");
		httpGet.setHeader("Content-Type", "image/gif");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "jwc.hrbnu.edu.cn");
		httpGet.setHeader("Referer",
				"http://jwc.hrbnu.edu.cn/Account/Access/Login");
		httpGet.setConfig(defaultRequestConfig);

		try {
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			String respContent = EntityUtils.toString(entity, "UTF-8");
			// System.out.println(respContent);

			Document html = Jsoup.parse(respContent);
			Element requestVerificationToken = html
					.getElementsByAttributeValue("name",
							"__RequestVerificationToken").get(0);
			return requestVerificationToken.val();
		} catch (SocketTimeoutException e) {
		} catch (ConnectionPoolTimeoutException e) {
		} catch (ConnectTimeoutException e) {
		} catch (UnknownHostException e) {
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "checkEduAccess出错；");
		} finally {
			httpGet.releaseConnection();
			try {
				httpClient.close();
			} catch (IOException e) {
			}
		}
		return "wrong";
	}

	/**
	 * 获取验证码
	 * 
	 * @param httpClient
	 * @return
	 */
	public ValidateCode getValidateCode() {
		ValidateCode validateCode = new ValidateCode();

		String picUrl = "http://jwc.hrbnu.edu.cn/Account/Access/GetValidateCode?rnd="
				+ Math.random();

		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpGet httpGet = new HttpGet(picUrl);
		httpGet.setHeader("Accept", "*/*");
		httpGet.setHeader("Accept-Language",
				"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3");
		httpGet.setHeader("Content-Type", "image/gif");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "jwc.hrbnu.edu.cn");
		httpGet.setHeader("Referer",
				"http://jwc.hrbnu.edu.cn/Account/Access/Login");
		httpGet.setConfig(defaultRequestConfig);

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
		} catch (UnknownHostException e) {
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getValidateCode出错；");
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
	 * 获取token
	 * 
	 * @param httpClient
	 * @return
	 */
	public ValidateCode getToken() {
		ValidateCode validateCode = new ValidateCode();

		String picUrl = "http://jwc.hrbnu.edu.cn/Account/Access/Login";

		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpGet httpGet = new HttpGet(picUrl);
		httpGet.setHeader("Accept", "*/*");
		httpGet.setHeader("Accept-Language",
				"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3");
		httpGet.setHeader("Content-Type", "image/gif");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "jwc.hrbnu.edu.cn");
		httpGet.setHeader("Referer",
				"http://jwc.hrbnu.edu.cn/Account/Access/Login");
		// httpGet.setConfig(defaultRequestConfig);

		try {
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			String respContent = EntityUtils.toString(entity, "UTF-8").trim();

			System.out.println(respContent);

			entity = null;
			response = null;
			return validateCode;
		} catch (SocketTimeoutException e) {
			e.printStackTrace();
		} catch (ConnectionPoolTimeoutException e) {
			e.printStackTrace();
		} catch (ConnectTimeoutException e) {
			e.printStackTrace();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
			// LogDao.getLog().addExpLog(e, "getValidateCode出错；");
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
	 * 获取期末成绩
	 * 
	 * @param httpClient
	 * @return
	 */
	public String[][] getScore(String cookieStr) {
		try {
			String json = getResult(cookieStr,
					"http://jwc.hrbnu.edu.cn:8000/XueSheng/chengji/GetXsxycj",
					null);
			// System.out.println(json);
			if (json.indexOf("Object moved to") > -1) {
				return null;
			}

			JSONObject datajo = JSONObject.parseObject(json);

			if (datajo != null && datajo.containsKey("data")) {
				JSONArray ja = datajo.getJSONArray("data");
				int size = ja.size();
				String[][] myScore = new String[size][9];

				for (int i = 0; i < size; i++) {
					JSONObject jo = ja.getJSONObject(i);
					myScore[i][0] = jo.getString("XKKH").substring(1, 12);// 选课课号
					myScore[i][1] = jo.getString("KCMC");// 课程名称
					myScore[i][2] = jo.getString("KCXZ");// 课程性质
					myScore[i][3] = jo.getString("XF");// 学分
					String pscj = jo.getString("PSCJ");// 平时成绩
					myScore[i][4] = pscj == null ? "-" : pscj;
					String qmcj = jo.getString("QMCJ");// 期末成绩
					myScore[i][5] = qmcj == null ? "-" : qmcj;
					String zscj = jo.getString("ZSCJ");// 折合成绩
					myScore[i][6] = zscj == null ? "-" : zscj;
					String bkcj = jo.getString("BKCJ");// 补考成绩
					myScore[i][7] = bkcj == null ? "-" : bkcj;
					String cxcj = jo.getString("CXCJ");// 重修成绩
					myScore[i][8] = cxcj == null ? "-" : cxcj;
					// myScore[i][9] = jo.get("XH");// 学号
					// myScore[i][10] = jo.get("XM");// 姓名
				}
				ja = null;
				datajo = null;
				return myScore;
			} else {
				String errorMessage = datajo.getString("errorMessage");
				String[][] res = { { "false", errorMessage } };
				datajo = null;
				return res;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getScore出错；");
		}
		return null;
	}

	/**
	 * 登录教务平台
	 * 
	 * @param httpClient
	 * @param userName
	 * @param password
	 * @param code
	 * @return "ok"/"wrong"/errorMessage
	 */
	public String isLogin(String cookieStr, String userName, String password,
			String code, String token) {

		String loginURL = "http://jwc.hrbnu.edu.cn/Account/Access/Login";
		CloseableHttpClient httpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(loginURL);
		httpPost.setHeader("Cookie", cookieStr);
		httpPost.setConfig(defaultRequestConfig);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		// nvps.add(new BasicNameValuePair("UserGroup", "0"));
		// nvps.add(new BasicNameValuePair("_UserGroup_state", ""));
		nvps.add(new BasicNameValuePair("UserName", userName));
		nvps.add(new BasicNameValuePair("Password", password));
		nvps.add(new BasicNameValuePair("VerifyCode", code));
		nvps.add(new BasicNameValuePair("ReturnUrl", ""));
		nvps.add(new BasicNameValuePair("__RequestVerificationToken", token));

		try {
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps);
			nvps = null;
			httpPost.setEntity(httpEntity);
			httpEntity = null;

			HttpResponse res = httpClient.execute(httpPost);
			int statusCode = res.getStatusLine().getStatusCode();
			System.out.println(statusCode);
			if (statusCode == 200) {
				String responseBody = EntityUtils.toString(res.getEntity(),
						"UTF-8");
				System.out.println(responseBody);
				JSONObject datajo = JSONObject.parseObject(responseBody);
				String success = datajo.getString("success");
				if (success != null) {
					if (success.equals("true")) {
						return "ok";
					} else if (success.equals("false")) {
						return datajo.getString("errorMessage");
					}
				}
			}
			res = null;
		} catch (Exception e) {
			e.printStackTrace();
			LogDao.getLog().addExpLog(e,
					"isLogin出错；userName:" + userName + ",password:" + password);
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
	 * 获取学生信息
	 * 
	 * @param httpClient
	 * @return
	 */
	public Student getStuInfo(String cookieStr) {
		try {
			String json = getResult(cookieStr,
					"http://jwc.hrbnu.edu.cn:8000/xuesheng/xueji/JsonXsjbxx",
					null);
			if (json.indexOf("Object moved to") > -1) {
				return null;
			}

			JSONObject datajo = JSONObject.parseObject(json);

			Student stu = new Student();
			stu.setDepart(datajo.getString("XY"));// 学院
			stu.setGrade(datajo.getString("DQSZJ"));// 年级
			stu.setMajor(datajo.getString("ZYMC"));// 专业
			stu.setStuNum(datajo.getString("XH"));// 学号
			stu.setStuName(datajo.getString("XM"));// 姓名
			// 隐私数据
			stu.setIDCard(datajo.getString("SFZH"));// 身份证号
			stu.setTrueSex(datajo.getString("XB"));// 真实性别
			stu.setOriginProvince(datajo.getString("LYS"));// 来源省

			// 高考分数
			String gkScore = datajo.getString("RXZF");
			if (gkScore == null || gkScore.equals("null") || gkScore.equals("")) {
				stu.setGkScore("0");
			} else {
				stu.setGkScore(gkScore);
			}

			datajo = null;
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getStuInfo出错；");
		}
		return null;
	}

	/**
	 * 评教
	 * 
	 * @param httpClient
	 * @return
	 */
	public boolean evaluate(String cookieStr) {
		try {
			String json1 = getResult(
					cookieStr,
					"http://jwc.hrbnu.edu.cn:8000/XueSheng/pingjiao/GetXsjxzlpjrw",
					null);// 获取评价课程
			JSONObject datajo = JSONObject.parseObject(json1);
			JSONArray ja = datajo.getJSONArray("data");

			for (int i = 0; i < ja.size(); i++) {
				JSONObject jo = ja.getJSONObject(i);
				if (jo.getString("PJZT") == null
						|| jo.getString("PJZT").equals("null")) {
					// StringBuffer sb = new StringBuffer();
					// sb.append("XKKH=" + jo.get("XKKH"));
					// for (int j = 1; j <= 20; j++) {
					// String n = "PJH";
					// n += j < 10 ? "0" + j : j;
					// int m = (int) (Math.random() * 8) + 3;
					// m = m % 2 == 0 ? m : (m - 1);
					// sb.append("&" + n + "=" + m);
					// sb.append("&_" + n+ "_state=%5B%7B%22value%22%3A%22"
					// + m+ "%22%2C%22text%22%3A%22" + m+
					// "%22%2C%22index%22%3A1%7D%5D");
					// }
					// sb.append("&PJLY=");
					// String params = sb.toString();
					String params = "XKKH="
							+ jo.getString("XKKH")
							+ "&PJH01=4&_PJH01_state=%5B%7B%22value%22%3A%224%22%2C%22text%22%3A%224%22%2C%22index%22%3A1%7D%5D&PJH02=8&_PJH02_state=%5B%7B%22value%22%3A%228%22%2C%22text%22%3A%228%22%2C%22index%22%3A1%7D%5D&PJH03=8&_PJH03_state=%5B%7B%22value%22%3A%228%22%2C%22text%22%3A%228%22%2C%22index%22%3A1%7D%5D&PJH04=12&_PJH04_state=%5B%7B%22value%22%3A%2212%22%2C%22text%22%3A%2212%22%2C%22index%22%3A1%7D%5D&PJH05=8&_PJH05_state=%5B%7B%22value%22%3A%228%22%2C%22text%22%3A%228%22%2C%22index%22%3A1%7D%5D&PJH06=12&_PJH06_state=%5B%7B%22value%22%3A%2212%22%2C%22text%22%3A%2212%22%2C%22index%22%3A1%7D%5D&PJH07=8&_PJH07_state=%5B%7B%22value%22%3A%228%22%2C%22text%22%3A%228%22%2C%22index%22%3A1%7D%5D&PJH08=8&_PJH08_state=%5B%7B%22value%22%3A%228%22%2C%22text%22%3A%228%22%2C%22index%22%3A1%7D%5D&PJH09=8&_PJH09_state=%5B%7B%22value%22%3A%228%22%2C%22text%22%3A%228%22%2C%22index%22%3A1%7D%5D&PJH10=4&_PJH10_state=%5B%7B%22value%22%3A%224%22%2C%22text%22%3A%224%22%2C%22index%22%3A1%7D%5D&PJLY=";

					HttpEntity entity = new StringEntity(params);
					getResult(
							cookieStr,
							"http://jwc.hrbnu.edu.cn:8000/XueSheng/pingjiao/SaveXsjxzlpj",
							entity);// 提交评价
				}
			}
			datajo = null;
			ja = null;
			return true;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "evaluate出错；");
		}
		return false;
	}

	/**
	 * 我的校选修
	 * 
	 * @param httpClient
	 * @return
	 */
	public String myCourse(String cookieStr) {
		try {
			String json = getResult(cookieStr,
					"http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/Getxxkyxkc",
					null);
			// System.out.println(json);
			if (json.indexOf("Object moved to") > -1) {
				return null;
			}

			JSONObject datajo = JSONObject.parseObject(json);

			if (datajo != null && datajo.containsKey("data")) {
				JSONArray ja = datajo.getJSONArray("data");
				int size = ja.size();

				if (size == 0) {
					return "no";
				} else {
					StringBuffer sb = new StringBuffer();
					for (int i = 0; i < size; i++) {
						JSONObject jo = ja.getJSONObject(i);
						sb.append(jo.getString("KCMC"));
						sb.append("-");
						sb.append(jo.getString("XQBS"));
						sb.append(jo.getString("SKDD"));
						sb.append("周");
						sb.append(jo.getString("SKSJ"));
						sb.append("-");
						sb.append(jo.getString("JSXM"));
						sb.append(";");
					}
					return sb.toString();
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "myCourse出错；");
		}
		return null;
	}
}
