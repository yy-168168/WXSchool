package com.wxschool.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Topic;

public class TopicDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Topic> getTopics(String wxid, String cate,
			boolean isRemoveExpire) {
		String expireSql = isRemoveExpire ? " and `overTime` > now() and cate != 20 "
				: "";

		String sql = "SELECT `topicId`, `title`, `info`, `personNum`, `pubTime`, `overTime`, `capacity`, `cate` FROM `tb_topic` WHERE `wxaccount` = ? and `cate` like ? and `status` = 1 "
				+ expireSql + " order by topicId asc ";

		Object[] o = { wxid, cate + "%" };
		List<Topic> topics = new ArrayList<Topic>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Topic topic = new Topic();
				topic.setTopicId(Integer.parseInt(os[i][0].toString()));
				topic.setTitle(os[i][1].toString());
				topic.setInfo(os[i][2].toString());
				topic.setPersonNum(Integer.parseInt(os[i][3].toString()));
				topic.setPubTime(os[i][4].toString().substring(0, 16));
				topic.setOverTime(os[i][5].toString().substring(0, 16));
				topic.setCapacity(Integer.parseInt(os[i][6].toString()));
				topic.setCate(Integer.parseInt(os[i][7].toString()));

				topics.add(topic);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getTopics出错；wxid:" + wxid + ",cate:" + cate);
		}
		return topics;
	}

	/**
	 * 获取每个topicId下已审核照片的数量
	 * 
	 * @param wxaccount
	 * @param topicId
	 * @param cate
	 * @return
	 */
	public Map<String, String> getCountOfEveryTopic(String wxaccount,
			String topicId, String cate) {
		String topicSql = topicId == null ? "" : " and topicId = " + topicId;
		String sql = "select t.capacity, count(*) from (SELECT * FROM `tb_topic` WHERE wxaccount = ? "
				+ topicSql
				+ " and cate like ?) t inner join tb_vote v on t.topicId = v.topicId where v.status = 1 group by t.topicId";
		Object[] o = { wxaccount, cate + "%" };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Map<String, String> counts = new HashMap<String, String>();

			for (int i = 0, len = os.length; i < len; i++) {
				counts.put(os[i][0].toString(), os[i][1].toString());
			}

			return counts;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getCountOfEveryTopic错误；wxaccount:" + wxaccount
							+ ",topicId:" + topicId);
			return null;
		}

	}

	public Topic getTopic(String topicId) {
		String sql = "SELECT `wxaccount`, `title`, `desc`, `pubTime`, `cate`, `personNum`, `overTime`, `info`, `capacity`, `qrcodeUrl` FROM `tb_topic` WHERE `topicId` = ? and `status` = 1 ";
		Object[] o = { topicId };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Topic topic = new Topic();

			for (int i = 0, len = os.length; i < len; i++) {
				topic.setWxaccount(os[i][0].toString());
				topic.setTitle(os[i][1].toString());
				topic.setDesc(os[i][2].toString());
				topic.setPubTime(os[i][3].toString().substring(0, 16));
				topic.setCate(Integer.parseInt(os[i][4].toString()));
				topic.setPersonNum(Integer.parseInt(os[i][5].toString()));
				topic.setTopicId(Integer.parseInt(topicId));
				topic.setOverTime(os[i][6].toString().substring(0, 16));
				topic.setInfo(os[i][7] == null ? "" : os[i][7].toString());
				topic.setCapacity(Integer.parseInt(os[i][8].toString()));
				topic.setQrcodeUrl(os[i][9] == null ? "" : os[i][9].toString());
			}
			return topic;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getTopic出错；topicId:" + topicId);
		}
		return null;
	}

	public Topic getTopic(String wxaccount, String cate) {
		String sql = "SELECT `topicId`, `title`, `desc`, `pubTime`, `overTime`, `capacity` FROM `tb_topic` WHERE `wxaccount` = ? and `cate` = ? and `status` = 1 ";
		Object[] o = { wxaccount, cate };
		Topic topic = new Topic();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				topic.setTopicId(Integer.parseInt(os[i][0].toString()));
				topic.setTitle(os[i][1].toString());
				topic.setDesc(os[i][2].toString());
				topic.setPubTime(os[i][3].toString().substring(0, 16));
				topic.setOverTime(os[i][4].toString().substring(0, 16));
				topic.setCapacity(Integer.parseInt(os[i][5].toString()));
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getTopic出错；wxaccount:" + wxaccount + ",cate:" + cate);
		}
		return topic;
	}

	public boolean addTopic(Topic topic) {
		String sql = "INSERT INTO `tb_topic`(`title`, `desc`, `personNum`, `cate`, `wxaccount`, `overTime`, `info`) VALUES (?, ?, ?, ?, ?, ?, ?) ";
		Object[] o = { topic.getTitle(), topic.getDesc(), topic.getPersonNum(),
				topic.getCate(), topic.getWxaccount(), topic.getOverTime(),
				topic.getInfo() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addTopic出错；wxid:" + topic.getWxaccount() + ",title:"
							+ topic.getTitle() + ",info:" + topic.getInfo()
							+ ",personNum:" + topic.getPersonNum() + ",cate:"
							+ topic.getCate() + ",overTime:"
							+ topic.getOverTime());
			return false;
		}
	}

	public boolean updateTopic(Topic topic) {
		String sql = "UPDATE `tb_topic` SET `title`= ? ,`desc`= ?, `overTime` = ?, `info` = ? WHERE `topicId` = ? ";
		Object[] o = { topic.getTitle(), topic.getDesc(), topic.getOverTime(),
				topic.getInfo(), topic.getTopicId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateTopic出错；topicId:" + topic.getTopicId() + ",title:"
							+ topic.getTitle() + ",info:" + topic.getInfo()
							+ ",overTime:" + topic.getOverTime());
			return false;
		}
	}

	public void updatePersonNum(String topicId) {
		String sql = "UPDATE `tb_topic` SET personNum = personNum + 1   WHERE `topicId`= ? ";
		Object[] o = { topicId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog()
					.addExpLog(e, "updatePersonNum出错；topicId:" + topicId);
		}
	}

	public int hasExpire(String topicId) {
		String sql = "SELECT timestampdiff(second , `overTime`, now()) FROM `tb_topic` WHERE `topicId` = ? ";
		Object[] o = { topicId };
		try {
			Result result = connDB.query(sql, o);
			if (result.getRowCount() == 0) {
				return 0;// 表示没有数据
			} else {
				String timestampdiff = result.getRowsByIndex()[0][0].toString();

				if (timestampdiff.startsWith("-")) {
					return 1;// 表示未过期
				} else {
					return 2;// 表示已过期
				}
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "hasExpire出错；topicId:" + topicId);
			return -1;// 出错
		}
	}

	public boolean delete(String topicId) {
		String sql = "UPDATE `tb_topic` SET `status`= -1  WHERE `topicId`= ? ";
		Object[] o = { topicId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "delete出错；topicId:" + topicId);
			return false;
		}
	}
}
