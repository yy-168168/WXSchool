package com.wxschool.dao;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.dpo.UpdateUserInfoThread;
import com.wxschool.entity.ChatRecord;
import com.wxschool.entity.Config;
import com.wxschool.entity.News;
import com.wxschool.entity.Page;
import com.wxschool.entity.Student;
import com.wxschool.entity.WxUser;
import com.wxschool.util.CommonUtil;
import com.wxschool.util.HttpUtils;

public class ChatTextDao {

	public static void main(String[] args) {
		String url = "http://dwz.cn/create.php";
		Map<String, String> params = new HashMap<String, String>();
		params.put("url",
				"http://www.jingl520.com/fsdljfs?fjdsj=fdfd&dfds=fdsfd");
		try {
			String s = HttpUtils.doPost(url, params, "utf-8");
			System.out.println(s);
			s = HttpUtils
					.httpStreamRequest("http://dwz.cn/create.php", "POST",
							"{\"url\":\"http://www.jingl520.com/fsdljfs?fjdsj=fdfd&dfds=fdsfd\"}");
			System.out.println(s);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private ConnDBI connDB = DBManager.getConnDb();

	public static List<News> chatText(String wxaccount, String userwx) {
		AccountDao accountDao = new AccountDao();
		String chat = accountDao.getContent(wxaccount, "textChat");
		accountDao = null;

		if (chat.equals("") || Integer.parseInt(chat) > 0) {
			WxUserDao wxUserDao = new WxUserDao();
			WxUser wxUser = wxUserDao.getUser_simple(wxaccount, userwx);

			if (wxUser == null || wxUser.getUserId() == 0) {
				wxUserDao = null;
				return null;
			} else {
				int sex = wxUser.getSex();
				sex = sex == 0 ? 0 : sex == 1 ? 2 : 1;

				List<ChatRecord> users = wxUserDao.getChatUsers(wxaccount, sex,
						Config.WECHATCUSTOMMSGVALIDTIME, 0, 6);
				/*
				 * if (users == null) { users =
				 * wxUserDao.getChatUsers(wxaccount, sex,
				 * Config.WECHATCUSTOMMSGVALIDTIME, 0, 9); } else {
				 * List<ChatRecord> level0Users = wxUserDao.getChatUsers(
				 * wxaccount, sex, Config.WECHATCUSTOMMSGVALIDTIME, 0, 9 -
				 * users.size()); users.addAll(level0Users); }
				 */

				if (users == null || users.size() == 0) {
					users = null;
					return null;
				} else {
					int countOFOnline = wxUserDao
							.getTotalRecordOfLastUsedUsers(wxaccount, 48);
					wxUserDao = null;

					List<News> nsl = new ArrayList<News>();
					News ns = new News();
					ns.setTitle("随机搭讪--总有新奇在身边！当前有" + countOFOnline
							+ "人在线！(点此设置相关信息及查看所有记录)");
					ns.setPicUrl("");
					ns.setUrl(Config.SITEURL
							+ "/mobile/chat/text?ac=wxInfo&wxaccount="
							+ wxaccount + "&userwx=" + userwx + "&t=");
					nsl.add(ns);

					String[] userwxs = new String[users.size()];// userwx数组

					for (int i = 0; i < users.size(); i++) {
						ns = new News();

						ChatRecord record = users.get(i);
						WxUser wxUser2 = record.getWxUser();
						Student stu = record.getStudent();

						StringBuffer title = new StringBuffer(
								wxUser2.getNickname());
						if (wxUser2.getSex() == 1) {
							title.append("汉纸");
						} else if (wxUser2.getSex() == 2) {
							title.append("妹纸");
						}

						if (!stu.getDepart().equals("")) {
							title.append("--");
							title.append(stu.getGrade());
							title.append("级");
							title.append(stu.getDepart());
							title.append(stu.getMajor());
							title.append("专业");
						}
						ns.setTitle(title.toString());

						String headImgUrl = wxUser2.getHeadImgUrl();
						if (i == 0) {
							ns.setPicUrl(headImgUrl);
						} else {
							int img_i = headImgUrl.lastIndexOf("/");
							if (img_i > -1) {
								ns.setPicUrl(headImgUrl.substring(0, img_i)
										+ "/96");
							} else {
								ns.setPicUrl(headImgUrl);
							}
						}

						ns.setUrl(Config.SITEURL
								+ "/mobile/chat/text?ac=chat&wxaccount="
								+ wxaccount + "&userwx=" + userwx + "&to="
								+ UUID.randomUUID().toString()
								+ wxUser2.getUserId() + "&t=");
						nsl.add(ns);

						userwxs[i] = wxUser2.getUserwx();
					}
					users = null;

					// 启动更新用户微信信息的线程
					UpdateUserInfoThread uuit = new UpdateUserInfoThread(
							wxaccount, userwxs);
					Thread t = new Thread(uuit);
					t.start();

					return nsl;
				}
			}
		} else {
			return null;
		}
	}

	public List<ChatRecord> getChatList(String wxaccount, String userwx,
			Page page) {
		// String sql =
		// "(select mr_d11.`from`, mr_d11.`to`, mr_d11.`content`, mr_d11.`addTime`, wu.`headImgUrl`, wu.`nickname`, wu.`sex` from (SELECT * FROM (SELECT * FROM  `tb_chat_textb_chat_text` WHERE `wxaccount` = ? and `from` = ? ORDER BY msgId DESC ) mr_d1 GROUP BY `to`) mr_d11 left join tb_wxuser wu on mr_d11.`to` = wu.userwx and wu.status > 0) UNION (select mr_d22.`to`, mr_d22.`from`, mr_d22.`content`, mr_d22.`addTime`, wu.`headImgUrl`, wu.`nickname`, wu.`sex` from (SELECT * FROM (SELECT * FROM `tb_chat_text` WHERE `wxaccount` = ? and `to` = ? ORDER BY msgId DESC) mr_d2 GROUP BY `from`) mr_d22 left join tb_wxuser wu on mr_d22.`from` = wu.userwx and wu.status > 0) order by addTime desc";
		String sql = "SELECT wu.`userId`, s_r.`content`, s_r.`addTime`, wu.`headImgUrl`, wu.`nickname`, wu.`sex`, wu.`lastUsedTime` FROM (SELECT * FROM ((SELECT `msgId`, `to`, `content`, `addTime` FROM  `tb_chat_text` WHERE wxaccount = ? And `from` = ? AND STATUS > -1) UNION (SELECT `msgId`, `from`,`content`, `addTime` FROM  `tb_chat_text` WHERE wxaccount = ? And `to` = ? AND STATUS > -1) ORDER BY msgId DESC) my_all_r GROUP BY `to`) s_r LEFT JOIN tb_wxuser wu ON s_r.`to` = wu.`userwx` where wu.status > 0 order by addTime desc limit ?, ? ";
		Object[] o = { wxaccount, userwx, wxaccount, userwx,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> records = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();
				// record.setFrom(os[i][0].toString());
				record.setTo(os[i][0] == null ? "" : os[i][0].toString());
				record.setContent(os[i][1].toString());
				record.setAddTime(os[i][2].toString().substring(0, 16));
				WxUser wxUser = new WxUser();
				wxUser.setHeadImgUrl(os[i][3] == null ? "" : os[i][3]
						.toString());
				wxUser.setNickname(os[i][4] == null ? "取消关注用户" : os[i][4]
						.toString());
				wxUser.setSex(Integer.parseInt(os[i][5].toString()));
				long diff_s = CommonUtil
						.getDiffSecondOfNow(os[i][6].toString());
				if (diff_s / (60 * 60) <= Config.WECHATCUSTOMMSGVALIDTIME) {
					wxUser.setOnline(true);
				}
				record.setWxUser(wxUser);
				records.add(record);
			}
			return records;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getChatList出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public List<ChatRecord> getReadRecords(String wxaccount, String from,
			String to, String msgId, int count) {
		String sql = "SELECT mr.`from`, mr.`to`, mr.`content`, mr.`addTime`, wu.`headImgUrl`, mr.msgId  from (select * FROM `tb_chat_text` WHERE `wxaccount` = ? and msgId < ? and `status` > 0 and ((`from` = ? and `to` = ?) or (`from` = ? and `to` = ?)) order by msgId desc limit ? )  mr left join tb_wxuser wu on mr.from = wu.userwx and wu.status > 0 ";
		Object[] o = { wxaccount, msgId, from, to, to, from, count };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> records = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();
				record.setFrom(os[i][0].toString());
				record.setTo(os[i][1].toString());
				record.setContent(os[i][2].toString());
				record.setAddTime(os[i][3].toString().substring(0, 16));
				WxUser wxUser = new WxUser();
				wxUser.setHeadImgUrl(os[i][4] == null ? "" : os[i][4]
						.toString());
				record.setWxUser(wxUser);
				record.setMsgId(Integer.parseInt(os[i][5].toString()));

				records.add(record);
			}
			return records;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getReadRecords出错；wxaccount:" + wxaccount + ",from:" + from
							+ ",to:" + to + ",msgId:" + msgId + ",count:"
							+ count);
			return null;
		}
	}

