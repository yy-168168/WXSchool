package com.wxschool.dao;

import javax.servlet.jsp.jstl.sql.Result;

public class CookieDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public boolean addDefaultCookie(String wxaccount, String userwx) {
		String sql = "INSERT INTO `tb_cookie`(`wxaccount`, `userwx`) SELECT '"
				+ wxaccount
				+ "', '"
				+ userwx
				+ "' FROM DUAL WHERE NOT EXISTS(SELECT * FROM `tb_cookie` WHERE `wxaccount` = ? and `userwx` = ?)";
		Object[] o = { wxaccount, userwx };

		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"addCookie出错；wxaccount:" + wxaccount + ",userwx:" + userwx);
		}
		return false;
	}

	public boolean updateCookie(String wxaccount, String userwx,
			String cookieStr) {
		String sql = "UPDATE `tb_cookie` SET `cookieStr` = ?, `amount` = `amount` + 1 WHERE `wxaccount`= ? and `userwx`= ?";
		Object[] o = { cookieStr, wxaccount, userwx };

		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateCookie出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx + ",cookieStr:" + cookieStr);
		}
		return false;
	}

	public String getCookie(String wxaccount, String userwx) {
		String sql = "SELECT `cookieId`, `cookieStr`, `addTime` FROM `tb_cookie` WHERE `wxaccount` = ? and `userwx` = ? order by `addTime` desc limit 1 ";
		Object[] o = { wxaccount, userwx };
		String cookieStr = "";

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				cookieStr = os[i][1].toString();
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getCookie出错；wxaccount:" + wxaccount + ",userwx:" + userwx);
		}
		return cookieStr;
	}
}
