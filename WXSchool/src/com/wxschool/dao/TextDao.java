package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Page;
import com.wxschool.entity.Text;

public class TextDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Text> getTexts(String wxaccount) {
		String sql = "SELECT `kvId`, `key`, `value` FROM `tb_text` WHERE (`wxaccount` = ? or "
				+ "`wxaccount` = 'admin') and `type` = 2 and `status` = 1 ";
		Object[] o = { wxaccount };
		try {
			Result reslut = connDB.query(sql, o);
			Object[][] os = reslut.getRowsByIndex();

			List<Text> texts = new ArrayList<Text>();
			for (int i = 0, len = os.length; i < len; i++) {
				Text text = new Text();
				text.setTextId(Integer.parseInt(os[i][0].toString()));
				text.setKey(os[i][1].toString());
				text.setValue(os[i][2].toString());
				text.setWxaccount(wxaccount);

				texts.add(text);
			}
			return texts;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getTextReply出错；wxaccount:" + wxaccount);
			return null;
		}
	}

	public List<Text> getTextsByPage(String wxaccount, Page page) {
		String sql = "SELECT `kvId`, `key`, `value`, `status` FROM `tb_text` WHERE `wxaccount` = ? and `type` = 2 and `status` > -1 order by kvId desc limit ? , ? ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		try {
			Result reslut = connDB.query(sql, o);
			Object[][] os = reslut.getRowsByIndex();
			List<Text> texts = new ArrayList<Text>();

			for (int i = 0, len = os.length; i < len; i++) {
				Text text = new Text();
				text.setTextId(Integer.parseInt(os[i][0].toString()));
				text.setKey(os[i][1].toString());
				text.setValue(os[i][2].toString());
				text.setStatus(Integer.parseInt(os[i][3].toString()));
				text.setWxaccount(wxaccount);

				texts.add(text);
			}
			return texts;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getTextReply出错；wxaccount:" + wxaccount);
			return null;
		}
	}

	public List<Text> getTextsByKeyword(String wxaccount, String keyword) {
		String sql = "SELECT `kvId`, `key`, `value` FROM `tb_text` WHERE (`wxaccount` = ? or `wxaccount` = 'admin') and `key` like ? "
				+ "  and `type` = 2 and `status` = 1 order by kvId desc ";
		Object[] o = { wxaccount, "%" + keyword + "%" };
		List<Text> texts = new ArrayList<Text>();

		try {
			Result reslut = connDB.query(sql, o);
			Object[][] os = reslut.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Text text = new Text();
				text.setTextId(Integer.parseInt(os[i][0].toString()));
				text.setKey(os[i][1].toString());
				text.setValue(os[i][2].toString());
				text.setWxaccount(wxaccount);

				texts.add(text);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchByKeyword出错；wxaccount:" + wxaccount + ",keyword:"
							+ keyword);
		}
		return texts;
	}

	public List<Text> searchByKeyword(String wxaccount, String keyword,
			Page page) {
		String sql = "SELECT `kvId`, `key`, `value`, `status` FROM `tb_text` WHERE `wxaccount` = ? and `key` like ? "
				+ "  and `type` = 2 and `status` > -1 order by kvId desc limit ? , ? ";
		Object[] o = { wxaccount, "%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		try {
			Result reslut = connDB.query(sql, o);
			Object[][] os = reslut.getRowsByIndex();
			List<Text> texts = new ArrayList<Text>();

			for (int i = 0, len = os.length; i < len; i++) {
				Text text = new Text();
				text.setTextId(Integer.parseInt(os[i][0].toString()));
				text.setKey(os[i][1].toString());
				text.setValue(os[i][2].toString());
				text.setStatus(Integer.parseInt(os[i][3].toString()));
				text.setWxaccount(wxaccount);

				texts.add(text);
			}
			return texts;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchByKeyword出错；wxaccount:" + wxaccount + ",keyword:"
							+ keyword);
			return null;
		}
	}

	public Text getText(String textId) {
		String sql = "SELECT `key`, `value`, `wxaccount` FROM `tb_text` WHERE `kvId` = ? ";
		Object[] o = { textId };
		Text text = new Text();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				text.setKey(os[i][0].toString());
				text.setValue(os[i][1].toString());
				text.setWxaccount(os[i][2].toString());
				text.setTextId(Integer.parseInt(textId));
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getText出错；textId:" + textId);
		}
		return text;
	}

	public Text getSubscribe(String wxaccount) {
		String sql = "SELECT `value`, `status` FROM `tb_text` WHERE `wxaccount` = ? and `key` = 'subscribe' ";
		Object[] o = { wxaccount };
		Text text = new Text();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				text.setValue(os[i][0].toString());
				text.setStatus(Integer.parseInt(os[i][1].toString()));
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getSubscribe出错；wxaccount:" + wxaccount);
		}
		return text;
	}

	public int getTotalRecord(String wxaccount) {
		String sql = "select count(*) from `tb_text` where wxaccount = ? and `type` = 2 and `status` = 1 ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_text中得到总记录数出错");
			return 0;
		}
	}

	public boolean updateText(Text text) {
		String sql = "UPDATE `tb_text` SET `key`= ? ,`value`= ? , `wxaccount`= ? WHERE `kvId` = ? ";
		Object[] o = { text.getKey(), text.getValue(), text.getWxaccount(),
				text.getTextId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateText出错；textId:" + text.getTextId() + ",wxaccout:"
							+ text.getWxaccount() + ",key:" + text.getKey()
							+ ",value:" + text.getValue());
			return false;
		}
	}

	public boolean updateSubscribe(Text text) {
		String sql = "UPDATE `tb_text` SET `value`= ? WHERE `wxaccount`= ? and `key`= 'subscribe' ";
		Object[] o = { text.getValue(), text.getWxaccount() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateSubscribe出错；wxaccout:" + text.getWxaccount()
							+ ",value:" + text.getValue());
			return false;
		}
	}

	public boolean addText(Text text) {
		String sql = "INSERT INTO `tb_text`(`key`, `value`, `wxaccount`, `status`) VALUES (?, ?, ?, ?) ";
		Object[] o = { text.getKey(), text.getValue(), text.getWxaccount(),
				text.getStatus() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addText出错；wxaccout:" + text.getWxaccount() + ",key:"
							+ text.getKey() + ",value:" + text.getValue());
			return false;
		}
	}

	public boolean changeStatusById(String textId, String status) {
		String sql = "UPDATE `tb_text` SET `status` = ?  WHERE `kvId`= ? ";
		Object[] o = { status, textId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"deleteText出错；textId:" + textId + ",status:" + status);
			return false;
		}
	}
}
