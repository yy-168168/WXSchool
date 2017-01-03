package com.wxschool.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Log;
import com.wxschool.entity.Page;

public class LogDao {

	private static LogDao log;

	private LogDao() {
	}

	public static LogDao getLog() {
		if (log == null) {
			log = new LogDao();
		}
		return log;
	}

	public List<Log> getLogsByPage(Page page) {
		String sql = "SELECT `logId`, `content`, `logtime` FROM `tb_log` WHERE 1 order by logtime desc limit ? ,? ";
		Object[] o = { (page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		ConnDBI connDB = DBManager.getConnDb();
		List<Log> logs = new ArrayList<Log>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				Log log = new Log();
				log.setLogId(Integer.parseInt(os[i][0].toString()));
				log.setContent(os[i][1].toString());
				log.setLogTime(os[i][2].toString().substring(0, 16));

				logs.add(log);
			}
		} catch (Exception e) {
			getLog().addExpLog(e, "getLogsByPage出错");
		} finally {
			connDB = null;
		}
		return logs;
	}

	public void addExpLog(Exception e, String data) {
		String sql = "INSERT INTO `tb_log`(`content`) VALUES ( ? ) ";
		Object[] o = { "数据源:" + data + getExceptionMsg(e) };
		ConnDBI connDB = DBManager.getConnDb();

		try {
			connDB.update(sql, o);
		} catch (Exception e1) {
			try {
				addExpLog(e, "添加日志出错");
			} catch (Exception e2) {
				System.out.println(getExceptionMsg(e1));
			}
		} finally {
			connDB = null;
		}
	}

	public void addNorLog(String data) {
		String sql = "INSERT INTO `tb_log`(`content`) VALUES ( ? ) ";
		Object[] o = { "数据源:" + data };
		ConnDBI connDB = DBManager.getConnDb();

		try {
			connDB.update(sql, o);
		} catch (Exception e) {
			try {
				addExpLog(e, "添加日志出错");
			} catch (Exception e1) {
				System.out.println(getExceptionMsg(e));
			}
		} finally {
			connDB = null;
		}
	}

	public boolean delete(String logId) {
		String sql = "DELETE FROM `tb_log` WHERE `logId` = ? ";
		Object[] o = { logId };
		ConnDBI connDB = DBManager.getConnDb();

		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			getLog().addExpLog(e, "delete出错;logId:" + logId);
			return false;
		} finally {
			connDB = null;
		}
	}

	public boolean deleteByKeyword(String keyword) {
		String sql = "DELETE FROM `tb_log` WHERE `content` like ? ";
		Object[] o = { "%" + keyword + "%" };
		ConnDBI connDB = DBManager.getConnDb();

		try {
			int r = connDB.update(sql, o);
			return r > 0;
		} catch (Exception e) {
			getLog().addExpLog(e, "deleteByKeyword出错;keyword:" + keyword);
			return false;
		} finally {
			connDB = null;
		}
	}

	public int getTotalRecord() {
		String sql = "select count(*) from tb_log";
		ConnDBI connDB = DBManager.getConnDb();

		try {
			Result result = connDB.query(sql, null);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			getLog().addExpLog(e, "getTotalRecord出错");
			return 0;
		} finally {
			connDB = null;
		}
	}

	private String getExceptionMsg(Exception e) {
		StringBuffer sb = new StringBuffer();
		try {
			sb.append(";\n异常时间:" + new Date());
			sb.append(";\n异常类型:" + e.getClass().getName() + ":");
			sb.append(e.getMessage() + ";\n");

			StackTraceElement[] stes = e.getStackTrace();
			for (int i = 0, len = stes.length; i < 3 && i < len; i++) {
				sb.append("异常位置:" + stes[i].getClassName());
				sb.append(":" + stes[i].getMethodName());
				sb.append(":" + stes[i].getLineNumber() + "\n");
			}
		} catch (Exception e2) {
			System.out.println("getExceptionMsg error!");
		}
		return sb.toString();
	}
}
