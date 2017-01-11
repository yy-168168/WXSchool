package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.dpo.BosService;
import com.wxschool.dpo.WechatService;
import com.wxschool.entity.ChatRecord;
import com.wxschool.entity.Config;
import com.wxschool.entity.Page;
import com.wxschool.entity.WxUser;
import com.wxschool.util.CommonUtil;

public class ChatVoiceDao {
	
	private ConnDBI connDB = DBManager.getConnDb();
	
	/**
	 * 
	 * @param token
	 * @param wxaccount
	 * @param userwx
	 * @return
	 */
	public static String chatVoice(String token, String wxaccount, String from,
			String to, String mediaId, String format, boolean isNeedNotice)
			throws Exception {
		String replyContent = "语音发送失败，请重试/::)";

		WxUserDao wxUserDao = new WxUserDao();
		WxUser wxUser = wxUserDao.getUser_simple(wxaccount, from);
		if (wxUser == null || wxUser.getUserId() == 0) {
			return replyContent;
		}

		// 获取随机聊天人的openId
		if (to == null) {
			int sex = wxUser.getSex();
			sex = sex == 0 ? 0 : sex == 1 ? 2 : 1;

			List<ChatRecord> users = wxUserDao.getChatUsers(wxaccount, sex,
					Config.WECHATCUSTOMMSGVALIDTIME, 0, 1);
			if (users == null || users.size() == 0) {
			} else {
				to = users.get(0).getWxUser().getUserwx();
			}
			users = null;
		}

		if (to != null) {
			WechatService wechatService = new WechatService();
			// 发送语音客服消息
			if (token != null) {
				String result = wechatService.sendCustomMsg_voice(token,
						wxaccount, to, mediaId);

				if (result.equals("ok")) {
					replyContent = "success";

					// 发送提示客服消息(随机，或者超过6小时)
					if (isNeedNotice) {
						wechatService
								.sendCustomMsg_text(
										token,
										wxaccount,
										to,
										"你收到一条来自"
												+ wxUser.getNickname()
												+ "的语音消息\n\n如想搭讪TA，请继续回复语音\n如若嫌弃，请回复文字:你走开");
					}
				} else if (result.equals("refuse")) {
					replyContent = "语音消息被对方拒收，请重新回复";
				}
			}

			// 下载语音，存储语音资源，保存记录到数据库
			if (token != null) {
				byte[] b = wechatService.downloadMedia(token, mediaId);
				String fileUrl = "";
				if (b != null) {
					BosService bosService = new BosService();
					fileUrl = bosService.addFile(b, format);
					fileUrl = fileUrl == null ? "" : fileUrl;
					bosService = null;
				}

				ChatRecord record = new ChatRecord();
				record.setContent(fileUrl);
				record.setFrom(from);
				record.setTo(to);
				record.setWxaccount(wxaccount);
				record.setMediaId(mediaId);

				ChatVoiceDao chatDao = new ChatVoiceDao();
				chatDao.addRecord(record);
				chatDao = null;
			}
			wechatService = null;
		}

		wxUserDao = null;
		return replyContent;
	}

	public boolean addRecord(ChatRecord record) {
		String sql = "INSERT INTO `tb_chat_voice`(`from`, `to`, `voiceUrl`, `wxaccount`) VALUES (?, ?, ?, ?)";
		Object[] o = { record.getFrom(), record.getTo(), record.getContent(),
				record.getWxaccount() };

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

	/**
	 * from与to的所有聊天记录
	 * 
	 * @param wxaccount
	 * @param wxuser
	 * @param 1.oneWay=true,from发给to的所有记录
	 * @param 2.oneWay=false,from与to的所有记录
	 * @return
	 */
	public List<ChatRecord> getChatRecords(String wxaccount, String from,
			String to, Page page, boolean oneWay) {

		StringBuffer sql = new StringBuffer();
		sql
				.append("SELECT cv.`msgId`, cv.`from`, cv.`to`, cv.`voiceUrl`, cv.`addTime`, cv.`status`, wu.`nickname`, wu.`headImgUrl` FROM (SELECT * FROM `tb_chat_voice` WHERE `wxaccount` = ? and `status` > 0 and ((`from` = ? and `to` = ?)");
		if (!oneWay) {
			sql.append(" or (`from` = '" + to + "' and `to` = '" + from + "')");
		}
		sql
				.append(") ORDER BY msgId DESC limit ?, ?) cv inner join `tb_wxuser` wu on cv.`from` = wu.`userwx` and wu.status > 0 ");
		Object[] o = { wxaccount, from, to,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };

		try {
			Result result = connDB.query(sql.toString(), o);
			Object[][] os = result.getRowsByIndex();
			List<ChatRecord> records = new ArrayList<ChatRecord>();

			for (int i = 0; i < os.length; i++) {
				ChatRecord record = new ChatRecord();
				record.setMsgId(Integer.parseInt(os[i][0].toString()));
				record.setFrom(os[i][1].toString());
				record.setTo(os[i][2].toString());
				record.setContent(os[i][3].toString());
				record.setAddTime(os[i][4].toString());
				record.setStatus(Integer.parseInt(os[i][5].toString()));
				WxUser user = new WxUser();
				user.setNickname(os[i][6].toString());
				user.setHeadImgUrl(os[i][7].toString());
				record.setWxUser(user);

				records.add(record);
			}
			return records;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getChatRecords出错；wxaccount:" + wxaccount + ",from:" + from
							+ ",type:" + to);
			return null;
		}
	}

