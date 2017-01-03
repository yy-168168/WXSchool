package com.wxschool.dao;

import com.wxschool.entity.Mass;

public class MassDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public boolean addMass(Mass mass) {
		String sql = "INSERT INTO `tb_mass`(`content`, `wxaccount`) VALUES (?, ?)";
		Object[] o = { mass.getContent(), mass.getWxaccount() };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addMass出错；content:" + mass.getContent() + ",wxaccount:"
							+ mass.getWxaccount());
			return false;
		}
	}
}
