package com.wxschool.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.servlet.jsp.jstl.sql.Result;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wxschool.entity.Page;
import com.wxschool.entity.WdOrder;
import com.wxschool.entity.WdUser;
public class WdOrderDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<WdOrder> getOrderByPage(String uid, Page page) {
		String sql = "SELECT `orderId`, `orderNum`, `itemId`, `buyer`, `itemName`, `amount`, `unitPrice`, `totalPrice`, `pubTime` FROM `tb_wdorder` "
				+ "WHERE `uid` = ? and `status` = 1 order by orderId desc limit ? , ? ";
		Object[] o = { uid, (page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<WdOrder> orders = new ArrayList<WdOrder>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				WdOrder order = new WdOrder();
				order.setOrderId(Integer.parseInt(os[i][0].toString()));
				order.setOrderNum(os[i][1].toString());
				order.setItemId(os[i][2].toString());
				order.setBuyer(os[i][3].toString());
				order.setItemName(os[i][4].toString());
				order.setAmount(os[i][5].toString());
				order.setUnitPrice(os[i][6].toString());
				order.setTotalPrice(os[i][7].toString());
				order.setPubTime(os[i][8].toString().substring(0, 16));

				orders.add(order);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getOrderByPage出错;uid:" + uid);
		}
		return orders;
	}

