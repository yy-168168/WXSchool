package com.wxschool.dao;

import javax.servlet.jsp.jstl.sql.Result;

public class BlackDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public boolean isBlack(String wxaccount, String userwx, String cate) {
		String sql = "SELECT * FROM `tb_blackuser` WHERE wxaccount = ? and userwx = ? and cate = ? and status = 1 ";
		Object[] o = { wxaccount, userwx, cate };
		try {
			Result result = connDB.query(sql, o);
			return result.getRowCount() > 0;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"isBlack出错；wxaccount:" + wxaccount + ",userwx:" + userwx
							+ ",cate:" + cate);
			return false;
		}
	}

	public boolean addBlack(String wxaccount, String userwx, String cate) {
		String sql = "INSERT INTO `tb_blackuser`(`wxaccount`, `userwx`, `cate`) VALUES (?, ?, ?) ";
		Object[] o = { wxaccount, userwx, cate };
		try {
			int r = connDB.update(sql, o);
			return r > 0;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addBlack出错；wxaccount:" + wxaccount + ",userwx:" + userwx
							+ ",cate:" + cate);
			return false;
		}
	}
}
