package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.OperateRecord;
import com.wxschool.entity.Page;

public class OperateRecordDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public int addRecord(OperateRecord record) {
		String sql = "INSERT INTO `tb_operaterecord`(`type`, `content`, `userwx`, `wxaccount`) VALUES (?, ?, ?, ?)";
		Object[] o = { record.getType(), record.getContent(),
				record.getUserwx(), record.getWxaccount() };
		try {
			int result = connDB.update(sql, o);
			return result;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "");
			return -1;
		}
	}

	public Object[][] getAccountData() {
		//String sql = "SELECT a.`wxaccount`, a.`wxName`, b.dataCount FROM (SELECT `wxName`, `wxAccount` FROM `tb_account` WHERE `status` > 0 ) a right join (SELECT `wxaccount`, count(*) as dataCount FROM `tb_operaterecord` where status > 0 group by `wxaccount`) b on a.wxaccount = b.wxaccount ";
		String sql = "SELECT `wxName`, `wxAccount` FROM `tb_account` WHERE `status` > 0 ";
		try {
			Result result = connDB.query(sql, null);
			Object[][] os = result.getRowsByIndex();
			return os;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getAccountData出错;");
			return null;
		}
	}

	public List<OperateRecord> getOperateRecords(String wxaccount, Page page) {
		String sql = "SELECT a.*, w.headImgUrl, w.nickname FROM (SELECT `type`, `content`, `operateTime`, `userwx` FROM `tb_operaterecord` WHERE `wxaccount` = ? order by `recordId` desc limit ?, ?) a left join tb_wxuser w on a.userwx = w.userwx and w.status = 1 ";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<OperateRecord> operateRecords = new ArrayList<OperateRecord>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				OperateRecord operateRecord = new OperateRecord();
				operateRecord.setType(os[i][0].toString());
				operateRecord.setContent(os[i][1].toString());
				operateRecord.setOperateTime(os[i][2].toString().substring(0,
						16));
				operateRecord.setUserwx(os[i][3].toString());
				operateRecord.setHeadImgUrl(os[i][4] == null ? "" : os[i][4]
						.toString());
				operateRecord.setNickname(os[i][5] == null ? "" : os[i][5]
						.toString());

				operateRecords.add(operateRecord);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getOperateRecords出错;wxaccount:" + wxaccount);
		}
		return operateRecords;
	}

	public List<OperateRecord> getOperateRecords_user(String wxaccount,
			String userwx, Page page) {
		String sql = "SELECT `type`, `content`, `operateTime` FROM `tb_operaterecord` WHERE `wxaccount` = ? and userwx = ? order by `recordId` desc limit ?, ? ";
		Object[] o = { wxaccount, userwx,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };
		List<OperateRecord> operateRecords = new ArrayList<OperateRecord>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0; i < os.length; i++) {
				OperateRecord operateRecord = new OperateRecord();
				operateRecord.setType(os[i][0].toString());
				operateRecord.setContent(os[i][1].toString());
				operateRecord.setOperateTime(os[i][2].toString().substring(0,
						16));

				operateRecords.add(operateRecord);
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getOperateRecords_user出错;wxaccount:" + wxaccount
							+ ",userwx:" + userwx);
		}
		return operateRecords;
	}

	public int getTotalRecord(String wxaccount) {
		String sql = "select count(*) from `tb_operaterecord` where wxaccount = ? ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"从tb_operaterecord中得到总记录数出错;wxaccount:" + wxaccount);
			return 0;
		}
	}

	public int getTotalRecord_user(String wxaccount, String userwx) {
		String sql = "select count(*) from `tb_operaterecord` where wxaccount = ? and userwx = ? ";
		Object[] o = { wxaccount, userwx };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"从tb_operaterecord中得到总记录数出错;wxaccount:" + wxaccount
							+ ",userwx:" + userwx);
			return 0;
		}
	}
}
