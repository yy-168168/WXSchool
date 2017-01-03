package com.wxschool.dao;

import java.io.*;
import java.net.*;
import javax.servlet.jsp.jstl.sql.Result;

public class FunDao {

	private ConnDBI connDB =  DBManager.getConnDb();

	public String getFun(String receive) {
		if (receive.matches(".*笑话.*")) {
			return getFun(1);
		} else if (receive.matches(".*常识.*")) {
			return getFun(2);
		} else {
			return getFun(1);
		}
	}

	private String getFun(int type) {
		String sql = "SELECT `content` FROM `tb_fun` WHERE `type` = ? and `status` = 1 order by rand() limit 1 ";
		Object[] o = { type };
		try {
			Result result = connDB.query(sql, o);
			return result.getRowsByIndex()[0][0].toString();
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getFun出错；type:" + type);
			return "/::)";
		}
	}

	public String chat(String ques) {
		StringBuffer bufferRes = new StringBuffer();
		try {
			URL realUrl = new URL(
					"http://www.niurenqushi.com/app/simsimi/ajax.aspx");
			HttpURLConnection conn = (HttpURLConnection) realUrl
					.openConnection();
			// 连接超时
			conn.setConnectTimeout(25000);
			// 读取超时 --服务器响应比较慢，增大时间
			conn.setReadTimeout(25000);

			// HttpURLConnection.setFollowRedirects(true);
			// 请求方式
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestProperty("Referer",
					"http://www.niurenqushi.com/app/simsimi/");
			conn.connect();
			// 获取URLConnection对象对应的输出流
			OutputStreamWriter out = new OutputStreamWriter(conn
					.getOutputStream());
			// 发送请求参数
			out.write("txt=" + URLEncoder.encode(ques, "UTF-8"));
			out.flush();
			out.close();

			InputStream in = conn.getInputStream();
			BufferedReader read = new BufferedReader(new InputStreamReader(in,
					"UTF-8"));
			String valueString = null;
			while ((valueString = read.readLine()) != null) {
				bufferRes.append(valueString);
			}
			in.close();
			if (conn != null) {
				conn.disconnect();// 关闭连接
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "chat出错");
			return "你说什么？";
		}

		String sendMsgs = bufferRes.toString();
		sendMsgs = sendMsgs.replaceAll("simsimi2", "");
		sendMsgs = sendMsgs.replaceAll("小黄", "小助手");
		sendMsgs = sendMsgs.replaceAll("小.*豆", "小助手");
		sendMsgs = sendMsgs.replaceAll("小.*鸡", "小助手");
		sendMsgs = sendMsgs.replaceAll(".*qq.*", "");
		sendMsgs = sendMsgs.replaceAll(".*QQ.*", "");
		sendMsgs = sendMsgs.replaceAll(".*smismi.*", "");
		sendMsgs = sendMsgs.replaceAll("xiaodouqqcom", "");
		sendMsgs = sendMsgs.replaceAll("刘思敏", "傻逼");
		sendMsgs = sendMsgs.replaceAll("妈逼", "pp");
		sendMsgs = sendMsgs.replaceAll("无解", "咱说点别的吧");
		sendMsgs = sendMsgs.replaceAll("1012838733", "我");
		sendMsgs = sendMsgs.replaceAll("小助手机器人网页版.*：http://xiao.douqq.com", "");
		sendMsgs = sendMsgs.replaceAll(".*xiao.douqq.com", "");
		sendMsgs = sendMsgs.replaceAll("ip62查询网 www.ip62.com", "");
		sendMsgs = sendMsgs.replaceAll("求.*标点\\)", "您可以说点别的");
		sendMsgs = sendMsgs.replaceAll(
				"点击网址httpjzqqcomindexshtml 2打开网页后用自己的qq号码登录3点加入家族4在游戏"
						+ "种类选择升级家族昵称直接输入夢幻天堂灬a盟誘惑①②③点击再次查找然后点加入即可完成申请",
				"您要干嘛？");

		if (sendMsgs.equals(" ")) {
			sendMsgs = "你说什么？";
		}
		return sendMsgs;
	}
}
