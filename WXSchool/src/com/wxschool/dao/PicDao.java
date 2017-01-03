package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;
import com.wxschool.entity.Page;
import com.wxschool.entity.Pic;

public class PicDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Pic> getPics(String wxaccount) {
		String sql = "SELECT `picId`, `visitPerson`, `keyword`, `title`, `desc` FROM `tb_pic` WHERE `wxaccount` = ? and `type` = 1 and `status` = 1 order by `picId` desc ";
		Object[] o = { wxaccount };
		List<Pic> pics = new ArrayList<Pic>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Pic pic = new Pic();
				pic.setPicId(Integer.parseInt(os[i][0].toString()));
				pic.setVisitPerson(Integer.parseInt(os[i][1].toString()));
				pic.setKeyword(os[i][2] == null ? "" : os[i][2].toString());
				pic.setTitle(os[i][3].toString());
				pic.setDesc(os[i][4] == null ? "" : os[i][4].toString());

				pics.add(pic);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getPics出错;wxaccount:" + wxaccount);
		}
		return pics;
	}

	public List<Pic> getPicsByKeyword(String wxaccount, String keyword) {
		String sql = "SELECT `picId`, `visitPerson`, `keyword`, `title`, `desc` FROM `tb_pic` WHERE `wxaccount` = ? and `keyword` like ? and `type` = 1 and `status` = 1 ";
		Object[] o = { wxaccount, "%" + keyword + "%" };
		List<Pic> pics = new ArrayList<Pic>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Pic pic = new Pic();
				pic.setPicId(Integer.parseInt(os[i][0].toString()));
				pic.setVisitPerson(Integer.parseInt(os[i][1].toString()));
				pic.setKeyword(os[i][2] == null ? "" : os[i][2].toString());
				pic.setTitle(os[i][3].toString());
				pic.setDesc(os[i][4] == null ? "" : os[i][4].toString());

				pics.add(pic);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getPicsByKeyword出错;wxaccount:" + wxaccount + ",keyword:"
							+ keyword);
		}
		return pics;
	}

	public List<Pic> getPicsByPage(String wxaccount, Page page, int type,
			String orderBy) {
		String sql = "SELECT `picId`, `title`, `picUrl`, `visitPerson`, `keyword`,  `addTime`, `desc` FROM `tb_pic` WHERE `wxaccount` = ? and `type` = ? and `status` = 1 order by "
				+ orderBy + " desc limit ? , ? ";
		Object[] o = { wxaccount, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Pic> pics = new ArrayList<Pic>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Pic pic = new Pic();
				pic.setPicId(Integer.parseInt(os[i][0].toString()));
				pic.setTitle(os[i][1].toString());
				pic.setPicUrl(os[i][2].toString());
				pic.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				pic.setKeyword(os[i][4] == null ? "" : os[i][4].toString());
				pic.setAddTime(os[i][5].toString().substring(0, 16));
				pic.setDesc(os[i][6] == null ? "" : os[i][6].toString());

				pics.add(pic);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getPicsByPage出错;wxaccount:" + wxaccount + ",type:" + type);
		}
		return pics;
	}

	public Pic getPicById(String picId) {
		String sql = "SELECT `type`, `title`, `picUrl`, `visitPerson`, `wxaccount`, `keyword`, `desc` FROM `tb_pic` WHERE `picId` = ? ";
		Object[] o = { picId };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Pic pic = new Pic();

			for (int i = 0, len = os.length; i < len; i++) {
				pic.setPicId(Integer.parseInt(picId));
				pic.setType(Integer.parseInt(os[i][0].toString()));
				pic.setTitle(os[i][1].toString());
				pic.setPicUrl(os[i][2].toString());
				pic.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				pic.setWxaccount(os[i][4].toString());
				pic.setKeyword(os[i][5] == null ? "" : os[i][5].toString());
				pic.setDesc(os[i][6] == null ? "" : os[i][6].toString());
			}
			return pic;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getPicById出错，picId:" + picId);
			return null;
		}
	}

	public boolean updatePic(Pic pic) {
		String sql = "UPDATE `tb_pic` SET `title`= ? ,`picUrl`= ? ,`type`= ?, `keyword` = ?, `desc` = ? where `picId` = ? ";
		Object[] o = { pic.getTitle(), pic.getPicUrl(), pic.getType(),
				pic.getKeyword(), pic.getDesc(), pic.getPicId() };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updatePic出错;picId:" + pic.getPicId() + ",title:"
							+ pic.getTitle() + ",type:" + pic.getType()
							+ ",keyword:" + pic.getKeyword() + ",desc:"
							+ pic.getDesc());
			return false;
		}
	}

	public void updateFiled(String picId, String filed) {
		String sql = "UPDATE `tb_pic` SET " + filed + " = " + filed
				+ " + 1 WHERE `picId` = ? ";
		Object[] o = { picId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "tb_pic updateFiled出错；picId:" + picId);
		}
	}

	public boolean addPic(Pic pic) {
		String sql = "INSERT INTO `tb_pic`(`title`, `picUrl`, `type`, `wxaccount`, `keyword`, `desc`) VALUES (?, ?, ?, ?, ?, ?)";
		Object[] o = { pic.getTitle(), pic.getPicUrl(), pic.getType(),
				pic.getWxaccount(), pic.getKeyword(), pic.getDesc() };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addPic出错;wxaccount:" + pic.getWxaccount() + ",title:"
							+ pic.getTitle() + ",type:" + pic.getType()
							+ ",keyword:" + pic.getKeyword() + ",desc;"
							+ pic.getDesc());
			return false;
		}
	}

	public boolean changeStatus(String picId, int status) {
		String sql = "UPDATE `tb_pic` SET `status` = ? WHERE `picId` = ? ";
		Object[] o = { status, picId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"deletePic出错picId:" + picId + ",status:" + status);
			return false;
		}
	}

	public List<Pic> searchByKeyword(String wxaccount, String keyword,
			Page page, int type) {
		String sql = "SELECT `picId`, `title`, `picUrl`, `visitPerson`, `keyword`, `desc` FROM `tb_pic` WHERE `wxaccount` = ? and `type` = ? and `title` like ? and `status` = 1 order by picId desc limit ? , ? ";
		Object[] o = { wxaccount, type, "%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Pic> pics = new ArrayList<Pic>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Pic pic = new Pic();
				pic.setPicId(Integer.parseInt(os[i][0].toString()));
				pic.setTitle(os[i][1].toString());
				pic.setPicUrl(os[i][2].toString());
				pic.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				pic.setKeyword(os[i][4] == null ? "" : os[i][4].toString());
				pic.setDesc(os[i][5] == null ? "" : os[i][5].toString());

				pics.add(pic);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"searchByKeyword出错;wxaccount:" + wxaccount + ",keyword:"
							+ keyword + ",type:" + type);
		}
		return pics;
	}

	public int getTotalRecord(String wxaccount, int type) {
		String sql = "select count(*) from `tb_pic` where wxaccount = ? and `type` = ? and `status` = 1 ";
		Object[] o = { wxaccount, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_pic中得到总记录数出错");
			return 0;
		}
	}
}