	/**
	 * 获取所有聊天记录中的最后一条
	 * 
	 * @param wxaccount
	 * @param wxuser
	 * @param 1.from =null,to!=null,发给to的所有记录
	 * @param 2.from!=null,to=null,from发出的所有记录
	 * @return
	 */
	public ChatRecord getLastChatRecord(String wxaccount, String from, String to) {

		String sql = "";
		if (from == null) {
			sql = "SELECT cv.`msgId`, cv.`from`, cv.`status`, cv.`addTime`, wu.`lastUsedTime`, wu.`nickname`, wu.`headImgUrl`, wu.`userId` FROM (SELECT * FROM `tb_chat_voice` WHERE `wxaccount` = ? and `to` = '"
					+ to
					+ "' and status  > 0 order by `addTime` desc limit 1) cv inner join `tb_wxuser` wu on cv.`from` = wu.`userwx` and wu.status > 0";
		} else if (to == null) {
			sql = "SELECT cv.`msgId`, cv.`to`, cv.`status`, cv.`addTime`, wu.`lastUsedTime`, wu.`nickname`, wu.`headImgUrl`, wu.`userId` FROM (SELECT * FROM `tb_chat_voice` WHERE `wxaccount` = ? and `from` = '"
					+ from
					+ "' and status  > 0 order by `addTime` desc limit 1) cv inner join `tb_wxuser` wu on cv.`to` = wu.`userwx` and wu.status > 0";
		}
		Object[] o = { wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			ChatRecord record = new ChatRecord();

			for (int i = 0; i < os.length; i++) {
				record.setMsgId(Integer.parseInt(os[i][0].toString()));
				record.setStatus(Integer.parseInt(os[i][2].toString()));
				record.setAddTime(os[i][3].toString());

				if (from == null) {
					record.setFrom(os[i][1].toString());
					record.setTo(to);
				} else {
					record.setFrom(from);
					record.setTo(os[i][1].toString());
				}

				WxUser user = new WxUser();
				user.setNickname(os[i][5].toString());
				user.setHeadImgUrl(os[i][6].toString());
				user.setUserId(Integer.parseInt(os[i][7].toString()));

				// 是否在线
				long diff_s = CommonUtil
						.getDiffSecondOfNow(os[i][4].toString());
				if (diff_s / (60 * 60) <= Config.WECHATCUSTOMMSGVALIDTIME) {
					user.setOnline(true);
				}
				record.setWxUser(user);
			}
			return record;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getLastChatRecord出错；wxaccount:" + wxaccount + ",from:"
							+ from + ",to:" + to);
			return null;
		}
	}

	public boolean setRecordStatusToRefuse(String wxaccount, String from,
			String to) {
		String sql = "UPDATE `tb_chat_voice` SET `status`= 2 WHERE `msgId` = (select cv.id from (SELECT max(msgId) as id FROM `tb_chat_voice` WHERE `wxaccount` = ? and `from` = ? and `to` = ? and status  > 0 order by `addTime` desc limit 1) cv)";
		Object[] o = { wxaccount, from, to };
		try {
			int result = connDB.update(sql, o);
			return result == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"setStatusToRefuse出错；wxaccount:" + wxaccount + ",from:"
							+ from + ",to:" + to);
		}
		return false;
	}
}
