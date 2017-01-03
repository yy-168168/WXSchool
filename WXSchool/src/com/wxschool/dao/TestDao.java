package com.wxschool.dao;

public class TestDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public void test() {
		String sql = "if exists (select * from `tb_wxuser` where userwx = 11 and `status` = 1) begin update `tb_wxuser` set `lastUsedTime` = now() where `userwx` = 11 end else begin INSERT INTO `tb_wxuser`(`subscribeTime`, `lastUsedTime`, `userwx`, `wxaccount`) VALUES (now(), now(), 11,'sdklfjds') end";
		try {
			connDB.update(sql, null);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "test");
		}
	}
}
