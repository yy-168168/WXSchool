package com.wxschool.dao;

import javax.servlet.jsp.jstl.sql.Result;

public class BarrierDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public void getBarrier(String topicId) {
		String sql = "";
		Object[] o = { topicId };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {

			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getBarrier出错；topicId:" + topicId);
		}
	}
}
