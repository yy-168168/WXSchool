package com.wxschool.dao;

import com.wxschool.entity.Config;

public class DBManager {

	public static ConnDBI getConnDb() {
		setDBAccount();

		ConnDBI connDB = null;
		switch (Config.DBCONNECTIONTYPE) {
		case 1:
			connDB = new ConnDB_JDBC1();
			break;
		case 3:
			connDB = new ConnDB_C3P0();
			break;
		}
		return connDB;
	}

	private static void setDBAccount() {
		switch (Config.PLATFORMACCOUNT) {
		case 1:// 百度云3.0账户
			if (Config.DBCONNECTION == null) {
				Config.DRIVER = "com.mysql.jdbc.Driver";
				Config.DBUSERNAME = "dDDmQGwr5NDPNw3heC2N8GqK";
				Config.DBPASSWORD = "bRchlG2fjVD1eqFbrmwxf03IIXHRx8wD";
				//Config.DBCONNECTION = "jdbc:mysql://sqld.duapp.com:4050/WOkeummxRlKQwoTiYtCS?autoReconnect=true&failOverReadOnly=false";
				Config.DBCONNECTION = "jdbc:mysql://sqld.duapp.com:4050/WOkeummxRlKQwoTiYtCS";
			}
			break;
		case 2:// 阿里云账户
			if (Config.DBCONNECTION == null) {
				Config.DRIVER = "com.mysql.jdbc.Driver";
				Config.DBUSERNAME = "r1ba514d815a7lz7";
				Config.DBPASSWORD = "123456";
				Config.DBCONNECTION = "jdbc:mysql://rds9or9kl86r82fb2hky.mysql.rds.aliyuncs.com:3306/r1ba514d815a7lz7?autoReconnect=true&failOverReadOnly=false";
			}
			break;
		}
	}
}
