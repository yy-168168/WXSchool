package com.wxschool.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.jstl.sql.Result;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.entity.WdUser;

public class WdUserDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<WdUser> getUsers() {
		String sql = "SELECT `uid`, `name`, `password`, `token`, `wdaccount`, `wdpwd`, `wduserid`, `wduss` FROM `tb_wduser` WHERE 1";
		List<WdUser> users = new ArrayList<WdUser>();

		try {
			Result result = connDB.query(sql, null);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				WdUser user = new WdUser();
				user.setUid(Integer.parseInt(os[i][0].toString()));
				user.setName(os[i][1].toString());
				user.setPassword(os[i][2].toString());
				user.setToken(os[i][3].toString());
				user.setWdaccount(os[i][4].toString());
				user.setWdpwd(os[i][5].toString());
				user.setWduserid(os[i][6].toString());
				user.setWduss(os[i][7].toString());

				users.add(user);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUsers出错；");
		}
		return users;
	}

	public WdUser getUserByPwd(String password) {
		String sql = "SELECT `token`, `wdaccount` FROM `tb_wduser` WHERE `password` = ? and `status` = 1 ";
		Object[] o = { password };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			WdUser user = new WdUser();

			for (int i = 0, len = os.length; i < len; i++) {
				user.setToken(os[i][0].toString());
				user.setWdaccount(os[i][1] == null ? "" : os[i][1].toString());
			}
			return user;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUserByPwd出错；password:" + password);
			return null;
		}
	}

	public WdUser getUserByUid(String uid) {
		String sql = "SELECT `wdaccount`, `wdpwd`, `wduserid`, `wduss` FROM `tb_wduser` WHERE `uid` = ? and `status` = 1 ";
		Object[] o = { uid };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			WdUser user = new WdUser();

			for (int i = 0, len = os.length; i < len; i++) {
				user.setWdaccount(os[i][0].toString());
				user.setWdpwd(os[i][1].toString());
				user.setWduserid(os[i][2].toString());
				user.setWduss(os[i][3].toString());
				user.setUid(Integer.parseInt(uid));
			}
			return user;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUserByUid出错；uid:" + uid);
			return null;
		}
	}

	public String getUidByToken(String token) {
		String sql = "SELECT `uid` FROM `tb_wduser` WHERE `token` = ? and `status` = 1 ";
		Object[] o = { token };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			if (os == null || os.length == 0) {
				return "";
			}
			return os[0][0].toString();
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUidByToken出错；token:" + token);
			return null;
		}
	}

	public boolean updateWdUser(WdUser user) {
		String sql = "UPDATE `tb_wduser` SET `wdaccount`= ?,`wdpwd`= ?,`wduserid`= ?,`wduss`= ? WHERE `token` = ? ";
		Object[] o = { user.getWdaccount(), user.getWdpwd(),
				user.getWduserid(), user.getWduss(), user.getToken() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateWdUser出错；token:" + user.getToken() + ",wdaccount:"
							+ user.getWdaccount() + ",wdpwd:" + user.getWdpwd()
							+ ",wduserid:" + user.getWduserid() + ",wduss:"
							+ user.getWduserid());
			return false;
		}
	}

	public WdUser checkBind(String wdaccount, String wdpwd) {
		WdUser user = new WdUser();
		try {
			String url = "http://login.koudai.com/weidian/loginAsSeller?param={%22client_type%22:%22PC%22,%22telephone%22:%22"
					+ wdaccount
					+ "%22,%22password%22:%22"
					+ wdpwd
					+ "%22,%22country_code%22:%2286%22}&callback=jsonpcallback&ver=111";
			String s = httpRequest(url);
			s = s.substring(14, s.length() - 2);
			// System.out.println(s);
			JSONObject root = JSONObject.parseObject(s);
			JSONObject status = root.getJSONObject("status");
			String status_code = status.getString("status_code");

			if (status_code.equals("0")) {
				JSONObject result = root.getJSONObject("result");
				String wdUserId = result.getString("user_id_raw");
				String wdUss = result.getString("wduss");

				user.setWdaccount(wdaccount);
				user.setWdpwd(wdpwd);
				user.setWduserid(wdUserId);
				user.setWduss(wdUss);
			}
			return user;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"checkBind出错；wdaccount:" + wdaccount + ",wdpwd:" + wdpwd);
			return null;
		}
	}

	private static String httpRequest(String url) throws IOException {
		StringBuffer temp = new StringBuffer();
		URL u = new URL(url);
		InputStream is = u.openStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(is,
				"utf-8"));
		String line = null;
		while ((line = reader.readLine()) != null) {
			temp.append(line + "\n");
		}
		reader.close();
		is.close();
		return temp.toString();
	}

	public static void main(String[] args) {
		new WdUserDao().checkBind("15331806979", "wenzhi_0403");
	}
}
