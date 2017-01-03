package com.wxschool.dao;

import java.util.*;
import javax.servlet.jsp.jstl.sql.Result;
import com.wxschool.entity.*;

public class BnsDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public int isExist(String wxaccount, String userwx) {
		String sql = "SELECT `menberId` FROM `tb_menber` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 ";
		Object[] o = { wxaccount, userwx };
		try {
			Result result = connDB.query(sql, o);
			return result.getRowCount();
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"isExist出错；wxaccount:" + wxaccount + ",userwx:" + userwx);
			return -1;
		}
	}

	public Menber getMenber(String wxaccount, String userwx) {
		String sql = "SELECT `menberNum`, `menberName`, `tel` FROM `tb_menber` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 ";
		Object[] o = { wxaccount, userwx };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Menber mb = new Menber();

			for (int i = 0; i < os.length; i++) {
				mb.setMenberNum(Integer.parseInt(os[i][0].toString()));
				mb.setMenberName(os[i][1].toString());
				mb.setTel(os[i][2].toString());
			}
			return mb;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getMenber出错；wxaccount:" + wxaccount + ",userwx:" + userwx);
			return null;
		}
	}

	public boolean addMenber(Menber mb) {
		int num = getMaxMenberNum();
		if (num == -1) {
			return false;
		}
		String sql = "INSERT INTO `tb_menber`(`menberNum`, `menberName`, `tel`, `wxaccount`, `userwx`) VALUES (?, ?, ?, ?, ?) ";
		Object[] o = { num + 1, mb.getMenberName(), mb.getTel(),
				mb.getWxaccount(), mb.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addMenber出错；wxaccount:" + mb.getWxaccount() + ",userwx:"
							+ mb.getUserwx() + ",menberName:"
							+ mb.getMenberName() + ",tel:" + mb.getTel()
							+ ",menberNum:" + num);
			return false;
		}
	}

	public int getMaxMenberNum() {
		String sql = "SELECT MAX(`menberNum`) FROM  `tb_menber` ";
		try {
			Result result = connDB.query(sql, null);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getMaxMenberNum出错；");
			return -1;
		}
	}

	public List<Merchant> getMerchants(String wxaccount) {
		String sql = "SELECT `merchantId`, `name`, `desc`, `picUrl`, `locUrl` FROM `tb_merchant` WHERE `wxaccount` = ? and `status` = 1 order by `rank` asc ";
		Object[] o = { wxaccount };
		List<Merchant> merchants = new ArrayList<Merchant>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Merchant m = new Merchant();
				m.setMerchantId(Integer.parseInt(os[i][0].toString()));
				m.setName(os[i][1].toString());
				m.setDesc(os[i][2].toString());
				m.setPicUrl(os[i][3].toString());
				m.setLocUrl(os[i][4].toString());

				merchants.add(m);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getMerchants出错；wxaccount:" + wxaccount);
		}
		return merchants;
	}

	public Merchant getMerchant(String wxaccount, String merchantId) {
		String sql = "SELECT `merchantId`, `name`, `desc`, `picUrl`, `locUrl`, `startTime`, `endTime` FROM `tb_merchant` WHERE `wxaccount` = ? and `merchantId` = ? and `status` = 1 ";
		Object[] o = { wxaccount, merchantId };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Merchant merchant = new Merchant();

			for (int i = 0, len = os.length; i < len; i++) {
				merchant.setMerchantId(Integer.parseInt(os[i][0].toString()));
				merchant.setName(os[i][1].toString());
				merchant.setDesc(os[i][2].toString());
				merchant.setPicUrl(os[i][3].toString());
				merchant.setLocUrl(os[i][4].toString());
				merchant.setStartTime(os[i][5].toString().substring(0, 5));
				merchant.setEndTime(os[i][6].toString().substring(0, 5));
			}

			return merchant;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getMerchant出错；wxaccount:" + wxaccount + ";merchantId:"
							+ merchantId);
		}
		return null;
	}

	public void updateVisitPerson_goods(String gsId) {
		String sql = "UPDATE `tb_goods` SET `visitPerson` = `visitPerson` + 1 WHERE `goodsId`= ? ";
		Object[] o = { gsId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"updateVisitPerson_goods出错;goodsId:" + gsId);
		}
	}

	public void updateVisitPerson_merchant(String wxaccount, String merchantId) {
		String sql = "UPDATE `tb_merchant` SET `visitPerson` = `visitPerson` + 1 WHERE `wxaccount` = ? and `merchantId`= ? ";
		Object[] o = { wxaccount, merchantId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateVisitPerson_merchant出错;wxaccount:" + wxaccount
							+ ",merchantId:" + merchantId);
		}
	}

	public List<Goods> getGoodses(String wxaccount, Page page, String type) {
		String sql = "SELECT `goodsId`, `simDesc`, `cate`, `visitPerson`, `pubTime`, `uptTime` ,"
				+ " `price`, `old` FROM `tb_goods` WHERE `wxaccount` = ? and "
				+ " type = ? and `status` = 1 order by `goodsId` desc limit ? , ? ";
		Object[] o = { wxaccount, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Goods> goodses = new ArrayList<Goods>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Goods goods = new Goods();
				goods.setGoodsId(Integer.parseInt(os[i][0].toString()));
				goods.setSimDesc(os[i][1].toString());
				goods.setCate(Integer.parseInt(os[i][2].toString()));
				goods.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				goods.setPubTime(os[i][4].toString().substring(0, 16));
				goods.setUptTime(os[i][5].toString().substring(0, 16));
				goods.setPrice(Integer.parseInt(os[i][6].toString()));
				goods.setOld(Integer.parseInt(os[i][7].toString()));
				goods.setType(Integer.parseInt(type));

				goodses.add(goods);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getGoodses出错；wxaccount:" + wxaccount);
		}
		return goodses;
	}

	public List<Goods> getGoodsesByVp(String wxaccount, Page page, String type) {
		String sql = "SELECT `goodsId`, `simDesc`, `picUrl`, `visitPerson`, `price`, `old` FROM `tb_goods` WHERE `wxaccount` = ? and "
				+ " type = ? and `status` = 1 order by `pubTime` desc , `visitPerson` desc limit ? , ? ";
		Object[] o = { wxaccount, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Goods> goodses = new ArrayList<Goods>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Goods goods = new Goods();
				goods.setGoodsId(Integer.parseInt(os[i][0].toString()));
				goods.setSimDesc(os[i][1].toString());
				goods.setPicUrl(os[i][2].toString());
				goods.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				goods.setPrice(Integer.parseInt(os[i][4].toString()));
				goods.setOld(Integer.parseInt(os[i][5].toString()));

				goodses.add(goods);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getGoodsesByVp出错；wxaccount:" + wxaccount);
		}
		return goodses;
	}

	public List<Goods> getGoodsesByCate(String wxaccount, String cate,
			Page page, String type) {
		String sql = "SELECT `goodsId`, `simDesc`, `picUrl`, `visitPerson`, `price`, `old` FROM `tb_goods` WHERE `wxaccount` = ? and "
				+ "`cate` = ? and type = ?  and `status` = 1 order by `pubTime` desc , `visitPerson` desc limit ? , ? ";
		Object[] o = { wxaccount, cate, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Goods> goodses = new ArrayList<Goods>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Goods goods = new Goods();
				goods.setGoodsId(Integer.parseInt(os[i][0].toString()));
				goods.setSimDesc(os[i][1].toString());
				goods.setPicUrl(os[i][2].toString());
				goods.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				goods.setPrice(Integer.parseInt(os[i][4].toString()));
				goods.setOld(Integer.parseInt(os[i][5].toString()));

				goodses.add(goods);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getGoodsesByCate出错；wxaccount:" + wxaccount + ",cate:"
							+ cate);
		}
		return goodses;
	}

	public List<Goods> getGoodsesByUserwx(String userwx, Page page, String type) {
		String sql = "SELECT `goodsId`, `simDesc`, `cate`, `visitPerson`, `pubTime`, `uptTime`, `status`, `price`, `old`  FROM `tb_goods` "
				+ " WHERE `uid` = ? and type = ? order by `goodsId` desc limit ? , ? ";
		Object[] o = { userwx, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Goods> goodses = new ArrayList<Goods>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Goods goods = new Goods();
				goods.setGoodsId(Integer.parseInt(os[i][0].toString()));
				goods.setSimDesc(os[i][1].toString());
				goods.setCate(Integer.parseInt(os[i][2].toString()));
				goods.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				goods.setPubTime(os[i][4].toString().substring(0, 16));
				goods.setUptTime(os[i][5].toString().substring(0, 16));
				goods.setStatus(Integer.parseInt(os[i][6].toString()));
				goods.setPrice(Integer.parseInt(os[i][7].toString()));
				goods.setOld(Integer.parseInt(os[i][8].toString()));
				goods.setType(Integer.parseInt(type));

				goodses.add(goods);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getGoodsesByUserwx出错；userwx:" + userwx);
		}
		return goodses;
	}

	public List<Goods> getGoodsesByKeyword(String wxaccount, String keyword,
			String type, Page page) {
		String sql = "SELECT `goodsId`, `simDesc`, `picUrl`, `visitPerson`, `price`, `old` FROM `tb_goods` WHERE `wxaccount` = ? and "
				+ " type = ? and `simDesc` like ? and `status` = 1 order by `pubTime` desc , `visitPerson` desc limit ? , ? ";
		Object[] o = { wxaccount, type, "%" + keyword + "%",
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Goods> goodses = new ArrayList<Goods>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Goods goods = new Goods();
				goods.setGoodsId(Integer.parseInt(os[i][0].toString()));
				goods.setSimDesc(os[i][1].toString());
				goods.setPicUrl(os[i][2].toString());
				goods.setVisitPerson(Integer.parseInt(os[i][3].toString()));
				goods.setPrice(Integer.parseInt(os[i][4].toString()));
				goods.setOld(Integer.parseInt(os[i][5].toString()));

				goodses.add(goods);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getGoodsesByKeyword出错；wxaccount:" + wxaccount + ",type:"
							+ type + ",keyword:" + keyword);
		}
		return goodses;
	}

	public int getTotalRecord(String wxaccount, String type) {
		String sql = "select count(*) from `tb_goods` where wxaccount = ? and type = ? and `status` = 1 ";
		Object[] o = { wxaccount, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_goods中得到总记录数出错；wxaccount:" + wxaccount);
			return 0;
		}
	}

	public int getTotalRecordByCate(String wxaccount, String cate, String type) {
		String sql = "select count(*) from `tb_goods` where wxaccount = ? and cate = ? and type = ? and `status` = 1 ";
		Object[] o = { wxaccount, cate, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"从tb_goods中得到总记录数出错；wxaccount:" + wxaccount + ",cate:"
							+ cate);
			return 0;
		}
	}

	public int getTotalRecordByUserwx(String userwx, String type) {
		String sql = "select count(*) from `tb_goods` where uid = ? and type = ? ";
		Object[] o = { userwx, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getTotalRecordByUserwx出错；userwx:" + userwx + ",type="
							+ type);
			return 0;
		}
	}

	public int getUsedNumOfWxin(String wxin, String type) {
		String sql = "select count(*) from `tb_goods` where wxin = ? and type = ? ";
		Object[] o = { wxin, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getUsedNumOfWxin出错；wxin:" + wxin + ",type:" + type);
			return 0;
		}
	}

	public int getUsedNumOfTel(String tel, String type) {
		String sql = "select count(*) from `tb_goods` where tel = ? and type = ? ";
		Object[] o = { tel, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getUsedNumOfTel出错；tel:" + tel + ",type:" + type);
			return 0;
		}
	}

	public Goods getGoods(String gsId) {
		String sql = "SELECT `simDesc`, `dtlDesc`, `picUrl`, `tel`, `wxin`, `visitPerson`, `cate`, `price`, `old`, `type` FROM `tb_goods` WHERE `goodsId` = ? ";
		Object[] o = { gsId };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Goods goods = new Goods();

			for (int i = 0; i < os.length; i++) {
				goods.setSimDesc(os[i][0].toString());
				goods.setDtlDesc(os[i][1].toString());
				goods.setPicUrl(os[i][2].toString());
				goods.setTel(os[i][3].toString());
				goods.setWxin(os[i][4].toString());
				goods.setVisitPerson(Integer.parseInt(os[i][5].toString()));
				goods.setCate(Integer.parseInt(os[i][6].toString()));
				goods.setGoodsId(Integer.parseInt(gsId));
				goods.setPrice(Integer.parseInt(os[i][7].toString()));
				goods.setOld(Integer.parseInt(os[i][8].toString()));
				goods.setType(Integer.parseInt(os[i][9].toString()));
			}
			return goods;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getGoods出错；goodsId:" + gsId);
			return null;
		}
	}

	public boolean deleteGs(String gsId, int status) {
		String sql = "UPDATE `tb_goods` SET `status`= ?  WHERE `goodsId`= ? ";
		Object[] o = { status, gsId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"deleteGs出错；gsId:" + gsId + ",status:" + status);
			return false;
		}
	}

	public boolean updateGoods(Goods goods) {
		String sql = "UPDATE `tb_goods` SET `simDesc`= ? ,`dtlDesc`= ? ,`picUrl`= ? ,`cate`= ? ,`tel`= ? ,`wxin`= ?, `price` = ?, `old` = ?  WHERE `goodsId` = ? ";
		Object[] o = { goods.getSimDesc(), goods.getDtlDesc(),
				goods.getPicUrl(), goods.getCate(), goods.getTel(),
				goods.getWxin(), goods.getPrice(), goods.getOld(),
				goods.getGoodsId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateGoods出错；goodsId:" + goods.getGoodsId() + ",simDesc:"
							+ goods.getSimDesc() + ",dtlDesc:"
							+ goods.getDtlDesc() + ",picUrl:"
							+ goods.getPicUrl() + ",cate:" + goods.getCate()
							+ ",tel:" + goods.getTel() + ",wxin:"
							+ goods.getWxin() + ",price:" + goods.getPrice()
							+ ",old:" + goods.getOld());
			return false;
		}
	}

	public boolean addGoods(Goods goods) {
		String sql = "INSERT INTO `tb_goods`(`uid`, `simDesc`, `dtlDesc`, `picUrl`, `cate`, `type`, `tel`, `wxin`, `price`, `old`, `pubTime`, `wxaccount`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
		Object[] o = { goods.getUid(), goods.getSimDesc(), goods.getDtlDesc(),
				goods.getPicUrl(), goods.getCate(), goods.getType(),
				goods.getTel(), goods.getWxin(), goods.getPrice(),
				goods.getOld(), goods.getWxaccount() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addGoods出错；wxaccount:" + goods.getWxaccount()
							+ ",simDesc:" + goods.getSimDesc() + ",dtlDesc:"
							+ goods.getDtlDesc() + ",picUrl:"
							+ goods.getPicUrl() + ",cate:" + goods.getCate()
							+ ",type:" + goods.getType() + ",tel:"
							+ goods.getTel() + ",wxin:" + goods.getWxin()
							+ ",price:" + goods.getPrice() + ",old:"
							+ goods.getOld());
			return false;
		}
	}
}
