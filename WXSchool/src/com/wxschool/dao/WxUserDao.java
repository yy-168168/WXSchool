package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.ChatRecord;
import com.wxschool.entity.Config;
import com.wxschool.entity.Page;
import com.wxschool.entity.Student;
import com.wxschool.entity.WxUser;
import com.wxschool.util.CommonUtil;

public class WxUserDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<ChatRecord> getChatUsers(String wxaccount, int sex, int hour,
			int level, int count) {
		String sql = "";
		String randType = Math.random() < 0.7 ? "rand()" : "`countOfSee` desc";
		int page = (int) (Math.random() * 20) - 7;
		page = page < 0 ? 0 : page;
		String sexSql = sex == 0 ? "" : " and `sex` = " + sex;

		if (level == 0) {
			sql = "select wu.`nickname`, wu.`headImgUrl`, wu.`userId`, stu.`stuName`, stu.`grade`, stu.`depart`, stu.`major`, wu.`sex`, wu.`userwx` from (select * from (SELECT * FROM `tb_wxuser` WHERE wxaccount = ? and wxReceiveMsg = 1 and beSearch = 1 and status > 0 and DATE_SUB(CURDATE(), INTERVAL ? HOUR) <= date(lastUsedTime) "
					+ sexSql
					+ ") wuh order by "
					+ randType
					+ " limit "
					+ page
					+ ", ?) wu left join `tb_stu` stu on wu.userwx = stu.userwx";
		} else {
			sql = "select wu.`nickname`, wu.`headImgUrl`, wu.`userId`, stu.`stuName`, stu.`grade`, stu.`depart`, stu.`major`, wu.`sex`, wu.`userwx` from (select * from (SELECT * FROM `tb_wxuser` WHERE wxaccount = ? and wxReceiveMsg = 1 and beSearch = 1 and status > 0 and DATE_SUB(CURDATE(), INTERVAL ? HOUR) <= date(lastUsedTime) and level = 1 "
					+ sexSql
					+ ") wuh order by rand() limit ?) wu left join `tb_stu` stu on wu.userwx = stu.userwx";
		}
		Object[] o = { wxaccount, hour, count };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> chatRecords = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();

				WxUser wxUser = new WxUser();
				wxUser.setNickname(os[i][0] == null ? "未知" : os[i][0]
						.toString());
				wxUser.setHeadImgUrl(os[i][1] == null ? "" : os[i][1]
						.toString());
				wxUser.setUserId(Integer.parseInt(os[i][2].toString()));
				wxUser.setSex(Integer.parseInt(os[i][7].toString()));
				wxUser.setUserwx(os[i][8].toString());
				record.setWxUser(wxUser);

				Student stu = new Student();
				stu.setStuName(os[i][3] == null ? "" : os[i][3].toString());
				stu.setGrade(os[i][4] == null ? "" : os[i][4].toString());
				stu.setDepart(os[i][5] == null ? "" : os[i][5].toString());
				stu.setMajor(os[i][6] == null ? "" : os[i][6].toString());
				record.setStudent(stu);

				chatRecords.add(record);
			}
			return chatRecords;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getLastUsedUsers出错;wxaccount:" + wxaccount + ",sex:" + sex
							+ ",hour:" + hour + ",count:" + count);
			return null;
		}
	}

	public String[] getOpenIds(String wxaccount, int hour) {
		String sql = "SELECT `userwx` FROM `tb_wxuser` WHERE wxaccount = ? and wxReceiveMsg = 1 and status > 0 and DATE_SUB(CURDATE(), INTERVAL "
				+ hour + " HOUR) <= date(lastUsedTime)";
		Object[] o = { wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			String[] openIds = new String[os.length];

			for (int i = 0; i < os.length; i++) {
				openIds[i] = os[i][0].toString();// userwx
			}
			return openIds;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getOpenIds出错;wxaccount:" + wxaccount + ",hour:" + hour);
			return null;
		}
	}

	public String[] getOpenIdsOfSql(String condition, String wxaccount, int hour) {
		String sql = "SELECT t.`userwx` FROM ("
				+ condition
				+ ") t left join `tb_wxuser` u on t.userwx = u.userwx WHERE u.wxaccount = ? and u.wxReceiveMsg = 1 and u.status > 0 and DATE_SUB(CURDATE(), INTERVAL "
				+ hour + " HOUR) <= date(u.lastUsedTime)";
		Object[] o = { wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			String[] openIds = new String[os.length];

			for (int i = 0; i < os.length; i++) {
				openIds[i] = os[i][0].toString();// userwx
			}
			return openIds;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOpenIdsOfSql出错;wxaccount:" + wxaccount + ",hour:"
							+ hour);
			return null;
		}
	}

	public Object[][] getAccountData() {
		// String sql =
		// "SELECT a.`wxaccount`, a.`wxName`, a.`fans`, b.replyCount FROM (SELECT `fans`, `wxName`, `wxAccount` FROM `tb_account` WHERE `status` > 0 ) a right join (SELECT `wxaccount`, count(*) as replyCount FROM `tb_wxuser` where status > 0 group by `wxaccount`) b on a.wxaccount = b.wxaccount ";
		String sql = "SELECT `wxName`, `wxAccount` FROM `tb_account` WHERE `isAuth` = 1 and `status` > 0 ";
		try {
			Result result = connDB.query(sql, null);
			Object[][] os = result.getRowsByIndex();
			return os;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAccountData出错;");
			return null;
		}
	}

	public List<WxUser> getUsers(String wxaccount, Page page, String orderBy) {
		String sql = "SELECT `userId`, `nickname`, `sex`, `country`, `province`, `city`, `headImgUrl`, `subscribeTime`, `unsubscribeTime`, `lastUsedTime`, `userwx`, `status`, `level` FROM `tb_wxuser` WHERE wxaccount = ? order by "
				+ orderBy + " desc limit ?, ? ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<WxUser> users = new ArrayList<WxUser>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				WxUser user = new WxUser();
				user.setUserId(Integer.parseInt(os[i][0].toString()));
				user.setNickname(os[i][1] == null ? "" : os[i][1].toString());
				user.setSex(Integer.parseInt(os[i][2].toString()));
				user.setCountry(os[i][3] == null ? "" : os[i][3].toString());
				user.setProvince(os[i][4] == null ? "" : os[i][4].toString());
				user.setCity(os[i][5] == null ? "" : os[i][5].toString());
				user.setHeadImgUrl(os[i][6] == null ? "" : os[i][6].toString());
				user.setSubscribeTime(os[i][7].toString().substring(0, 16));
				user.setUnsubscribeTime(os[i][8] == null ? "" : os[i][8]
						.toString().substring(0, 16));
				user.setLastUsedTime(os[i][9].toString().substring(0, 16));
				user.setUserwx(os[i][10].toString());
				user.setStatus(Integer.parseInt(os[i][11].toString()));
				user.setLevel(Integer.parseInt(os[i][12].toString()));

				users.add(user);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getUsers出错;wxaccount:" + wxaccount);
		}
		return users;
	}

	public List<WxUser> searchUsersByNickname(String wxaccount, String keyword,
			Page page) {
		String sql = "SELECT `userId`, `nickname`, `sex`, `country`, `province`, `city`, `headImgUrl`, `subscribeTime`, `unsubscribeTime`, `lastUsedTime`, `userwx`, `status`, `level` FROM `tb_wxuser` WHERE wxaccount = ? and `nickname` like ? order by userId desc limit ?, ? ";
		Object[] o = { wxaccount, "%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<WxUser> users = new ArrayList<WxUser>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				WxUser user = new WxUser();
				user.setUserId(Integer.parseInt(os[i][0].toString()));
				user.setNickname(os[i][1] == null ? "" : os[i][1].toString());
				user.setSex(Integer.parseInt(os[i][2].toString()));
				user.setCountry(os[i][3] == null ? "" : os[i][3].toString());
				user.setProvince(os[i][4] == null ? "" : os[i][4].toString());
				user.setCity(os[i][5] == null ? "" : os[i][5].toString());
				user.setHeadImgUrl(os[i][6] == null ? "" : os[i][6].toString());
				user.setSubscribeTime(os[i][7].toString().substring(0, 16));
				user.setUnsubscribeTime(os[i][8] == null ? "" : os[i][8]
						.toString().substring(0, 16));
				user.setLastUsedTime(os[i][9].toString().substring(0, 16));
				user.setUserwx(os[i][10].toString());
				user.setStatus(Integer.parseInt(os[i][11].toString()));
				user.setLevel(Integer.parseInt(os[i][12].toString()));

				users.add(user);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchUsersByNickname出错;wxaccount:" + wxaccount
							+ ",keyword:" + keyword);
		}
		return users;
	}

	public String[][] searchUsersByStuinfo(String wxaccount, String keyword,
			int count) {
		String sql = "SELECT wu.`nickname`, wu.`headImgUrl`, wu.`userId`, stu.`stuName`, stu.`grade`, stu.`depart`, stu.`major`, wu.`sex`, wu.`userwx` FROM (SELECT * FROM `tb_stu` WHERE `wxaccount` = ? and (`stuNum` like ? or `stuName` like ? or `depart` like ? or `major` like ?)) stu left join `tb_wxuser` wu on stu.userwx = wu.userwx where wu.wxReceiveMsg = 1 and wu.status = 1 limit ? ";
		Object[] o = { wxaccount, "%" + keyword + "%", "%" + keyword + "%",
				"%" + keyword + "%", "%" + keyword + "%", count };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			String[][] users = new String[os.length][9];

			for (int i = 0; i < os.length; i++) {
				users[i][0] = os[i][0] == null ? "未知" : os[i][0].toString();// 昵称
				users[i][1] = os[i][1] == null ? "" : os[i][1].toString();// 头像
				users[i][2] = os[i][2].toString();// userId
				users[i][3] = os[i][3] == null ? "" : os[i][3].toString();// 姓名
				users[i][4] = os[i][4] == null ? "" : os[i][4].toString();// 年级
				users[i][5] = os[i][5] == null ? "" : os[i][5].toString();// 学院
				users[i][6] = os[i][6] == null ? "" : os[i][6].toString();// 专业
				users[i][7] = os[i][7].toString();// 性别
				users[i][8] = os[i][8].toString();// userwx
			}
			return users;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchUsersByStuinfo出错;wxaccount:" + wxaccount
							+ ",keyword:" + keyword);
			return null;
		}
	}

	public WxUser getUser_simple(String wxaccount, String userwx) {
		String sql = "SELECT `userId`, `nickname`, `sex`, `lastUsedTime`, `headImgUrl`, `beSearch`, `isSendMsg` FROM `tb_wxuser` WHERE wxaccount = ? and `userwx` = ? and `status` > 0 ";
		Object[] o = { wxaccount, userwx };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			WxUser user = new WxUser();

			for (int i = 0; i < os.length; i++) {
				user.setUserId(Integer.parseInt(os[i][0].toString()));
				user.setNickname(os[i][1] == null ? "" : os[i][1].toString());
				user.setSex(Integer.parseInt(os[i][2].toString()));
				user.setLastUsedTime(os[i][3].toString().substring(0, 16));
				user.setHeadImgUrl(os[i][4] == null ? "" : os[i][4].toString());
				user.setBeSearch(os[i][5].toString().equals("1"));
				user.setSendMsg(os[i][6].toString().equals("1"));
				user.setUserwx(userwx);
			}
			return user;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getUser_simple出错;wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public String[] getUser_detail_userId(String wxaccount, String userId,
			int cate) {
		// String sql =
		// "select wu.`nickname`, wu.`headImgUrl`, wu.`userwx`, stu.`stuName`, stu.`grade`, stu.`depart`, stu.`major`, wu.`sex`, wu.`lastUsedTime`, wu.`countOfSee` from (SELECT * from `tb_wxuser` WHERE wxaccount = ? and `userId` = ? ) wu left join `tb_stu` stu on wu.userwx = stu.userwx";
		String sql = "select wu.`nickname`, wu.`headImgUrl`, wu.`userwx`, stu.`stuName`, stu.`grade`, stu.`depart`, stu.`major`, wu.`sex`, wu.`lastUsedTime`, wu.`countOfSee`, wu.status subscribe, bu.status black from (SELECT * from `tb_wxuser` WHERE wxaccount = ? and `userId` = ? ) wu left join `tb_stu` stu on wu.userwx = stu.userwx left join tb_blackuser bu on wu.userwx = bu.userwx and bu.cate = ? ";
		Object[] o = { wxaccount, userId, cate };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			String[] user = { "", "", "", "", "", "", "", "0",
					"2013-07-02 00:00", "0", "(离线)" };

			for (int i = 0; i < os.length; i++) {
				user[0] = os[i][0] == null ? "未知" : os[i][0].toString();// 昵称
				user[1] = os[i][1] == null ? "" : os[i][1].toString();// 头像
				user[2] = os[i][2].toString();// userwx
				user[3] = os[i][3] == null ? "" : os[i][3].toString();// 姓名
				user[4] = os[i][4] == null ? "" : os[i][4].toString();// 年级
				user[5] = os[i][5] == null ? "" : os[i][5].toString();// 学院
				user[6] = os[i][6] == null ? "" : os[i][6].toString();// 专业
				user[7] = os[i][7].toString();// 性别
				user[8] = os[i][8].toString();// 最后使用时间
				user[9] = os[i][9].toString();// 被查看次数

				if (os[i][11] != null && os[i][11].toString().equals("1")) {
					user[10] = "(黑名单)";
				} else if (os[i][10].toString().equals("-1")) {
					user[10] = "(取消关注)";
				} else {
					long diff_s = CommonUtil.getDiffSecondOfNow(user[8]);
					if (diff_s / (60 * 60) <= Config.WECHATCUSTOMMSGVALIDTIME) {
						user[10] = "在线";
					}
				}
			}
			return user;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getUser_detail_userId出错;wxaccount:" + wxaccount
							+ ",userId:" + userId + ",cate:" + cate);
			return null;
		}
	}

	public boolean addUser(WxUser user) {
		String sql = "INSERT INTO `tb_wxuser`(`nickname`, `sex`, `country`, `province`, `city`, `headImgUrl`, `subscribeTime`, `lastUsedTime`, `userwx`, `wxaccount`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] o = { user.getNickname(), user.getSex(), user.getCountry(),
				user.getProvince(), user.getCity(), user.getHeadImgUrl(),
				user.getSubscribeTime(), user.getLastUsedTime(),
				user.getUserwx(), user.getWxaccount() };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addUser出错;sex:" + user.getSex() + ",country:"
							+ user.getCountry() + ",province:"
							+ user.getProvince() + ",city:" + user.getCity()
							+ ",headImgUrl:" + user.getHeadImgUrl()
							+ ",subscribeTime:" + user.getSubscribeTime()
							+ ",userwx:" + user.getUserwx() + ",wxaccount:"
							+ user.getWxaccount());
			return false;
		}
	}

	// 取消关注
	public int unsubscribe(String wxaccount, String userwx) {
		String sql = "UPDATE `tb_wxuser` SET `unsubscribeTime`= now(), `status` = -1 WHERE `wxaccount`= ? and `userwx`= ? and `status` > 0 ";
		Object[] o = { wxaccount, userwx };
		try {
			return connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"unsubscribe出错;wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return -1;
		}
	}

	public boolean updateUser(WxUser user) {
		String sql = "update `tb_wxuser` set `nickname` = ?, `sex` = ?, `country` = ?, `province` = ?, `city` = ?, `headImgUrl` = ? WHERE `wxaccount`= ? and `userwx`= ? and `status` > 0 ";
		Object[] o = { user.getNickname(), user.getSex(), user.getCountry(),
				user.getProvince(), user.getCity(), user.getHeadImgUrl(),
				user.getWxaccount(), user.getUserwx() };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateUser出错;sex:" + user.getSex() + ",country:"
							+ user.getCountry() + ",province:"
							+ user.getProvince() + ",city:" + user.getCity()
							+ ",headImgUrl:" + user.getHeadImgUrl()
							+ ",userwx:" + user.getUserwx() + ",wxaccount:"
							+ user.getWxaccount());
			return false;
		}
	}

	public boolean updateField(String wxaccount, String userwx, String field) {
		String sql = "update `tb_wxuser` set " + field + " = " + field
				+ " + 1 WHERE `wxaccount`= ? and `userwx`= ? and `status` > 0 ";
		Object[] o = { wxaccount, userwx };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateField出错;wxaccount:" + wxaccount + ",userwx:"
							+ userwx + ",field:" + field);
			return false;
		}
	}

	public boolean updateFieldByUserId(String wxaccount, String userId,
			String field) {
		String sql = "update `tb_wxuser` set " + field + " = " + field
				+ " + 1 WHERE `wxaccount`= ? and `userId`= ? and `status` > 0 ";
		Object[] o = { wxaccount, userId };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateFieldByUserId出错;wxaccount:" + wxaccount + ",userId:"
							+ userId + ",field:" + userId);
			return false;
		}
	}

	public boolean updateField(String wxaccount, String userwx, String field,
			String status) {
		String sql = "update `tb_wxuser` set " + field
				+ " = ? WHERE `wxaccount`= ? and `userwx`= ? and `status` > 0 ";
		Object[] o = { status, wxaccount, userwx };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateField出错;wxaccount:" + wxaccount + ",userwx:"
							+ userwx + ",field:" + field + ",status:" + status);
			return false;
		}
	}

	public int updateLastUsedTime(String wxaccount, String userwx) {
		String sql = "UPDATE `tb_wxuser` SET `lastUsedTime`= now() WHERE `wxaccount`= ? and `userwx`= ? and `status` > 0 ";
		Object[] o = { wxaccount, userwx };
		try {
			return connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateLastUsedTime出错;wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return -1;
		}
	}

	public int getTotalRecord(String wxaccount) {
		String sql = "select count(*) from `tb_wxuser` where wxaccount = ? ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_wxuser中得到总记录数出错;wxaccount:" + wxaccount);
			return 0;
		}
	}

	public int getTotalRecordOfLastUsedUsers(String wxaccount, int hour) {
		String sql = "select count(*) from `tb_wxuser` where wxaccount = ? and DATE_SUB(CURDATE(), INTERVAL "
				+ hour + " HOUR) <= date(lastUsedTime)";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getTotalRecordOfLastUsedUsers出错;wxaccount:" + wxaccount
							+ ",hour:" + hour);
			return 1268;
		}
	}
}