	public List<ChatRecord> getUnreadRecords(String wxaccount, String from,
			String to, String msgId) {
		String sql = "SELECT mr.`from`, mr.`to`, mr.`content`, mr.`addTime`, wu.`headImgUrl`, mr.msgId  from (select * from (select * FROM `tb_chat_text` WHERE `wxaccount` = ? and msgId > ? and `status` > 0 and ((`from` = ? and `to` = ?) or (`from` = ? and `to` = ?))) tr order by tr.msgId desc )  mr left join tb_wxuser wu on mr.from = wu.userwx and wu.status > 0 ";
		Object[] o = { wxaccount, msgId, from, to, to, from };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> records = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();
				record.setFrom(os[i][0].toString());
				record.setTo(os[i][1].toString());
				record.setContent(os[i][2].toString());
				record.setAddTime(os[i][3].toString().substring(0, 16));
				WxUser wxUser = new WxUser();
				wxUser.setHeadImgUrl(os[i][4] == null ? "" : os[i][4]
						.toString());
				record.setWxUser(wxUser);
				record.setMsgId(Integer.parseInt(os[i][5].toString()));

				records.add(record);
			}
			return records;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getUnreadRecords出错；wxaccount:" + wxaccount + ",from:"
							+ from + ",to:" + to + ",msgId:" + msgId);
			return null;
		}
	}

	public boolean existUnreadRecord(String wxaccount, String me, String from) {
		String sql = "select * FROM `tb_chat_text` WHERE `wxaccount` = ? and `to` = ? and `from` = ? and `status` = 21 ";
		Object[] o = { wxaccount, me, from };

		try {
			Result result = connDB.query(sql, o);
			int count = result.getRowCount();
			return count > 0;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"existUnreadRecord出错；wxaccount:" + wxaccount + ",from:"
							+ from + ",me:" + me);
		}
		return false;
	}

	public boolean addRecord(ChatRecord record) {
		String sql = "INSERT INTO `tb_chat_text`(`from`, `to`, `content`, `wxaccount`, `status`) VALUES (?, ?, ?, ?, ?)";
		Object[] o = { record.getFrom(), record.getTo(), record.getContent(),
				record.getWxaccount(), record.getStatus() };

		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addRecord出错；wxaccount:" + record.getWxaccount() + ",from:"
							+ record.getFrom() + ",to:" + record.getTo()
							+ ",content:" + record.getContent());
			return false;
		}
	}

	public void changeStatus(String wxaccount, String from, String to) {
		String sql = "UPDATE `tb_chat_text` SET `status`= (case "
				+ " when `from` = ? and `to` = ? and `status` = 12 then 22"
				+ " when `to` = ? and `from` = ? and `status` = 21 then 22"
				+ " else `status` end) WHERE `wxaccount` = ? ";
		Object[] o = { from, to, from, to, wxaccount };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"changeStatus出错；wxaccount:" + wxaccount + ",from:" + from
							+ ",to:" + to);
		}
	}

	public int getTotalRecord(String wxaccount) {
		String sql = "select count(*) from `tb_chat_text` where wxaccount = ? and status > 0";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_chat_text中得到总记录数出错;wxaccount:" + wxaccount);
			return 0;
		}
	}

	public int getTotalRecord_user(String wxaccount, String from, String to) {
		String sql = "select count(*) FROM `tb_chat_text` WHERE `wxaccount` = ? and `status` > 0 and ((`from` = ? and `to` = ?) or (`from` = ? and `to` = ?))";
		Object[] o = { wxaccount, from, to, to, from };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_chat_text中得到总记录数出错;wxaccount:" + wxaccount);
			return 0;
		}
	}

	public Object[][] getAccountData() {
		// String sql =
		// "SELECT a.`wxaccount`, a.`wxName`, b.dataCount FROM (SELECT `wxName`, `wxAccount` FROM `tb_account` WHERE `status` > 0 ) a right join (SELECT `wxaccount`, count(*) as dataCount FROM `tb_operaterecord` where status > 0 group by `wxaccount`) b on a.wxaccount = b.wxaccount ";
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

	public List<ChatRecord> getMsgRecords(String wxaccount, Page page) {
		String sql = "SELECT a.*, w.headImgUrl, w.nickname FROM (SELECT `from`, `to` , `content`, `addTime` FROM `tb_chat_text` WHERE `wxaccount` = ? and `status` > 0 order by `msgId` desc limit ?, ?) a left join tb_wxuser w on a.`from` = w.userwx and w.status = 1 ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<ChatRecord> chatRecords = new ArrayList<ChatRecord>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				ChatRecord chatRecord = new ChatRecord();

				chatRecord.setFrom(os[i][0].toString());
				chatRecord.setTo(os[i][1].toString());
				chatRecord.setContent(os[i][2].toString());
				chatRecord.setAddTime(os[i][3].toString().substring(0, 16));
				WxUser wxUser = new WxUser();
				wxUser.setHeadImgUrl(os[i][4] == null ? "" : os[i][4]
						.toString());
				wxUser.setNickname(os[i][5] == null ? "" : os[i][5].toString());
				chatRecord.setWxUser(wxUser);

				chatRecords.add(chatRecord);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getMsgRecords出错;wxaccount:" + wxaccount);
		}
		return chatRecords;
	}

	public List<ChatRecord> getMsgRecords_user(String wxaccount, String from,
			String to, Page page) {
		String sql = "SELECT mr.`from`, mr.`content`, mr.`addTime`, wu.`headImgUrl`, mr.msgId  from (select * FROM `tb_chat_text` WHERE `wxaccount` = ? and `status` > 0 and ((`from` = ? and `to` = ?) or (`from` = ? and `to` = ?)) ORDER BY msgId DESC limit ?, ? )  mr left join tb_wxuser wu on mr.from = wu.userwx and wu.status > 0 ";
		Object[] o = { wxaccount, from, to, to, from,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> records = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();

				record.setFrom(os[i][0].toString());
				record.setContent(os[i][1].toString());
				record.setAddTime(os[i][2].toString().substring(0, 16));
				WxUser wxUser = new WxUser();
				wxUser.setHeadImgUrl(os[i][3] == null ? "" : os[i][3]
						.toString());
				record.setWxUser(wxUser);
				record.setMsgId(Integer.parseInt(os[i][4].toString()));

				records.add(record);
			}
			return records;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getMsgRecords_user出错；wxaccount:" + wxaccount + ",from:"
							+ from + ",to:" + to);
			return null;
		}
	}

	public List<ChatRecord> getChatList_mng(String wxaccount, String userwx) {
		String sql = "SELECT wu.`userwx`, s_r.`addTime`, wu.`headImgUrl`, wu.`nickname`, wu.`sex`, wu.`lastUsedTime` FROM (SELECT * FROM ((SELECT `msgId`, `to`, `content`, `addTime` FROM  `tb_chat_text` WHERE wxaccount = ? And `from` = ? AND STATUS > 0) UNION (SELECT `msgId`, `from`,`content`, `addTime` FROM  `tb_chat_text` WHERE wxaccount = ? And `to` = ? AND STATUS > 0) ORDER BY msgId DESC) my_all_r GROUP BY `to`) s_r LEFT JOIN tb_wxuser wu ON s_r.`to` = wu.`userwx` where wu.status > 0 order by addTime desc";
		Object[] o = { wxaccount, userwx, wxaccount, userwx };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> records = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();

				record.setFrom(userwx);
				record.setTo(os[i][0].toString());
				record.setAddTime(os[i][1].toString().substring(0, 16));
				WxUser wxUser = new WxUser();
				wxUser.setHeadImgUrl(os[i][2] == null ? "" : os[i][2]
						.toString());
				wxUser.setNickname(os[i][3] == null ? "取消关注用户" : os[i][3]
						.toString());
				long diff_s = CommonUtil
						.getDiffSecondOfNow(os[i][5].toString());
				if (diff_s / (60 * 60) <= Config.WECHATCUSTOMMSGVALIDTIME) {
					wxUser.setOnline(true);
				}
				record.setWxUser(wxUser);
				records.add(record);
			}
			return records;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getChatList_mng出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}
}
