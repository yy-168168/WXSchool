package com.wxschool.dpo;

import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.net.ssl.HttpsURLConnection;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.dao.AccountDao;
import com.wxschool.dao.LogDao;
import com.wxschool.entity.Account;
import com.wxschool.entity.Config;
import com.wxschool.entity.News;
import com.wxschool.entity.WxUser;
import com.wxschool.util.CommonUtil;

public class WechatService {

	public static void main(String[] args) {
		WechatService wechatService = new WechatService();
		String token = "igNB8MXyT1Av4xrXA_pikUP6w8M0cE13mpmlghUMuwcel3o9cgAq_zKSvm37BvI9cTqoKrZ5eeyjyrTmVpgjNuKE0C60O62cCLUsaE1g7U-5DXnf6xZwzYEZzn7lQQ7lFHUhAFAQSF";
		String b = wechatService.sendCustomMsg_text(token, "gh_b315c2abe8ce",
				"owRT7jtwCxFFIHXm0F_Hc7fa9_go",
				"你收到一条来自火星的语音消息，请按如下提示操作：\n\n如想回复TA，请继续回复语音\n如不想回复，请回复文字:你走开");
		// String b = wechatService.sendCustomMsg_voice(token,
		// "gh_b315c2abe8ce",
		// "owRT7jtwCxFFIHXm0F_Hc7fa9_go", "11111111");
		// wechatService.downloadMedia(token, "1111111");
		System.out.println(b);
	}

	public String getAccessToken(String wxaccount) {
		try {
			AccountDao accountDao = new AccountDao();
			Account account = accountDao.getAccountOfSecurityData(wxaccount);

			if (account != null && account.isAuth()) {
				// 判断accessToken是否失效
				String expireTimeOfToken = account.getExpireTimeOfToken();

				long diff_s = CommonUtil.getDiffSecondOfNow(expireTimeOfToken);

				if (-diff_s < 10 * 60) {
					// 更新accessToken
					Account account2 = getAccessToken(account.getAppId(),
							account.getAppSecret());

					if (account2 != null) {
						Calendar new_expireTime = Calendar.getInstance();
						new_expireTime.add(Calendar.SECOND, Integer
								.parseInt(account2.getExpireTimeOfToken()));

						SimpleDateFormat df = new SimpleDateFormat(
								"yyyy-MM-dd HH:mm:ss");
						account2.setExpireTimeOfToken(df.format(new_expireTime
								.getTime()));
						account2.setWxAccount(wxaccount);

						accountDao.updateAccessToken(account2);

						return account2.getAccessToken();
					}
				} else {
					return account.getAccessToken();
				}
			}
			accountDao = null;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getAccessToken出错；wxaccount:" + wxaccount);
		}
		return null;
	}

	private Account getAccessToken(String appId, String appSecret) {
		String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential"
				+ "&appid=" + appId + "&secret=" + appSecret;
		try {
			String result = httpRequest(url, "GET", null);
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == -100) {
				String token = root.getString("access_token");
				int expires_in = root.getIntValue("expires_in");

				Account account = new Account();
				account.setAccessToken(token);
				account.setExpireTimeOfToken(expires_in + "");

				return account;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getWxToken出错；url:" + url);
		}
		return null;
	}

	private String getjsapiTicket(String accessToken) {
		String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="
				+ accessToken + "&type=jsapi";
		try {
			String result = httpRequest(url, "GET", null);
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == 0) {
				String ticket = root.getString("ticket");
				int expires_in = root.getIntValue("expires_in");
				long expireTime = System.currentTimeMillis() + expires_in
						* 1000;

				return ticket + "@" + expireTime;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getjsapiTicket出错；url:" + url);
		}
		return null;
	}

	public WxUser getUserInfo(String token, String openId) {
		String url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token="
				+ token + "&openid=" + openId + "&lang=zh_CN";
		try {
			String result = httpRequest(url, "GET", null);
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == -100) {
				int isSubscribe = root.getIntValue("subscribe");
				if (isSubscribe == 1) {
					// String openId = root.getString("openid");
					String nickname = root.getString("nickname");

					int sex = root.getIntValue("sex");
					String city = root.getString("city");
					String country = root.getString("country");
					String province = root.getString("province");
					String headImgUrl = root.getString("headimgurl");
					long subscribeTime = root.getLong("subscribe_time");

					WxUser user = new WxUser();
					user.setIsSubscribe(isSubscribe);
					user.setUserwx(openId);
					user.setNickname(nickname);
					user.setSex(sex);
					user.setCity(city);
					user.setCountry(country);
					user.setProvince(province);
					user.setHeadImgUrl(headImgUrl);
					String format_subscribeTime = String.format("%tF %<tT",
							subscribeTime * 1000);
					user.setSubscribeTime(format_subscribeTime);
					user.setLastUsedTime(format_subscribeTime);

					return user;
				} else {// 未关注
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUserInfo出错；url:" + url);
		}
		return null;
	}

	public String[] getUserList(String token, String nextOpenId) {
		String url = "https://api.weixin.qq.com/cgi-bin/user/get?access_token="
				+ token + "&next_openid=" + nextOpenId;
		try {
			String result = httpRequest(url, "GET", null);
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == -100) {
				// String count = root.getString("count");
				String next_openid = root.getString("next_openid");

				JSONObject data = root.getJSONObject("data");
				JSONArray openIds = data.getJSONArray("openid");
				int size = openIds.size();

				String[] s_opendIds = new String[size + 1];

				for (int i = 0; i < size; i++) {
					s_opendIds[i] = openIds.getString(i);
				}
				s_opendIds[size] = next_openid;

				return s_opendIds;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUserList出错；url:" + url);
		}
		return null;
	}

	public String createMenu(String token, String body) {
		// 判断body是否为json格式
		try {
			JSONObject.parseObject(body);
		} catch (Exception e) {
			return "wrong";
		}

		String url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token="
				+ token;
		try {
			String result = httpRequest(url, "POST", body);
			JSONObject root = JSONObject.parseObject(result);
			String errmsg = root.getString("errmsg");
			checkResponseCode(root);

			return errmsg;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "createWxMenu出错；url:" + url);
			return null;
		}
	}

