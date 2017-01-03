package com.wxschool.dao;

import java.util.*;

import javax.servlet.jsp.jstl.sql.Result;
import com.wxschool.entity.*;

public class CourseDao {

	private ConnDBI connDB = DBManager.getConnDb();

	public String computeReceive(String wxaccount, String userwx) {
		String replyContent = "亲，出错了，请重试！";

		try {
			StudentDao studentDao = new StudentDao();
			Student stu = studentDao.getStuForCourse(wxaccount, userwx);
			studentDao = null;
			if (stu == null) {
				// 默认回复
			} else if (stu.getMajor() != null && !stu.getMajor().equals("")) {
				String grade = stu.getGrade();
				String depart = stu.getDepart();
				String major = stu.getMajor();

				String picId = getCoursePicId(wxaccount, grade, major);

				String coursePicUrl = Config.SITEURL
						+ "/mobile/pic?ac=getPic&wxaccount=" + wxaccount + "&picId="
						+ picId;// 课表图片的链接

				if (picId.equals("-1")) {
					// 默认回复
				} else if (picId.equals("0")) {
					replyContent = "亲，检测到您是"
							+ grade
							+ "级-"
							+ depart
							+ "-"
							+ major
							+ "专业，暂没有您所在专业的课表，请回复【反馈没有课表】，我们会及时处理.\n如果专业信息不对，回复【个人中心】更新信息.";
				} else {
					replyContent = "亲，检测到您是" + grade + "级-" + depart + "-"
							+ major + "专业，<a href = '" + coursePicUrl
							+ "'>点此查看课表</a>.\n如果专业信息不对，回复【个人中心】更新信息.";
				}
			} else {// 绑定信息
				replyContent = "亲，未检测到您的专业信息，所以无法找到课表，<a href='"
						+ Config.SITEURL + "/mobile/course?ac=course&wxaccount="
						+ wxaccount + "&userwx=" + userwx
						+ "'>点此填写信息</a>，输入成功后请再次回复";
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"computeReceive出错；wxaccount:" + wxaccount + ",userwx:"
							+ userwx);
		}
		return replyContent;
	}