	public List<WdOrder> getOrderInDb(String uid, String orderNum) {
		String sql = "SELECT `buyer`, `itemName`, `amount`, `unitPrice`, `totalPrice`, `pubTime` FROM `tb_wdorder` "
				+ "WHERE `uid` = ? and `orderNum` = ?  and `status` = 1 ";
		Object[] o = { uid, orderNum };
		List<WdOrder> orders = new ArrayList<WdOrder>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				WdOrder order = new WdOrder();
				order.setBuyer(os[i][0].toString());
				order.setItemName(os[i][1].toString());
				order.setAmount(os[i][2].toString());
				order.setUnitPrice(os[i][3].toString());
				order.setTotalPrice(os[i][4].toString());
				order.setPubTime(os[i][5].toString().substring(0, 16));
				order.setOrderNum(orderNum);

				orders.add(order);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getOrderInDb出错；uid:" + uid + ",orderNum:" + orderNum);
			return null;
		}
		return orders;
	}

	public List<WdOrder> getOrderByDate(String uid, String month, String day,
			Page page) {
		String sql = "";
		if (month.equals("0")) {
			sql = "SELECT `orderNum`, `buyer`, `itemName`, `amount`, `unitPrice`, `totalPrice`, `pubTime` FROM `tb_wdorder` where uid = ? "
					+ "and `status` = 1 order by orderId desc limit ? , ? ";
		} else if (day.equals("0")) {
			sql = "SELECT `orderNum`, `buyer`, `itemName`, `amount`, `unitPrice`, `totalPrice`, `pubTime` FROM `tb_wdorder` where uid = ? "
					+ "and `status` = 1 and month(`pubTime`) = '"
					+ month
					+ "' order by orderId desc limit ? , ? ";
		} else {
			String date = Calendar.getInstance().get(Calendar.YEAR) + "-"
					+ month + "-" + day;
			sql = "SELECT `orderNum`, `buyer`, `itemName`, `amount`, `unitPrice`, `totalPrice`, `pubTime` FROM `tb_wdorder` where uid = ? "
					+ "and `status` = 1 and date(`pubTime`) = '"
					+ date
					+ "' order by orderId desc limit ? , ? ";
		}
		Object[] o = { uid, (page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<WdOrder> orders = new ArrayList<WdOrder>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				WdOrder order = new WdOrder();
				order.setOrderNum(os[i][0].toString());
				order.setBuyer(os[i][1].toString());
				order.setItemName(os[i][2].toString());
				order.setAmount(os[i][3].toString());
				order.setUnitPrice(os[i][4].toString());
				order.setTotalPrice(os[i][5].toString());
				order.setPubTime(os[i][6].toString().substring(0, 16));

				orders.add(order);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOrderByDate出错;" + "uid:" + uid + ",month:" + month
							+ ",day:" + day);
		}
		return orders;
	}

	public List<WdOrder> getOrderInWd(WdUser user, String orderNum) {
		List<WdOrder> orders = new ArrayList<WdOrder>();

		try {
			String url = "http://v.vdian.com/wd/order/getDetail";
			String params = "param={%22userID%22:%22" + user.getWduserid()
					+ "%22,%22wduss%22:%22" + user.getWduss()
					+ "%22,%22orderID%22:%22" + orderNum
					+ "%22}&callback=jsonpcallback&ver=111";
			String s = httpRequest(url + "?" + params);
			s = s.substring(14, s.length() - 2);
			// System.out.println(com.wxschool.util.FormatTransform.unicodeToString(s));
			JSONObject root = JSONObject.parseObject(s);
			JSONObject status = root.getJSONObject("status");
			String status_code = status.getString("status_code");

			if (status_code.equals("0")) {
				try {
					JSONObject result = root.getJSONObject("result");

					JSONObject buyerInfo = result.getJSONObject("buyerInfo");
					String name = buyerInfo.getString("name");// 消费者姓名
					String tel = buyerInfo.getString("telephone");// 消费者手机号

					String time = result.getString("time");// 下单时间
					String statusDesc = result.getString("status_desc");// 订单状态

					if (statusDesc.equals("已完成") || statusDesc.equals("待发货")) {
						statusDesc = "已付款";
					}

					JSONArray items = result.getJSONArray("items");
					for (int i = 0, len = items.size(); i < len; i++) {
						JSONObject item = items.getJSONObject(i);
						String itemId = item.getString("item_id");// 商品Id
						String unitPrice = item.getString("price");// 单价
						String totalPrice = item.getString("total_price");// 消费总价
						String quantity = item.getString("quantity");// 数量
						String itemName = item.getString("item_name");// 商品名称

						WdOrder order = new WdOrder();
						order.setAmount(quantity);
						order.setBuyer(name + "/" + tel + "/" + time);
						order.setItemId(itemId);
						order.setItemName(itemName);
						order.setOrderNum(orderNum);
						order.setStatusDesc(statusDesc);
						order.setTotalPrice(totalPrice);
						order.setUid(user.getUid());
						order.setUnitPrice(unitPrice);
						order.setStatusDesc(statusDesc);

						orders.add(order);
					}
				} catch (ClassCastException e) {
				}
			}
		} catch (Exception e) {
			//e.printStackTrace();
			LogDao.getLog().addExpLog(
					e,
					"getOrderInWd出错；wduserid:" + user.getWduserid() + ",wduss:"
							+ user.getWduss() + ",orderNum:" + orderNum);
			return null;
		}
		return orders;
	}

	public int addOrder(WdOrder order) {
		String sql = "INSERT INTO `tb_wdorder`(`uid`, `itemId`, `orderNum`, `buyer`, `itemName`, `amount`, `unitPrice`, `totalPrice`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] o = { order.getUid(), order.getItemId(), order.getOrderNum(),
				order.getBuyer(), order.getItemName(), order.getAmount(),
				order.getUnitPrice(), order.getTotalPrice() };
		try {
			return connDB.update(sql, o);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addWdorder出错；uid:" + order.getUid() + ",orderNum:"
							+ order.getOrderNum() + ",itemId:"
							+ order.getItemId() + ",buyer:" + order.getBuyer()
							+ ",itemName:" + order.getItemName() + ",amount:"
							+ order.getAmount() + ",unitPrice:"
							+ order.getUnitPrice() + ",totalPrice:"
							+ order.getTotalPrice());
			return -1;
		}
	}

	public Object[][] getSumByDate(String uid, String month, String day) {
		String sql;
		if (month.equals("0")) {
			sql = "SELECT `itemName`, SUM(`amount`), SUM(`totalPrice`) FROM `tb_wdorder` where uid = ? and `status` = 1 group by `itemId` ";
		} else if (day.equals("0")) {
			sql = "SELECT `itemName`, SUM(`amount`), SUM(`totalPrice`) FROM `tb_wdorder` where uid = ? "
					+ "and `status` = 1 and month(`pubTime`) = '"
					+ month
					+ "' group by `itemId` ";
		} else {
			String date = Calendar.getInstance().get(Calendar.YEAR) + "-"
					+ month + "-" + day;
			sql = "SELECT `itemName`, SUM(`amount`), SUM(`totalPrice`) FROM `tb_wdorder` where uid = ? "
					+ "and `status` = 1 and date(`pubTime`) = '"
					+ date
					+ "' group by `itemId` ";
		}
		Object[] o = { uid };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			return os;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getSumByDate出错；uid:" + uid + ",month:" + month + ",day:"
							+ day);
			return null;
		}
	}

	public int getTotalRecordByDate(String uid, String month, String day) {
		String sql = "";
		if (month.equals("0")) {
			sql = "select count(*) from tb_wdorder where uid = ? and `status` = 1 ";
		} else if (day.equals("0")) {
			sql = "select count(*) from tb_wdorder where uid = ? and `status` = 1 and month(`pubTime`) = '"
					+ month + "'";
		} else {
			String date = Calendar.getInstance().get(Calendar.YEAR) + "-"
					+ month + "-" + day;
			sql = "select count(*) from tb_wdorder where uid = ? and `status` = 1 and date(`pubTime`) = '"
					+ date + "'";
		}
		Object[] o = { uid };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getTotalRecordByMonth出错;uid:" + uid + ",month:" + month
							+ ",day:" + day);
			return 0;
		}
	}

	private static String httpRequest(String url) throws IOException {
		StringBuffer temp = new StringBuffer();
		URL u = new URL(url);
		InputStream is = u.openStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(is,
				"utf-8"));
		String line = null;
		while ((line = reader.readLine()) != null) {
			temp.append(line + "\n");
		}
		reader.close();
		is.close();
		return temp.toString();
	}

	public static void main(String[] args) {
		WdUser user = new WdUser();
		user.setWduserid("160771832");
		user.setWduss("NX4sjHdErPz02Fh8SKh7HDbmpEDSdSTT12L2Fsa2SlLBs3D");
		new WdOrderDao().getOrderInWd(user, "6683304");
		// new WdOrderDao().getOrderInWd(user, "6640791");
		// new WdOrderDao().getOrderInWd(user, "6201680");
		// new WdOrderDao().getOrderInWd(user, "6291177");
	}
}