	// 发送单图文客服消息
	public String sendCustomMsg_news(String token, String wxaccount,
			String userwx, News news) {
		List<News> nsl = new ArrayList<News>();
		nsl.add(news);

		return sendCustomMsg_newsList(token, wxaccount, userwx, nsl);
	}

	// 发送多图文客服消息
	public String sendCustomMsg_newsList(String token, String wxaccount,
			String userwx, List<News> nsl) {
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="
				+ token;
		StringBuffer sb = new StringBuffer("{\"touser\":\"");
		sb.append(userwx);
		sb.append("\",\"msgtype\":\"news\",\"news\":{\"articles\": [");

		for (int i = 0; i < nsl.size(); i++) {
			News ns = nsl.get(i);
			sb.append("{\"title\":\"");
			sb.append(ns.getTitle());
			sb.append("\",\"description\":\"");
			sb.append(ns.getDescription());
			sb.append("\",\"url\":\"");
			sb.append(ns.getUrl());
			sb.append("\",\"picurl\":\"");
			sb.append(ns.getPicUrl());
			sb.append("\"}");

			if (i != nsl.size() - 1) {
				sb.append(",");
			}
		}
		sb.append("]}}");

		try {
			String result = httpRequest(url, "POST", sb.toString());
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == 0) {
				return "ok";
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "sendCustomMsg_news出错；url:" + url);
		}
		return "false";
	}

	// 发送文字客服消息
	public String sendCustomMsg_text(String token, String wxaccount,
			String userwx, String content) {
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="
				+ token;
		StringBuffer sb = new StringBuffer("{\"touser\":\"");
		sb.append(userwx);
		sb.append("\",\"msgtype\":\"text\",\"text\":{\"content\":\"");
		sb.append(content);
		sb.append("\"}}");

		try {
			String result = httpRequest(url, "POST", sb.toString());
			// System.out.println(result);
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == 0) {
				return "ok";
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "sendCustomMsg_text出错；url:" + url);
		}
		return "false";
	}

	// 发送语音客服消息
	public String sendCustomMsg_voice(String token, String wxaccount,
			String userwx, String mediaId) {
		String url = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token="
				+ token;
		StringBuffer sb = new StringBuffer("{\"touser\":\"");
		sb.append(userwx);
		sb.append("\",\"msgtype\":\"voice\",\"voice\":{\"media_id\":\"");
		sb.append(mediaId);
		sb.append("\"}}");

		try {
			String result = httpRequest(url, "POST", sb.toString());
			// System.out.println(result);
			JSONObject root = JSONObject.parseObject(result);

			int errcode = checkResponseCode(root);
			if (errcode == 0) {
				return "ok";
			} else if (errcode == 48002) {// 用户拒收
				return "refuse";
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "sendCustomMsg_text出错；url:" + url);
		}
		return "false";
	}

	public String[] jsSign(String url) {
		try {
			String appId = "wx1338cfbdf95455df";// 哈师大助手appId
			String timestamp = Long.toString(System.currentTimeMillis() / 1000);
			String nonceStr = UUID.randomUUID().toString();
			String jsapi_ticket = null;

			// 获取jsapi_ticket
			String jsapiTicket = Config.jsapiTicket;
			int index = jsapiTicket.indexOf("@");
			if (index > -1) {
				long expireTime = Long.parseLong(jsapiTicket
						.substring(index + 1));
				if (expireTime > System.currentTimeMillis()) {// 没过期
					jsapi_ticket = jsapiTicket.substring(0, index);
				}
			}
			if (jsapi_ticket == null) {
				String accessToken = getAccessToken("gh_b315c2abe8ce");// 助手的accessToken

				if (accessToken != null) {
					String new_jsapiTicket = getjsapiTicket(accessToken);

					if (new_jsapiTicket != null) {
						Config.jsapiTicket = new_jsapiTicket;
						jsapi_ticket = new_jsapiTicket.substring(0,
								new_jsapiTicket.indexOf("@"));
					}
				}
			}

			// 注意这里参数名必须全部小写，且必须有序
			String string1 = "jsapi_ticket=" + jsapi_ticket + "&noncestr="
					+ nonceStr + "&timestamp=" + timestamp + "&url=" + url;

			String signature = CommonUtil.encryptAHA1(string1);

			String[] arrStr = { appId, timestamp, nonceStr, signature };

			return arrStr;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "jsSign出错；url:" + url);
			return null;
		}
	}

	/**
	 * 获取媒体文件
	 * 
	 * @param accessToken
	 *            接口访问凭证
	 * @param media_id
	 *            媒体文件id
	 * @param savePath
	 *            文件在服务器上的存储路径
	 * */
	public byte[] downloadMedia(String accessToken, String mediaId) {
		String requestUrl = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token="
				+ accessToken + "&media_id=" + mediaId;

		try {
			URL url = new URL(requestUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			conn.setRequestMethod("GET");

			InputStream in = conn.getInputStream();

			ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
			byte[] buff = new byte[100]; // buff用于存放循环读取的临时数据
			int rc = 0;
			while ((rc = in.read(buff, 0, 100)) > 0) {
				swapStream.write(buff, 0, rc);
			}
			byte[] in_b = swapStream.toByteArray(); // in_b为转换之后的结果

			in.close();
			conn.disconnect();

			// 结果检查
			try {
				String result = new String(in_b);
				JSONObject root = JSONObject.parseObject(result);
				checkResponseCode(root);
			} catch (Exception e) {// 二进制文件
				return in_b;
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "下载腾讯文件错误；");
		}
		return null;
	}

	private String httpRequest(String requestUrl, String requestMethod,
			String outputStr) throws IOException {

		URL url = new URL(requestUrl);
		HttpsURLConnection httpUrlConn = (HttpsURLConnection) url
				.openConnection();

		httpUrlConn.setDoOutput(true);
		httpUrlConn.setDoInput(true);
		httpUrlConn.setUseCaches(false);
		// 设置请求方式（GET/POST）
		httpUrlConn.setRequestMethod(requestMethod);

		if ("GET".equalsIgnoreCase(requestMethod))
			httpUrlConn.connect();

		// 当有数据需要提交时
		if (null != outputStr) {
			OutputStream outputStream = httpUrlConn.getOutputStream();
			// 注意编码格式，防止中文乱码
			outputStream.write(outputStr.getBytes("UTF-8"));
			outputStream.close();
		}

		// 将返回的输入流转换成字符串
		InputStream inputStream = httpUrlConn.getInputStream();
		InputStreamReader inputStreamReader = new InputStreamReader(
				inputStream, "utf-8");
		BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

		StringBuffer buffer = new StringBuffer();
		String str = null;
		while ((str = bufferedReader.readLine()) != null) {
			buffer.append(str);
		}
		bufferedReader.close();
		inputStreamReader.close();
		// 释放资源
		inputStream.close();
		inputStream = null;
		httpUrlConn.disconnect();

		String result = buffer.toString();
		// System.out.println(result);
		return result;
	}

	private int checkResponseCode(JSONObject root) {
		String errmsg = root.getString("errmsg");
		if (errmsg == null) {
			return -100;
		} else {
			int errcode = root.getIntValue("errcode");
			// 对返回码检测
			int[] codes = { -1, 40001, 40002, 40003, 40004, 40005, 40006,
					40007, 40008, 40009, 40010, 40011, 40012, 40013, 40014,
					40015, 40016, 40017, 40018, 40019, 40020, 40021, 40022,
					40023, 40024, 40025, 40026, 40027, 40028, 40029, 40030,
					40031, 40032, 40033, 40034, 40035, 40036, 40037, 40038,
					40039, 40050, 40051, 40117, 40118, 40119, 40120, 40121,
					40132, 40137, 41001, 41002, 41003, 41004, 41005, 41006,
					41007, 41008, 41009, 42001, 42002, 42003, 42007, 43001,
					43002, 43003, 43004, 43005, 44001, 44002, 44003, 44004,
					45001, 45002, 45003, 45004, 45005, 45006, 45007, 45008,
					45009, 45010, 45015, 45016, 45017, 45018, 45047, 46001,
					46002, 46003, 46004, 47001, 48001, 48004, 50001, 50002,
					61451, 61452, 61453, 61454, 61455, 61456, 61457, 61450,
					61500, 65301, 65302, 65303, 65304, 65305, 65306, 65307,
					65308, 65309, 65310, 65311, 65312, 65313, 65314, 65316,
					65317, 9001001, 9001002, 9001003, 9001004, 9001005,
					9001006, 9001007, 9001008, 9001009, 9001010, 9001020,
					9001021, 9001022, 9001023, 9001024, 9001025, 9001026,
					9001027, 9001028, 9001029, 9001030, 9001031, 9001032,
					9001033, 9001034, 9001035, 9001036 };
			for (int c : codes) {
				if (c == errcode) {
					LogDao.getLog().addNorLog(
							"code:" + errcode + ";msg:" + errmsg);
					break;
				}
			}
			return errcode;
		}
	}
}
