package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.WxMenu;

public class WxMenuDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<WxMenu> getMenus(String wxaccount) {
		String sql = "SELECT `menuId`, `parentId`, `name`, `type`, `content` FROM `tb_wxmenu` WHERE `wxaccount` = ? and `status` = 1 order by parentId asc, rank asc, menuId asc ";
		Object[] o = { wxaccount };
		List<WxMenu> wxMenus = new ArrayList<WxMenu>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				WxMenu wxMenu = new WxMenu();
				wxMenu.setMenuId(Integer.parseInt(os[i][0].toString()));
				wxMenu.setParentId(Integer.parseInt(os[i][1].toString()));
				wxMenu.setName(os[i][2].toString());
				wxMenu.setType(os[i][3] == null ? "" : os[i][3].toString());
				wxMenu.setContent(os[i][4] == null ? "" : os[i][4].toString());

				wxMenus.add(wxMenu);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getMenus出错；wxaccount:" + wxaccount);
		}
		return wxMenus;
	}

	public List<WxMenu> getMenus(String wxaccount, String menuId) {
		String sql = "SELECT `menuId`, `name`, `rank` FROM `tb_wxmenu` WHERE `wxaccount` = ? and `parentId` = ? and `status` = 1 order by parentId asc, rank asc, menuId asc ";
		Object[] o = { wxaccount, menuId };
		List<WxMenu> wxMenus = new ArrayList<WxMenu>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				WxMenu wxMenu = new WxMenu();
				wxMenu.setMenuId(Integer.parseInt(os[i][0].toString()));
				wxMenu.setName(os[i][1].toString());
				wxMenu.setRank(Integer.parseInt(os[i][2].toString()));

				wxMenus.add(wxMenu);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getMenus出错；wxaccount:" + wxaccount + ",menuId:" + menuId);
		}
		return wxMenus;
	}

	public WxMenu getMenuInfo(String menuId) {
		String sql = "SELECT `parentId`, `name`, `type`, `content` FROM `tb_wxmenu` WHERE `menuId`= ? ";
		Object[] o = { menuId };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			WxMenu wxMenu = new WxMenu();

			for (int i = 0, len = os.length; i < len; i++) {
				wxMenu.setParentId(Integer.parseInt(os[i][0].toString()));
				wxMenu.setName(os[i][1].toString());
				wxMenu.setType(os[i][2] == null ? "" : os[i][2].toString());
				wxMenu.setContent(os[i][3] == null ? "" : os[i][3].toString());
				wxMenu.setMenuId(Integer.parseInt(menuId));
			}
			return wxMenu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getMenuInfo出错；menuId:" + menuId);
			return null;
		}
	}

	public boolean addMenuName(String wxaccount, String parentId,
			String menuName) {
		String sql = "INSERT INTO `tb_wxmenu`(`wxaccount`, `parentId`, `name`) VALUES (?, ?, ?)";
		Object[] o = { wxaccount, parentId, menuName };

		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addMenuName出错；wxaccount:" + wxaccount + ",parentId:"
							+ parentId + ",menuName:" + menuName);
			return false;
		}
	}

	public boolean updateMenuName(String menuId, String menuName) {
		String sql = "UPDATE `tb_wxmenu` SET `name`= ? WHERE `menuId`= ? ";
		Object[] o = { menuName, menuId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateMenuName出错；menuId:" + menuId + ",menuName:"
							+ menuName);
			return false;
		}
	}

	public boolean updateMenuInfo(String menuId, String type, String content) {
		String sql = "UPDATE `tb_wxmenu` SET `type`= ? ,`content`= ? WHERE `menuId`= ? ";
		Object[] o = { type, content, menuId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateMenuInfo出错；menuId:" + menuId + ",type:" + type
							+ ",content:" + content);
			return false;
		}
	}

	public boolean updateMenuRank(String[] menuIds, String[] ranks) {
		try {
			int size = menuIds.length;
			StringBuffer sql = new StringBuffer(
					"UPDATE `tb_wxmenu` SET rank = CASE menuId ");

			for (int i = 0; i < size; i++) {
				sql.append(" when " + menuIds[i] + " then " + ranks[i]);
			}

			sql.append(" END WHERE menuId IN ( ");

			for (int i = 0; i < size; i++) {
				sql.append(menuIds[i] + ",");
			}
			sql = sql.deleteCharAt(sql.length() - 1);
			sql.append(")");

			int r = connDB.update(sql.toString(), null);
			return r == size;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "updateMenuRank出错；");
			return false;
		}
	}

	public boolean deleteMenu(String menuId) {
		String sql = "UPDATE `tb_wxmenu` SET `status`= -1 WHERE `menuId`= ? ";
		Object[] o = { menuId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "deleteMenu出错；menuId:" + menuId);
			return false;
		}
	}
}
