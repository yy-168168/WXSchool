package com.wxschool.dao;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.jstl.sql.Result;

import com.wxschool.entity.Config;
import com.wxschool.entity.Page;
import com.wxschool.entity.Student;
import com.wxschool.entity.WxUser;
import com.wxschool.util.CommonUtil;

public class StudentDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public Student getStuByStuNum(String wxaccount, String stuNum) {
		String sql = "SELECT `personId`, `password`, `userwx` FROM `tb_stu` WHERE `wxaccount` = ? and `stuNum` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, stuNum };
		try {

			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Student stu = new Student();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setPersonId(os[i][0] == null ? "" : os[i][0].toString());
				stu.setPassword(os[i][1] == null ? "" : os[i][1].toString());
				stu.setUserwx(os[i][2] == null ? "" : os[i][2].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuByStuNum出错；wxaccount:" + wxaccount + ",stuNum:"
							+ stuNum);
			return null;
		}
	}

	public Student getStuForCourse(String wxaccount, String userwx) {
		String sql = "SELECT `grade`, `depart`, `major` FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, userwx };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Student stu = new Student();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setGrade(os[i][0] == null ? "" : os[i][0].toString()
						.substring(0, 4));
				stu.setDepart(os[i][1] == null ? "" : os[i][1].toString());
				stu.setMajor(os[i][2] == null ? "" : os[i][2].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuByCourse出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public boolean updateStuByCourse(Student stu) {
		String sql = "UPDATE `tb_stu` SET `grade` = ?, `depart`= ?, `major`= ? WHERE `wxaccount`= ? and `userwx`= ? ";
		Object[] o = { stu.getGrade(), stu.getDepart(), stu.getMajor(),
				stu.getWxaccount(), stu.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateStuByCourse出错；grade:" + stu.getGrade() + ",depart:"
							+ stu.getDepart() + ",major:" + stu.getMajor()
							+ ",userwx:" + stu.getUserwx() + ",wxaccount:"
							+ stu.getWxaccount());
			return false;
		}
	}

	public Student getStuForScore(String wxaccount, String userwx) {
		String sql = "SELECT `personId`, `password` FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, userwx };
		try {

			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Student stu = new Student();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setPersonId(os[i][0] == null ? "" : os[i][0].toString());
				stu.setPassword(os[i][1] == null ? "" : os[i][1].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuByScore出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public boolean updateStuByScore(Student stu) {
		String sql = "UPDATE `tb_stu` SET `stuNum`= ?, `personId`= ?, `password`= ?, `stuName`= ?, `grade`= ?, `depart`= ?, `major`= ?, `IDCard`= ?, `trueSex`= ?, `gkScore`= ?, `origionProvince`= ? WHERE `wxaccount`= ? and `userwx`= ? ";
		Object[] o = { stu.getStuNum(), stu.getPersonId(), stu.getPassword(),
				stu.getStuName(), stu.getGrade(), stu.getDepart(),
				stu.getMajor(), stu.getIDCard(), stu.getTrueSex(),
				stu.getGkScore(), stu.getOriginProvince(), stu.getWxaccount(),
				stu.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateStuByScore出错； personId:" + stu.getPersonId()
							+ ",password:" + stu.getPassword() + "stuNum:"
							+ stu.getStuNum() + ",stuName:" + stu.getStuName()
							+ ",grade:" + stu.getGrade() + ",depart:"
							+ stu.getDepart() + ",major:" + stu.getMajor()
							+ ", userwx:" + stu.getUserwx() + ",wxaccount:"
							+ stu.getWxaccount() + ",gkScore:"
							+ stu.getGkScore());
			return false;
		}
	}

	public Student getStuForCet(String wxaccount, String userwx) {
		String sql = "SELECT `cetName`, `cetNum` FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, userwx };
		Student stu = new Student();
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setCetName(os[i][0] == null ? "" : os[i][0].toString());
				stu.setCetNum(os[i][1] == null ? "" : os[i][1].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuByCet出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public boolean updateStuByCet(Student stu) {
		String sql = "UPDATE `tb_stu` SET `cetNum`= ? , `cetName`= ?  WHERE `wxaccount`= ? and `userwx`= ? ";
		Object[] o = { stu.getCetNum(), stu.getCetName(), stu.getWxaccount(),
				stu.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateStuByCet出错；cetName:" + stu.getCetName() + ",cetNum:"
							+ stu.getCetNum() + ",userwx:" + stu.getUserwx()
							+ ",wxaccount:" + stu.getWxaccount());
			return false;
		}
	}

	public Student getStuForFellow(String wxaccount, String userwx) {
		String sql = "SELECT `province` FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, userwx };
		try {

			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Student stu = new Student();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setProvince(os[i][0] == null ? "" : os[i][0].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuByFellow出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public Student getStuForSelCourse(String wxaccount, String userwx) {
		String sql = "SELECT `selCourse` FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, userwx };
		try {

			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Student stu = new Student();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setSelCourse(os[i][0] == null ? "" : os[i][0].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuOfSelCourse出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
			return null;
		}
	}

	public boolean updateStuBySelCourse(String wxaccount, String userwx,
			String selCourse) {
		String sql = "UPDATE `tb_stu` SET `selCourse`= ? WHERE `wxaccount`= ? and `userwx`= ? ";
		Object[] o = { selCourse, wxaccount, userwx };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateStuBySelCourse出错；selCourse:" + selCourse
							+ ",userwx:" + userwx + ",wxaccount:" + wxaccount);
			return false;
		}
	}

	public Student getStuAll(String wxaccount, String userwx) {
		String sql = "SELECT `stuId`, `grade`, `personId`, `password`, `depart`, `major`, `province`, `city`, `county`, `find`, `sex`, `stuName`, `stuNum` FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and `status` = 1 order by stuId desc limit 1 ";
		Object[] o = { wxaccount, userwx };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Student stu = new Student();

			for (int i = 0, len = os.length; i < len; i++) {
				stu.setStuId(Integer.parseInt(os[i][0].toString()));
				stu.setGrade((os[i][1] == null) ? "" : os[i][1].toString());
				stu.setPersonId((os[i][2] == null) ? "" : os[i][2].toString());
				stu.setPassword((os[i][3] == null) ? "" : os[i][3].toString());
				stu.setDepart((os[i][4] == null) ? "" : os[i][4].toString());
				stu.setMajor((os[i][5] == null) ? "" : os[i][5].toString());
				stu.setProvince((os[i][6] == null) ? "" : os[i][6].toString());
				stu.setCity((os[i][7] == null) ? "" : os[i][7].toString());
				stu.setCounty((os[i][8] == null) ? "" : os[i][8].toString());
				stu.setFind((os[i][9] == null) ? "" : os[i][9].toString());
				stu.setSex(Integer.parseInt(os[i][10].toString()));
				stu.setStuName((os[i][11] == null) ? "" : os[i][11].toString());
				stu.setStuNum((os[i][12] == null) ? "" : os[i][12].toString());
			}
			return stu;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e,
					"getStuAll出错;wxaccount:" + wxaccount + ",userwx:" + userwx);
			return null;
		}
	}

	public boolean addStuOfDefault(String wxaccount, String userwx) {
		String sql = "INSERT INTO `tb_stu`(`wxaccount`, `userwx`) SELECT '"
				+ wxaccount
				+ "', '"
				+ userwx
				+ "' FROM DUAL WHERE NOT EXISTS(SELECT * FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and status = 1)";
		Object[] o = { wxaccount, userwx };
		try {
			connDB.update(sql, o);
			return true;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"StuDao-addStuOfDefault出错;wxaccount=" + wxaccount
							+ ",userwx=" + userwx);
			return false;
		}
	}

	public boolean addStuByScore(Student stu) {
		String sql = "INSERT INTO `tb_stu`(`wxaccount`, `userwx`, `personId`, `password`) SELECT '"
				+ stu.getWxaccount()
				+ "', '"
				+ stu.getUserwx()
				+ "', '"
				+ stu.getPersonId()
				+ "', '"
				+ stu.getPassword()
				+ "' FROM DUAL WHERE NOT EXISTS(SELECT * FROM `tb_stu` WHERE `wxaccount` = ? and `userwx` = ? and status = 1)";
		Object[] o = { stu.getWxaccount(), stu.getUserwx() };
		try {
			connDB.update(sql, o);
			return true;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"addStuByScore出错;wxaccount:" + stu.getWxaccount()
							+ ",userwx:" + stu.getUserwx() + ",personId:"
							+ stu.getPersonId() + ",password:"
							+ stu.getPassword());
			return false;
		}

	}

	public boolean updateStuAll(Student stu) {
		String sql = "UPDATE `tb_stu` SET stuName = ?, `grade`= ? ,`depart`= ? , `major`= ? , `province`= ? , `city`= ? , `county`= ? , `find`= ? ,`sex`= ?, `stuNum`= ? WHERE `wxaccount`= ? and `userwx`= ? and `status`= 1";
		Object[] o = { stu.getStuName(), stu.getGrade(), stu.getDepart(),
				stu.getMajor(), stu.getProvince(), stu.getCity(),
				stu.getCounty(), stu.getFind(), stu.getSex(), stu.getStuNum(),
				stu.getWxaccount(), stu.getUserwx() };
		try {
			return connDB.update(sql, o) == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"updateStuAll出错；name:" + stu.getStuName() + ";grade:"
							+ stu.getGrade() + ",depart:" + stu.getDepart()
							+ ",major:" + stu.getMajor() + "provice:"
							+ stu.getProvince() + ",city:" + stu.getCity()
							+ ",county:" + stu.getCounty() + ",find:"
							+ stu.getFind() + ",sex:" + stu.getSex()
							+ ",stuNum:" + stu.getStuNum() + ",userwx:"
							+ stu.getUserwx() + ",wxaccount:"
							+ stu.getWxaccount());
			return false;
		}
	}

	// 按条件获取已注册用户列表
	public List<Student> getRegStus_condition(String wxaccount,
			Student condition, Page page) {
		String sql = "select s.`grade`, s.`depart`, s.`major`, s.`province`, s.`city`, s.`county`, s.`find`, s.`sex`, u.userId, u.nickname, u.headImgUrl, u.lastUsedTime from "
				+ "(SELECT * FROM `tb_stu` WHERE `wxaccount` = ? and `status` = 1";
		if (!condition.getGrade().equals("")) {
			sql += " and grade = " + condition.getGrade();
		}
		if (condition.getSex() != 0) {
			sql += " and sex = " + condition.getSex();
		}
		if (condition.getDepart().equals("")) {
			sql += " and depart is not null";
		} else {
			sql += " and depart = " + condition.getDepart();
		}
		if (!condition.getMajor().equals("")) {
			sql += " and major = " + condition.getMajor();
		}
		if (!condition.getProvince().equals("")) {
			sql += " and province = " + condition.getProvince();
		}
		if (!condition.getCity().equals("")) {
			sql += " and city = " + condition.getCity();
		}
		sql += " order by stuId desc limit ?, ?) s inner join (select * from tb_wxuser where wxaccount = ? and status = 1) u on s.userwx = u.userwx";
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage(), wxaccount };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<Student> stus = new ArrayList<Student>();

			for (int i = 0, len = os.length; i < len; i++) {
				Student s = new Student();
				s.setGrade(os[i][0] == null ? "" : os[i][0].toString());
				s.setDepart(os[i][1] == null ? "" : os[i][1].toString());
				s.setMajor(os[i][2] == null ? "" : os[i][2].toString());
				s.setProvince(os[i][3] == null ? "" : os[i][3].toString());
				s.setCity(os[i][4] == null ? "" : os[i][4].toString());
				s.setCounty(os[i][5] == null ? "" : os[i][5].toString());
				s.setFind(os[i][6] == null ? "" : os[i][6].toString());
				s.setSex(Integer.parseInt(os[i][7].toString()));

				WxUser wxUser = new WxUser();
				wxUser.setUserId(Integer.parseInt(os[i][8].toString()));
				wxUser.setNickname(os[i][9] == null ? "" : os[i][9].toString());
				wxUser.setHeadImgUrl(os[i][10] == null ? "" : os[i][10]
						.toString());
				long diff_s = CommonUtil.getDiffSecondOfNow(os[i][11]
						.toString());
				if (diff_s / (60 * 60) <= Config.WECHATCUSTOMMSGVALIDTIME) {
					wxUser.setOnline(true);
				}
				s.setWxUser(wxUser);

				stus.add(s);
			}
			return stus;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"按条件获取已注册用户列表出错;wxaccount:" + wxaccount + ",grade:"
							+ condition.getGrade() + ".sex:"
							+ condition.getSelCourse() + ",depart:"
							+ condition.getDepart() + ",major:"
							+ condition.getMajor() + ",province:"
							+ condition.getProvince() + ",city:"
							+ condition.getCity());
			return null;
		}
	}

	// 已经注册的总人数
	public int getTotalRecord_register(String wxaccount, Student condition) {
		String sql = "select count(*) from `tb_stu` where wxaccount = ?  and `status` = 1 ";
		if (!condition.getGrade().equals("")) {
			sql += " and grade = " + condition.getGrade();
		}
		if (condition.getSex() != 0) {
			sql += " and sex = " + condition.getSex();
		}
		if (condition.getDepart().equals("")) {
			sql += " and depart is not null";
		} else {
			sql += " and depart = " + condition.getDepart();
		}
		if (!condition.getMajor().equals("")) {
			sql += " and major = " + condition.getMajor();
		}
		if (!condition.getProvince().equals("")) {
			sql += " and province = " + condition.getProvince();
		}
		if (!condition.getCity().equals("")) {
			sql += " and city = " + condition.getCity();
		}
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);
			return Integer.parseInt(result.getRowsByIndex()[0][0].toString());
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "获取注册总人数出错;wxaccount:" + wxaccount);
			return 0;
		}
	}

	// 是否注册
	public boolean isReg(String wxaccount, String userwx) {
		String sql = "select * from `tb_stu` where wxaccount = ?  and `status` = 1 and grade is not null and grade <> '' and depart is not null and depart <> '' and province is not null and province <> '' ";
		Object[] o = { wxaccount };
		try {
			Result result = connDB.query(sql, o);

			return result.getRowCount() > 0;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "判断是否注册出错;wxaccount:" + wxaccount);
			return false;
		}
	}
	
	//老乡
	public List<Student> getStusForFellow(String wxaccount, String province,
			String city, Page page) {
		String sql = "";
		if (province == null || province.equals("null")) {
			sql = "SELECT `grade`, `major`, `city`, `county`, `find`, `sex`, `stuName`, `depart` FROM `tb_stu` WHERE `wxaccount` = ? and `province` is not null and `province` <> '' and `status` = 1 order by rand() limit ?, ? ";
		} else if (city == null || city.equals("null")) {
			sql = "SELECT `grade`, `major`, `city`, `county`, `find`, `sex`, `stuName`, `depart` FROM `tb_stu` WHERE `wxaccount` = ? and `province` = '"
					+ province
					+ "' and `status` = 1 order by `stuId` desc limit ?, ? ";
		} else {
			sql = "SELECT `grade`, `major`, `city`, `county`, `find`, `sex`, `stuName`, `depart` FROM `tb_stu` WHERE `wxaccount` = ? and `city` = '"
					+ city
					+ "' and `status` = 1 order by `stuId` desc limit ?, ? ";
		}
		Object[] o = { wxaccount,
				(page.getCurPage() - 1) * page.getEveryPage(),
				page.getEveryPage() };

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			List<Student> fellows = new ArrayList<Student>();

			for (int i = 0, len = os.length; i < len; i++) {
				Student s = new Student();

				if (os[i][0] == null || os[i][0].equals("")) {
					s.setGrade("未知年");
				} else {
					s.setGrade(os[i][0].toString().substring(0, 4));
				}

				s.setMajor(os[i][1] == null ? "" : os[i][1].toString());
				s.setCity(os[i][2] == null ? "" : os[i][2].toString());
				s.setCounty(os[i][3] == null ? "" : os[i][3].toString());
				s.setFind(os[i][4].toString());
				s.setSex(Integer.parseInt(os[i][5].toString()));

				if (os[i][6] == null || os[i][6].equals("")) {
					s.setStuName("未知");
				} else {
					s.setStuName(os[i][6].toString());
				}

				s.setDepart(os[i][7] == null ? "" : os[i][7].toString());

				fellows.add(s);
			}
			return fellows;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getStuByFellow出错;wxaccount:" + wxaccount + ",province:"
							+ province + ",city:" + city);
			return null;
		}
	}
}
