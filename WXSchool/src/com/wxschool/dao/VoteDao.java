package com.wxschool.dao;

import java.util.*;
import javax.servlet.jsp.jstl.sql.*;
import com.wxschool.entity.*;

public class VoteDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Vote> getVotes(String wxaccount, String topicId,
			String orderBy, Page page, int status) {
		String sql = "SELECT `voteId`, `name`, `content`, `supportNum`, `opposeNum`, `addTime`, `num`, `size`, `status`, `remark` FROM `tb_vote` "
				+ "WHERE `wxaccount` = ? and `topicId` = ? and `status` >= ?  order by "
				+ orderBy + " desc limit ? , ? ";
		Object[] o = { wxaccount, topicId, status,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();

				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1] == null ? "" : os[i][1].toString());
				v.setContent(os[i][2] == null ? "" : os[i][2].toString());
				v.setSupportNum(Integer.parseInt(os[i][3].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][4].toString()));
				v.setAddTime(os[i][5].toString().substring(0, 16));
				v.setNum(Integer.parseInt(os[i][6].toString()));
				v.setSize(Long.parseLong(os[i][7].toString()));
				v.setStatus(Integer.parseInt(os[i][8].toString()));
				v.setRemark(os[i][9] == null ? "" : os[i][9].toString());

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getVotes出错；wxaccount:" + wxaccount + ",topicId:" + topicId
							+ ",orderBy:" + orderBy + ",status:" + status);
		}
		return vs;
	}

	public List<Vote> getVotesByStatus(String wxaccount, String topicId,
			String orderBy, Page page, int status) {
		String sql = "SELECT `voteId`, `name`, `content`, `supportNum`, `opposeNum`, `addTime`, `num`, `size`, `status`, `remark`, `replyNum`, `userwx` FROM `tb_vote` "
				+ "WHERE `wxaccount` = ? and `topicId` = ? and `status` = ?  order by "
				+ orderBy + " desc limit ? , ? ";
		Object[] o = { wxaccount, topicId, status,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();
				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1] == null ? "" : os[i][1].toString());
				v.setContent(os[i][2] == null ? "" : os[i][2].toString());
				v.setSupportNum(Integer.parseInt(os[i][3].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][4].toString()));
				v.setAddTime(os[i][5].toString().substring(0, 16));
				v.setNum(Integer.parseInt(os[i][6].toString()));
				v.setSize(Long.parseLong(os[i][7].toString()));
				v.setStatus(Integer.parseInt(os[i][8].toString()));
				v.setRemark(os[i][9] == null ? "" : os[i][9].toString());
				v.setReplyNum(Integer.parseInt(os[i][10].toString()));
				v.setUserwx(os[i][11] == null ? "" : os[i][11].toString());

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getVotesByStatus出错；wxaccount:" + wxaccount + ",topicId:"
							+ topicId + ",orderBy:" + orderBy + ",status:"
							+ status);
		}
		return vs;
	}

	public List<Vote> getVotesAndWxuser(String wxaccount, String topicId,
			String orderBy, Page page) {
		String sql = "SELECT v.`voteId`, v.`content`, v.`supportNum`, v.`opposeNum`, v.`addTime`, v.`num`, v.`replyNum`, v.`userwx`, u.headImgUrl, u.nickname, v.`name` FROM (SELECT * FROM `tb_vote` WHERE `wxaccount` = ? and `topicId` = ? and `status` = 1  order by "
				+ orderBy
				+ " desc limit ? , ? ) v inner join tb_wxuser u on v.userwx = u.userwx where u.status = 1 order by "
				+ orderBy + " desc";
		Object[] o = { wxaccount, topicId,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();
				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setContent(os[i][1] == null ? "" : os[i][1].toString());
				v.setSupportNum(Integer.parseInt(os[i][2].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][3].toString()));
				v.setAddTime(os[i][4].toString().substring(0, 16));
				v.setNum(Integer.parseInt(os[i][5].toString()));
				v.setReplyNum(Integer.parseInt(os[i][6].toString()));
				v.setUserwx(os[i][7] == null ? "" : os[i][7].toString());
				v.setHeadImgUrl(os[i][8] == null ? "" : os[i][8].toString());
				v.setNickname(os[i][9] == null ? "" : os[i][9].toString());
				v.setName(os[i][10] == null ? "" : os[i][10].toString());

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getVotesAndWxuser出错；wxaccount:" + wxaccount + ",topicId:"
							+ topicId + ",orderBy:" + orderBy);
		}
		return vs;
	}

	public List<Vote> getVotesByUserwx(String wxaccount, String userwx,
			String topicId, Page page) {
		String sql = "(select `voteId`, `name`, `content`, `supportNum`, `opposeNum`, `addTime`, `num`, `size`, `status`, `remark`, `replyNum`, `userwx` FROM  `tb_vote`  WHERE  `wxaccount` = ? AND  `topicId` = ? and userwx = ? and status = 1) union (select v.`voteId`, v.`name`, v.`content`, v.`supportNum`, v.`opposeNum`, v.`addTime`, v.`num`, v.`size`, v.`status`, v.`remark`, v.`replyNum`, v.`userwx` from (SELECT quesId FROM tb_reply WHERE `wxaccount` = ? and userwx = ? AND TYPE =2 and status = 1) r left join tb_vote v on v.voteId = r.quesId where v.status = 1) ORDER BY voteId DESC limit ?, ? ";
		Object[] o = { wxaccount, topicId, userwx, wxaccount, userwx,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();
				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1] == null ? "" : os[i][1].toString());
				v.setContent(os[i][2] == null ? "" : os[i][2].toString());
				v.setSupportNum(Integer.parseInt(os[i][3].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][4].toString()));
				v.setAddTime(os[i][5].toString().substring(0, 16));
				v.setNum(Integer.parseInt(os[i][6].toString()));
				v.setSize(Long.parseLong(os[i][7].toString()));
				v.setStatus(Integer.parseInt(os[i][8].toString()));
				v.setRemark(os[i][9] == null ? "" : os[i][9].toString());
				v.setReplyNum(Integer.parseInt(os[i][10].toString()));
				v.setUserwx(os[i][11] == null ? "" : os[i][11].toString());

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getVotesByUserwx出错；wxaccount:" + wxaccount + ",topicId:"
							+ topicId + ",userwx:" + userwx);
		}
		return vs;
	}

	public List<Vote> getVotesAndWxuserByUserwx(String wxaccount,
			String userwx, String topicId, Page page) {
		String sql = "select v.*, u.headImgUrl, u.nickname from ((select `voteId`, `name`, `content`, `supportNum`, `opposeNum`, `addTime`, `num`, `replyNum`, `userwx` FROM  `tb_vote`  WHERE  `wxaccount` = ? AND  `topicId` = ? and userwx = ? and status = 1) union (select v.`voteId`, v.`name`, v.`content`, v.`supportNum`, v.`opposeNum`, v.`addTime`, v.`num`, v.`replyNum`, v.`userwx` from (SELECT quesId FROM tb_reply WHERE `wxaccount` = ? and userwx = ? AND TYPE = 2 and status = 1) r left join tb_vote v on v.voteId = r.quesId where v.status = 1)) v inner join tb_wxuser u on v.userwx = u.userwx where u.status = 1 ORDER BY v.voteId DESC limit ?, ?";
		Object[] o = { wxaccount, topicId, userwx, wxaccount, userwx,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();
				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1] == null ? "" : os[i][1].toString());
				v.setContent(os[i][2] == null ? "" : os[i][2].toString());
				v.setSupportNum(Integer.parseInt(os[i][3].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][4].toString()));
				v.setAddTime(os[i][5].toString().substring(0, 16));
				v.setNum(Integer.parseInt(os[i][6].toString()));
				v.setReplyNum(Integer.parseInt(os[i][7].toString()));
				v.setUserwx(os[i][8] == null ? "" : os[i][8].toString());
				v.setHeadImgUrl(os[i][9] == null ? "" : os[i][9].toString());
				v.setNickname(os[i][10] == null ? "" : os[i][10].toString());

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getVotesAndWxuserByUserwx出错；wxaccount:" + wxaccount
							+ ",topicId:" + topicId + ",userwx:" + userwx);
		}
		return vs;
	}

	public List<Vote> getVotesBySearch(String wxaccount, String topicId,
			String keyword, Page page, int status) {
		String sql = "SELECT `voteId`, `name`, `content`, `supportNum`, `addTime`, `size`, `status`, `remark` FROM `tb_vote` "
				+ "WHERE `wxaccount` = ? and `topicId` = ? and `status` >= ? and (`name` like ? or `remark` like ? )  order by voteId desc limit ?, ? ";
		Object[] o = { wxaccount, topicId, status, "%" + keyword + "%",
				"%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();

				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1] == null ? "" : os[i][1].toString());
				v.setContent(os[i][2] == null ? "" : os[i][2].toString());
				v.setSupportNum(Integer.parseInt(os[i][3].toString()));
				v.setAddTime(os[i][4].toString().substring(0, 16));
				v.setSize(Long.parseLong(os[i][5].toString()));
				v.setStatus(Integer.parseInt(os[i][6].toString()));
				v.setRemark(os[i][7] == null ? "" : os[i][7].toString());

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getVotesBySearch出错；wxaccount:" + wxaccount + ",topicId:"
							+ topicId + ",keyword:" + keyword + ",status:"
							+ status);
		}
		return vs;
	}

	public List<Vote> searchByKeyword(String wxaccount, String keyword,
			Page page, String topicId) {
		String sql = "SELECT `voteId`, `name`, `content`, `supportNum`, `addTime`, `remark`, `num`  FROM `tb_vote` "
				+ "WHERE `wxaccount` = ? and `topicId` = ? and `status` = 1 and (`name` like ? or `remark` like ? or voteId = ? or `num` = ?) order by voteId desc limit ? , ? ";
		Object[] o = { wxaccount, topicId, "%" + keyword + "%",
				"%" + keyword + "%", keyword, keyword,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Vote> vs = new ArrayList<Vote>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Vote v = new Vote();
				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1] == null ? "" : os[i][1].toString());
				v.setContent(os[i][2] == null ? "" : os[i][2].toString());
				v.setSupportNum(Integer.parseInt(os[i][3].toString()));
				v.setAddTime(os[i][4].toString().substring(0, 16));
				v.setRemark(os[i][5] == null ? "" : os[i][5].toString());
				v.setNum(Integer.parseInt(os[i][6].toString()));

				vs.add(v);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchByKeyword出错；wxaccount:" + wxaccount + ",keyword:"
							+ keyword + ",topicId:" + topicId);
		}
		return vs;
	}

	public Vote getVote(String voteId) {
		String sql = "SELECT `content`, `supportNum`, `addTime`, `name`, `remark`, `status`, `opposeNum`, `replyNum`, `userwx` FROM `tb_vote` WHERE `voteId` = ? and `status` >= 0 ";
		Object[] o = { voteId };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Vote v = new Vote();

			for (int i = 0, len = os.length; i < len; i++) {
				v.setContent(os[i][0] == null ? "" : os[i][0].toString());
				v.setSupportNum(Integer.parseInt(os[i][1].toString()));
				v.setAddTime(os[i][2].toString().substring(0, 16));
				v.setName(os[i][3] == null ? "" : os[i][3].toString());
				v.setRemark(os[i][4] == null ? "" : os[i][4].toString());
				v.setStatus(Integer.parseInt(os[i][5].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][6].toString()));
				v.setReplyNum(Integer.parseInt(os[i][7].toString()));
				v.setUserwx(os[i][8] == null ? "" : os[i][8].toString());
				v.setVoteId(Integer.parseInt(voteId));
			}
			return v;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getVote出错；voteId:" + voteId);
			return null;
		}
	}

	public Vote getVoteAndWxuser(String voteId) {
		String sql = "SELECT v.`content`, v.`supportNum`, v.`opposeNum`, v.`replyNum`, v.`addTime`, v.`name`, v.`userwx`, u.headImgUrl, u.nickname FROM (SELECT * FROM `tb_vote` WHERE `voteId` = ? and `status` = 1 ) v inner join tb_wxuser u on v.userwx = u.userwx where u.status = 1 ";
		Object[] o = { voteId };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Vote v = new Vote();

			for (int i = 0, len = os.length; i < len; i++) {
				v.setContent(os[i][0] == null ? "" : os[i][0].toString());
				v.setSupportNum(Integer.parseInt(os[i][1].toString()));
				v.setOpposeNum(Integer.parseInt(os[i][2].toString()));
				v.setReplyNum(Integer.parseInt(os[i][3].toString()));
				v.setAddTime(os[i][4].toString().substring(0, 16));
				v.setName(os[i][5] == null ? "" : os[i][5].toString());
				v.setUserwx(os[i][6] == null ? "" : os[i][6].toString());
				v.setHeadImgUrl(os[i][7] == null ? "" : os[i][7].toString());
				v.setNickname(os[i][8] == null ? "" : os[i][8].toString());
				v.setVoteId(Integer.parseInt(voteId));
			}
			return v;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getVoteAndWxuser出错；voteId:" + voteId);
			return null;
		}
	}

	public Vote getVoteByFiled(String value) {
		String sql = "SELECT `voteId`, `name`, `status`, `topicId` FROM `tb_vote` WHERE `content` like ? ";
		Object[] o = { "%" + value + "%" };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Vote v = new Vote();

			for (int i = 0, len = os.length; i < len; i++) {
				v.setVoteId(Integer.parseInt(os[i][0].toString()));
				v.setName(os[i][1].toString());
				v.setStatus(Integer.parseInt(os[i][2].toString()));
				v.setTopicId(Integer.parseInt(os[i][3].toString()));
				v.setContent(value);
			}
			return v;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getVoteByFiled出错；value:" + value);
			return null;
		}
	}

	public boolean updateBoyGirl(Vote vote) {
		String sql = "UPDATE `tb_vote` SET `name`= ? , `content`= ?, `topicId`= ?, `status`= ?, `remark`= ? WHERE `voteId` = ? ";
		Object[] o = { vote.getName(), vote.getContent(), vote.getTopicId(),
				vote.getStatus(), vote.getRemark(), vote.getVoteId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateBoyGirl出错；voteId:" + vote.getVoteId() + ",name:"
							+ vote.getName() + ",remark:" + vote.getRemark());
			return false;
		}
	}

	public boolean updateSizeAndStatus(String voteId, long size, int status) {
		String sql = "UPDATE `tb_vote` SET `size`= ? , `status`= ? WHERE `voteId` = ? ";
		Object[] o = { size, status, voteId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateSizeAndStatus出错；voteId:" + voteId + ",size:" + size
							+ ",status:" + status);
			return false;
		}
	}

	public void updateFiled(String voteId, String field) {
		String sql = "UPDATE `tb_vote` SET " + field + "=" + field
				+ "+ 1   WHERE `voteId`= ? ";
		Object[] o = { voteId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"updateFiled出错；voteId:" + voteId + ",field:" + field);
		}
	}

	public void updateFiledVal(int voteId, int val) {
		String sql = "UPDATE `tb_vote` SET num = ? WHERE `voteId`= ? ";
		Object[] o = { val, voteId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "updateFiledVal出错");
		}
	}

	public boolean addVote(Vote v) {
		String sql = "INSERT INTO `tb_vote`(`name`, `content`, `topicId`, `wxaccount`, `userwx` , `num`, `addTime`, `size`, `status`, `remark`) VALUES (?, ?, ?, ?, ?, ?, now(), ?, ?, ?) ";
		Object[] o = { v.getName(), v.getContent(), v.getTopicId(),
				v.getWxaccount(), v.getUserwx(), v.getNum(), v.getSize(),
				v.getStatus(), v.getRemark() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addVote出错；name:" + v.getName() + ",content:"
							+ v.getContent() + ",topicId:" + v.getTopicId()
							+ ",wxaccount:" + v.getWxaccount() + ",userwx:"
							+ v.getUserwx() + ",num:" + v.getNum() + ",size:"
							+ v.getSize() + ",status:" + v.getStatus()
							+ ",remark:" + v.getRemark());
			return false;
		}
	}

	public boolean addVotePerson(String voteId, String wxaccount, String userwx) {
		String sql = "INSERT INTO `tb_voteperson`(`voteId`, `userwx`, `wxaccount`) VALUES (?, ?, ?) ";
		Object[] o = { voteId, userwx, wxaccount };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addVotePerson出错；voteId:" + voteId + ",wxaccount:"
							+ wxaccount + ",userwx:" + userwx);
			return false;
		}
	}

	public boolean updateVoteAccount(String voteId, String wxaccount,
			String userwx) {
		String sql = "UPDATE `tb_voteperson` SET `voteAccount` = `voteAccount` + 1 WHERE `voteId`= ? and `userwx`= ? and `wxaccount`= ? ";
		Object[] o = { voteId, userwx, wxaccount };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateVoteAccount出错；voteId:" + voteId + ",wxaccount:"
							+ wxaccount + ",userwx:" + userwx);
			return false;
		}
	}

	public boolean hasVote(String voteId, String wxaccount, String userwx) {
		String sql = "SELECT `vpId` FROM `tb_voteperson` WHERE `voteId` = ? and`userwx` = ? and `wxaccount` = ?";
		Object[] o = { voteId, userwx, wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return result.getRowCount() > 0;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"hasVote出错；voteId:" + voteId + ",wxaccount:" + wxaccount
							+ ",userwx:" + userwx);
			return true;
		}
	}

	public int hasTodayVote(String voteId, String wxaccount, String userwx) {
		String sql = "SELECT datediff(date(`voteTime`),curdate()) FROM `tb_voteperson` WHERE `voteId` = ? and `userwx` = ? and `wxaccount` = ? ";
		Object[] o = { voteId, userwx, wxaccount };
		try {
			Result result = connDB.query(sql, o);
			if (result.getRowCount() == 0) {
				return 0;// 没有数据表示没投过
			} else {
				String datediff = result.getRowsByIndex()[0][0].toString();

				if (datediff.equals("0")) {
					return 1;// 表示今天已经投过
				} else {
					return -1;// 表示今天没有投过
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"hasTodayVote出错；voteId:" + voteId + ",wxaccount:"
							+ wxaccount + ",userwx:" + userwx);
			return -1;// 如果出错了表示今天没投过
		}
	}

	public int getTotalRecordByUserwx(String wxaccount, String userwx,
			String topicId) {
		// String sql =
		// "select count(*) from tb_vote where wxaccount = ? and topicId = ? and (userwx = ? or voteId in (select quesId from tb_reply where userwx = ? and type =2 )) and status = 1 ";
		String sql = "select count(*) from ((select * FROM  `tb_vote`  WHERE  `wxaccount` = ? AND  `topicId` = ? and userwx = ? and status = 1) union (select v.* from tb_vote v, (SELECT quesId FROM tb_reply WHERE `wxaccount` = ? and userwx = ? AND TYPE =2 and status = 1) r where v.voteId = r.quesId and v.status = 1)) u";
		Object[] o = { wxaccount, topicId, userwx, wxaccount, userwx };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_vote中得到总记录数出错getTotalRecordByUserwx");
			return 0;
		}
	}

	public int getTotalRecordByStatus(String wxaccount, String topicId,
			int status) {
		String sql = "select count(*) from tb_vote where wxaccount = ? and topicId = ? and status = ? ";
		Object[] o = { wxaccount, topicId, status };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_vote中得到总记录数出错");
			return 0;
		}
	}

	/*
	 * public Object[][] getVoteTopic(String voteId) { String sql =
	 * "SELECT `subVoteId`, `content`, `supportNum` FROM `tb_subvote` WHERE `voteId` = ? and `status` = 1"
	 * ; Object[] o = { voteId }; try { Result result = connDB.query(sql, o);
	 * return result.getRowsByIndex(); } catch (Exception e) {
	 * LogDao.getLog().addExpLog(e, "getVoteTopic出错；voteId:" + voteId); return
	 * null; } }
	 * 
	 * public Object[][] getVoteTopicByOrder(String voteId) { String sql =
	 * "SELECT `subVoteId`, `content`, `supportNum` FROM `tb_subvote` WHERE `voteId` = ? and `status` = 1 order by `supportNum` desc "
	 * ; Object[] o = { voteId }; try { Result result = connDB.query(sql, o);
	 * return result.getRowsByIndex(); } catch (Exception e) {
	 * LogDao.getLog().addExpLog(e, "getVoteTopic出错；voteId:" + voteId); return
	 * null; } }
	 * 
	 * public void updateSubVoteNum(String subVoteId, int num) { String sql =
	 * "UPDATE `tb_subvote` SET `supportNum`= `supportNum` + ?  " +
	 * "WHERE `subVoteId`= ? and `status` = 1 "; Object[] o = { num, subVoteId
	 * }; try { connDB.update(sql, o); } catch (Exception e) {
	 * LogDao.getLog().addExpLog(e, "subVoteId:" + subVoteId + ",num:" + num); }
	 * }*
	 */

	public int getMaxNum(String wxaccount, String topicId) {
		String sql = "SELECT max(`num`) FROM `tb_vote` WHERE `wxaccount` = ? and `topicId` = ? and status = 1 ";
		Object[] o = { wxaccount, topicId };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getMaxNum出错；wxaccount:" + wxaccount + ",topicId:"
							+ topicId);
			return 1;
		}
	}

	public boolean changeStatus(String voteId, int status) {
		String sql = "UPDATE `tb_vote` SET `status`= ? WHERE `voteId`= ? ";
		Object[] o = { status, voteId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"changeStatus出错；voteId:" + voteId + ",status:" + status);
			return false;
		}
	}

	public boolean delete_Forever(String voteId) {
		String sql = "DELETE FROM `tb_vote` WHERE `voteId` = ? ";
		Object[] o = { voteId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "delete_Forever出错voteId:" + voteId);
			return false;
		}
	}
}
