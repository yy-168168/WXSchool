package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Module;

public class ModuleDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public List<Module> getModules(String wxid) {
		// String sql = "SELECT `name`, `picUrl`, `locUrl`, `moduleId`, `parentId`, `sort` FROM `tb_module` WHERE `parentId` IN (SELECT m.`moduleId` FROM `tb_module` m INNER JOIN `tb_permission` p ON p.`moduleId` = m.`moduleId` INNER JOIN `tb_admin` a ON a.`adminId` = p.`adminId` WHERE m.`status` =1 AND a.`userwx` = ? AND p.`isPermit` =1) ORDER BY sort ASC ";
		String sql = "SELECT m.`name`, m.`picUrl`, m.`locUrl`, m.`moduleId`, m.`parentId`, m.`sort`, p.edit FROM (select * from tb_admin where userwx = ? and status > -1) a inner join tb_permission p on a.adminId = p.adminId inner join tb_module m on m.parentId = p.moduleId where m.status = 1 and p.isPermit = 1 order by sort asc ";
		Object[] o = { wxid };
		List<Module> modules = new ArrayList<Module>();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Module module = new Module();
				module.setName(os[i][0].toString());
				module.setPicUrl(os[i][1].toString());
				module.setLocUrl(os[i][2].toString());
				module.setModuleId(Integer.parseInt(os[i][3].toString()));
				module.setParentId(Integer.parseInt(os[i][4].toString()));
				module.setSort(os[i][5].toString());
				module.setEdit(os[i][6].toString());

				modules.add(module);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getModules出错；wxid:" + wxid);
		}
		return modules;
	}

}
