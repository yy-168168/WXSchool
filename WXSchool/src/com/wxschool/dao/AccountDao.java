package com.wxschool.dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.jstl.sql.Result;

import com.alibaba.fastjson.JSONObject;
import com.wxschool.entity.Account;
import com.wxschool.entity.Page;
import com.wxschool.util.CommonUtil;
import com.wxschool.util.HttpUtils;

public class AccountDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Account> getAccounts(Page page) {
		String sql = "SELECT `aId`, `wxAccount`, `wxNum`, `wxName`, `fans`, `appId`, `guideUrl`, `regTime`, `isAuth`, `status` FROM `tb_account` WHERE 1 order by aId desc limit ?, ?";
		Object[] o = { (page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Account> accounts = new ArrayList<Account>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Account account = new Account();
				account.setAccountId(Integer.parseInt(os[i][0].toString()));
				account.setWxAccount(os[i][1].toString());
				account.setWxNum(os[i][2] == null ? "" : os[i][2].toString());
				account.setWxName(os[i][3].toString());
				account.setFans(Integer.parseInt(os[i][4].toString()));
				account.setAppId(os[i][5] == null ? "" : os[i][5].toString());
				account
						.setGuideUrl(os[i][6] == null ? "" : os[i][6]
								.toString());
				account.setRegTime(os[i][7].toString().substring(0, 16));
				account.setAuth(os[i][8].toString().equals("1"));
				account.setStatus(Integer.parseInt(os[i][9].toString()));

				accounts.add(account);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAccounts出错；");
		}
		return accounts;
	}

	public Account getAccount(String wxaccount) {
		String sql = "SELECT `aId`, `wxNum`, `wxName`, `fans`, `regTime`, `guideUrl`, `robotChat`, `translate`, `weather`, `express`, `status`, `textChat`, `appId`, `accessToken`, `expireTimeOfToken`, `isAuth`, `voiceChat` FROM `tb_account` WHERE `wxAccount` = ? ";
		Object[] o = { wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Account account = new Account();

			for (int i = 0, len = os.length; i < len; i++) {
				account.setWxAccount(wxaccount);
				account.setAccountId(Integer.parseInt(os[i][0].toString()));
				account.setWxNum(os[i][1] == null ? "" : os[i][1].toString());
				account.setWxName(os[i][2].toString());
				account.setFans(Integer.parseInt(os[i][3].toString()));
				account.setRegTime(os[i][4].toString().substring(0, 16));
				account
						.setGuideUrl(os[i][5] == null ? "" : os[i][5]
								.toString());
				account
						.setRobotChat(Integer.parseInt(os[i][6].toString()) > -1);
				account
						.setTranslate(Integer.parseInt(os[i][7].toString()) > -1);
				account.setWeather(Integer.parseInt(os[i][8].toString()) > -1);
				account.setExpress(Integer.parseInt(os[i][9].toString()) > -1);
				account.setStatus(Integer.parseInt(os[i][10].toString()));
				account
						.setTextChat(Integer.parseInt(os[i][11].toString()) > -1);
				account.setAppId(os[i][12] == null ? "" : os[i][12].toString());
				account.setAccessToken(os[i][13] == null ? "" : os[i][13]
						.toString());
				account.setExpireTimeOfToken(os[i][14].toString().substring(0,
						16));
				account.setAuth(os[i][15].toString().equals("1"));
				account
						.setVoiceChat(Integer.parseInt(os[i][16].toString()) > -1);
			}
			return account;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAccount出错；wxccount:" + wxaccount);
			return null;
		}
	}

	public Account getAccountOfSecurityData(String wxaccount) {
		String sql = "SELECT `aId`, `wxNum`, `wxName`, `appId`, `appSecret`, `accessToken`, `expireTimeOfToken`, `isAuth` FROM `tb_account` WHERE `wxAccount` = ? ";
		Object[] o = { wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Account account = new Account();

			for (int i = 0, len = os.length; i < len; i++) {
				account.setWxAccount(wxaccount);
				account.setAccountId(Integer.parseInt(os[i][0].toString()));
				account.setWxNum(os[i][1] == null ? "" : os[i][1].toString());
				account.setWxName(os[i][2].toString());
				account.setAppId(os[i][3] == null ? "" : os[i][3].toString());
				account.setAppSecret(os[i][4] == null ? "" : os[i][4]
						.toString());
				account.setAccessToken(os[i][5] == null ? "" : os[i][5]
						.toString());
				account.setExpireTimeOfToken(os[i][6].toString());
				account.setAuth(os[i][7].toString().equals("1"));
			}
			return account;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getAccountOfSecurityData出错；wxccount:" + wxaccount);
			return null;
		}
	}

