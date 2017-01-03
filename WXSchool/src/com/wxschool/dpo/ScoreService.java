package com.wxschool.dpo;

import java.awt.image.BufferedImage;
import java.io.*;
import java.net.SocketTimeoutException;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;
import javax.imageio.ImageIO;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.ConnectionPoolTimeoutException;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import com.alibaba.fastjson.*;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Student;

public class ScoreService {

	private String getResult(HttpClient httpClient, String url, HttpEntity paras)
			throws ClientProtocolException, IOException {

		HttpPost httpPost = new HttpPost(url);
		httpPost
				.setHeader("Accept",
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
		String responseBody = null;

		try {
			// httpClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT,
			// 10000);
			// httpClient.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,
			// 30000);

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
		}
		return responseBody;
	}

	/**
	 * 检测教务平台是否可用
	 * 
	 * @param httpClient
	 * @return
	 */
	public boolean checkEduAccess() {
		String picUrl = "http://jwc.hrbnu.edu.cn:8000/Account/access/GetValidateCode?id="
				+ Math.random();

		HttpClient httpClient = HttpClients.createDefault();
		HttpGet httpGet = new HttpGet(picUrl);
		httpGet.setHeader("Accept", "image/png,image/*;q=0.8,*/*;q=0.5");
		httpGet.setHeader("Accept-Language",
				"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3");
		httpGet.setHeader("Content-Type", "image/gif");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "jwc.hrbnu.edu.cn:8000");
		httpGet
				.setHeader("Referer",
						"http://jwc.hrbnu.edu.cn:8000/Account/access/Login?ReturnUrl=%2Fmain%2Findex");

		try {
			httpClient.execute(httpGet);

			return true;
		} catch (SocketTimeoutException e) {
		} catch (ConnectionPoolTimeoutException e) {
		} catch (ConnectTimeoutException e) {
		} catch (UnknownHostException e) {
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "checkEduAccess出错；");
		} finally {
			httpGet.releaseConnection();
			httpClient = null;
		}
		return false;
	}

	/**
	 * 获取验证码
	 * 
	 * @param httpClient
	 * @return
	 */
	public BufferedImage getValidateCode(HttpClient httpClient) {
		String picUrl = "http://jwc.hrbnu.edu.cn:8000/Account/access/GetValidateCode?id="
				+ Math.random();
		HttpGet httpGet = new HttpGet(picUrl);
		httpGet.setHeader("Accept", "image/png,image/*;q=0.8,*/*;q=0.5");
		httpGet.setHeader("Accept-Language",
				"zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3");
		httpGet.setHeader("Content-Type", "image/gif");
		httpGet.setHeader("Connection", "keep-alive");
		httpGet.setHeader("Host", "jwc.hrbnu.edu.cn:8000");
		httpGet
				.setHeader("Referer",
						"http://jwc.hrbnu.edu.cn:8000/Account/access/Login?ReturnUrl=%2Fmain%2Findex");

		try {
			HttpResponse response = httpClient.execute(httpGet);
			HttpEntity entity = response.getEntity();
			InputStream is = entity.getContent();
			BufferedImage image = ImageIO.read(is);

			is = null;
			entity = null;
			response = null;
			return image;
		} catch (SocketTimeoutException e) {
		} catch (ConnectionPoolTimeoutException e) {
		} catch (ConnectTimeoutException e) {
		} catch (UnknownHostException e) {
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getValidateCode出错；");
		} finally {
			httpGet.releaseConnection();
		}
		return null;
	}

	/**
	 * 获取期末成绩
	 * 
	 * @param httpClient
	 * @return
	 */
	/*public String[][] getScore(HttpClient httpClient) {
		try {
			String json = getResult(httpClient,
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
	}*/

	/**
	 * 获取所有可选的校选修课程
	 * 
	 * @param httpClient
	 * @param xqbs
	 * @return
	 */
	public String[][] getAllCourse(HttpClient httpClient, String param, int cate) {
		try {

			param = URLEncoder.encode(URLEncoder.encode(param, "UTF-8"),
					"UTF-8");

			String url = "";
			if (cate == 1) {
				url = "http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/Getxxkjxrw?xqbs="
						+ param;
			} else if (cate == 2) {
				url = "http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/GetTykjxrw?xzb="
						+ param;
			}
			String json = getResult(httpClient, url, null);
			// System.out.println(json);
			JSONObject datajo = JSONObject.parseObject(json);

			if (datajo != null && datajo.containsKey("data")) {
				String[][] sels = getCourseSelCount(httpClient, param, cate);// 已选人数
				if (sels == null) {
					return null;
				}

				JSONArray ja = datajo.getJSONArray("data");
				int size = ja.size();
				String[][] courses = new String[size][6];

				int j = 0;
				for (int i = 0; i < size; i++) {
					JSONObject jo = ja.getJSONObject(i);
					String xkkh = jo.getString("XKKH");
					int rs = jo.getIntValue("RS");// 总人数

					for (int k = 0; k < sels.length; k++) {
						if (xkkh.equals(sels[k][0])
								&& Math.round(Float.parseFloat(sels[k][1])) < rs) {
							courses[j][0] = xkkh;// 选课课号
							courses[j][1] = jo.getString("KCMC");// 课程名称
							courses[j][2] = jo.getString("SKSJ");// 上课时间
							courses[j][3] = jo.getString("SKDD");// 上课地点
							courses[j][4] = jo.getString("XQBS");// 校区
							courses[j][5] = jo.getString("JSXM");// 教师名称
							j++;
						}
					}
				}
				ja = null;
				return courses;
			}
			datajo = null;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAllCourse出错；");
		}
		return null;
	}

	/**
	 * 获取所有选课的已选人数
	 * 
	 * @param httpClient
	 * @param xqbs
	 * @return
	 */
	public String[][] getCourseSelCount(HttpClient httpClient, String param,
			int cate) {
		try {
			String url = "";
			if (cate == 1) {
				url = "http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/Getxxkyxrs?xqbs="
						+ param;
			} else if (cate == 2) {
				url = "http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/GetTykyxrs?xzb="
						+ param;
			}

			String json = getResult(httpClient, url, null);
			// System.out.println(json);
			JSONObject datajo = JSONObject.parseObject(json);

			if (datajo != null && datajo.containsKey("data")) {
				JSONArray ja = datajo.getJSONArray("data");
				int size = ja.size();
				String[][] sels = new String[size][2];

				for (int i = 0; i < size; i++) {
					JSONObject jo = ja.getJSONObject(i);

					sels[i][0] = jo.getString("XKKH");// 课程号
					sels[i][1] = jo.getString("YXRS");// 已选人数
				}
				ja = null;
				return sels;
			}
			datajo = null;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getCourseSelCount出错；");
		}
		return null;
	}

	/**
	 * 获取选课时的个人信息
	 * 
	 * @param httpClient
	 * @return
	 */
	public String[] getComfirmInfoOfCourse(HttpClient httpClient) {
		try {
			String json = getResult(httpClient,
					"http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/GetXszxxx",
					null);
			// System.out.println(json);
			JSONObject datajo = JSONObject.parseObject(json);

			if (datajo != null && datajo.containsKey("data")) {
				JSONObject jo = datajo.getJSONObject("data");
				String xqbs = jo.getString("xqbs");// 校区
				String xzb = jo.getString("xzb");// 专业

				String str[] = { xqbs, xzb };
				return str;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getComfirmInfoOfCourse出错；");
		}
		return null;
	}

	/**
	 * 提交选课信息
	 * 
	 * @param httpClient
	 * @param xkkh
	 * @return
	 */
	public String submitSelCourse(HttpClient httpClient, String xkkh, int cate) {
		try {
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			nvps.add(new BasicNameValuePair("XKKH", xkkh));
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps);

			String url = "";
			if (cate == 1) {
				url = "http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/XxkXuanKe";
			} else if (cate == 2) {
				url = "http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/TykXuanKe";
			}

			String json = getResult(httpClient, url, httpEntity);
			// System.out.println(json);
			JSONObject datajo = JSONObject.parseObject(json);

			String success = datajo.getString("success");
			if (success.equals("false")) {
				return datajo.getString("errorMessage");
			} else {
				return "ok";
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "submitSelCourse出错；");
		}
		return null;
	}

	/**
	 * 我的校选修
	 * 
	 * @param httpClient
	 * @return
	 */
	public String myCourse(HttpClient httpClient) {
		try {
			String json = getResult(httpClient,
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

	/**
	 * 我的校选修
	 * 
	 * @param httpClient
	 * @return
	 */
	public String mySport(HttpClient httpClient) {
		try {
			String json = getResult(httpClient,
					"http://jwc.hrbnu.edu.cn:8000/XueSheng/XuanKe/GetTykyxkc",
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
			LogDao.getLog().addExpLog(e, "mySport出错；");
		}
		return null;
	}

	/**
	 * 评教
	 * 
	 * @param httpClient
	 * @return
	 */
	/*public boolean evaluate(HttpClient httpClient) {
		try {
			String json1 = getResult(
					httpClient,
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
							httpClient,
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
	}*/

	/**
	 * 刷新学费
	 * 
	 * @param httpClient
	 * @return
	 */
	public String flushFee(HttpClient httpClient) {
		try {
			String result = getResult(httpClient,
					"http://jwc.hrbnu.edu.cn:8000/XueSheng/XueJi/Sxqfje", null);

			if (result.indexOf("成功") > -1) {
				int text_i = result.indexOf("App.txtQFJE.setText");
				int yinghao_i1 = result.indexOf("\"", text_i);
				int yinghao_i2 = result.indexOf("\"", yinghao_i1 + 1);
				String money = result.substring(yinghao_i1 + 1, yinghao_i2 - 1);

				return "欠费" + money + "元";
			} else {
				LogDao.getLog().addNorLog(result);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "flush出错；");
		}
		return "操作失败";
	}

	/**
	 * 获取学生信息
	 * 
	 * @param httpClient
	 * @return
	 */
	public Student getStuInfo(HttpClient httpClient) {
		try {
			String json = getResult(httpClient,
					"http://jwc.hrbnu.edu.cn:8000/xuesheng/xueji/JsonXsjbxx",
					null);
			if (json.indexOf("Object moved to") > -1) {
				return null;
			}

			JSONObject datajo = JSONObject.parseObject(json);

			Student stu = new Student();
			stu.setDepart(datajo.getString("XY"));
			stu.setGrade(datajo.getString("DQSZJ"));
			stu.setMajor(datajo.getString("ZYMC"));
			stu.setStuNum(datajo.getString("XH"));
			stu.setStuName(datajo.getString("XM"));
			// 隐私数据
			stu.setIDCard(datajo.getString("SFZH"));// 身份证号
			stu.setTrueSex(datajo.getString("XB"));// 真是性别
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
	 * 登录教务平台
	 * 
	 * @param httpClient
	 * @param userName
	 * @param password
	 * @param code
	 * @return "ok"/"wrong"/errorMessage
	 */
	public String isLogin(HttpClient httpClient, String userName,
			String password, String code) {

		if (httpClient == null) {
			return "wrong";
		}

		String loginURL = "http://jwc.hrbnu.edu.cn:8000/Account/access/Login";
		HttpPost httPost = new HttpPost(loginURL);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("UserGroup", "0"));
		nvps.add(new BasicNameValuePair("_UserGroup_state",
				"%5B%7B%22value%22%3A%220%22%2C%22text%22%3A%22%5Cu5b66"
						+ "%5Cu751f%22%2C%22index%22%3A0%7D%5D"));
		nvps.add(new BasicNameValuePair("UserName", userName));
		nvps.add(new BasicNameValuePair("Password", password));
		nvps.add(new BasicNameValuePair("VerifyCode", code));
		nvps.add(new BasicNameValuePair("ReturnUrl", ""));

		try {
			HttpEntity httpEntity = new UrlEncodedFormEntity(nvps);
			nvps = null;
			httPost.setEntity(httpEntity);
			httpEntity = null;

			HttpResponse res = httpClient.execute(httPost);
			int statusCode = res.getStatusLine().getStatusCode();
			if (statusCode == 200) {
				String responseBody = EntityUtils.toString(res.getEntity(),
						"UTF-8");
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
			// LogDao.getLog().addExpLog(e,"isLogin出错；userName:" + userName +
			// ",password:" + password);
			e.printStackTrace();
		} finally {
			httPost.releaseConnection();
		}
		return "wrong";
	}

}
