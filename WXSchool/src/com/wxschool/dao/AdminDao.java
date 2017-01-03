package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;
import com.wxschool.entity.*;
import com.wxschool.util.CommonUtil;

public class AdminDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public Admin getAdminByKey(String key) {
		String sql = "SELECT `wxaccount`, `userwx`, `type`, `token` FROM `tb_admin` WHERE `key` = ? and `status` >= 0 ";
		Object[] o = { key };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Admin admin = new Admin();

			for (int i = 0, len = os.length; i < len; i++) {
				admin.setWxaccount(os[i][0].toString());
				admin.setUserwx(os[i][1].toString());
				admin.setType(os[i][2].toString());
				admin.setToken(os[i][3].toString());
			}
			return admin;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAdminByKey出错；key:" + key);
			return null;
		}
	}

	public Admin getAdminByToken(String token) {
		String sql = "SELECT `wxaccount`, `userwx`, `type`, `status` FROM `tb_admin` WHERE `token` = ? and `status` >= 0 ";
		Object[] o = { token };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Admin admin = new Admin();

			for (int i = 0, len = os.length; i < len; i++) {
				admin.setWxaccount(os[i][0].toString());
				admin.setUserwx(os[i][1].toString());
				admin.setType(os[i][2].toString());
				admin.setStatus(Integer.parseInt(os[i][3].toString()));
			}
			return admin;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAdminByToken出错；token:" + token);
			return null;
		}
	}

	public Admin getAdminByUserwx(String userwx) {
		String sql = "SELECT `wxaccount`, `type` FROM `tb_admin` WHERE `userwx` = ? and `status` >= 0 ";
		Object[] o = { userwx };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Admin admin = new Admin();

			for (int i = 0, len = os.length; i < len; i++) {
				admin.setWxaccount(os[i][0].toString());
				admin.setType(os[i][1].toString());
				admin.setUserwx(userwx);
			}
			return admin;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAdminByUserwx出错；userwx:" + userwx);
			return null;
		}
	}

	public List<Admin> getAdmins(String wxaccount, Page page) {
		String sql = "SELECT `adminId`, `userwx`, `key`, `token`, `maxUsedNum`, `maxBoxNum`, `maxResNum`, `type`, `regTime`, `lastTime`, `status` FROM `tb_admin` WHERE `wxaccount` = ? ";
		Object[] o = { wxaccount };
		List<Admin> admins = new ArrayList<Admin>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Admin admin = new Admin();
				admin.setAdminId(Integer.parseInt(os[i][0].toString()));
				admin.setUserwx(os[i][1].toString());
				admin.setKey(os[i][2].toString());
				admin.setToken(os[i][3].toString());
				admin.setMaxUsedNum(Integer.parseInt(os[i][4].toString()));
				admin.setMaxBoxNum(Integer.parseInt(os[i][5].toString()));
				admin.setMaxResNum(Integer.parseInt(os[i][6].toString()));
				admin.setType(os[i][7].toString());
				admin.setRegTime(os[i][8].toString().substring(0, 16));
				admin.setLastTime(os[i][9].toString().substring(0, 16));
				admin.setStatus(Integer.parseInt(os[i][10].toString()));

				admins.add(admin);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAdmins出错；wxaccount:" + wxaccount);
		}
		return admins;
	}

	public String getOrCreateKey(String wxaccount, String userwx) {
		String key = "出错咯，请重试";
		try {
			Admin admin = getAdminByUserwx(userwx);
			if (admin != null) {
				int length = (int) Math.random() * 3 + 8;// 长度可以为8、9、10位
				key = CommonUtil.getRandomStr(length);// 生成密钥
				admin.setKey(key);
				boolean isSuccess;
				if (admin.getWxaccount() == null) {// add
					admin.setWxaccount(wxaccount);
					admin.setUserwx(userwx);
					admin.setType("bns");

					length = (int) Math.random() * 3 + 13;// 长度可以为13、14、15位
					String token = CommonUtil.getRandomStr(length);// 生成token
					admin.setToken(token);
					isSuccess = addAdmin(admin);
				} else {// update
					isSuccess = updateAdmin(admin);
				}
				if (isSuccess) {// 回复密钥
					key = "你的密钥为:" + key + "\n登录网址为:\n" + Config.SITEURL
							+ "/mng\n请不要泄露，如果忘记，重新回复getkey即可";
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOrCreateKey出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
		}
		return key;
	}

	public void changeStatus(String userwx, int status) {
		String sql = "UPDATE `tb_admin` SET `status`= ? where `userwx` = ? ";
		Object[] o = { status, userwx };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"changeStatus出错；userwx:" + userwx + ",status:" + status);
		}
	}

	public boolean addAdmin(Admin admin) {
		String sql = "INSERT INTO `tb_admin`(`wxaccount`, `userwx`, `key`, `type`, `regTime`) VALUES (?, ?, ?, ?, now()) ";
		Object[] o = { admin.getWxaccount(), admin.getUserwx(), admin.getKey(),
				admin.getType() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addAdmin出错；wxaccount:" + admin.getWxaccount() + ",userwx:"
							+ admin.getUserwx() + ",key:" + admin.getKey()
							+ ",type:" + admin.getType());
			return false;
		}
	}

	public boolean updateAdmin(Admin admin) {
		String sql = "UPDATE `tb_admin` SET `key`= ? WHERE `userwx`= ? ";
		Object[] o = { admin.getKey(), admin.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateAdmin出错；wxaccount:" + admin.getWxaccount()
							+ ",userwx:" + admin.getUserwx() + ",key:"
							+ admin.getKey());
			return false;
		}
	}

	public int getTotalRecord() {
		String sql = "select count(*) from `tb_admin` where `status` >= 0 and type <> 'admin' ";
		try {
			Result result = connDB.query(sql, null);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_admin中得到总记录数出错");
			return 0;
		}
	}
}
