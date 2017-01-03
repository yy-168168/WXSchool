package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Dqorder;
import com.wxschool.entity.Page;

public class DqorderDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Dqorder> getOrders(String wxaccount, String company, Page page,
			String type, int status) {
		String sql;
		if (company.equals("default")) {
			sql = "SELECT `orderId`, `name`, `tel`, `company`, `address`, `info`, `locTime`, `sendTime`, `pubTime`, `status`, `userwx` FROM `tb_dqorder` WHERE `wxaccount`= ? and type = ? and `status` >= ? order by orderId desc limit ?, ? ";
		} else {
			sql = "SELECT `orderId`, `name`, `tel`, `company`, `address`, `info`, `locTime`, `sendTime`, `pubTime`, `status`, `userwx` FROM `tb_dqorder` WHERE `wxaccount`= ? and type = ? and company = '"
					+ company
					+ "' and `status` >= ? order by orderId desc limit ?, ? ";
		}

		Object[] o = { wxaccount, type, status,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Dqorder> orders = new ArrayList<Dqorder>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				Dqorder order = new Dqorder();

				order.setOrderId(Integer.parseInt(os[i][0].toString()));
				order.setName(os[i][1].toString());
				order.setTel(os[i][2].toString());
				order.setCompany(os[i][3].toString());
				order.setAddress(os[i][4].toString());
				order.setInfo(os[i][5] == null ? "" : os[i][5].toString());
				order.setLoc_time(os[i][6].toString());
				order.setSendTime(os[i][7].toString());
				order.setPubTime(os[i][8].toString().substring(0, 16));
				order.setStatus(Integer.parseInt(os[i][9].toString()));

				orders.add(order);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOrders出错；wxaccount:" + wxaccount + ",type:" + type
							+ ",status:" + status);
		}
		return orders;
	}

	public List<Dqorder> getOrdersByStatus(String wxaccount, String company,
			Page page, String type, int status) {
		String sql;
		if (company.equals("default")) {
			sql = "SELECT `orderId`, `name`, `tel`, `company`, `address`, `info`, `locTime`, `sendTime`, `pubTime`, `status`, `userwx` FROM `tb_dqorder` WHERE `wxaccount`= ? and type = ? and `status` = ? order by orderId desc limit ?, ? ";
		} else {
			sql = "SELECT `orderId`, `name`, `tel`, `company`, `address`, `info`, `locTime`, `sendTime`, `pubTime`, `status`, `userwx` FROM `tb_dqorder` WHERE `wxaccount`= ? and type = ? and company = '"
					+ company
					+ "' and `status` = ? order by orderId desc limit ?, ? ";
		}

		Object[] o = { wxaccount, type, status,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Dqorder> orders = new ArrayList<Dqorder>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				Dqorder order = new Dqorder();

				order.setOrderId(Integer.parseInt(os[i][0].toString()));
				order.setName(os[i][1].toString());
				order.setTel(os[i][2].toString());
				order.setCompany(os[i][3].toString());
				order.setAddress(os[i][4].toString());
				order.setInfo(os[i][5] == null ? "" : os[i][5].toString());
				order.setLoc_time(os[i][6].toString());
				order.setSendTime(os[i][7].toString());
				order.setPubTime(os[i][8].toString().substring(0, 16));
				order.setStatus(Integer.parseInt(os[i][9].toString()));

				orders.add(order);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOrdersByStatus出错；wxaccount:" + wxaccount + ",type:"
							+ type + ",status:" + status);
		}
		return orders;
	}

	public List<Dqorder> getOrdersByOperator(String wxaccount, String userwx,
			String company, Page page, String type) {
		String sql;
		if (company.equals("default")) {
			sql = "SELECT `orderId`, `name`, `tel`, `company`, `address`, `info`, `locTime`, `sendTime`, `pubTime`, `status`, `userwx` FROM `tb_dqorder` WHERE `wxaccount`= ? and `operator`= ? and type = ? and `status` = 1 order by orderId desc limit ?, ? ";
		} else {
			sql = "SELECT `orderId`, `name`, `tel`, `company`, `address`, `info`, `locTime`, `sendTime`, `pubTime`, `status`, `userwx` FROM `tb_dqorder` WHERE `wxaccount`= ? and `operator`= ? and type = ? and company = '"
					+ company
					+ "' and `status` = 1 order by orderId desc limit ?, ? ";
		}

		Object[] o = { wxaccount, userwx, type,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<Dqorder> orders = new ArrayList<Dqorder>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				Dqorder order = new Dqorder();

				order.setOrderId(Integer.parseInt(os[i][0].toString()));
				order.setName(os[i][1].toString());
				order.setTel(os[i][2].toString());
				order.setCompany(os[i][3].toString());
				order.setAddress(os[i][4].toString());
				order.setInfo(os[i][5] == null ? "" : os[i][5].toString());
				order.setLoc_time(os[i][6].toString());
				order.setSendTime(os[i][7].toString());
				order.setPubTime(os[i][8].toString().substring(0, 16));
				order.setStatus(Integer.parseInt(os[i][9].toString()));

				orders.add(order);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOrdersByOperator出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx + ",company:" + company);
		}
		return orders;
	}

	public Dqorder getLastOrder(String wxaccount, String userwx, String type) {
		String sql = "SELECT `name`, `tel`, `address` FROM `tb_dqorder` WHERE `wxaccount` = ? and `userwx` = ? and type = ? and `status` >= 0 order by `orderId` desc limit 1 ";
		Object[] o = { wxaccount, userwx, type };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Dqorder order = new Dqorder();

			for (int i = 0; i < os.length; i++) {
				order.setName(os[i][0].toString());
				order.setTel(os[i][1].toString());
				order.setAddress(os[i][2].toString());
			}
			return order;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getLastOrder出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public int getTotalRecord(String wxaccount, String company, String type,
			int status) {
		String sql;
		if (company.equals("default")) {
			sql = "select count(*) from tb_dqorder where wxaccount = ? and type = ? and status >= ? ";
		} else {
			sql = "select count(*) from tb_dqorder where wxaccount = ? and type = ? and company = '"
					+ company + "' and status >= ? ";
		}

		Object[] o = { wxaccount, type, status };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "从tb_dqorder中得到总记录数出错");
			return 0;
		}
	}

	public int getTotalRecordByStatus(String wxaccount, String company,
			String type, int status) {
		String sql;
		if (company.equals("default")) {
			sql = "select count(*) from tb_dqorder where wxaccount = ? and type = ? and status = ? ";
		} else {
			sql = "select count(*) from tb_dqorder where wxaccount = ? and type = ? and company = '"
					+ company + "' and status = ? ";
		}

		Object[] o = { wxaccount, type, status };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_dqorder中得到总记录数出错getTotalRecordByStatus");
			return 0;
		}
	}

	public int getTotalRecordByOperator(String wxaccount, String userwx,
			String company, String type) {
		String sql;
		if (company.equals("default")) {
			sql = "select count(*) from tb_dqorder where wxaccount = ? and operator = ? and type = ? and status = 1 ";
		} else {
			sql = "select count(*) from tb_dqorder where wxaccount = ? and operator = ? and type = ? and company = '"
					+ company + "' and status = 1 ";
		}

		Object[] o = { wxaccount, userwx, type };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_dqorder中得到总记录数出错getTotalRecordByOperator");
			return 0;
		}
	}

	public boolean addOrder(Dqorder express) {
		String sql = "INSERT INTO `tb_dqorder`(`name`, `tel`, `company`, `address`, `locTime`, `sendTime`, `info`, `type`, `userwx`, `wxaccount`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] o = { express.getName(), express.getTel(),
				express.getCompany(), express.getAddress(),
				express.getLoc_time(), express.getSendTime(),
				express.getInfo(), express.getType(), express.getUserwx(),
				express.getWxaccount() };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addOrder出错；wxaccount:" + express.getWxaccount()
							+ ",userwx:" + express.getUserwx() + ",name:"
							+ express.getName() + ",tel:" + express.getTel()
							+ ",company:" + express.getCompany() + ",address:"
							+ express.getAddress() + ",info:"
							+ express.getInfo() + ",loc_time:"
							+ express.getLoc_time() + ",sendTime:"
							+ express.getSendTime() + ",type:"
							+ express.getType());
		}
		return false;
	}

	public boolean pickUp(String orderId, String operator) {
		String sql = "UPDATE `tb_dqorder` SET `operator` = ?, `pickupTime` = now(), `status`= 1 WHERE `orderId`= ? ";
		Object[] o = { operator, orderId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"pickUp出错；orderId:" + orderId + ",operator:" + operator);
			return false;
		}
	}

	public boolean changeStatus(String orderId, int status) {
		String sql = "UPDATE `tb_dqorder` SET `status`= ? WHERE `orderId`= ? ";
		Object[] o = { status, orderId };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"changeStatus出错；orderId:" + orderId + ",status:" + status);
			return false;
		}
	}
}