	public String getContent(String wxaccount, String type) {
		String sql = "SELECT " + type
				+ " FROM `tb_account` WHERE `wxAccount` = ? ";
		Object[] o = { wxaccount };
		try {
			Result reslut = connDB.query(sql, o);
			String reply = reslut.getRowsByIndex()[0][0].toString();
			return reply;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getContent出错；wxaccount:" + wxaccount + ",type:" + type);
			return "";
		}
	}

	public boolean updateAppInfo(String wxaccount, String appId,
			String appSecret) {
		String sql = "UPDATE `tb_account` SET `appId`= ? ,`appSecret`= ? WHERE `wxAccount`= ? ";
		Object[] o = { appId, appSecret, wxaccount };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateAppIdAndAppSecret出错；wxaccount:" + wxaccount
							+ ",appId:" + appId + ",appSecret:" + appSecret);
			return false;
		}
	}

	public boolean updateAccessToken(Account account) {
		String sql = "UPDATE `tb_account` SET `accessToken` = ? , `expireTimeOfToken` = ? WHERE `wxAccount`= ? ";
		Object[] o = { account.getAccessToken(),
				account.getExpireTimeOfToken(), account.getWxAccount() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateAccessToken出错；wxaccount:" + account.getWxAccount()
							+ ",accessToken:" + account.getAccessToken()
							+ ",expireTimeOfToken:"
							+ account.getExpireTimeOfToken());
			return false;
		}
	}

	public boolean updateAccountInfo(Account account) {
		String sql = "UPDATE `tb_account` SET `wxAccount`= ? ,`wxNum`= ? , `wxName`= ? ,`guideUrl`= ? WHERE `aId`= ? ";
		Object[] o = { account.getWxAccount(), account.getWxNum(),
				account.getWxName(), account.getGuideUrl(),
				account.getAccountId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateAccount出错；accountId:" + account.getAccountId()
							+ ",wxAccount:" + account.getWxAccount()
							+ ",wxNum:" + account.getWxNum() + ",wxName:"
							+ account.getWxName());
			return false;
		}
	}

	public boolean updateFiled(String account, String filed, int num) {
		String sql = "UPDATE `tb_account` SET " + filed + " = " + filed + " + "
				+ num + " WHERE `wxAccount` = ? ";
		Object[] o = { account };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateFiled出错；wxaccount:" + account + ",filed:" + filed
							+ ",num:" + num);
			return false;
		}
	}

	public boolean updateFiled(String accountId, String filed) {
		String sql = "UPDATE `tb_account` SET " + filed + " = -" + filed
				+ " WHERE `aId` = ? ";
		Object[] o = { accountId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"updateFiled出错；accountId:" + accountId + ",filed:" + filed);
			return false;
		}
	}

	public int getTotalRecord() {
		String sql = "select count(*) from `tb_account`";
		try {
			Result result = connDB.query(sql, null);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_account中得到总记录数出错");
			return 0;
		}
	}

	public String isAccessOfClient(String wxaccount) {
		String sql = "SELECT `aId` FROM `tb_account` WHERE `wxAccount` = ? and `status` > 0 ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			if (result.getRowCount() == 0) {
				LogDao.getLog().addNorLog(
						"非法访问isValidOfClient；wxaccount:" + wxaccount);
				return "illegal";
			}
			return "allow";
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"isValidOfClient出错；wxaccount:" + wxaccount);
			return "error";
		}
	}

	public boolean isAccessOfWeb(HttpServletRequest request, String wxaccount)
			throws IOException {
		String sql = "SELECT `aId` FROM `tb_account` WHERE `wxAccount` = ? and `status` > 0 ";
		Object[] o = { wxaccount };
		Result result;

		try {
			result = connDB.query(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"isValidOfWeb出错；wxaccount:" + wxaccount + "请求网址为："
							+ request.getRequestURL() + "?"
							+ request.getQueryString());
			return false;
		}

		if (result.getRowCount() == 0) {
			StringBuffer sb = new StringBuffer("不正当访问isValidOfWeb；wxaccount:"
					+ wxaccount);
			String ip = CommonUtil.getIpAddr(request);
			sb.append("  ip：");
			sb.append(ip);

			try {
				String ip_result = HttpUtils.doGet(
						"http://ip.taobao.com/service/getIpInfo.php", "ip="
								+ ip, "utf-8");
				JSONObject root = JSONObject.parseObject(ip_result);
				JSONObject data = root.getJSONObject("data");

				sb.append("  来源：");
				sb.append(data.getString("region"));
				sb.append(data.getString("city"));
				sb.append(data.getString("county"));
				sb.append(data.getString("isp"));
			} catch (Exception e) {
			}

			LogDao.getLog().addNorLog(sb.toString());
			return false;
		}
		return true;
	}
}
