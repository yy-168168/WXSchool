package com.wxschool.dao;

import java.util.*;

import javax.servlet.jsp.jstl.sql.*;

import com.wxschool.entity.*;

public class FoodDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Res> getRessByArea(String wxaccount, String area) {
		String sql = "SELECT `resId`, `picPath`, `resName`, `address`, `locUrl`, `tel1`, `visitPerson` "
				+ "FROM `tb_res` where `wxaccount` = ? and `area` = ? and `status` = 1 order by `rank` desc , rand() ";
		Object[] o = { wxaccount, area };
		List<Res> ress = new ArrayList<Res>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Res res = new Res();
				res.setResId((Integer) os[i][0]);
				res.setPicPath(os[i][1].toString());
				res.setResName(os[i][2].toString());
				res.setAddress(os[i][3].toString());
				res.setLocUrl(os[i][4] == null ? "" : os[i][4].toString());
				res.setTel(os[i][5].toString());
				res.setVisitPerson(Integer.parseInt(os[i][6].toString()));

				ress.add(res);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getRess出错；wxaccount:" + wxaccount);
		}
		return ress;
	}

	public List<Res> getRessByPage(String wxaccount, Page page) {
		String sql = "SELECT `resId`, `resName`, `address`, `tel1`, `visitPerson`, notice , rank , area "
				+ "FROM `tb_res` where `wxaccount` = ? and `status` = 1 order by `resId` desc limit ?, ? ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Res> ress = new ArrayList<Res>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Res res = new Res();

				res.setResId(Integer.parseInt(os[i][0].toString()));
				res.setResName(os[i][1].toString());
				res.setAddress(os[i][2].toString());
				res.setTel(os[i][3].toString());
				res.setVisitPerson(Integer.parseInt(os[i][4].toString()));
				res.setNotice(os[i][5].toString());
				res.setSort(Integer.parseInt(os[i][6].toString()));
				res.setArea(os[i][7].toString());

				ress.add(res);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getRessByPage出错；wxaccount:" + wxaccount);
		}
		return ress;
	}

	public List<Res> getRessByPage_merchant(String merchantId, Page page) {
		String sql = "SELECT `resId`, `resName`, `address`, `tel1`, `visitPerson`, notice , rank , area "
				+ "FROM `tb_res` where `merchantId` = ? and `status` = 1 order by `resId` desc limit ?, ? ";
		Object[] o = { merchantId,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Res> ress = new ArrayList<Res>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Res res = new Res();

				res.setResId(Integer.parseInt(os[i][0].toString()));
				res.setResName(os[i][1].toString());
				res.setAddress(os[i][2].toString());
				res.setTel(os[i][3].toString());
				res.setVisitPerson(Integer.parseInt(os[i][4].toString()));
				res.setNotice(os[i][5].toString());
				res.setSort(Integer.parseInt(os[i][6].toString()));
				res.setArea(os[i][7].toString());

				ress.add(res);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getRessByPage_merchant出错；merchantId:" + merchantId);
		}
		return ress;
	}

	public List<Food> getFoodsByPage(String resId, Page page) {
		String sql = "SELECT `foodId`, `foodName`, `price`, `type`, `sort` FROM `tb_food` "
				+ "WHERE `resId` = ? and `status` = 1 order by `foodId` desc limit ?, ? ";
		Object[] o = { resId, (page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Food> foods = new ArrayList<Food>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Food food = new Food();

				food.setFoodId(Integer.parseInt(os[i][0].toString()));
				food.setFoodName(os[i][1].toString());
				food.setPrice(os[i][2].toString());
				food.setType(Integer.parseInt(os[i][3].toString()));
				food.setSort(Integer.parseInt(os[i][4].toString()));

				foods.add(food);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getFoodsByPage出错；resId:" + resId);
		}
		return foods;
	}

	public Res getResById(String resId) {
		String sql = "SELECT `picPath`, `resName`, `notice`, `tel1`, `visitPerson`, `wxaccount`, "
				+ "`address`, `rank`,  locUrl, `area` FROM `tb_res` WHERE `resId` = ? ";
		Object[] o = { resId };
		Res res = new Res();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			res.setResId(Integer.parseInt(resId));
			res.setPicPath(os[0][0].toString());
			res.setResName(os[0][1].toString());
			res.setNotice(os[0][2].toString());
			res.setTel(os[0][3].toString());
			res.setVisitPerson(Integer.parseInt(os[0][4].toString()));
			res.setWxaccount(os[0][5].toString());
			res.setAddress(os[0][6].toString());
			res.setSort(Integer.parseInt(os[0][7].toString()));
			res.setLocUrl(os[0][8] == null ? "" : os[0][8].toString());
			res.setArea(os[0][9].toString());

		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getResById出错；resId:" + resId);
		}
		return res;
	}

	public List<Food> getFoodsById(String resId) {
		String sql = "SELECT  `foodId`, `foodName`, `price`, `locUrl`  FROM `tb_food` WHERE `resId` = ? and status = 1 order by `sort` desc , `price` ASC ";
		Object[] o = { resId };
		List<Food> foods = new ArrayList<Food>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Food food = new Food();
				food.setFoodId(Integer.parseInt(os[i][0].toString()));
				food.setFoodName(os[i][1].toString());
				food.setPrice(os[i][2].toString());
				food.setLocUrl(os[i][3] == null ? "" : os[i][3].toString());

				foods.add(food);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getFoodsById出错；resId:" + resId);
		}
		return foods;
	}

	public Food getFoodById(String foodId) {
		String sql = "SELECT `foodName`, `price`, `type`, `sort`, `locUrl` FROM `tb_food` WHERE `foodId` = ? ";
		Object[] o = { foodId };
		Food food = new Food();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			food.setFoodId(Integer.parseInt(foodId));
			food.setFoodName(os[0][0].toString());
			food.setPrice(os[0][1].toString());
			food.setType(Integer.parseInt(os[0][2].toString()));
			food.setSort(Integer.parseInt(os[0][3].toString()));
			food.setLocUrl(os[0][4] == null ? "" : os[0][4].toString());

		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getFoodById出错；foodId:" + foodId);
		}
		return food;
	}

	public void updateVisitPerson(String resId) {
		String sql = "UPDATE `tb_res` SET `visitPerson`= `visitPerson` + 1  WHERE `resId` = ? ";
		Object[] o = { resId };
		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "updateVisitPerson出错；resId:" + resId);
		}
	}

	public int getTotalRecordofResByWxaccount(String wxaccount) {
		String sql = "select count(*) from `tb_res` where wxaccount = ? and `status` = 1 ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_res中得到总记录数出错; wxaccount:" + wxaccount);
			return 0;
		}
	}

	public int getTotalRecordofResByMerchantId(String merchantId) {
		String sql = "select count(*) from `tb_res` where merchantId = ? and `status` = 1 ";
		Object[] o = { merchantId };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_res中得到总记录数出错; merchantId:" + merchantId);
			return 0;
		}
	}

	public int getTotalRecordofFood(String resId) {
		String sql = "select count(*) from `tb_food` where `resId` = ? and status = 1 ";
		Object[] o = { resId };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_food中得到总记录数出错; resId:" + resId);
			return 0;
		}
	}

	public boolean updateRes(Res res) {
		String sql = "UPDATE `tb_res` SET `picPath`= ? ,`resName`= ? ,`address`= ? ,`notice`= ? ,`rank`= ? ,`locUrl`= ? ,`tel1`= ? ,`area`= ? WHERE `resId`= ? ";
		Object[] o = { res.getPicPath(), res.getResName(), res.getAddress(),
				res.getNotice(), res.getSort(), res.getLocUrl(), res.getTel(),
				res.getArea(), res.getResId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateRes出错；wxaccount:" + res.getWxaccount() + ";resId:"
							+ res.getResId() + ";resName:" + res.getResName()
							+ ";address:" + res.getAddress() + ";picUrl:"
							+ res.getPicPath() + ";locUrl:" + res.getLocUrl()
							+ ";notice:" + res.getNotice() + ";tel:"
							+ res.getTel() + ";sort:" + res.getSort()
							+ ",area:" + res.getArea());
			return false;
		}
	}

	public boolean updateRes_merchant(Res res) {
		String sql = "UPDATE `tb_res` SET `picPath`= ? ,`resName`= ? ,`address`= ? ,`notice`= ? ,`locUrl`= ? ,`tel1`= ? ,`area`= ? WHERE `resId`= ? ";
		Object[] o = { res.getPicPath(), res.getResName(), res.getAddress(),
				res.getNotice(), res.getLocUrl(), res.getTel(), res.getArea(),
				res.getResId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateRes出错；wxaccount:" + res.getWxaccount() + ";resId:"
							+ res.getResId() + ";resName:" + res.getResName()
							+ ";address:" + res.getAddress() + ";picUrl:"
							+ res.getPicPath() + ";locUrl:" + res.getLocUrl()
							+ ";notice:" + res.getNotice() + ";tel:"
							+ res.getTel() + ",area:" + res.getArea());
			return false;
		}
	}

	public boolean addRes(Res res) {
		String sql = "INSERT INTO `tb_res`(`picPath`, `resName`, `address`, `notice`, `rank`, `locUrl`, `tel1`, `area`, `wxaccount`, `merchantId`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] o = { res.getPicPath(), res.getResName(), res.getAddress(),
				res.getNotice(), res.getSort(), res.getLocUrl(), res.getTel(),
				res.getArea(), res.getWxaccount(), res.getMerchantId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addRes出错；wxaccount:" + res.getWxaccount() + ";merchantId:"
							+ res.getMerchantId() + ";resName:"
							+ res.getResName() + ";address:" + res.getAddress()
							+ ";picUrl:" + res.getPicPath() + ";locUrl:"
							+ res.getLocUrl() + ";notice:" + res.getNotice()
							+ ";tel:" + res.getTel() + ";sort:" + res.getSort()
							+ ",area:" + res.getArea());
			return false;
		}
	}

	public boolean updateFood(Food food) {
		String sql = "UPDATE `tb_food` SET `foodName` = ? ,`price` = ? ,`type` = ? ,`locUrl` = ? ,`sort` = ? WHERE `foodId` = ? ";
		Object[] o = { food.getFoodName(), food.getPrice(), food.getType(),
				food.getLocUrl(), food.getSort(), food.getFoodId() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateFood出错；foodId:" + food.getFoodId() + ",foodName:"
							+ food.getFoodName() + ",price:" + food.getPrice()
							+ ",type:" + food.getType());
			return false;
		}
	}

	public boolean addFood(Food food, String resId) {
		String sql = "INSERT INTO `tb_food`(`resId`, `foodName`, `price`, `locUrl`, `type`, `sort`) VALUES (?, ?, ?, ?, ?, ?)";
		Object[] o = { resId, food.getFoodName(), food.getPrice(),
				food.getLocUrl(), food.getType(), food.getSort() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addFood出错；resId:" + resId + ",foodName:"
							+ food.getFoodName() + ",price:" + food.getPrice()
							+ ",type:" + food.getType());
			return false;
		}
	}

	public boolean deleteRes(String resId) {
		String sql = "UPDATE `tb_res` SET `status`= -1  WHERE `resId`= ? ";
		Object[] o = { resId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "deleteRes出错；resId:" + resId);
			return false;
		}
	}

	public boolean deleteFood(String foodId) {
		String sql = "UPDATE `tb_food` SET `status`= -1  WHERE `foodId`= ? ";
		Object[] o = { foodId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "deleteFood出错；foodId:" + foodId);
			return false;
		}
	}

	/*
	 * public List<Order> getTempOrders(String wxaccount, String userwx) {
	 * String sql =
	 * "SELECT o.`temporderId`, o.`shopId`, r.`resName`, o.`goodsId`, f.`foodName`, f.`price`, o.`amount` "
	 * +
	 * "FROM (select * from `tb_temporder` where `wxaccount` = ? and `userwx` = ?) as o "
	 * + "inner join `tb_res` r on o.`shopId` = r.`resId` " +
	 * "inner join `tb_food` f on  o.`goodsId` = f.`foodId` "; Object[] o = {
	 * wxaccount, userwx }; try { Result result = connDB.query(sql, o);
	 * Object[][] os = result.getRowsByIndex(); List<Order> tempOrders = new
	 * ArrayList<Order>();
	 * 
	 * Order tempOrder = null; for (int i = 0; i < os.length; i++) { tempOrder =
	 * new Order(); tempOrder.setOrderId(Integer.parseInt(os[i][0].toString()));
	 * tempOrder.setShopId(Integer.parseInt(os[i][1].toString()));
	 * tempOrder.setShopName(os[i][2].toString());
	 * tempOrder.setGoodsId(Integer.parseInt(os[i][3].toString()));
	 * tempOrder.setGoodsName(os[i][4].toString());
	 * tempOrder.setPrice(Double.parseDouble(os[i][5].toString()));
	 * tempOrder.setAmount(Integer.parseInt(os[i][6].toString()));
	 * 
	 * tempOrders.add(tempOrder); } return tempOrders; } catch (Exception e) {
	 * log.addExpLog(e, "getTempOrder出错；wxaccount:" + wxaccount + ",userwx:" +
	 * userwx + ""); return null; } }
	 * 
	 * public int getTempOrderSize(String wxaccount, String userwx) { String sql
	 * =
	 * "SELECT SUM(`amount`)  FROM `tb_temporder` WHERE `wxaccount` = ? and `userwx` = ? "
	 * ; Object[] o = { wxaccount, userwx }; try { Result result =
	 * connDB.query(sql, o); return
	 * Integer.parseInt(result.getRowsByIndex()[0][0].toString()); } catch
	 * (NullPointerException e) { return 0; } catch (Exception e) {
	 * log.addExpLog(e, "getTempOrderSize出错；wxaccount:" + wxaccount + ",userwx:"
	 * + userwx); return 0; } }
	 * 
	 * public boolean addTempOrder(String wxaccount, String userwx, String
	 * shopId, String goodsId) { String sql =
	 * "INSERT INTO `tb_temporder`(`shopId`, `goodsId`, `wxaccount`, `userwx`) "
	 * + "VALUES (? ,? ,? ,? ) "; Object[] o = { shopId, goodsId, wxaccount,
	 * userwx }; try { int r = connDB.update(sql, o); return r == 1; } catch
	 * (Exception e) { log.addExpLog(e, "addTempOrder出错；wxaccount:" + wxaccount
	 * + ",userwx:" + userwx + ",shopId:" + shopId + ",goodsId:" + goodsId);
	 * return false; } }
	 * 
	 * public int hasOrder(String wxaccount, String userwx, String shopId,
	 * String goodsId) { String sql =
	 * "SELECT `temporderId` FROM `tb_temporder` WHERE `wxaccount` = ? and `userwx` = ? and `shopId` = ? and `goodsId` = ? "
	 * ; Object[] o = { wxaccount, userwx, shopId, goodsId }; try { Result
	 * result = connDB.query(sql, o); return result.getRowCount(); } catch
	 * (Exception e) { log.addExpLog(e, "hasOrder出错；wxaccount:" + wxaccount +
	 * ",userwx:" + userwx + ",shopId:" + shopId + ",goodsId:" + goodsId);
	 * return -1; } }
	 * 
	 * public boolean updateOrderAmount(String tempOrderId, int num) { String
	 * sql =
	 * "UPDATE `tb_temporder` SET `amount` = `amount` + ? WHERE `temporderId` = ? "
	 * ; Object[] o = { num, tempOrderId }; try { int r = connDB.update(sql, o);
	 * return r == 1; } catch (Exception e) { log.addExpLog(e,
	 * "updateOrderAmount出错；tempOrderId:" + tempOrderId + ",num:" + num); return
	 * false; } }
	 * 
	 * public void deleteTempOrder(String tempOrderId) { String sql =
	 * "DELETE FROM `tb_temporder` WHERE `temporderId` = ? "; Object[] o = {
	 * tempOrderId }; try { connDB.update(sql, o); } catch (Exception e) {
	 * log.addExpLog(e, "deleteTempOrder出错；tempOrderId:" + tempOrderId); } }
	 */
}