	public String getCoursePicId(String wxaccount, String grade, String major) {
		String sql = "SELECT `picId` FROM `tb_pic` WHERE `wxaccount` = ? and `title` like ? and `status` = 1 ";
		Object[] o = { wxaccount, "%" + grade + "%" + major + "%" };
		String picId = "0";

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();

			for (int i = 0, len = os.length; i < len; i++) {
				picId = os[i][0].toString();
			}
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getCoursePicId出错；wxaccount:" + wxaccount + ",grade:"
							+ grade + ",major:" + major);
			picId = "-1";
		}
		return picId;
	}

	public List<CourseList> getCourseList(String wxaccount, String grade,
			String major) {
		String sql = "SELECT `courseId`, `day`, `courseName`, `teacher`, `address`, `isDifWeek`, `startLession`, `endLession`  FROM `tb_course` "
				+ "WHERE `major` = ? and `grade` = ? and `wxaccount` = ? order by `day` asc , `startLession` asc ";
		Object[] o = { major, grade, wxaccount };
		List<CourseList> courseList = new ArrayList<CourseList>();

		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			if (os == null || os.length == 0) {
				return courseList;
			}
			CourseList courses = null;

			int flag = 0;
			for (int i = 0, len = os.length; i < len; i++) {
				int day = Integer.parseInt(os[i][1].toString());
				if (day != flag) {
					flag = day;
					if (courses != null) {
						courseList.add(courses);
					}
					courses = new CourseList();
					courses.setDay(day);
				}
				Course c = new Course();
				c.setCourseId(Integer.parseInt(os[i][0].toString()));
				c.setDay(Integer.parseInt(os[i][1].toString()));
				c.setCoureName(os[i][2].toString());
				c.setTeacher(os[i][3].toString());
				c.setAddress(os[i][4].toString());
				c.setIsDifWeek(Integer.parseInt(os[i][5].toString()));
				c.setStartLession(Integer.parseInt(os[i][6].toString()));
				c.setEndLession(Integer.parseInt(os[i][7].toString()));
				courses.getCourses().add(c);
			}
			courseList.add(courses);
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"grade:" + grade + ",major:" + major + ",wxaccount:"
							+ wxaccount);
			return null;
		}
		return orderByDay(courseList);
	}

	private List<CourseList> orderByDay(List<CourseList> courseList) {
		if (courseList == null || courseList.size() == 0) {
			return courseList;
		}

		int nowDay = Calendar.getInstance().get(Calendar.DAY_OF_WEEK);
		nowDay = nowDay == 1 ? 8 : nowDay;
		nowDay -= 1;// 当前星期1-7

		int size = courseList.size();
		CourseList temp = courseList.get(size - 1);
		int day = temp.getDay();
		if (day < nowDay) {
			return courseList;
		}

		int i = 0;
		while (true) {
			temp = courseList.get(i);
			day = temp.getDay();
			if (day < nowDay) {
				courseList.remove(i);
				courseList.add(temp);
			} else {
				break;
			}
		}
		return courseList;
	}

	public Course getCourseById(String courseId) {
		String sql = "SELECT `day`, `courseName`, `teacher`, `address`, `startLession`, `endLession`, `startWeek`,"
				+ " `endWeek`, `isDifWeek` FROM `tb_course` WHERE `courseId` = ? ";
		Object[] o = { courseId };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			Course course = new Course();

			for (int i = 0, len = os.length; i < len; i++) {
				course.setCourseId(Integer.parseInt(courseId));
				course.setDay(Integer.parseInt(os[i][0].toString()));
				course.setCoureName(os[i][1].toString());
				course.setTeacher(os[i][2].toString());
				course.setAddress(os[i][3].toString());
				course.setStartLession(Integer.parseInt(os[i][4].toString()));
				course.setEndLession(Integer.parseInt(os[i][5].toString()));
				course.setStartWeek(Integer.parseInt(os[i][6].toString()));
				course.setEndWeek(Integer.parseInt(os[i][7].toString()));
				course.setIsDifWeek(Integer.parseInt(os[i][8].toString()));
			}
			return course;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "getCourse出错，courseId:" + courseId);
			return null;
		}
	}

	public boolean updateCourse(Course course) {
		String sql = "UPDATE `tb_course` SET `day`= ? ,`courseName`= ? ,`teacher`= ? ,`address`= ? ,`startLession`= ? ,"
				+ "`endLession`= ? ,`startWeek`= ? ,`endWeek`= ? ,`isDifWeek`= ? WHERE `courseId` = ? ";
		Object[] o = { course.getDay(), course.getCoureName(),
				course.getTeacher(), course.getAddress(),
				course.getStartLession(), course.getEndLession(),
				course.getStartWeek(), course.getEndWeek(),
				course.getIsDifWeek(), course.getCourseId() };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "updateCourse出错");
			return false;
		}
	}

	public boolean addCourse(Course course) {
		String sql = "INSERT INTO `tb_course`(`day`, `courseName`, `teacher`, `address`, `startLession`, "
				+ "`endLession`, `startWeek`, `endWeek`, `isDifWeek`, `major`, `grade`, `wxaccount`) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] o = { course.getDay(), course.getCoureName(),
				course.getTeacher(), course.getAddress(),
				course.getStartLession(), course.getEndLession(),
				course.getStartWeek(), course.getEndWeek(),
				course.getIsDifWeek(), course.getMajor(), course.getGrade(),
				course.getWxaccount() };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "addCourse出错");
			return false;
		}
	}

	public boolean deleteCourse(String courseId) {
		String sql = "DELETE FROM `tb_course` WHERE `courseId` = ? ";
		Object[] o = { courseId };
		try {
			int r = connDB.update(sql, o);
			return r == 1;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(e, "deleteCourse出错courseId:" + courseId);
			return false;
		}
	}

	public List<Course> getCoursesByDay(String wxaccount, String grade,
			String major, int day) {
		String sql = "SELECT `courseId`, `day`, `courseName`, `teacher`, `address`, `startLession`, `endLession`, `isDifWeek`"
				+ " FROM `tb_course` WHERE `wxaccount` = ? and `grade` = ? and `major` = ? and `day` = ? order by `startLession` asc ";
		Object[] o = { wxaccount, grade, major, day };
		try {
			Result result = connDB.query(sql, o);
			Object[][] os = result.getRowsByIndex();
			List<Course> courses = new ArrayList<Course>();

			for (int i = 0, len = os.length; i < len; i++) {
				Course c = new Course();
				c.setCourseId(Integer.parseInt(os[i][0].toString()));
				c.setDay(Integer.parseInt(os[i][1].toString()));
				c.setCoureName(os[i][2].toString());
				c.setTeacher(os[i][3].toString());
				c.setAddress(os[i][4].toString());
				c.setStartLession(Integer.parseInt(os[i][5].toString()));
				c.setEndLession(Integer.parseInt(os[i][6].toString()));
				c.setIsDifWeek(Integer.parseInt(os[i][7].toString()));
				courses.add(c);
			}
			return courses;
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"getCoursesByDay出错,wxaccount:" + wxaccount + ";grade:"
							+ grade + ",major:" + major + ",day:" + day);
			return null;
		}
	}

	public int isCourseExist(String wxaccount, String grade, String major) {
		String sql = "SELECT `courseId` FROM `tb_course` WHERE `wxaccount` = ? and `grade` = ? and `major` = ? ";
		Object[] o = { wxaccount, grade, major };
		try {
			Result result = connDB.query(sql, o);
			return result.getRowCount();
		} catch (Exception e) {
			LogDao.getLog().addExpLog(
					e,
					"isCourseExist出错,wxaccount:" + wxaccount + ";grade:"
							+ grade + ",major:" + major);
			return -1;
		}
	}
}
