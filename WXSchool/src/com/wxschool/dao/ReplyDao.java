package com.wxschool.dao;

import java.util.*;

import javax.servlet.jsp.jstl.sql.Result;
import com.wxschool.entity.*;

public class ReplyDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Question> getQuess(String wxaccount, String topicId,
			String orderBy, Page page) {
		String sql = "SELECT `quesId`, `content`, `replyNum`, `visitPerson`, `other`, `userwx`, `pubTime`, `num`, `uptTime` FROM `tb_ques` WHERE `wxaccount` = ? and `topicId` = ? and `status` = 1 order by "
				+ orderBy + " desc limit ? ,? ";
		Object[] o = { wxaccount, topicId,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Question> quess = new ArrayList<Question>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Question ques = new Question();
				ques.setQuesId(Integer.parseInt(os[i][0].toString()));
				ques.setContent(os[i][1].toString());
				ques.setReplyNum(Integer.parseInt(os[i][2].toString()));
				ques.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				ques.setOther(os[i][4].toString());
				ques.setUserwx(os[i][5].toString());
				ques.setPubTime(os[i][6].toString().substring(0, 16));
				ques.setNum(Integer.parseInt(os[i][7].toString()));
				ques.setUptTime(os[i][8].toString().substring(0, 16));
				ques.setWxaccount(wxaccount);

				quess.add(ques);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getQuess出错；wxaccount:" + wxaccount + ",topicId:" + topicId
							+ ",orderBy:" + orderBy);
		}
		return quess;
	}

	public List<Question> getQuessByUserwx(String wxaccount, String topicId,
			String userwx, Page page) {
		// String sql =
		// "SELECT `quesId`, `content`, `replyNum`, `visitPerson`, `other`, `userwx`, `pubTime`, `num`, `uptTime` FROM `tb_ques` WHERE `wxaccount` = ? and `topicId` = ? and (userwx = ? or quesId in (select quesId from tb_reply where userwx = ? and type = 1 )) and `status` = 1 order by quesId desc limit ? ,? ";
		String sql = "(SELECT `quesId`, `content`, `replyNum`, `visitPerson`, `other`, `userwx`, `pubTime`, `num`, `uptTime` FROM `tb_ques` WHERE `wxaccount` = ? and `topicId` = ? and userwx = ? and `status` = 1) union (SELECT q.`quesId`, q.`content`, q.`replyNum`, q.`visitPerson`, q.`other`, q.`userwx`, q.`pubTime`, q.`num`, q.`uptTime` FROM (SELECT quesId FROM tb_reply WHERE `wxaccount` = ? and userwx = ? AND TYPE = 1 and status = 1) r left join `tb_ques` q on q.quesId = r.quesId where q.topicId = ? and q.status = 1) ORDER BY quesId DESC limit ?, ? ";
		Object[] o = { wxaccount, topicId, userwx, wxaccount, userwx, topicId,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Question> quess = new ArrayList<Question>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Question ques = new Question();
				ques.setQuesId(Integer.parseInt(os[i][0].toString()));
				ques.setContent(os[i][1].toString());
				ques.setReplyNum(Integer.parseInt(os[i][2].toString()));
				ques.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				ques.setOther(os[i][4].toString());
				ques.setUserwx(os[i][5].toString());
				ques.setPubTime(os[i][6].toString().substring(0, 16));
				ques.setNum(Integer.parseInt(os[i][7].toString()));
				ques.setUptTime(os[i][8].toString().substring(0, 16));
				ques.setWxaccount(wxaccount);

				quess.add(ques);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getQuess出错；wxaccount:" + wxaccount + ",topicId:" + topicId
							+ ",userwx:" + userwx);
		}
		return quess;
	}

	public List<Reply> getReplys(String quesId, int type, Page page) {
		String sql = "SELECT `replyId`, `content`, `userwx`, `wxaccount`, `pubTime`, `num`, `other` FROM `tb_reply` WHERE `quesId` = ? and type = ? and `status` = 1 order by `pubTime` desc limit ?,?";
		Object[] o = { quesId, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Reply> replys = new ArrayList<Reply>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Reply reply = new Reply();

				reply.setReplyId(Integer.parseInt(os[i][0].toString()));
				reply.setContent(os[i][1].toString());
				reply.setUserwx(os[i][2].toString());
				reply.setWxaccount(os[i][3].toString());
				reply.setPubTime(os[i][4].toString().substring(0, 16));
				reply.setNum(Integer.parseInt(os[i][5].toString()));
				reply.setOther(os[i][6].toString());

				replys.add(reply);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getReplys出错；quesId:" + quesId + ",type:" + type);
		}
		return replys;
	}

	public List<Reply> getReplysAndWxuser(String quesId, int type, Page page) {
		// String sql =
		// "SELECT `replyId`, `content`, `userwx`, `wxaccount`, `pubTime`, `num`, `other` FROM `tb_reply` WHERE `quesId` = ? and type = ? and `status` = 1 order by `pubTime` desc limit ?,?";
		String sql = "SELECT r.`replyId`, r.`content`, r.`userwx`, r.`wxaccount`, r.`pubTime`, r.`num`, r.`other`, u.headImgUrl, u.nickname FROM (SELECT * FROM `tb_reply` WHERE `quesId` = ? and type = ? and `status` = 1) r inner join tb_wxuser u on r.userwx = u.userwx where u.status = 1 order by r.replyId desc limit ?, ? ";
		Object[] o = { quesId, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Reply> replys = new ArrayList<Reply>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Reply reply = new Reply();

				reply.setReplyId(Integer.parseInt(os[i][0].toString()));
				reply.setContent(os[i][1].toString());
				reply.setUserwx(os[i][2].toString());
				reply.setWxaccount(os[i][3].toString());
				reply.setPubTime(os[i][4].toString().substring(0, 16));
				reply.setNum(Integer.parseInt(os[i][5].toString()));
				reply.setOther(os[i][6].toString());
				reply.setHeadImgUrl(os[i][7] == null ? "" : os[i][7].toString());
				reply.setNickname(os[i][8] == null ? "" : os[i][8].toString());

				replys.add(reply);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getReplys出错；quesId:" + quesId + ",type:" + type);
		}
		return replys;
	}

	public Question getQues(String quesId) {
		String sql = "SELECT `content`, `replyNum`, `visitPerson`, `other`, `userwx`, `pubTime`, `num` FROM `tb_ques` WHERE `quesId` = ? and `status` = 1 ";
		Object[] o = { quesId };
		Question ques = new Question();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				ques.setContent(os[i][0].toString());
				ques.setReplyNum(Integer.parseInt(os[i][1].toString()));
				ques.setVisitPerson(Integer.parseInt(os[i][2].toString()));
				ques.setOther(os[i][3].toString());
				ques.setUserwx(os[i][4].toString());
				ques.setPubTime(os[i][5].toString().substring(0, 16));
				ques.setNum(Integer.parseInt(os[i][6].toString()));
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getQues出错；quesId:" + quesId);
		}
		return ques;
	}

	public boolean addReply(Reply reply) {
		String sql = "INSERT INTO `tb_reply`(`quesId`, `content`, `other`, `userwx`, `wxaccount`, `num`, type) VALUES (?, ?, ?, ?, ?, ?, ?) ";
		Object[] o = { reply.getQuesId(), reply.getContent(), reply.getOther(),
				reply.getUserwx(), reply.getWxaccount(), reply.getNum(),
				reply.getType() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addReply出错；quesId:" + reply.getQuesId() + ",content:"
							+ reply.getContent() + ",other:" + reply.getOther()
							+ ",userwx:" + reply.getUserwx() + ",wxaccount:"
							+ reply.getWxaccount() + ",num:" + reply.getNum()
							+ ",type:" + reply.getType());
			return false;
		}
	}

	public boolean addQues(Question ques) {
		String sql = "INSERT INTO `tb_ques`(`topicId`, `content`, `other`, `userwx`, `wxaccount`, `num`, `pubTime` ) VALUES (?, ?, ?, ?, ?, ?, now()) ";
		Object[] o = { ques.getTopicId(), ques.getContent(), ques.getOther(),
				ques.getUserwx(), ques.getWxaccount(), ques.getNum() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addQues出错；topicId:" + ques.getTopicId() + ",content:"
							+ ques.getContent() + ",userwx:" + ques.getUserwx()
							+ ",wxaccount:" + ques.getWxaccount() + ",other:"
							+ ques.getOther() + ",num:" + ques.getNum());
			return false;
		}
	}

	public void updateFiled(String quesId, String filed) {
		String sql = "UPDATE `tb_ques` SET " + filed + " = " + filed
				+ " + 1 WHERE `quesId`= ? ";
		Object[] o = { quesId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "updateReplyNum出错；quesId:" + quesId);
		}
	}

	public int getMaxNum_ques(String wxaccount, String topicId) {
		String sql = "SELECT max(`num`) FROM `tb_ques` WHERE `wxaccount` = ? and `topicId` = ? and status = 1 ";
		Object[] o = { wxaccount, topicId };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"从tb_ques表getMaxNum出错；wxaccount:" + wxaccount + ",topicId:"
							+ topicId);
			return 0;
		}
	}

	public int getMaxNum_reply(String quesId, int type) {
		String sql = "SELECT max(`num`) FROM `tb_reply` WHERE `quesId` = ? and type = ? and status = 1 ";
		Object[] o = { quesId, type };
		try {
			Result result = connDB.query(sql, o);

			Object firstRowCol = result.getRowsByIndex()[0][0];
			if (firstRowCol == null) {
				return 0;
			} else {
				return Integer.parseInt(firstRowCol.toString());
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_reply表getMaxNum出错；quesId:" + quesId + ",type:" + type);
			return 0;
		}
	}

	public int getTotalRecord_ques(String wxaccount, String topicId) {
		String sql = "select count(*) from tb_ques where wxaccount = ? and topicId = ? and status = 1 ";
		Object[] o = { wxaccount, topicId };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_ques中得到总记录数出错");
			return 0;
		}
	}

	public int getTotalRecordByUserwx_ques(String wxaccount, String userwx,
			String topicId) {
		// String sql =
		// "select count(*) from tb_ques where wxaccount = ? and topicId = ? and (userwx = ? or quesId in (select quesId from tb_reply where userwx = ? and type = 1 )) and status = 1 ";
		String sql = "select count(*) from ((select * FROM  `tb_ques`  WHERE  `wxaccount` = ? AND  `topicId` = ? and userwx = ? and status = 1) union (select q.* from tb_ques q, (SELECT quesId FROM tb_reply WHERE `wxaccount` = ? and userwx = ? AND TYPE =1 and status = 1) r where q.quesId = r.quesId and q.topicId = ? and q.status = 1)) u";
		Object[] o = { wxaccount, topicId, userwx, wxaccount, userwx, topicId };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_ques中得到总记录数出错");
			return 0;
		}
	}

	public int getTotalRecord_reply(String quesId, int type) {
		String sql = "select count(*) from tb_reply where quesId = ? and type = ? and status = 1 ";
		Object[] o = { quesId, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_reply中得到总记录数出错");
			return 0;
		}
	}

	public boolean changeStatus_ques(String quesId) {
		String sql = "UPDATE `tb_ques` SET `status` = -1  WHERE `quesId`= ? ";
		Object[] o = { quesId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "tb_ques删除数据出错；quesId:" + quesId);
			return false;
		}
	}

	public boolean changeStatus_reply(String replyId) {
		String sql = "UPDATE `tb_reply` SET `status` = -1  WHERE `replyId`= ? ";
		Object[] o = { replyId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "tb_reply删除数据出错；replyId:" + replyId);
			return false;
		}
	}
}
